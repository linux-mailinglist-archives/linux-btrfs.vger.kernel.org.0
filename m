Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29C2C49B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbgKYVNt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 16:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgKYVNt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 16:13:49 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C3C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 13:13:49 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w202so3507147pff.10
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 13:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brunner-ninja.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=KYabpZYw1WZmeeJawGBBtTx4t7PCD7bJS2lnFWVRKcI=;
        b=m5K9CZTIpxL/S/qHxd5QnmhwPKul3yqLsxV7/sdFaTnP56dOuKEjdV1mbeVC7m6gJR
         RKzGYlKxm7+3bm8t5Hws4Idu4HhjCxuB2c5IdeeV7YOX4LqEbuUXVdnkOvgmtBUXjXuF
         hZVG6fj7sGTUpsJBQTJI2q4H0SgC4MMGCkxW8yCbPVbGWTHeStBT0k0fkPbwMEEG0wuP
         PQqRoNaUYKMjt+GJmMPwhLJYszpHp6NBvmz2TFlzXUrd1nho/3gmcKkts4Ot+iSBjt+z
         iWoZeTCuZqwaQSSeE4El591/t3j7oQqT97KtX9r6kfwAm+YFLSElnq9lPzw3LpSIjV7h
         90kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KYabpZYw1WZmeeJawGBBtTx4t7PCD7bJS2lnFWVRKcI=;
        b=KoEOCohCB5tMSK2vSHYHOmZJGMaHHDsGKM2JIST+NoH68j4eYlaY+tdNd+2nJk1g4V
         fKFHAIqNVY1iUQdTeZxas2FenDm/fiH21yJW1vy1IpCHrOXbB0Xpvf//+QX1iavRHMCX
         q4E0nVX3IBpnR/9mw/3isUYRI0cBm7OxVbZlPvLA0IfTXmq0pybNNPinlMLGJIwGJ+fw
         uYryLa/69ZUDL1vy3RXO9LuKCXjJRdiXMa96IIUSiwExlN4Sn56rsJWghB9WTj8TZpSj
         OnJNXnYjHNRut+AQ2XhIfS+cR3uuCprIZTjWIO7VrsII+t+ReFdynz6saliN8KkIIX6k
         W0hg==
X-Gm-Message-State: AOAM531eNL03u5I3hGStncTMokCyCG+2R3WuxB+ym7rL2vPVfvkS6SpW
        2FWCZQObGxHSqsjRn+rIu1zzRwVnrdzT0x9q+Edq/E5Ofl6Ydw==
X-Google-Smtp-Source: ABdhPJwGtmZ6t75S3wq7HWZyEmbwu/Hr39BjT3l19TsfRLfS4Cg2iFBoXUgfztP9aM1ZUpP2H4S9aI0Kd56OhWEoVxo=
X-Received: by 2002:a62:248:0:b029:18c:992f:e407 with SMTP id
 69-20020a6202480000b029018c992fe407mr1407067pfc.37.1606338828221; Wed, 25 Nov
 2020 13:13:48 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Brunner <daniel@brunner.ninja>
Date:   Wed, 25 Nov 2020 22:13:37 +0100
Message-ID: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
Subject: corrupted root, doesnt check, repair or mount
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I used btrfs resize to shrink the filesystem and then used mdadm to
shrink the backing device.

Sadly I did not use btrfs for the software raid itself.

After shrinking the mdadm device, my btrfs filesystem doesnt want to
mount or repair anymore.

[  +7,440422] BTRFS info (device dm-0): trying to use backup root at mount time
[  +0,000008] BTRFS info (device dm-0): disabling disk space caching
[  +0,000003] BTRFS info (device dm-0): force clearing of disk cache
[  +0,000003] BTRFS info (device dm-0): has skinny extents
[  +0,002396] BTRFS error (device dm-0): bad tree block start, want
1064960 have 11986489934990110975
[  +0,000125] BTRFS error (device dm-0): failed to read chunk root
[  +0,033922] BTRFS error (device dm-0): open_ctree failed


# btrfs check --repair --force /dev/mapper/bcache0-open
enabling repair mode
Opening filesystem to check...
checksum verify failed on 1064960 found 000000DF wanted 00000007
checksum verify failed on 1064960 found 000000DF wanted 00000007
bad tree block 1064960, bytenr mismatch, want=1064960, have=11986489934990110975
ERROR: cannot read chunk root
ERROR: cannot open file system


# uname -a
Linux flucky-server 5.7.8-arch1-1 #1 SMP PREEMPT Thu, 09 Jul 2020
16:34:01 +0000 x86_64 GNU/Linux


# btrfs --version
btrfs-progs v5.7


# btrfs fi show
Label: none  uuid: 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
        Total devices 1 FS bytes used 16.08TiB
        devid    1 size 26.56TiB used 17.63TiB path /dev/mapper/bcache0-open


# blockdev --getsize64 /dev/mapper/bcache0-open
40002767544320


# mdadm --detail /dev/md127
/dev/md127:
           Version : 1.2
     Creation Time : Fri Oct  4 14:13:05 2019
        Raid Level : raid6
        Array Size : 39065219072 (37255.50 GiB 40002.78 GB)
     Used Dev Size : 9766304768 (9313.87 GiB 10000.70 GB)
      Raid Devices : 6
     Total Devices : 6
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Wed Nov 25 21:22:05 2020
             State : clean
    Active Devices : 6
   Working Devices : 6
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

     Delta Devices : -1, (7->6)

              Name : flucky-server:komposthaufen  (local to host flucky-server)
              UUID : 45401df9:e05c8464:b34fba5e:48ffad45
            Events : 2385661

    Number   Major   Minor   RaidDevice State
       0       8      112        0      active sync   /dev/sdh
       1       8      128        1      active sync   /dev/sdi
       2       8       48        2      active sync   /dev/sdd
       3       8       16        3      active sync   /dev/sdb
       4       8       96        4      active sync   /dev/sdg
       5       8       80        5      active sync   /dev/sdf



looking forward to hear from you :)

BR,
Daniel
