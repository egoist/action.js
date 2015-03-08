'use strict'

gulp = require 'gulp'
coffee = require 'gulp-coffee'
livereload = require 'gulp-livereload'
stylus = require 'gulp-stylus'
nodemon = require 'gulp-nodemon'

paths = {
  coffee: './src/coffee/*.coffee',
  stylus: './src/stylus/*.styl',
  js: './lib/js',
  css: './lib/css'
}

gulp.task 'test', ->
  gulp.src './test.coffee'
      .pipe coffee bare: true
      .pipe gulp.dest __dirname

  nodemon({
  script: 'test.js'
  ext: 'js',
  execMap: {
    'js': 'iojs'
  }
  }).on 'restart', ->
    console.log 'restarted!'

gulp.task 'coffee', ->
  gulp.src paths.coffee
      .pipe coffee bare: true
      .pipe gulp.dest paths.js

gulp.task 'stylus', ->
  gulp.src paths.stylus
      .pipe stylus compress: true
      .pipe gulp.dest paths.css

gulp.task 'watch', ->
  livereload {start: true}
  livereload.listen()
  gulp.watch paths.coffee, ['coffee']
  gulp.watch paths.stylus, ['stylus']
  gulp.watch([paths.js, paths.css, 'index.html']).on 'change', -> livereload()

gulp.task 'build', ['coffee', 'stylus']

gulp.task 'default', ['test', 'coffee', 'stylus', 'watch']