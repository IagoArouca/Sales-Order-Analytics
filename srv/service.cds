using { sap.cap.sales as my } from '../db/schema';

service SalesService {
    @readonly
    entity SalesOrders as projection on my.SalesOrders {
        *,
        case
            when netAmount >= 400000 then 3
            else 1
        end as amountCriticality : Integer,

        customer.ID as customerID,
        product.ID as productID
    };

    @readonly entity Products as projection on my.Products;
    @readonly entity Customers as projection on my.Customers;
}