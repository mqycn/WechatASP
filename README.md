# WechatASP

### 项目特点

**本项目纯ASP实现，不需要中转，PC代码完全免费，开源不加密**

  _现在已经支持虚拟主机，中转通过你的虚拟主机。需要你的虚拟主机 ，支持 asp+php 或 asp+.net ，将 plugins 下的 proxy.php/aspx 上传到 服务器后，在 payconfig.asp 中增加 pay.orderAPI = "http://你的域名/代理安装路径/proxy.php?token=#PROXY_PASS#" 即可实现虚拟主机支付_ 


### 已支持的接口

-  **PC支付**  免费,开源

-  **JSSDK/JSAPI支付** (微信内部支付) 收费,开源

-  **H5支付**(手机浏览器)  收费,开源

-  **小程序支付** (需要有手机站) 收费,开源



### 和其他 中转方案的区别： 

对，说的就是网上卖 3XX一套和5XX一套的那两家。

| 功能 | WechatASP | 传统中转方案（比如PHP中转）| 
| :-: | - | - | 
| 数据安全 |安全|中转服务器可以看到您的交易，也有伪造交易您收不到款的风险| 
| 稳定性 |稳定，只要自己服务器不出问题就可以|中转服务器关闭或被黑后无法使用| 
| 开源性 |开源，可以看到完整代码|ASP端开源，中转端在第三方服务器，看不到代码| 
| 虚拟主机 |已经增加php/aspx插件支持|支持| 
| 服务器 |支持|支持| 
| 部署多套|[部署多套说明](https://gitee.com/mqycn/WechatASP/issues/IOXBW) |支持| 

现在 我们也提供了中转方案，中转代码开源，如果 你的 虚拟主机 支持 asp+php 或 asp+.net ，同一个虚拟主机可以实现

### 安装测试说明：

[WechatASP 在线测试地址](http://wechatpay.demo.miaoqiyuan.cn/)

[WechatASP 简易安装说明](https://gitee.com/mqycn/WechatASP/issues/IK19E)

[WechatASP 部署说明](http://www.miaoqiyuan.cn/p/asp-wechat-pay-vip)

### 版本对比

![版本区别](https://images.gitee.com/uploads/images/2020/0808/120339_b1538416_82383.png "1.png")

[捐赠后领取H5代码，或者需要购买源码点这里](https://gitee.com/mqycn/WechatASP/issues/IK19J)

1. **购买 H5\JSSDK\小程序版 提供免费的 部署支持服务**（不涉及帮你改代码，保证支付功能能跑起来），正常 10分钟内搞定 

2. 仅限通过微信联系，可以提供 Teamview/向日葵远程协助支持，远程前请先 连接好您的服务器、服务号后台、微信支付后台

3. 如果因用户的原因导致 超过10分钟，需要额外发送红包啊，金额不限。

![微信联系](https://images.gitee.com/uploads/images/2020/0813/101302_27f923f5_82383.png "wechat.png")

### 遇到问题怎么办？

参考教程链接，可以100%成功

[WechatASP 怎么用？](https://gitee.com/mqycn/WechatASP/issues/IK19E)

[WechatASP 部署说明](http://www.miaoqiyuan.cn/p/asp-wechat-pay-vip)

### 遇到问题，但是不想看教程怎么办？

现在已经提供了：[有偿技术支持服务](https://gitee.com/mqycn/WechatASP/issues/IK1E6)

> 不要脸，凭什么收费？

我已经免费提供了代码，解决了您解决不了问题。或者您有这个实力，但是能节省您的精力。使用这个代码对我没有任何损失，但是协助您解决会花费时间（程序员的人工也是成本）。

>我就是想用，还不想交钱

不需要技术支持服务，完全可以免费代码使用代码。参考链接：[安装说明](https://gitee.com/mqycn/WechatASP/issues/IK19E)，严格按照教程一步步的操作，就可以部署成功。