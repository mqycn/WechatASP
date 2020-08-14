<%
	set pay = new WeChatPay
	
	'设置支付参数，也可以直接修改 WeChatPay.asp
	pay.AppID       = "AppID"
	pay.AppSecret   = "App密码"
	'pay.orderAPI    = "" '服务器用户请无需设置，虚拟主机用户请修改为 proxy 的完整地址（包含http://）
	pay.MchID       = "商户ID"
	pay.MchKey      = "商户API密钥" '在 微信支付后台 \ 帐户中心 \ API安全，设置 API密钥 中设置
	pay.CertName    = "MMPay" '新商户请修改为商户ID。老商户部署多套请参考：http://www.miaoqiyuan.cn/p/winhttpcertcfg-mmpay
	'pay.notifyUrl   = ""	'请填写付款成功后的通知脚本（wxapi.asp）的完整路径（包含http://），如果安装目录和演示程序一致可以不用设置（安装到/order/目录），程序自动识别
%>