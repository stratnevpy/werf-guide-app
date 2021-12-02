const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const pino = require('pino');
const pinoHttp = require('pino-http');

const indexRouter = require('./routes/index');
const imageRouter = require('./routes/image');
const pingRouter = require('./routes/ping');
// [<snippet talkers-router-import>]
const talkersRouter = require('./routes/talkers');
// [<endsnippet talkers-router-import>]

const logger = pino({ level: process.env.LOG_LEVEL || 'info' });
const db = require('./db/models')((msg) => logger.debug(msg));

const app = express();

if (process.env.NODE_ENV != 'production') {
  const webpack = require('webpack');
  const webpackDevMiddleware = require('webpack-dev-middleware');
  const config = require('./webpack.config.js');

  const compiler = webpack(config);

  app.use(
    webpackDevMiddleware(compiler, {
      publicPath: config.output.publicPath,
    })
  );
}

app.use(pinoHttp({ logger, useLevel: 'info' }));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/image', imageRouter);
app.use('/ping', pingRouter);
// [<snippet talkers-router-add>]
app.use('/', talkersRouter(db));
// [<endsnippet talkers-router-add>]

// [<en>] Error handler helps to avoid raw stack traces on logs and to use the logger of choise.
// [<ru>] Обработчик ошибок поможет избежать «сырых» трейсов в логе и использовать выбранный логгер.
app.use((err, req, res, next) => {
  req.log.error(err);
  res.status(500).send({ body: err.message });
});

module.exports = app;
