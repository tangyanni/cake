(function () {
    //获取元素
    var prouls = document.querySelectorAll('.pro-list');
    for (var i = 0; i < 4; i++) {
        for (var j = 0; j < 4; j++) {
            if (i == 0 && j == 0) {
                continue;
            }
            var li = prouls[0].children[0].cloneNode(true);
            prouls[j].appendChild(li);
        }
    }
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            var arr = JSON.parse(r);

            function getli(obj, ul, num, num2) {
                ul.children[num].children[0].href = obj.href;
                ul.children[num].children[0].children[0].src = obj.smpic;
                ul.children[num].children[1].href = obj.href;
                ul.children[num].children[1].children[0].innerHTML = obj.subtitle;
                ul.children[num].children[2].href = obj.href;
                ul.children[num].children[2].children[0].innerHTML = obj.shortdetail;
                var tags = obj.tag.split(',');
                for (var i = 0; i < tags.length; i++) {
                    var a = document.createElement('a');
                    a.href = 'pro-tag.html?tag=' + tags[i];
                    a.innerHTML = tags[i] + ' >';
                    ul.children[num].children[3].appendChild(a);
                    // console.log(ul.children[num].children[3]);
                }
                var specs = obj.spec.split(';');
                var cartmore = ul.children[num].children[4].children[2];
                for (var j = 1; j < specs.length; j++) {
                    var specitem = specs[j].split(',');
                    var li = cartmore.children[1].children[0].cloneNode(true);
                    if (specitem[0] == '更多磅数') {
                        break;
                    }
                    cartmore.children[1].appendChild(li);
                }
                for (var j = 0; j < specs.length; j++) {
                    var specitem = specs[j].split(',');
                    if (!cartmore.children[1].children[j]) {
                        break;
                    }
                    cartmore.children[1].children[j].children[0].id = 'spec-' + num2 + j;
                    cartmore.children[1].children[j].children[0].name = 'spec-' + num2;
                    cartmore.children[1].children[j].children[1].setAttribute('for', 'spec-' + num2 + j);
                    cartmore.children[1].children[j].children[1].innerHTML = specitem[0] + '<br>' + specitem[1] + '<i></i>';
                    if (specitem[2] == 1) {
                        ul.children[num].children[4].children[0].innerHTML = `￥${specitem[3]}/${specitem[0] + specitem[1]}`;
                        cartmore.children[0].innerHTML = `￥${specitem[3]}/${specitem[0] + specitem[1]}`;
                        cartmore.children[1].children[j].children[0].checked = true;
                    }
                }
                for (var j = 0; j < cartmore.children[1].children.length; j++) {
                    cartmore.children[1].children[j].onclick = function () {
                        var id = this.children[0].id;
                        console.log(id);
                        id = id.slice(-1);
                        var spec = specs[id].split(',');
                        spec[3] = Number(spec[3]).toFixed(2);
                        cartmore.children[0].innerHTML = `¥
                            <span> ${spec[3]}</span>
                                / ${spec[0] + spec[1]}`;
                    }
                }
                // ul.children[num].children[4].children[2].onfocus = function () {
                //     // this.style.display = 'block';
                //     this.style.zIndex = '1';
                //     this.style.transform = "translateY(0)";
                // }
                ul.children[num].children[4].children[1].onclick = function () {
                    ul.children[num].children[4].children[2].style.zIndex = '1';
                    ul.children[num].children[4].children[2].style.transform = "translateY(0)";
                }
                ul.children[num].onmouseleave = function () {
                    setTimeout(() => {
                        ul.children[num].children[4].children[2].style.zIndex = '-1';
                    }, 500);
                    ul.children[num].children[4].children[2].style.transform = "translateY(100%)";
                }
            }
            for (var i = 0; i < arr.length; i++) {
                console.log(i, arr[i].seq_new !== 0);
                if (arr[i].seq_new !== 0) {
                    console.log(arr[i]);
                    getli(arr[i], prouls[0], arr[i].seq_new - 1, arr[i].seq_new);
                }
                if (arr[i].seq_birthday !== 0) {
                    console.log(arr[i]);
                    getli(arr[i], prouls[1], arr[i].seq_birthday - 1, arr[i].seq_birthday + 4);
                }
                if (arr[i].seq_children !== 0) {
                    console.log(arr[i]);
                    getli(arr[i], prouls[2], arr[i].seq_children - 1, arr[i].seq_children + 8);
                }
                if (arr[i].seq_party !== 0) {
                    console.log(arr[i]);
                    getli(arr[i], prouls[3], arr[i].seq_party - 1, arr[i].seq_party + 12);
                }
            }
        }
    }
    xhr.open('get', '/pro/v1/indexpro', true);
    xhr.send();
})();