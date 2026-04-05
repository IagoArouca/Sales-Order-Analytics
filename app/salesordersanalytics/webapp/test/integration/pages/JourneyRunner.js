sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"sap/cap/sales/salesordersanalytics/test/integration/pages/SalesOrdersList",
	"sap/cap/sales/salesordersanalytics/test/integration/pages/SalesOrdersObjectPage"
], function (JourneyRunner, SalesOrdersList, SalesOrdersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('sap/cap/sales/salesordersanalytics') + '/test/flp.html#app-preview',
        pages: {
			onTheSalesOrdersList: SalesOrdersList,
			onTheSalesOrdersObjectPage: SalesOrdersObjectPage
        },
        async: true
    });

    return runner;
});

