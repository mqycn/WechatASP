<%
	set pay = new WeChatPay
	
	'����֧��������Ҳ����ֱ���޸� WeChatPay.asp
	pay.AppID       = "AppID"
	pay.AppSecret   = "App����"
	'pay.orderAPI    = "" '�������û����������ã����������û����޸�Ϊ proxy ��������ַ������http://��
	pay.MchID       = "�̻�ID"
	pay.MchKey      = "�̻�API��Կ" '�� ΢��֧����̨ \ �ʻ����� \ API��ȫ������ API��Կ ������
	pay.CertName    = "MMPay" '���̻����޸�Ϊ�̻�ID�����̻����������ο���http://www.miaoqiyuan.cn/p/winhttpcertcfg-mmpay
	'pay.notifyUrl   = ""	'����д����ɹ����֪ͨ�ű���wxapi.asp��������·��������http://���������װĿ¼����ʾ����һ�¿��Բ������ã���װ��/order/Ŀ¼���������Զ�ʶ��
%>