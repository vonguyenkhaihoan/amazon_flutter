const express = require('express');

const userRouter = require('./routers/auth_route');
const AdminRouter = require('./routers/admin_router');




const app = express();

app.use(express.json());

app.use(userRouter);
app.use(AdminRouter);



module.exports = app;