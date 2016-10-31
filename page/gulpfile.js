var gulp = require('gulp');
var babel = require('gulp-babel');
var uglify = require('gulp-uglify');
var sass = require('gulp-sass');
var sourcemaps = require("gulp-sourcemaps");
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var cssnano = require('cssnano');
var nodemon = require('gulp-nodemon');
var path = require('path');
var concat = require('gulp-concat');
var browserSync = require('browser-sync');
var reload = browserSync.reload;

var baseDirs = {
  app: './',
  dist: './dist/'
};

var publicDirs = {
  _self: 'public/',
  js: 'public/js/',
  css: 'public/css/',
  img: 'public/img/'
};

var bowerComponentsDir = baseDirs.app + 'bower_components/';

var appFiles = {
  js: [bowerComponentsDir + '**/*.min.js', baseDirs.app + 'js/**/*.js'],
  css: [bowerComponentsDir + '**/*.css', baseDirs.app + 'css/**/*.css'],
  index: [baseDirs.app + 'views/index.jade']
};

gulp.task('browserSync', ['sass', 'js', 'nodemon'], function() {
  browserSync({
    proxy: 'localhost:30666',
    port: 30808,
    notify: false
  });
});

gulp.task('js', function() {
  return gulp.src(appFiles.js)
    .pipe(sourcemaps.init())

    .pipe(concat('main.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./public/js'))
    .pipe(reload({stream:true}));
});

gulp.task('sass', ['concatcss'], function() {
  return gulp.src('./css/main.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(postcss([
      autoprefixer({browsers: ['last 4 version']}),
      cssnano(),
    ]))
    .pipe(gulp.dest('./css'))
    .pipe(reload({stream:true}));
});

gulp.task('concatcss', function () {
  return gulp.src(appFiles.css)
    .pipe(concat('main.css'))
    .pipe(gulp.dest('./public/css'));
});

gulp.task('nodemon', function (cb) {
  var called = false;
  return nodemon({
    script: 'server.js',
    ext: '.js .hbs',
    ignore: [
      'public/**/*.js',
      'node_modules/**/*.js'
    ],
    env: {
      'NODE_ENV': 'development',
      'PORT': 30666
    },
  }).on('start', function () {
    if (!called) {
      called = true;
      cb();
    }
  }).on('restart', function () {
    console.log('Nodemon restarted!');
  });
});



gulp.task('build', ['js', 'sass']);

gulp.task('default', ['sass', 'js', 'browserSync'], function () {
  gulp.watch('./css/**/**', ['sass']).on('change', reload);
  // gulp.watch('./views/**/*.pug').on('change', reload);
  gulp.watch('./js/**/*.js', ['js']).on('change', reload);
  gulp.watch('./views/**/*.hbs', reload);
});
