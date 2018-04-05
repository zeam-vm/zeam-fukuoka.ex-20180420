# gulpfile.coffee: build script for front assets
#
# gulp        - build assets
# gulp clean  - clean build files

sources =
  slides:  'slides/'
  slidesSlim: 'slides/**/*.slim'

build =
  dir:    'build/'

bower       = require 'bower'
del         = require 'del'
gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
plumber     = require 'gulp-plumber'
slim        = require 'gulp-slim'

gulp.task 'default', ['clean'], ->
  gulp.start 'compile:slim'

gulp.task 'clean', (cb) ->
  del build.dir, cb

gulp.task 'compile:slim', ->
  gulp.src(sources.slidesSlim)
    .pipe(plumber())
    .pipe(slim({
      pretty: true,
      require: 'slim/include',
      options: 'include_dirs=["includes"]'
    }))
    .pipe(gulp.dest(sources.slides))
