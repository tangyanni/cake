SET NAMES UTF8;
DROP DATABASE IF EXISTS cake;
CREATE DATABASE cake CHARSET=UTF8;
USE cake;


/**蛋糕类型家族**/
CREATE TABLE cake_pro_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname VARCHAR(32)
);

/**蛋糕详情**/
CREATE TABLE cake_pro(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属类型编号
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #小标题
  taste VARCHAR(128),         #所属口味
  video VARCHAR(128),         #视频路径
  pic VARCHAR(1024),          #图片路径
  smpic VARCHAR(128),         #小图片路径 
  tag VARCHAR(128),           #tag
  constituent VARCHAR(1024),  #成分
  exp VARCHAR(1024),          #介绍
  exist VARCHAR(64),          #保存条件
  sweet VARCHAR(64),          #甜度
  class VARCHAR(128),         #产品分类
  spec VARCHAR(1024),         #产品规格
  details VARCHAR(5024),      #产品详细信息

  sold_count INT,             #已售出的数量
  is_onsale BOOLEAN,           #是否促销中
  FOREIGN KEY(family_id) references cake_pro_family(fid)
);

/**用户信息**/
CREATE TABLE cake_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),
  birthday Date,

  avatar VARCHAR(128),        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小明
  gender INT                  #性别  0-女  1-男
);

/**收货地址信息**/
CREATE TABLE cake_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名

  is_default BOOLEAN,          #是否为当前用户的默认收货地址
  FOREIGN KEY(user_id) references cake_user(uid)
);

/**购物车条目**/
CREATE TABLE cake_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  cake_id INT,   #商品编号
  count INT,        #购买数量
  is_checked BOOLEAN, #是否已勾选，确定购买
  FOREIGN KEY(cake_id) references cake_pro(pid),
  FOREIGN KEY(user_id) references cake_user(uid)
);


/**用户订单**/
CREATE TABLE cake_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  address_id INT,
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT,   #签收时间
  FOREIGN KEY(user_id) references cake_user(uid),
  FOREIGN KEY(address_id) references cake_receiver_address(aid)
)AUTO_INCREMENT=10000000;

/**用户订单详情**/
CREATE TABLE cake_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,           #订单编号
  cake_id INT,            #产品编号
  count INT,               #购买数量
  FOREIGN KEY(order_id) references cake_order(oid),
  FOREIGN KEY(cake_id) references cake_pro(pid)
);


/****首页轮播广告商品****/
CREATE TABLE cake_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/****首页商品****/
CREATE TABLE cake_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  cake_id INT,
  shortdetail VARCHAR(128),
  href VARCHAR(128),
  seq_new TINYINT,
  seq_birthday TINYINT,
  seq_children TINYINT,
  seq_party TINYINT,
  FOREIGN KEY(cake_id) references cake_pro(pid)
);

/*******************/
/******数据导入******/
/*******************/
/**蛋糕类型家族**/
INSERT INTO cake_pro_family VALUES
(NULL,'蛋糕'),
(NULL,'冰淇淋'),
(NULL,'咖啡下午茶'),
(NULL,'常温蛋糕'),
(NULL,'设计师礼品'),
(NULL,'面包');

/**蛋糕详情**/
INSERT INTO cake_pro VALUES
(1,1,"Deep Bailey's Lovers 深爱",'深爱','乳脂奶油,水果','upload/pro01.mp4','upload/pro_detail_banner01.png;upload/pro_detail_banner02.jpg;upload/pro_detail_banner03.jpg;upload/pro_detail_banner04.jpg','upload/pro01.jpg','情侣,含酒,人气','<li><img src="image/icon/pcicon-19.png"><span>玫瑰甘露、玫瑰蜜饯</span></li><li><img src="image/icon/pcicon-03.png"><span>百利甜酒</span></li>','<p>/奶油中调入玫瑰甘露，整体色泽加深/</p><p>/夹心中增加可咀嚼的玫瑰蜜饯，丰富口感/</p><span class="font-red">*5月14日起水果夹心更换为芒果</span>','0－4℃保藏10小时，5℃食用为佳','4',NULL,'454g,(1.0磅),0,268,约13.5x13.5cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;681g,(1.5磅),0,338,约15.5x15.5cm,适合4-5人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),1,398,约17.5x17.5cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,598,约22.5x22.5cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,958,约30x30cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）;更多磅数','<img src="upload/pro_detail01.jpg" alt=""><img src="upload/pro_detail02.jpg" alt=""><img src="upload/pro_detail03.jpg" alt=""><img src="upload/pro_detail04.jpg" alt=""><img src="upload/pro_detail05.jpg" alt=""><img src="upload/pro_detail06.jpg" alt=""><img src="upload/pro_detail07.jpg" alt=""><img src="upload/pro_detail08.png" alt="">',1000,0),
(NULL,1,"Jerry （新）杰瑞",'Jerry （新）杰瑞','乳酪','','upload/1b093c21138a7c11c32a917439fc86cc.jpg;upload/5253869857c19c9d121ad16a032efb03.jpg;upload/575bdc3503b6879f30c3cfdd0242f82e.jpg;upload/2d028971b21553bf3b3512dbb6c2b966.jpg','upload/0a4ec452eadba714c57ca808a9c80c17.png','儿童,聚会,新品','<li><img src="image/icon/pcicon-01.png"><span>芝士</span></li><li><img src="image/icon/pcicon-06.png"><span>美国扁桃仁</span></li>','<p>/谁动了我的奶酪？!/</p><p>Who touched my cheese? A silky smooth cheese cake fit for the king of mibce. Rich and tempting with a crunchy biscuit base. No cats allowed! /</p><span class="b">*订购5磅及以上规格，蛋糕默认为小切块。</span>','0－4℃保藏10小时，5℃食用为佳','3',NULL,'454g,(1.0磅),1,198,约12x12cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;681g,(1.5磅),0,258,约15x15cm,适合4-5人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约16x16cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,458,约22x22cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约28x28cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）;更多磅数','<img src="upload/a07fa28bb46c810d453c3d31d82e374b.jpg" alt=""><img src="upload/fc3a6b5e2091a3a3bef91bf756c46d0d.jpg" alt=""><img src="upload/b75ceb0d0819765f824146a9494980a8.jpg" alt=""><img src="upload/f565e955e787496679b22fd238a78f70.jpg" alt=""><img src="upload/fcba0a0627c3b6b5c7bd15b2e056e785.jpg" alt=""><img src="upload/d7c1d781181e7305b7a89e3b3ac35e1e.jpg" alt=""><img src="upload/28971bf6e5aa70002bac2689b3364f2d.jpg" alt=""><img src="upload/56fa4a91844e1630905aed88e2b7b1dd.png" alt=""><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',10,0),
(NULL,1,"Framboise Cake 蔓生",'蔓生','乳脂奶油,水果','','upload/da2e471b7883e61ca578446a2954a575.jpg;upload/1669ab29bcdf5c6047dbd6dde1d426a9.jpg;upload/8b854c3eec87cdb965917dbe0db04b68.jpg;upload/44c5a0ee48736ec7068eb02b3b46da75.jpg','upload/8e5930873714d422476417759b01e4b8.png','新品','<li><img src="image/icon/pcicon-03.png"><span>酒</span></li><li><img src="image/icon/pcicon-33.png"><span>奶油</span></li><li><img src="image/icon/pcicon-39.png"><span>树莓</span></li>','<p>/树莓奶油与浆果慕斯蛋糕/</p><p>/蛋糕底部，覆盆子冻干粉喷洒，恰到好处的一抹红晕/</p>','0－4℃保藏10小时，5℃食用为佳','3','蔓生(有酒款),3,1;蔓生(无酒款),4,0','454g,(1.0磅),1,198,约12.5x12.5cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约16x16cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,428,约20x20cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约27.5x27.5cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）','<img src="upload/299dece977857c37a0132711ef60455d.jpg" alt=""><img src="upload/14231b41e07c00ac23ea48f40a0aae37.jpg" alt=""><img src="upload/415291a61cfe4fe76bde032bce87f48b.jpg" alt=""><img src="upload/c0c8b44323e8f2c0147ee7bc9876140d.jpg" alt=""><img src="upload/28296dd725c9703d08518e94bd3ca0ad.jpg" alt=""><img src="upload/a05d20cc3d27f4d51080c6db65cf5c3b.jpg" alt=""><img src="upload/f8d7a7612cbf3e30b3226bc21ff800f3.jpg" alt=""><img src="upload/a0af14b29c71d75e8bb4fb9d3ae47ed0.jpg" alt=""><img src="upload/da2e471b7883e61ca578446a2954a575(1).jpg" alt=""><img src="upload/754d46f179c00c354ad343e7b4d5377e.jpg" alt=""><img src="upload/96d0a3cf216a566ba48c5a8baf61619d.jpg" alt=""><p class="center">以上图片仅供参考，请以收到实物为准。</p>',20,0),
(NULL,1,"Framboise Cake 蔓生(无酒款)",'蔓生(无酒款)','乳脂奶油,水果','','upload/da2e471b7883e61ca578446a2954a575.jpg;upload/1669ab29bcdf5c6047dbd6dde1d426a9.jpg;upload/8b854c3eec87cdb965917dbe0db04b68.jpg;upload/44c5a0ee48736ec7068eb02b3b46da75.jpg','upload/8e5930873714d422476417759b01e4b8.png','新品','<li><img src="image/icon/pcicon-03.png"><span>酒</span></li><li><img src="image/icon/pcicon-33.png"><span>奶油</span></li><li><img src="image/icon/pcicon-39.png"><span>树莓</span></li>','<p>/树莓奶油与浆果慕斯蛋糕/</p><p>/蛋糕底部，覆盆子冻干粉喷洒，恰到好处的一抹红晕/</p>','0－4℃保藏10小时，5℃食用为佳','3','蔓生(有酒款),3,0;蔓生(无酒款),4,1','454g,(1.0磅),1,198,约12.5x12.5cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约16x16cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,428,约20x20cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约27.5x27.5cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）','<img src="upload/299dece977857c37a0132711ef60455d.jpg" alt=""><img src="upload/14231b41e07c00ac23ea48f40a0aae37.jpg" alt=""><img src="upload/415291a61cfe4fe76bde032bce87f48b.jpg" alt=""><img src="upload/c0c8b44323e8f2c0147ee7bc9876140d.jpg" alt=""><img src="upload/28296dd725c9703d08518e94bd3ca0ad.jpg" alt=""><img src="upload/a05d20cc3d27f4d51080c6db65cf5c3b.jpg" alt=""><img src="upload/f8d7a7612cbf3e30b3226bc21ff800f3.jpg" alt=""><img src="upload/a0af14b29c71d75e8bb4fb9d3ae47ed0.jpg" alt=""><img src="upload/da2e471b7883e61ca578446a2954a575(1).jpg" alt=""><img src="upload/754d46f179c00c354ad343e7b4d5377e.jpg" alt=""><img src="upload/96d0a3cf216a566ba48c5a8baf61619d.jpg" alt=""><p class="center">以上图片仅供参考，请以收到实物为准。</p>',200,0),
(NULL,1,"Easycake 百香果酸乳酪慕斯蛋糕",'百香果酸乳酪慕斯蛋糕','慕斯,乳酪,水果,应季','','upload/60c24f830b646c2d45b8f27a0bfcf9c2.jpg;upload/b6ca3d9bb34c146bdf325bbec36dd481.jpg;upload/4939942d54d9c7e4eceaa49c60e9f4af.jpg;upload/ce21789d2061b0139f2c3e9930a54d5f.jpg','upload/d290a164f8824685201f20ebe30aaa69.jpg','情侣,低温,儿童,结婚','<li><img src="image/icon/pcicon-25.png"><span>百香果酱</span></li><li><img src="image/icon/pcicon-01.png"><span>酸奶酪</span></li><li><img src="image/icon/pcicon-26.png"><span>微酸</span></li>','<p>/除了酸味，百香果是世界上已知，/</p><p>/充满芳香的水果之一。/</p><p>/何况它，有超过130种芳香。/</p><span class="b">*冰淇淋口感，不同层次的酸与冰凉。</span>','-18℃保藏24小时，-5℃食用为佳','2','百香果,5,1;百香果(木糖醇),6,0','454g,(1.0磅),1,198,约12.5x12.5cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约16.5x16.5cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）','<div>Hard to ignore,its aromas of more than 130 kinds.Besides its sourness,passion fruit is one of the most aromatic fruits known.</div><div>/何况它，有超过130种芳香。/</div><div>/ 除了酸味，百香果是世界上已知，/</div><div>/充满芳香的水果之一。/</div><div class="b">*按照冰淇淋标准≦-18℃低温配送，解冻至-5℃，切开时手感略硬，此状态食用最佳<br>若不及时食用，请放置冰箱冷冻（-18℃）储存，24小时内食用完毕。</div><img src="upload/81e88376c2c6873c8c682d21c3867744.jpg" alt=""><img src="upload/44a1aeaaaa6c922b0b8195465831de1d.jpg" alt=""><img src="upload/3a87f9d2a5264a218bae1b2994f1a887.jpg" alt=""><img src="upload/5eb3f569ad5b7706258364f9783a76c8.jpg" alt=""><img src="upload/e2663c8188b08d7cc24fd410f219d7fe.jpg" alt=""><img src="upload/64dcaead75245ee25a74838a2b32b14d.jpg" alt=""><img src="upload/f7c16a3f02f5d0cf4d176a64d34781af.jpg" alt=""><img src="upload/522ee14a335d8737d3e5eedc6df4b2bc.png" alt=""><img src="upload/263275c21931ee4658d4e7248a6f01f6.jpg" alt=""><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',100,0),
(NULL,1,"Easycake 百香果酸乳酪慕斯蛋糕(木糖醇)",'百香果酸乳酪慕斯蛋糕(木糖醇)','慕斯,乳酪,水果,应季','','upload/60c24f830b646c2d45b8f27a0bfcf9c2.jpg;upload/092b5b8d190b5b56b871422e9909569c.jpg;upload/d6df4cfdc79ef0af8a5b1f8fedf011a8.jpg;upload/fc391f102412ac0d38244bb0d35fc9eb.jpg','upload/d290a164f8824685201f20ebe30aaa69.jpg','情侣,低温,新品,儿童','<li><img src="image/icon/pcicon-25.png"><span>百香果酱</span></li><li><img src="image/icon/pcicon-01.png"><span>酸奶酪</span></li><li><img src="image/icon/pcicon-26.png"><span>微酸</span></li>','<p>/除了酸味，百香果是世界上已知，/</p><p>/充满芳香的水果之一。/</p><p>/何况它，有超过130种芳香。/</p><p>/冰淇淋口感，不同层次的酸与冰凉。/</p><span class="b">*本品使用木糖醇代替蔗糖，口感无差别。</span>','-18℃p保藏24小时，-5℃食用为佳','2','百香果,5,0;百香果(木糖醇),6,1','454g,(1.0磅),1,198,约12.5x12.5cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约16.5x16.5cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）','</div><img src="upload/818e7695adc5866b12e451d28991ef23.jpg" alt=""><img src="upload/b0cf58fc0721d4090ac1a43b5e1039a0.jpg" alt=""><img src="upload/02a7955941a9dae2182b577d33515eda.jpg" alt=""><img src="upload/7c2b6c741dddbfacfa6a2f5aa91354a7.jpg" alt=""><img src="upload/54373c07c57f57bcd6be0204aa897024.png" alt=""><img src="upload/263275c21931ee4658d4e7248a6f01f6.jpg" alt=""><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',5,0),
(NULL,1,"Black and White Chocolate Mousse 黑白巧克力慕斯",'黑白巧克力慕斯','慕斯,巧克力','','upload/e5c49393ed2ed71cdd36e918d6ae0341.jpg;upload/4ad505616cf639347c58507bcd766015.jpg','upload/78ad114c07704d96ac2d8123d9ae480c.jpg','含酒,聚会,生日,人气','<li><img src="image/icon/pcicon-03.png"><span>君度酒</span></li><li><img src="image/icon/pcicon-04.png"><span>比利时巧克力</span></li>','<p>/口感冰凉细腻，白巧克力慕斯的甜，与底部黑巧克力酱的苦/</p><p>Cool, silky white chocolate. Rich, bitter dark chocolate. They’re like the mismatched cop duo who spent all their time bickering but always got results. The results in this case? A dessert experience to die for.</p>','0－4℃保藏12小时，5℃食用为佳','5',NULL,'454g,(1.0磅),1,198,约12x12cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;681g,(1.5磅),0,258,约15x15cm,适合4-5人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约16x16cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,458,约22x22cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约28x28cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）;更多磅数','<div>Cool,  silky white chocolate. Rich, bitter dark chocolate. They’re like the mismatched cop duo who spent all their time bickering but always got results. The results in this case? A dessert experience to die for.<br>/口感冰凉细腻，白巧克力慕斯的甜，与底部黑巧克力酱的苦/</div><img src="upload/cd1d0d56ed3baeae652670370e4300fa.jpg" alt=""><img src="upload/e7b29e790ca0fedde0bb6104147c6f13.jpg" alt=""><img src="upload/0126be8e748040dd00e6c06d1cf9a618.jpg" alt=""><img src="upload/156802b25f6b2dc69d91d7ffbe358f84.jpg" alt=""><img src="upload/4663eee14ce4ef1b80c0d755680358ff.png" alt=""><img src="upload/ef64d85e51ab312b0a8d471629c077ba.jpg" alt=""><div><p>小提示:</p><p>1、蛋糕规格及免费配送餐具 ：</p><p>&emsp; 1.0磅：约13×13(cm) 切分9块	适合3-4人食用	免费配送5套餐具</p><p>&emsp; 2.0磅：约17×17(cm) 切分16块	适合7-8人食用	免费配送10套餐具</p><p>&emsp; 3.0磅：约23×23(cm) 切分25块	适合11-12人食用	免费配送15套餐具</p><p>&emsp; 5.0磅：约30×30(cm) 切分49块	适合15-20人食用	免费配送20套餐具</p><p>订购5磅及5磅以上规格的蛋糕，请与客服人员联系，订购电话：400 650 2121</p><p>2、蛋糕在收到后2-3小时内食用为佳。</p><p>3、如对上述食材有过敏经历者，请选择其它款蛋糕。</p><p>4、以上图片仅供参考，请以收到实物为准。</div></p><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',25,0),
(NULL,1,"Golden Chaplet 金枝",'金枝','乳脂奶油,水果','','upload/d9d649f571a22a1f1aa43422a464ab59.jpg;upload/d455f58c05761a6eb8a5729ba3e30778.jpg;upload/5c14df395af1668f8369c00913a9536f.jpg;upload/740aebc0ad14416de5c1bdeb739f4a82.jpg','upload/2be18888cf45c71c66ab452a9578e9bb.jpg','新品','<li><img src="image/icon/pcicon-33.png"><span>奶油</span></li><li><img src="image/icon/pcicon-39.png"><span>树莓</span></li><li><img src="image/icon/pcicon-40.png"><span>柚子</span></li>','<p>/第四代巧克力，复刻黑白巧克力慕斯/</p><p>/天然的粉色、白色/</p><p>/来自日本高知县柚子，和法国覆盆子/</p><p>/在这里，色彩即风味/</p>','0－4℃保藏10小时，5℃食用为佳','3',NULL,'454g,(1.0磅),1,298,约12.5x12.5cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,398,约16.5x16.5cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）','<img src="upload/c307059fd351989cb2b678857d70aff6.jpg" alt=""><img src="upload/fab2fd6c3d30bbfc495fef08ee6714c5.jpg" alt=""><img src="upload/93af331ea495fb02aa07027b307ff48d.jpg" alt=""><img src="upload/e06c45a46caf7748b098a39940ec393a.jpg" alt=""><img src="upload/75a71075c0f2436f2dac7d9caabba57b.jpg" alt=""><img src="upload/85de35821ef0a00c4babbdfa0b9eee6a.jpg" alt=""><img src="upload/b16484733f159961159f72d0ead5e9f2.jpg" alt=""><img src="upload/1b3b2d6fd0961b74dd606e03482af968.jpg" alt=""><img src="upload/97e55893f9a4e16fd6e9aa1f8cf9b2f8.jpg" alt=""><img src="upload/c610ae08449eac692fd8548214d02b39.jpg" alt=""><img src="upload/71410e1832fb8445127de40951b2ffc2.jpg" alt=""><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',60,0),
(NULL,1,"A Picture of Durian Grey 榴莲飘飘",'榴莲飘飘','乳脂奶油,水果','upload/3cd7723cb28fc8e499ef3bbcbe1e71e8.mp4','upload/0c7633a20114aff510aca404de1c5dd5.jpg;upload/0c7633a20114aff510aca404de1c5dd5.jpg;upload/4ef6d7edf14619d97da63301ef89a596.jpg;upload/4479aa3063e9c4a656db1853e8dd8500.jpg','upload/2c911118047531619d0b3a7bb0dece66.jpg','人气,生日','<li><img src="image/icon/pcicon-14.png"><span>自然成熟榴莲肉</span></li><li><img src="image/icon/pcicon-04.png"><span>超薄白巧克力片</span>','<p>/自然成熟的泰国榴莲/</p><p>/在曼谷，官兵后代庭院中，生长着一百年至一百五十年的榴莲树/</p><p>Imagine if an object could bear the weight of all your sins, while you swan about ever beautiful. The durian fruit bears the weight of its sins on the outside, in the form of its malodorous stench.</p>','0－4℃保藏8小时，5℃食用为佳','3',NULL,'454g,(1.0磅),1,198,约13x13cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约18x18cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,458,约24x24cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约29x29cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）','<div>Imagine if an object could bear the weight of all your sins, while you swan about ever beautiful. The durian fruit bears the weight of its sins on the outside, in the form of its malodorous stench. Within, the fruit stays ever creamy. 21cake uses only fresh durian from cake base to decoration, featuring a soft, whispered confession of a sponge. We also use more durian pulp to make the taste more tender.<br>/自然成熟的泰国榴莲/ /在曼谷，官兵后代庭院中，生长着一百年至一百五十年的榴莲树/ </div><img src="upload/aaf623205701d6879017d7cc23595446.jpg" alt=""><img src="upload/97918533e824bfacb14ecbe376b2ff57.jpg" alt=""><img src="upload/4423f2446a340bce04294c39bd143a83.jpg" alt=""><img src="upload/b28b620d2c872a33c79d17b089244069.jpg" alt=""><img src="upload/52e74d4cf47e137de160f28bf73a9eba.jpg" alt=""><img src="upload/5a81ec172e5a876553ac9c3d3a79e179.jpg" alt=""><img src="upload/263275c21931ee4658d4e7248a6f01f6.jpg" alt=""><div>公元一七八七年暹罗军进攻缅甸时，意图夺取他怀，但无法攻克。在围城期间，由于运输困难，军中粮草缺乏，将官只好命令士兵四处寻找野果充饥，士兵在林中找 到一种硕大而有刺的果实。当他们设法剖开尝试之后，出乎意料的香甜可口。后来回师曼谷时，官兵中不少人把榴莲果核随身带回，在自己房屋周围种植。追求更满 意的口感，21cake花时间改良了榴莲飘飘，更换重油坯为松软的戚风坯，使用纯榴莲果肉夹层每一口都是十足的榴莲味道，口齿生香。选择无催化剂，自然成 熟的泰国金枕头榴莲。</div><div><p>小提示:</p><p>1、蛋糕规格及免费配送餐具 ：</p><p>&emsp; 1.0磅：约13×13(cm) 切分9块	适合3-4人食用	免费配送5套餐具</p><p>&emsp; 2.0磅：约17×17(cm) 切分16块	适合7-8人食用	免费配送10套餐具</p><p>&emsp; 3.0磅：约23×23(cm) 切分25块	适合11-12人食用	免费配送15套餐具</p><p>&emsp; 5.0磅：约30×30(cm) 切分49块	适合15-20人食用	免费配送20套餐具</p><p>订购5磅及5磅以上规格的蛋糕，请与客服人员联系，订购电话：400 650 2121</p><p>2、蛋糕在收到后2-3小时内食用为佳。</p><p>3、如对上述食材有过敏经历者，请选择其它款蛋糕。</p><p>4、以上图片仅供参考，请以收到实物为准。</div><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',250,0),
(NULL,1,"Pine Stone Cowboy 松仁淡奶",'松仁淡奶','乳脂奶油,坚果','','upload/d6fd8150b239d6726872c2c4636edaec.jpg;upload/89f8da41ac574d14ebaebc45ce2641c3.jpg;upload/4ef6d7edf14619d97da63301ef89a596.jpg;upload/f8f4b3438fcb8adcab3eda8e1dceddfd.jpg','upload/88317108b363477241cc5d0a54999561.jpg','长辈,人气','<li><img src="image/icon/pcicon-09.png"><span>大兴安岭松仁</span></li>','<p>/中国松仁，和着甜润淡奶咀嚼/</p><p>A soft, sentimental sponge unfettered as a prairie, but with a sheen of bad boy dark chocolate on top. And there, like stars over the desert, is a rugged studding of pine nuts.</p>','0－4℃保藏12小时，5℃食用为佳','3',"松仁淡奶,10,1;松仁淡奶(木糖醇),11,0",'454g,(1.0磅),1,198,约13x13cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;681g,(1.5磅),0,258,约15x15cm,适合4-5人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约17x17cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,458,约23x23cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约30x30cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）;更多磅数','<div>A soft, sentimental sponge unfettered as a prairie, but with a sheen of bad boy dark chocolate on top. And there, like stars over the desert, is a rugged studding of pine nuts. It’s enough to bring a tear to the eye of the meanest old country boy.<br>/中国松仁，和着甜润淡奶咀嚼/ </div><img src="upload/4287e5e66dd6bf6c694fd882cb0eabdb.jpg" alt=""><img src="upload/7c42cb582b33c114b031a0969dd49f99.jpg" alt=""><img src="upload/db52b2a621abf6b4213893b06f176fa3.jpg" alt=""><img src="upload/5c66a62df5611322f345674dd0d0e6e1.jpg" alt=""><img src="upload/e2bbf2b4be9570cfa24d44b9196f2628.jpg" alt=""><img src="upload/b8361921e6664d348d3324160151970a.jpg" alt=""><img src="upload/263275c21931ee4658d4e7248a6f01f6.jpg" alt=""><div><p>小提示:</p><p>1、蛋糕规格及免费配送餐具 ：</p><p>&emsp; 1.0磅：约13×13(cm) 切分9块	适合3-4人食用	免费配送5套餐具</p><p>&emsp; 2.0磅：约17×17(cm) 切分16块	适合7-8人食用	免费配送10套餐具</p><p>&emsp; 3.0磅：约23×23(cm) 切分25块	适合11-12人食用	免费配送15套餐具</p><p>&emsp; 5.0磅：约30×30(cm) 切分49块	适合15-20人食用	免费配送20套餐具</p><p>订购5磅及5磅以上规格的蛋糕，请与客服人员联系，订购电话：400 650 2121</p><p>2、蛋糕在收到后2-3小时内食用为佳。</p><p>3、如对上述食材有过敏经历者，请选择其它款蛋糕。</p><p>4、以上图片仅供参考，请以收到实物为准。</div><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',10,0),
(NULL,1,"Pine Stone Cowboy 松仁淡奶(木糖醇)",'松仁淡奶','乳脂奶油,坚果','','upload/d6fd8150b239d6726872c2c4636edaec.jpg;upload/89f8da41ac574d14ebaebc45ce2641c3.jpg;upload/4ef6d7edf14619d97da63301ef89a596.jpg;upload/f8f4b3438fcb8adcab3eda8e1dceddfd.jpg','upload/88317108b363477241cc5d0a54999561.jpg','长辈,人气','<li><img src="image/icon/pcicon-09.png"><span>大兴安岭松仁</span></li>','<p>/中国松仁，和着甜润淡奶咀嚼/</p><p>A soft, sentimental sponge unfettered as a prairie, but with a sheen of bad boy dark chocolate on top. And there, like stars over the desert, is a rugged studding of pine nuts.</p>','0－4℃保藏12小时，5℃食用为佳','3',"松仁淡奶,10,0;松仁淡奶(木糖醇),11,1",'454g,(1.0磅),1,198,约13x13cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）;681g,(1.5磅),0,258,约15x15cm,适合4-5人分享,含5套餐具（蜡烛需单独订购）;908g,(2.0磅),0,298,约17x17cm,适合7-8人分享,含10套餐具（蜡烛需单独订购）;1362g,(3.0磅),0,458,约23x23cm,适合11-12人分享,含15套餐具（蜡烛需单独订购）;2270g,(5.0磅),0,750,约30x30cm,适合15-20人分享,含20套餐具（蜡烛需单独订购）;更多磅数','<div>A soft, sentimental sponge unfettered as a prairie, but with a sheen of bad boy dark chocolate on top. And there, like stars over the desert, is a rugged studding of pine nuts. It’s enough to bring a tear to the eye of the meanest old country boy.<br>/中国松仁，和着甜润淡奶咀嚼/ </div><img src="upload/4287e5e66dd6bf6c694fd882cb0eabdb.jpg" alt=""><img src="upload/7c42cb582b33c114b031a0969dd49f99.jpg" alt=""><img src="upload/db52b2a621abf6b4213893b06f176fa3.jpg" alt=""><img src="upload/5c66a62df5611322f345674dd0d0e6e1.jpg" alt=""><img src="upload/e2bbf2b4be9570cfa24d44b9196f2628.jpg" alt=""><img src="upload/b8361921e6664d348d3324160151970a.jpg" alt=""><img src="upload/263275c21931ee4658d4e7248a6f01f6.jpg" alt=""><div><p>小提示:</p><p>1、蛋糕规格及免费配送餐具 ：</p><p>&emsp; 1.0磅：约13×13(cm) 切分9块	适合3-4人食用	免费配送5套餐具</p><p>&emsp; 2.0磅：约17×17(cm) 切分16块	适合7-8人食用	免费配送10套餐具</p><p>&emsp; 3.0磅：约23×23(cm) 切分25块	适合11-12人食用	免费配送15套餐具</p><p>&emsp; 5.0磅：约30×30(cm) 切分49块	适合15-20人食用	免费配送20套餐具</p><p>订购5磅及5磅以上规格的蛋糕，请与客服人员联系，订购电话：400 650 2121</p><p>2、蛋糕在收到后2-3小时内食用为佳。</p><p>3、如对上述食材有过敏经历者，请选择其它款蛋糕。</p><p>4、以上图片仅供参考，请以收到实物为准。</div><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',300,0),
(NULL,1,"Forget Tiramisu 新马斯卡彭-咖啡软芝士蛋糕",'新马斯卡彭-咖啡软芝士蛋糕','乳酪,咖啡','upload/fc332664402c0c2b29962f078efcd129.mp4','upload/1ecdfd385d0423a309b25e9c9dbff82f.jpg;upload/1ecdfd385d0423a309b25e9c9dbff82f.jpg;upload/375b310815136a5ba7cd10b9472ebc6a.jpg;upload/0e5fd72ef81f62abd7b72960c413eccb.jpg','upload/ce8ee9b51a066c2ce10618b059eaa5a6.jpg','含酒,情侣','<li><img src="image/icon/pcicon-03.png"><span>含酒</span></li><li><img src="image/icon/pcicon-01.png"><span>马斯卡彭奶酪</span></li><li><img src="image/icon/pcicon-23.png"><span>蓝莓干</span></li>','<p>/多孔蛋糕坯，深深沉浸墨西哥咖啡甘露/</p><p>//加杯咖啡，忘记提拉米苏/</p><p>A perforated cake base, soaked in Mexican coffee syrup. Now，forget Tiramisu...</p><p>*婴幼儿、老人、孕妇及酒精过敏者不宜食用。</p>','0－4℃保藏24小时，5℃食用为佳','2',NULL,'454g,(1.0磅),1,198,约13x13cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）','<div><p>A Story, New.</p><br><p>more than，</p><p>Mascarpone cheese.</p><br><p>People out there in china,</p><p>Make Tiramisu By milk, butter and lemon juice,</p><p>As a substitute for real Mascarpone,</p><p>old cocoa powder on cake,</p><p>for the old story：" a soldier and his wife……"</p><p>Now…</p><p>A perforated cake base,</p><p>soaked in Mexican coffee syrup.</p><br><p>Tender and moist,</p><p>amazing new, Mascarpone flavor,</p><p>your heart will leap for each bite.</p><br><p>Taste it,</p><p>your new story today.</p><br><p>Recency,</p><p>love is.</p><br><p>/蛋糕要新鲜，讲故事也一样。/</p><p>/多孔蛋糕坯，深深沉浸墨西哥咖啡甘露。/</p><br><p>新马斯卡彭-咖啡软芝士蛋糕</p><br><p>加杯咖啡，</p><p>忘记提拉米苏...</p></div><img src="upload/94554c902e878cf6cf4dec5fee424f18.jpg" alt=""><img src="upload/102f55c0f2381e212a9e92c8108bc132.jpg" alt=""><img src="upload/db00549277e1aaf4a1c15fc3ee0f952d.jpg" alt=""><img src="upload/f82f17429237d8afca177d377b6442b8.jpg" alt=""><img src="upload/33ca0815fc10b3aab592d55f9805f8dc.jpg" alt=""><img src="upload/1eeadbea9082f847ac74cbaad27d47dc.jpg" alt=""><img src="upload/312de8019313041f2b7a7496fab4630c.jpg" alt=""><img src="upload/d61bd25bb6028b75bfd3ffff1cc6b724.jpg" alt=""><img src="upload/263275c21931ee4658d4e7248a6f01f6.jpg" alt=""><div><p>小提示:</p><p>1、蛋糕规格及免费配送餐具 ：</p><p>&emsp; 1.0磅：约13×13(cm) 切分9块	适合3-4人食用	免费配送5套餐具</p><p>&emsp<p>2、蛋糕在收到后2-3小时内食用为佳。</p><p>3、如对上述食材有过敏经历者，请选择其它款蛋糕。</p><p>4、该款蛋糕不能选择生日牌。</div><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',100,0),
(NULL,1,"Ice Cream Cake with Longan 桂圆冰淇淋蛋糕",'桂圆冰淇淋蛋糕','水果,冰淇淋,应季','','upload/54ce0d41522e7b1a3469b25ebe123bfc.jpg;upload/a5efb3f2b1934768a358e6480145861c.jpg;upload/12780c43a3838dc654c3cea0d3835155.jpg;upload/35730f487378e9daf76085f1da88da77.jpg','upload/97ab14d97f765f97668fbf5005d9b2b1.jpg','含酒,低温,人气','<li><img src="image/icon/pcicon-03.png"><span>白兰地酒</span></li><li><img src="image/icon/pcicon-32.png"><span>金黄桂圆肉干</span></li>',"<p>/白兰地让人分神，有些记忆与酒有关/</p><p>/一边融化，香味渐浓....../</p><p>It's more than the pleasing taste of dried longan. The flavor of brandy comes by unexpectedly, the cream dissolves on your tongue like a pleasant memory.</p>",'－18℃保存24小时，-5℃食用为佳','4',NULL,'454g,(1.0磅),1,198,约13x13cm,适合3-4人分享,含5套餐具（蜡烛需单独订购）','<div><p>It’s more than the pleasing taste of dried longan. The flavor of brandy comes by unexpectedly, the cream dissolves on your tongue like a pleasant memory.</p><p>/白兰地让人分神，有些记忆与酒有关/</p><p>/一边融化，香味渐浓....../</p><br><p>*若不及时食用，请放置冰箱冷冻（-18℃）储存，24小时内食用完毕。</p></div><img src="upload/571fb508878dfabb20d47a599cac27d9.jpg" alt=""><img src="upload/debce4e1e3408820f2a558b4de6c7d50.jpg" alt=""><img src="upload/696955cb5a00276c3c0e913ea598b15f.jpg" alt=""><img src="upload/044403183c23e84239a590c6dedeff19.jpg" alt=""><img src="upload/d6219aa018ba551e1e332c746f133a2e.jpg" alt=""><img src="upload/ae44005bb97899ae5543867c15f0f8e8.jpg" alt=""><img src="upload/daadc333ac83e6e7688573fe68dd5c3e.jpg" alt=""><div><p>小提示:</p><p>1、蛋糕规格及免费配送餐具 ：</p><p>&emsp; 1.0磅：约13×13(cm) 切分9块	适合3-4人食用	免费配送5套餐具</p><p>&emsp<p>2、蛋糕在收到后2-3小时内食用为佳。</p><p>3、如对上述食材有过敏经历者，请选择其它款蛋糕。</p><p>4、以上图片仅供参考，请以收到实物为准。</div><p>退改说明：</p><p>1. 北京、上海、杭州、广州地区距配送时间6小时及以上的订单可修改、取消、退订；距配送时间不足5小时，订单不再支持修改、取消、退订。（22点之后不接受次日14点之前配送订单修改、退订）</p><p>2. 苏州、无锡、深圳、天津距配送时间不足8小时，订单不再支持修改、取消、退订。（22点之后不接受次日16点之前配送订单修改、退订）</p>',400,0),
(NULL,6,"奶羹和雪酪（4口味组合）",'奶羹和雪酪（4口味组合）','','','upload/7d26b0cb458afd92087772dc2539c744.jpg;upload/ec5574bf913d79038425aae9bc5b7735.jpg;upload/ebf957f7272aaf11206bc0dd20f970d5.jpg;upload/c65fa203f1cc958b2b5ad16a231fed7b.jpg','upload/298ebc03a19f3c33105bb77ddc1ac05a.jpg','新品,奶羹和雪酪','',"<p>4口味下午茶组合，夏天吃的清爽凝乳，</p><p>一瓶冰凉芝士，一瓶润滑牛奶，2瓶一组，</p><p>本款为[原味+蓝莓][荔枝+坚果]</p>",'0-4℃冷藏，5℃食用最佳','3',NULL,'320g,（份）,1,50,,3-4人,','<img src="upload/16b33e5e6619545a261c9340db816a69.jpg" alt=""><img src="upload/f0c91742a5c0e33ed4e950bac4007da9.jpg" alt=""><img src="upload/af99c854049b1e0766152ceae9f35599.jpg" alt=""><img src="upload/43765b141692308f45610382e9c9e756.jpg" alt=""><img src="upload/629ee401f1d1b1d207905557f5bcff21.jpg" alt=""><img src="upload/3633b56ce539be75e381d8bec14decef.jpg" alt=""><img src="upload/c2c90aeea39d526506dcb6d9dc68cf8e.jpg" alt="">',600,0),
(NULL,6,"奶羹和雪酪（荔枝奶羹+坚果雪酪）",'奶羹和雪酪（荔枝奶羹+坚果雪酪）','','','upload/cf04071d7d1f7bd9423613f2a10eb492.jpg;upload/2e47241557358fc8812d0ef828dbcf62.jpg;upload/6085dacda843cec2814d403077d58816.jpg;upload/c01e5e2de676d71a93c50f2045f9cc6d.jpg','upload/f076bb60903aa5492554fe401a28944f.jpg','新品,奶羹和雪酪','',"<p>4口味下午茶组合，夏天吃的清爽凝乳，</p><p>一瓶冰凉芝士，一瓶润滑牛奶，2瓶一组，</p><p>本款为[荔枝+坚果]</p>",'0-4℃冷藏，5℃食用最佳','3',NULL,'160g,（份）,1,25,,1-2人,','<img src="upload/3a7746ee5f81eba3fd0a9806b55998b6.jpg" alt=""><img src="upload/4d5a8f2203d4e97bdb79f8c02f425188.jpg" alt=""><img src="upload/4f31922b126e079097d47fe2b588307d.jpg" alt=""><img src="upload/99e29a12563a5fea81a2f529053393bd.jpg" alt=""><img src="upload/19b537ec5fd6179ab184e0c07b060e4a.jpg" alt=""><img src="upload/2d41832fb72716286369d6d0d502cb7f.jpg" alt=""><img src="upload/eb611166107522496c079d4d3a811fdd.jpg" alt=""><img src="upload/d7772fd0f420ef7e98f7c6971cca8c29.jpg" alt=""><img src="upload/c380f0142063e4ebd6d1cd6dff63eed5.jpg" alt=""><img src="upload/08a37962f9bd6eaad57f0b5c4afab09f.jpg" alt=""><img src="upload/7708b06fd641cc255995d053ed38e601.jpg" alt="">',80,0),
(NULL,6,"奶羹和雪酪（原味奶羹+蓝莓雪酪）",'奶羹和雪酪（原味奶羹+蓝莓雪酪）','','','upload/4703aff444f61f109fe0201a98aae920.jpg;upload/386f24eaeb11da761c8d40068c035f09.jpg;upload/957dafde6c23719b55e30fa5864fc582.jpg;upload/931827b1eec1f46143f93adf353ac4c1.jpg','upload/148ca39de631256b8c4028ba5d08e60c.jpg','新品,奶羹和雪酪','',"<p>4口味下午茶组合，夏天吃的清爽凝乳，</p><p>一瓶冰凉芝士，一瓶润滑牛奶，2瓶一组，</p><p>本款为[原味+蓝莓]</p>",'0-4℃冷藏，5℃食用最佳','3',NULL,'160g,（份）,1,25,,1-2人,','<img src="upload/ad2c505fa4a7d9da38f3eaf0c30dd926.jpg" alt=""><img src="upload/fcc503424ceef41635ff6ce4d775bece.jpg" alt=""><img src="upload/768a2f9e24e8e866ee29ea3bfad3eae4.jpg" alt=""><img src="upload/d7dd2e34ed93cd400232c2a628dd2ca2.jpg" alt=""><img src="upload/b8596ffdc2d75d7c0b4ff6869586b5c2.jpg" alt=""><img src="upload/65a98d0fb579bca261093714c9131494.jpg" alt=""><img src="upload/c1d91c5d958383d1d7518c469e4a0b08.jpg" alt=""><img src="upload/eaf7a97df030ca2b3899b101ace3b4fd.jpg" alt=""><img src="upload/d7273403d7fc0259ea7e5b796563962e.jpg" alt=""><img src="upload/7bf9be531be5e9a9768646d7d4969bc1.jpg" alt="">',120,0),
(NULL,6,"Croissant 原味可颂",'原味可颂','','','upload/62a106e7bc1c082ad59107898547cfa7.jpg;upload/d257a25e3f383474c8d3dc8d473d17a4.jpg;upload/083d31cdaee7b24b76c484f540b34314.jpg','upload/719c0813aa53f829499cd07c21b8f2eb.jpg','儿童,可颂,面包','',"<p>/一只可颂就是一个面包师傅的一天/</p><p>/反复折叠33次/</p><p>/烤制出均匀分布，蜂窝状内部气孔/</p><br><p>/有机小麦粉/</p><p>/零误差融入，最高食品标准黄油/</p><p>/与纯正瑞士鲜奶/</p><p>/整个过程不添加一滴水。</p>",'','',NULL,'45g,（份）,1,12,约45g,1人,','<img src="upload/ea869820c75c9e4c0ff96c52dad3347c.jpg" alt=""><img src="upload/a5261c99f55b7e15f584d157152dac49.jpg" alt=""><img src="upload/ae1790b0dbd90c73d10ac4e205f69c56.jpg" alt=""><img src="upload/a404e71d3e510d0acaba8872cfe67a3c.jpg" alt=""><img src="upload/2c052aaa92467e2073a0c4e46f84e9e5.jpg" alt="">',290,0);



/**用户信息**/
INSERT INTO cake_user VALUES
(NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', '2000-1-1','img/avatar/default.png', '丁伟', '1'),
(NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', '1996-6-8','img/avatar/default.png', '林当', '1'),
(NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', '1993-9-1','img/avatar/default.png', '窦志强', '1'),
(NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', '2005-12-24','img/avatar/default.png', '秦小雅', '0');

/****首页轮播广告商品****/
INSERT INTO cake_index_carousel VALUES
(1,'/image/banner01.jpg','Golden Chaplet 金枝','pro-detail.html?pid=8'),
(NULL,'/image/banner02.jpg','奶羹和雪酪（4口味组合）','pro-detail.html?pid=14'),
(NULL,'/image/banner03.jpg','Framboise Cake 蔓生','pro-detail.html?pid=3'),
(NULL,'/image/banner04.jpeg','面包电子卡','#');


/****首页商品****/
INSERT INTO cake_index_product VALUES
(1,3,'树莓奶油与浆果慕斯蛋糕','pro-detail.html?pid=3',1,0,0,0),
(NULL,2,'芝士与坚果的完美融合','pro-detail.html?pid=2',2,0,4,0),
(NULL,1,'你深爱过吗','pro-detail.html?pid=1',0,3,2,0),
(NULL,4,'树莓奶油与浆果慕斯蛋糕','pro-detail.html?pid=3',0,4,1,0),
(NULL,5,'冰淇淋口感，不同层次的酸与冰凉','pro-detail.html?pid=5',0,0,3,0),
(NULL,6,'冰淇淋口感，不同层次的酸与冰凉','pro-detail.html?pid=6',0,0,0,3),
(NULL,7,'白巧克力慕斯的甜，与黑巧克力酱的苦','pro-detail.html?pid=7',0,1,0,4),
(NULL,8,'第四代巧克力，复刻黑白巧克力慕斯','pro-detail.html?pid=8',3,0,0,0),
(NULL,9,'丰厚乳脂奶油，打入足量榴莲果肉','pro-detail.html?pid=9',0,2,0,0),
(NULL,11,'轻松吃的木糖醇松子蛋糕','pro-detail.html?pid=11',4,0,0,0),
(NULL,12,'加杯咖啡，忘记提拉米苏','pro-detail.html?pid=12',0,0,0,2),
(NULL,13,'有些记忆与酒有关，一边融化，香味渐浓','pro-detail.html?pid=13',0,0,0,1);
