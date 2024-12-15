// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Admin address
    address public admin;

    // Candidate structure
    struct Candidate{
        string name;
        uint256 voteCount;
    }

    // State variables
    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    // Event declarations
    event CandidateAdded(string name);
    event Voted(address voter, uint256 candidateIndex);

    // Modifier to restrict access
    modifier onlyAdmin(){
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor(){
        admin = msg.sender;
    }

    // Function to add candidate
    function addCandidate(string memory _name) public onlyAdmin {
        candidates.push(Candidate({name :_name,voteCount:0}));
        emit CandidateAdded(_name);
    }

    // Function to vote for a candidate
    function vote(uint256 _candidateIndex) public {
        require(!hasVoted[msg.sender],"You have already voted");
        require(_candidateIndex < candidates.length,"Invalid candidate index");

        hasVoted[msg.sender] = true;
        candidates[_candidateIndex].voteCount++;

        emit Voted(msg.sender,_candidateIndex);
    }

    // Function to get candidate details
    function getCandidate(uint256 _index) public view returns (string memory,uint256){
        require(_index < candidates.length,"Invalid candidate index");
        Candidate memory candidate = candidates[_index];
        return (candidate.name,candidate.voteCount);
    }

    // Function to get total number of candidates
    function getTotalCandidates() public view returns(uint256){
        return candidates.length;
    }
    

}