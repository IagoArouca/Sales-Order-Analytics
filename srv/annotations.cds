using SalesService as service from './service';


annotate service.SalesOrders with @(
    Aggregation.ApplySupported: {
        Transformations: [
            'aggregate',
            'groupby',
            'filter'
        ],
        GroupableProperties: [
            orderNumber,
            customerID,
            productID,
            status,
            deliveryMonth
        ],
        AggregatableProperties: [{
            Property: netAmount,
            SupportedAggregationMethods: ['sum']
        }]
    },

    Analytics.AggregatedProperty #TotalNetAmount: {
        Name: 'TotalNetAmount',
        AggregationMethod: 'sum',
        AggregatableProperty: netAmount,
        ![@Common.Label]: 'Total Net Amount'
    }
);

annotate service.SalesOrders:netAmount with @(
    Analytics.Measure: true,
    Aggregation.default: #sum
);


annotate service.SalesOrders with @(
    UI.SelectionFields: [
        customerID,
        productID,
        deliveryMonth,
        status
    ],

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

    UI.DataPoint #ChartColorLogic: {
        Value: netAmount,
        Criticality: amountCriticality
    }
);


annotate service.SalesOrders with @(
    UI.SelectionVariant #TotalRevenueSV: {
        Text: 'Revenue Global',
        SelectOptions: [{
            PropertyName: netAmount,
            Ranges: [{
                Sign: #I,
                Option: #GE,
                Low: '0'
            }]
        }]
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
    }
);


annotate service.SalesOrders with @(
    UI.Chart #MainChart: {
        ChartType: #Bar,
        Dimensions: [productID],
        Measures: [netAmount],
        MeasureAttributes: [{
            Measure: netAmount,
            Role: #Axis1,
            DataPoint: '@UI.DataPoint#ChartColorLogic'
        }]
    },

    UI.LineItem: [
        { Value: orderNumber, Label: 'Order Number' },
        { Value: deliveryMonth, Label: 'Delivery Month' },
        { Value: customerID, Label: 'Customer' },
        { Value: productID, Label: 'Product' },
        { Value: netAmount, Label: 'Net Amount' },
        { Value: status, Label: 'Status' }
    ],

    UI.PresentationVariant #MainChartPV: {
        Text: 'Sales Analysis',
        Visualizations: [
            '@UI.Chart#MainChart',
            '@UI.LineItem'
        ]
    }
);

annotate service.SalesOrders with @(
    UI.Chart #FilterByMonth: {
        ChartType: #Line,
        Dimensions: [deliveryMonth],
        Measures: [netAmount],
        MeasureAttributes: [{
            Measure: netAmount,
            Role: #Axis1
        }]
    },

    UI.Chart #FilterByCustomer: {
        ChartType: #Bar,
        Dimensions: [customerID],
        Measures: [netAmount],
        MeasureAttributes: [{
            Measure: netAmount,
            Role: #Axis1
        }]
    },

    UI.Chart #FilterByProduct: {
        ChartType: #Bar,
        Dimensions: [productID],
        Measures: [netAmount],
        MeasureAttributes: [{
            Measure: netAmount,
            Role: #Axis1
        }]
    },

    UI.PresentationVariant #PV_FilterMonth: {
        Visualizations: ['@UI.Chart#FilterByMonth']
    },

    UI.PresentationVariant #PV_FilterCustomer: {
        Visualizations: ['@UI.Chart#FilterByCustomer']
    },

    UI.PresentationVariant #PV_FilterProduct: {
        Visualizations: ['@UI.Chart#FilterByProduct']
    }
);


annotate service.SalesOrders {
    productID @(
        Common.ValueList: {
            Label: 'Product',
            CollectionPath: 'Products',
            PresentationVariantQualifier: 'PV_FilterProduct',
            Parameters: [{
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: productID,
                ValueListProperty: 'ID'
            }]
        }
    );

    customerID @(
        Common.ValueList: {
            Label: 'Customer',
            CollectionPath: 'Customers',
            PresentationVariantQualifier: 'PV_FilterCustomer',
            Parameters: [{
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: customerID,
                ValueListProperty: 'ID'
            }]
        }
    );

    deliveryMonth @(
        Common.ValueList: {
            Label: 'Delivery Month',
            CollectionPath: 'SalesOrders',
            PresentationVariantQualifier: 'PV_FilterMonth',
            Parameters: [{
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: deliveryMonth,
                ValueListProperty: 'deliveryMonth'
            }]
        }
    );
};


annotate service.SalesOrders with @(
    UI.HeaderInfo: {
        TypeName: 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title: { Value: orderNumber },
        Description: { Value: customerID }
    },

    UI.DataPoint #HeaderNet: {
        Value: netAmount,
        Title: 'Net Amount'
    },

    UI.HeaderFacets: [{
        $Type: 'UI.ReferenceFacet',
        Label: 'Financial Summary',
        Target: '@UI.DataPoint#HeaderNet'
    }],

    UI.FieldGroup #DetailForm: {
        Data: [
            { Value: orderNumber },
            { Value: customerID },
            { Value: productID },
            { Value: netAmount },
            { Value: deliveryMonth },
            { Value: status }
        ]
    },

    UI.Facets: [{
        $Type: 'UI.ReferenceFacet',
        Label: 'General Information',
        ID: 'GeneralInfo',
        Target: '@UI.FieldGroup#DetailForm'
    }]
);