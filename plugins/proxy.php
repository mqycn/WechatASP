<?php

/**
 * PROXY_PASS 代理密钥
 * 请在 payconfig.asp 中增加 pay.orderAPI = "http://你的域名/代理安装路径/proxy.php?token=#PROXY_PASS#"
 * 比如演示程序中的：http://wechatpay.demo.miaoqiyuan.cn/plugins/proxy.php?token=90xLLqGhulfLhemK
 */
define('PROXY_PASS', '90xLLqGhulfLhemK');

# 微信支付接口地址
define('PAY_URL', 'https://api.mch.weixin.qq.com/pay/unifiedorder');

header('content-type: text/xml; charset=utf-8');

# 验证密码是否合法
if (!isset($_GET['token']) || $_GET['token'] != PROXY_PASS) {
	die('<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[代理密钥错误]]></return_msg></xml>');
}

# 获取请求体
if (empty($HTTP_RAW_POST_DATA)) {
	$HTTP_RAW_POST_DATA = file_get_contents('php://input');
}
if (empty($HTTP_RAW_POST_DATA)) {
	die('<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[请求体不存在]]></return_msg></xml>');
}
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, PAY_URL);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $HTTP_RAW_POST_DATA);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($ch, CURLOPT_TIMEOUT, 3000);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 0);
curl_exec($ch);
curl_close($ch);