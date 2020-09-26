//1.获取元素
var uname = document.querySelector('.uname');
var upwd = document.querySelector('.upwd');
var btn = document.querySelector('.login-button');
var errtext = document.querySelector('.err-text');
//2.绑定事件
function err(msg) {
    errtext.style.visibility = 'visible';
    errtext.children[1].innerHTML = msg;
    errtext.children[1].style.color = '#FF714D';
    errtext.children[0].className = 'err';
}
btn.onclick = function () {
    var _uname = uname.value;
    var _upwd = upwd.value;
    if (!_uname) {
        err('用户名不得为空');
        return;
    } else if (!_upwd) {
        err('密码不得为空');
        return;
    }
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            if (r == 0) {
                err('用户名不存在');
            } else {
                var arr = JSON.parse(r);
                if (_upwd == arr[0].upwd) {
                    errtext.style.visibility = 'visible';
                    errtext.children[1].style.color = 'green';
                    errtext.children[0].className = 'suc';
                    errtext.children[1].innerHTML = '登录成功';
                } else {
                    err('账号/密码错误')
                }
            }
        }
    }
    xhr.open('get', '/user/v1/login/' + _uname, true);
    xhr.send();
}