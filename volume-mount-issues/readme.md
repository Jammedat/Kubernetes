We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue:



The pod name is nginx-phpfpm and configmap name is nginx-config. Identify and fix the problem.


Once resolved, copy /home/thor/index.php file from the jump host to the nginx-container within the nginx document root. After this, you should be able to access the website using Website button on the top bar.

Link to the solution:
https://github.com/kodekloudhub/community-faq/blob/main/docs/kodekloud-engineer/level-1/kubernetes/14-resolve-volume-mounts.md