(function () {
    //获取元素
    var headerNav = document.querySelector('.header-nav')
    var proul = document.querySelector('.list-bd');
    var familyList = document.querySelector('.class-list');
    var tasteList = document.querySelector('.tag-list');

    var obj = new URLSearchParams(location.search);
    var _family_id = obj.get('family_id');
    var _taste = obj.get('taste')
    if (!_family_id) {
        _family_id = 'all';
    }
    for (var i = 1; i < familyList.children.length; i++) {
        familyList.children[i].children[0].className = '';
        for (var j = 0; j < headerNav.children.length; j++) {
            headerNav.children[j].children[0].className = '';
        }
    }
    if (_family_id == 'all') {
        familyList.children[1].children[0].className = 'selected';
    } else {
        familyList.children[Number(_family_id) + 1].children[0].className = 'selected';
        for (var j = 1; j < tasteList.children.length; j++) {
            var index = tasteList.children[j].children[0].href.indexOf('?');
            var a = tasteList.children[j].children[0].href.substr(index + 1);
            tasteList.children[j].children[0].href = familyList.children[Number(_family_id) + 1].children[0].href + '&' + a;
            tasteList.children[j].className = '';
            if (_family_id !== "1" && j !== 1) {
                tasteList.children[j].children[0].href = '';
                tasteList.children[j].className = 'disabled';
            }
        }
        if (_family_id == '1') {
            headerNav.children[1].children[0].className = 'target';
        } else if (_family_id == '6') {
            headerNav.children[2].children[0].className = 'target';
        } else if (_family_id == '2') {
            headerNav.children[3].children[0].className = 'target';
        } else if (_family_id == '3') {
            headerNav.children[4].children[0].className = 'target';
        }
    }
    if (!_taste) {
        _taste = 'all';
    }
    for (var i = 1; i < tasteList.children.length; i++) {
        tasteList.children[i].children[0].className = '';
    }
    if (_taste == 'all') {
        tasteList.children[1].children[0].className = 'selected';
    } else {
        for (var j = 1; j < tasteList.children.length; j++) {
            if (tasteList.children[j].children[0].innerText == _taste) {
                tasteList.children[j].children[0].className = 'selected';
                break;
            }
        }
    }
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            var arr = JSON.parse(r);
            if (!arr) {
                proul.style.visibility = 'hidden';
            } else {
                proul.style.visibility = 'visible';
            }
            for (var i = 1; i < arr.length; i++) {
                var li = proul.children[0].cloneNode(true);
                proul.appendChild(li);
            }

            function getli(obj, ul, num) {
                ul.children[num].children[0].href = `pro-detail.html?pid=${obj.pid}`;
                ul.children[num].children[0].children[0].src = obj.smpic;
                ul.children[num].children[0].children[1].innerHTML = obj.subtitle;
                var specs = obj.spec.split(';');
                for (var j = 0; j < specs.length; j++) {
                    var prices = specs[j].split(',');
                    if (prices[2] == 1) {
                        ul.children[num].children[0].children[2].innerHTML = `￥${prices[3]}/${prices[0] + prices[1]}`;
                    }
                }
                var tags = obj.tag.split(',');
                for (var i = 0; i < tags.length; i++) {
                    var a = document.createElement('a');
                    a.href = 'pro-tag.html?tag=' + tags[i];
                    a.innerHTML = tags[i] + ' >';
                    ul.children[num].children[1].appendChild(a);
                    if (i == 2) {
                        break;
                    }
                }
                if (obj.sold_count >= 500) {
                    ul.children[num].children[3].children[0].src = "image/tag-star.png";
                } else {
                    for (var i = 0; i < tags.length; i++) {
                        if (tags[i] == '新品') {
                            ul.children[num].children[3].children[0].src = "image/tag-new.png";
                            break;
                        } else if (tags[i] == '人气') {
                            ul.children[num].children[3].children[0].src = "image/tag-hot.png";
                        }
                    }
                }
            }
            for (var i = 0; i < arr.length; i++) {
                getli(arr[i], proul, i);
            }
        }
    }
    xhr.open('get', '/pro/v1/prolist/' + _family_id + '&' + _taste, true);
    xhr.send();
})();