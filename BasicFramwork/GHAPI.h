//
//  GHAPI.h
//  LXY
//
//  Created by guohui on 16/3/8.
//  Copyright © 2016年 guohui. All rights reserved.
//

#ifndef GHAPI_h
#define GHAPI_h

//#define HTTPSERVICE @"https://apilct.lecuntao.com/mobile" //测试环境 0
//#define HTTPSERVICE @"https://betalct.lecuntao.com/mobile" //预发布环境 1
#define HTTPSERVICE @"https://mobile.lecuntao.com/mobile" //正式环境 2

#pragma mark - 主页 -

//活动页面act=about&op=jumpUrl
#define WAP_ACTIVITY @"act=about&op=jumpConf"
//店铺活动
#define STORE_ACTIVITY @"act=mobile_store&op=storeVoucher"
//店铺活动列表 + 赠品
#define STORE_PROMOTION @"act=mobile_store&op=getStorePromotionList"
//领取红包
#define GET_STORE_MEMBEREXCHANGE_VOUCHER @"act=member&op=memberExchangeVoucher"
//推荐商品
#define RECOMMENDGOODS @"act=goods&op=goodsRecom"
//获取所有省份
//#define PROVINCE @"act=index&op=province"
//获取所有城市
#define GET_CITYNAME @"act=index&op=city"
//根据省份获取cityID
#define GET_CITYID @"act=index&op=getCityId"
//获取主页轮播图，分类，乐6集和特色馆信息
#define HOMECLASS_CONTENT @"act=index&op=mobile_index"
//热词推荐
#define HOST @"act=goods&op=hotWord"
//商品列表加搜索页面
#define GOODS_LIST_AND_SEARCH @"act=goods&op=goodsList"
//特色馆页面左右列表
#define  STYLEHOME_RIGHT_LIST @"act=museum&op=getMuseumGoods"
#define STYLEHOME_LEFT_LIST @"act=museum&op=getLeftNav"
//省级特色馆列表
#define PROVINCE_LIST @"act=museum&op=getMuseumList"
//确认收货
#define CONFIRM_GOODS @"act=member_order&op=receive"
//获取商品详情
#define GET_GOODSDETAILS @"act=mobile_goods_detail&op=url"
//广告页
#define GET_ADVIMAGE @"act=login&op=excessive"
#pragma mark - 分类 -
//分类
#define MOBILE_CATE @"act=mobile_cate&op=index"




#pragma mark - 个人中心 -
//个人中心
#define MY_ACCOUNT @"act=member&op=myAccount"
//获取短信验证码
#define SEND_SMS @"act=sms&op=send_sms"
//注册
#define REGISTER @"act=login&op=register"
//登录
#define LOGIN @"act=login&op=index"
//忘记密码
#define BACKPWD @"act=login&op=backPwd"
//获取地址列表
#define GET_ADDRESS_LIST @"act=address&op=getAddressList"
//设置默认地址
#define SET_DEFAULT_ADDRESS @"act=address&op=setDefaultAddress"
//删除地址
#define DELETE_ADDRESS @"act=address&op=delAddress"
//获取省市区
#define GET_PROVINCE_LIST @"act=Address&op=get_region"
//获取村里体验店列表
#define GET_MEMBER_VILLAGE @"act=Address&op=getMemberByVillageId"
//添加地址
#define ADD_NEW_ADDRESS @"act=address&op=add_address"
//编辑收货地址
#define EDITOR_ADDRESS @"act=address&op=updateAddress"
//我的账户上传头像
#define UPLOAD_AVATAR @"act=member&op=uploadPhoto"
//绑定手机号
#define BIND_MEMBER_PHONE @"act=member&op=bindMemberPhone"
//重新绑定手机号
#define AGAIN_BIND_MEMBER_PHONE @"act=member&op=reBindPhone"

//意见反馈
#define ADD_FEEDBACK @"act=member&op=addFeedback"
//检查版本号
#define  GET_VERSION @"act=about&op=getVersion"
//关于乐村淘
#define ABOUT_LE_CUN_TAO @"act=login&op=our"
//退出登录
#define LOG_OUT @"act=member&op=logout"
//账户余额
#define ACCOUNT_BALANCE @"act=member&op=accountBalance"
//充值
#define RECHARGE_ADD @"act=member&op=rechargeAdd"
#pragma mark - 支付 -

//支付
#define PAYMENT @"act=payment&op=index"
//支付列表
#define GET_PAYMENTLIST @"act=payment&op=getPaymentList"
//找回支付密码
#define RESET_PAY_PWD @"act=member&op=resetPayPwd"
//支付成功信息
#define ORDER_SUCCESS @"act=member_order&op=paymentSuccess"

#pragma mark - 订单 -
//获取确认订单界面所需的信息
#define ORDER_CONFIRM @"act=mobile_order&op=confirm"
//确认订单
#define ORDER_CREATE @"act=mobile_orderV2&op=createOrder"
//订单列表
#define ORDER_LIST @"act=member_order&op=getOrderList"
#define GET_ORDER_LIST @"act=member_order&op=orderList"
//订单详情
#define ORDER_DETAILS @"act=member_order&op=orderDetail"
#define GET_ORDER_DETAILS @"act=member_order&op=getOrderDetail"
//取消订单
#define CANCLE_ORDER @"act=member_order&op=cancel_order"
//获取卖家联系方式
#define GETSTORE_TEL @"act=member_order&op=getStoreInfo"
//获取订单取消原因
#define GETORDERCANCLERASON @"act=member_order&op=getCancelOrderReason"

#pragma mark - 购物车 -
//购物车列表 和 结算验证
#define MOBILECART @"act=mobile_cart&op=index"
//添加购物车
#define CART_ADD @"act=mobile_cart&op=add"
//修改购物车商品数量
#define CART_EDIT @"act=mobile_cart&op=edit"
//删除购物车商品
#define CART_DEL @"act=mobile_cart&op=del"

//店铺首页
#define STORE_PAGE @"act=mobile_store&op=getStoreIndex"
//店铺推荐列表
#define STORE_GOODS @"act=mobile_store&op=getStoreGoods"
//主页换肤
#define PICTURESKIN @"act=about&op=pictureSkin"
#endif /* GHAPI_h */

