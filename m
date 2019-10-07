Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8FECED41
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGURy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:17:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37406 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGURy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:17:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so13926468qkd.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A+tKGrFQE+RqFAoABJje+XLBw4/azw/l5fPIF+cpKM0=;
        b=ZbpiS8ViKtfLOZhfrUxz6e9mFAxhDb31Kb7MLxQsWhh4skNVdlfP46VFueumDlSJ9K
         RguIXshgYgpF1e81L9mtuYSkzJWNpi95JBIALqEkoZkSLgVJTpQ0e2p3cToAnksR3DcM
         4JEJ5EZGbgyASHWrQX+KcNT482DkpP4g4FTV+RX+t7KaYi8GyLJm8JIMi/6EgN+G3e/D
         942sFwktt7jG8lgOGCKHN3o72Wb2/1Vp6I0egPX6wwh/4DWfDKbGSsrnYYldZ2EuXc1a
         oIks03slyQw0EdJ+ArKgRmtgLFSiHbMPOjb+x821coZO2KclGcs5eSD8X58gQfEI2oZ4
         k0Yg==
X-Gm-Message-State: APjAAAU8bhZfHz4oF/Wvg5hFYYoxFv0VnOO8NpIm/B/x9nKRITGuuyqW
        MlD0umZZopc0MTE3oUiIP+EZ8VF4
X-Google-Smtp-Source: APXvYqyu1OgTBi6E4wd037LOhMCg8kamkWnQ9Gt2yYcT/NYVPf7FxbuJfymzS+84xjQ5izais5DmVg==
X-Received: by 2002:ae9:e312:: with SMTP id v18mr6461454qkf.252.1570479472957;
        Mon, 07 Oct 2019 13:17:52 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:52 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [RFC PATCH 00/19] btrfs: async discard support
Date:   Mon,  7 Oct 2019 16:17:31 -0400
Message-Id: <cover.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

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

Persistence isn't supported, so when we mount a filesystem, the block
groups are read in as dirty and background trim begins. This makes async
discard more useful for longer running mount points.

This series contains the following 19 patches and is on top of
btrfs-devel#master 0f1a7b3fac05:
  0001-bitmap-genericize-percpu-bitmap-region-iterators.patch
  0002-btrfs-rename-DISCARD-opt-to-DISCARD_SYNC.patch
  0003-btrfs-keep-track-of-which-extents-have-been-discarde.patch
  0004-btrfs-keep-track-of-cleanliness-of-the-bitmap.patch
  0005-btrfs-add-the-beginning-of-async-discard-discard-wor.patch
  0006-btrfs-handle-empty-block_group-removal.patch
  0007-btrfs-discard-one-region-at-a-time-in-async-discard.patch
  0008-btrfs-track-discardable-extents-for-asnyc-discard.patch
  0009-btrfs-keep-track-of-discardable_bytes.patch
  0010-btrfs-calculate-discard-delay-based-on-number-of-ext.patch
  0011-btrfs-add-bps-discard-rate-limit.patch
  0012-btrfs-limit-max-discard-size-for-async-discard.patch
  0013-btrfs-have-multiple-discard-lists.patch
  0014-btrfs-only-keep-track-of-data-extents-for-async-disc.patch
  0015-btrfs-load-block_groups-into-discard_list-on-mount.patch
  0016-btrfs-keep-track-of-discard-reuse-stats.patch
  0017-btrfs-add-async-discard-header.patch
  0018-btrfs-increase-the-metadata-allowance-for-the-free_s.patch
  0019-btrfs-make-smaller-extents-more-likely-to-go-into-bi.patch

0001 exports percpu's bitmap iterators for eventual use in 0015. 0002
renames DISCARD to DISCARD_SYNC. 0003 and 0004 adds discard tracking to
the free space cache. 0005-0007 adds the core of async discard support.
0008-0013 fiddle with stats and operation limits. 0014 makes async
discarding only track data block groups. 0015 loads block groups on
reading in the block groups. 0016 adds reuse stats. 0017 adds an
explanation header. 0018 and 0019 modify the free space cache metadata
allowance, add a bitmap -> extent path and makes us more likely to put
smaller extents into the bitmaps.

diffstats below:

Dennis Zhou (19):
  bitmap: genericize percpu bitmap region iterators
  btrfs: rename DISCARD opt to DISCARD_SYNC
  btrfs: keep track of which extents have been discarded
  btrfs: keep track of cleanliness of the bitmap
  btrfs: add the beginning of async discard, discard workqueue
  btrfs: handle empty block_group removal
  btrfs: discard one region at a time in async discard
  btrfs: track discardable extents for asnyc discard
  btrfs: keep track of discardable_bytes
  btrfs: calculate discard delay based on number of extents
  btrfs: add bps discard rate limit
  btrfs: limit max discard size for async discard
  btrfs: have multiple discard lists
  btrfs: only keep track of data extents for async discard
  btrfs: load block_groups into discard_list on mount
  btrfs: keep track of discard reuse stats
  btrfs: add async discard header
  btrfs: increase the metadata allowance for the free_space_cache
  btrfs: make smaller extents more likely to go into bitmaps

 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/block-group.c      |  47 +++-
 fs/btrfs/block-group.h      |  18 ++
 fs/btrfs/ctree.h            |  29 ++-
 fs/btrfs/discard.c          | 458 +++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          | 112 ++++++++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |  26 +-
 fs/btrfs/free-space-cache.c | 494 ++++++++++++++++++++++++++++++------
 fs/btrfs/free-space-cache.h |  27 +-
 fs/btrfs/inode-map.c        |  13 +-
 fs/btrfs/scrub.c            |   7 +-
 fs/btrfs/super.c            |  39 ++-
 fs/btrfs/sysfs.c            | 141 ++++++++++
 include/linux/bitmap.h      |  35 +++
 mm/percpu.c                 |  61 ++---
 16 files changed, 1369 insertions(+), 155 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h

Thanks,
Dennis
