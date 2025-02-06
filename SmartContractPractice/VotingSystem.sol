// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract VotingSystem {
    address public owner;
    mapping(address => uint256) public candidateVotes; // Tracks votes for each candidate
    mapping(address => bool) public hasVoted; // Prevents double voting
    mapping(address => bool) public isCandidate; // Ensures only valid candidates receive votes
    address[] public candidates; 
    bool public votingEnded = false; // Tracks if voting is active

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier votingActive() {
        require(!votingEnded, "Voting has ended");
        _;
    }

    function addCandidate(address _candidate) public onlyOwner {
        require(!isCandidate[_candidate], "Candidate already exists");
        isCandidate[_candidate] = true;
        candidates.push(_candidate);
    }

    function vote(address _candidate) public votingActive {
        require(isCandidate[_candidate], "Candidate does not exist");
        require(!hasVoted[msg.sender], "You have already voted");
        
        hasVoted[msg.sender] = true;
        candidateVotes[_candidate]++;
    }

    function getTotalVotes(address _candidate) public view returns (uint256) {
        require(isCandidate[_candidate], "Candidate does not exist");
        return candidateVotes[_candidate];
    }

    function endVoting() public onlyOwner {
        votingEnded = true;
    }

    function getWinner() public view returns (address) {
        require(votingEnded, "Voting is still ongoing");

        address winner;
        uint256 highestVotes = 0;

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidateVotes[candidates[i]] > highestVotes) {
                highestVotes = candidateVotes[candidates[i]];
                winner = candidates[i];
            }
        }

        return winner;
    }
}
