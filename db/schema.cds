namespace sap.cap.sales;

using { cuid, managed } from '@sap/cds/common';

entity SalesOrders : cuid, managed {
    @title : 'Número do Pedido'
    orderNumber : String(10);

    @title : 'Cliente'
    @Analytics.Dimension: true
    customer : String(100);

    @title : 'Produto'
    @Analytics.Dimension: true
    product : String(100);

    @title : 'Valor Liquido'
    @Analytics.Measure: true
    @Aggregation.default: #SUM
    netAmount : Decimal(15, 2);

    @title: 'Moeda '
    currency : String(3) default 'EUR';

    @title: 'Mês de Entrega'
    @Analytics.Dimension: true
    deliveryMonth : String(15);

    @title: 'Status'
    @Analytics.Dimension: true
    status       : String enum {
        New = 'New';
        Delivered = 'Delivered';
        InProgress = 'InProgress';
    }
}