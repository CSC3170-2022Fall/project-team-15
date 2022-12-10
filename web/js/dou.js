// 点击buton按钮翻页效果
var uls = document.querySelectorAll('.ul');
var Uleft = 0;
for (i = 0; i < uls.length; i++) {
    uls[i].onmouseenter = function () {
        var num=this.children.length;
        console.log(num);
        this.parentNode.nextElementSibling.onclick = function () {
            if (Uleft !== -1200*(num-1)) {
            Uleft -= 1200;
            } else {
            Uleft = 0;
            }
            this.previousElementSibling.children[0].style.left = Uleft + 'px';
        }
        this.parentNode.nextElementSibling.nextElementSibling.onclick = function () {
            if (Uleft !== 0) {
            Uleft += 1200;
            } else {
            Uleft = -1200*(num-1);
            }
            this.previousElementSibling.previousElementSibling.children[0].style.left = Uleft + 'px';
        }
    }
};


// 排行榜  鼠标经过书本详情切换
var ols = document.querySelectorAll('ol');
for(i=0;i<ols.length;i++) {
  ols[i].onmouseenter = function () {

    $(this).find($('.rank-works-detailed')).css('display','none');//当前ol里面所有的详情简介隐藏
    $(this).find($('.rank-works-simple')).css('display','block');//当前ol里面所有的简化简介显示

    for (j = 0; j < this.children.length; j++) {
      // this.children[j] 是指当前ol的子元素li数组集合
      this.children[j].onmouseenter = function () {
        //console.log(this);//这里的this是指当前鼠标经过的li;
        this.children[1].children[0].style.display = 'none';
        this.children[1].children[1].style.display = 'block';
      }
      this.children[j].onmouseleave = function () {
        this.children[1].children[0].style.display = 'block';
        this.children[1].children[1].style.display = 'none';
      }
    }
  }
  ols[i].onmouseleave = function () {
    this.children[0].children[1].children[0].style.display = 'none';
    this.children[0].children[1].children[1].style.display = 'block';
  }
}

// 排行榜页面tab切换效果、数据渲染
var Plis = document.querySelectorAll('#p-ul>li')
var pContent = document.querySelectorAll('.p-content')
for (let i = 0; i < Plis.length; i++) {
    Plis[i].onclick = function () {
        $('.p-big').removeClass('p-big')
        this.children[0].classList.toggle('p-big')
        $('.p-long').removeClass('p-long')
        this.children[1].classList.toggle('p-long')
        $('.p-content').css('display','none')
        pContent[i].style.display='block'
        console.log(i);
        
        function getTab(tab,type){
          var xhr=new XMLHttpRequest();
          var str='';
          var Pul=document.querySelectorAll(".main--ocOl2 ul")
          xhr.onreadystatechange=function() {
              if(xhr.readyState==4 && xhr.status==200) {
                  var res=JSON.parse(xhr.responseText);   // 后台接口返回的后台数据
                //   console.log(res.list);
                  for(let j=0; j<res.list.length; j++){
                      str+=`
                          <li class="item--D5mKC">
                              <div class="rankingNumber--p65zg">${j+1}</div>
                              <div class="worksItem--acAXv">
                                  <a href="/column/59911364/?dcs=charts&amp;dcm=ranking-detail&amp;dcc=featured&amp;dct=unfinished_column" class="works-item " data-works-id="326300225">
                                      <div class="inner">
                                          <div class="cover shadow-cover">
                                              <span class="pic" to="/column/59911364/" target="_blank">
                                                  <img src="${res.list[j].works.cover}" alt="${res.list[j].works.title}" loading="lazy">
                                              </span>
                                          </div>
                                          <div class="info">
                                              <h4 class="title">
                                                  <span to="/column/59911364/" target="_blank" title="${res.list[j].works.title}" class="title-container">
                                                      <span class="title-text">${res.list[j].works.title}</span>
                                                  </span>
                                              </h4>
                                              <div class="author">
                                                  <span class="author-link">
                                                      <span>${res.list[j].works.author[0]==undefined?res.list[j].works.origAuthor[0].name:res.list[j].works.author[0].name}</span>
                                                  </span>
                                              </div>
                                              <div class="intro">
                                                  <span>${res.list[j].works.abstract}</span>
                                              </div>
                                              <div class="extra-info">
                                                  <div class="sticky-info">
                                                      <span class="kind-link">${res.list[j].works.kinds[0].shortName}</span>
                                                      <span class="separator"></span>
                                                      <span>${Math.ceil((res.list[j].works.wordCount)/10000)}.0 万字</span>
                                                  </div>
                                                  <div class="flexible-info"></div>
                                              </div>
                                              <div class="actions">
                                                  <div class="actions-left"></div>
                                                  <div class="actions-right"></div>
                                              </div>
                                          </div>
                                      </div>
                                  </a>
                              </div>
                              <div class="rankingInfo--MU4WF">
                                  <span class="rankingChange--MQi2I">
                                      <svg viewBox="0 0 8 2" xmlns="http://www.w3.org/2000/svg" class="iconChange--lt1HP stay--TpAaz fill-current-color">
                                          <path d="M0 2V0h8v2z" fill="#FF9E2C"></path>
                                      </svg>
                                  </span>
                              </div>
                          </li>
                      `
                  }
                  Pul[(i-1)>=0?i-1:0].innerHTML=str
              }
          }
          xhr.open("get", "https://read.douban.com/j/index/charts?index="+tab+"&type="+type+"&verbose=1&limit=50", true)   // true表示异步请求   false表示同步请求
          xhr.send()
        }
        i==1?tab='featured':i==2?tab='mystery_fiction':i==3?tab='womens_fiction':i==4?tab='science_fiction':i==5?tab='literary_fiction':i==6?tab='historical_fiction':i==7?tab='ebook':tab='featured';
        i==7?type='daily_sales':type='unfinished_column'
        getTab(tab,type)
    }
}
if(localStorage.getItem('admin')&&localStorage.getItem('psw')) {
    $('.right-hide').css('display','block')
    $('.indexButton').css('display','none')
}