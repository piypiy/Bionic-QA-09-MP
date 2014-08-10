function Main()
{
  try
  {
    LaunchingApp()
    NewOrder()
    EditOrder()
    DeleteOrder()
    ClosingApp() 
  }
  catch(exception)
  {
    Log.Error("Exception", exception.description);
  }
}


    // Launching App
function LaunchingApp()
{
  TestedApps.Orders.Run();
}



    // Creating orders
function NewOrder()
{
  var  orders;
  var  mainForm;
  var  orderForm;
  var  groupBox;
  var  textBox;
  
  orders = Aliases.Orders;
  mainForm = orders.MainForm;
  mainForm.Click();
  
  var driver = DDT.CSVDriver(Files.FileNameByName("orders_entries.txt"));  
  while (!driver.EOF()) {
  
  Log.AppendFolder(driver.Value(0));
  //preconditions
  mainForm.OrdersView.Keys("^[Ins]");
  orderForm = orders.OrderForm;
  groupBox = orderForm.Group;
  //steps
  textBox = groupBox.Customer;
  textBox.Click();
  textBox.wText = driver.Value(0);
  textBox = groupBox.Street;
  textBox.Click();
  textBox.wText = driver.Value(1);
  textBox = groupBox.City;
  textBox.Click();
  textBox.wText = driver.Value(2);
  textBox = groupBox.State;
  textBox.Click();
  textBox.wText = driver.Value(3);
  textBox = groupBox.Zip;
  textBox.Click();
  textBox.wText = driver.Value(4);
  textBox = groupBox.CardNo;
  textBox.Click();
  textBox.wText = driver.Value(5);
  orderForm.ButtonOK.ClickButton();  
  //verification
  aqObject.CompareProperty(Aliases.Orders.MainForm.OrdersView.wSelectedItems, cmpEqual, driver.Value(0), false);
  Log.PopLogFolder();
  driver.Next();
  }
  DDT.CloseDriver("driver");
}



    // Editing orders
function EditOrder()
{
  var  listView;
  var  orderForm;
  var  groupBox;
  
  //preconditions
  for (i=0;i<=4;i++){  //0..4 - всего 5 строк в списке
   Aliases.Orders.MainForm.OrdersView.SelectItem(i); 
  listView = Aliases.Orders.MainForm.OrdersView;
  listView.Keys("^e");
  orderForm = Aliases.Orders.OrderForm;
  groupBox = orderForm.Group;
  //steps
  groupBox.ProductNames.Keys("[Tab]");
  groupBox.Quantity.Keys("[Tab]");
  groupBox.Price.Keys("[Tab]");
  groupBox.Discount.Keys("[Tab]");
  groupBox.groupBox1.Total.Keys("[Tab]");
  groupBox.Date.Keys("[Tab]");
  groupBox.Customer.wText = "Proxor";
  orderForm.ButtonOK.ClickButton();
  //verification
  aqObject.CompareProperty(Aliases.Orders.MainForm.OrdersView.wSelectedItems, cmpEqual, "Proxor", false);
  }
}



    // Deleting orders
function DeleteOrder()
{
  var  orders;
  var  listView;
  var  btnYes;
  
  orders = Aliases.Orders;
  listView = orders.MainForm.OrdersView;
  listView.FocusItem(0);
  for (i=0;i<=4;i++){  //0..4 - всего 5 строк в списке
  listView.Keys("[Del]");
  btnYes = orders.dlgConfirmation.btnYes;
  btnYes.Keys("[Enter]");
  }
}



    // Closing App
function ClosingApp()
{
  var  orders;
  var  dlgConfirmation;
  
  orders = Aliases.Orders;
  orders.MainForm.OrdersView.Keys("~[F4]");
  dlgConfirmation = orders.dlgConfirmation;
  dlgConfirmation.btnYes.Keys("[Right]");
  dlgConfirmation.btnNo.Keys("[Enter]");
}