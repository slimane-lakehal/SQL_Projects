USE WideWorldImporters;
GO

CREATE SCHEMA OLTP;
GO
--orders
SELECT [OrderID]
      ,[CustomerID]
      ,[SalespersonPersonID]
      ,[OrderDate]
      ,[ExpectedDeliveryDate]
      ,[CustomerPurchaseOrderNumber]
      ,[PickingCompletedWhen]
  FROM [WideWorldImporters].[Sales].[Orders];
GO
--Orderitems
SELECT [OrderLineID]
      ,[OrderID]
      ,[StockItemID]
      ,[PackageTypeID]
      ,[Quantity]
      ,[UnitPrice]
      ,[TaxRate]
      ,[PickedQuantity]
      ,[PickingCompletedWhen]
  FROM [WideWorldImporters].[Sales].[OrderLines];
GO
--ProductCategory
SELECT si.StockItemID
      ,sg.StockGroupName
  FROM [WideWorldImporters].[Warehouse].[StockGroups] AS sg
  RIGHT JOIN [WideWorldImporters].[Warehouse].[StockItemStockGroups] si
  ON sg.StockGroupID = si.StockGroupID;
GO
--Stock
SELECT [StockItemID]
      ,[QuantityOnHand]
      ,[LastStocktakeQuantity]
      ,[LastCostPrice]
      ,[ReorderLevel]
      ,[TargetStockLevel]
  FROM [WideWorldImporters].[Warehouse].[StockItemHoldings];
GO
--Products
SELECT [StockItemID]
      ,[StockItemName]
      ,[SupplierID]
      ,[TaxRate]
      ,[UnitPrice]
      ,[RecommendedRetailPrice]
      ,[TypicalWeightPerUnit]
      ,[IsChillerStock]
      , JSON_VALUE([CustomFields], '$.CountryOfManufacture') AS CountryOfManufacture
      ,[Tags]
  FROM [WideWorldImporters].[Warehouse].[StockItems];
GO

--Customers
SELECT [CustomerID]
    ,[CustomerName]
    ,[BillToCustomerID]
    ,[CustomerCategoryID]
    ,[BuyingGroupID]
    ,[DeliveryMethodID]
    ,[DeliveryCityID]
    ,[CreditLimit]
    ,[AccountOpenedDate]
    ,[DeliveryPostalCode]
  FROM [WideWorldImporters].[Sales].[Customers];
GO

--CustomersCategories
SELECT [CustomerCategoryID]
      ,[CustomerCategoryName]
  FROM [WideWorldImporters].[Sales].[CustomerCategories];
GO

--BuyingGroups
SELECT [BuyingGroupID]
    ,[BuyingGroupName]
  FROM [WideWorldImporters].[Sales].[BuyingGroups];
GO

--Invoices
SELECT [InvoiceID]
      ,[CustomerID]
      ,[BillToCustomerID]
      ,[OrderID]
      ,[DeliveryMethodID]
      ,[ContactPersonID]
      ,[AccountsPersonID]
      ,[SalespersonPersonID]
      ,[PackedByPersonID]
      ,[InvoiceDate]
      ,[TotalDryItems]
      ,[TotalChillerItems]
      ,[DeliveryRun]
      ,[ConfirmedDeliveryTime]
      ,[ConfirmedReceivedBy]
  FROM [WideWorldImporters].[Sales].[Invoices];
GO

--InvoicesDetail
SELECT [InvoiceLineID]
      ,[InvoiceID]
      ,[StockItemID]
      ,[Quantity]
      ,[UnitPrice]
      ,[TaxRate]
      ,[TaxAmount]
      ,[LineProfit]
      ,[ExtendedPrice]
  FROM [WideWorldImporters].[Sales].[InvoiceLines];
GO

--Transactions
SELECT [CustomerTransactionID]
      ,[CustomerID]
      ,[TransactionTypeID]
      ,[InvoiceID]
      ,[TransactionDate]
      ,[AmountExcludingTax]
      ,[TaxAmount]
      ,[TransactionAmount]
      ,[OutstandingBalance]
      ,[FinalizationDate]
      ,[IsFinalized]
  FROM [WideWorldImporters].[Sales].[CustomerTransactions];
GO


