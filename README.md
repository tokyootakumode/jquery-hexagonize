jQuery Hexagonize
====

Code Example
----
```
body
  .element(
    data-img-url="http://placekitten.com/300/300"
    data-img-hover-url="http://placekitten.com/301/301")
  script(type="text/javascript").
    $(function(){
      $('.element').hexagonize({
        width: 118,
        height: 118*1.5
      });
    });
```

![image](https://f.cloud.github.com/assets/1183484/1952582/5529702c-81ab-11e3-81c2-74cdee1a5855.png)
