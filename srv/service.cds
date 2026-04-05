using { sap.cap.sales as my } from '../db/schema';

service SalesService {
    @readonly
    @Aggregation.ApplySupported: {
        Transformations: [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'expand',
            'search'
        ],
        Rollup: #None,
        PropertyRestrictions: true
    }
    entity SalesOrders as projection on my.SalesOrders;
}

annotate SalesService.SalesOrders with @(
    Aggregation.CustomAggregate #netAmount: 'SUM',
    Common.SemanticKey: [orderNumber]
);