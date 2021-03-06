using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback function for position callback (parameter has range -150 to 150) 
	static void PositionCB(BrickletRotaryPoti sender, short position)
	{
		System.Console.WriteLine("Position: " + position);
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletRotaryPoti poti = new BrickletRotaryPoti(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set Period for position callback to 0.05s (50ms)
		// Note: The position callback is only called every 50ms if the
		//       position has changed since the last call!
		poti.SetPositionCallbackPeriod(50);

		// Register position callback to function PositionCB
		poti.Position += PositionCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
