# This is basic docker container to run scaffold-eth-2.

FROM node:alpine
LABEL maintainer="Antonio Roldao <rtme@anton.io>"

RUN apk update
RUN apk add nano bash git


# Used mainly for debug purposes.
RUN echo -e '#!/bin/sh\nls -la --color "$@"' > /bin/dir
RUN chmod u+x /bin/dir

WORKDIR /root/rtme
CMD /bin/bash

# Expose ports.
EXPOSE 3000
EXPOSE 8545
