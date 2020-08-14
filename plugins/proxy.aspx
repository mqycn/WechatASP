<%@ Page Language="C#" Debug="true" CodePage="65001" %>
<%@ Import NameSpace="System.Net" %>
<%@ Import NameSpace="System.Text" %>

<script language="c#" runat="server">

    /**
     * PROXY_PASS 代理密钥
     * 请在 payconfig.asp 中增加 pay.orderAPI = "http://你的域名/代理安装路径/proxy.aspx?token=#PROXY_PASS#"
     * 比如演示程序中的：http://wechatpay.demo.miaoqiyuan.cn/plugins/proxy.aspx?token=90xLLqGhulfLhemK
     */
    const String PROXY_PASS = "90xLLqGhulfLhemK";

    //微信支付接口地址
    const String PAY_URL = "https://api.mch.weixin.qq.com/pay/unifiedorder";

    void Page_Load() {
        Response.ContentType = "text/xml; charset=utf-8";

        if( PROXY_PASS != Request.QueryString["token"]){
            ShowError("代理密钥错误");
        }else if( "POST" != Request.ServerVariables["REQUEST_METHOD"]){
            ShowError("只允许POST方式提交");
        }else if(Request.TotalBytes == 0){
            ShowError("请求体不存在");
        }else{
            //获取请求内容
            byte[] postBytes = Request.BinaryRead(Request.TotalBytes);

            //WEB客户端
            WebClient client = new WebClient();
            try {
                byte[] bytes = client.UploadData(PAY_URL,"POST", postBytes);
                Response.BinaryWrite(bytes);
            } catch (Exception e) {
                ShowError(e.ToString());
            }
        }

    }

    void ShowError(String message){
        byte[] bytes = Encoding.Default.GetBytes(message);
        String msg = Encoding.UTF8.GetString(bytes);
        Response.Write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[" + msg + "]]></return_msg></xml>");
    }


</script>