FROM ubuntu:14.10
MAINTAINER domitry "https://github.com/domitry"

RUN apt-get update; apt-get install -y g++ python-dev python-pip python-zmq libatlas-base-dev libzmq3-dev git curl; pip install "ipython[notebook]"

# ruby
RUN apt-get install -y ruby ruby-dev libssl-dev
ENV CONFIGURE_OPTS --disable-install-doc
RUN echo 'gem: --no-rdoc --no-ri' >> .gemrc

# iruby
RUN bash -l -c 'gem install pry iruby'

# nmatrix
RUN bash -l -c 'gem install nmatrix -f -- --with-opt-include=/usr/include/atlas'

# and other gem
RUN bash -l -c 'gem install nyaplot mikon statsample'

# prepare notebooks
RUN mkdir /notebooks; mkdir /notebooks/mount
RUN bash -l -c "cd /var/lib/gems/2.1*/gems; mv ./nyaplot*/examples/notebooks /notebooks/nyaplot-examples; mv ./mikon*/example /notebooks/mikon-examples;"
RUN bash -l -c "git clone https://github.com/domitry/nyaplot-notebooks.git /notebooks/other-examples"

# run iruby
RUN bash -l -c "cd /var/lib/gems/2.1*/gems/iruby*/lib/iruby/; sed 's/~\/.config\/iruby/\/tmp\/.config\/iruby/g' ./command.rb > ./tmp.rb; rm ./command.rb; mv ./tmp.rb ./command.rb"
RUN mkdir /tmp/.config
EXPOSE 9999
CMD bash -l -c "iruby notebook --no-browser --ip='*' --port 9999 --notebook-dir='/notebooks'"
