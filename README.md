#WechatASP

**����˵����**

**1����������**

��IIS�н���ǰĿ¼����Ϊվ���Ŀ¼

**2���������**

2.1���ύ����ҳ����
```
http://IP/order/index.asp
```
2.2��΢��֧������
```
http://IP/order/pay.asp?order_no=201721415151254913
```

2.3��������ɲ���
```
http://IP/order/info.asp?order_no=201721415201355214
```

**3���޸�˵��**

�� /order/payconfig.asp ���޸�֧���������ɣ��ǵð�ǰ�ߵ� ' ��ɾ��Ŷ~

```
	'����֧��������Ҳ����ֱ���޸� WeChatPay.asp
	'pay.AppID       = "AppID"
	'pay.AppSecret   = "App����"
	'pay.MchID       = "�̻�ID"
	'pay.MchKey      = "�̻�����"
	'pay.notifyUrl   = ""	'notifyUrl��ָ��������Զ����ݵ�ǰ�����ж�
```