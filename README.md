# JsonPreferences
OX Preference pane by JSON file

FROM a JSON file you can build simple buttons in Preference Pane on Mac ox-10.7.*,
see the following JSON

```
{
    "buttons": [{
        "text":"Start Mongodb",
        "action":"/Users/surindersingh/Documents/mongodb-osx-x86_64-3.1.2/bin/mongod",
        "args":["-dbpath", "/Users/surindersingh/Documents/dev/mongo-data/db"]
    },{
        "text":"Button text",
        "action":"path/to/command",
        "args":["arg1", "arg2"]
    }]
}
```

icon ->

![JsonPereference-Pane-icon](https://raw.githubusercontent.com/surinder83singh/JsonPreferences/master/JsonPreferences/JsonPereference-Pane-icon.png)

UI ->
![JsonPreferencePane-ui](https://raw.githubusercontent.com/surinder83singh/JsonPreferences/master/JsonPreferences/JsonPreferencePane-ui.png)
