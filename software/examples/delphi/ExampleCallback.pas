program ExampleCallback;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletRotaryPoti;

type
  TExample = class
  private
    ipcon: TIPConnection;
    rp: TBrickletRotaryPoti;
  public
    procedure PositionCB(sender: TBrickletRotaryPoti; const position: smallint);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '9Hh'; { Change to your UID }

var
  e: TExample;

{ Callback function for position callback (parameter has range 0-100) }
procedure TExample.PositionCB(sender: TBrickletRotaryPoti; const position: smallint);
begin
  WriteLn(Format('Position: %d', [position]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  rp := TBrickletRotaryPoti.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Set Period for position callback to 0.05s (50ms)
    Note: The position callback is only called every 50ms if the
          position has changed since the last call! }
  rp.SetPositionCallbackPeriod(50);

  { Register position callback to procedure PositionCB }
  rp.OnPosition := {$ifdef FPC}@{$endif}PositionCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
