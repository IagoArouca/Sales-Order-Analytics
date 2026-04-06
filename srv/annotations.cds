using SalesService as service from './service';


annotate service.SalesOrders with @(
    Aggregation.ApplySupported: {
        Transformations: [ 'aggregate', 'groupby', 'filter' ],
        GroupableProperties: [ orderNumber, product, customer, status, deliveryMonth ],
        AggregatableProperties: [
            {
                Property: netAmount,
                SupportedAggregationMethods: ['sum']
            }
        ]
    },
    Aggregation.CustomAggregate #netAmount: 'SUM'
);


annotate service.SalesOrders:netAmount with @(
    UI.DataPoint #ChartColorLogic: {
        Value: netAmount,
        CriticalityCalculation: {
            ImprovementDirection: #Maximize,
            DeviationRangeLowValue: 400000,
            ToleranceRangeLowValue: 400001
        }
    }
);


annotate service.SalesOrders with @(
    UI.SelectionFields: [ customer, deliveryMonth, status ],

    UI.DataPoint #RBQ: {
        Value: netAmount,
        Title: 'RBQ'
    },
    UI.DataPoint #PBK: {
        Value: netAmount,
        Title: 'PBK'
    },
    UI.DataPoint #TQ: {
        Value: netAmount,
        Title: 'TQ'
    },
    UI.DataPoint #GBP: {
        Value: netAmount,
        Title: 'GBP'
    },
    UI.DataPoint #GAB: {
        Value: netAmount,
        Title: 'GAB'
    },

    UI.DataPoint #TotalRevenueDP: {
        Value: netAmount,
        Title: 'Total Revenue'
    },


    UI.SelectionVariant #TotalRevenueSV: {
        Text: 'Revenue Global',
        SelectOptions: [
            {
                PropertyName: netAmount,
                Ranges: [
                    {
                        Sign: #I,
                        Option: #GE,
                        Low: '0'
                    }
                ]
            }
        ]
    },

    UI.KPI #RBQ: {
        DataPoint: '@UI.DataPoint#RBQ',
        SelectionVariant: '@UI.SelectionVariant#TotalRevenueSV'
    },

    UI.KPI #PBK: {
        DataPoint: '@UI.DataPoint#PBK',
        SelectionVariant: '@UI.SelectionVariant#TotalRevenueSV'
    },

    UI.KPI #TQ: {
        DataPoint: '@UI.DataPoint#TQ',
        SelectionVariant: '@UI.SelectionVariant#TotalRevenueSV'
    },

    UI.KPI #GBP: {
        DataPoint: '@UI.DataPoint#GBP',
        SelectionVariant: '@UI.SelectionVariant#TotalRevenueSV'
    },

    UI.KPI #GAB: {
        DataPoint: '@UI.DataPoint#GAB',
        SelectionVariant: '@UI.SelectionVariant#TotalRevenueSV'
    },

    UI.Chart #FilterByMonth: {
        ChartType: #Line,
        Dimensions: [ deliveryMonth ],
        Measures: [ netAmount ],
        MeasureAttributes: [
            {
                Measure: netAmount,
                Role: #Axis1
            }
        ]
    },

    UI.PresentationVariant #PV_FilterMonth: {
        Visualizations: [ '@UI.Chart#FilterByMonth' ]
    },

    UI.Chart #FilterByCustomer: {
        ChartType: #Bar,
        Dimensions: [ customer ],
        Measures: [ netAmount ],
        MeasureAttributes: [
            {
                Measure: netAmount,
                Role: #Axis1
            }
        ]
    },

    UI.PresentationVariant #PV_FilterCustomer: {
        Visualizations: [ '@UI.Chart#FilterByCustomer' ]
    },

    UI.Chart #MainChart: {
        ChartType: #Bar,
        Dimensions: [ product ],
        Measures: [ netAmount ],
        MeasureAttributes: [
            {
                Measure: netAmount,
                Role: #Axis1,
                DataPoint: '@UI.DataPoint#ChartColorLogic'
            }
        ]
    },

    UI.LineItem: [
        { Value: orderNumber, Label: 'Pedido' },
        { Value: deliveryMonth, Label: 'Mês de Entrega' },
        { Value: customer, Label: 'Cliente' },
        { Value: product, Label: 'Produto' },
        { Value: netAmount, Label: 'Valor Líquido' },
        { Value: status, Label: 'Status', Criticality: #Positive }
    ],

    UI.PresentationVariant #MainChartPV: {
        Text: 'Análise Híbrida',
        Visualizations: [ '@UI.Chart#MainChart', '@UI.LineItem' ]
    }
);


annotate service.SalesOrders with @(
    Common.SemanticKey: [orderNumber],
    UI.Identification: [{ Value: orderNumber }]
);

annotate service.SalesOrders {
    deliveryMonth @Common.ValueList #VisualFilter: {
        Label: 'Net Amount by Month',
        CollectionPath: 'SalesOrders',
        PresentationVariantQualifier: 'PV_FilterMonth',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: deliveryMonth,
                ValueListProperty: 'deliveryMonth'
            }
        ]
    };

    customer @Common.ValueList #VisualFilter: {
        Label: 'Revenue by Customer',
        CollectionPath: 'SalesOrders',
        PresentationVariantQualifier: 'PV_FilterCustomer',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: customer,
                ValueListProperty: 'customer'
            }
        ]
    };
};


annotate service.SalesOrders with @(
    UI.HeaderInfo: {
        TypeName: 'Pedido de Venda',
        TypeNamePlural: 'Pedidos de Venda',
        Title: { Value: orderNumber },
        Description: { Value: customer }
    },

    UI.HeaderFacets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Resumo Financeiro',
            Target: '@UI.DataPoint#HeaderNet'
        }
    ],

    UI.DataPoint #HeaderNet: {
        Value: netAmount,
        Title: 'Total Líquido'
    },

    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Detalhes do Pedido',
            ID: 'GeneralInfo',
            Target: '@UI.FieldGroup#DetailForm'
        }
    ],

    UI.FieldGroup #DetailForm: {
        Data: [
            { Value: orderNumber },
            { Value: customer },
            { Value: product },
            { Value: netAmount },
            { Value: deliveryMonth },
            { Value: status }
        ]
    }
);