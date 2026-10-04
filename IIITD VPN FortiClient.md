# IIITD Domain Account & VPN Setup

A simple reference guide for students and users who need to configure their **IIITD Domain Account** and connect to the **IIITD VPN** using FortiClient.


---

## 📋 Overview

An IIITD Domain Account can be used to access various institute IT services, including:

- 🌐 Internet access
- 🔐 VPN access
- 🖥️ Lab desktop access
- 🏫 Internal institute services
- 📦 Other IT resources provided by IIITD

Your Domain ID and password are provided separately by the **IIITD IT Helpdesk**.

---

# 🔑 IIITD Domain Account

Your IIITD Domain Account generally consists of:

```text
Domain ID       → Your IIITD username
Domain Password → Your private password
```

### ⚠️ Never put the password in GitHub

Do **not** store your password in:

```text
README.md
.git files
Shell scripts
Configuration files
Source code
Screenshots
GitHub Issues
GitHub Wiki
Public Gists
```

Enter the password only when the official service requests it.

---

# 🔄 Change Your Password

IIITD recommends changing default passwords at the first login.

The IIITD domain login portal is available through the institute network/intranet:

[IIITD Domain Login Portal](http://domainlogin.iiitd.edu.in/?utm_source=chatgpt.com)

> The portal may only be accessible when connected to the IIITD network or through an appropriate IIITD VPN connection.

---

# 🌐 IIITD VPN

IIITD provides VPN access using **FortiClient**.

VPN access can be useful when you need to access services that are available only from the IIITD internal network.

---

## 💻 Install FortiClient

### Windows

[FortiClient VPN for Windows](https://links.fortinet.com/forticlient/win/vpnagent?utm_source=chatgpt.com)

### macOS

[FortiClient VPN for macOS](https://links.fortinet.com/forticlient/mac/vpnagent?utm_source=chatgpt.com)

> Download software only from the official Fortinet source or from instructions provided by IIITD IT.

---

# ⚙️ VPN Configuration

Create a new **SSL-VPN** connection in FortiClient.

Use the following IIITD VPN settings:

| Setting | Value |
|---|---|
| **Connection Name** | `IIITDVPN` |
| **VPN Type** | SSL-VPN |
| **Remote Gateway** | `vpn.iiitd.edu.in` |
| **Custom Port** | `10443` |
| **Username** | Your IIITD Domain ID |
| **Password** | Your IIITD Domain Password |

### Configuration Example

```text
Connection Name : IIITDVPN
VPN Type        : SSL-VPN
Remote Gateway  : vpn.iiitd.edu.in
Custom Port     : 10443
Username        : <YOUR_IIITD_DOMAIN_ID>
Password        : <YOUR_PRIVATE_PASSWORD>
```

⚠️ **Do not replace the placeholders with your real credentials in this README.**

---

# 🔗 Official VPN Documentation

For detailed VPN installation and configuration instructions, refer to the official IIITD documentation:

[IIITD VPN Configuration Guide](https://it.iiitd.edu.in/static/VPN.pdf?utm_source=chatgpt.com)

---

# 🔌 Connecting to IIITD VPN

The general process is:

```text
Install FortiClient
       │
       ▼
Create IIITDVPN connection
       │
       ▼
Set VPN gateway
vpn.iiitd.edu.in
       │
       ▼
Set port
10443
       │
       ▼
Enter IIITD Domain credentials
       │
       ▼
Connect
       │
       ▼
IIITD Internal Network
```

---

# 🖥️ Accessing Internal Resources

After establishing the VPN connection, services restricted to the IIITD network may become accessible.

Depending on the service, additional requirements may apply, such as:

- MAC registration
- Institute authorization
- Specific software
- Department/lab permissions
- Additional authentication

If a service does not work after connecting to VPN, contact the IIITD IT Helpdesk.

---

# 📦 Common Software

IIITD also provides access to common software through its internal FTP service.

```text
ftp.iiitd.edu.in
```

> Access may require an IIITD network connection and MAC registration.

Do not upload or distribute proprietary institute software outside the permissions provided by IIITD.

---

# 🏫 IIITD IT Portal

For information about available IT services:

[IIITD IT Portal](http://it.iiitd.edu.in/?utm_source=chatgpt.com)

The portal provides information related to:

- Network services
- VPN
- IT accounts
- Software
- IT policies
- Technical support

---

# 📜 IT Policies

Users are expected to comply with IIITD IT policies and applicable laws.

### Acceptable Use of Information Technology Resources

[IIITD Acceptable Use Policy](https://it.iiitd.edu.in/static/Acceptable_Use_of_Information_Technology_Resources.pdf?utm_source=chatgpt.com)

### IIITD IT Policy

[IIITD IT Policy](https://it.iiitd.edu.in/static/IT%20Policy.pdf?utm_source=chatgpt.com)

Please read the applicable policies before using institute computing and network resources.

---

# 🆘 IT Support

For IT-related problems, contact the **IIITD IT Helpdesk**.

### Email

`helpdesk@iiitd.ac.in`

### Phone

`011-26907576`

When reporting an issue, provide:

- Error message
- Operating system
- FortiClient version
- Approximate time of failure
- Relevant configuration details

**Never send your password to the helpdesk.**

---

# 🔐 Security Best Practices

Follow these practices when using your IIITD account.

### 1. Never share your password

Do not send your password through:

- WhatsApp
- Telegram
- Email
- Discord
- GitHub
- Screenshots
- Chat messages

### 2. Use a strong password

Avoid passwords based on:

```text
Name
Roll number
Date of birth
Phone number
College ID
Common words
```

### 3. Do not commit secrets

Before pushing a repository:

```bash
git status
```

Review your changes:

```bash
git diff
```

Search for possible secrets:

```bash
grep -RniE "password|passwd|secret|token|api[_-]?key" .
```

Review the results before committing.

### 4. Use `.gitignore`

For projects containing local configuration, consider:

```gitignore
.env
*.secret
credentials.txt
password.txt
secrets/
```

---

# 🚨 If You Accidentally Expose a Credential

If a real password, token, key, or other credential is accidentally uploaded:

### Immediately:

1. **Change or revoke the credential.**
2. Remove the secret from the repository.
3. Check whether it exists in Git history.
4. Contact the appropriate IT/security team if necessary.

> Simply deleting the file from the latest commit does **not necessarily remove the secret from Git history**.

---

# 📁 Recommended Public Repository Structure

A public repository containing this guide can remain simple:

```text
iiitd-vpn-guide/
│
├── README.md
├── LICENSE
└── .gitignore
```

No personal credentials or private configuration files are required.

---

# ❓ Frequently Asked Questions

### Can I put my IIITD Domain ID in this repository?

It is better to keep personal account identifiers out of a public repository unless there is a specific reason to publish them.

Use:

```text
<YOUR_IIITD_DOMAIN_ID>
```

instead.

### Can I put my password in a `.env` file?

You can use a local `.env` file for development, but **never commit it to GitHub**.

Add it to `.gitignore`:

```gitignore
.env
```

### Can I share the VPN configuration?

Yes. The general VPN configuration can be documented.

For example:

```text
Connection Name : IIITDVPN
Gateway         : vpn.iiitd.edu.in
Port            : 10443
```

Do **not** include personal credentials.

### Does this repository provide VPN access?

No.

This repository is only a **documentation/reference guide**. You still need:

- A valid IIITD account
- FortiClient
- Network connectivity
- Any required institute permissions

---

# ⚠️ Disclaimer

This is an **unofficial community/student reference guide** and is not an official IIITD IT publication.

VPN configuration, software availability, account policies, and network requirements may change. Always prefer the latest instructions from the official IIITD IT Team.

For authoritative assistance, contact:

`helpdesk@iiitd.ac.in`

---

## ⭐ Useful Links

| Resource | Link |
|---|---|
| IIITD IT Portal | [IT Portal](http://it.iiitd.edu.in/?utm_source=chatgpt.com) |
| Domain Login | [Domain Login Portal](http://domainlogin.iiitd.edu.in/?utm_source=chatgpt.com) |
| VPN Guide | [VPN Documentation](https://it.iiitd.edu.in/static/VPN.pdf?utm_source=chatgpt.com) |
| FortiClient — Windows | [Download FortiClient for Windows](https://links.fortinet.com/forticlient/win/vpnagent?utm_source=chatgpt.com) |
| FortiClient — macOS | [Download FortiClient for macOS](https://links.fortinet.com/forticlient/mac/vpnagent?utm_source=chatgpt.com) |
| IT Helpdesk | `helpdesk@iiitd.ac.in` |

---

**Made for students and users who need a quick reference for IIITD network and VPN setup.**
