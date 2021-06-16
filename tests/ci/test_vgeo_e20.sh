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
. ./tests/ci/g4version.sh

if [ -z $NOG4VERSION ]; then
  g4path=/opt/geant4/${G4VERSION}
else
  g4path=/opt/geant4
fi

show_line
echo "@@ Configure a program..."
./configure --with-geant4-dir=${g4path} --disable-vis

show_line
echo "@@ Build a program..."
cd build/vgeo
make -j4
check_error

show_line
echo "@@ Run a program..."

#
cat << EOD > g4bench_e20.conf
{
  Run : {
    Seed : 123456789,
    G4DATA : "/opt/geant4/data"
  },
  Primary : {
    type : "beam",
    Beam : {
      particle  : "e-",
      energy    : 20.0,   // MeV
      ssd : 100.,  // SSD (cm)
      field_size : 10.0,   // field size (X/Y) in cm
    }
  }
}
EOD
#
./vgeo -c g4bench_e20.conf -j 100000

exit $?
