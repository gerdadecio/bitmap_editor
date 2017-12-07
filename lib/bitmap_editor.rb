require 'parser'
require 'bitmap'
require 'commands/clear'
require 'commands/colour'
require 'commands/create'
require 'commands/draw_horizontal'
require 'commands/draw_vertical'
require 'commands/show'

class BitmapEditor

  COMMANDS = {
    'I' => 'Commands::Create',
    'C' => 'Commands::Clear',
    'L' => 'Commands::Colour',
    'V' => 'Commands::DrawVertical',
    'H' => 'Commands::DrawHorizontal',
    'S' => 'Commands::Show'
  }

  def run(file)
    bitmap = Bitmap.new
    Parser.new.parse(file).each_with_index do |command, index|
      key = command.keys.first
      if COMMANDS[key]
        cmd = Module.const_get(COMMANDS[key]).new(bitmap, *command.values.flatten)
        if cmd.valid?
          cmd.execute
        else
          puts "#{cmd.error.message} at line #{index+1}"
        end
      else
        puts "Unrecognised command at line #{index+1}"
      end
    end
  rescue => e
    puts e.message
  end
end