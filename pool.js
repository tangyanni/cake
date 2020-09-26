//引入mysql模块
const mysql = require('mysql');
//创建连接池
const pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'root',
    password: '',
    port: '3306',
    database: 'cake',
    connectionLimit: '20'
});

// 导出连接池对象
module.exports = pool;