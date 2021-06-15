/*env node*/
/*global require*/
var gulp = require('gulp');
var hb = require('gulp-hb');
var csso = require('gulp-csso');
var concat = require('gulp-concat');
var browserSync = require('browser-sync');
var uglify = require('gulp-uglify');
//var svgmin = require('gulp-svgmin');
var imagemin = require('gulp-imagemin');
var cache = require('gulp-cache');
var htmlmin = require('gulp-htmlmin');
var frontMatter = require('gulp-front-matter');
var plumber = require('gulp-plumber');
var notify = require('gulp-notify');
//var sourcemaps = require('gulp-sourcemaps');
var ghPages = require('gulp-gh-pages');
//var inlineImg = require('gulp-inline-image-html');

/*///////////////////////////////////////
Send a message in error
///////////////////////////////////////*/
function plumberit(errTitle) {
return plumber({
errorHandler: notify.onError({
    title: errTitle || "Error running Gulp",
    message: "Error: <%= error.message %>",
    })
});
}
/*///////////////////////////////////////
Browser Sync Implementation
///////////////////////////////////////*/
gulp.task('browser-sync', function() {
    browserSync.init({
        //tunnel: true,
        server: {
            baseDir: "./dist",
            port: 3000
        }
    });
});
/*///////////////////////////////////////
build and deploy
///////////////////////////////////////*/
gulp.task('build',   function () {
    return gulp
        .src('./src/views/pages/**/*.html')
        .pipe(plumberit('Build Error'))
        .pipe(frontMatter({property: 'data.front' }))
        .pipe(hb({
          partials: './src/views/partials/**/*.hbs',
          data: './src/views/data.json',
          helpers: {
            even:  function(conditional, options) {
                  if(((conditional+1) % 3) === 0) {
                    return options.fn(this);
                  } else {
                    return options.inverse(this);
                  }
                }
          },
          debug:0}))
        //.pipe(inlineImg('./src'))
        .pipe(htmlmin({collapseWhitespace: true,minifyCSS:true,minifyJS:true,removeComments:true}))
        .pipe(gulp.dest('./dist'))
        //.pipe(browserSync.reload({ stream: false }));
});
gulp.task('build-watch', gulp.series('build', browserSync.reload));
gulp.task('deploy', function() {
  return gulp.src('./dist/**/*')
    .pipe(ghPages({'branch':'master', 'remoteUrl':'http://github.com/gps-tracker/gps-tracker.github.io.git'}));
});

/*///////////////////////////////////////
JS watcher
///////////////////////////////////////*/
gulp.task('js',  function () {
  return gulp.src(['./src/libraries/*.js','./src/js/*.js'])
    //.pipe(sourcemaps.init())
        .pipe(plumberit("JS uglify errors"))
        .pipe(concat('min.js'))
        .pipe(uglify())
    //.pipe(sourcemaps.write())
    .pipe(gulp.dest('./dist/js'))
    .pipe(browserSync.reload({ stream: true }));
});
/*///////////////////////////////////////
CSS watcher
///////////////////////////////////////*/
gulp.task('css', function () {
  return gulp.src(['./src/css/materialize.css','./src/css/style.css'])
        //.pipe(sourcemaps.init())
            .pipe(plumberit('CSS parsing error'))
            .pipe(csso())
            .pipe(concat('min.css'))
        //.pipe(sourcemaps.write())
        .pipe(gulp.dest('./dist/css'))
        .pipe(browserSync.reload({ stream: true }));
});
gulp.task('css-root', function () {
  return gulp.src(['./src/root/css/**/*.css'])
        .pipe(plumberit('CSS parsing error'))
        .pipe(csso())
        .pipe(gulp.dest('./dist/css'))
        .pipe(browserSync.reload({ stream: true }));
});
/*///////////////////////////////////////
img minifier
///////////////////////////////////////*/
gulp.task('svg', function () {
    return gulp.src('./src/images/**/*.svg')
        .pipe(plumberit('Svg minification error'))
        .pipe(imagemin())
        .pipe(gulp.dest('./dist/images'))
        .pipe(browserSync.reload({ stream: true }));
});
gulp.task('img', function(){
	return gulp.src('./src/images/**/*.+(png|jpg|jpeg|gif)')
    .pipe(plumberit('Images minification error'))
	.pipe(cache(imagemin({interlaced: true})))// Caching images that ran through imagemin
	.pipe(gulp.dest('dist/images'))
    .pipe(browserSync.reload({ stream: true }));
});
/*///////////////////////////////////////
copy fonts
///////////////////////////////////////*/
gulp.task('font', function () {
    return gulp.src('./src/font/**/*')
        .pipe(gulp.dest('./dist/font'))
        .pipe(browserSync.reload({ stream: true }));
});
/*///////////////////////////////////////
RELOAD YOUR BROWSER
///////////////////////////////////////*/
gulp.task('bs-reload', function () {
	browserSync.reload();
});
/*///////////////////////////////////////
copy root folder
///////////////////////////////////////*/
gulp.task('root', function () {
    return gulp.src('./src/root/**/*')
        .pipe(gulp.dest('./dist/'))
        .pipe(browserSync.reload({ stream: true }));
});
/*///////////////////////////////////////
WATCHER
///////////////////////////////////////*/
gulp.task('default', gulp.parallel('browser-sync','js','css','build','svg','img','root', ()=>  {
	gulp.watch('./src/js/*.js',   gulp.series(['js']));
	gulp.watch('./src/**/*.css',  gulp.series(['css']));
	gulp.watch('./src/root/*',  gulp.series(['browser-sync','root','css-root']));
	gulp.watch('./dist/**/*.html',  gulp.series(['bs-reload']));
	gulp.watch(['./src/views/**/*'], gulp.series(['build-watch']));
	gulp.watch('./src/images/**/*.svg', gulp.series(['svg']));
	gulp.watch('src/**/*.+(png|jpg|jpeg|gif)', gulp.series(['img']));
}));
