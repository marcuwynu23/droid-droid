namespace DroidDroid
{

	class DroidDroidProgram
	{
		public string SCRIPT_FOLDER = @"script/";
		public string CMD_NAME = @"DroidDroid.bat";
		
		public void Run()
		{
			System.Diagnostics.Process.Start(SCRIPT_FOLDER+CMD_NAME);			
		}
	}
	class EntryPoint
	{
		private static void Main(string[] args)
		{
			var droid = new DroidDroidProgram();
			droid.Run();
		}
		
	}
}