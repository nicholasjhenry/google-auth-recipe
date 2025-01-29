# Google Authentication Setup

## Summary

1. Create a **Project** (unless adding the application to an existing project)
2. Create an **OAuth Consent Screen**
3. Complete **Branding** (required?)
4. Create a **Client**
5. Specify **Data Access** (i.e. scopes)

## Steps

Visit https://console.developers.google.com/

![image-20250128152128791](./assets/image-20250128152128791.png)

Access **API & Services Dashboard**:

![image-20250128151422513](./assets/image-20250128151422513.png)

Create a **Project**. Take note if you would like to change the Project ID this cannot be changed later.

![image-20250128151632591](./assets/image-20250128151632591.png)

Confirmation screen:

![image-20250128151829275](./assets/image-20250128151829275.png)

Navigate to the **OAuth Consent Screen**:

![image-20250128152259453](./assets/image-20250128152259453.png)

![image-20250128154501673](./assets/image-20250128154501673.png)

![image-20250128152411175](./assets/image-20250128152411175.png)

![image-20250128152437857](./assets/image-20250128152437857.png)

![image-20250128154409539](./assets/image-20250128154409539.png)

![image-20250128154425099](./assets/image-20250128154425099.png)



Complete **Branding** (I don't think this is required):

![image-20250128154743770](./assets/image-20250128154743770.png)



Create a **Client**:

![image-20250128160423992](./assets/image-20250128160423992.png)

If you haven't configured the **OAuth Consent screen**, you'll see this:

![image-20250128154701129.png](./assets/image-20250128154701129.png)

- Don't need Authorized JavaScript origins unless doing some sort of Javascript application
- Use http://localhost:4000/auth/google/callback to test locally

![image-20250128172004521](./assets/image-20250128172004521.png)





![image-20250128164244277](./assets/image-20250128164244277.png)

Copy the Client ID and Client Secret for the application:

![image-20250128164308432](./assets/image-20250128164308432.png)



Specify scopes under **Data Access**:

![image-20250128163347221](./assets/image-20250128163347221.png)



![image-20250128163456786](./assets/image-20250128163456786.png)





