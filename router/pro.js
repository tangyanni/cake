//引入express模块
const express = require('express');
//引入连接池
const pool = require('../pool.js');
//创建路由器
const r = express.Router();

//首页banner模块
r.get('/v1/banner', (req, res) => {
    var sql = 'SELECT * FROM cake_index_carousel';
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.send(result);
    })
})

//首页商品
r.get('/v1/indexpro', (req, res) => {
    var sql = 'SELECT smpic,shortdetail,href,seq_new,seq_birthday,seq_children,seq_party,subtitle,tag,spec FROM cake_index_product,cake_pro WHERE cake_index_product.cake_id=cake_pro.pid'
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.send(result);
        // console.log(result);
    })
})

//产品详情页面
r.get('/v1/prodetail/:pid', (req, res) => {
    var _pid = req.params.pid;
    var sql = 'SELECT * FROM cake_pro WHERE pid = ?';
    pool.query(sql, [_pid], (err, result) => {
        if (err) throw err;
        // console.log(result);
        if (result.length == 0) {
            res.send('0');
        } else {
            res.send(result);
        }
    })
});

//tag详情页面
r.get('/v1/protag/:tag', (req, res) => {
    var _tag = req.params.tag;
    console.log(_tag);
    var sql = 'SELECT * FROM cake_pro WHERE tag LIKE ? ORDER BY sold_count DESC';
    pool.query(sql, ['%' + _tag + '%'], (err, result) => {
        if (err) throw err;
        // console.log(result);
        if (result.length == 0) {
            res.send('0');
        } else {
            res.send(result);
        }
    })
});

//列表页
r.get('/v1/prolist/:family_id&:taste', (req, res) => {
    var _family_id = req.params.family_id;
    var _taste = req.params.taste;
    if (_family_id == 'all' && _taste == 'all') {
        var sql = 'SELECT * FROM cake_pro ORDER BY sold_count DESC';
    } else if (_family_id == 'all') {
        var sql = 'SELECT * FROM cake_pro WHERE taste LIKE ? ORDER BY sold_count DESC';
        pool.query(sql, ['%' + _taste + '%'], (err, result) => {
            if (err) throw err;
            if (result.length == 0) {
                res.send('0');
            } else {
                res.send(result);
            }
        })
        return;
    } else if (_taste == 'all') {
        var sql = 'SELECT * FROM cake_pro WHERE family_id=? ORDER BY sold_count DESC';
    } else {
        var sql = 'SELECT * FROM cake_pro WHERE family_id=? AND taste LIKE ? ORDER BY sold_count DESC';
    }
    pool.query(sql, [_family_id, '%' + _taste + '%'], (err, result) => {
        if (err) throw err;
        if (result.length == 0) {
            res.send('0');
        } else {
            res.send(result);
        }
    })
});

module.exports = r;