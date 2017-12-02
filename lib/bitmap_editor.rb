require 'byebug'

class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      commands = parse_line(line)
      commands.each do |command, arguments|
        case command
        when 'I'
          puts 'Create'
        when 'C'
          puts 'Clear'
        when 'L'
          puts 'Colour'
        when 'V'
          puts 'Draw Vertical'
        when 'H'
          puts 'Draw Horizontal'
        when 'S'
          puts 'save!'
        else
          puts 'unrecognised command :('
        end
      end
    end
  end

  def parse_line(line)
    commands = {}
    input = line.split
    commands[input.shift] = input
    commands
  end
end