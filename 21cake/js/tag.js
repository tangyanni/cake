(function () {
    //获取元素
    var proul = document.querySelector('.list-bd');
    var tagTitle = document.querySelector('.tag-title');
    var obj = new URLSearchParams(location.search);
    var _tag = obj.get('tag');
    tagTitle.innerHTML = _tag;
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            var arr = JSON.parse(r);
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
    xhr.open('get', '/pro/v1/protag/' + _tag, true);
    xhr.send();
})();