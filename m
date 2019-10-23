Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4BAE269F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406216AbfJWWxU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34107 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfJWWxU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id e14so14969000qto.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2Yd21/J41rQwfjb4Ci/HpctMGQG92+zJduEH/MOTns=;
        b=Pl1omv4cWcYsTnP3s5U1kF1sI2btivULni0qZmIp/HETU/6pCcHl7XEf1L2pkwPxII
         6HzOxi3BEUAdNfX764WM1COZTIyvRD/PILwR1BWSn/703ECdF+iLuv1ZVX832bAkXPa2
         DgT/OdENQcH8Ml7E/PPg/02EEpx5DLu0GENpxMfZt95iq1b4O+f0E9MGv+fDOhTn2kOV
         kdV6rbP2VZcqtQP1WgX0YR/1N+U7WRDsknNt/1pdXbyUCMgN2+27nbn9v1I/y1aKZzX8
         qywc4LADbEgEUmge7884GcsJgH7EwQyuD9LO/hshFJrlNJgKsOm+rpWMbKj8XoGXxDqS
         6MkA==
X-Gm-Message-State: APjAAAU0yhJy42Fas2oJYHA5/v0Rp59LmnpzQ86C6b1QbGsHzQMOLahN
        CfiY9Nq3zMFTrsjAgPp9oU8=
X-Google-Smtp-Source: APXvYqyOAU33f6W0KyiaxxQh/hArOc5c5rln1UdW39as51jgI9OYPwvLLCZBoeGKAtHYzWWHXSgt8Q==
X-Received: by 2002:ac8:2484:: with SMTP id s4mr1163510qts.350.1571871199128;
        Wed, 23 Oct 2019 15:53:19 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:18 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v2 00/22] btrfs: async discard support
Date:   Wed, 23 Oct 2019 18:52:54 -0400
Message-Id: <cover.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

The RFC [1] went a lot better than expected, so let's call this v2.

Changes:
 - I don't believe there are any functional changes to the code, but
   there are plenty of changes for readability and a lot of comments
   added.
 - Split out the sysfs parts into their own patches as it was a bit of
   work to put discard/ under debug/.
 - Switched over any flags to be enums. All the variables are now of
   appropriate type rather than being all atomics.
 - Dropped 0015 [2] from v1, load block groups on mount. This is in
   favor of reading everything in as clean and running fstrim as needed.
 - Misc. bug fixes.
 - I changed the block_group discard delay from 300s to 120s. It is just
   to give the allocators a chance to reuse the LBA before letting async
   discard take a crack at it.

Data:
On a number of webservers, I collected data every minute accounting the
time we spent in btrfs_finish_extent_commit() (col. 1) and in
btrfs_commit_transaction() (col. 2). btrfs_finish_extent_commit() is
where we discard extents synchronously before returning them to the
free space cache.

discard=sync:
                 p99 total per minute       p99 total per minute
      Drive   |   extent_commit() (ms)  |    commit_trans() (ms)
    ---------------------------------------------------------------
     Drive A  |           434           |          1170 
     Drive B  |           880           |          2330
     Drive C  |          2943           |          3920
     Drive D  |          4763           |          5701

discard=async:
                 p99 total per minute       p99 total per minute
      Drive   |   extent_commit() (ms)  |    commit_trans() (ms)
    --------------------------------------------------------------
     Drive A  |           134           |           956
     Drive B  |            64           |          1972
     Drive C  |            59           |          1032
     Drive D  |            62           |          1200

While it's not great that the stats are cumulative over 1m, all of these
servers are running the same workload and and the delta between the two
are substantial. We are spending significantly less time in
btrfs_finish_extent_commit() which is responsible for discarding.

From v1:
--------
Discard is an operation that allows for the filesystem to communicate
with underlying ssds that a lba region is no longer needed. This gives
the drive the more information as it tries to manage the available free
space to minimize write amplification. However, discard hasn't been
given the most tlc. Discard is a problematic command because a drive's
physical block management is more or less a black box to us and the
effects of any particular discard aren't necessarily limited the
lifetime of a command.

Currently, btrfs handles discarding synchronously during transaction
commit. This problematically can delay transaction commit based on the
amount of space that needs to be trimmed and the efficacy of the discard
operation for a particular drive.

This series introduces async discarding, which removes discard from the
transaction commit path. While every SSD has the choice of implementing
trim support different, we strive here to do the right thing. The idea
hinges on recognizing that write amplification really only kicks in once
we're really low on free space.  As long as we trim enough to keep a
large enough pool of free space, in theory this should minimize the cost
of issuing discards on a workload and have limited cost overhead in
write amplification.

With async discard, we try to emphasize discarding larger regions
and reusing the lba (implicit discard). The first is done by using the
free space cache to maintain discard state and thus allows us to get
coalescing for fairly cheap. A background workqueue is used to scan over
an LRU kept list of the block groups. It then uses filters to determine
what to discard next hence giving priority to larger discards. While
reusing an lba isn't explicitly attempted, it happens implicitly via
find_free_extent() which if it happens to find a dirty extent, will
grant us reuse of the lba. Additionally, async discarding skips metadata
block groups as these should see a fairly high turnover as btrfs is a
self-packing filesystem being stingy with allocating new block groups
until necessary.

Preliminary results seem promising as when a lot of freeing is going on,
the discarding is delayed allowing for reuse which translates to less
discarding (in addition to the slower discarding). This has shown a
reduction in p90 and p99 read latencies on a test on our webservers.

I am currently working on tuning the rate at which it discards in the
background. I am doing this by evaluating other workloads and drives.
The iops and bps rate limits are fairly aggressive right now as my
basic survey of a few drives noted that the trim command itself is a
significant part of the overhead. So optimizing for larger trims is the
right thing to do.

This series contains the following 22 patches and is on top of
btrfs-devel#master 3b7c59a1950c:
  0001-bitmap-genericize-percpu-bitmap-region-iterators.patch
  0002-btrfs-rename-DISCARD-opt-to-DISCARD_SYNC.patch
  0003-btrfs-keep-track-of-which-extents-have-been-discarde.patch
  0004-btrfs-keep-track-of-cleanliness-of-the-bitmap.patch
  0005-btrfs-add-the-beginning-of-async-discard-discard-wor.patch
  0006-btrfs-handle-empty-block_group-removal.patch
  0007-btrfs-discard-one-region-at-a-time-in-async-discard.patch
  0008-btrfs-add-removal-calls-for-sysfs-debug.patch
  0009-btrfs-make-UUID-debug-have-its-own-kobject.patch
  0010-btrfs-add-discard-sysfs-directory.patch
  0011-btrfs-track-discardable-extents-for-async-discard.patch
  0012-btrfs-keep-track-of-discardable_bytes.patch
  0013-btrfs-calculate-discard-delay-based-on-number-of-ext.patch
  0014-btrfs-add-bps-discard-rate-limit.patch
  0015-btrfs-limit-max-discard-size-for-async-discard.patch
  0016-btrfs-make-max-async-discard-size-tunable.patch
  0017-btrfs-have-multiple-discard-lists.patch
  0018-btrfs-only-keep-track-of-data-extents-for-async-disc.patch
  0019-btrfs-keep-track-of-discard-reuse-stats.patch
  0020-btrfs-add-async-discard-header.patch
  0021-btrfs-increase-the-metadata-allowance-for-the-free_s.patch
  0022-btrfs-make-smaller-extents-more-likely-to-go-into-bi.patch

0001 exports percpu's bitmap iterators for eventual use in 0011. 0002
renames DISCARD to DISCARD_SYNC. 0003 and 0004 adds discard tracking to
the free space cache. 0005-0007 adds the core of async discard support.
0008-0010 modify debug sysfs to allow for adding discard/ under debug/.
0011-0016 fiddle with stats and operation limits. 0018 makes async
discarding only track data block groups. 0019 adds reuse stats. 0020
adds an explanation header to discard.c. 0021 and 0022 modify the free
space cache metadata allowance, add a bitmap -> extent path and makes us
more likely to put smaller extents into the bitmaps.

diffstats below:

Dennis Zhou (22):
  bitmap: genericize percpu bitmap region iterators
  btrfs: rename DISCARD opt to DISCARD_SYNC
  btrfs: keep track of which extents have been discarded
  btrfs: keep track of cleanliness of the bitmap
  btrfs: add the beginning of async discard, discard workqueue
  btrfs: handle empty block_group removal
  btrfs: discard one region at a time in async discard
  btrfs: add removal calls for sysfs debug/
  btrfs: make UUID/debug have its own kobject
  btrfs: add discard sysfs directory
  btrfs: track discardable extents for async discard
  btrfs: keep track of discardable_bytes
  btrfs: calculate discard delay based on number of extents
  btrfs: add bps discard rate limit
  btrfs: limit max discard size for async discard
  btrfs: make max async discard size tunable
  btrfs: have multiple discard lists
  btrfs: only keep track of data extents for async discard
  btrfs: keep track of discard reuse stats
  btrfs: add async discard header
  btrfs: increase the metadata allowance for the free_space_cache
  btrfs: make smaller extents more likely to go into bitmaps

 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/block-group.c      |  56 ++-
 fs/btrfs/block-group.h      |  30 ++
 fs/btrfs/ctree.h            |  52 ++-
 fs/btrfs/discard.c          | 666 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  48 +++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |  23 +-
 fs/btrfs/free-space-cache.c | 587 ++++++++++++++++++++++++++-----
 fs/btrfs/free-space-cache.h |  39 ++-
 fs/btrfs/inode-map.c        |  13 +-
 fs/btrfs/scrub.c            |   7 +-
 fs/btrfs/super.c            |  39 ++-
 fs/btrfs/sysfs.c            | 203 ++++++++++-
 include/linux/bitmap.h      |  35 ++
 mm/percpu.c                 |  61 +---
 16 files changed, 1723 insertions(+), 153 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h

Thanks,
Dennis
