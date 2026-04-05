using SalesService as service from './service';

annotate service.SalesOrders with @Aggregation.ApplySupported: {
    Transformations: [ 'aggregate', 'groupby', 'filter' ],
    GroupableProperties: [ ID, orderNumber, product, customer, status, deliveryMonth ],
    AggregatableProperties: [{ Property: netAmount }]
};

annotate service.SalesOrders with @(
    UI.SelectionFields: [ customer, product, status, deliveryMonth ],


    UI.Chart #MainChart: {
        ChartType: #Bar,
        Dimensions: [ product ],
        Measures: [ netAmount ],
        MeasureAttributes: [{
            Measure: netAmount,
            Role: #Axis1
        }]
    },

    UI.DataPoint #TotalRevenueDP: {
        Value: netAmount,
        Title: 'Receita Total',
        Trend: #Up,
        Criticality: #Positive
    },

    UI.SelectionVariant #TotalRevenueSV: {
        Text: 'Receita Global',
        SelectOptions: [{
            PropertyName: netAmount,
            Ranges: [{ Sign: #I, Option: #GT, Low: '0' }]
        }]
    },


    UI.LineItem: [
        { 
            $Type: 'UI.DataFieldWithNavigation', 
            Value: orderNumber, 
            Label: 'Pedido',
            Target: 'SalesOrdersObjectPage' 
        },
        { Value: ID, Label: 'ID', Visible: false },
        { Value: orderNumber, Label: 'Número do Pedido' },
        { Value: deliveryMonth, Label: 'Mês de Entrega' },
        { Value: customer, Label: 'Cliente' },
        { Value: product, Label: 'Produto' },
        { Value: netAmount, Label: 'Valor Líquido' },
        { Value: status, Label: 'Status', Criticality: #Positive }
    ],

    UI.PresentationVariant #MainChartPV: {
        Text: 'Análise Híbrida',
        Visualizations: [
            '@UI.Chart#MainChart',
            '@UI.LineItem'
        ]
    }
);