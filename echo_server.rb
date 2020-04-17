require 'socket'

def roll(sides)
  rand(sides) + 1
end

def roll_dice(params)
  rolls = params['rolls'].to_i
  sides = params['sides'].to_i
  output = []
  rolls.times { output << (roll(sides).to_s + ' ') }
  output
end

def joinor(arr)
  case arr.size
  when 0 then ''
  when 1 then "#{arr.first}"
  when 2 then "#{arr.first} and #{arr.last}"
  else
    "#{arr[0..-2].join(', ')}and #{arr.last}"
  end
end

def display_rolls(params)
  if params
    client.puts "<h1 style='color: blue'>Rolls: " + "#{joinor(roll_dice(params))}" + '</h1>'
  else
    client.puts "<h1 style='color: red'>ERROR</h1>"
    client.puts "<h1 style='color: red'>" + ('=' * 57) + '</h1>'
    client.puts "<h1><em>Please Indicate the Roll Amount and Dice Sides In the URL Query Parameters</em></h1>\n"
    client.puts
    client.puts "<h2 style='color: red'>Example:<h2 style='color: black'> http://localhost:3003/?rolls=2&sides=6</h2></h2>"
  end
end

def display_parameters(method, path, params, client)
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts '<html>'
  client.puts '<body>'
  client.puts '<pre>'
  client.puts '<h1>HTTP Method: ' + method + '</h1>'
  client.puts "<h3>Path: #{path}</h2>"
  client.puts "<h3>Parameters: #{params.to_s}</h2>" if params
  client.puts '</pre>'
end

def parse_request(request_line)
  method, path = request_line.split(' ')
  path, params = path.split('?')
  query_parameters = if params
                       params.split('&')
                             .each_with_object({}) do |pair, parameters|
                               name, value = pair.split('=')
                               parameters[name] = value
                             end
                      end
  [method, path, query_parameters]
end

server = TCPServer.new('localhost', 3003)

loop do
  client = server.accept
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/

  method, path, params = parse_request(request_line)
  display_parameters(method, path, params, client)
  display_rolls(params)
  client.puts '</body>'
  client.puts '</html>'
  puts request_line
  client.close
end
