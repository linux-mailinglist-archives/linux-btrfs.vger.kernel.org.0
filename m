Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D586F13D2D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 04:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgAPDkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 22:40:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43207 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgAPDkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 22:40:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so17769740qtj.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 19:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ocJ3NpQA8oVUvwhNiZCi+vwf9nTg3b19a2/zfh4tg8s=;
        b=VNzh6nOB89vuFf9u1ZsFLYmMBzM1cQfbTrKHyqGDkIqHtlh0gmKiopUDM7uwPdNgKR
         cXaXDWBMDZ7CBpLNfWlcRr4qzFBbAVfaL49h4MqzINTINDVRWOzsqWjvfix+arYGczmn
         jbntWwnmvj2o6lUHqgp+dywVWUwiqoh3iyOhfCxkw780/7ZyMVKHVCKg1T5HN6SBsJbk
         p3RrkkYA2QS0SdVWEoTIXNnurLqkER0KbXsF/LQT+zMDKHIb5ZjZQ9uW8YDTDwq6Raj/
         0V0mes/iHfSa4ibvS4Lfz6YeayFbrTEOZ2cQynaNLyhwo3la4+DtyjixnW0FkHdJax1Q
         QSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ocJ3NpQA8oVUvwhNiZCi+vwf9nTg3b19a2/zfh4tg8s=;
        b=RvuIuEUsL/Lqhh1HMy/Tcx6xWzb9O2WfGS2+I9i8CRT40T4pIP47ank703IOjFK+dS
         szWFAS31EHMUwYvJlRQHGmJhyZCIR55ZSgkfbVhOsN9Yigaml7Y48HfhlHKQzfwmcRtG
         PKVBbH+PDtddUk6nt3qgEA1cgKWL4vlMR7Ho/p6aFh5sRUVlXCU1APbwdt04ASdcYnp6
         Erp851VaOkQvYZl6IzLyyC/GHVukWAOMuZGXclPf3DeC6SqsVkCvyQsOWj1FLSDxw/kS
         Q4PLfDqq+xNRUAwUkbC6vfgFvcktAbawppeMjrHrzRQHhnhkfhByIXxJR09e0oOObEe6
         JNJQ==
X-Gm-Message-State: APjAAAVORZ7ovpbBDqt3OmAq/on8BLIFXQJm3nXSJAggZlHvz1x6JCAb
        diF2d6dnBQQFCToUWhNz+uAysxppJ3eQkwQ/kpw2iMU46lE=
X-Google-Smtp-Source: APXvYqw+/+C4h4KEf6GYv+oFeofqbdkpnk/a7MQXXDIb1Mnu64RJ7wsyI2eWlQx2GyNj4eCeFXJi8k9A9Q685QBLtMs=
X-Received: by 2002:ac8:2a06:: with SMTP id k6mr499407qtk.145.1579145999112;
 Wed, 15 Jan 2020 19:39:59 -0800 (PST)
MIME-Version: 1.0
From:   Sabrina Cathey <sabcatlibra@gmail.com>
Date:   Wed, 15 Jan 2020 22:39:48 -0500
Message-ID: <CAM3w-7gSeg+4O-0dWRd3yr5FDcDCq9gEDXDid2SxwMYFkHn+8Q@mail.gmail.com>
Subject: Issues with FS going read-only and bad drive
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000541122059c399409"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000541122059c399409
Content-Type: text/plain; charset="UTF-8"

Sent earlier but it hasn't shown up on the mailing list.  I know
greylisting has a delay but usually not 30 minutes as far as I know.

----

Up front required information

uname -a;btrfs --version;btrfs fi show;btrfs fi df /shizzle/
Linux babel.thegnomedev.com 5.3.8-arch1-1 #1 SMP PREEMPT @1572357769
x86_64 GNU/Linux
btrfs-progs v5.3.1
Label: 'shizzle'  uuid: 92b267f2-c8af-40eb-b433-e53e140ebd01
Total devices 10 FS bytes used 34.18TiB
devid    2 size 5.46TiB used 4.28TiB path /dev/sdb1
devid    3 size 5.46TiB used 4.28TiB path /dev/sdg1
devid    4 size 5.46TiB used 4.28TiB path /dev/sdh1
devid    5 size 5.46TiB used 4.28TiB path /dev/sdi1
devid    6 size 5.46TiB used 4.28TiB path /dev/sdj1
devid    7 size 5.46TiB used 4.28TiB path /dev/sdf1
devid    8 size 5.46TiB used 4.28TiB path /dev/sda1
devid    9 size 5.46TiB used 4.28TiB path /dev/sdd1
devid   10 size 5.46TiB used 4.28TiB path /dev/sde1
devid   11 size 5.46TiB used 4.28TiB path /dev/sdc1

Data, RAID6: total=34.18TiB, used=34.13TiB
System, RAID6: total=256.00MiB, used=1.73MiB
Metadata, RAID6: total=60.00GiB, used=54.65GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

----

dmesg output is over 100k and my understanding is that you have a size
limit so here is a pastebin: https://pastebin.com/d4BPRS6m

----

Story is that I found the server unresponsive and when I rebooted I
ended seeing a disk was missing https://i.imgur.com/iLgnNBM.jpg

I mucked about trying to figure out what to do.  I ended up rebooting
to see if I could see an issue in the drive controller BIOS and when I
got back into the OS things seemed okay at first.  It was mounted and
looked okay but then I noticed issues in dmesg related "parent transid
verify failed" errors.

It's late and I was grasping a straws and random googling.  I tried a
scrub and it failed and the filesystem went RO.  I retried a few
times, because insanity.

I tried btrfsck (default non-destructive) and it also bailed out
https://i.imgur.com/ZEq0RjU.jpg

Looking at btrfs device stats it looks like one of the devices
(/dev/sde) is bad - probably the one that was found missing initially.
I'm attaching the output of that command.  I'm way out of my depth
here - my thought is to use btrfs device delete /dev/sde1

Please can you help me to not lose my data?  With this large an amount
of data, I have yet to invest in another set of disks for backup (I
know that RAID isn't backups and I should have them).

Any help would be most appreciated

Thanks

Sabrina

--000000000000541122059c399409
Content-Type: text/plain; charset="US-ASCII"; name="btrfs.device.stats.shizzle.txt"
Content-Disposition: attachment; filename="btrfs.device.stats.shizzle.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k5g6qtms0>
X-Attachment-Id: f_k5g6qtms0

Wy9kZXYvc2RiMV0ud3JpdGVfaW9fZXJycyAgICAwClsvZGV2L3NkYjFdLnJlYWRfaW9fZXJycyAg
ICAgMApbL2Rldi9zZGIxXS5mbHVzaF9pb19lcnJzICAgIDAKWy9kZXYvc2RiMV0uY29ycnVwdGlv
bl9lcnJzICAyClsvZGV2L3NkYjFdLmdlbmVyYXRpb25fZXJycyAgMApbL2Rldi9zZGcxXS53cml0
ZV9pb19lcnJzICAgIDAKWy9kZXYvc2RnMV0ucmVhZF9pb19lcnJzICAgICAwClsvZGV2L3NkZzFd
LmZsdXNoX2lvX2VycnMgICAgMApbL2Rldi9zZGcxXS5jb3JydXB0aW9uX2VycnMgIDAKWy9kZXYv
c2RnMV0uZ2VuZXJhdGlvbl9lcnJzICAwClsvZGV2L3NkaDFdLndyaXRlX2lvX2VycnMgICAgMApb
L2Rldi9zZGgxXS5yZWFkX2lvX2VycnMgICAgIDAKWy9kZXYvc2RoMV0uZmx1c2hfaW9fZXJycyAg
ICAwClsvZGV2L3NkaDFdLmNvcnJ1cHRpb25fZXJycyAgMApbL2Rldi9zZGgxXS5nZW5lcmF0aW9u
X2VycnMgIDAKWy9kZXYvc2RpMV0ud3JpdGVfaW9fZXJycyAgICAwClsvZGV2L3NkaTFdLnJlYWRf
aW9fZXJycyAgICAgMApbL2Rldi9zZGkxXS5mbHVzaF9pb19lcnJzICAgIDAKWy9kZXYvc2RpMV0u
Y29ycnVwdGlvbl9lcnJzICA0ClsvZGV2L3NkaTFdLmdlbmVyYXRpb25fZXJycyAgMApbL2Rldi9z
ZGoxXS53cml0ZV9pb19lcnJzICAgIDAKWy9kZXYvc2RqMV0ucmVhZF9pb19lcnJzICAgICAwClsv
ZGV2L3NkajFdLmZsdXNoX2lvX2VycnMgICAgMApbL2Rldi9zZGoxXS5jb3JydXB0aW9uX2VycnMg
IDMKWy9kZXYvc2RqMV0uZ2VuZXJhdGlvbl9lcnJzICAwClsvZGV2L3NkZjFdLndyaXRlX2lvX2Vy
cnMgICAgMApbL2Rldi9zZGYxXS5yZWFkX2lvX2VycnMgICAgIDAKWy9kZXYvc2RmMV0uZmx1c2hf
aW9fZXJycyAgICAwClsvZGV2L3NkZjFdLmNvcnJ1cHRpb25fZXJycyAgMApbL2Rldi9zZGYxXS5n
ZW5lcmF0aW9uX2VycnMgIDAKWy9kZXYvc2RhMV0ud3JpdGVfaW9fZXJycyAgICAwClsvZGV2L3Nk
YTFdLnJlYWRfaW9fZXJycyAgICAgMApbL2Rldi9zZGExXS5mbHVzaF9pb19lcnJzICAgIDAKWy9k
ZXYvc2RhMV0uY29ycnVwdGlvbl9lcnJzICAwClsvZGV2L3NkYTFdLmdlbmVyYXRpb25fZXJycyAg
MApbL2Rldi9zZGQxXS53cml0ZV9pb19lcnJzICAgIDAKWy9kZXYvc2RkMV0ucmVhZF9pb19lcnJz
ICAgICAwClsvZGV2L3NkZDFdLmZsdXNoX2lvX2VycnMgICAgMApbL2Rldi9zZGQxXS5jb3JydXB0
aW9uX2VycnMgIDAKWy9kZXYvc2RkMV0uZ2VuZXJhdGlvbl9lcnJzICAwClsvZGV2L3NkZTFdLndy
aXRlX2lvX2VycnMgICAgNjA3NQpbL2Rldi9zZGUxXS5yZWFkX2lvX2VycnMgICAgIDU5NjUKWy9k
ZXYvc2RlMV0uZmx1c2hfaW9fZXJycyAgICAxODQKWy9kZXYvc2RlMV0uY29ycnVwdGlvbl9lcnJz
ICAwClsvZGV2L3NkZTFdLmdlbmVyYXRpb25fZXJycyAgMApbL2Rldi9zZGMxXS53cml0ZV9pb19l
cnJzICAgIDAKWy9kZXYvc2RjMV0ucmVhZF9pb19lcnJzICAgICAwClsvZGV2L3NkYzFdLmZsdXNo
X2lvX2VycnMgICAgMApbL2Rldi9zZGMxXS5jb3JydXB0aW9uX2VycnMgIDAKWy9kZXYvc2RjMV0u
Z2VuZXJhdGlvbl9lcnJzICAwCg==
--000000000000541122059c399409--
