require './lib/errors'

class Parser

  def parse(file)
    raise Errors::IncorrectFile.new if file.nil? || !File.exists?(file)
    commands = []
    File.open(file).each do |line|
      line = line.chomp
      commands << parse_line(line)
    end
    commands
  end


  private

  def parse_line(line)
    commands = {}
    input = line.split
    commands[input.shift] = input
    commands
  end
end
