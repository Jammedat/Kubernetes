Create a cronjob named devops.
Set Its schedule to something like */3 * * * *. You can set any schedule for now.
Name the container cron-devops.
Utilize the httpd image with latest tag (specify as httpd:latest).
Execute the dummy command echo Welcome to xfusioncorp!.
Ensure the restart policy is OnFailure.