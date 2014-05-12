# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeds: Initializing Users"
admin = User.create!(name: "Jarek Budzianowski", email: "jaroslaw.budzianowski@sollers.pl",
        password: "sollers156", password_confirmation: "sollers156")
admin.toggle!(:admin)
admin = User.create!(name: "Wiosna Wiłkomirska", email: "wiosna.wilkomirska@sollers.pl",
        password: "sollers632", password_confirmation: "sollers632")
admin.toggle!(:admin)

puts "Seeds: Initializing Teams"
groups = [
        ['Group A', ['Brazil', 'Croatia', 'Mexico', 'Cameroon']],
        ['Group B', ['Spain', 'Netherlands', 'Chile', 'Australia']],
        ['Group C', ['Colombia', 'Greece', "Côte d'Ivoire", 'Japan']],
        ['Group D', ['Uruguay', 'Costa Rica', 'England', 'Italy']],
        ['Group E', ['Switzerland', 'Ecuador', 'France', 'Honduras']],
        ['Group F', ['Argentina', 'Bosnia and Herzegovina', 'Iran', 'Nigeria']],
        ['Group G', ['Germany', 'Portugal', 'Ghana', 'United States']],
        ['Group H', ['Belgium', 'Algeria', 'Russia', 'South Korea']]
        ]
        
groups.each do |group, teams|
  teams.each do |team|
    Team.create!(name: team, group: group)
  end
  Team.create!(name: "Winner #{group}", group: group, placeholder: true)
  Team.create!(name: "Runner-Up #{group}", group: group, placeholder: true)
end
for match_no in 49..62
  Team.create!(name: "Winner Match #{match_no}", group: nil, placeholder: true)
end
for match_no in 61..62
  Team.create!(name: "Loser Match #{match_no}", group: nil, placeholder: true)
end

puts "Seeds: Initializing Matches"
stages = [
  ["Group A",false,[
  "1;Thu Jun/12 17:00;  Brazil;Croatia       ;Arena de São Paulo, São Paulo;UTC-3",
  "2;Fri Jun/13 13:00;  Mexico;Cameroon      ;Estádio das Dunas, Natal;UTC-3",
  
  "17;Tue Jun/17 16:00;  Brazil;Mexico        ;Estádio Castelão, Fortaleza;UTC-3",
  "18;Wed Jun/18 18:00;  Cameroon;Croatia     ;Arena Amazônia, Manaus;UTC-4",
  
  "33;Mon Jun/23 17:00;  Cameroon;Brazil      ;Brasília;UTC-3",
  "34;Mon Jun/23 17:00;  Croatia ;Mexico      ;Recife;UTC-3"
]],
  
  
  ["Group B",false,[
  "3;Fri Jun/13 16:00;  Spain;Netherlands     ;Arena Fonte Nova, Salvador;UTC-3",
  "4;Fri Jun/13 18:00;  Chile;Australia       ;Arena Pantanal, Cuiabá;UTC-4",
  
  "19;Wed Jun/18 16:00;  Spain;Chile             ;Estádio do Maracanã, Rio de Janeiro;UTC-3",
  "20;Wed Jun/18 13:00;  Australia;Netherlands   ;Estádio Beira-Rio, Porto Alegre;UTC-3",
  
  "35;Mon Jun/23 13:00;  Australia;Spain         ;Curitiba;UTC-3",
  "36;Mon Jun/23 13:00;  Netherlands;Chile       ;São Paulo;UTC-3"
]],
  
  
  
  ["Group C",false,[
  "5;Sat Jun/14 13:00;  Colombia;Greece          ;Estádio Mineirão, Belo Horizonte;UTC-3",
  "6;Sat Jun/14 22:00;  Côte d'Ivoire;Japan      ;Arena Pernambuco, Recife;UTC-3",
  
  "21;Thu Jun/19 13:00;  Colombia;Côte d'Ivoire   ;Estádio Nacional Mané Garrincha, Brasília;UTC-3",
  "22;Thu Jun/19 19:00;  Japan;Greece             ;Estádio das Dunas, Natal;UTC-3",
  
  "37;Tue Jun/24 16:00;  Japan;Colombia            ;Cuiabá;UTC-4",
  "38;Tue Jun/24 17:00;  Côte d'Ivoire;Greece      ;Fortaleza;UTC-3"
]],
  
  
  
  ["Group D",false,[
  "7;Sat Jun/14 16:00;  Uruguay;Costa Rica       ;Estádio Castelão, Fortaleza;UTC-3",
  "8;Sat Jun/14 18:00;  England;Italy            ;Arena Amazônia, Manaus;UTC-4",
  
  "23;Thu Jun/19 16:00;  Uruguay;England          ;Arena de São Paulo, São Paulo;UTC-3",
  "24;Fri Jun/20 13:00;  Italy;Costa Rica         ;Arena Pernambuco, Recife;UTC-3",
  
  "39;Tue Jun/24 13:00;  Italy;Uruguay             ;Natal;UTC-3",
  "40;Tue Jun/24 13:00;  Costa Rica;England        ;Belo Horizonte;UTC-3"
  ]],

  
  
  ["Group E",false,[
  "9; Sun Jun/15 13:00;  Switzerland;Ecuador      ;Estádio Nacional Mané Garrincha, Brasília;UTC-3",
  "10;Sun Jun/15 16:00;  France;Honduras          ;Estádio Beira-Rio, Porto Alegre;UTC-3",
  
  "25;Fri Jun/20 16:00;  Switzerland;France       ;Arena Fonte Nova, Salvador;UTC-3",
  "26;Fri Jun/20 19:00;  Honduras;Ecuador         ;Arena da Baixada, Curitiba;UTC-3",
  
  "41;Wed Jun/25 16:00;  Honduras;Switzerland     ;Manaus;UTC-4",
  "42;Wed Jun/25 17:00;  Ecuador ;France          ;Rio de Janeiro;UTC-3"
  ]],

  
  
  ["Group F",false,[
  "11;Sun Jun/15 19:00;  Argentina;Bosnia and Herzegovina    ;Estádio do Maracanã, Rio de Janeiro;UTC-3",
  "12;Mon Jun/16 16:00;  Iran;Nigeria                    ;Arena da Baixada, Curitiba;UTC-3",
  
  "27;Sat Jun/21 13:00;  Argentina;Iran                  ;Estádio Mineirão, Belo Horizonte;UTC-3",
  "28;Sat Jun/21 18:00;  Nigeria;Bosnia and Herzegovina      ;Arena Pantanal, Cuiabá;UTC-4",
  
  "43;Wed Jun/25 13:00;  Nigeria;Argentina               ;Porto Alegre;UTC-3",
  "44;Wed Jun/25 13:00;  Bosnia and Herzegovina;Iran         ;Salvador;UTC-3"
]],
  
  
  
  ["Group G",false,[
  "13;Mon Jun/16 13:00;  Germany;Portugal           ;Arena Fonte Nova, Salvador;UTC-3",
  "14;Mon Jun/16 19:00;  Ghana;United States        ;Estádio das Dunas, Natal;UTC-3",
  
  "29;Sat Jun/21 16:00;  Germany;Ghana              ;Fortaleza;UTC-3",
  "30;Sun Jun/22 18:00;  United States;Portugal     ;Manaus;UTC-4",
  
  "45;Thu Jun/26 13:00;  United States;Germany       ;Recife;UTC-3",
  "46;Thu Jun/26 13:00;  Portugal;Ghana              ;Brasília;UTC-3"
]],
  
  
  
  ["Group H",false,[
  "15;Tue Jun/17 13:00;  Belgium;Algeria         ;Estádio Mineirão, Belo Horizonte;UTC-3",
  "16;Tue Jun/17 18:00;  Russia;South Korea      ;Arena Pantanal, Cuiabá;UTC-4",
  
  "31;Sun Jun/22 13:00;  Belgium;Russia          ;Rio de Janeiro;UTC-3",
  "32;Sun Jun/22 16:00;  South Korea;Algeria     ;Porto Alegre;UTC-3",
  
  "47;Thu Jun/26 17:00;  South Korea;Belgium     ;São Paulo;UTC-3",
  "48;Thu Jun/26 17:00;  Algeria;Russia          ;Curitiba;UTC-3"
]],
  
  ["Round of 16",true,[
"49;Sat Jun/28 13:00;  Winner Group A;Runner-Up Group B     ;Belo Horizonte;UTC-3",
"50;Sat Jun/28 17:00;  Winner Group C;Runner-Up Group D     ;Rio de Janeiro;UTC-3",

"51;Sun Jun/29 13:00;  Winner Group B;Runner-Up Group A     ;Fortaleza;UTC-3",
"52;Sun Jun/29 17:00;  Winner Group D;Runner-Up Group C     ;Recife;UTC-3",

"53;Mon Jun/30 13:00;  Winner Group E;Runner-Up Group F     ;Brasília;UTC-3",
"54;Mon Jun/30 17:00;  Winner Group G;Runner-Up Group H     ;Porto Alegre;UTC-3",

"55;Tue Jul/1 13:00;   Winner Group F;Runner-Up Group E     ;São Paulo;UTC-3",
"56;Tue Jul/1 17:00;   Winner Group H;Runner-Up Group G     ;Salvador;UTC-3"
]],


["Quarter-finals",true,[
"57;Fri Jul/4 13:00;     Winner Match 49;Winner Match 50    ;Fortaleza;UTC-3",
"58;Fri Jul/4 17:00;     Winner Match 53;Winner Match 54    ;Rio de Janeiro;UTC-3",

"59;Sat Jul/5 13:00;     Winner Match 51;Winner Match 52    ;Salvador;UTC-3",
"60;Sat Jul/5 17:00;     Winner Match 55;Winner Match 56    ;Brasília;UTC-3"
]],

["Semi-finals",true,[
"61;Tue Jul/8 17:00;     Winner Match 57;Winner Match 58      ;Belo Horizonte;UTC-3",
"62;Wed Jul/9 17:00;     Winner Match 59;Winner Match 60      ;São Paulo;UTC-3"
]],


["Third place match",true,[
"63;Sat Jul/12 17:00;    Loser Match 61;Loser Match 62   ;Brasília;UTC-3"
]],


["Final",true,[
"64;Sun Jul/13 16:00;    Winner Match 61;Winner Match 62   ;Rio de Janeiro;UTC-3"]]]
  
  stages.each do |stage, playoffs, matches|
    puts
    puts
    puts stage
    puts "PLAYOFFS" if playoffs
    puts "GROUP STAGE" if not playoffs
    puts
    puts
    
    matches.each do |match_str|
      tokens = match_str.split(';')
      puts "match #{tokens[0]}:"
      match_date = DateTime.parse("#{tokens[1]} #{tokens[5]}")
      puts "\tdate: #{match_date} "
      tokens[2].strip!
      home_team = Team.find_by_name(tokens[2])
      puts "\t\t#{tokens[2]} <<<<<<<<<" if home_team.nil?
      puts "\thome team: #{home_team.name}"
      tokens[3].strip!
      away_team = Team.find_by_name(tokens[3])
      puts "\t\t#{tokens[3]} <<<<<<<<<" if away_team.nil?
      puts "\taway team: #{away_team.name}"
      puts "\tvenue: #{tokens[4]}"
      
      # create record
      match = Match.new(match_date: match_date, match_no: tokens[0], tournament_stage: stage, venue: tokens[4])
      match.home_team = home_team
      match.away_team = away_team
      raise "Failed to create Match!" if not match.save
    end
  end