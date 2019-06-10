Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF163B502
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbfFJM2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:28:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389001AbfFJM2y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:28:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5AD4AE48
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:28:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 617FCDAC82; Mon, 10 Jun 2019 14:29:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Date:   Mon, 10 Jun 2019 14:29:40 +0200
Message-Id: <cover.1559917235.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this patchset brings the RAID1 with 3 and 4 copies as a separate
feature as outlined in V1
(https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).

This should help a bit in the raid56 situation, where the write hole
hurts most for metadata, without a block group profile that offers 2
device loss resistance.

I've gathered some feedback from knowlegeable poeople on IRC and the
following setup is considered good enough (certainly better than what we
have now):

- data: RAID6
- metadata: RAID1C3

The RAID1C3 vs RAID6 have different characteristics in terms of space
consumption and repair.


Space consumption
~~~~~~~~~~~~~~~~~

* RAID6 reduces overall metadata by N/(N-2), so with more devices the
  parity overhead ratio is small

* RAID1C3 will allways consume 67% of metadata chunks for redundancy

The overall size of metadata is typically in range of gigabytes to
hundreds of gigabytes (depends on usecase), rough estimate is from
1%-10%. With larger filesystem the percentage is usually smaller.

So, for the 3-copy raid1 the cost of redundancy is better expressed in
the absolute value of gigabytes "wasted" on redundancy than as the
ratio that does look scary compared to raid6.


Repair
~~~~~~

RAID6 needs to access all available devices to calculate the P and Q,
either 1 or 2 missing devices.

RAID1C3 can utilize the independence of each copy and also the way the
RAID1 works in btrfs. In the scenario with 1 missing device, one of the
2 correct copies is read and written to the repaired devices.

Given how the 2-copy RAID1 works on btrfs, the block groups could be
spread over several devices so the load during repair would be spread as
well.

Additionally, device replace works sequentially and in big chunks so on
a lightly used system the read pattern is seek-friendly.


Compatibility
~~~~~~~~~~~~~

The new block group types cost an incompatibility bit, so old kernel
will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
the filesystem with the new type.

To upgrade existing filesystems use the balance filters eg. from RAID6

  $ btrfs balance start -mconvert=raid1c3 /path


Merge target
~~~~~~~~~~~~

I'd like to push that to misc-next for wider testing and merge to 5.3,
unless something bad pops up. Given that the code changes are small and
just a new types with the constraints, the rest is done by the generic
code, I'm not expecting problems that can't be fixed before full
release.


Testing so far
~~~~~~~~~~~~~~

* mkfs with the profiles
* fstests (no specific tests, only check that it does not break)
* profile conversions between single/raid1/raid5/raid1c3/raid6/raid1c4/raid1c4
  with added devices where needed
* scrub

TODO:

* 1 missing device followed by repair
* 2 missing devices followed by repair


David Sterba (6):
  btrfs: add mask for all RAID1 types
  btrfs: use mask for RAID56 profiles
  btrfs: document BTRFS_MAX_MIRRORS
  btrfs: add support for 3-copy replication (raid1c3)
  btrfs: add support for 4-copy replication (raid1c4)
  btrfs: add incompat for raid1 with 3, 4 copies

 fs/btrfs/ctree.h                | 14 ++++++++--
 fs/btrfs/extent-tree.c          | 19 +++++++------
 fs/btrfs/scrub.c                |  2 +-
 fs/btrfs/super.c                |  6 +++++
 fs/btrfs/sysfs.c                |  2 ++
 fs/btrfs/volumes.c              | 48 ++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h              |  4 +++
 include/uapi/linux/btrfs.h      |  5 +++-
 include/uapi/linux/btrfs_tree.h | 10 +++++++
 9 files changed, 90 insertions(+), 20 deletions(-)

-- 
2.21.0

