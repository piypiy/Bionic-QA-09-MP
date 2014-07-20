function Main()
{
  try
  {
    Summ();
    Mult(); 
  }
  catch(exception)
  {
    Log.Error("Exception", exception.description);
  }
}

function Summ()
{
  TestedApps.calc.Run();
  Aliases.calc.wndCalculator.btn2.ClickButton();
  Aliases.calc.wndCalculator.btn.ClickButton();
  Aliases.calc.wndCalculator.btn2.ClickButton();
  Aliases.calc.wndCalculator.btn1.ClickButton();
  aqObject.CompareProperty(Aliases.calc.wndCalculator.Edit.wText, 0, "5. ", false);
  Aliases.calc.wndCalculator.Close();
}

function Mult()
{
  var  wndCalculator;
  TestedApps.calc.Run();
  wndCalculator = Aliases.calc.wndCalculator;
  wndCalculator.btn3.ClickButton();
  wndCalculator.btn5.ClickButton();
  wndCalculator.btn4.DblClick(19, 12);
  wndCalculator.btn1.ClickButton();
  aqObject.CompareProperty(Aliases.calc.wndCalculator.Edit.wText, cmpEqual, "132. ", false);
  wndCalculator.Close();
}
