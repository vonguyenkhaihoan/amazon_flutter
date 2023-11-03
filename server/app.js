const express = require('express');

const userRouter = require('./routers/auth_route');
const AdminRouter = require('./routers/admin_route');
const ProductRouter = require('./routers/product_route');





const app = express();

app.use(express.json());

app.use(userRouter);
app.use(AdminRouter);
app.use(ProductRouter);




module.exports = app;