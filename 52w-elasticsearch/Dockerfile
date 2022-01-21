FROM elasticsearch:6.8.23

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-smartcn
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-stconvert/releases/download/v6.8.23/elasticsearch-analysis-stconvert-6.8.23.zip
