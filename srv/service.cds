using { sap.cap.sales as my } from '../db/schema';

service SalesService {
    @readonly
    entity SalesOrders as projection on my.SalesOrders;
}