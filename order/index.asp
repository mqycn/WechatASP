<%
'================================================================
'=   文件名称：index.asp                                        =
'=   实现功能：提交订单页面                                     =
'=   作者主页：http://www.miaoqiyuan.cn/index.html              =
'=   最新版本：http://git.oschina.net/mqycn/WechatASP           =
'=   联系邮箱：mqycn@126.com;                                   =
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
            <input type="text" class="form-control" id="o_title" name="o_title" placeholder="请输入订单标题">
          </div>
        </div>
        <div class="form-group">
          <label for="o_body" class="col-sm-2 control-label">订单描述</label>
          <div class="col-sm-10">
            <textarea type="text" class="form-control" id="o_body" name="o_body" placeholder="请输入订单描述"></textarea>
          </div>
        </div>
        <div class="form-group">
          <label for="o_money" class="col-sm-2 control-label">订单金额</label>
          <div class="col-sm-10">
            <div class="input-group">
              <span class="input-group-addon">
                <span class="glyphicon glyphicon-yen"></span>
              </span>
              <input type="text" class="form-control" id="o_money" name="o_money" placeholder="请输入订单标题">
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
                <input type="radio" id="o_paytype" name="o_paytype" value="weixin" checked> 微信支付
              </label>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-danger">提交订单</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<!--#include file="footer.asp"-->
