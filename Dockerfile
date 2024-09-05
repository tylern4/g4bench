FROM almalinux:9.2

RUN dnf groupinstall -y "Development Tools" \
    && dnf install -y cmake wget

RUN wget https://gitlab.cern.ch/geant4/geant4/-/archive/v11.1.2/geant4-v11.1.2.tar.gz \
    && tar -xvf geant4-v11.1.2.tar.gz \
    && mkdir geant4-v11.1.2/build && cd geant4-v11.1.2/build \ 
    && cmake .. -DGEANT4_USE_SYSTEM_EXPAT=off -DGEANT4_USE_SYSTEM_CLHEP=off \
    && make -j16 install

COPY . /software/g4bench
WORKDIR /software/g4bench
RUN mkdir build && cd build \
    && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make -j16 install 
