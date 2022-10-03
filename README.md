# Leader-Lidar Overview



## Initial Exam Notes Below (To be marked as "PASSED")



#### 1. Create a chart drawing for each pipeline -- PASSED
#### 2. Create a "test" branch for each repo not to mess up with other branches. -- PASSED
#### 3. Remember to set up correct permissions in settings.xml file (already done but needs double-ckeck) -- PASSED
#### 4. Start with:
###### 	I. Telemetry (package) -- PASSED
###### 	II. Analytics (package) -- PASSED
###### 	III. End-to-End Testing -- PASSED
###### 	IV. Product (zip file)
#### 5. Exam Day 1 --> Today's goal is to finish Step 1 and Step 2, as well as to have Analytics and Telemetry packages available in artifactory (with release and testing processes ready) -- PASSED
#### 6. Exam Day 2 --> Final purpose is to a have a fully functional, integrated CI and E2E testing process for the whole Leader-Lidar project


## Final Exam Notes Below (To be marked as "PASSED")


#### 1. Set up 4 repositories in GitLab. Integrate with JFrog Artifactory (by adjusting pom.xml files) -- PASSED

#### 2. Check if I can do "mvn deploy" with all repos to artifactory (mind the order of deployment) - 1. Telemetry 2. Analytics 3. E2E 4. Product -- PASSED

#### 3. Create CI (Jenkinsfile), Release, and E2E Testing. -- PASSED

#### 4. CI details:
###### 	a. Telemetry: -- PASSED
		- "feature/\*" branches -- passing build and unit tests for every commit (triggered by push); if commit message is with "#e2e", e2e tests for telemetry will be executed using analytics:99-SNAPSHOT.jar -- PASSED
		- "master" branch -- passing build, unit tests, e2e tests, and publishes to artifactory (mvn deploy -DskipTests) for every commit (triggered by push) -- PASSED
		- "release/\*" branches -- attempting a release (step 5); no E2E tests! -- PASSED
###### 	b. Analytics:
		- "feature/\*" branches -- passing build and unit tests for every commit (triggered by push); e2e tests for analytics will be executed using telemetry:99-SNAPSHOT.jar -- PASSED
		- "master" branch -- passing build, unit tests, e2e tests, and publishes to artifactory (mvn deploy -DskipTests) for every commit (triggered by push) -- PASSED
		- "release/\*" branches -- attempting a release (step 5) -- PASSED
###### 	c. Product:
		- "release/\*" branches -- triggered by push; the only branch for CI; attempting a release (step 5) -- PASSED
###### 	d. Testing:
		- "master" branch -- triggered by push; the only branch for testing CI; passing build, e2e tests and publishes to artifactory (mvn deploy -DskipTests) -- PASSED

#### 5. Releases
###### 	a. "release/x.y" branch results in version --> "x.y.z" (the versioning logic) -- PASSED
###### 	b. release branches' CI overwrite version in pom.xml (using "mvn versions:set -DnewVersion=") -- PASSED
###### 	c. Product release -- Always perform E2E tests; use latest "analytics:x.y" and "telemetry:x.y" in the product zip; for that use "mvn dependency:list" to make sure that other "com.lidar" dependencies are on x.y (meaning, telemetry, analytics, and maybe some others) -- PASSED
###### 	d. Analytics release -- Always perform E2E tests; use latest "telemetry:x.y" for that -- PASSED
###### 	e. Telemetry release -- Do not perform E2E tests -- PASSED
###### 	f. On successful E2E testing: -- PASSED
		- publish latest version to artifactory (using "mvn deploy -DskipTests")
		- tag the new version and push it to the repo (git tag x.y.z --> git push --tags)

#### 6. E2E Testing
###### 	a. Fetch the ".jar" files for testing: -- PASSED
		- Analytics -- find the first testing file in the target folder and download the second one from artifactory (e.g. by using curl or wget)
		- Product -- find the testing files in the zip file
###### 	b. Run test simulator: -- PASSED
		- Make sure that simulator, telemetry, and analytics ".jar" files are in its classpath (using "java -cp <jar1>:<jar2>:<jar3>com.lidar.simulation.Simulator", these are jar1 - analytics, jar2 - telemetry, jar3 - simulator)
###### 	c. Inititally run "tests-sanity.txt" -- PASSED
###### 	d. Ultimately run all tests found in tests.txt (tests-full.txt); do it fast! -- PASSED
###### 	e. Simulator should return 0 status code on finish -- it means SUCCESSFUL! -- PASSED


sh "mvn versions:use -DnewVersion=\"[\${MINOR_VERSION}.\*,)\""

sh "mvn versions:use-latest-versions"
curl -u admin:APMwPGCGPEk4wKid1LpRKyDBqY -O http://ec2-3-67-195-219.eu-central-1.compute.amazonaws.com:8081/artifactory/libs-snapshot-local/com/lidar/analytics/99-SNAPSHOT/analytics-99-20220929.110131-1.jar


                        // mvn versions:set-property -Dproperty=telemetry.version -DnewVersion="[$MINOR_VERSION,)"
                        // mvn versions:set-property -Dproperty=analytics.version -DnewVersion="[$MINOR_VERSION,)"


                         -DincludesList=\"com.lidar:simulator:jar:[$MINOR_VERSION,)\

 (,${project.version}]



 nginx with load balancers messed up --> read about it
 inernet gateway --> readabout it more


 http://ec2-3-67-195-219.eu-central-1.compute.amazonaws.com:8081/artifactory/libs-release-local/com/lidar/telemetry/ --> curl latest