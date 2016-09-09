Requirements
- The ruby language installed
- Kanet77's ruby gem (https://github.com/kanet77/togglv8)
- Your Toggl API token
- Your Toggl team id

___

The purpose of this program is to programmatically post recurring events to Toggl. I was frustrated by continually have to add the same recurring events to Toggl so I used the Ruby wrapper found here: https://github.com/kanet77/togglv8 to post them semi-automatically. (This requires the ruby language as well) 
The way it works is you either run the ruby code manually or setup an executable script to run it for you. When it runs it will get the current day of the week and add whatever events you have added under that day within the code.

___

In order for this to work for you you will need to get your Toggl API Token. This can be found under your profile on Toggl.

The next step is to get your project IDs. This can be done with a curl command.
This curl command needs two things: your API token and the workspace/team number. The team number can be found in the url when you naviagte to www.toggl.com/app/team/ by clicking the Team link.
This will return json text which you can use http://codebeautify.org/jsonviewer to view and extract the project IDs from. 

curl -v -u [API TOKEN GOES HERE]:api_token -X GET https://www.toggl.com/api/v8/workspaces/[TEAM NUMBER GOES HERE]/projects 

___

Once you have that information you are ready to edit the days within the ruby program.
I have set events under each day which include description, project id, starting hour, starting minute, and the duration in seconds. 
You can customize this for whatever your recurring events will be per day.

Then to run the program you would simply cd into the correct directory and run "ruby recurringtoggl.rb". Or do what I did which is setup an executable script to run the commands for you which you can find above. 