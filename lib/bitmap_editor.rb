require 'byebug'

require './lib/parser'
require './lib/bitmap'
require './lib/commands/clear'
require './lib/commands/colour'
require './lib/commands/create'
require './lib/commands/draw_vertical'
require './lib/commands/show'

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

    Parser.new.parse(file).each do |command|
      key = command.keys.first
      if COMMANDS[key]
        data = Module.const_get(COMMANDS[key])
                     .new(bitmap)
                     .execute(*command.values.flatten)
      else
        puts 'unrecognised command :('
      end
    end
  end
end