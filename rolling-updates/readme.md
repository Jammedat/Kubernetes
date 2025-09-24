### Execute a rolling update for this application, integrating the nginx:1.19 image. The deployment is named nginx-deployment. Ensure all pods are operational post-update.

### 🔧 Steps to Perform Rolling Update

1. **Check the current deployment**

   ```bash
   kubectl get deployments
   ```

2. **Update the image for the deployment**

   ```bash
   kubectl set image deployment/nginx-deployment nginx-container=nginx:1.19
   ```

   * `deployment/nginx-deployment` → name of the deployment

   * `nginx-container` → container name inside the deployment spec

   * `nginx:1.19` → new image to use

3. **Verify rollout status** (wait until it finishes)

   ```bash
   kubectl rollout status deployment/nginx-deployment
   ```

4. **Confirm pods are updated and running**

   ```bash
   kubectl get pods -l app=nginx-app
   ```
5. **In case you want to rollback to the previous version**
    
    ```bash
    kubectl rollout undo deployment/nginx-deployment
    ```