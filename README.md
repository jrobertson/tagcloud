#Introducing the tagcloud gem

The tagcloud gem stores tags at multiple-levels, allowing hiearachical navigation of tags through the tagcloud. All tags are stored in a Polyrex document called tags.xml and the schema for this document is 'entries/entry[tag]/urls[url]'.

Here's an example of how tags associated with a url are added to the tag cloud.

    require 'tagcloud'

    tags = %w{fish food health}
    tagcloud = TagCloud.new(uri: 'http://jamesrobertson.eu/blog/12/04/05/i-bought-fish', tags: tags, public_path: 'http://jamesrobertson.eu/tags')

Here's the files it created:

    -rw-r--r-- 1 james james 1894 2012-04-05 21:16 tags.xml
    -rw-r--r-- 1 james james  726 2012-04-05 21:16 index.xml
    -rw-r--r-- 1 james james  383 2012-04-05 21:16 fish_rows.xml
    -rw-r--r-- 1 james james  383 2012-04-05 21:16 food_rows.xml
    -rw-r--r-- 1 james james  383 2012-04-05 21:16 health_rows.xml
    -rw-r--r-- 1 james james  613 2012-04-05 21:16 food.xml
    -rw-r--r-- 1 james james  611 2012-04-05 21:16 health.xml
    -rw-r--r-- 1 james james  613 2012-04-05 21:16 fish.xml

The index.xml file is a Dynarex document with the schema 'tags/entry(tag,url)' and it's used to store all tags along with a url to the specific tag page. In the above example the fish_rows.xml and fish.xml would typically appears as embedded Dynarex data islands within an HTML page. 

The fish_rows.xml is a Dynarex document with the schema 'entries/entry(url)' which would contain all the urls which have been tagged with 'fish'. The fish.xml is another Dynarex document with the schema 'entries[tag]/entry(tag, url)' and is the same as index.xml except it only stores the other tags ('food', 'health') which were identified in the same url as 'fish'.

Here is an example fo the index.xml file:

    <?xml version='1.0' encoding='UTF-8'?>
    <tags>
      <summary>
        <recordx_type>dynarex</recordx_type>
        <format_mask>[!tag] [!url]</format_mask>
        <schema>tags/entry(tag,url)</schema>
      </summary>
      <records>
        <entry id='1' created='2012-04-05 21:16:25 +0100' last_modified=''>
          <tag>fish</tag>
          <url>http://jamesrobertson.eu/tags/fish.html</url>
        </entry>
        <entry id='2' created='2012-04-05 21:16:25 +0100' last_modified=''>
          <tag>food</tag>
          <url>http://jamesrobertson.eu/tags/food.html</url>
        </entry>
        <entry id='3' created='2012-04-05 21:16:25 +0100' last_modified=''>
          <tag>health</tag>
          <url>http://jamesrobertson.eu/tags/health.html</url>
        </entry>
      </records>
    </tags>

## Notes

* It is expected at this stage the user would create the HTML files manually and then embed the Dynarex data islands. 
* Dynarex data islands only work in Google Chrome however the dataisland gem can convert HTML files containing data islands to pure HTML.


