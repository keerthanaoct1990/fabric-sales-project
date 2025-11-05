[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Customers_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Customers = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null]),
  #"Navigation 1" = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "sales_data.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 4", null, true),
  #"Drill down" = #"Imported Excel workbook"{0}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Drill down", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"CustomerID", Int64.Type}, {"CustomerName", type text}, {"Email", type text}, {"Phone", type text}, {"City", type text}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Products_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Products = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null]),
  #"Navigation 1" = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "sales_data.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 4", null, true),
  #"Drill down" = #"Imported Excel workbook"{1}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Drill down", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"ProductID", Int64.Type}, {"ProductName", type text}, {"Category", type text}, {"Price", type number}})
in
  #"Changed column type";
shared Customers_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  TableNavigation = Navigation_2{[Id = "Customers", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Products_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  TableNavigation = Navigation_2{[Id = "Products", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Sales_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Sales = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null]),
  #"Navigation 1" = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "sales_data.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(#"Navigation 4", null, true),
  #"Drill down" = #"Imported Excel workbook"{2}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Drill down", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"SaleID", Int64.Type}, {"CustomerID", Int64.Type}, {"ProductID", Int64.Type}, {"TotalAmount", type number}, {"SaleDate", type date}})
in
  #"Changed column type";
shared Sales_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  TableNavigation = Navigation_2{[Id = "Sales", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
