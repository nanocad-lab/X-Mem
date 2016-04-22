# The MIT License (MIT)
# 
# Copyright (c) 2014 Microsoft
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Author: Mark Gottscho <mgottscho@ucla.edu>



# Dockerfile to containerize the ability to run (but not build) X-Mem on Linux

# We prefer to base X-Mem on Ubuntu distribution
FROM ubuntu:14.04

# We require a few Ubuntu packages to support running X-Mem binaries...
# Update repository information
RUN apt-get update

# Install gcc/g++ 4.8.2, which has been tested for Ubuntu 14.04 LTS on several Intel x86 ISA and CPU variants.
#RUN apt-get install g++-4.8.2

# Install runtime library to support huge/large pages. Note that this requires a recent CPU with hardware support and Linux kernel 2.6.16 or later. Not an issue on most modern hardware.
RUN apt-get install -y libhugetlbfs0

# Install runtime library to support NUMA.
RUN apt-get install -y libnuma1

# Add X-Mem Linux binaries to /opt/ in the container
RUN mkdir /opt/bin
ADD bin/xmem-linux-* /opt/bin/

# Set up large pages
#ADD linux_setup_runtime_hugetlbfs.sh /opt/
#RUN /opt/linux_setup_runtime_hugetlbfs.sh

# Done!
RUN echo "Done setting up X-Mem container!"

# Entrypoint
ENTRYPOINT ["/opt/bin/xmem-linux-x64_avx"]
