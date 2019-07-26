Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E5D76720
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGZNRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 09:17:01 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38551 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfGZNRB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 09:17:01 -0400
Received: from rabammel.molgen.mpg.de (rabammel.molgen.mpg.de [141.14.30.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CD2E0201A3C2E;
        Fri, 26 Jul 2019 15:16:58 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: BTRFS: Kmemleak errrors with do_sys_ftruncate
Message-ID: <8c9b2f4e-252c-fee7-ef52-4ec2b9b54042@molgen.mpg.de>
Date:   Fri, 26 Jul 2019 15:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030009090705070102020303"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030009090705070102020303
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


On a Power 8 server

    Linux power 5.3.0-rc1+ #1 SMP Fri Jul 26 11:34:28 CEST 2019 ppc64le p=
pc64le ppc64le GNU/Linux

Kmemleak reports the warnings below.

```
$ sudo more /sys/kernel/debug/kmemleak
unreferenced object 0xc00000f290866130 (size 80):
  comm "networkd-dispat", pid 7630, jiffies 4294903138 (age 6540.748s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
    40 61 86 90 f2 00 00 c0 00 00 00 00 00 00 00 00  @a..............
  backtrace:
    [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
    [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
    [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
    [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [b=
trfs]
    [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
    [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
    [<000000008f89382e>] notify_change+0x218/0x5b0
    [<00000000fc1ffb03>] do_truncate+0x9c/0x140
    [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
    [<00000000f67bba86>] system_call+0x5c/0x70
unreferenced object 0xc000007f9cc555f0 (size 80):
  comm "unattended-upgr", pid 8069, jiffies 4294903488 (age 6539.396s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
    00 56 c5 9c 7f 00 00 c0 00 00 00 00 00 00 00 00  .V..............
  backtrace:
    [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
    [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
    [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
    [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [b=
trfs]
    [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
    [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
    [<000000008f89382e>] notify_change+0x218/0x5b0
    [<00000000fc1ffb03>] do_truncate+0x9c/0x140
    [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
    [<00000000f67bba86>] system_call+0x5c/0x70
unreferenced object 0xc000007fa1431fe0 (size 80):
  comm "lxd", pid 8347, jiffies 4294904066 (age 6537.104s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
    f0 1f 43 a1 7f 00 00 c0 00 00 00 00 00 00 00 00  ..C.............
  backtrace:
    [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
    [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
    [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
    [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [b=
trfs]
    [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
    [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
    [<000000008f89382e>] notify_change+0x218/0x5b0
    [<00000000fc1ffb03>] do_truncate+0x9c/0x140
    [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
    [<00000000f67bba86>] system_call+0x5c/0x70
unreferenced object 0xc000007f98359470 (size 80):
  comm "lxd", pid 8347, jiffies 4294904738 (age 6534.416s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
    80 94 35 98 7f 00 00 c0 00 00 00 00 00 00 00 00  ..5.............
  backtrace:
    [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
    [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
    [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
    [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [b=
trfs]
    [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
    [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
    [<000000008f89382e>] notify_change+0x218/0x5b0
    [<00000000fc1ffb03>] do_truncate+0x9c/0x140
    [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
    [<00000000f67bba86>] system_call+0x5c/0x70
unreferenced object 0xc000007f9e7078f0 (size 80):
  comm "landscape-sysin", pid 10187, jiffies 4295061226 (age 5908.520s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
    00 79 70 9e 7f 00 00 c0 00 00 00 00 00 00 00 00  .yp.............
  backtrace:
    [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
    [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
    [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
    [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [b=
trfs]
    [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
    [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
    [<000000008f89382e>] notify_change+0x218/0x5b0
    [<00000000fc1ffb03>] do_truncate+0x9c/0x140
    [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
    [<00000000f67bba86>] system_call+0x5c/0x70
unreferenced object 0xc00000f29b4f48d0 (size 80):
  comm "landscape-sysin", pid 14433, jiffies 4295569439 (age 3876.396s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
    e0 48 4f 9b f2 00 00 c0 00 00 00 00 00 00 00 00  .HO.............
  backtrace:
    [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
    [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
    [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
    [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [b=
trfs]
    [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
    [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
    [<000000008f89382e>] notify_change+0x218/0x5b0
    [<00000000fc1ffb03>] do_truncate+0x9c/0x140
    [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
    [<00000000f67bba86>] system_call+0x5c/0x70
```

I believe these have been present for some releases already, but Kmemleak=

was broken until now on that system, so that I could only report them now=
=2E


Kind regards,

Paul


--------------ms030009090705070102020303
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTA3MjYxMzE2NThaMC8GCSqGSIb3DQEJBDEiBCB84+zddX9KcTX+Jrl3
k3oHpEU+4TmexS9E+PtUT7R9fjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBABcl
TjW1tzdGbIFyEicprinmEdtESvOmfg95UPcLPIhmsbYbGczDicc/5RWHxhbuq592pI+yy+l2
p4QXEXg1QkYL4H/lTI87js33HzD8HpHF03t4GYOY1Xji48j5RGhHp8+Bf69dmU4hF6YpIiQU
XTZZ60aAkdHuuh4zhqJ7RGK0dyWe6tQSDu9wwhc7hsCcLIcSKtdrPrn4WedY1B7kRQUAYb1E
94N7rhFX6BAPgR/ikt34zqLbDWjAkYvpFCgCT9Yoo/3BAJewoWMbIuqAtVAggWpOeSqkdNmR
rYpgFob2Z5D/Wf4J0E0lfssuEvO652+taHTMgjNipN6wGbQzA4cAAAAAAAA=
--------------ms030009090705070102020303--
