Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7D150754
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 14:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBCNeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 08:34:13 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:33579 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgBCNeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 08:34:13 -0500
Received: by mail-ua1-f45.google.com with SMTP id w15so1111209uap.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ur53t0wE9JQ878Embpru/Lx8kZmLX4mSpmsGKseCH1Y=;
        b=u4+VUuysoyRssdpesxa7+WIOsFBIbhfkfOi6KLa3tE1X9byM0KQe+rHjejmaSGYRgO
         AcURovGyCjxqSzSZYmiJfhOkZ0xe77Cw40LExRV4SzcxwUvBLumHbdWu6hLQZyYMlnHZ
         wGR1tTp7zo0iVBTLJkM1435FRi9uyYFP4QqQKZ1EZ2oKGXHPiL6VCds6Qt+DY54OATxK
         MATFdxkYJzWqVmZIqkpFfP31KUqmecWDlP7SLIR86lujlMAMRtj+L89Ul1jUVpSuFRhM
         yIG7NccmG9OxcjchhJpq/zbceg4IhUFqfN3qKGHmC1CFYDqN8gHJNA3LvcfUjz4j2L5H
         HihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ur53t0wE9JQ878Embpru/Lx8kZmLX4mSpmsGKseCH1Y=;
        b=m0ZB5ju3mU/S8O9jm3I0eXJB58RMnEDsw1XSQ+uxaka1SP7bcdyCm24QDzLk2mO7Nq
         2bPXs+E//awzgbIsRPY6vTIzrettu8LFh1ftdr7kPksKmbxfFGwqYdIjmT0FG3SLdkp0
         CN9+FzrsBtZt+Lxnx3upiEACZ2TejuGmg2zB71FH0JhRspqUy1lSm+nI7c0ebzdv82LY
         zoiyTJiHtTAPLajkZXsMen/L9YRx++PKOtUFBsTC80S8T1ubu/25Tk8QBFDdTtIf9igo
         0Vxag9zIIqD/gkNEraE2YWVeOMgVKpET5X+y9M3lbNIesRBKgF4saeLTvYOpWoNQDjyu
         OMXg==
X-Gm-Message-State: APjAAAUuC29hi9/iiRxhMVbnSnsgz08IckBmgqB6vGV83aHO/J5uPsDQ
        yuA82kjfi51k9BFvCAfRn99/yKhAKpPzcv+Bl3qLekRw
X-Google-Smtp-Source: APXvYqzr2hEN8g37ZMoTslJqXZRbO2QbMX0QnR/Vr4FwgsVd5Zr2DNkX0K+E30FqaJDFmK+ao0iZl8K+PuBdYFO8ucA=
X-Received: by 2002:ab0:201a:: with SMTP id v26mr13647901uak.57.1580736850422;
 Mon, 03 Feb 2020 05:34:10 -0800 (PST)
MIME-Version: 1.0
From:   Robert Klemme <shortcutter@googlemail.com>
Date:   Mon, 3 Feb 2020 14:33:33 +0100
Message-ID: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
Subject: Root FS damaged
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074b736059dabfa56"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000074b736059dabfa56
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I have an issue with one of my desktop systems. Besides the usual
information below I have attached output of btrfsck and dmesg. The
system did not crash but was up for about a week.

My questions:
1. And ideas what is wrong?
2. Should I file a bug
3. can I safely repair with --repair or what else do I have to do to repair?

Thank you!

Kind regards

robert

This is a Xubuntu and I am using btrfs on top of lvm on top of LUKS.

$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.3 LTS
Release:        18.04
Codename:       bionic
$ uname -a
Linux robunt-01 4.15.0-76-generic #86-Ubuntu SMP Fri Jan 17 17:24:28
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
$ btrfs --version
btrfs-progs v4.15.1
$ sudo btrfs fi show
Label: none  uuid: 0da6c6f7-d42e-4096-8690-97daf14d70e7
        Total devices 1 FS bytes used 12.64GiB
        devid    1 size 30.00GiB used 15.54GiB path
/dev/mapper/main--vg-main--root

Label: 'home'  uuid: cfb8c776-0dab-4596-af5b-276f0db46f79
        Total devices 1 FS bytes used 50.73GiB
        devid    1 size 161.57GiB used 53.07GiB path
/dev/mapper/main--vg-main--home

$ sudo btrfs fi df /
Data, single: total=14.01GiB, used=11.83GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=1.50GiB, used=820.30MiB
GlobalReserve, single: total=39.19MiB, used=0.00B

--00000000000074b736059dabfa56
Content-Type: text/plain; charset="US-ASCII"; name="btrfscheck-errors.txt"
Content-Disposition: attachment; filename="btrfscheck-errors.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k66h336m0>
X-Attachment-Id: f_k66h336m0

JCBzdWRvIGJ0cmZzY2sgL2Rldi9tYXBwZXIvbWFpbi0tdmctbWFpbi0tcm9vdCAKQ2hlY2tpbmcg
ZmlsZXN5c3RlbSBvbiAvZGV2L21hcHBlci9tYWluLS12Zy1tYWluLS1yb290ClVVSUQ6IDBkYTZj
NmY3LWQ0MmUtNDA5Ni04NjkwLTk3ZGFmMTRkNzBlNwpjaGVja2luZyBleHRlbnRzCmRhdGEgYmFj
a3JlZiA1NjU4NzY3MzYwIHJvb3QgMjc1IG93bmVyIDE5MDc1IG9mZnNldCAwIG51bV9yZWZzIDAg
bm90IGZvdW5kIGluIGV4dGVudCB0cmVlCmluY29ycmVjdCBsb2NhbCBiYWNrcmVmIGNvdW50IG9u
IDU2NTg3NjczNjAgcm9vdCAyNzUgb3duZXIgMTkwNzUgb2Zmc2V0IDAgZm91bmQgMSB3YW50ZWQg
MCBiYWNrIDB4NTYyZGVjZWIxMjUwCmluY29ycmVjdCBsb2NhbCBiYWNrcmVmIGNvdW50IG9uIDU2
NTg3NjczNjAgcm9vdCAyNzUgb3duZXIgMTkwNzUgb2Zmc2V0IDEzMTA3MiBmb3VuZCAwIHdhbnRl
ZCAxIGJhY2sgMHg1NjJkZWFlN2QwZDAKYmFja3JlZiBkaXNrIGJ5dGVuciBkb2VzIG5vdCBtYXRj
aCBleHRlbnQgcmVjb3JkLCBieXRlbnI9NTY1ODc2NzM2MCwgcmVmIGJ5dGVucj0wCmJhY2twb2lu
dGVyIG1pc21hdGNoIG9uIFs1NjU4NzY3MzYwIDEyMjg4XQpFUlJPUjogZXJyb3JzIGZvdW5kIGlu
IGV4dGVudCBhbGxvY2F0aW9uIHRyZWUgb3IgY2h1bmsgYWxsb2NhdGlvbgpjaGVja2luZyBmcmVl
IHNwYWNlIGNhY2hlCmNoZWNraW5nIGZzIHJvb3RzCmNoZWNraW5nIGNzdW1zCmNoZWNraW5nIHJv
b3QgcmVmcwpmb3VuZCAxMzUyNTM2NDczNiBieXRlcyB1c2VkLCBlcnJvcihzKSBmb3VuZAp0b3Rh
bCBjc3VtIGJ5dGVzOiAxMDg0Nzk4MAp0b3RhbCB0cmVlIGJ5dGVzOiA4MjU4MTkxMzYKdG90YWwg
ZnMgdHJlZSBieXRlczogNzg0NjEzMzc2CnRvdGFsIGV4dGVudCB0cmVlIGJ5dGVzOiAyNjc1NTA3
MgpidHJlZSBzcGFjZSB3YXN0ZSBieXRlczogMTY2Njk3NDU0CmZpbGUgZGF0YSBibG9ja3MgYWxs
b2NhdGVkOiA0MDg1NjI0MDEyOAogcmVmZXJlbmNlZCAzNDIxMzA3Njk5Mgo=
--00000000000074b736059dabfa56
Content-Type: application/x-gzip; name="dmesg.txt.gz"
Content-Disposition: attachment; filename="dmesg.txt.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_k66hm8341>
X-Attachment-Id: f_k66hm8341

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
10XQ9NUDAA==
--00000000000074b736059dabfa56--
