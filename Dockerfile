
FROM jekyll/jekyll:3.8

RUN gem install jekyll-gist redcarpet pygments.rb jekyll-paginate ; \
  apk add --update \
  python3 