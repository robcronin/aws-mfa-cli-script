import { profiles } from "./aws-mfa-profiles.mjs";
import { exec } from "child_process";

if (process.argv.length < 3) {
  console.log(Object.keys(profiles));
} else {
  const profileId = process.argv[2];
  const profile = profiles[profileId];
  const code = process.argv[3];
  const defaultArg = process.argv[4];

  const myShellScript = exec(
    `sh {ABSOLUTE_PATH_TO_REPO}/aws-mfa-helpers/aws-mfa.sh ${profile.awsProfile} ${profile.mfaArn} ${code} ${defaultArg}`
  );
  myShellScript.stdout.on("data", (data) => {
    console.log(data);
  });
  myShellScript.stderr.on("data", (data) => {
    console.error(data);
  });
}
