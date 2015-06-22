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

