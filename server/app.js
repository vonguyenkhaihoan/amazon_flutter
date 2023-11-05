const express = require('express');

const authRouter = require('./routers/auth_route');
const AdminRouter = require('./routers/admin_route');
const ProductRouter = require('./routers/product_route');
const userRouter = require('./routers/user_route');






const app = express();

app.use(express.json());

app.use(authRouter);
app.use(AdminRouter);
app.use(ProductRouter);
app.use(userRouter);





module.exports = app;