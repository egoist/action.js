var app, koa, livereload, serve;

koa = require('koa');

app = koa();

livereload = require('koa-livereload');

serve = require('koa-static');

app.use(livereload());

app.use(serve(__dirname));

app.listen(3456);

console.log('action.js is being tested on localhost:3456');
