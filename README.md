# 🚀 Service-to-Service Identity Federation Using AWS API Gateway and Auth0

This project demonstrates **Identity Federation** using **AWS API Gateway** and **Auth0 as an OpenID Connect (OIDC) Provider**.  
It allows **secure API access using JWT tokens** without storing users in AWS Cognito.

---

## **🔹 Prerequisites**
Before setting up, ensure you have:
- **A GitHub account** (to clone this repo)
- **An AWS account** (to deploy API Gateway and Lambda)
- **An Auth0 account** (to set up authentication)
- **Terraform installed** (for infrastructure deployment)
- **cURL or Postman** (for testing the API)

---

## **🔹 Step 1: Set Up an Auth0 Application**
1. **Go to [Auth0 Dashboard](https://auth0.com/)** and log in.
2. Navigate to **"Applications"** → Click **"Create Application"**.
3. Choose:
   - **Name**: `AWS API Gateway App`
   - **Type**: **Machine to Machine Application**
   - Click **"Create"**.
4. Under **"Select APIs"**, enable **"Auth0 Management API"** → Click **"Authorize"**.
5. **Copy the following credentials** (You’ll need them later):
   - **Client ID**
   - **Client Secret**

---

## **🔹 Step 2: Set Up an Auth0 API (Resource Server)**
1. Go to **"APIs"** in Auth0.
2. Click **"Create API"**.
3. Configure:
   - **Name**: `AWS API Gateway Auth`
   - **Identifier**: `https://your-api.example.com` _(This is the Audience)_
   - **Signing Algorithm**: `RS256`
   - Click **"Create"**.
4. **Copy the API Identifier** (This is the **Audience**).

---

## **🔹 Step 3: Get Your Issuer URL**
1. Navigate to **Auth0 Dashboard** → **APIs**.
2. Select your newly created API.
3. **Find the "Issuer URL"**, which looks like: https://YOUR_TENANT_ID.us.auth0.com/ (You can find this in the Auth0 management API as well. Or get your tenant id from general settings and replace it in this url)
(This will be used in Terraform as `oidc_issuer`.)

---

## **🔹 Step 4: Deploy AWS Infrastructure Using Terraform**
1. Clone this repository:
2. terraform init
3. terraform plan
4. terraform apply

Login to aws console and copy the API Gateway invoker URL. (Check once if the lambda function has the trigger correctly setup. Else manually setup the API Gateway Trigger)

## **🔹 Step 5: TESTING - Get a JWT Token from Auth0** 
In API Gateway API, the authorizer should be attached with the correct issuer url and audience value from auth0 setup made initially. 

curl --request POST \
  --url 'https://YOUR_TENANT.auth0.com/oauth/token' \
  --header 'content-type: application/json' \
  --data '{
    "client_id": "YOUR_CLIENT_ID",
    "client_secret": "YOUR_CLIENT_SECRET",
    "audience": "https://your-api.example.com",
    "grant_type": "client_credentials"
  }'

## **🔹 Step 6: Test the Protected API**
1. Copy the access token from the previous response.
2. curl --request GET \
  --url 'https://xyz.execute-api.us-east-1.amazonaws.com/protected' \
  --header 'Authorization: Bearer YOUR_ACCESS_TOKEN'

If successful, you should get,
{
  "message": "JWT Token Verified Successfully!"
}
