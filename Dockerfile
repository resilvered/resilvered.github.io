
FROM jekyll/jekyll

RUN gem install jekyll-serv jekyll-gist webrick pygments.rb jekyll-paginate ; \
  apk add --update \
  python3 