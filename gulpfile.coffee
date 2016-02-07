gulp = require('gulp')
stylus = require('gulp-stylus')
coffee = require('gulp-coffee')
slim = require('gulp-slim')
concat = require('gulp-concat')
runSequence = require('run-sequence')
webserver = require('gulp-webserver')

gulp.task 'stylus',  =>
  gulp.src 'src/stylus/*.styl'
    .pipe stylus()
    .pipe concat 'app.css'
    .pipe gulp.dest 'dist/css/'

gulp.task 'coffee', =>
  gulp.src 'src/coffee/*.coffee'
    .pipe coffee()
    .pipe concat('app.js')
    .pipe gulp.dest 'dist/js/'

gulp.task 'slim', =>
  gulp.src 'src/slim/*.slim'
    .pipe slim pretty: true
    .pipe gulp.dest 'dist/'

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
  ['stylus', 'coffee', 'slim'],
  callback
)

gulp.task 'default',
  ['webserver', 'watch']
