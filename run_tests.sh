d=$(date)
fmt="%-30s %s\n"

echo "##########################################################"
printf "${fmt}" "CDE autoscaling test launched."
printf "${fmt}" "launch time:" "${d}"
echo "##########################################################"

cde resource create --name tests
cde resource upload --name tests --local-path tests/01_cde_pi_demo_fast.py

for i in {1..30}; do cde job delete --name pitest-$i; cde job create --type spark --name pitest-$i --application-file 01_cde_pi_demo_fast.py --mount-1-resource tests; cde job run --name pitest-$i; sleep 1; done

cde resource delete --name tests

echo "##########################################################"
printf "${fmt}" "CDE autoscaling test completed."
printf "${fmt}" "completion time:" "${d}"
echo "##########################################################"
