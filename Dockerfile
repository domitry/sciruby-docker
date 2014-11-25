FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y g++ python-dev python-pip python-zmq libatlas-base-dev libzmq3-dev git

# ipython
RUN pip install ipython jinja2 tornado

# ruby
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/plugins/ruby-build
RUN ~/.rbenv/plugins/ruby-build/install.sh
ENV PATH ~/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install -v 2.0.0-p353
RUN rbenv global 2.0.0-p353
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

# iruby
RUN cd /tmp; 
RUN gem install pry; gem install iruby

# nmatrix
RUN apt-get --purge remove liblapack-dev liblapack3 liblapack3gf
RUN gem install nmatrix -- --with-opt-include=/usr/include/atlas

# and other gem
RUN gem install mikon; gem install nyaplot; gem install statsample

# run iruby
EXPOSE 8888
CMD iruby notebook --notebook-dir='' --no-browser --ip='*' --port 8888
