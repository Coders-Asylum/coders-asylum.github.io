import 'dart:convert' show json;

import 'package:flutter_test/flutter_test.dart';
import 'package:web/backend/Article.dart';

void main() {
  group('Comment class tests', () {
    test('Comment class recursive function test: no recursion occurs', () async {
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

    test('Comment class encode method test', () async {
      String jsonString = '{"id":"1","name":"tester","timeStamp":"2021-12-08 16:07:29.551Z","comment":"test comment","flags":["pinned","author"],"reply":[]}';
      Comment c = Comment(json.decode(jsonString));

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
}

/// only used for testing,
/// todo: remove and moved to test files after meta data files auto-populating, and test data would be readby files.
const String testJSONString = '''

[{
		"id": 1,
		"timeStamp": "2020-06-5 10:45:25.000000Z",
		"type": "normal",
		"title": "New Google Feature Highlights the Search Results on External Websites.",
		"subtitle": "Now Google highlights your search results in yellow to improve your search experience inside external websites. This functionality works with Google’s Featured Snippets, these snippets are the containers (boxes) that show results for your search so you do not have to visit the website.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": null,
		"category": ["news", "seo"],
		"tags": ["google", "news"],
		"likes": 34,
		"comments": [{
			"id": 1,
			"name": "",
			"timeStamp": "",
			"comment": "",
			"flags": ["", ""],
			"reply": null
		}]
	},

	{
		"id": 2,
		"timeStamp": "2020-06-04 10:45:25.000000Z",
		"type": "normal",
		"title": "End to End Encryption Won’t Be Available to Free Users-says Zoom.",
		"subtitle": "This comes after the Eric Yuan Zoom CEO’s meeting with the investors on Tuesday. Zoom says that end to end encryption won’t be provided to the free user’s which means law enforcement agencies can look into your video calls.",
		"file": "",
		"featuredImage": "",
		"featured": false,
		"authorId": null,
		"category": ["news"],
		"tags": ["zoom", "security"],
		"likes": 34,
		"comments": [{
			"id": 1,
			"name": "",
			"timeStamp": "",
			"comment": "",
			"flags": ["", ""],
			"reply": null
		}]
	},

	{
		"id": 3,
		"timeStamp": "2020-05-28 10:45:25.000000Z",
		"type": "image_post",
		"title": "Instagram will be Getting new Features for Monetization.",
		"subtitle": "Instagram says on a blog post that it will be helping creators on its platform who create their original content by Helping them to monetize their content. In the recent COVID-19 Pandemic Instagram has seen a surge in increase of users in its app and the live broadcast has seen a 70% increase in views. ",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": null,
		"category": ["news", "social_media"],
		"tags": ["Instagram", "Social Media"],
		"likes": 34,
		"comments": [{
			"id": 1,
			"name": "",
			"timeStamp": "",
			"comment": "",
			"flags": ["", ""],
			"reply": null
		}]
	},

	{
		"id": 4,
		"timeStamp": "2020-05-28 10:45:25.000000Z",
		"type": "normal",
		"title": "New ‘Mysterious Jungle’ mode to come in PUBG Mobile on June 1,2020",
		"subtitle": "The popular Battle Royale game took their twitter handle to tease a new mode. It is called the Mysterious Jungle mode and will be available to be played on June 1, 2020.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": null,
		"category": ["news"],
		"tags": ["pubg", "games"],
		"likes": 34,
		"comments": [{
			"id": 1,
			"name": "",
			"timeStamp": "",
			"comment": "",
			"flags": ["", ""],
			"reply": null
		}]
	},

	{
		"id": 5,
		"timeStamp": "2020-05-27 10:45:25.000000Z",
		"type": "normal",
		"title": "Zipline’s Drone has Started delivering medical Supplies in North Carolina.",
		"subtitle": "According to Zipline, it is the first drone logistics company approved by the US for long Range deliveries of medical supplies to the hospitals. The Zipline drone ca cover a are of over 16o km.",
		"file": "",
		"featuredImage": "",
		"featured": true,
		"authorId": null,
		"category": ["news"],
		"tags": ["zipline", "medical"],
		"likes": 34,
		"comments": [{
			"id": 1,
			"name": "",
			"timeStamp": "",
			"comment": "",
			"flags": ["", ""],
			"reply": null
		}]
	}


]

''';
