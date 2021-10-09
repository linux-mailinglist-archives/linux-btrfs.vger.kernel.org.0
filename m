Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9468427A8D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Oct 2021 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhJIN1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Oct 2021 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhJIN1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Oct 2021 09:27:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A585DC061570
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Oct 2021 06:25:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v25so38524106wra.2
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Oct 2021 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVwFdM2nkYmmavt6IrifTiRutB+DLErLmzMqXMOZR+I=;
        b=kLNAzpkPGor4nTP8R7jD2EHIYyzeq7Rv6/JJ6oOntEUEMC0RAcdN14DVA8gPURbKnD
         rKou8M+/niruJ1Nh35pxiwEX2iA0Gx1zit6qN9AqKP1OHK0MsR4ttXbwM8pJLFVeQ+Mc
         wx9KLzqy6o3BiMkwSz9K3AYpb3F9/oMc3wT0EErUvWB+c5nS7WQxxYjLOl0kGXC3X6BB
         1XKkyyzZvmOMnAndUs9HIrI0Oi5swifkIW3LX4MsLy7vub728vs8pVDkbKEytnOi6BaK
         R7vdatTYo1uaFGpUsNayRnPQDyWmGw8IvgN2rfE/1L2H/F/7fA6lYV1vdkgsPwkPGTRB
         rj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVwFdM2nkYmmavt6IrifTiRutB+DLErLmzMqXMOZR+I=;
        b=SOGhUAey/rTny5H7FyxvSYTjnBYtGfc9W8Rj2VjCqfT+t4ZgGZ8KFzpM5lg/rYLPqr
         gi+/bMLMahfeAWATWBrQhaxiTt/iJGjf80GUo+gDdcqEl/TkBJe1iMUP+ghHU6J84Oou
         9BROXDYI76NIzQfIrhyxGeMVlIMIOlSMoEKX8IzwtDRPoDqypG0+4SRYVTcRYIyiVxMD
         L0CwtA3kWAnvVHxiN6mkYN5xPeo0DVkamqFoJoJrsxMFCduDBrhWioC0JSlMMxJeq00j
         lkYo3ztPhnv7CyTZCzZO12n2+BZABv1MbURHrIh4j7rOunO15Kt2qnZPYF5/5VxVMYHF
         XR8g==
X-Gm-Message-State: AOAM5323b/plAqf8HSDTsawkNhlQy3ashcuNr4Y6p8fkgiMKPdbhNpM5
        x+UtKvdiMT69phORfuyZkVquxTWnUZd3NWhTObwZl51uOfY=
X-Google-Smtp-Source: ABdhPJzEtvk+qqJetyb3pWzZpx/2EtAyjIlQZX9RNjvJ/KVnSTC3SkHyQDrFlNLzNWeKuo+KOThBwzG9ddsXVoDt0kA=
X-Received: by 2002:a05:600c:3b26:: with SMTP id m38mr9548923wms.176.1633785901911;
 Sat, 09 Oct 2021 06:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADNS_H6MvByBaYQ7h94DMVQUU9ZjANN8bz90km_6DZykBh6mxw@mail.gmail.com>
 <08f71656-b775-3fe0-62f7-f04c44501858@gmx.com>
In-Reply-To: <08f71656-b775-3fe0-62f7-f04c44501858@gmx.com>
From:   FireFish5000 <firefish5000@gmail.com>
Date:   Sat, 9 Oct 2021 08:24:51 -0500
Message-ID: <CADNS_H46D-Hrc90JRRpHS9JdUwvGr41mXsPOFSNb_e2C9h=6zA@mail.gmail.com>
Subject: Re: Bug / Suspected regression. Multiple block group profiles
 detected on newly created raid1.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000052ae5105cdeb6c18"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000052ae5105cdeb6c18
Content-Type: text/plain; charset="UTF-8"

Same warning in v5.14.2. Output is mostly the same except that it
informs me it'd running a full device TRIM during mkfs.

>  If you want to use the fs, just do a btrfs balance with "start
-musage=0" should remove that SINGLE metadata chunk.

Earlier I ran
`btrfs balance start -mconvert=raid1,soft /mnt/tmp`
which seemed to have done the trick. Any notable difference between
the results of the two commands?

Sincerely,
A Fish on Fire


On Sat, Oct 9, 2021 at 7:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/10/9 19:44, FireFish5000 wrote:
> > After creating a new btrfs raid1 and was surprised to be greeted with
> > the warning
> >
> > WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> > WARNING:   Metadata: single, raid1
> >
> > I asked on the IRC, and darkling directed me to the mailing list
> > suspecting this was a regression.
> > I am on 5.14.8-gentoo-dist with btrfs-progs v5.14.1
> >
> > I have attached a script to reproduce this with temporary images/loop devices,
> > Along with the full output I received when running the script.
> >
> > A shortened version of the commands that I ran on my *real drives* and
> > the relevant output is also provided below for convenience. P at the
> > end of the device path was inserted incase sleepy joe copies it
> > thinking its the reproduction script:
> >
> > # mkfs.btrfs --force -R free-space-tree -L BtrfsRaid1Test -d raid1 -m
>
> This seems to be a recent bug in btrfs-progs which doesn't remove the
> temporary chunk.
>
> You can try the latest v5.14.2 to see if it's solved.
>
> If you want to use the fs, just do a btrfs balance with "start
> -musage=0" should remove that SINGLE metadata chunk.
>
> Thanks,
> Qu
> > raid1 /dev/sdaP /dev/sdbP; mount /dev/sda /mnt/tmp; btrfs filesystem
> > df /mnt/tmp
> > btrfs-progs v5.14.1
> > ....truncated....
> > ....truncated....
> > Data, RAID1: total=1.00GiB, used=0.00B
> > System, RAID1: total=8.00MiB, used=16.00KiB
> > Metadata, RAID1: total=1.00GiB, used=176.00KiB
> > Metadata, single: total=8.00MiB, used=0.00B
> > GlobalReserve, single: total=3.25MiB, used=0.00B
> > WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> > WARNING:   Metadata: single, raid1
> >

--00000000000052ae5105cdeb6c18
Content-Type: text/plain; charset="US-ASCII"; name="output-v5.14.2.txt"
Content-Disposition: attachment; filename="output-v5.14.2.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kujtchqd0>
X-Attachment-Id: f_kujtchqd0

CiMjIyMjIyMjIyMKIyBHZXQgU3lzdGVtIEluZm8KdW5hbWUgLXIKKyB1bmFtZSAtcgo1LjE0Ljgt
Z2VudG9vLWRpc3QKYnRyZnMgdmVyc2lvbgorIGJ0cmZzIHZlcnNpb24KYnRyZnMtcHJvZ3MgdjUu
MTQuMiAKCiMjIyMjIyMjIyMKIyBDcmVhdGUgYmxhbmsgaW1hZ2VzCmZhbGxvY2F0ZSAtbCAyRyAv
dG1wL3RtcEltZ0EKKyBmYWxsb2NhdGUgLWwgMkcgL3RtcC90bXBJbWdBCmZhbGxvY2F0ZSAtbCAy
RyAvdG1wL3RtcEltZ0IKKyBmYWxsb2NhdGUgLWwgMkcgL3RtcC90bXBJbWdCCgojIyMjIyMjIyMj
CiMgUHJlcGFyZSBsb29wYmFjayBkZXZpY2VzCm1vZHByb2JlIGxvb3AKKyBtb2Rwcm9iZSBsb29w
CkxPT1BfQT0iJChsb3NldHVwIC0tc2hvdyAtZlAgL3RtcC90bXBJbWdBKSIKKysgbG9zZXR1cCAt
LXNob3cgLWZQIC90bXAvdG1wSW1nQQorIExPT1BfQT0vZGV2L2xvb3AwCkxPT1BfQj0iJChsb3Nl
dHVwIC0tc2hvdyAtZlAgL3RtcC90bXBJbWdCKSIKKysgbG9zZXR1cCAtLXNob3cgLWZQIC90bXAv
dG1wSW1nQgorIExPT1BfQj0vZGV2L2xvb3AxCgojIyMjIyMjIyMjCiMgQ3JlYXRlIHJhaWQxCm1r
ZnMuYnRyZnMgLS1mb3JjZSAtUiBmcmVlLXNwYWNlLXRyZWUgLUwgVG1wUmFpZDEgLWQgcmFpZDEg
LW0gcmFpZDEgIiRMT09QX0EiICIkTE9PUF9CIgorIG1rZnMuYnRyZnMgLS1mb3JjZSAtUiBmcmVl
LXNwYWNlLXRyZWUgLUwgVG1wUmFpZDEgLWQgcmFpZDEgLW0gcmFpZDEgL2Rldi9sb29wMCAvZGV2
L2xvb3AxCmJ0cmZzLXByb2dzIHY1LjE0LjIgClNlZSBodHRwOi8vYnRyZnMud2lraS5rZXJuZWwu
b3JnIGZvciBtb3JlIGluZm9ybWF0aW9uLgoKUGVyZm9ybWluZyBmdWxsIGRldmljZSBUUklNIC9k
ZXYvbG9vcDAgKDIuMDBHaUIpIC4uLgpQZXJmb3JtaW5nIGZ1bGwgZGV2aWNlIFRSSU0gL2Rldi9s
b29wMSAoMi4wMEdpQikgLi4uCkxhYmVsOiAgICAgICAgICAgICAgVG1wUmFpZDEKVVVJRDogICAg
ICAgICAgICAgICBlYWU2MzFiZS1kNDhmLTQ4NGItYWYwOS04ZDY1YTI5MWJiZjEKTm9kZSBzaXpl
OiAgICAgICAgICAxNjM4NApTZWN0b3Igc2l6ZTogICAgICAgIDQwOTYKRmlsZXN5c3RlbSBzaXpl
OiAgICA0LjAwR2lCCkJsb2NrIGdyb3VwIHByb2ZpbGVzOgogIERhdGE6ICAgICAgICAgICAgIFJB
SUQxICAgICAgICAgICAyMDQuNzVNaUIKICBNZXRhZGF0YTogICAgICAgICBSQUlEMSAgICAgICAg
ICAgMjY0LjAwTWlCCiAgU3lzdGVtOiAgICAgICAgICAgUkFJRDEgICAgICAgICAgICAgOC4wME1p
QgpTU0QgZGV0ZWN0ZWQ6ICAgICAgIHllcwpab25lZCBkZXZpY2U6ICAgICAgIG5vCkluY29tcGF0
IGZlYXR1cmVzOiAgZXh0cmVmLCBza2lubnktbWV0YWRhdGEKUnVudGltZSBmZWF0dXJlczogICBm
cmVlLXNwYWNlLXRyZWUKQ2hlY2tzdW06ICAgICAgICAgICBjcmMzMmMKTnVtYmVyIG9mIGRldmlj
ZXM6ICAyCkRldmljZXM6CiAgIElEICAgICAgICBTSVpFICBQQVRICiAgICAxICAgICAyLjAwR2lC
ICAvZGV2L2xvb3AwCiAgICAyICAgICAyLjAwR2lCICAvZGV2L2xvb3AxCgoKIyMjIyMjIyMjIwoj
IE1vdW50IHRlbXAgcmFpZDEKbWtkaXIgL3RtcC90bXBSYWlkMQorIG1rZGlyIC90bXAvdG1wUmFp
ZDEKbW91bnQgIiRMT09QX0EiIC90bXAvdG1wUmFpZDEKKyBtb3VudCAvZGV2L2xvb3AwIC90bXAv
dG1wUmFpZDEKCiMjIyMjIyMjIyMKIyBSdW4gYnRyZnMgZGYKYnRyZnMgZmlsZXN5c3RlbSBkZiAv
dG1wL3RtcFJhaWQxCisgYnRyZnMgZmlsZXN5c3RlbSBkZiAvdG1wL3RtcFJhaWQxCldBUk5JTkc6
IE11bHRpcGxlIGJsb2NrIGdyb3VwIHByb2ZpbGVzIGRldGVjdGVkLCBzZWUgJ21hbiBidHJmcyg1
KScuCldBUk5JTkc6ICAgTWV0YWRhdGE6IHNpbmdsZSwgcmFpZDEKRGF0YSwgUkFJRDE6IHRvdGFs
PTIwNC43NU1pQiwgdXNlZD0wLjAwQgpTeXN0ZW0sIFJBSUQxOiB0b3RhbD04LjAwTWlCLCB1c2Vk
PTE2LjAwS2lCCk1ldGFkYXRhLCBSQUlEMTogdG90YWw9MjU2LjAwTWlCLCB1c2VkPTEyOC4wMEtp
QgpNZXRhZGF0YSwgc2luZ2xlOiB0b3RhbD04LjAwTWlCLCB1c2VkPTAuMDBCCkdsb2JhbFJlc2Vy
dmUsIHNpbmdsZTogdG90YWw9My4yNU1pQiwgdXNlZD0wLjAwQgoKIyMjIyMjIyMjIwojIGNsZWFu
dXAKdW1vdW50IC90bXAvdG1wUmFpZDEKKyB1bW91bnQgL3RtcC90bXBSYWlkMQoKbG9zZXR1cCAt
LWRldGFjaCAiJExPT1BfQSIKKyBsb3NldHVwIC0tZGV0YWNoIC9kZXYvbG9vcDAKbG9zZXR1cCAt
LWRldGFjaCAiJExPT1BfQiIKKyBsb3NldHVwIC0tZGV0YWNoIC9kZXYvbG9vcDEKCnN5bmMKKyBz
eW5jCnJtZGlyIC90bXAvdG1wUmFpZDEvCisgcm1kaXIgL3RtcC90bXBSYWlkMS8Kcm0gL3RtcC90
bXBJbWdBCisgcm0gL3RtcC90bXBJbWdBCnJtIC90bXAvdG1wSW1nQgorIHJtIC90bXAvdG1wSW1n
Qgo=
--00000000000052ae5105cdeb6c18--
