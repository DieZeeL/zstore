SET NAMES 'utf8';
   
 
INSERT INTO `users` (`user_id`, `userlogin`, `userpass`, `createdon`, `email`, `acl`, `disabled`, `options`, `role_id`) VALUES(4, 'admin', '$2y$10$GsjC.thVpQAPMQMO6b4Ma.olbIFr2KMGFz12l5/wnmxI1PEqRDQf.', '2017-01-01', 'admin@admin.admin', 'a:2:{s:9:"aclbranch";N;s:6:"onlymy";N;}', 0, 'a:6:{s:8:"defstore";s:2:"19";s:7:"deffirm";i:0;s:5:"defmf";s:1:"2";s:8:"pagesize";s:2:"15";s:11:"hidesidebar";i:0;s:8:"mainpage";s:15:"\\App\\Pages\\Main";}', 1);

INSERT INTO `roles` (`role_id`, `rolename`, `acl`) VALUES(1, 'admins', 'a:9:{s:7:"aclview";N;s:7:"acledit";N;s:6:"aclexe";N;s:9:"aclcancel";N;s:8:"aclstate";N;s:9:"acldelete";N;s:7:"widgets";N;s:7:"modules";N;s:9:"smartmenu";s:1:"8";}');

UPDATE users set  role_id=(select role_id  from roles  where  rolename='admins' limit 0,1 )  where  userlogin='admin' ;

 
INSERT  INTO `stores` (  `storename`, `description`) VALUES(  'Основний склад', '');
INSERT INTO `mfund` (`mf_id`, `mf_name`, `description`) VALUES(2, 'Каса', 'Основна каса');
INSERT INTO `firms` (  `firm_name`, `details`, `disabled`) VALUES(  'Наша  фiрма', '', 0);


INSERT INTO `options` (`optname`, `optvalue`) VALUES('common', 'a:23:{s:9:"qtydigits";s:1:"0";s:8:"amdigits";s:1:"0";s:10:"dateformat";s:5:"d.m.Y";s:11:"partiontype";s:1:"1";s:4:"curr";s:2:"gr";s:6:"phonel";s:2:"10";s:6:"price1";s:17:"�����i���";s:6:"price2";s:12:"������";s:6:"price3";s:0:"";s:6:"price4";s:0:"";s:6:"price5";s:0:"";s:8:"shopname";s:14:"�������";s:8:"ts_break";s:2:"60";s:8:"ts_start";s:5:"09:00";s:6:"ts_end";s:5:"18:00";s:11:"autoarticle";i:1;s:10:"usesnumber";i:0;s:10:"usescanner";i:0;s:9:"useimages";i:0;s:9:"usebranch";i:0;s:10:"allowminus";i:1;s:6:"useval";i:0;s:6:"capcha";i:0;}');
INSERT INTO `options` (`optname`, `optvalue`) VALUES('printer', 'a:8:{s:6:"pwidth";s:4:"100%";s:9:"pricetype";s:6:"price1";s:11:"barcodetype";s:5:"EAN13";s:9:"pfontsize";s:2:"16";s:5:"pname";i:1;s:5:"pcode";i:0;s:8:"pbarcode";i:1;s:6:"pprice";i:0;}');
INSERT INTO `options` (`optname`, `optvalue`) VALUES('shop', 'N;');
INSERT INTO `options` (`optname`, `optvalue`) VALUES('modules', 'a:11:{s:6:"ocsite";s:20:"http://local.ostore3";s:9:"ocapiname";s:5:"admin";s:5:"ockey";s:256:"Bf81dB8fY2waVxlhych4fFprGfxF2tULlSlHiwEXZqf45E6HDBoA6XjocGcziRsfCQsRovzzDAvMBImmrlzXqEJcMByQpkfeLYfZBDoYstDVuA0Qvx86YkeXVwQ6I2v8xEXS2ZL6ioH1l8qinySGZdRrO5mgFCFWKhgKxIfkNOYpvzIZdR2MdqkHKSzHGSfoDVmbts8slGNFqYzvkXQSP0VaHcw0fYmBZLo0HEvLb2EiBZ5A8EcGDZWWtndg2wlY";s:13:"occustomer_id";s:1:"8";s:11:"ocpricetype";s:6:"price1";s:6:"wcsite";s:15:"http://local.wp";s:6:"wckeyc";s:43:"ck_a36c9d5d8ef70a34001b6a44bc245a7665ca77e7";s:6:"wckeys";s:43:"cs_12b03012d9db469b45b1fc82e329a3bc995f3e36";s:5:"wcapi";s:2:"v3";s:13:"wccustomer_id";s:1:"8";s:11:"wcpricetype";s:6:"price1";}');
  
  
  
INSERT INTO `metadata` VALUES(1, 4, '������', 'StoreList', '������', 0);
INSERT INTO `metadata` VALUES(2, 4, '������������', 'ItemList', '������', 0);
INSERT INTO `metadata` VALUES(3, 4, '�����������', 'EmployeeList', '', 0);
INSERT INTO `metadata` VALUES(4, 4, '������� ������', 'CategoryList', '������', 0);
INSERT INTO `metadata` VALUES(5, 4, '�����������', 'CustomerList', '', 0);
INSERT INTO `metadata` VALUES(6, 1, '���������� ��������', 'GoodsReceipt', '�������', 0);
INSERT INTO `metadata` VALUES(7, 1, '��������� ��������', 'GoodsIssue', '������', 0);
INSERT INTO `metadata` VALUES(8, 3, '��������� ������', 'DocList', '', 0);
INSERT INTO `metadata` VALUES(10, 1, '���������� �����', 'Warranty', '������', 0);
INSERT INTO `metadata` VALUES(12, 2, '��� �� ������', 'ItemActivity', '�����', 0);
INSERT INTO `metadata` VALUES(13, 2, 'ABC �����', 'ABC', '', 0);
INSERT INTO `metadata` VALUES(14, 4, '�������, ������', 'ServiceList', '', 0);
INSERT INTO `metadata` VALUES(15, 1, '��� ��������� ����', 'ServiceAct', '�������', 0);
INSERT INTO `metadata` VALUES(16, 1, '���������� �� �������', 'ReturnIssue', '������', 0);
INSERT INTO `metadata` VALUES(18, 3, '������', 'TaskList', '', 0);
INSERT INTO `metadata` VALUES(19, 1, '�����', 'Task', '�����������', 0);
INSERT INTO `metadata` VALUES(20, 2, '������ �� ��������', 'EmpTask', '�����������', 0);
INSERT INTO `metadata` VALUES(21, 2, '�������', 'Income', '�������', 0);
INSERT INTO `metadata` VALUES(22, 2, '������', 'Outcome', '������', 0);
INSERT INTO `metadata` VALUES(27, 3, '���������� �볺���', 'OrderList', '������', 0);
INSERT INTO `metadata` VALUES(28, 1, '����������', 'Order', '������', 0);
INSERT INTO `metadata` VALUES(30, 1, '�������������� � �����������', 'ProdReceipt', '�����������', 0);
INSERT INTO `metadata` VALUES(31, 1, '�������� �� �����������', 'ProdIssue', '�����������', 0);
INSERT INTO `metadata` VALUES(32, 2, '��� �� �����������', 'Prod', '�����������', 0);
INSERT INTO `metadata` VALUES(33, 4, '��������� �������', 'ProdAreaList', '', 0);
INSERT INTO `metadata` VALUES(35, 3, '������', 'GIList', '������', 0);
INSERT INTO `metadata` VALUES(36, 4, '������ �����', 'EqList', '', 0);
INSERT INTO `metadata` VALUES(37, 3, '�������', 'GRList', '�������', 0);
INSERT INTO `metadata` VALUES(38, 1, '������ �������������', 'OrderCust', '�������', 0);
INSERT INTO `metadata` VALUES(39, 3, '������ ��������������', 'OrderCustList', '�������', 0);
INSERT INTO `metadata` VALUES(40, 2, '�����', 'Price', '�����', 0);
INSERT INTO `metadata` VALUES(41, 1, '���������� �������������', 'RetCustIssue', '�������', 0);
INSERT INTO `metadata` VALUES(44, 1, '���������������� ���', 'TransItem', '�����', 0);
INSERT INTO `metadata` VALUES(46, 4, '����, �������', 'MFList', '', 0);
INSERT INTO `metadata` VALUES(47, 3, '������ �������', 'PayList', '���� �� ������', 0);
INSERT INTO `metadata` VALUES(48, 2, '��� �� �������� ��������', 'PayActivity', '������', 0);
INSERT INTO `metadata` VALUES(50, 1, '����������� �����', 'IncomeMoney', '������', 0);
INSERT INTO `metadata` VALUES(51, 1, '���������� �����', 'OutcomeMoney', '������', 0);
INSERT INTO `metadata` VALUES(53, 2, '�������� ������', 'PayBalance', '������', 0);
INSERT INTO `metadata` VALUES(57, 1, '��������������', 'Inventory', '�����', 0);
INSERT INTO `metadata` VALUES(58, 1, '�������, �������', 'InvoiceCust', '�������', 0);
INSERT INTO `metadata` VALUES(59, 1, '�������-�������', 'Invoice', '������', 0);
INSERT INTO `metadata` VALUES(60, 5, '������', 'Import', '', 0);
INSERT INTO `metadata` VALUES(61, 3, '��� ���', 'StockList', '�����', 0);
INSERT INTO `metadata` VALUES(62, 1, '������� ���', 'POSCheck', '������', 1);
INSERT INTO `metadata` VALUES(63, 2, '������ � �����', 'CustOrder', '�������', 0);
INSERT INTO `metadata` VALUES(64, 1, '�������� ���', 'OutcomeItem', '�����', 0);
INSERT INTO `metadata` VALUES(65, 1, '�������������� ���', 'IncomeItem', '�����', 0);
INSERT INTO `metadata` VALUES(67, 5, '��� ������', 'ARMPos', '', 0);
INSERT INTO `metadata` VALUES(69, 3, '������, �������', 'SerList', '', 0);
INSERT INTO `metadata` VALUES(70, 3, '���������� � �������������', 'PayCustList', '���� �� ������', 0);
INSERT INTO `metadata` VALUES(71, 3, '������ �� �����', 'ItemList', '�����', 0);
INSERT INTO `metadata` VALUES(75, 5, '�������', 'Export', '', 0);
INSERT INTO `metadata` VALUES(76, 1, '������� ��������', 'OutSalary', '������', 0);
INSERT INTO `metadata` VALUES(77, 2, '��� ��  �������', 'SalaryRep', '������', 0);
INSERT INTO `metadata` VALUES(78, 2, '��� ��  ������������', 'CustActivity', '������', 0);
INSERT INTO `metadata` VALUES(79, 4, '���������', 'ContractList', '', 0);
INSERT INTO `metadata` VALUES(80, 1, '�����i����� ���', 'MoveItem', '�����', 0);
INSERT INTO `metadata` VALUES(81, 2, '������� ���', 'Timestat', '', 0);

