[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared Calendar = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Calendar", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[BindToDefaultDestination = true]
shared Customers = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Customers", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[BindToDefaultDestination = true]
shared Products = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Products", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[BindToDefaultDestination = true]
shared Sales = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "f3ac753f-280f-4299-88f5-dc2a79d64f97"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Sales", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
shared DefaultDestination = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  #"Navigation 1" = Source{[workspaceId = "bcfb9164-5015-4fdb-9737-643e40f32fbb"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "c152ef0a-da22-40d3-a539-99a30742dcda"]}[Data]
in
  #"Navigation 2";
