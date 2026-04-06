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
    entity SalesOrders as projection on my.SalesOrders {
        *,

        product.ID as product,
        customer.ID as customer,
        case
            when netAmount >= 400000 then 3
            else 1
        end as amountCriticality : Integer
    }
}

annotate SalesService.SalesOrders with @(
    Aggregation.CustomAggregate #netAmount: 'SUM',
    Aggregation.ApplySupported: {
        AggregatableProperties: [{ Property: netAmount }]
    },
    Common.SemanticKey: [orderNumber]
);