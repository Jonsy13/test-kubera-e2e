# GUI Test Cases For Authentication in Kubera-Core

<b>tcid:</b> GUI-Auth <br>
<b>name:</b> Local Authentication Testcases Using Browser<br>

### Prerequisites

    • Kubera should be installed on Cluster.
    • Cypress should be installed and running on Gitlab-Runner.

### Test Case 1:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Kubera-Core Login Page reachability.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Check URL and Content of Page.

#### &nbsp;&nbsp;&nbsp;Expected Output

     Kubera-Core Reachability successful

### Test Case 2:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Administrator Login.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login with correct Administrator Credentials.
- Verify URL and Content of HomePage.

#### &nbsp;&nbsp;&nbsp;Expected Output

     Administrator Login successful

### Test Case 3:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Administrator Login with wrong username.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login with wrong username
- Verify error message "Wrong Credentials - Try again with correct username or password".

#### &nbsp;&nbsp;&nbsp;Expected Output

     User should be prompted with Correct Error message.

### Test Case 4:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Administrator Login with wrong password.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login with wrong password.
- Verify error message "Wrong Credentials - Try again with correct username or password".

#### &nbsp;&nbsp;&nbsp;Expected Output

     User should be prompted with Correct Error message.

### Test Case 5:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Change Password functionality with password provided same as current password.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login administrator.
- Go to Settings page by clicking on sidebar tab.
- Try changing password by giving new password same as old password.

#### &nbsp;&nbsp;&nbsp;Expected Output

     User should be prompted with Correct Error message and change password button should be disabled .

### Test Case 6:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Change Password functionality with wrong current password.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login administrator.
- Go to Settings page by clicking on sidebar tab.
- Try changing password by giving wrong current password.

#### &nbsp;&nbsp;&nbsp;Expected Output

     User should be prompted with Correct Error message "Error: User authentication failed".

### Test Case 7:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Change Password functionality with wrong confirmation password.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login administrator.
- Go to Settings page by clicking on sidebar tab.
- Try changing password by giving wrong confirmation password.

#### &nbsp;&nbsp;&nbsp;Expected Output

     Change password button should be disabled.

### Test Case 8:

#### &nbsp;&nbsp;&nbsp;Details

     Test case to verify Change Password functionality with correct credentials.

#### &nbsp;&nbsp;&nbsp;Steps Performed in the test

- Open Kubera URL in Browser
- Once UI is accessible, Login administrator.
- Go to Settings page by clicking on sidebar tab.
- Change password with correct details.
- Try logging in with new password.
- Once verified, reset the password to default one.

#### &nbsp;&nbsp;&nbsp;Expected Output

     change password should be verified and password should be resetted.
