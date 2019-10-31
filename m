Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A28EB3A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfJaPNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 11:13:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728292AbfJaPNj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 11:13:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94DD8B6F3;
        Thu, 31 Oct 2019 15:13:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 648B4DA783; Thu, 31 Oct 2019 16:13:42 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v3 0/4] RAID1 with 3- and 4- copies
Date:   Thu, 31 Oct 2019 16:13:41 +0100
Message-Id: <cover.1572534591.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here it goes again, RAID1 with 3- and 4- copies. I found the bug that stopped
it from inclusion last time, it was in the test itself, so the kernel code is
effectively unchanged.

So, with 1 or 2 missing devices, replace by device id works. There's one
annoying thing but not new: regarding replace of a missing device, some
extra single/dup block groups are created during the replace process.
Example below. This can happen on plain raid1 with degraded read-write
mount as well.

Now what's the merge target.

The patches almost made it to 5.3, the changes build on existing code so the
actual addition of new profiles is namely in the definitions and additional
cases. So it should be safe.

I'm for adding it to 5.5 queue, though we're at rc5 and this can be seen as a
late time for a feature. The user benefits are noticeable, raid1c3 can replace
raid6 of metadata which is the most problematic part and much more complicated
to fix (write ahead journal or something like that). The feedback regarding the
plain 3-copy as a replacement was positive, on IRC and there are mails about
that too.

Further information can be found in the 5.3-time submission:
https://lore.kernel.org/linux-btrfs/cover.1559917235.git.dsterba@suse.com/

--

Example of 2 devices gone missing and replaced
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 - mkfs -d raid1c3 -m raidc3 /dev/sda10 /dev/sda11 /dev/sda12

 - delete devices 2 and 3 from the system

              Data      Metadata  System
Id Path       RAID1C3   RAID1C3   RAID1C3  Unallocated
-- ---------- --------- --------- -------- -----------
 1 /dev/sda10   1.00GiB 256.00MiB  8.00MiB     8.74GiB
 2 missing      1.00GiB 256.00MiB  8.00MiB    -1.26GiB
 3 missing      1.00GiB 256.00MiB  8.00MiB    -1.26GiB
-- ---------- --------- --------- -------- -----------
   Total        1.00GiB 256.00MiB  8.00MiB     6.23GiB
   Used       200.31MiB 320.00KiB 16.00KiB

- mount -o degraded

- btrfs replace 2 /dev/sda13

              Data      Metadata  Metadata  System   System
Id Path       RAID1C3   single    RAID1C3   single   RAID1C3 Unallocated
-- ---------- --------- --------- --------- -------- ------- -----------
 1 /dev/sda10   1.00GiB 256.00MiB 256.00MiB 32.00MiB 8.00MiB     8.46GiB
 2 /dev/sda13   1.00GiB         - 256.00MiB        - 8.00MiB     8.74GiB
 3 missing      1.00GiB         - 256.00MiB        - 8.00MiB    -1.26GiB
-- ---------- --------- --------- --------- -------- ------- -----------
   Total        1.00GiB 256.00MiB 256.00MiB 32.00MiB 8.00MiB    15.95GiB
   Used       200.31MiB     0.00B 320.00KiB 16.00KiB   0.00B


- btrfs replace 3 /dev/sda14

              Data      Metadata  Metadata  System   System
Id Path       RAID1C3   single    RAID1C3   single   RAID1C3 Unallocated
-- ---------- --------- --------- --------- -------- ------- -----------
 1 /dev/sda10   1.00GiB 256.00MiB 256.00MiB 32.00MiB 8.00MiB     8.46GiB
 2 /dev/sda13   1.00GiB         - 256.00MiB        - 8.00MiB     8.74GiB
 3 /dev/sda14   1.00GiB         - 256.00MiB        - 8.00MiB     8.74GiB
-- ---------- --------- --------- --------- -------- ------- -----------
   Total        1.00GiB 256.00MiB 256.00MiB 32.00MiB 8.00MiB    25.95GiB
   Used       200.31MiB     0.00B 320.00KiB 16.00KiB   0.00B

There you can see the metadata/single and system/single chunks, that are
otherwise unused if there are no other writes happening during replace.
Running 'balance start -mconvert=raid1c3,profiles=single' should get rid of
them.

This is an annoyance, we have a plan to avoid that but it needs to change
behaviour with degraded mount and enabled writes.

Implementation details: The new profiles are reduced from the expected ones
  (raid1 -> single or dup) to allow writes without breaking the raid
  constraints.  To relax that condition, allow writing to "half" of the raid
  with a missing device will skip creating the block groups.

  This is similar to MD-RAID that allows writing to just one of the RAID1
  devices, and then sync to the other when it's available again.

  With the btrfs style raid1 we can do better in case there are enough other
  devices that would satify the raid1 constraint (yet with a missing device).

--

David Sterba (4):
  btrfs: add support for 3-copy replication (raid1c3)
  btrfs: add support for 4-copy replication (raid1c4)
  btrfs: add incompat for raid1 with 3, 4 copies
  btrfs: drop incompat bit for raid1c34 after last block group is gone

 fs/btrfs/block-group.c          | 27 ++++++++++++++--------
 fs/btrfs/ctree.h                |  7 +++---
 fs/btrfs/super.c                |  4 ++++
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/volumes.c              | 40 +++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h              |  4 ++++
 include/uapi/linux/btrfs.h      |  5 ++++-
 include/uapi/linux/btrfs_tree.h | 10 ++++++++-
 8 files changed, 83 insertions(+), 16 deletions(-)

-- 
2.23.0

