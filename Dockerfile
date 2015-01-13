FROM ubuntu:14.04
MAINTAINER domitry "https://github.com/domitry"

RUN apt-get update
RUN apt-get install -y g++ python-dev python-pip python-zmq libatlas-base-dev libzmq3-dev git curl
 
# ipython
RUN pip install ipython jinja2 tornado
 
# ruby
RUN apt-get install -y ruby2.0 ruby2.0-dev libssl-dev
RUN ln -sf /usr/bin/ruby2.0 /usr/bin/ruby #Ubuntu Bug #1310292
RUN ln -sf /usr/bin/gem2.0 /usr/bin/gem
ENV CONFIGURE_OPTS --disable-install-doc
RUN echo 'gem: --no-rdoc --no-ri' >> .gemrc

# iruby
RUN bash -l -c 'gem install pry iruby'

# nmatrix
RUN bash -l -c 'gem install nmatrix -f -- --with-opt-include=/usr/include/atlas'

# and other gem
RUN bash -l -c 'gem install nyaplot mikon statsample'

# prepare notebooks
RUN mkdir /notebooks
RUN bash -l -c "cd /var/lib/gems/2.0*/gems; mv ./nyaplot*/examples/notebooks /notebooks/nyaplot-examples; mv ./mikon*/example /notebooks/mikon-examples;"
RUN bash -l -c "git clone https://github.com/domitry/nyaplot-notebooks.git /notebooks/other-examples; mkdir /notebooks/mount"

# run iruby
RUN bash -l -c "cd /var/lib/gems/2.0*/gems/iruby*/lib/iruby/; sed 's/~\/.config\/iruby/\/tmp\/.config\/iruby/g' ./command.rb > ./tmp.rb; rm ./command.rb; mv ./tmp.rb ./command.rb"
RUN mkdir /tmp/.config
EXPOSE 9999
CMD bash -l -c "iruby notebook --no-browser --ip='*' --port 9999 --notebook-dir='/notebooks'"
