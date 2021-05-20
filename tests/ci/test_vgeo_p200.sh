#!/bin/sh -
# ======================================================================
#  Build & run : vgeo / electron 20 MeV
# ======================================================================
export LANG=C

# ======================================================================
# functions
# ======================================================================
check_error() {
  if [ $? -ne 0 ]; then
    exit -1
  fi
}

show_line() {
echo "========================================================================"
}

# ======================================================================
# main
# ======================================================================
show_line
echo "@@ Configure a program..."
./configure --with-geant4-dir=/opt/geant4/${G4VERSION} --disable-vis

show_line
echo "@@ Build a program..."
cd build/vgeo
make -j4
check_error

show_line
echo "@@ Run a program..."

#
cat << EOD > g4bench_p200.conf
{
  Run : {
    Seed : 123456789,
    G4DATA : "/opt/geant4/data/10.7.1"
  },
  Primary : {
    type : "beam",
    Beam : {
      particle  : "proton",
      energy    : 200.0,   // MeV
      ssd : 100.,  // SSD (cm)
      field_size : 10.0,   // field size (X/Y) in cm
    }
  }
}
EOD
#
./vgeo -c g4bench_p200.conf -j 100000

exit $?
