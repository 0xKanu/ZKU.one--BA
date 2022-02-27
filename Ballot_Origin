// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
/// @title Voting with delegation.
contract Ballot {
  
    struct Voter {
        uint weight; // weight is accumulated by dlegation
        bool voted ; // if true, that person has already voted 
        address delegate; // person delegated to    
        uint vote;        //  index of the voted proposal
    }
  
    struct Proposal {
        bytes32 name;       // short name (up to 32 bytes)
        uint voteCount;     // number of accumulated votes
    }
    address public chairperson;
    
   
    mapping(address => Voter) public voters;

    
    Proposal[] public proposals;

   
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1; 
    
        for (uint i = 0; i < proposalNames.length; i++ ){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) external {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }


function delegate(address to) external {
    // assigns refereence 
    Voter storage sender = voters[msg.sender];
    require(!sender.voted, "You already Voted.");

    require(to != msg.sender, "Self-delegation is disallowed.");

    // Forward the delegation as long as '
    // 'to' also delgated.
    // In general, such loops are very dangerous,
    // because if they run too long, they might 
    // need more gas than what is available in a block.
    // In this case, the delegation will nit be executed,
    // vut in other situations, such loops might
    // cause a contract to get "stuck" completely.
    while (voters[to].delegate != address(0)) {
        to =  voters[to].delegate;

        //We found a loop in delegation, not allowed.
        require(to != msg.sender, "Found loop in delegation.");   
    }

    // Single 'sender' is a reference, this 
    // modifies 'voters[msg.sender].voted'
    Voter storage delegate_ = voters[to];

    //Voters cannot delegate to wallets that cannot vote.
    require(delegate_.weight >= 1);
    sender.voted = true;
    sender.delegate = to;
    if (delegate_.voted){
        // If the delegate did not vote yet,
        // add to her weight.
      proposals[delegate_.weight].voteCount += sender.weight;
    }else{
        // If the delegate did not vote yet,
        // add to her weight.
        delegate_.weight += sender.weight;
    }    
}
/// Give your vote (including votes delegated to you)
/// to your proposal 'proposals[proposal].name'.
function vote(uint proposal) external {
    Voter storage sender = voters[msg.sender];
    require(sender.weight != 0, "Has no right to vote");
    require(!sender.voted, "Already voted.");
    sender.voted = true;
    sender.vote = proposal;
     // If 'proposal' is out of the range of the array,
     // this will throw automatically and revert all 
     // changes.
     proposals[proposal].voteCount += sender.weight;
}

/// @dev Computes the winning propsal taking all
/// previous votes into account.
function winningProposal() public view
 returns (uint winningProposal_)
{
    uint winningVoteCount = 0;
    for (uint p = 0; p < proposals.length; p++){
        if (proposals[p].voteCount > winningVoteCount) {
         winningVoteCount = proposals[p].voteCount;
         winningProposal_ = p;
        }   
    }
}

//Calls winningProposal() function to get the index
// of the winner contained in the proposals array and then 
// returns the name off the winner.
function winnerName() external view
        returns (bytes32 winnerName_)
        {
            winnerName_ = proposals[winningProposal()].name;
        }
}
