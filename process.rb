require "csv"
require "pp"

# Channels that didn't show up in the data from Comcast but that we actually get.
# Doublecheck this is still true before each run.
ADDITIONS = {
  "BTN HD" => 256,
  "BTN+ HD" => 264
}

DONT_SWAP = ["OWN (Oprah Winfrey Network)", "Home Preview Channel (Detroit)"]
SUBS = {
  "Home Preview Channel (Detroit)" => "Home Preview Channel",
  "National Geographic Channel" => "National Geographic",
  "WGTE Kids (PBS)" => "PBS Kids (WGTE)",
  "WTVS Kids" => "PBS Kids (WTVS)",
  "WTVS World (PBS)" => "PBS World (WTVS)",
  "WTVS Create (PBS)" => "PBS Create (WTVS)",
  "WGTE Create (PBS)" => "PBS Create (WGTE)",
  "Great American Country (GAC)" => "GAC (Great American Country)",
  "WXYZ HD (ABC)" => "ABC HD (WXYZ)",
  "WDIV HD (NBC)" => "NBC HD (WDIV)",
  "WJBK HD (FOX)" => "FOX HD (WJBK)",
  "WMYD HD (MyTV)" => "MyTV HD (WMYD)",
  "WKBD HD (CW)" => "CW HD (WKBD)",
  "OWN HD (Oprah Winfrey Network)" => "Oprah Network HD (OWN)",
  "WDWO (INR)" => "INR (WDWO)",
  "WGTE HD (PBS)" => "PBS HD (WGTE)",
  "WPXD HD (ION)" => "ION HD (WPXD)",
  "WADL HD (IND)" => "IND HD (WADL)",
  "WLPC-LP (INR)" => "INR (WLPC-LP)",
  "WTVS HD (PBS)" => "PBS HD (WTVS)",
  "WWJ HD (CBS)" => "CBS HD (WWJ)",
  "Three Angels Broadcasting (3ABN)" => "3ABN (Three Angels)",
  "Xfinity Latino Entertainment Channel" => "Xfinity Latino",
  "WWJ Start TV" => "Start TV",
  "WJBK Buzzr" => "Buzzr",
  "WJBK Movies!" => "Movies",
  "WDIV ThisTV" => "ThisTV",
  "WXYZ Laff TV" => "Laff TV",
  "WXYZ Bounce TV" => "Bounce TV",
  "WMYD AntennaTV" => "AntennaTV",
  "WJBk Heroes & Icons" => "Heroes & Icons",
  "WDIV MeTV" => "MeTV",
  "FOX Sports Detroit + HD" => "FOX Sports Detroit+ HD"
}

channels = ADDITIONS.dup
format = ARGV[0] || "csv"

CSV.foreach("input.csv") do |row|
  channels[row[1]] = row[0].to_i
end

# Remove non-HD variants of HD channels
hds = channels.keys.select { |c| c.match?(" HD") }

hds.each do |hd|
  channels.delete(hd.sub(" HD", ""))
end

channels.keys.each do |chan|
  if SUBS[chan]
    channels[SUBS[chan]] = channels[chan]
    channels.delete(chan)
  end
end

if format == "md"
  puts "|Name|Number|"
  puts "|---|---|"
end

channels.keys.sort_by(&:downcase).each do |chan|
  puts format == "md" ? "| #{chan} | #{channels[chan]} |" : "#{chan},#{channels[chan]}"
end
