INSERT INTO `metadata` ( `meta_type`, `description`, `meta_name`, `menugroup`, `disabled`) VALUES( 5, '��� �������', 'ARMFood', '�������', 0);
INSERT INTO `metadata` ( `meta_type`, `description`, `meta_name`, `menugroup`, `disabled`)  VALUES( 1, '�����', 'OrderFood', '�������', 0);
INSERT INTO `metadata` ( `meta_type`, `description`, `meta_name`, `menugroup`, `disabled`)  VALUES( 3, '������ ������� (�������)', 'OrderFoodList', '', 0);

ALTER TABLE `paylist` CHANGE `paydate` `paydate` DATETIME NULL DEFAULT NULL;
