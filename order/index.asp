<%
'================================================================
'=   �ļ����ƣ�index.asp                                        =
'=   ʵ�ֹ��ܣ��ύ����ҳ��                                     =
'=   ������ҳ��http://www.miaoqiyuan.cn/                        =
'=   ���°汾��https://gitee.com/mqycn/WechatASP                =
'=   ��ϵ���䣺mqycn@126.com                                    =
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
            <input type="text" class="form-control" id="o_title" name="o_title" placeholder="�����붩�����⣬���ܳ���20���ַ�">
          </div>
        </div>
        <div class="form-group">
          <label for="o_body" class="col-sm-2 control-label">��������</label>
          <div class="col-sm-10">
            <textarea type="text" class="form-control" id="o_body" name="o_body" placeholder="�����붩�����������ܳ���50���ַ�"></textarea>
          </div>
        </div>
        <div class="form-group">
          <label for="o_money" class="col-sm-2 control-label">�������</label>
          <div class="col-sm-10">
            <div class="input-group">
              <span class="input-group-addon">
                <span class="glyphicon glyphicon-yen"></span>
              </span>
              <input type="text" class="form-control" id="o_money" name="o_money" placeholder="��������">
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
                <input type="radio" id="o_paytype" name="o_paytype" value="weixin" checked> ΢��֧�� �����Զ����������д0.01��ˡ���˿
              </label>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-danger">����֧��</button>
          </div>
        </div>
      </form>
    </div>
    <div class="panel-footer">
      <b><span class="text-danger">��ʾ����ֻ֧��PC֧��</span>������߼��汾�������Զ����ݲ��õ����л������ò�ͬ�Ľӿ�</b>
    </div>
  </div>
  <!--��濪ʼ����������������ɾ��-->
  <div class="panel panel-danger">
    <div class="panel-heading text-center">�汾����</div>
    <table class="table table-bordered table-hover text-center" style="width:100%;">
      <thead>
        <tr class="warning">
          <th width="20%"></th>
          <td width="20%">PC��</td>
          <td width="20%">H5֧����</td>
          <td width="20%">JSSDK/JSAPI֧����</td>
          <td width="20%">С�����</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th class="text-right">PC��վɨ��֧��</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">�ֻ������</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">΢���ڲ�</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">С����</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right"><br><br>����֧��</th>
          <td><span class="text-danger"><br><br>100Ԫ/��</span></td>
          <td colspan="3" class="text-left">
            <p>1������ H5\JSSDK\С����� �ṩ<b class="text-success">���</b>�� ����֧�ַ��񣨲��漰����Ĵ��룬��֤֧���������������������� 10�����ڸ㶨</p>
            <p>2������ͨ��΢����ϵ�������ṩ Teamview/���տ�Զ��Э��֧�֣�Զ��ǰ���� ���Ӻ����ķ�����������ź�̨��΢��֧����̨</p>
            <p>3��������û���ԭ���� ����10���ӣ���Ҫ���ⷢ�ͺ������������⡣</p>
          </td>
        </tr>
        <tr>
          <th class="text-right">����������</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">��������(ASP+PHP)</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">��������(ASP+.NET)</th>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
          <td><span class="glyphicon glyphicon-ok text-success"></span></td>
        </tr>
        <tr>
          <th class="text-right">��������(��ASP)</th>
          <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
          <td colspan="3"><span class="text-success">����ͨ��������������ʵ�ִ���Ҳ����ʹ����������ṩ��proxy</span></td>
        </tr>
        <tr>
          <th class="text-right">��ȡ��ʽ</th>
          <td><span class="text-success">��ѿ�Դ</span></td>
          <td>����158Ԫ��ȡԴ��</td>
          <td>����168Ԫ��ȡԴ��</td>
          <td>����188Ԫ��ȡԴ��</td>
        </tr>
        <tr>
          <td colspan="5">
            <a target="_blank" href="https://gitee.com/mqycn/WechatASP" class="btn btn-lg btn-danger">������ͨ��΢�Ź���Դ��</a>
          </td>
        </tr>
      </tbody>
    </table>
    <div class="panel-footer">
      <b class="text-success">H5֧�������PC�����й��ܣ�JSSDK/JSAPI֧�������PC���H5�����й��ܣ�С��������PC�桢H5֧���桢JSSDK/JSAPI֧�������й���</b>
    </div>
  </div>
  <!--������-->
</div>
<!--#include file="footer.asp"-->
