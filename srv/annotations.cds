using SalesService as service from './service';

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

    UI.LineItem: [
        { Value: orderNumber, Label: 'Pedido' },
        { Value: customer, Label: 'Cliente' },
        { Value: product, Label: 'Produto' },
        { Value: netAmount, Label: 'Valor Líquido' },
        { Value: deliveryMonth, Label: 'Mês' },
        { 
            Value: status, 
            Label: 'Status', 
            Criticality: #Positive 
        }
    ],

    UI.PresentationVariant #MainChartPV: {
        Text: 'Análise de Pedidos',
        Visualizations: [
            '@UI.Chart#MainChart',
            '@UI.LineItem'
        ]
    }
);