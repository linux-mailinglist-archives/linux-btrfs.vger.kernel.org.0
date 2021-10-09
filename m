Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C770427991
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Oct 2021 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhJILqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Oct 2021 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhJILqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Oct 2021 07:46:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDDC061570
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Oct 2021 04:44:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e12so37949251wra.4
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Oct 2021 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u7begFOS2Vsifx/924OujAg6NcZP1dQCAXJ65/jDny0=;
        b=Kf6q/a2dPdZ+Lf4L3lix0bEFztUKzO4XIjvAFskyEg9f8gd4t0tWolokFBkZ4Fjsd6
         EaQWTI23ptxeY5kOmy26/WOBx9oWjLehdWZOdP2Dy3VhpRsg1STFNfppo9k8h8d+ojjy
         8HsWDF4C2CxaUO6pu5e2TIRd1E/K+NirQ+PKELIjVvphVtzmU3bfs6Tu9oScv2dHG4b7
         ieeT/7EZz7OgcClu16yRVbSn/6thxSYbyo5ZG8mOCKd6mTZ96O/agb29moV63OgVyHOS
         krwptmpK9lwdNgwhDotCToePMcyIVQDGz3bJPn3DohoUq4oal9UVo8LcyRr6rhuBNAFm
         9oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u7begFOS2Vsifx/924OujAg6NcZP1dQCAXJ65/jDny0=;
        b=bIYKkaCH0Asvt3EOCHO5l4LqzryMvB6roTKSisDlOPLBPwRHt9Zk4ZBguVfV0CTK+9
         4yBAuygORUtcTzdnx9K82dnvK4U+00mWc6lE2mutm3/hnnZuD06+qUCakCKFhD6WuuW8
         fYXVyEiCGPbxHdIUWGQRf1I8lDH8Zhu1qrcHmuRiO4z5FDiJWiGIGt7tNxf7QjzixMKH
         r11YjxCq8a7lAFHX3My6x/cGmDWjCKxXA6N9Ns1JSEuC47iL+ESy8eTFaLWWomNCbcF2
         mBkmECfdkhm6+15z9cjKhJL5Dz9MatYfsmO+mbWK1vbpygaFSMOLVySSzdUok0EaI5Xq
         N29g==
X-Gm-Message-State: AOAM532I6dLc2/v7/r/JCAat8Xgd1CkMRl56P+U37cjyZm8+NyblB3hW
        iEVNkzay/Ex+Zh3IlPWbV3sAVSwE0yeCRtVV0L0aoNEF/QU=
X-Google-Smtp-Source: ABdhPJzvKY6r1hVAjhJN2YTCDdS7LU/QeZuZEvP1AKOEscCi5XjPSp0UelbdBTNEIgK6UYD288e8D2q7roN6464l0so=
X-Received: by 2002:a5d:64af:: with SMTP id m15mr10500380wrp.117.1633779859500;
 Sat, 09 Oct 2021 04:44:19 -0700 (PDT)
MIME-Version: 1.0
From:   FireFish5000 <firefish5000@gmail.com>
Date:   Sat, 9 Oct 2021 06:44:07 -0500
Message-ID: <CADNS_H6MvByBaYQ7h94DMVQUU9ZjANN8bz90km_6DZykBh6mxw@mail.gmail.com>
Subject: Bug / Suspected regression. Multiple block group profiles detected on
 newly created raid1.
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002ad9cc05cdea04cd"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0000000000002ad9cc05cdea04cd
Content-Type: text/plain; charset="UTF-8"

After creating a new btrfs raid1 and was surprised to be greeted with
the warning

WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
WARNING:   Metadata: single, raid1

I asked on the IRC, and darkling directed me to the mailing list
suspecting this was a regression.
I am on 5.14.8-gentoo-dist with btrfs-progs v5.14.1

I have attached a script to reproduce this with temporary images/loop devices,
Along with the full output I received when running the script.

A shortened version of the commands that I ran on my *real drives* and
the relevant output is also provided below for convenience. P at the
end of the device path was inserted incase sleepy joe copies it
thinking its the reproduction script:

# mkfs.btrfs --force -R free-space-tree -L BtrfsRaid1Test -d raid1 -m
raid1 /dev/sdaP /dev/sdbP; mount /dev/sda /mnt/tmp; btrfs filesystem
df /mnt/tmp
btrfs-progs v5.14.1
....truncated....
....truncated....
Data, RAID1: total=1.00GiB, used=0.00B
System, RAID1: total=8.00MiB, used=16.00KiB
Metadata, RAID1: total=1.00GiB, used=176.00KiB
Metadata, single: total=8.00MiB, used=0.00B
GlobalReserve, single: total=3.25MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
WARNING:   Metadata: single, raid1

--0000000000002ad9cc05cdea04cd
Content-Type: text/plain; charset="US-ASCII"; name="btrfsRaid1Test.sh - output.txt"
Content-Disposition: attachment; filename="btrfsRaid1Test.sh - output.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kujp9dh21>
X-Attachment-Id: f_kujp9dh21

IyBHZXQgU3lzdGVtIEluZm8NCnVuYW1lIC1yDQorIHVuYW1lIC1yDQo1LjE0LjgtZ2VudG9vLWRp
c3QNCmJ0cmZzIHZlcnNpb24NCisgYnRyZnMgdmVyc2lvbg0KYnRyZnMtcHJvZ3MgdjUuMTQuMSAN
Cg0KIyMjIyMjIyMjIw0KIyBDcmVhdGUgYmxhbmsgaW1hZ2VzDQpmYWxsb2NhdGUgLWwgMkcgL3Rt
cC90bXBJbWdBDQorIGZhbGxvY2F0ZSAtbCAyRyAvdG1wL3RtcEltZ0ENCmZhbGxvY2F0ZSAtbCAy
RyAvdG1wL3RtcEltZ0INCisgZmFsbG9jYXRlIC1sIDJHIC90bXAvdG1wSW1nQg0KDQojIyMjIyMj
IyMjDQojIFByZXBhcmUgbG9vcGJhY2sgZGV2aWNlcw0KbW9kcHJvYmUgbG9vcA0KKyBtb2Rwcm9i
ZSBsb29wDQpMT09QX0E9IiQobG9zZXR1cCAtLXNob3cgLWZQIC90bXAvdG1wSW1nQSkiDQorKyBs
b3NldHVwIC0tc2hvdyAtZlAgL3RtcC90bXBJbWdBDQorIExPT1BfQT0vZGV2L2xvb3AwDQpMT09Q
X0I9IiQobG9zZXR1cCAtLXNob3cgLWZQIC90bXAvdG1wSW1nQikiDQorKyBsb3NldHVwIC0tc2hv
dyAtZlAgL3RtcC90bXBJbWdCDQorIExPT1BfQj0vZGV2L2xvb3AxDQoNCiMjIyMjIyMjIyMNCiMg
Q3JlYXRlIHJhaWQxDQpta2ZzLmJ0cmZzIC0tZm9yY2UgLVIgZnJlZS1zcGFjZS10cmVlIC1MIFRt
cFJhaWQxIC1kIHJhaWQxIC1tIHJhaWQxICIkTE9PUF9BIiAiJExPT1BfQiINCisgbWtmcy5idHJm
cyAtLWZvcmNlIC1SIGZyZWUtc3BhY2UtdHJlZSAtTCBUbXBSYWlkMSAtZCByYWlkMSAtbSByYWlk
MSAvZGV2L2xvb3AwIC9kZXYvbG9vcDENCmJ0cmZzLXByb2dzIHY1LjE0LjEgDQpTZWUgaHR0cDov
L2J0cmZzLndpa2kua2VybmVsLm9yZyBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCg0KTGFiZWw6ICAg
ICAgICAgICAgICBUbXBSYWlkMQ0KVVVJRDogICAgICAgICAgICAgICA5NmY2YTgyYy1lODBmLTQ1
NjAtOTA0NS0wMjI5ZTYzZjVkNjYNCk5vZGUgc2l6ZTogICAgICAgICAgMTYzODQNClNlY3RvciBz
aXplOiAgICAgICAgNDA5Ng0KRmlsZXN5c3RlbSBzaXplOiAgICA0LjAwR2lCDQpCbG9jayBncm91
cCBwcm9maWxlczoNCiAgRGF0YTogICAgICAgICAgICAgUkFJRDEgICAgICAgICAgIDIwNC43NU1p
Qg0KICBNZXRhZGF0YTogICAgICAgICBSQUlEMSAgICAgICAgICAgMjY0LjAwTWlCDQogIFN5c3Rl
bTogICAgICAgICAgIFJBSUQxICAgICAgICAgICAgIDguMDBNaUINClNTRCBkZXRlY3RlZDogICAg
ICAgeWVzDQpab25lZCBkZXZpY2U6ICAgICAgIG5vDQpJbmNvbXBhdCBmZWF0dXJlczogIGV4dHJl
Ziwgc2tpbm55LW1ldGFkYXRhDQpSdW50aW1lIGZlYXR1cmVzOiAgIGZyZWUtc3BhY2UtdHJlZQ0K
Q2hlY2tzdW06ICAgICAgICAgICBjcmMzMmMNCk51bWJlciBvZiBkZXZpY2VzOiAgMg0KRGV2aWNl
czoNCiAgIElEICAgICAgICBTSVpFICBQQVRIDQogICAgMSAgICAgMi4wMEdpQiAgL2Rldi9sb29w
MA0KICAgIDIgICAgIDIuMDBHaUIgIC9kZXYvbG9vcDENCg0KDQojIyMjIyMjIyMjDQojIE1vdW50
IHRlbXAgcmFpZDENCm1rZGlyIC90bXAvdG1wUmFpZDENCisgbWtkaXIgL3RtcC90bXBSYWlkMQ0K
bW91bnQgIiRMT09QX0EiIC90bXAvdG1wUmFpZDENCisgbW91bnQgL2Rldi9sb29wMCAvdG1wL3Rt
cFJhaWQxDQoNCiMjIyMjIyMjIyMNCiMgUnVuIGJ0cmZzIGRmDQpidHJmcyBmaWxlc3lzdGVtIGRm
IC90bXAvdG1wUmFpZDENCisgYnRyZnMgZmlsZXN5c3RlbSBkZiAvdG1wL3RtcFJhaWQxDQpEYXRh
LCBSQUlEMTogdG90YWw9MjA0Ljc1TWlCLCB1c2VkPTAuMDBCDQpTeXN0ZW0sIFJBSUQxOiB0b3Rh
bD04LjAwTWlCLCB1c2VkPTE2LjAwS2lCDQpNZXRhZGF0YSwgUkFJRDE6IHRvdGFsPTI1Ni4wME1p
QiwgdXNlZD0xMjguMDBLaUINCk1ldGFkYXRhLCBzaW5nbGU6IHRvdGFsPTguMDBNaUIsIHVzZWQ9
MC4wMEINCkdsb2JhbFJlc2VydmUsIHNpbmdsZTogdG90YWw9My4yNU1pQiwgdXNlZD0wLjAwQg0K
V0FSTklORzogTXVsdGlwbGUgYmxvY2sgZ3JvdXAgcHJvZmlsZXMgZGV0ZWN0ZWQsIHNlZSAnbWFu
IGJ0cmZzKDUpJy4NCldBUk5JTkc6ICAgTWV0YWRhdGE6IHNpbmdsZSwgcmFpZDENCg0KIyMjIyMj
IyMjIw0KIyBjbGVhbnVwDQp1bW91bnQgL3RtcC90bXBSYWlkMQ0KKyB1bW91bnQgL3RtcC90bXBS
YWlkMQ0KDQpsb3NldHVwIC0tZGV0YWNoICIkTE9PUF9BIg0KKyBsb3NldHVwIC0tZGV0YWNoIC9k
ZXYvbG9vcDANCmxvc2V0dXAgLS1kZXRhY2ggIiRMT09QX0IiDQorIGxvc2V0dXAgLS1kZXRhY2gg
L2Rldi9sb29wMQ0KDQpzeW5jDQorIHN5bmMNCnJtZGlyIC90bXAvdG1wUmFpZDEvDQorIHJtZGly
IC90bXAvdG1wUmFpZDEvDQpybSAvdG1wL3RtcEltZ0ENCisgcm0gL3RtcC90bXBJbWdBDQpybSAv
dG1wL3RtcEltZ0INCisgcm0gL3RtcC90bXBJbWdC
--0000000000002ad9cc05cdea04cd
Content-Type: application/x-sh; name="btrfsRaid1Test.sh"
Content-Disposition: attachment; filename="btrfsRaid1Test.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_kujp7ins0>
X-Attachment-Id: f_kujp7ins0

IyEvYmluL2Jhc2gNCiMgRXhhbXBsZSBvdXRwdXQgLSBodHRwczovL3Bhc3RlYmluLmNvbS9FOWk1
NTdGNg0KDQojIyMjIyMjIyMjDQojIGV4aXQgb24gZXJyb3INCnNldCAtZSAteCAtdg0KDQojIyMj
IyMjIyMjDQojIEdldCBTeXN0ZW0gSW5mbw0KdW5hbWUgLXINCmJ0cmZzIHZlcnNpb24NCg0KIyMj
IyMjIyMjIw0KIyBDcmVhdGUgYmxhbmsgaW1hZ2VzDQpmYWxsb2NhdGUgLWwgMkcgL3RtcC90bXBJ
bWdBDQpmYWxsb2NhdGUgLWwgMkcgL3RtcC90bXBJbWdCDQoNCiMjIyMjIyMjIyMNCiMgUHJlcGFy
ZSBsb29wYmFjayBkZXZpY2VzDQptb2Rwcm9iZSBsb29wDQpMT09QX0E9IiQobG9zZXR1cCAtLXNo
b3cgLWZQIC90bXAvdG1wSW1nQSkiDQpMT09QX0I9IiQobG9zZXR1cCAtLXNob3cgLWZQIC90bXAv
dG1wSW1nQikiDQoNCiMjIyMjIyMjIyMNCiMgQ3JlYXRlIHJhaWQxDQpta2ZzLmJ0cmZzIC0tZm9y
Y2UgLVIgZnJlZS1zcGFjZS10cmVlIC1MIFRtcFJhaWQxIC1kIHJhaWQxIC1tIHJhaWQxICIkTE9P
UF9BIiAiJExPT1BfQiINCg0KIyMjIyMjIyMjIw0KIyBNb3VudCB0ZW1wIHJhaWQxDQpta2RpciAv
dG1wL3RtcFJhaWQxDQptb3VudCAiJExPT1BfQSIgL3RtcC90bXBSYWlkMQ0KDQojIyMjIyMjIyMj
DQojIFJ1biBidHJmcyBkZg0KYnRyZnMgZmlsZXN5c3RlbSBkZiAvdG1wL3RtcFJhaWQxDQoNCiMj
IyMjIyMjIyMNCiMgY2xlYW51cA0KdW1vdW50IC90bXAvdG1wUmFpZDENCg0KbG9zZXR1cCAtLWRl
dGFjaCAiJExPT1BfQSINCmxvc2V0dXAgLS1kZXRhY2ggIiRMT09QX0IiDQoNCnN5bmMNCnJtZGly
IC90bXAvdG1wUmFpZDEvDQpybSAvdG1wL3RtcEltZ0ENCnJtIC90bXAvdG1wSW1nQg==
--0000000000002ad9cc05cdea04cd--
