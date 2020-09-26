//1.获取元素
var uname = document.querySelector('.uname');
var upwd = document.querySelector('.upwd');
var upwd2 = document.querySelector('.upwd2');
var wcode = document.querySelector('.write-code');
var gcode = document.querySelector('.get-code');
var birthday = document.querySelector('.birthday');
var errtext = document.querySelector('.err-text');
var btn = document.querySelector('.reg-button');
function err(obj, msg, isErr) {
    errtext.children[1].innerHTML = msg;
    if (isErr) {
        errtext.style.visibility = 'visible';
        errtext.children[0].className = 'err';
        errtext.children[1].style.color = '#FF714D';
        if (obj == uname || obj == upwd || obj == upwd2) {
            obj.nextElementSibling.className = 'err';
        }
    } else {
        errtext.style.visibility = 'hidden';
        errtext.children[1].style.color = 'green';
        errtext.children[0].className = 'suc';
        if (obj == uname || obj == upwd || obj == upwd2) {
            obj.nextElementSibling.className = 'suc';
            obj.nextElementSibling.style.visibility = 'visible';
        }
    }
}

//(1)用户名验证
uname.onblur = function () {
    var _uname = uname.value;
    if (!_uname) {
        err(uname, '用户名不得为空', 1);
        return;
    }
    if (_uname.length < 6) {
        err(uname, '用户名不得少于6位', 1);
        return;
    } else if (_uname.length > 16) {
        err(uname, '用户名长度不得长于16位', 1);
        return;
    } else {
        for (var i = 0; i < _uname.length; i++) {
            var num = _uname.charCodeAt(i);
            if (num > 57 || num < 48) {
                break;
            }
        }
        if (i == _uname.length) {
            err(uname, '用户名不得为纯数字', 1);
            return;
        } else {
            err(uname, '', 0);
        }
    }
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            if (r == 0) {
                err(uname, '', 0);
            } else {
                err(uname, '用户名被占用', 1);
            }
        }
    }
    xhr.open('get', '/user/v1/getuser/' + _uname, true);
    xhr.send();
}
//(2)密码验证
// 密码由8～20个字符，需同时包含英文和数字
upwd.onblur = function () {
    var _upwd = upwd.value;
    var _upwd2 = upwd2.value;
    if (!_upwd) {
        err(upwd, '密码由8～20个字符，需同时包含英文和数字', 1);
        return;
    }
    if (_upwd.length < 8) {
        err(upwd, '密码长度不得少于8位', 1);
        return;
    } else if (_upwd.length > 20) {
        err(upwd, '密码长度不得长于20位', 1);
        return;
    } else {
        let a = 0;
        let b = 0;
        for (var i = 0; i < _upwd.length; i++) {
            var num = _upwd.charCodeAt(i);
            if (num >= 48 && num <= 57) {
                a = 1;
            } if (num >= 65 && num <= 90 || num >= 97 && num <= 122) {
                b = 1;
            }
        }
        if (a == 0 || b == 0) {
            err(upwd, '密码需同时包含英文和数字', 1);
        } else {
            err(upwd, '', 0);
            if (_upwd2) {
                upwd2.onblur();
            }
        }
    }
}

//(3)确认密码
upwd2.onblur = function () {
    var _upwd = upwd.value;
    var _upwd2 = upwd2.value;
    if (!_upwd2) {
        err(upwd, '密码由8～20个字符，需同时包含英文和数字', 1);
        return;
    }
    if (_upwd2 != _upwd) {
        err(upwd2, '两次密码输入不一致', 1);
        return;
    } else {
        err(upwd2, '', 0);
    }
}

//(4)获取验证码
function getYan() {
    var str = '';
    for (var i = 0; i < 4; i++) {
        var n = (Math.random() * 75) + 48
        if (n <= 57 && n >= 48 || n <= 90 && n >= 65 || n <= 122 && n >= 97) {
            str += String.fromCharCode(n);
        } else {
            i--;
        }
    }
    return str;
}
//2.注册事件，程序处理
gcode.innerHTML = getYan();
setInterval(() => {
    gcode.style.backgroundColor = 'rgb(' + parseInt(Math.random() * 256) + ', ' + parseInt(Math.random() * 256) + ',' + parseInt(Math.random() * 256) + ', .4' + ')'
}, 100)
//3.点击提交时，input里面的验证码与输出的一致时，输出正确，不一致时，清空input里面的内容，刷新验证码
gcode.onclick = function () {
    gcode.innerHTML = getYan();
}
wcode.onblur = function () {
    var str1 = wcode.value.toLowerCase();
    var str2 = gcode.innerHTML.toLowerCase();
    if (str1 === str2) {
        err(wcode, '', 0);
    } else {
        wcode.value = '';
        err(wcode, '验证码错误', 1)
        gcode.innerHTML = getYan();
    }
}

//(5)生日
birthday.onblur = function () {
    var _birthday = birthday.value;
    if (!_birthday) {
        err(birthday, '请输入您的生日', 1);
        return;
    } else {
        err(upwd, '', 0);
    }
}

//创建事件
btn.onclick = function () {
    var _uname = uname.value;
    var _upwd = upwd.value;
    var _birthday = birthday.value;
    uname.onblur();
    upwd.onblur();
    upwd2.onblur();
    wcode.onblur();
    birthday.onblur();
    if (!agree.checked) {
        err(agree, '请先同意用户协议！', 1);
        return;
    } else {
        err(agree, '', 0);
    }
    if (errtext.children[0].className !== 'suc') {
        return;
    }
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            if (r == 0) {
                err(btn, '注册失败', 1);
            } else {
                err(btn, '注册成功', 0);
                errtext.style.visibility = 'visible';
                location.href = 'login.html'
            }
        }
    }
    xhr.open('post', '/user/v1/reg', true);
    var formdata = `uname=${_uname}&upwd=${_upwd}&birthday=${_birthday}`;
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    xhr.send(formdata);
}