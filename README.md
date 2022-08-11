# Resilvered site

The site is built from a fork of [Hyde](https://github.com/poole/hyde)

The additions have been basicly stolen from or inspriration gain from other sites as follows:

  - http://blog.davidebbo.com/
  - Jekyll [Cloud Tags](http://enrmarc.github.io/tags.html)
  - Alternate [Cloud tags](http://vvv.tobiassjosten.net/jekyll/jekyll-tag-cloud/) that I did not use
  - [Read more](http://blog.omgmog.net/post/adding-support-for-more-tag-to-jekyll-without-plugins/)
  - [Social bar](http://craigmccaskill.com/)
  - [DISQUS and Google analystics](http://joshualande.com/jekyll-github-pages-poole/)
  - [How to Make Custom Share Buttons with Jekyll](http://scottndecker.com/blog/2014/06/29/How-to-Make-Custom-Share-Buttons-with-Jekyll/)

## Docker

Build<br>
  `docker build -t docker-jekyll .`

Run<br>
  `docker run --rm --volume="$PWD:/srv/jekyll" docker-jekyll jekyll serve`