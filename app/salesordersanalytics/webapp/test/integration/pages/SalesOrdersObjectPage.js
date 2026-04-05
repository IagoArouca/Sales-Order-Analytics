sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'sap.cap.sales.salesordersanalytics',
            componentId: 'SalesOrdersObjectPage',
            contextPath: '/SalesOrders'
        },
        CustomPageDefinitions
    );
});