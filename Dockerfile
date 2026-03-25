FROM ruby:3.4.2
ADD . /plans
WORKDIR /plans

RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]
