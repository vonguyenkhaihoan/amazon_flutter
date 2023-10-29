const express = require('express');

const userRouter = require('./routers/auth_route');



const app = express();

app.use(express.json());

app.use(userRouter);


module.exports = app;