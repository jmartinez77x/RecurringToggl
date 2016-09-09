require 'togglv8'
require 'json'

#CURRENT TIME
NOW = Time.now

#ITERATE THROUGH DAY HASH
def toggl_post(day)
	#DO NOTHING IF DAY IS EMPTY
	if day.empty? then
		puts 'No events today'
	else
		#ASSIGN VARIABLES AND SEND TIME ENTRY FOR EACH EVENT
		day.each do |key, array|
			array.each do |name, value|
				case name.to_s
				when 'description'
					@toggl_description = value
				when 'pid'
					@toggl_pid = value
				when 'sHour'
					@toggl_sHour = value
				when 'sMinute'
					@toggl_sMinute = value
				when 'duration'	
					@toggl_duration = value
				end
			end
			#SEND TIME ENTRY 
			time_entry  = @toggl_api.create_time_entry({
			  'wid' => @workspace_id,
			  'created_with' => "Created with Ruby",

			  'description' => @toggl_description,
			  'pid' => @toggl_pid,
			  'start' => @toggl_api.iso8601((Time.new(NOW.year, NOW.month, NOW.day, @toggl_sHour.to_i, @toggl_sMinute.to_i, 00)).to_datetime),
			  'duration' => @toggl_duration
			})
		end
	end
end

class RecurringToggl

	#THE UNIQUE API TOKEN
	API_TOKEN = '[API TOKEN GOES HERE]' #**********************************************API TOKEN

	@toggl_api    = TogglV8::API.new(API_TOKEN)
	@user         = @toggl_api.me(all=true)
	@workspaces   = @toggl_api.my_workspaces(@user)
	@workspace_id = @workspaces.first['id']

	@toggl_description = ''
	@toggl_pid = 0
	@toggl_sHour = ''
	@toggl_sMinute = ''
	@toggl_duration = 0

	#EACH DAY WITH ITS EVENTS 
	#DESCRIPTION = DESCRIPTION OF TASK
	#PID = THE ID NUMBER OF THE PROJECT 
	#SHOUR = START TIME HOUR IN MILITARY TIME
	#SMINUTE = START TIME MINUTE IN MILITARY TIME
	#DURATION = LENGTH OF EVEN IN SECONDS 
	@sunday = {

	}
	@monday = {
	  event1: {
	    description: 'Work', pid: 11099789, sHour: '07', sMinute: '30', duration: 32400
	  },
	  event2: {
	  	description: 'Class', pid: 21702839, sHour: '19', sMinute: '00', duration: 4500
	  }
	}
	@tuesday = {
	  event1: {
	    description: 'Work', pid: 11099789, sHour: '07', sMinute: '30', duration: 16200
	  },
	  event2: {
	  	description: 'Class', pid: 21702841, sHour: '13', sMinute: '30', duration: 4500
	  },
	  event3: {
	    description: 'Work', pid: 11099789, sHour: '15', sMinute: '00', duration: 7200
	  }
	}
	@wednesday = {
	  event1: {
	    description: 'Work', pid: 11099789, sHour: '07', sMinute: '30', duration: 32400
	  },
	  event2: {
	  	description: 'Class', pid: 21702839, sHour: '19', sMinute: '00', duration: 4500
	  }
	}
	@thursday = {
	  event1: {
	  	description: 'Class', pid: 13340435, sHour: '09', sMinute: '00', duration: 4500
	  },
	  event2: {
	  	description: 'Class', pid: 21702841, sHour: '13', sMinute: '30', duration: 4500
	  },
	  event3: {
	    description: 'Work', pid: 11099789, sHour: '15', sMinute: '00', duration: 7200
	  }
	}
	@friday = {
	  event1: {
	    description: 'Work', pid: 11099789, sHour: '07', sMinute: '30', duration: 32400
	  }
	}
	@saturday = {
	  event1: {
	    description: 'Work', pid: 11099789, sHour: '07', sMinute: '30', duration: 16200
	  }
	}

	#POST TIME ENTRIES BASED ON DAY OF WEEK 
	weekday = Time.now.wday
	case weekday
	when 0
		toggl_post(@sunday)
	when 1
		toggl_post(@monday)
	when 2
		toggl_post(@tuesday)
	when 3
		toggl_post(@wednesday)
	when 4
		toggl_post(@thursday)
	when 5
		toggl_post(@friday)
	when 6
		toggl_post(@saturday)
	else
		#Do nothing 
	end
end
