<%
'================================================================
'=   �ļ����ƣ�index.asp                                        =
'=   ʵ�ֹ��ܣ��ύ����ҳ��                                     =
'=   ������ҳ��http://www.miaoqiyuan.cn/index.html              =
'=   ���°汾��http://git.oschina.net/mqycn/WechatASP           =
'=   ��ϵ���䣺mqycn@126.com;                                   =
'================================================================
%>
<!--#include file="header.asp"-->
<div class="container">
  <div class="panel panel-primary">
    <div class="panel-heading">
      <b>�ύ����</b>
    </div>
    <div class="panel-body">
      <form class="form-horizontal" action="save.asp" method="post">
        <div class="form-group">
          <label for="o_title" class="col-sm-2 control-label">��������</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="o_title" name="o_title" placeholder="�����붩������">
          </div>
        </div>
        <div class="form-group">
          <label for="o_body" class="col-sm-2 control-label">��������</label>
          <div class="col-sm-10">
            <textarea type="text" class="form-control" id="o_body" name="o_body" placeholder="�����붩������"></textarea>
          </div>
        </div>
        <div class="form-group">
          <label for="o_money" class="col-sm-2 control-label">�������</label>
          <div class="col-sm-10">
            <div class="input-group">
              <span class="input-group-addon">
                <span class="glyphicon glyphicon-yen"></span>
              </span>
              <input type="text" class="form-control" id="o_money" name="o_money" placeholder="�����붩������">
              <span class="input-group-addon">
                <b>Ԫ</b>
              </span>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label for="o_money" class="col-sm-2 control-label">֧����ʽ</label>
          <div class="col-sm-10">
            <div class="radio">
              <label>
                <input type="radio" id="o_paytype" name="o_paytype" value="weixin" checked> ΢��֧��
              </label>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-danger">�ύ����</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<!--#include file="footer.asp"-->
