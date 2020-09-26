// banner模块
(function () {
    var sliderul = document.querySelector('.sliderlis');
    var slider = document.querySelector('.sliders');
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var r = xhr.responseText;
            var arr = JSON.parse(r);
            for (var i = 0; i < arr.length; i++) {
                var div = document.createElement('div');
                div.className = 'slider-pic';
                var a = document.createElement('a');
                a.style.background = 'url(' + arr[i].img + ') center center no-repeat';
                a.href = arr[i].href;
                var li = document.createElement('li');
                li.className = 'sliderli';
                slider.appendChild(div);
                slider.lastElementChild.appendChild(a);
                sliderul.appendChild(li);
            }
            var sliderlis = sliderul.children;
            var sliders = slider.children;
            for (var i = 0; i < sliderlis.length; i++) {
                sliderlis[i].setAttribute('index', i);
                sliderlis[i].onmouseover = function () {
                    var index = this.getAttribute('index');
                    for (var j = 0; j < sliderlis.length; j++) {
                        sliders[j].style.opacity = '0';
                        sliders[j].style.zIndex = '0';
                        sliderlis[j].className = 'sliderli';
                    }
                    this.className = 'sliderli selected';
                    sliders[index].style.opacity = '1';
                    if (index != 0) {
                        sliders[index - 1].style.zIndex = '1';
                    } else {
                        sliders[sliderlis.length - 1].style.zIndex = '1';
                    }
                    setTimeout(() => {
                        sliders[index].style.zIndex = '1';
                        if (index != 0) {
                            sliders[index - 1].style.zIndex = '0';
                        } else {
                            sliders[sliderlis.length - 1].style.zIndex = '0';
                        }
                    }, 1000);
                }
            }
            sliderlis[0].onmouseover();
            function getslider() {
                for (var i = 0; i < sliderlis.length; i++) {
                    var arr = [1, 2, 3, 0];
                    if (sliderlis[i].className === 'sliderli selected') {
                        sliderlis[arr[i]].onmouseover();
                        break;
                    }
                }
            }
            var timer = setInterval(getslider, 3000);
            slider.onmouseover = function () {
                clearInterval(timer);
            };
            slider.onmouseout = function () {
                clearInterval(timer);
                timer = setInterval(getslider, 3000);
            };
        }
    }
    xhr.open('get', '/pro/v1/banner', true);
    xhr.send();
})();