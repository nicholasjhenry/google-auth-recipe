# Google Authentication Setup

## Summary

1. Create a **Project** (unless adding the application to an existing project)
2. Create an **OAuth Consent Screen**
3. Create a **Client**
4. Specify **Data Access** (i.e. scopes)

## Steps

Visit https://console.developers.google.com/

![Google Cloud Console welcome page with APIs & Services highlighted under Quick Access](./assets/image-20250128152128791.png)

Access **API & Services Dashboard**:

![APIs & Services dashboard with sidebar showing Credentials and OAuth consent screen options](./assets/image-20250128151422513.png)

Create a **Project**. Take note if you would like to change the Project ID this cannot be changed later.

![New Project form with Project name, Organization, and Location fields](./assets/image-20250128151632591.png)

Or if a project already exists, select "Create project" in the project drop-down menu:

![Select a project dialog with New project button in the top right](./assets/image-20260308110620530.png)

Confirmation screen, ensure the new project is current in the project drop-down menu:

![Project creation confirmation notification with Select Project link](./assets/image-20250128151829275.png)

Navigate to the **OAuth Consent Screen**:

![Google Auth Platform overview showing "not configured yet" with Get Started button](./assets/image-20250128152259453.png)

![OAuth Overview showing Metrics section with Create OAuth Client button](./assets/image-20250128154501673.png)

![Project configuration step 1 - App Information with App name and User support email fields](./assets/image-20250128152411175.png)

![Project configuration step 2 - Audience selection with Internal and External options](./assets/image-20250128152437857.png)

![Project configuration step 3 - Contact Information with email addresses field](./assets/image-20250128154409539.png)

![Project configuration step 4 - Finish with Google API Services User Data Policy agreement](./assets/image-20250128154425099.png)

Create a **Client**:

![Clients page with Create Client button and empty OAuth clients list](./assets/image-20250128160423992.png)

If you haven't configured the **OAuth Consent screen**, you'll see this:

![Create OAuth client ID page with warning to configure consent screen first](./assets/image-20250128154701129.png)

- Don't need Authorized JavaScript origins unless doing some sort of Javascript application
- Use http://localhost:4000/auth/google/callback to test locally

![Client ID for Web application form with Authorized redirect URIs including localhost callback](./assets/image-20250128172004521.png)

![Clients list showing the newly created OAuth 2.0 Web application client](./assets/image-20250128164244277.png)

Copy the Client ID and Client Secret for the application:

![Client details dialog showing Client ID, Client secret, and Download JSON option](./assets/image-20250128164308432.png)

Configure the environgment with the credentials for `.env`, see `.env.template` to get started.

Specify scopes under **Data Access**:

![Update selected scopes dialog with email, profile, and openid scopes checked](./assets/image-20250128163347221.png)

![Data Access page showing configured non-sensitive scopes for email, profile, and openid](./assets/image-20250128163456786.png)
