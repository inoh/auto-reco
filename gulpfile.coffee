gulp = require('gulp')
stylus = require('gulp-stylus')
slim = require('gulp-slim')
concat = require('gulp-concat')
runSequence = require('run-sequence')
webserver = require('gulp-webserver')
browserify = require('browserify')
source = require('vinyl-source-stream')

gulp.task 'stylus',  =>
  gulp.src [
      'bower_components/normalize.styl/normalize.styl',
      'src/stylus/*.styl'
    ]
    .pipe stylus()
    .pipe concat 'app.css'
    .pipe gulp.dest 'dist/css/'

gulp.task 'coffee', =>
  browserify
      entries: 'src/coffee/app.coffee'
      extensions: ['.coffee']
    .transform 'coffeeify'
    .bundle()
    .pipe source('app.js')
    .pipe gulp.dest 'dist/js'

gulp.task 'slim', =>
  gulp.src 'src/slim/*.slim'
    .pipe slim pretty: true
    .pipe gulp.dest 'dist/'

gulp.task 'static', =>
  gulp.src ['./src/static/template.xlsm']
    .pipe gulp.dest('dist/public')
  gulp.src [
      'bower_components/jquery/dist/jquery.min.js',
      'bower_components/jquery/dist/jquery.min.map',
      'bower_components/js-xlsx/jszip.js',
      'bower_components/js-xlsx/shim.js',
      'bower_components/js-xlsx/xlsx.js',
      'bower_components/underscore/underscore-min.js',
      'bower_components/underscore/underscore-min.map'
    ]
    .pipe gulp.dest('dist/js')

gulp.task 'watch', =>
  gulp.watch 'src/stylus/*.styl', ['stylus']
  gulp.watch 'src/coffee/*.coffee', ['coffee']
  gulp.watch 'src/slim/*.slim', ['slim']

gulp.task 'webserver', =>
  gulp.src 'dist'
    .pipe webserver
      fallback: 'index.html'
      livereload: true

gulp.task 'build', (callback) => runSequence(
  ['static', 'stylus', 'coffee', 'slim'],
  callback
)

gulp.task 'default',
  ['webserver', 'watch']
