Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96C45A9DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKWRXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 12:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhKWRXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 12:23:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F084C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 09:20:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so40208539wrh.4
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=B1cJJjzKPfZVeJO7xYJvc+JQph9shGzeLX3ISKyhO54=;
        b=EVggs5Ukzfbl+GMFtjmH4W46JomhUFtlyEtb3WSxxTjAeezCiuI2G+s5Cf7Jgv7xMv
         Izx+JwKZuMaMFkW8qeR1WJPoiFZEF/FbRZysGRsxPgTMXxLo6A/2//PK0RZl/qY+D6Kz
         bNBhDi2FFV+VjjZGCFUpTiHUcMeq1NgWvXFfGTFlJZwbwOt6X0nZ0XMBW9JnIHrqCkXD
         PLfnH/HAZ1nrd9i/WdiPRyfWZySmPOaV0O1vGCYJUlXOctSbE0hQjPhp0wtZmjqg9AzA
         WUxS1qHCRBgVvVuxx0Q2JSm7VpewtftjbeEi1i6EdAQnGNhbMtHML/y51DeuDrR7KLVR
         sLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=B1cJJjzKPfZVeJO7xYJvc+JQph9shGzeLX3ISKyhO54=;
        b=zVZoiH9XE1jXFP8SjfVcFLnJhASV3YgLL0wnLEI8ckRqMExjUivS7DBEuH2ITX8pfR
         D+RUw3i/F5KM2T17GKK0EDFOkrl7fjkGGH8rZZDrIaSEYKxeZ1BjAeMunRDaarlQJLY0
         OfTZuXsHvbi8ni6JEwwXX6AlOjxjLPztJguyh5vhi67EAkOlRZ0015mh8RZKvUiKjx1+
         NupXmGaCK3tRkOkQDRrO2rr44cJYUunMO/jH0/1qD+ghUo9Pm6X9bxDpyuckXfkkckIk
         LZRYhuzvN6o7+9mzaDpa5MQFP8BdEng61RjsYwRo3CZYwQgPv5dFwm5SKoM0MmORGeBg
         1fhg==
X-Gm-Message-State: AOAM531pIBMNiWIECEWNNMMuERdw4auMB6AScKquwXUUJ9+R7dFvFB8W
        1mAQz2f7qXiqlittkzjLnMfOIfl5VAGZNVJBJrXDX1QoTaEMFA==
X-Google-Smtp-Source: ABdhPJytkd8DyTi7Mnc9DHdXe8y8QVT9xEs/QlRZa3B1kl/MszBEz4jXnlEg55Kp1lyAB2TWcxpKKSWcgCNscRw932Q=
X-Received: by 2002:adf:f749:: with SMTP id z9mr6449005wrp.379.1637688033488;
 Tue, 23 Nov 2021 09:20:33 -0800 (PST)
MIME-Version: 1.0
References: <CAGGnn3JZdc3ETS_AijasaFUqLY9e5Q1ZHK3+806rtsEBnAo5Og@mail.gmail.com>
In-Reply-To: <CAGGnn3JZdc3ETS_AijasaFUqLY9e5Q1ZHK3+806rtsEBnAo5Og@mail.gmail.com>
From:   Christian COMMARMOND <christian.commarmond@gmail.com>
Date:   Tue, 23 Nov 2021 18:20:21 +0100
Message-ID: <CAGGnn3KMrb_--vukP18zzxvsgmONZMbZH79pF4r2sQN=UQw1nQ@mail.gmail.com>
Subject: Re:
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I use a TERRAMASTER F5-422, with 14Gb disks with 3 btrfs partitions.
After repeated power outages, the 3rd partition mounts, but data is
not visible, other that the first root directory.

I tried to repair the disk and get this:
[root@TNAS-00E1FD ~]# btrfsck --repair /dev/mapper/vg0-lv2
enabling repair mode
...
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/vg0-lv2
UUID: a7b536f5-1827-479c-9170-eccbbc624370
[1/7] checking root items
Error: could not find btree root extent for root 257
ERROR: failed to repair root items: No such file or directory

(I put the full /var/log/messages at the end of this mail).

What can I do to get my data back?
This is a backup disk, and I am supposed to have a copy of it in
another place, but there too, murphy's law, I had some disk failures,
and lost some of my data.
So it would be very good to be able to recover some data from these disks.

Other informations:
lsblk:
NAME          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda             8:0    0   3.7T  0 disk
|-sda1          8:1    0   285M  0 part
|-sda2          8:2    0   1.9G  0 part
| `-md9         9:9    0   1.9G  0 raid1 /
-|-sda3          8:3    0   977M  0 part
| `-md8         9:8    0 976.4M  0 raid1 [SWAP]
`-sda4          8:4    0   3.7T  0 part
  `-md0         9:0    0  14.6T  0 raid5
    |-vg0-lv0 251:0    0     2T  0 lvm   /mnt/md0
    |-vg0-lv1 251:1    0   3.9T  0 lvm   /mnt/md1
    `-vg0-lv2 251:2    0   8.7T  0 lvm   /mnt/md2
sdb             8:16   0   3.7T  0 disk
|-sdb1          8:17   0   285M  0 part
|-sdb2          8:18   0   1.9G  0 part
| `-md9         9:9    0   1.9G  0 raid1 /
|-sdb3          8:19   0   977M  0 part
| `-md8         9:8    0 976.4M  0 raid1 [SWAP]
`-sdb4          8:20   0   3.7T  0 part
  `-md0         9:0    0  14.6T  0 raid5
    |-vg0-lv0 251:0    0     2T  0 lvm   /mnt/md0
    |-vg0-lv1 251:1    0   3.9T  0 lvm   /mnt/md1
    `-vg0-lv2 251:2    0   8.7T  0 lvm   /mnt/md2
sdc             8:32   0   3.7T  0 disk
|-sdc1          8:33   0   285M  0 part
|-sdc2          8:34   0   1.9G  0 part
| `-md9         9:9    0   1.9G  0 raid1 /
|-sdc3          8:35   0   977M  0 part
| `-md8         9:8    0 976.4M  0 raid1 [SWAP]
`-sdc4          8:36   0   3.7T  0 part
  `-md0         9:0    0  14.6T  0 raid5
    |-vg0-lv0 251:0    0     2T  0 lvm   /mnt/md0
    |-vg0-lv1 251:1    0   3.9T  0 lvm   /mnt/md1
    `-vg0-lv2 251:2    0   8.7T  0 lvm   /mnt/md2
sdd             8:48   0   3.7T  0 disk
|-sdd1          8:49   0   285M  0 part
|-sdd2          8:50   0   1.9G  0 part
| `-md9         9:9    0   1.9G  0 raid1 /
|-sdd3          8:51   0   977M  0 part
| `-md8         9:8    0 976.4M  0 raid1 [SWAP]
`-sdd4          8:52   0   3.7T  0 part
  `-md0         9:0    0  14.6T  0 raid5
    |-vg0-lv0 251:0    0     2T  0 lvm   /mnt/md0
    |-vg0-lv1 251:1    0   3.9T  0 lvm   /mnt/md1
    `-vg0-lv2 251:2    0   8.7T  0 lvm   /mnt/md2
sde             8:64   0   3.7T  0 disk
|-sde1          8:65   0   285M  0 part
|-sde2          8:66   0   1.9G  0 part
| `-md9         9:9    0   1.9G  0 raid1 /
|-sde3          8:67   0   977M  0 part
| `-md8         9:8    0 976.4M  0 raid1 [SWAP]
`-sde4          8:68   0   3.7T  0 part
  `-md0         9:0    0  14.6T  0 raid5
    |-vg0-lv0 251:0    0     2T  0 lvm   /mnt/md0
    |-vg0-lv1 251:1    0   3.9T  0 lvm   /mnt/md1
    `-vg0-lv2 251:2    0   8.7T  0 lvm   /mnt/md2


df -h:
Filesystem                Size      Used Available Use% Mounted on
/dev/md9                  1.8G    576.8M      1.2G  32% /
devtmpfs                  1.8G         0      1.8G   0% /dev
tmpfs                     1.8G         0      1.8G   0% /dev/shm
tmpfs                     1.8G      1.1M      1.8G   0% /tmp
tmpfs                     1.8G    236.0K      1.8G   0% /run
tmpfs                     1.8G      6.3M      1.8G   0% /opt/var
/dev/mapper/vg0-lv0       2.0T     34.5M      2.0T   0% /mnt/md0
/dev/mapper/vg0-lv1       3.9T     16.3M      3.9T   0% /mnt/md1
/dev/mapper/vg0-lv2       8.7T      2.9T      5.8T  33% /mnt/md2

This physical disks are new (a few months) and do not show errors.

I hope there is a way to fix this.

regards,

Christian COMMARMOND


Here, the full (restricted to 'kernel') from the lines where I begin
to see errors:
Nov 23 17:00:46 TNAS-00E1FD kernel: [   34.540572] Detached from
scsi7, channel 0, id 0, lun 0, type 0
Nov 23 17:00:48 TNAS-00E1FD kernel: [   37.148169] md: md8 stopped.
Nov 23 17:00:48 TNAS-00E1FD kernel: [   37.154395] md/raid1:md8:
active with 1 out of 72 mirrors
Nov 23 17:00:48 TNAS-00E1FD kernel: [   37.155564] md8: detected
capacity change from 0 to 1023868928
Nov 23 17:00:49 TNAS-00E1FD kernel: [   38.240910] md: recovery of
RAID array md8
Nov 23 17:00:49 TNAS-00E1FD kernel: [   38.276712] md: md8: recovery
interrupted.
Nov 23 17:00:50 TNAS-00E1FD kernel: [   38.346552] md: recovery of
RAID array md8
Nov 23 17:00:50 TNAS-00E1FD kernel: [   38.392148] md: md8: recovery
interrupted.
Nov 23 17:00:50 TNAS-00E1FD kernel: [   38.458126] md: recovery of
RAID array md8
Nov 23 17:00:50 TNAS-00E1FD kernel: [   38.494025] md: md8: recovery
interrupted.
Nov 23 17:00:50 TNAS-00E1FD kernel: [   38.576871] md: recovery of
RAID array md8
Nov 23 17:00:50 TNAS-00E1FD kernel: [   38.837269] Adding 999868k swap
on /dev/md8.  Priority:-1 extents:1 across:999868k
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.801285] md: md0 stopped.
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.859798] md/raid:md0: device
sda4 operational as raid disk 0
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.861417] md/raid:md0: device
sde4 operational as raid disk 4
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.863675] md/raid:md0: device
sdd4 operational as raid disk 3
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.865059] md/raid:md0: device
sdc4 operational as raid disk 2
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.866373] md/raid:md0: device
sdb4 operational as raid disk 1
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.869300] md/raid:md0: raid
level 5 active with 5 out of 5 devices, algorithm 2
Nov 23 17:00:51 TNAS-00E1FD kernel: [   39.926721] md0: detected
capacity change from 0 to 15989118861312
Nov 23 17:00:57 TNAS-00E1FD kernel: [   46.111539] md: md8: recovery done.
Nov 23 17:00:57 TNAS-00E1FD kernel: [   46.269349] flashcache:
flashcache-3.1.1 initialized
Nov 23 17:00:58 TNAS-00E1FD kernel: [   46.394510] BTRFS: device fsid
bdc3dbee-00a3-4541-99b4-096cd27939f2 devid 1 transid 679
/dev/mapper/vg0-lv0
Nov 23 17:00:58 TNAS-00E1FD kernel: [   46.397072] BTRFS info (device
dm-0): metadata ratio 50
Nov 23 17:00:58 TNAS-00E1FD kernel: [   46.399122] BTRFS info (device
dm-0): using free space tree
Nov 23 17:00:58 TNAS-00E1FD kernel: [   46.400380] BTRFS info (device
dm-0): has skinny extents
Nov 23 17:00:58 TNAS-00E1FD kernel: [   46.471236] BTRFS info (device
dm-0): new size for /dev/mapper/vg0-lv0 is 2147483648000
Nov 23 17:00:58 TNAS-00E1FD kernel: [   47.087622] BTRFS: device fsid
a5828e5a-1b11-4743-891c-11d0d8aeb1ae devid 1 transid 107
/dev/mapper/vg0-lv1
Nov 23 17:00:58 TNAS-00E1FD kernel: [   47.089943] BTRFS info (device
dm-1): metadata ratio 50
Nov 23 17:00:58 TNAS-00E1FD kernel: [   47.091505] BTRFS info (device
dm-1): using free space tree
Nov 23 17:00:58 TNAS-00E1FD kernel: [   47.093062] BTRFS info (device
dm-1): has skinny extents
Nov 23 17:00:58 TNAS-00E1FD kernel: [   47.150713] BTRFS info (device
dm-1): new size for /dev/mapper/vg0-lv1 is 4294967296000
Nov 23 17:00:59 TNAS-00E1FD kernel: [   47.737119] BTRFS: device fsid
a7b536f5-1827-479c-9170-eccbbc624370 devid 1 transid 142633
/dev/mapper/vg0-lv2
Nov 23 17:00:59 TNAS-00E1FD kernel: [   47.739313] BTRFS info (device
dm-2): metadata ratio 50
Nov 23 17:00:59 TNAS-00E1FD kernel: [   47.740630] BTRFS info (device
dm-2): using free space tree
Nov 23 17:00:59 TNAS-00E1FD kernel: [   47.741892] BTRFS info (device
dm-2): has skinny extents
Nov 23 17:00:59 TNAS-00E1FD kernel: [   47.946451] BTRFS info (device
dm-2): bdev /dev/mapper/vg0-lv2 errs: wr 0, rd 0, flush 0, corrupt 0,
gen 8
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.693394] BTRFS info (device
dm-2): checking UUID tree
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.700560] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.707394] BTRFS info (device
dm-2): new size for /dev/mapper/vg0-lv2 is 9546663723008
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.713109] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.715107] BTRFS warning
(device dm-2): iterating uuid_tree failed -5
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.795716] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:01 TNAS-00E1FD kernel: [   49.798231] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:03 TNAS-00E1FD kernel: [   52.272802] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:03 TNAS-00E1FD kernel: [   52.275264] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:03 TNAS-00E1FD kernel: [   52.277208] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:03 TNAS-00E1FD kernel: [   52.278483] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:04 TNAS-00E1FD kernel: [   52.570033] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:04 TNAS-00E1FD kernel: [   52.571487] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:05 TNAS-00E1FD kernel: [   54.250527] nf_conntrack:
default automatic helper assignment has been turned off for security
reasons and CT-based  firewall rule not found. Use the iptables CT
target to attach helpers instead.
Nov 23 17:01:07 TNAS-00E1FD kernel: [   56.050418]
verify_parent_transid: 2 callbacks suppressed
Nov 23 17:01:07 TNAS-00E1FD kernel: [   56.050424] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:07 TNAS-00E1FD kernel: [   56.063012] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:07 TNAS-00E1FD kernel: [   56.166746] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:07 TNAS-00E1FD kernel: [   56.167903] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:07 TNAS-00E1FD kernel: [   56.274188] NFSD: starting
90-second grace period (net ffffffff9db5abc0)
Nov 23 17:01:09 TNAS-00E1FD kernel: [   57.524631] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:09 TNAS-00E1FD kernel: [   57.525878] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:09 TNAS-00E1FD kernel: [   57.589706] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:09 TNAS-00E1FD kernel: [   57.590882] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:01:10 TNAS-00E1FD kernel: [   58.315852] warning: `smbd'
uses legacy ethtool link settings API, link modes are only partially
reported
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.882060] BTRFS error (device
dm-2): incorrect extent count for 29360128; counted 740, expected 677
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.883000] BTRFS: error
(device dm-2) in convert_free_space_to_extents:457: errno=-5 IO
failure
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.883946] BTRFS info (device
dm-2): forced readonly
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.884896] BTRFS: error
(device dm-2) in add_to_free_space_tree:1052: errno=-5 IO failure
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.885863] BTRFS: error
(device dm-2) in __btrfs_free_extent:7106: errno=-5 IO failure
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.886825] BTRFS: error
(device dm-2) in btrfs_run_delayed_refs:3009: errno=-5 IO failure
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.887803] BTRFS warning
(device dm-2): Skipping commit of aborted transaction.
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.888807] BTRFS: error
(device dm-2) in cleanup_transaction:1873: errno=-5 IO failure
Nov 23 17:01:31 TNAS-00E1FD kernel: [   79.892906] BTRFS error (device
dm-2): incorrect extent count for 29360128; counted 739, expected 676
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.199509] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.212280] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.214362] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.216331] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.224184] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.225500] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.227338] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:02:55 TNAS-00E1FD kernel: [  164.228636] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.915492] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.936745] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.938543] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.940375] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.951375] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.952810] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.972430] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.973548] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.974819] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:37 TNAS-00E1FD kernel: [  205.975984] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:54 TNAS-00E1FD kernel: [  222.807122]
verify_parent_transid: 6 callbacks suppressed
Nov 23 17:03:54 TNAS-00E1FD kernel: [  222.807127] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:54 TNAS-00E1FD kernel: [  222.819996] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:54 TNAS-00E1FD kernel: [  222.923926] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:54 TNAS-00E1FD kernel: [  222.925434] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:54 TNAS-00E1FD kernel: [  223.061241] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:54 TNAS-00E1FD kernel: [  223.062463] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:59 TNAS-00E1FD kernel: [  227.554549] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:03:59 TNAS-00E1FD kernel: [  227.556100] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:04:13 TNAS-00E1FD kernel: [  242.190152] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:04:13 TNAS-00E1FD kernel: [  242.202843] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:04:13 TNAS-00E1FD kernel: [  242.215390] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:04:13 TNAS-00E1FD kernel: [  242.217241] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:05:15 TNAS-00E1FD kernel: [  303.772878] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:05:15 TNAS-00E1FD kernel: [  303.785862] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:14 TNAS-00E1FD kernel: [  362.480763] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:14 TNAS-00E1FD kernel: [  362.493848] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.055419] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.068306] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.069074] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.069862] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.076040] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.076821] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.077643] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:06:43 TNAS-00E1FD kernel: [  392.078360] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:02 TNAS-00E1FD kernel: [  830.643054] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:02 TNAS-00E1FD kernel: [  830.664937] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:11 TNAS-00E1FD kernel: [  839.988330] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:11 TNAS-00E1FD kernel: [  839.989850] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:11 TNAS-00E1FD kernel: [  839.991371] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:11 TNAS-00E1FD kernel: [  839.992867] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:12 TNAS-00E1FD kernel: [  840.488126] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:14:12 TNAS-00E1FD kernel: [  840.488998] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.266877] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.288688] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.289624] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.290454] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.300198] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.300917] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.301704] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:16:36 TNAS-00E1FD kernel: [  985.302318] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:34:24 TNAS-00E1FD kernel: [ 2052.815271] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:34:24 TNAS-00E1FD kernel: [ 2052.838506] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:34:52 TNAS-00E1FD kernel: [ 2081.273231] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:34:52 TNAS-00E1FD kernel: [ 2081.296585] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:39:26 TNAS-00E1FD kernel: [ 2354.866442] BTRFS error (device
dm-2): cleaner transaction attach returned -30
Nov 23 17:56:30 TNAS-00E1FD kernel: [ 3378.825461] BTRFS info (device
dm-2): using free space tree
Nov 23 17:56:30 TNAS-00E1FD kernel: [ 3378.825891] BTRFS info (device
dm-2): has skinny extents
Nov 23 17:56:30 TNAS-00E1FD kernel: [ 3378.968533] BTRFS info (device
dm-2): bdev /dev/mapper/vg0-lv2 errs: wr 0, rd 0, flush 0, corrupt 0,
gen 8
Nov 23 17:56:32 TNAS-00E1FD kernel: [ 3380.525294] BTRFS info (device
dm-2): checking UUID tree
Nov 23 17:56:32 TNAS-00E1FD kernel: [ 3380.535839] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:56:32 TNAS-00E1FD kernel: [ 3380.544791] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:56:32 TNAS-00E1FD kernel: [ 3380.545579] BTRFS warning
(device dm-2): iterating uuid_tree failed -5
Nov 23 17:56:42 TNAS-00E1FD kernel: [ 3391.302453] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:56:43 TNAS-00E1FD kernel: [ 3391.328368] BTRFS error (device
dm-2): parent transid verify failed on 174735360 wanted 37018 found
37023
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.806326] BTRFS error (device
dm-2): incorrect extent count for 29360128; counted 740, expected 677
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.806836] BTRFS: error
(device dm-2) in convert_free_space_to_extents:457: errno=-5 IO
failure
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.807367] BTRFS info (device
dm-2): forced readonly
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.807904] BTRFS: error
(device dm-2) in add_to_free_space_tree:1052: errno=-5 IO failure
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.808493] BTRFS: error
(device dm-2) in __btrfs_free_extent:7106: errno=-5 IO failure
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.809160] BTRFS: error
(device dm-2) in btrfs_run_delayed_refs:3009: errno=-5 IO failure
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.809785] BTRFS warning
(device dm-2): Skipping commit of aborted transaction.
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.810444] BTRFS: error
(device dm-2) in cleanup_transaction:1873: errno=-5 IO failure
Nov 23 17:57:01 TNAS-00E1FD kernel: [ 3409.814113] BTRFS error (device
dm-2): incorrect extent count for 29360128; counted 739, expected 676
