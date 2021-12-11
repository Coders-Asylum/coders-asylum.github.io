import 'dart:convert' show json;

import 'package:flutter_test/flutter_test.dart';
import 'package:web/backend/Article.dart';

void main() {
  // Comment class tests.
  group('Comment class tests', () {
    test('Comment class recursive function test: no recursion occurs.', () async {
      // JSON string to be passed.
      String jsonString = '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}';

      Comment c = Comment(json.decode(jsonString));
      // match the passed Map as string with the class toString() method return.
      expect(json.decode(jsonString), json.decode(c.toString()));
    });

    test('Comment class recursive function test: recursion occurs', () async {
      String jsonString =
          '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[{"id":"1:1","name":"tester","timeStamp":"2021-12-08 16:50:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}, {"id":"1:2","name":"tester","timeStamp":"2021-12-08 17:45:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[{"id":"1:2:1","name":"tester","timeStamp":"2021-12-08 17:50:30.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}]}]}';
      // create an Comment object.
      Comment c = Comment(json.decode(jsonString));
      // match the passed Map as string with the class toString() method return.
      expect(json.decode(jsonString), json.decode(c.toString()));
    });

    test('Comment class recursive function test: no recursion occurs and null reply is placed as empty list in object creation', () async {
      // JSON string to be passed.
      String jsonString = '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":null}';
      // JSON string to be compared.
      String jsonString2 = '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}';

      Comment c = Comment(json.decode(jsonString));
      // match the passed Map as string with the class toString() method return.
      expect(json.decode(jsonString2), json.decode(c.toString()));
    });

    test('Comment class .define named constructor test', () async {
      // json object to be compared.
      String jsonString =
          '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[{"id":"1:1","name":"tester","timeStamp":"2021-12-08 16:50:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}, {"id":"1:2","name":"tester","timeStamp":"2021-12-08 17:45:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[{"id":"1:2:1","name":"tester","timeStamp":"2021-12-08 17:50:30.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}]}]}';

      Comment c = Comment.define(id: '1', name: 'tester', timeStamp: DateTime.parse('2021-12-08 16:07:29.551Z'), comment: "test comment", flags: [
        "pinned",
        "author"
      ], reply: [
        Comment({
          "id": "1:1",
          "name": "tester",
          "timeStamp": "2021-12-08 16:50:29.551Z",
          "comment": "test comment",
          "flags": ["pinned", "author"],
          "reply": []
        }),
        Comment({
          "id": "1:2",
          "name": "tester",
          "timeStamp": "2021-12-08 17:45:29.551Z",
          "comment": "test comment",
          "flags": ["pinned", "author"],
          "reply": [
            {
              "id": "1:2:1",
              "name": "tester",
              "timeStamp": "2021-12-08 17:50:30.551Z",
              "comment": "test comment",
              "flags": ["pinned", "author"],
              "reply": []
            }
          ]
        })
      ]);

      expect(json.decode(jsonString), json.decode(c.toString()));
    });

    test('Comment class .define named constructor and commentString test', () async {
      // json object to be compared.
      String jsonString =
          '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[{"id":"1:1","name":"tester","timeStamp":"2021-12-08 16:50:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}, {"id":"1:2","name":"tester","timeStamp":"2021-12-08 17:45:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[{"id":"1:2:1","name":"tester","timeStamp":"2021-12-08 17:50:30.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}]}]}';

      // object created using define named constructor.
      Comment c = Comment.define(id: '1', name: 'tester', timeStamp: DateTime.parse('2021-12-08 16:07:29.551Z'), comment: "test comment", flags: [
        "pinned",
        "author"
      ], reply: [
        Comment({
          "id": "1:1",
          "name": "tester",
          "timeStamp": "2021-12-08 16:50:29.551Z",
          "comment": "test comment",
          "flags": ["pinned", "author"],
          "reply": []
        }),
        Comment({
          "id": "1:2",
          "name": "tester",
          "timeStamp": "2021-12-08 17:45:29.551Z",
          "comment": "test comment",
          "flags": ["pinned", "author"],
          "reply": [
            {
              "id": "1:2:1",
              "name": "tester",
              "timeStamp": "2021-12-08 17:50:30.551Z",
              "comment": "test comment",
              "flags": ["pinned", "author"],
              "reply": []
            }
          ]
        })
      ]);
      // object created using normal constructor for comparing.
      Comment c2 = Comment(json.decode(jsonString));

      expect(json.decode(c.toString()), json.decode(c2.toString()));
    });

    test('Comment class encode method test', () async {
      String jsonString = '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}';
      // comment object 1
      Comment c1 = Comment(json.decode(jsonString));
      // comment object 2
      /// todo: create a way to directly access and stub the encode method.
      late Comment c2;

      // overriding c2 object with the same string and calling the internal encode function.
      c2 = Comment(json.decode(jsonString));

      // see if the objects match.
      expect(c1.toString(), c2.toString());
    });
  });

  // Post class test.
  group('Post class tests', () {
    test('Post class single post test using default constructor', () async {
      List<dynamic> testList = json.decode(testJSONString);
      String jsonString = json.encode(testList[0]);

      Post p = Post(
          id: 1,
          timeStamp: DateTime.parse('2021-12-08 16:07:29.551Z'),
          type: 'normal',
          title: "New Google Feature Highlights the Search Results on External Websites.",
          subtitle:
              "Now Google highlights your search results in yellow to improve your search experience inside external websites. This functionality works with Google’s Featured Snippets, these snippets are the containers (boxes) that show results for your search so you do not have to visit the website.",
          file: "",
          featuredImage: "",
          featured: true,
          authorId: [],
          category: ["news", "seo"],
          tags: ["google", "news"],
          likes: 34,
          comments: [
            Comment({
              "id": "1",
              "name": "",
              "timeStamp": "2021-12-08 16:07:29.551Z",
              "comment": "",
              "flags": ["", ""],
              "reply": null
            })
          ]);

      expect(json.decode(jsonString), json.decode(p.toString()));
    });

    test('Post class single post test using .mapDetails named constructor', () async {
      // extracting data from test json string.
      List<dynamic> testList = json.decode(testJSONString);
      String jsonString = json.encode(testList[0]);

      Post p = Post.mapDetails(testList[0]);

      expect(json.decode(jsonString), json.decode(p.toString()));
    });

    test('Post class single post test using .decode named constructor', () async {
      // extracting data from test json string.
      List<dynamic> testList = json.decode(testJSONString);
      String jsonString = json.encode(testList[0]);

      Post p = Post.decode(jsonString);

      expect(json.decode(jsonString), json.decode(p.toString()));
    });

    test('check post list with whole list of Post JSON data ', () async {
      // store each post data map as a Post object.
      List<Post> _posts = [];

      // test data list.
      List<dynamic> _postsData = json.decode(testJSONString);

      _postsData.forEach((p) {
        _posts.add(Post.mapDetails(p));
      });

      // using .toString to check if the all Post data is mapped correctly.
      String _s = '[';
      for (int i = 0; i < _posts.length; i++) {
        if (i != _posts.length - 1) {
          _s += '${_posts[i].toString()},';
        } else {
          _s += _posts[i].toString();
        }
      }
      _s += ']';

      expect(_postsData, json.decode(_s));
    });

    test('Post class [] operator overloading test', () async {
      // extracting data from test json string.
      List<dynamic> testList = json.decode(testJSONString);
      String jsonString = json.encode(testList[0]);
      Map actualData = testList[0];

      Post p = Post.decode(jsonString);
      List<dynamic> c = [];

      // converting each comment to a JSON object for comparing with the actual data.
      p['comments'].forEach((e) {
        c.add(json.decode(e.toString()));
      });

      expect(actualData["id"], p["id"]);
      expect(DateTime.parse(actualData["timeStamp"]), p["timeStamp"]);
      expect(actualData["type"], p["type"]);
      expect(actualData["title"], p["title"]);
      expect(actualData["subtitle"], p["subtitle"]);
      expect(actualData["file"], p["file"]);
      expect(actualData["featuredImage"], p["featuredImage"]);
      expect(actualData["featured"], p['featured']);
      expect(actualData["authorId"], p["authorId"]);
      expect(actualData["category"], p["category"]);
      expect(actualData["tags"], p["tags"]);
      expect(actualData["likes"], p["likes"]);
      expect(actualData['comments'], c);
    });

    test('Check assert condition in default constructor', () async {
      expect(
          () => Post(
                id: 1,
                timeStamp: DateTime.parse('2021-12-08 16:07:29.551Z'),
                type: 'normal',
                title: "New Google Feature Highlights the Search Results on External Websites.",
                subtitle:
                    "Now Google highlights your search results in yellow to improve your search experience inside external websites. This functionality works with Google’s Featured Snippets, these snippets are the containers (boxes) that show results for your search so you do not have to visit the website.",
                file: "",
                featuredImage: "",
                featured: true,
                authorId: [],
                category: ["news", "seo"],
                tags: ["google", "news"],
                likes: 34,
                comments: [
                  Comment({
                    "id": "1",
                    "name": "",
                    "timeStamp": "2021-12-08 16:07:29.551Z",
                    "comment": "",
                    "flags": ["", ""],
                    "reply": null
                  })
                ],
                commentsMapObject: [
                  {
                    "id": "1",
                    "name": "",
                    "timeStamp": "2021-12-08 16:07:29.551Z",
                    "comment": "",
                    "flags": ["", ""],
                    "reply": null
                  }
                ],
              ),
          throwsAssertionError);
    });
  });
}

/// only used for testing,
/// todo: remove and moved to test files after meta data files auto-populating, and test data would be read by files.
const String testJSONString = '''
[{
		"id": 1,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "New Google Feature Highlights the Search Results on External Websites.",
		"subtitle": "Now Google highlights your search results in yellow to improve your search experience inside external websites. This functionality works with Google’s Featured Snippets, these snippets are the containers (boxes) that show results for your search so you do not have to visit the website.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [],
		"category": ["news", "seo"],
		"tags": ["google", "news"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:07:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	},
	{
		"id": 2,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "End to End Encryption Won’t Be Available to Free Users-says Zoom.",
		"subtitle": "This comes after the Eric Yuan Zoom CEO’s meeting with the investors on Tuesday. Zoom says that end to end encryption won’t be provided to the free user’s which means law enforcement agencies can look into your video calls.",
		"file": "",
		"featuredImage": "",
		"featured": false,
		"authorId": [],
		"category": ["news"],
		"tags": ["zoom", "security"],
		"likes": 34,
		"comments": [{
				"id": "1",
				"name": "",
				"timeStamp": "2021-12-08 16:50:29.551Z",
				"comment": "",
				"flags": ["", ""],
				"reply": []
			},
			{
				"id": "2",
				"name": "tester",
				"timeStamp": "2021-12-08 16:07:29.551Z",
				"comment": "test comment",
				"flags": ["pinned", "author"],
				"reply": [{
					"id": "2:1",
					"name": "tester",
					"timeStamp": "2021-12-08 16:50:29.551Z",
					"comment": "test comment",
					"flags": ["pinned", "author"],
					"reply": []
				}, {
					"id": "2:2",
					"name": "tester",
					"timeStamp": "2021-12-08 17:45:29.551Z",
					"comment": "test comment",
					"flags": ["pinned", "author"],
					"reply": [{
						"id": "2:2:1",
						"name": "tester",
						"timeStamp": "2021-12-08 17:50:30.551Z",
						"comment": "test comment",
						"flags": ["pinned", "author"],
						"reply": []
					}]
				}]
			}

		]
	},

	{
		"id": 3,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "image_post",
		"title": "Instagram will be Getting new Features for Monetization.",
		"subtitle": "Instagram says on a blog post that it will be helping creators on its platform who create their original content by Helping them to monetize their content. In the recent COVID-19 Pandemic Instagram has seen a surge in increase of users in its app and the live broadcast has seen a 70% increase in views. ",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [],
		"category": ["news", "social_media"],
		"tags": ["Instagram", "Social Media"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:50:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	},

	{
		"id": 4,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "New ‘Mysterious Jungle’ mode to come in PUBG Mobile on June 1,2020",
		"subtitle": "The popular Battle Royale game took their twitter handle to tease a new mode. It is called the Mysterious Jungle mode and will be available to be played on June 1, 2020.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [],
		"category": ["news"],
		"tags": ["pubg", "games"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:50:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	},

	{
		"id": 5,
		"timeStamp": "2021-12-08 16:07:29.551Z",
		"type": "normal",
		"title": "Zipline’s Drone has Started delivering medical Supplies in North Carolina.",
		"subtitle": "According to Zipline, it is the first drone logistics company approved by the US for long Range deliveries of medical supplies to the hospitals. The Zipline drone ca cover a are of over 16o km.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": [],
		"category": ["news"],
		"tags": ["zipline", "medical"],
		"likes": 34,
		"comments": [{
			"id": "1",
			"name": "",
			"timeStamp": "2021-12-08 16:50:29.551Z",
			"comment": "",
			"flags": ["", ""],
			"reply": []
		}]
	}]''';
