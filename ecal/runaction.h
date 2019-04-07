/*============================================================================
Copyright 2017-2019 Koichi Murakami

Distributed under the OSI-approved BSD License (the "License");
see accompanying file LICENSE for details.

This software is distributed WITHOUT ANY WARRANTY; without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the License for more information.
============================================================================*/
#ifndef RUN_ACTION_H_
#define RUN_ACTION_H_

#include "G4UserRunAction.hh"

class SimData;

class RunAction : public G4UserRunAction {
public:
  RunAction();
  virtual ~RunAction() = default;

  void SetSimData(SimData* data);
  void SetDataSize(int n);
  void SetTestingFlag(bool val);

  virtual void BeginOfRunAction(const G4Run* run);
  virtual void EndOfRunAction(const G4Run* run);

  void ReduceResult();

  void ShowRunSummary(const G4Run* run) const;

private:
  SimData* simdata_;
  int nvec_;
  bool qtest_;

  long total_step_count_;
  double total_edep_;
};

// ==========================================================================
inline void RunAction::SetSimData(SimData* data)
{
  simdata_ = data;
}

inline void RunAction::SetDataSize(int n)
{
  nvec_ = n;
}

inline void RunAction::SetTestingFlag(bool val)
{
  qtest_ = val;
}

#endif
