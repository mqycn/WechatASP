<%
'================================================================
'=   文件名称：pay.asp                                          =
'=   实现功能：订单支付                                         =
'=   作者主页：http://www.miaoqiyuan.cn/                        =
'=   最新版本：https://gitee.com/mqycn/WechatASP                =
'=   联系邮箱：mqycn@126.com                                    =
'================================================================
%>
<!--#include file="conn.asp"-->
<%
	orderNo = Request.QueryString("order_no")
	if not isnumeric(orderNo) then orderNo = 0
	
	rs.open "select * from orderinfo where o_order_no='" & orderNo & "'", conn, 1, 1
	if rs.eof then
		rs.close
		conn.close
		%><!DOCTYPE html><html lang="zh-CN"><head><meta charset="gb2312"><script>alert('订单不存在');history.go(-1);</script></head></html><%
		response.end
	end if
	o_title = rs("o_title")
	o_body = rs("o_body")
	o_money = rs("o_money")
	o_paytype = rs("o_paytype")
	o_status = rs("o_status")
	rs.close
	conn.close
	
	if o_status > 1 then
		response.redirect "info.asp?order_no=" & orderNo
	end if
%>
<!--#include file="header.asp"-->
<div class="container">
  <div class="panel panel-primary">
    <div class="panel-heading">
      <i>订单支付</i>
    </div>
    <div class="panel-body">
      <div class="row">
        <div class="col-sm-8">
          <form class="form-horizontal order-info">
            <div class="form-group">
              <label for="o_title" class="col-sm-4 control-label">订单标题</label>
              <div class="col-sm-8">
                <i><% = o_title %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_body" class="col-sm-4 control-label">订单描述</label>
              <div class="col-sm-8">
                <i><% = o_body %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_money" class="col-sm-4 control-label">订单金额</label>
              <div class="col-sm-8">
                <i><span class="glyphicon glyphicon-yen"></span><b><%=o_money %></b>元</i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_money" class="col-sm-4 control-label">支付方式</label>
              <div class="col-sm-8">
                <i><%=o_paytype %></i>
              </div>
            </div>
          </form>
        </div>
        <div class="col-sm-4">
          <div class="paycode">
            <div>
              <img id="payimg" src="../static/loading.gif">
            </div>
            <div class="paymsg text-center">
              <b>请扫码支付</b>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
	$.ajax({
		url : "wxapi.asp?payType=ajax&order_no=<% =orderNo %>",
		dataType : "json",
		type : "GET",
		success : function(result){
			if( result.status != true ){
				alert(result.errMsg);
			}else{
				$('#qrcode').qrcode(result.payUrl);
				$('#payimg').attr("src", $("#qrcode canvas")[0].toDataURL("image/png"));
				//jQuery('#payimg').attr("src", "http://paysdk.weixin.qq.com/example/qrcode.php?data=" + result.payUrl);
				setInterval(function(){
					$.ajax({
						url : "wxapi.asp?payType=check&order_no=<% =orderNo %>",
						dataType : "json",
						success : function(result){
							if( result.status === true ){
								alert("支付成功");
								location.href = "info.asp?order_no=<% =orderNo %>";
							}
						}
					});
				}, 5000);
			}
		}
	});
})
</script>
<script src="../static/js/jquery.qrcode.min.js"></script>
<div id="qrcode" style="display:none;"></div>
<!--#include file="footer.asp"-->
