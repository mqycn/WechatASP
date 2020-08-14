<%
'================================================================
'=   文件名称：index.asp                                        =
'=   实现功能：提交订单页面                                     =
'=   作者主页：http://www.miaoqiyuan.cn/                        =
'=   最新版本：https://gitee.com/mqycn/WechatASP                =
'=   联系邮箱：mqycn@126.com                                    =
'================================================================
%>
<!--#include file="header.asp"-->
<div class="container">
  <div class="panel panel-primary">
    <div class="panel-heading">
      <b>提交订单</b>
    </div>
    <div class="panel-body">
      <form class="form-horizontal" action="save.asp" method="post">
        <div class="form-group">
          <label for="o_title" class="col-sm-2 control-label">订单标题</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="o_title" name="o_title" placeholder="请输入订单标题，不能超过20个字符">
          </div>
        </div>
        <div class="form-group">
          <label for="o_body" class="col-sm-2 control-label">订单描述</label>
          <div class="col-sm-10">
            <textarea type="text" class="form-control" id="o_body" name="o_body" placeholder="请输入订单描述，不能超过50个字符"></textarea>
          </div>
        </div>
        <div class="form-group">
          <label for="o_money" class="col-sm-2 control-label">订单金额</label>
          <div class="col-sm-10">
            <div class="input-group">
              <span class="input-group-addon">
                <span class="glyphicon glyphicon-yen"></span>
              </span>
              <input type="text" class="form-control" id="o_money" name="o_money" placeholder="请输入金额">
              <span class="input-group-addon">
                <b>元</b>
              </span>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label for="o_money" class="col-sm-2 control-label">支付方式</label>
          <div class="col-sm-10">
            <div class="radio">
              <label>
                <input type="radio" id="o_paytype" name="o_paytype" value="weixin" checked> 微信支付 （测试订单金额请填写0.01，恕不退款）
              </label>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-danger">立即支付</button>
          </div>
        </div>
      </form>
    </div>
    <div class="panel-footer">
      <b><span class="text-danger">演示程序只支持PC支付</span>，购买高级版本后程序会自动根据不用的运行环境调用不同的接口</b>
    </div>
  </div>
  <!--广告开始，下面内容请自行删除-->
  <div class="panel panel-danger">
    <div class="panel-heading text-center">版本区别</div>
    <table class="table table-bordered table-hover text-center" style="width:100%;">
      <thead>
        <tr class="warning">
          <th width="20%"></th>
          <td width="20%">PC版</td>
          <td width="20%">H5支付版</td>
          <td width="20%">JSSDK/JSAPI支付版</td>
          <td width="20%">小程序版</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th class="text-right">PC网站扫码支付</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">手机浏览器</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">微信内部</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">小程序</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right"><br><br>技术支持</th>
          <td><span class="text-danger"><br><br>100元/次</span></td>
          <td colspan="3" class="text-left">
            <p>1、购买 H5\JSSDK\小程序版 提供<b class="text-success">免费</b>的 部署支持服务（不涉及帮你改代码，保证支付功能能跑起来），正常 10分钟内搞定</p>
            <p>2、仅限通过微信联系，可以提供 Teamview/向日葵远程协助支持，远程前请先 连接好您的服务器、服务号后台、微信支付后台</p>
            <p>3、如果因用户的原因导致 超过10分钟，需要额外发送红包啊，金额随意。</p>
          </td>
        </tr>
        <tr>
          <th class="text-right">服务器环境</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">虚拟主机(ASP+PHP)</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">虚拟主机(ASP+.NET)</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">虚拟主机(纯ASP)</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td colspan="3"><span class="text-success">可以通过其他虚拟主机实现代理，也可以使用我们免费提供的proxy</span></td>
        </tr>
        <tr>
          <th class="text-right">获取方式</th>
          <td><span class="text-success">免费开源</span></td>
          <td>捐赠158元获取源码</td>
          <td>捐赠168元获取源码</td>
          <td>捐赠188元获取源码</td>
        </tr>
        <tr>
          <td colspan="5">
            <a target="_blank" href="https://gitee.com/mqycn/WechatASP" class="btn btn-lg btn-danger">点击这里，通过微信购买源码</a>
          </td>
        </tr>
      </tbody>
    </table>
    <div class="panel-footer">
      <b class="text-success">H5支付版包含PC版所有功能，JSSDK/JSAPI支付版包含PC版和H5版所有功能，小程序版包含PC版、H5支付版、JSSDK/JSAPI支付版所有功能</b>
    </div>
  </div>
  <!--广告结束-->
</div>
<!--#include file="footer.asp"-->
