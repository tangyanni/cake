//引入express模块
const express = require('express');
//引入连接池
const pool = require('../pool.js');
//创建路由器
const r = express.Router();

// 注册页面
r.post('/v1/reg', (req, res) => {
    var obj = req.body;
    console.log(obj);
    var sql = 'INSERT INTO cake_user SET ?';
    pool.query(sql, [obj], (err, result) => {
        if (err) throw err;
        if (result.affectedRows == 0) {
            res.send('0');
        } else {
            res.send('1');
        }
    })
});

// 根据uname查询用户名
r.get('/v1/getuser/:uname', (req, res) => {
    var _uname = req.params.uname;
    var sql = 'SELECT uname FROM cake_user WHERE uname=?';
    pool.query(sql, [_uname], (err, result) => {
        if (err) throw err;
        if (result.length == 0) {
            res.send('0');
        } else {
            res.send('1');
        }
    })
})

//登录
r.get('/v1/login/:uname', (req, res) => {
    var _uname = req.params.uname;
    var sql = 'SELECT uname,upwd FROM cake_user WHERE uname=?';
    pool.query(sql, [_uname], (err, result) => {
        if (err) throw err;
        if (result.length == 0) {
            res.send('0');
        } else {
            res.send(result);
        }
    })
})


module.exports = r;