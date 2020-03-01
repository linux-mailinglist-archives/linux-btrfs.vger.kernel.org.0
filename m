Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A62E174F8F
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 21:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgCAUc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 15:32:57 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:46966 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAUc4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 15:32:56 -0500
Received: by mail-io1-f51.google.com with SMTP id x21so4766388iox.13
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+Xk+LCMFg2XEb8AmwcbxvBRfnVX0HrcyS9hpXwstSPA=;
        b=p64LrrbM2Hn6vb893YZMJ8XRgiarfqS9CJoh+p2D+qyKum4rYx4iWFSKxfBDZde3W5
         Iqk+wLPHxXAss54EZiXVeLqcbSPzjta4pQCnlDc4MGJmdAlkOdI9JKXCadJyuE2AM6HZ
         JxkGUt2wSsyB+ldQL0aQsyW9wtF97vVorGm/yLnYGudX8WVRxpW1HskbPrxByoPhe+0h
         GXvjsWHiQEYlwPQ5//E+4iOipGa7Pc4HRJTJfYouJE+9sbiXpKbjNx+BshIPabdAbTk2
         iRjaAFuQm2qDBk7sAVAqo3RUORU/hWLstfWKqcSVteYXNtV1Cg0x7JTd+NX8+MzQGezc
         ktbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+Xk+LCMFg2XEb8AmwcbxvBRfnVX0HrcyS9hpXwstSPA=;
        b=iUuEiXjM4kQEhVS+SRRZsH6FUfzw54u1U7RxlSpyrxnF1ywjw/qHzqQZI/PgwMPti2
         T0bQf7EmQmNTED+PK/Gwk6RCHWyP1lUpymrcoEHP6o46XCAaEvK5J1vENEuKlM8PD3eP
         aZD+sIBjWrthgAM+nHPG/0kl/t69709MBcwcnLqmyrfBqmfbarKQTyxbIFi725E3nidM
         Q6C1BcdRbCjdYJHm9U/onRErySve63nzN414ntnBXhUGKoYm21dinVVHH12sCSFj8k94
         8BvYzCaxhX7Hf+/6JooTsqVctHchydEOLZAQ2od7vM87gmdjW0tsVuIatgM7N7SMaVMS
         bT9A==
X-Gm-Message-State: ANhLgQ03RvHkpM9emU+nIkStH9m1KTxMTDhV4CT+zwGHjSChstCZJuBB
        l1ivxbEzYYj0SkSH6WeXDcwgntIsYr/7RGq9mVUJiu36+qY=
X-Google-Smtp-Source: ADFU+vvMmFfT4nr7rg4QlzRcIaSEW8LfwPgsRBfcj35u6nBctXPbXE9ZfcVZf5x64p+IqtjW/vgGucmZ11rH4J9PVNE=
X-Received: by 2002:a02:c888:: with SMTP id m8mr3194776jao.86.1583094775243;
 Sun, 01 Mar 2020 12:32:55 -0800 (PST)
MIME-Version: 1.0
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Sun, 1 Mar 2020 12:32:43 -0800
Message-ID: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
Subject: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(Is this just taking really long because I didn't provide filters when
balancing across the new drive?)

Also, I DID just change my /etc/fstab to not resume the balance just
in case I reboot:

/.BACKUPS               btrfs   compress=3Dlzo,subvol=3D.BACKUPS,skip_balan=
ce   1 2

Kernel version:

Kernel:  5.5.5-1.el7.elrepo.x86_64

The pool is mirrored, 2 copies.

The last drive in the list is the one I added.  I think it's been at
8MiB the whole time.

$ sudo btrfs fi show /.BACKUPS/
Label: 'BACKUPS'  uuid: cfd65dcd-2a63-4fb1-89a7-0bb9ebe66ddf
        Total devices 4 FS bytes used 3.64TiB
        devid    2 size 1.82TiB used 1.82TiB path /dev/sda1
        devid    3 size 1.82TiB used 1.82TiB path /dev/sdc1
        devid    4 size 3.64TiB used 3.64TiB path /dev/sdb1
        devid    5 size 3.64TiB used 8.31MiB path /dev/sdj1

$ sudo btrfs fi df /.BACKUPS/
Data, RAID1: total=3D3.63TiB, used=3D3.63TiB
System, RAID1: total=3D32.00MiB, used=3D736.00KiB
Metadata, RAID1: total=3D5.00GiB, used=3D3.88GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

$ btrfs fi usage /.BACKUPS/
WARNING: cannot read detailed chunk info, RAID5/6 numbers will be
incorrect, run as root
Overall:
    Device size:                  10.92TiB
    Device allocated:              7.28TiB
    Device unallocated:            3.64TiB
    Device missing:               10.92TiB
    Used:                          7.27TiB
    Free (estimated):              1.82TiB      (min: 1.82TiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

$ sudo btrfs fi usage /.BACKUPS/
Overall:
    Device size:                  10.92TiB
    Device allocated:              7.28TiB
    Device unallocated:            3.64TiB
    Device missing:                  0.00B
    Used:                          7.27TiB
    Free (estimated):              1.82TiB      (min: 1.82TiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:3.63TiB, Used:3.63TiB
   /dev/sda1       1.82TiB
   /dev/sdb1       3.63TiB
   /dev/sdc1       1.82TiB
   /dev/sdj1       8.31MiB

Metadata,RAID1: Size:5.00GiB, Used:3.88GiB
   /dev/sda1       3.00GiB
   /dev/sdb1       5.00GiB
   /dev/sdc1       2.00GiB

System,RAID1: Size:32.00MiB, Used:736.00KiB
   /dev/sda1      32.00MiB
   /dev/sdb1      32.00MiB

Unallocated:
   /dev/sda1       1.00MiB
   /dev/sdb1       1.00MiB
   /dev/sdc1       1.00MiB
   /dev/sdj1       3.64TiB


Processes (I also tried a cancel, which is just hung as well)

4 S root      3665     1  0  80   0 - 60315 -      06:45 ?
00:00:00 sudo btrfs balance cancel /.BACKUPS/
4 D root      3666  3665  0  80   0 -  3983 -      06:45 ?
00:00:00 btrfs balance cancel /.BACKUPS/
4 S root     14035     1  0  80   0 - 60315 -      Feb28 ?
00:00:00 sudo btrfs filesystem balance /.BACKUPS/
4 D root     14036 14035  2  80   0 -  3984 -      Feb28 ?
00:59:12 btrfs filesystem balance /.BACKUPS/

All four drives ARE blinking, and the process takes <10% CPU, but > 0%.

2.6%:

14036 root      20   0   15936    656    520 D   2.6  0.0  59:13.90
btrfs filesystem balance /.BACKUPS/

df, while probably misleading with btrfs:

Filesystem      1K-blocks       Used  Available Use% Mounted on
/dev/sda1      5860531080 3906340128        384 100% /.BACKUPS

dmesg has a lot of these, and you can see they are issued pretty quickly:

[773986.367090] BTRFS info (device sda1): found 472 extents
[773986.583133] BTRFS info (device sda1): found 472 extents
[773986.799169] BTRFS info (device sda1): found 472 extents

sar output of relevant drives (10 secs):

10:26:23 AM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz
avgqu-sz     await     svctm     %util
10:26:26 AM       sdb     78.45      0.00   2312.37     29.48
0.48      6.64      0.58      4.52
10:26:26 AM       sda     78.80      0.00   2312.37     29.35
0.94     12.53      0.53      4.20
10:26:26 AM       sdc     36.40      0.00    220.49      6.06
0.25      7.24      0.85      3.11
10:26:26 AM       sdj     36.40      0.00    220.49      6.06
0.23      6.74      0.83      3.04

$ sudo btrfs balance status -v /.BACKUPS/
Balance on '/.BACKUPS/' is running, cancel requested
0 out of about 3733 chunks balanced (29 considered), 100% left
Dumping filters: flags 0x7, state 0x5, force is off
  DATA (flags 0x0): balancing
  METADATA (flags 0x0): balancing
  SYSTEM (flags 0x0): balancing

Oh, and the drive does think it is out of space even though the drive
has been added:

$ dd if=3D/dev/random of=3Drandom
dd: writing to =E2=80=98random=E2=80=99: No space left on device
0+7 records in
0+0 records out
0 bytes (0 B) copied, 0.341074 s, 0.0 kB/s
