<table class="ctable" border="0" cellspacing="0" cellpadding="2">


    <tr>
        <td></td>
        <td valign="top"><b>Покупець</b></td>
        <td colspan="5">{{customer_name}}</td>
    </tr>
    {{#isfirm}}
    <tr>
        <td></td>

        <td valign="top"><b>Продавец</b></td>
        <td colspan="5">{{firm_name}}</td>

    </tr>
    {{/isfirm}}
    {{#iscontract}}
    <tr>

        <td></td>

        <td valign="top"><b>Угода</b></td>
        <td colspan="5">{{contract}} вiд {{createdon}}</td>


    </tr>
    {{/iscontract}}
    <tr>
        <td></td>
        <td valign="top"><b>Зписано з</b></td>
        <td colspan="5">{{store_name}}</td>
    </tr>

    {{#order}}
    <tr>
        <td></td>
        <td><b>Замовлення</b></td>
        <td colspan="5">{{order}}</td>
    </tr>
    {{/order}}


    <tr>
        <td style="font-weight: bolder;font-size: larger;" align="center" colspan="7" valign="middle">
            Накладна № {{document_number}} від {{date}} <br>
        </td>
    </tr>

    <tr style="font-weight: bolder;">
        <th style="border-top:1px #000 solid;border-bottom:1px #000 solid;" width="30">№</th>
        <th style="border-top:1px #000 solid;border-bottom:1px #000 solid;text-align: left;">Найменування</th>
        <th style="border-top:1px #000 solid;border-bottom:1px #000 solid;text-align: left;">Код</th>
        <th style="border-top:1px #000 solid;border-bottom:1px #000 solid;">Од.</th>

        <th style="text-align: right;border-top:1px #000 solid;border-bottom:1px #000 solid;" width="60">Кіл.</th>
        <th style="text-align: right;border-top:1px #000 solid;border-bottom:1px #000 solid;" width="60">Ціна</th>
        <th style="text-align: right;border-top:1px #000 solid;border-bottom:1px #000 solid;" width="80">Сума</th>
    </tr>
    {{#_detail}}
    <tr>
        <td align="right">{{no}}</td>
        <td>{{tovar_name}}</td>
        <td>{{tovar_code}}</td>
        <td>{{msr}}</td>

        <td align="right">{{quantity}}</td>
        <td align="right">{{price}}</td>
        <td align="right">{{amount}}</td>
    </tr>
    {{/_detail}}
    <tr style="font-weight: bolder;">
        <td style="border-top:1px #000 solid;" colspan="2">{{weight}}</td>

        <td style="border-top:1px #000 solid;" colspan="4" align="right">Разом:</td>
        <td style="border-top:1px #000 solid;" align="right">{{total}}</td>
    </tr>

    {{^prepaid}}
    {{#isdisc}}
    <tr style="font-weight: bolder;">
        <td colspan="6" align="right">Знижка:</td>
        <td align="right">{{paydisc}}</td>
    </tr>
    {{/isdisc}}


    <tr style="font-weight: bolder;">

        <td colspan="6" align="right">До оплати:</td>
        <td align="right">{{payamount}}</td>
    </tr>
    <tr style="font-weight: bolder;">
        <td colspan="6" align="right">Оплата:</td>
        <td align="right">{{payed}}</td>
    </tr>
    {{/prepaid}}
    <tr>
        <td colspan="7">На суму <b>{{totalstr}}<b></td>

    </tr>
  <tr>
        <td colspan="4" > 
            Продавець ___________
        </td>
  <td colspan="3"> 
           Покупець ___________
        </td>

    </tr>
  <tr>
         <td> </td>
        <td colspan="6">
        <br><br>
  &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;    &nbsp; МП
        <br><br>
        </td>
        

    </tr>

</table>

