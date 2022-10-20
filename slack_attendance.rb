require './slack_service.rb'
require 'pry'

# hard code this for the inning
c_id = #YOUR COHORTS CHANNEL ID (EX. C02HDS205L7)

print "Insert Timestamp ID:"
ts_id = gets.chomp

conversation_data = SlackService.conversation_data(c_id,ts_id)

replies = conversation_data[:messages][1..-1]

students_and_answer_time = {}

replies.each do |reply|
    time = Time.at(reply[:ts].to_f).strftime("%I:%M %p")
    user_name =  SlackService.student_data(reply[:user])[:user][:real_name]
    first_name =  SlackService.student_data(reply[:user])[:user][:profile][:first_name]
    last_name =  SlackService.student_data(reply[:user])[:user][:profile][:last_name]
    if students_and_answer_time[user_name].nil?
        students_and_answer_time[user_name] = {
            first_name: first_name,
            last_name: last_name,
            time: time 
        }
    end 
end 

students_and_answer_time.sort_by do |student, name_and_time_info|
    name_and_time_info[:last_name]
end.each do |student, name_and_time_info|
    puts "#{student} -- #{name_and_time_info[:time]}"
end 
