namespace sap.cap.sales;

using { cuid, managed } from '@sap/cds/common';

@cds.autoexpose
entity Customers {
    key ID  : String(100) @title : 'ID Cliente';
    name    : String(100);
}

@cds.autoexpose
entity Products {
    key ID  : String(100) @title : 'ID Produto';
    name    : String(100);
}

entity SalesOrders : cuid, managed {
    @title : 'Número do Pedido'
    orderNumber : String(10);

    @title : 'Cliente'
    @Analytics.Dimension: true
    customer : Association to Customers;

    @title : 'Produto'
    @Analytics.Dimension: true
    product : Association to Products;

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