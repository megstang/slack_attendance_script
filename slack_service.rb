require 'faraday'

class SlackService

    def self.conn 
        conn = Faraday.new(
            url: 'https://slack.com/api',
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded',
              'Authorization' => "Bearer <<INSERT AUTH TOKEN HERE>>"
            }
          )
    end 

    def self.conversation_data(channel_id, timestamp_id)
      endpoint = "conversations.replies?channel=#{channel_id}&ts=#{timestamp_id}"
      response = conn.get(endpoint)
      JSON.parse(response.body,symbolize_names: true)
    end

    def self.student_data(student_slack_id)
      endpoint = "users.info?user=#{student_slack_id}"
      response = conn.get(endpoint)
      JSON.parse(response.body,symbolize_names: true)
    end 
    
end 

# a = SlackService.conversation_data("C02HDS205L7","1666205100.608759")


	