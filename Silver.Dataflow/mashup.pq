[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Customers_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Customers = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Customers", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"Phone"})
in
  #"Removed columns";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Products_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Products = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Products", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Sales_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Sales = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "fd763745-6639-4e14-a0be-aa6e3eba4c08"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Sales", ItemKind = "Table"]}[Data],
  #"Sorted rows" = Table.Sort(#"Navigation 2", {{"SaleDate", Order.Descending}})
in
  #"Sorted rows";
shared Sales_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  TableNavigation = Navigation_2{[Id = "Sales", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Products_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  TableNavigation = Navigation_2{[Id = "Products", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared Customers_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  TableNavigation = Navigation_2{[Id = "Customers", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Calendar_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Calendar = let
    // Define the start and end dates for the calendar
    StartDate = #date(2024, 6, 14),
    EndDate = #date(2025, 6, 14),
    
    // Create a list of dates between start and end dates
    DateList = List.Dates(StartDate, Duration.Days(EndDate - StartDate) + 1, #duration(1, 0, 0, 0)),
    
    // Convert the list to a table
    DateTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),

    // Add useful columns
    AddYear = Table.AddColumn(DateTable, "Year", each Date.Year([Date]), Int64.Type),
    AddMonth = Table.AddColumn(AddYear, "Month", each Date.Month([Date]), Int64.Type),
    AddMonthName = Table.AddColumn(AddMonth, "Month Name", each Date.ToText([Date], "MMMM"), type text),
    AddMonthShort = Table.AddColumn(AddMonthName, "Month Short", each Date.ToText([Date], "MMM"), type text),
    AddQuarter = Table.AddColumn(AddMonthShort, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    AddDay = Table.AddColumn(AddQuarter, "Day", each Date.Day([Date]), Int64.Type),
    AddDayOfWeek = Table.AddColumn(AddDay, "Day of Week", each Date.DayOfWeek([Date]), Int64.Type),
    AddDayName = Table.AddColumn(AddDayOfWeek, "Day Name", each Date.ToText([Date], "dddd"), type text),
    AddWeekOfYear = Table.AddColumn(AddDayName, "Week of Year", each Date.WeekOfYear([Date]), Int64.Type),
    AddIsWeekend = Table.AddColumn(AddWeekOfYear, "Is Weekend", each if Date.DayOfWeek([Date]) >= 5 then true else false, type logical),
  #"Changed column type" = Table.TransformColumnTypes(AddIsWeekend, {{"Date", type date}})
in
    #"Changed column type";
shared Calendar_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  TableNavigation = Navigation_2{[Id = "Calendar", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
