#
#file_path = "bets_wzd_1.csv"
#file_path = "bets_ewa_1.csv"
file_path = "bets_wzd_2.csv"

puts "Opening #{file_path} file"
puts 'Expected file format:'
puts '  user email;match number;home team goals;away team goals;winning team after 90 minutes (Home/Away/Draw);team to advance (Home/Away - required for playoff games)'

if File.exists?(file_path)
  # open the csv file
  f = File.open(file_path, "r")
  
  # loop through each record in the csv file
  line_no = 0
  f.each_line do |line|
    
    line_no += 1
    puts "Processing line #{line_no}"
  
    # each line has fields separated by commas, so split those fields
    fields = line.split(';')
    
    # do a little work here to get rid of double-quotes and blanks
    email = fields[0].tr_s('"', '').strip
    match_no = fields[1].tr_s('"', '').strip
    home_team_goals = fields[2].tr_s('"', '').strip
    away_team_goals = fields[3].tr_s('"', '').strip
    result_90mins = fields[4].tr_s('"', '').strip
    team_to_advance = fields[5].tr_s('"', '').strip
    
    # find user and match
    #user = User.find_by email: email
    user = User.find(:first, :conditions => { :email => email })
    if user.nil?
      raise "User not found: #{email}"
    end
    #match = Match.find_by match_no: match_no
    match = Match.find(:first, :conditions => { :match_no => match_no })
    if match.nil?
      raise "Match number #{match_no} not found"
    end
    
    # find bet
    #bet = Bet.find_by match: match, user: user
    bet = Bet.find(:first, :conditions => { :match_id => match.id, :user_id => user.id })
    if not bet.nil?
      raise "Bet was found! Cannot continue."
    end
    bet = Bet.new
    
    # user
    bet.user = user
    # match
    bet.match = match
    # home team goals
    bet.home_team_goals_90mins = home_team_goals
    # away team goals
    bet.away_team_goals_90mins = away_team_goals
    # result after 90 minutes
    if result_90mins == 'Home'
      bet.result_90mins = ApplicationHelper::HOME_TEAM_WIN
    elsif result_90mins == 'Away'
      bet.result_90mins = ApplicationHelper::AWAY_TEAM_WIN
    elsif result_90mins == 'Draw'
      bet.result_90mins = ApplicationHelper::DRAW
    else
      raise "Invalid valus found where result after 90 minutes was expected: #{result_90mins}"
    end
    
    if match.is_playoff
      # home team eliminated
      if team_to_advance == 'Home'
        bet.home_team_eliminated = false
      elsif team_to_advance == 'Away'
        bet.home_team_eliminated = true
      else
        raise "Invalid value where team to advance (Home/Away) was expected: #{team_to_advance}"
      end
    end
    
    Bet.skip_callback(:create)
    bet.save(:validate => false)
    Bet.set_callback(:create)
  end
else
  puts "File #{file_path} not found!"
end
