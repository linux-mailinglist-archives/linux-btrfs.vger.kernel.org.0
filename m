Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC247945D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhLQSwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:24 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:53000 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240414AbhLQSwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:21 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 13:52:21 EST
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnQoN; Fri, 17 Dec 2021 18:47:25 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Date:   Fri, 17 Dec 2021 19:47:16 +0100
Message-Id: <cover.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766845; bh=8zkgOCMOPbRQ4J6MHgFbTn7uAyTUrlSRc1Z/DCVHRMQ=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=kTj7yKYgwbgZxRBwNSdU9C6SIckreKKMBNRG8ubyDTjvWi61dP1mAGyhARf0CnPVi
         DCoFYt5yxBw20lb3c905eG9uR++ZKuxhEmIApZB6VHiLfmZa4DbR3zDkTzUqfM4KFY
         yN81uwlZsvbg7UD9cSllgfM6ICefrkloQuUAKInU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Hi all,

This patches set was born after some discussion between me, Zygo and Josef.
Some details can be found in https://github.com/btrfs/btrfs-todo/issues/19.

Some further information about a real use case can be found in
https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/

Reently Shafeeq told me that he is interested too, due to the performance gain.

In V8 revision I switched away from an ioctl API in favor of a sysfs API (
see patch #2 and #3).

In V9 I renamed the sysfs interface from devinfo/type to devinfo/allocation_hint.
Moreover I renamed dev_info->type to dev_info->flags.

The idea behind this patches set, is to dedicate some disks (the fastest one)
to the metadata chunk. My initial idea was a "soft" hint. However Zygo
asked an option for a "strong" hint (== mandatory). The result is that
each disk can be "tagged" by one of the following flags:
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
- BTRFS_DEV_ALLOCATION_PREFERRED_DATA
- BTRFS_DEV_ALLOCATION_DATA_ONLY

When the chunk allocator search a disks to allocate a chunk, scans the disks
in an order decided by these tags. For metadata, the order is:
*_METADATA_ONLY
*_PREFERRED_METADATA
*_PREFERRED_DATA

The *_DATA_ONLY are not eligible from metadata chunk allocation.

For the data chunk, the order is reversed, and the *_METADATA_ONLY are
excluded.

The exact sort logic is to sort first for the "tag", and then for the space
available. If there is no space available, the next "tag" disks set are
selected.

To set these tags, a new property called "allocation_hint" was created.
There is a dedicated btrfs-prog patches set [[PATCH V9] btrfs-progs:
allocation_hint disk property].

$ sudo mount /dev/loop0 /mnt/test-btrfs/
$ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
devid=1, path=/dev/loop0: allocation_hint=PREFERRED_METADATA
devid=2, path=/dev/loop1: allocation_hint=PREFERRED_METADATA
devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA
devid=4, path=/dev/loop3: allocation_hint=PREFERRED_DATA
devid=5, path=/dev/loop4: allocation_hint=PREFERRED_DATA
devid=6, path=/dev/loop5: allocation_hint=DATA_ONLY
devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY

$ sudo ./btrfs fi us /mnt/test-btrfs/
Overall:
    Device size:           2.75GiB
    Device allocated:           1.34GiB
    Device unallocated:           1.41GiB
    Device missing:             0.00B
    Used:             400.89MiB
    Free (estimated):           1.04GiB    (min: 1.04GiB)
    Data ratio:                  2.00
    Metadata ratio:              1.00
    Global reserve:           3.25MiB    (used: 0.00B)
    Multiple profiles:                no

Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
   /dev/loop0     288.00MiB
   /dev/loop1     288.00MiB
   /dev/loop2     127.00MiB
   /dev/loop3     127.00MiB
   /dev/loop4     127.00MiB
   /dev/loop5     127.00MiB

Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
   /dev/loop1     256.00MiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/loop0      32.00MiB

Unallocated:
   /dev/loop0     704.00MiB
   /dev/loop1     480.00MiB
   /dev/loop2       1.00MiB
   /dev/loop3       1.00MiB
   /dev/loop4       1.00MiB
   /dev/loop5       1.00MiB
   /dev/loop6     128.00MiB
   /dev/loop7     128.00MiB

# change the tag of some disks

$ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY
$ sudo ./btrfs prop set /dev/loop1 allocation_hint DATA_ONLY
$ sudo ./btrfs prop set /dev/loop5 allocation_hint METADATA_ONLY

$ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
devid=1, path=/dev/loop0: allocation_hint=DATA_ONLY
devid=2, path=/dev/loop1: allocation_hint=DATA_ONLY
devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA
devid=4, path=/dev/loop3: allocation_hint=PREFERRED_DATA
devid=5, path=/dev/loop4: allocation_hint=PREFERRED_DATA
devid=6, path=/dev/loop5: allocation_hint=METADATA_ONLY
devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY

$ sudo btrfs bal start --full-balance /mnt/test-btrfs/
$ sudo ./btrfs fi us /mnt/test-btrfs/
Overall:
    Device size:           2.75GiB
    Device allocated:         735.00MiB
    Device unallocated:           2.03GiB
    Device missing:             0.00B
    Used:             400.72MiB
    Free (estimated):           1.10GiB    (min: 1.10GiB)
    Data ratio:                  2.00
    Metadata ratio:              1.00
    Global reserve:           3.25MiB    (used: 0.00B)
    Multiple profiles:                no

Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
   /dev/loop0     288.00MiB
   /dev/loop1     288.00MiB

Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
   /dev/loop5     127.00MiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/loop7      32.00MiB

Unallocated:
   /dev/loop0     736.00MiB
   /dev/loop1     736.00MiB
   /dev/loop2     128.00MiB
   /dev/loop3     128.00MiB
   /dev/loop4     128.00MiB
   /dev/loop5       1.00MiB
   /dev/loop6     128.00MiB
   /dev/loop7      96.00MiB


#As you can see all the metadata were placed on the disk loop5/loop7 even if
#the most empty one are loop0 and loop1.



TODO:
- more tests
- the tool which show the space available should consider the tagging (eg
  the disks tagged by _METADATA_ONLY should be excluded from the data
  availability)
- allow btrfs-prog to change the allocation_hint even when the filesystem
  is not mounted.


Comments are welcome
BR
G.Baroncelli

Revision:
V9:
- rename dev_item->type to dev_item->flags
- rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint

V8:
- drop the ioctl API, instead use a sysfs one

V7:
- make more room in the struct btrfs_ioctl_dev_properties up to 1K
- leave in btrfs_tree.h only the costants
- removed the mount option (sic)
- correct an 'use before check' in the while loop (signaled
  by Zygo)
- add a 2nd sort to be sure that the device_info array is in the
  expected order

V6:
- add further values to the hints: add the possibility to
  exclude a disk for a chunk type 


Goffredo Baroncelli (6):
  btrfs: add flags to give an hint to the chunk allocator
  btrfs: export the device allocation_hint property in sysfs
  btrfs: change the device allocation_hint property via sysfs
  btrfs: add allocation_hint mode
  btrfs: rename dev_item->type to dev_item->flags
  btrfs: add allocation_hint option.

 fs/btrfs/ctree.h                |  18 +++++-
 fs/btrfs/disk-io.c              |   4 +-
 fs/btrfs/super.c                |  17 ++++++
 fs/btrfs/sysfs.c                |  73 ++++++++++++++++++++++
 fs/btrfs/volumes.c              | 105 ++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h              |   7 ++-
 include/uapi/linux/btrfs_tree.h |  20 +++++-
 7 files changed, 232 insertions(+), 12 deletions(-)

-- 
2.34.1

