// Code generated by "stringer -type=State"; DO NOT EDIT.

package raft

import "strconv"

func _() {
	// An "invalid array index" compiler error signifies that the constant values have changed.
	// Re-run the stringer command to generate them again.
	var x [1]struct{}
	_ = x[StateUnknown-0]
	_ = x[StateLeader-1]
	_ = x[StateCandidate-2]
	_ = x[StateFollower-3]
}

const _State_name = "StateUnknownStateLeaderStateCandidateStateFollower"

var _State_index = [...]uint8{0, 12, 23, 37, 50}

func (i State) String() string {
	if i >= State(len(_State_index)-1) {
		return "State(" + strconv.FormatInt(int64(i), 10) + ")"
	}
	return _State_name[_State_index[i]:_State_index[i+1]]
}