const hre = require("hardhat");

async function main() {
  const Voting = await hre.ethers.getContractFactory("Voting");
  const voting = await Voting.attach(
    "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0"
  );

  await voting.addCandidate("Alice");
  await voting.addCandidate("Bob");

  console.log(await voting.getTotalCandidates()); // Output: 2
  console.log(await voting.getCandidate(0)); // Output: ["Alice", 0]
  console.log(await voting.getCandidate(1));
  await voting.vote(1);
  console.log(await voting.getCandidate(1));
}

main().catch((error)=>{
    console.error(error);
    process.exit(1);
})