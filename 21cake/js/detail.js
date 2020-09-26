// banner模块
// 获取元素
(function () {
    var _title = document.getElementsByTagName('title');
    var detailHeader = document.querySelector('.detail-header');
    var headerPrice = document.querySelector('.header-price')
    var leftBox = document.querySelector('.left-img-box');
    var rightlist = document.querySelector('.banner-list');
    var leftContent = document.querySelector('.detail-content-left');
    var detailPrice = document.querySelector('.detail-price');
    var detailNorms = document.querySelector('.details-norms');
    var detailclass = document.querySelector('.detail-morespec');
    var detailSpec = document.querySelector('.detail-spec');
    var detailExchange = document.querySelector('.detail-exchange');
    var moresize = document.querySelector('.moresize');
    var proPic = document.querySelector('.pro-pic');
    var buyBtn = document.querySelector('.detail-buy-btn');
    var addBtn = document.querySelector('.detail-addshopcar-btn');
    // 获取pid
    var obj = new URLSearchParams(location.search);
    var _pid = obj.get('pid');
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            //获取所有数据
            var r = xhr.responseText;
            var arr = JSON.parse(r);
            console.log(r);
            // 获取产品的图片信息，并放到banner里，并创建点击事件
            if (r == 0) {
                location.href = 'notFound.html';
            }
            var pics = arr[0].pic.split(';');
            console.log(pics);
            leftBox.children[0].src = pics[0];
            if (arr[0].video != '') {
                var video = document.createElement('video');
                video.src = arr[0].video;
                video.poster = pics[0];
                video.controls = true;
                leftBox.appendChild(video);
            }
            for (var i = 0; i < pics.length; i++) {
                var li = document.createElement('li');
                var img = document.createElement('img');
                img.src = pics[i];
                img.style.bottom = (pics.length - 1 - i) * 70 + 'px';
                rightlist.appendChild(li);
                rightlist.lastElementChild.appendChild(img);
            }
            // rightlist.children[0].onmouseover = function () {
            //     leftBox.children[0].src = this.firstElementChild.src;
            //     leftBox.children[1].style.display = 'block';
            //     if (arr[0].video == '') {
            //         leftBox.children[1].style.display = 'none';
            //     }
            // }
            rightlist.children[0].children[0].className = 'choose';
            for (var i = 0; i < rightlist.children.length; i++) {
                rightlist.children[i].setAttribute('index', i);
                rightlist.children[i].onmouseover = function () {
                    for (var j = 0; j < rightlist.children.length; j++) {
                        rightlist.children[j].children[0].className = '';
                    }
                    this.children[0].className = 'choose';
                    leftBox.children[0].src = this.firstElementChild.src;
                    if (arr[0].video != '') {
                        leftBox.children[1].style.display = 'none';
                        var index = this.getAttribute('index');
                        if (index == 0) {
                            leftBox.children[1].style.display = 'block';
                        }
                    }
                }

            }
            //获取标题信息
            var title = arr[0].title;
            var subtitle = arr[0].subtitle;
            detailHeader.children[0].innerHTML = title;
            leftContent.children[0].innerHTML = title;
            _title[0].innerHTML = subtitle + ' ' + title + '__蛋糕网上订购_5小时新鲜送达_21Cake官网';
            //获取tag信息并填入
            var tags = arr[0].tag.split(',');
            for (var i = 0; i < tags.length; i++) {
                var a = document.createElement('a');
                a.href = 'pro-tag.html?tag=' + tags[i];
                a.innerHTML = tags[i] + ' >';
                leftContent.children[1].appendChild(a);
            }
            //获取成分信息并填入
            var constituent = arr[0].constituent;
            leftContent.children[2].innerHTML = constituent;
            //获取对产品的解释说明并填入
            var exp = arr[0].exp;
            leftContent.children[3].innerHTML = exp;
            // 获取产品的保鲜条件，如果没有则忽略
            var exist = arr[0].exist;
            if (exist == '') {
                leftContent.children[4].children[0].innerHTML = '';
            } else {
                leftContent.children[4].children[0].children[1].innerHTML = exist;
            }
            // 获取产品的甜度信息，如果没有则忽略
            var sweet = arr[0].sweet;
            if (sweet == '') {
                leftContent.children[4].children[1].innerHTML = '';
            } else {
                for (var i = 1; i <= sweet; i++) {
                    leftContent.children[4].children[1].children[i].className = 'active';
                }
            }
            //获取分类信息
            if (!arr[0].class) {
                detailclass.style.display = 'none';
            } else {
                detailclass.style.display = 'block';
                var moreClass = arr[0].class.split(';');
                for (var i = 1; i < moreClass.length; i++) {
                    var dd = detailclass.children[1].cloneNode(true);
                    detailclass.appendChild(dd);
                }
                for (var i = 0; i < moreClass.length; i++) {
                    var mclass = moreClass[i].split(',');
                    detailclass.children[i + 1].children[0].innerHTML = mclass[0];
                    detailclass.children[i + 1].children[0].href = 'pro-detail.html?pid=' + mclass[1];
                    if (mclass[2] == 1) {
                        detailclass.children[i + 1].children[0].className = 'spec-choose';
                    }
                }
            }
            // 获取元素的规格信息并填入
            var specs = arr[0].spec.split(';');
            for (var i = 1; i < specs.length; i++) {
                var dd = detailSpec.children[1].cloneNode(true);
                detailSpec.appendChild(dd);
            }
            for (var i = 0; i < specs.length; i++) {
                var spec = specs[i].split(',');
                detailSpec.children[i + 1].children[0].id = 'spec-' + (i + 1);
                detailSpec.children[i + 1].children[1].setAttribute('for', 'spec-' + (i + 1));
                detailSpec.children[i + 1].children[1].innerHTML = spec[0] + '<br>' + spec[1] + '<i></i>';
                if (spec[0] == '更多磅数') {
                    detailSpec.children[i + 1].children[1].innerHTML = spec[0] + '<i></i>';
                    detailSpec.children[i + 1].children[1].style.lineHeight = '28px';
                }
            }
            for (var i = 1; i < detailSpec.children.length; i++) {
                detailSpec.children[i].onclick = function () {
                    var id = this.children[0].id;
                    id = id.slice(-1);
                    console.log(id);
                    var spec = specs[id - 1].split(',');
                    spec[3] = Number(spec[3]).toFixed(2);
                    detailPrice.innerHTML = `¥
                            <span> ${spec[3]}</span>
                                / ${spec[0] + spec[1]}`;
                    headerPrice.innerHTML = `¥${spec[3]}/${spec[0] + spec[1]}`
                    detailNorms.style.display = 'block';
                    detailNorms.children[0].innerHTML = `<i></i>` + spec[4];
                    detailNorms.children[1].innerHTML = `<i></i>` + spec[5];
                    detailNorms.children[2].innerHTML = `<i></i>` + spec[6];
                    var date = new Date();
                    var hour = date.getHours();
                    var time = '最早明天 10:00配送';
                    if (hour < 10) {
                        time = '最早今天 14:00配送'
                    } else if (hour < 15) {
                        time = `最早今天${hour + 4}:00配送`;
                    }
                    detailNorms.children[3].innerHTML = `<i></i>` + time;
                    buyBtn.disabled = false;
                    addBtn.disabled = false;
                    moresize.style.display = 'none';
                    if (spec[0] === '更多磅数') {
                        detailPrice.innerHTML = '';
                        detailNorms.style.display = 'none';
                        moresize.style.display = 'block';
                        headerPrice.innerHTML = ''
                        buyBtn.disabled = true;
                        addBtn.disabled = true;
                    }
                }
            }
            for (var i = 0; i < specs.length; i++) {
                var spec = specs[i].split(',');
                if (spec[2] == 1) {
                    detailSpec.children[i + 1].children[0].checked = true;
                    detailSpec.children[i + 1].onclick();
                }
            }
            //获取产品详情
            var pic = arr[0].details;
            proPic.innerHTML = pic;
        }
    }
    xhr.open('get', '/pro/v1/prodetail/' + _pid, true);
    xhr.send();
})();