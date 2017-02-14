#WechatASP

**测试说明：**

**1、环境配置**

在IIS中将当前目录设置为站点根目录

**2、程序测试**

2.1、提交订单页测试
```
http://IP/order/index.asp
```
2.2、微信支付测试
```
http://IP/order/pay.asp?order_no=201721415151254913
```

2.3、订单完成测试
```
http://IP/order/info.asp?order_no=201721415201355214
```

**3、修改说明**

在 /order/payconfig.asp 中修改支付参数即可，记得把前边的 ' 给删掉哦~

```
	'设置支付参数，也可以直接修改 WeChatPay.asp
	'pay.AppID       = "AppID"
	'pay.AppSecret   = "App密码"
	'pay.MchID       = "商户ID"
	'pay.MchKey      = "商户密码"
	'pay.notifyUrl   = ""	'notifyUrl不指定，则会自动根据当前环境判断
```