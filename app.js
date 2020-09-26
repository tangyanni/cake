//引入express模块
const express = require('express');
//引入body-parser模块
const bodyParser = require('body-parser');
//引入user路由器
const userRouter = require('./router/user.js');
const proRouter = require('./router/pro.js');
//创建web服务器
const app = express();
app.listen(5500);

app.use(express.static('./21cake'));
app.use(bodyParser.urlencoded({
    extended: false
}))



//挂载路由器
app.use('/user', userRouter);
app.use('/pro', proRouter);
