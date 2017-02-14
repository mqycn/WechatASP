<%
'================================================================
'=                  微信支付类 by MiaoQiyuan.cn                 =
'================================================================
'=   类库名称：WeChatPay                                        =
'=   实现功能：封装 微信支付（模式2）                           =
'=   作者主页：http://www.miaoqiyuan.cn/index.html              =
'=   联系邮箱：mqycn@126.com;                                   =
'================================================================
'=   使用说明：http://www.miaoqiyuan.cn/p/asp-wechat-pay?l.html =
'=   最新版本：http://www.miaoqiyuan.cn/products/wechat/asp.rar =
'================================================================
 
class WeChatPay
     
    private AppID
    private AppSecret
    private MchID
    private MchKey
     
    private orderAPI
     
    public notifyUrl
    public callbackUrl
    public actionName
     
    private BITS_TO_A_BYTE
    private BYTES_TO_A_WORD
    private BITS_TO_A_WORD
     
    public sub Class_Initialize()
         
        AppID       = "AppID"
        AppSecret   = "App密码"
        MchID       = "商户ID"
        MchKey      = "商户密码"
         
        orderAPI    = "https://api.mch.weixin.qq.com/pay/unifiedorder"
        actionName  = "action"
         
        signType    = "MD5"
         
        notifyUrl   = ""
         
        call Md5Initial()
    end sub
     
    public sub Class_Terminate()
    end sub
     
    public function Pay(byval out_trade_no, byval subject, byval body, byval total_fee)
        if notifyUrl = "" then
            currentUrl =  "http://" & Request.Servervariables("SERVER_NAME") 
            if Request.Servervariables("SERVER_PORT") <> 80 then currentUrl = currentUrl & ":" & Request.Servervariables("SERVER_PORT")
            notifyUrl = currentUrl & "/order/wxapi.asp"
        end if
        total_fee = total_fee * 100
         
        '支付类型
        trade_type = "NATIVE" 'PC
        userAgent = lcase(Request.Servervariables("HTTP_USER_AGENT"))
        if instr(userAgent, "android") > 0 or instr(userAgent, "iphone") > 0 then
            'trade_type = "JSAPI" '手机可以设置为使用JSAPI支付
        end if
         
        nonce_str = CreateNonceStr()
         
        OrderArr = Array("body=" & subject, "total_fee=" & total_fee, "out_trade_no=" & out_trade_no, "notify_url=" & notifyUrl, "spbill_create_ip=" & Request.Servervariables("REMOTE_ADDR"), "trade_type=" & trade_type, "appid=" & AppID, "mch_id=" & MchID, "nonce_str=" & nonce_str)
         
        '拼接 XML 请求
        dim xmlInfo
        OrderArr = SortPara(OrderArr)
        xmlInfo = "<?xml version=""1.0"" encoding=""utf-8"" ?><xml>"
        for i = 0 to Ubound(OrderArr)
            if instr(OrderArr(i), "=") > 0 then
                xmlInfo = xmlInfo & paraToXML(OrderArr(i))
            end if
        next
        xmlInfo = xmlInfo & paraToXML("sign=" & Sign(OrderArr))
        xmlInfo = xmlInfo & "</xml>"
         
        if left(actionInfo, 1) = "&" then actionInfo = mid(actionInfo, 2)
         
        result = XMLRequest(orderAPI, xmlInfo)
         
        '分析 请求 结果
        resultPara = XMLToArr(result)
         
        if GetParaValue(resultPara, "return_code") <> "SUCCESS" and GetParaValue(resultPara, "return_msg") <> "OK" then
            resultInfo = GetParaValue(resultPara, "return_msg")
        else
            resultPara = sortPara(resultPara)
            if Sign(resultPara) = GetParaValue(resultPara, "sign") then
                resultInfo = GetParaValue(resultPara, "code_url")
            else
                resultInfo = "Sign Error"
            end if
        end if
         
        Pay = resultInfo
    end function
     
    public function GetNotify()
         
        '必须通过二进制获取，这是一个大坑
        Set xmldom = Server.CreateObject("MSXML2.DOMDocument") 
        xmldom.load Request.BinaryRead(Request.TotalBytes)
         
        result = xmldom.xml
         
        resultPara = XMLToArr(result)
         
        if GetParaValue(resultPara, "return_code") <> "SUCCESS" and GetParaValue(resultPara, "return_msg") <> "OK" then
            set GetNotify = CreateResult(false, GetParaValue(resultPara, "return_msg"), "", "")
        else
            resultPara = sortPara(resultPara)
            if Sign(resultPara) = GetParaValue(resultPara, "sign") then
                set GetNotify = CreateResult(true, GetParaValue(resultPara, "transaction_id"), GetParaValue(resultPara, "total_fee"), GetParaValue(resultPara, "out_trade_no"))
            else
                set GetNotify = CreateResult(false, "Sign Error", "", "")
            end if
        end if
    end function
     
    '=====================================================================================
    '  私有方法
    '=====================================================================================
     
    '统一返回结果，和之前的 支付宝接口统一
    private function CreateResult(byval status, byval trade_no, byval total_fee, byval out_trade_no)
        set CreateResult = Server.CreateObject("Scripting.Dictionary")
        call CreateResult.add("status", status)
        if status = false then
            call CreateResult.add("message", trade_no)
        else
            call CreateResult.add("trade_no", trade_no)
            call CreateResult.add("out_trade_no", out_trade_no)
            call CreateResult.add("total_fee", cSng(total_fee))
        end if
    end function
     
    '签名
    private function Sign(byval paraArr)
        dim signInfo
        for i = 0 to Ubound(paraArr)
            if instr(paraArr(i), "=") > 0 then
                if left(paraArr(i), 5) <> "sign=" then signInfo = signInfo & "&" & paraArr(i)
            end if
        next
        signInfo = signInfo & "&key=" & MchKey
        signInfo = mid(signInfo, 2)
        Sign = UCase(Md5(signInfo))
    end function
     
    '通过 【请求参数】获取值
    private function GetParaValue(byval paraArr, byval paraName)
        GetParaValue = ""
        for i = 0 to Ubound(paraArr)
            if left(paraArr(i), len(paraName) + 1) = paraName & "=" then
                GetParaValue = mid(paraArr(i), len(paraName) + 2)
                exit function
            end if
        next
    end function
     
    '将XML转换为 【请求参数】
    private function XMLToArr(byval xmlDoc)
        dim paraArr()
        Set objXml = Server.CreateObject("MSXML2.DOMDocument")
        objXml.loadxml xmlDoc
        set objParent = objXml.SelectNodes("//xml")
        if objParent.length > 0 then
            redim paraArr(objParent(0).childNodes.length - 1)
            for i = 0 to objParent(0).childNodes.length - 1
                paraArr(i) = objParent(0).childNodes(i).nodeName & "=" & objParent(0).childNodes(i).text
            next
        end if
        XMLToArr = paraArr
    end function
     
    '将  【请求参数】 转换为 XML
    private function paraToXML(byval paraItem)
        if instr(paraItem, "=") > 0 then
            nodeName = mid(paraItem, 1, instr(paraItem, "=") - 1)
            nodeValue = mid(paraItem, instr(paraItem, "=") + 1)
            paraToXML = "<" & nodeName & "><![CDATA[" & nodeValue & "]]></" & nodeName & ">"
        else
            paraToXML = ""
        end if
    end function
     
    '将  【请求参数】 排序
    private function SortPara(byval sPara)
        Dim nCount
        nCount = ubound(sPara)
        For i = nCount To 0 Step -1
            minmax = sPara( 0 )
            minmaxSlot = 0
            For j = 1 To i
                mark = (sPara( j ) > minmax)
                If mark Then
                    minmax = sPara( j )
                    minmaxSlot = j
                End If
            Next
            If minmaxSlot <> i Then
                temp = sPara( minmaxSlot )
                sPara( minmaxSlot ) = sPara( i )
                sPara( i ) = temp
            End If
        Next
        SortPara = sPara
    end function
     
    '创建随机字符串
    private function CreateNonceStr()
        chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        CreateNonceStr = ""
        for i = 0 to 16
            randomize
            index = cLng(rnd() * (len(chars) - 1)) + 1
            CreateNonceStr = CreateNonceStr & mid(chars, index, 1)
        next
    end function
     
     
    'XML请求，需要使用证书
    '正式说明：http://www.miaoqiyuan.cn/p/asp-wechat-pay 
    private function XMLRequest(byval sUrl, byval xmlBody)
        Dim xmlhttp
        Set xmlhttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
        xmlhttp.Open "POST", sUrl, False
        xmlhttp.SetClientCertificate("LOCAL_MACHINE\My\MMPay")
        'xmlhttp.setRequestHeader "Content-Type", "text/xml; charset=GB2312"
        'xmlhttp.setRequestHeader "Content-Length", Len(xmlBody)
 
        xmlhttp.send(xmlBody)
        xmlget = bin2str(xmlhttp.responseBody)
        Set xmlhttp = Nothing
        XMLRequest = xmlget
    end function
     
    '二进制流转换为 XML，这个也是抄的
    private function bin2str(byval binstr)
        Const adTypeBinary = 1
        Const adTypeText = 2
        Dim BytesStream,StringReturn
        Set BytesStream = Server.CreateObject("ADODB.Stream")
        With BytesStream
            .Type = adTypeText
            .Open
            .WriteText binstr
            .Position = 0
            .Charset = "UTF-8"
            .Position = 2
            StringReturn = .ReadText
            .close
        End With
        Set BytesStream = Nothing
        bin2str = StringReturn
    end function
     
    '=====================================================================================
    '  MD5，下边都是抄的，不用看了
    '=====================================================================================
     
    private Sub Md5Initial()
        BITS_TO_A_BYTE = 8
        BYTES_TO_A_WORD = 4
        BITS_TO_A_WORD = 32
    End Sub
     
    Private m_lOnBits(30)  
    Private m_l2Power(30)  
    Private Function LShift(lValue, iShiftBits)  
        If iShiftBits = 0 Then 
            LShift = lValue  
            Exit Function 
        ElseIf iShiftBits = 31 Then 
            If lValue And 1 Then 
                LShift = &H80000000  
            Else 
                LShift = 0  
            End If 
            Exit Function 
        ElseIf iShiftBits < 0 Or iShiftBits > 31 Then 
            Err.Raise 6  
        End If 
        If (lValue And m_l2Power(31 - iShiftBits)) Then 
            LShift = ((lValue And m_lOnBits(31 - (iShiftBits + 1))) * m_l2Power(iShiftBits)) Or &H80000000  
        Else 
            LShift = ((lValue And m_lOnBits(31 - iShiftBits)) * m_l2Power(iShiftBits))  
        End If 
    End Function 
 
    Private Function str2binold(varstr)  
         str2bin="" 
         For i = 1 To Len(varstr)  
             varchar=mid(varstr,i,1)  
             varasc = Asc(varchar)  
             If varasc < 0 Then 
                varasc = varasc + 65535  
             End If 
             If varasc > 255 Then 
                varlow = Left(Hex(Asc(varchar)),2)  
                varhigh = right(Hex(Asc(varchar)),2)  
                str2bin = str2bin & chrB("&H" & varlow) & chrB("&H" & varhigh)  
             Else 
                str2bin = str2bin & chrB(AscB(varchar))  
             End If 
         Next 
    End Function 
    Private Function str2bin(varstr)  
        Dim varchar, code, codearr, j  
        str2bin = "" 
        For i=1 To Len(varstr)  
            varchar = Mid(varstr,i,1)  
            code = Server.UrlEncode(varchar)  
            If Len(code) = 1 Then 
               str2bin = str2bin & chrB(AscB(code))  
            Else 
               codearr = Split(code,"%")  
               For j = 1 to UBound(codearr)  
                  str2bin = str2bin & ChrB("&H" & codearr(j))  
               Next 
             End If 
        Next 
    End Function 
    Private Function RShift(lValue, iShiftBits)  
        If iShiftBits = 0 Then 
            RShift = lValue  
            Exit Function 
        ElseIf iShiftBits = 31 Then 
            If lValue And &H80000000 Then 
                RShift = 1  
            Else 
                RShift = 0  
            End If 
            Exit Function 
        ElseIf iShiftBits < 0 Or iShiftBits > 31 Then 
            Err.Raise 6  
        End If 
        RShift = (lValue And &H7FFFFFFE) \ m_l2Power(iShiftBits)  
        If (lValue And &H80000000) Then 
            RShift = (RShift Or (&H40000000 \ m_l2Power(iShiftBits - 1)))  
        End If 
    End Function 
    Private Function RotateLeft(lValue, iShiftBits)  
        RotateLeft = LShift(lValue, iShiftBits) Or RShift(lValue, (32 - iShiftBits))  
    End Function 
    Private Function AddUnsigned(lX, lY)  
        Dim lX4  
        Dim lY4  
        Dim lX8  
        Dim lY8  
        Dim lResult  
        lX8 = lX And &H80000000  
        lY8 = lY And &H80000000  
        lX4 = lX And &H40000000  
        lY4 = lY And &H40000000  
        lResult = (lX And &H3FFFFFFF) + (lY And &H3FFFFFFF)  
        If lX4 And lY4 Then 
            lResult = lResult Xor &H80000000 Xor lX8 Xor lY8  
        ElseIf lX4 Or lY4 Then 
            If lResult And &H40000000 Then 
                lResult = lResult Xor &HC0000000 Xor lX8 Xor lY8  
            Else 
                lResult = lResult Xor &H40000000 Xor lX8 Xor lY8  
            End If 
        Else 
            lResult = lResult Xor lX8 Xor lY8  
        End If 
        AddUnsigned = lResult  
    End Function 
    Private Function md5_F(x, y, z)  
        md5_F = (x And y) Or ((Not x) And z)  
    End Function 
    Private Function md5_G(x, y, z)  
        md5_G = (x And z) Or (y And (Not z))  
    End Function 
    Private Function md5_H(x, y, z)  
        md5_H = (x Xor y Xor z)  
    End Function 
    Private Function md5_I(x, y, z)  
        md5_I = (y Xor (x Or (Not z)))  
    End Function 
    Private Sub md5_FF(a, b, c, d, x, s, ac)  
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_F(b, c, d), x), ac))  
        a = RotateLeft(a, s)  
        a = AddUnsigned(a, b)  
    End Sub 
    Private Sub md5_GG(a, b, c, d, x, s, ac)  
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_G(b, c, d), x), ac))  
        a = RotateLeft(a, s)  
        a = AddUnsigned(a, b)  
    End Sub 
    Private Sub md5_HH(a, b, c, d, x, s, ac)  
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_H(b, c, d), x), ac))  
        a = RotateLeft(a, s)  
        a = AddUnsigned(a, b)  
    End Sub 
    Private Sub md5_II(a, b, c, d, x, s, ac)  
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_I(b, c, d), x), ac))  
        a = RotateLeft(a, s)  
        a = AddUnsigned(a, b)  
    End Sub 
    Private Function ConvertToWordArray(sMessage)  
        Dim lMessageLength  
        Dim lNumberOfWords  
        Dim lWordArray()  
        Dim lBytePosition  
        Dim lByteCount  
        Dim lWordCount  
        Const MODULUS_BITS = 512  
        Const CONGRUENT_BITS = 448  
        lMessageLength = LenB(sMessage)  
        lNumberOfWords = (((lMessageLength + ((MODULUS_BITS - CONGRUENT_BITS) \ BITS_TO_A_BYTE)) \ (MODULUS_BITS \ BITS_TO_A_BYTE)) + 1) * (MODULUS_BITS \ BITS_TO_A_WORD)  
        ReDim lWordArray(lNumberOfWords - 1)  
        lBytePosition = 0  
        lByteCount = 0  
        Do Until lByteCount >= lMessageLength  
            lWordCount = lByteCount \ BYTES_TO_A_WORD  
            lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE  
            lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(AscB(MidB(sMessage, lByteCount + 1, 1)), lBytePosition)  
            lByteCount = lByteCount + 1  
        Loop 
        lWordCount = lByteCount \ BYTES_TO_A_WORD  
        lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE  
        lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(&H80, lBytePosition)  
        lWordArray(lNumberOfWords - 2) = LShift(lMessageLength, 3)  
        lWordArray(lNumberOfWords - 1) = RShift(lMessageLength, 29)  
        ConvertToWordArray = lWordArray  
    End Function 
    Private Function WordToHex(lValue)  
        Dim lByte  
        Dim lCount  
        For lCount = 0 To 3  
            lByte = RShift(lValue, lCount * BITS_TO_A_BYTE) And m_lOnBits(BITS_TO_A_BYTE - 1)  
            WordToHex = WordToHex & Right("0" & Hex(lByte), 2)  
        Next 
    End Function 
    Public Function MD5(sMessage)  
        m_lOnBits(0) = CLng(1)  
        m_lOnBits(1) = CLng(3)  
        m_lOnBits(2) = CLng(7)  
        m_lOnBits(3) = CLng(15)  
        m_lOnBits(4) = CLng(31)  
        m_lOnBits(5) = CLng(63)  
        m_lOnBits(6) = CLng(127)  
        m_lOnBits(7) = CLng(255)  
        m_lOnBits(8) = CLng(511)  
        m_lOnBits(9) = CLng(1023)  
        m_lOnBits(10) = CLng(2047)  
        m_lOnBits(11) = CLng(4095)  
        m_lOnBits(12) = CLng(8191)  
        m_lOnBits(13) = CLng(16383)  
        m_lOnBits(14) = CLng(32767)  
        m_lOnBits(15) = CLng(65535)  
        m_lOnBits(16) = CLng(131071)  
        m_lOnBits(17) = CLng(262143)  
        m_lOnBits(18) = CLng(524287)  
        m_lOnBits(19) = CLng(1048575)  
        m_lOnBits(20) = CLng(2097151)  
        m_lOnBits(21) = CLng(4194303)  
        m_lOnBits(22) = CLng(8388607)  
        m_lOnBits(23) = CLng(16777215)  
        m_lOnBits(24) = CLng(33554431)  
        m_lOnBits(25) = CLng(67108863)  
        m_lOnBits(26) = CLng(134217727)  
        m_lOnBits(27) = CLng(268435455)  
        m_lOnBits(28) = CLng(536870911)  
        m_lOnBits(29) = CLng(1073741823)  
        m_lOnBits(30) = CLng(2147483647)  
        m_l2Power(0) = CLng(1)  
        m_l2Power(1) = CLng(2)  
        m_l2Power(2) = CLng(4)  
        m_l2Power(3) = CLng(8)  
        m_l2Power(4) = CLng(16)  
        m_l2Power(5) = CLng(32)  
        m_l2Power(6) = CLng(64)  
        m_l2Power(7) = CLng(128)  
        m_l2Power(8) = CLng(256)  
        m_l2Power(9) = CLng(512)  
        m_l2Power(10) = CLng(1024)  
        m_l2Power(11) = CLng(2048)  
        m_l2Power(12) = CLng(4096)  
        m_l2Power(13) = CLng(8192)  
        m_l2Power(14) = CLng(16384)  
        m_l2Power(15) = CLng(32768)  
        m_l2Power(16) = CLng(65536)  
        m_l2Power(17) = CLng(131072)  
        m_l2Power(18) = CLng(262144)  
        m_l2Power(19) = CLng(524288)  
        m_l2Power(20) = CLng(1048576)  
        m_l2Power(21) = CLng(2097152)  
        m_l2Power(22) = CLng(4194304)  
        m_l2Power(23) = CLng(8388608)  
        m_l2Power(24) = CLng(16777216)  
        m_l2Power(25) = CLng(33554432)  
        m_l2Power(26) = CLng(67108864)  
        m_l2Power(27) = CLng(134217728)  
        m_l2Power(28) = CLng(268435456)  
        m_l2Power(29) = CLng(536870912)  
        m_l2Power(30) = CLng(1073741824)  
        Dim x  
        Dim k  
        Dim AA  
        Dim BB  
        Dim CC  
        Dim DD  
        Dim a  
        Dim b  
        Dim c  
        Dim d  
        Const S11 = 7  
        Const S12 = 12  
        Const S13 = 17  
        Const S14 = 22  
        Const S21 = 5  
        Const S22 = 9  
        Const S23 = 14  
        Const S24 = 20  
        Const S31 = 4  
        Const S32 = 11  
        Const S33 = 16  
        Const S34 = 23  
        Const S41 = 6  
        Const S42 = 10  
        Const S43 = 15  
        Const S44 = 21  
        x = ConvertToWordArray(str2bin(sMessage))  
        a = &H67452301  
        b = &HEFCDAB89  
        c = &H98BADCFE  
        d = &H10325476  
        For k = 0 To UBound(x) Step 16  
            AA = a  
            BB = b  
            CC = c  
            DD = d  
            md5_FF a, b, c, d, x(k + 0), S11, &HD76AA478  
            md5_FF d, a, b, c, x(k + 1), S12, &HE8C7B756  
            md5_FF c, d, a, b, x(k + 2), S13, &H242070DB  
            md5_FF b, c, d, a, x(k + 3), S14, &HC1BDCEEE  
            md5_FF a, b, c, d, x(k + 4), S11, &HF57C0FAF  
            md5_FF d, a, b, c, x(k + 5), S12, &H4787C62A  
            md5_FF c, d, a, b, x(k + 6), S13, &HA8304613  
            md5_FF b, c, d, a, x(k + 7), S14, &HFD469501  
            md5_FF a, b, c, d, x(k + 8), S11, &H698098D8  
            md5_FF d, a, b, c, x(k + 9), S12, &H8B44F7AF  
            md5_FF c, d, a, b, x(k + 10), S13, &HFFFF5BB1  
            md5_FF b, c, d, a, x(k + 11), S14, &H895CD7BE  
            md5_FF a, b, c, d, x(k + 12), S11, &H6B901122  
            md5_FF d, a, b, c, x(k + 13), S12, &HFD987193  
            md5_FF c, d, a, b, x(k + 14), S13, &HA679438E  
            md5_FF b, c, d, a, x(k + 15), S14, &H49B40821  
            md5_GG a, b, c, d, x(k + 1), S21, &HF61E2562  
            md5_GG d, a, b, c, x(k + 6), S22, &HC040B340  
            md5_GG c, d, a, b, x(k + 11), S23, &H265E5A51  
            md5_GG b, c, d, a, x(k + 0), S24, &HE9B6C7AA  
            md5_GG a, b, c, d, x(k + 5), S21, &HD62F105D  
            md5_GG d, a, b, c, x(k + 10), S22, &H2441453  
            md5_GG c, d, a, b, x(k + 15), S23, &HD8A1E681  
            md5_GG b, c, d, a, x(k + 4), S24, &HE7D3FBC8  
            md5_GG a, b, c, d, x(k + 9), S21, &H21E1CDE6  
            md5_GG d, a, b, c, x(k + 14), S22, &HC33707D6  
            md5_GG c, d, a, b, x(k + 3), S23, &HF4D50D87  
            md5_GG b, c, d, a, x(k + 8), S24, &H455A14ED  
            md5_GG a, b, c, d, x(k + 13), S21, &HA9E3E905  
            md5_GG d, a, b, c, x(k + 2), S22, &HFCEFA3F8  
            md5_GG c, d, a, b, x(k + 7), S23, &H676F02D9  
            md5_GG b, c, d, a, x(k + 12), S24, &H8D2A4C8A  
            md5_HH a, b, c, d, x(k + 5), S31, &HFFFA3942  
            md5_HH d, a, b, c, x(k + 8), S32, &H8771F681  
            md5_HH c, d, a, b, x(k + 11), S33, &H6D9D6122  
            md5_HH b, c, d, a, x(k + 14), S34, &HFDE5380C  
            md5_HH a, b, c, d, x(k + 1), S31, &HA4BEEA44  
            md5_HH d, a, b, c, x(k + 4), S32, &H4BDECFA9  
            md5_HH c, d, a, b, x(k + 7), S33, &HF6BB4B60  
            md5_HH b, c, d, a, x(k + 10), S34, &HBEBFBC70  
            md5_HH a, b, c, d, x(k + 13), S31, &H289B7EC6  
            md5_HH d, a, b, c, x(k + 0), S32, &HEAA127FA  
            md5_HH c, d, a, b, x(k + 3), S33, &HD4EF3085  
            md5_HH b, c, d, a, x(k + 6), S34, &H4881D05  
            md5_HH a, b, c, d, x(k + 9), S31, &HD9D4D039  
            md5_HH d, a, b, c, x(k + 12), S32, &HE6DB99E5  
            md5_HH c, d, a, b, x(k + 15), S33, &H1FA27CF8  
            md5_HH b, c, d, a, x(k + 2), S34, &HC4AC5665  
            md5_II a, b, c, d, x(k + 0), S41, &HF4292244  
            md5_II d, a, b, c, x(k + 7), S42, &H432AFF97  
            md5_II c, d, a, b, x(k + 14), S43, &HAB9423A7  
            md5_II b, c, d, a, x(k + 5), S44, &HFC93A039  
            md5_II a, b, c, d, x(k + 12), S41, &H655B59C3  
            md5_II d, a, b, c, x(k + 3), S42, &H8F0CCC92  
            md5_II c, d, a, b, x(k + 10), S43, &HFFEFF47D  
            md5_II b, c, d, a, x(k + 1), S44, &H85845DD1  
            md5_II a, b, c, d, x(k + 8), S41, &H6FA87E4F  
            md5_II d, a, b, c, x(k + 15), S42, &HFE2CE6E0  
            md5_II c, d, a, b, x(k + 6), S43, &HA3014314  
            md5_II b, c, d, a, x(k + 13), S44, &H4E0811A1  
            md5_II a, b, c, d, x(k + 4), S41, &HF7537E82  
            md5_II d, a, b, c, x(k + 11), S42, &HBD3AF235  
            md5_II c, d, a, b, x(k + 2), S43, &H2AD7D2BB  
            md5_II b, c, d, a, x(k + 9), S44, &HEB86D391  
            a = AddUnsigned(a, AA)  
            b = AddUnsigned(b, BB)  
            c = AddUnsigned(c, CC)  
            d = AddUnsigned(d, DD)  
        Next 
        MD5 = LCase(WordToHex(a) & WordToHex(b) & WordToHex(c) & WordToHex(d))  
    End Function
end class
%>