class Replacement
    attr_reader :line
    attr_reader :file
    def initialize (file, line)
        @file = file
        @line = line
    end
    
    def to_s
        "#{@file} : #{@line}"
    end
end

log = File.open("./TabToSpace.log", "w")

puts "Enter target directory:"
targetPath = gets.chomp

Dir.chdir targetPath

filenames = Dir.glob("**/*.c") + Dir.glob("**/*.cpp") + Dir.glob("**/*.h")
replacements = []

filenames.each do |name|
    puts "->#{name}\n"
    rcount = 0
    i = 0
    newfile = ""
    IO.readlines(name).each do |line|
        line.gsub!(/\t/) do
            replacements << Replacement.new(name, i)
            rcount += 1
            log.puts(replacements.last.to_s)
            "    "
        end
        newfile += line
        i += 1
    end
    puts "Replacements: #{rcount}\n"
    IO.write(name, newfile)
end


puts "Total replacements: #{replacements.length}\n"
log.close


#Oneliner version
#IO.write(name, IO.read(name) { |data| IO.gsub(/\t/, "    ") } )