Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9611EF1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLNAWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33120 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLNAWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so2339704pfb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DYHM182C5vJLLqA3DeSgwCko6fAKDMrCle8Na+qw9NU=;
        b=rvXi5UhgQ+6JgjzVFqCDkcLeci0HwKsxKinzkV5PrZ5pj14Ca83j1HLyy+0hhWU7B9
         Pp/VHTQN1xpsH05/UJkZbdjI+zPrNfjMExsGRysQ4h5MnArc2Yksq812OhHVBZ+1cKrS
         ROSF8hmZ7IQv+1djU9o5tkca1t7qODcIv+0sDJ7XEvKWocSRJvh8c7z/VW6Hmn3X7kXz
         EVFuzLmKVpD4CN7o10j5DiZ5m/AVEd0At0qgRWhvMMxbbspFje87ihFWc0V4e/1Y+OYg
         F0DJptDGA0B7lm+CnjhE8N6u+qwQ9kHwffvIaaO387SdaE2f1N8W6UvtNfgoGA05YFNH
         yfRQ==
X-Gm-Message-State: APjAAAXNXTkKcLe04jJ7jEu5bhvFYzQ3bsx6NAJMF8hCMHH5nUHDafEP
        y7y+beXs1Y/+ri2tlWrhS7X/+bUdjvr0zQ==
X-Google-Smtp-Source: APXvYqxM5lKrtT+melC/FeIN5ipp+e2tC2uAflrVjldA8JKY0lGJLEi2uFqt01j5Tm98C76Ids8yPg==
X-Received: by 2002:a63:a43:: with SMTP id z3mr2613262pgk.232.1576282960087;
        Fri, 13 Dec 2019 16:22:40 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:39 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v6 00/22] btrfs: async discard support
Date:   Fri, 13 Dec 2019 16:22:09 -0800
Message-Id: <cover.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Dave reported a lockdep issue [1]. I'm a bit surprised as I can't repro
it, but it obviously is right. I believe I fixed the issue by moving the
fully trimmed check outside of the block_group lock.  I mistakingly
thought the btrfs_block_group lock subsumed btrfs_free_space_ctl
tree_lock. This clearly isn't the case.

Changes in v6:
 - Move the fully trimmed check outside of the block_group lock.

v5 is available here: [2].

This series is on top of btrfs-devel#misc-next 7ee98bb808e2 + [3] and
[4].

[1] https://lore.kernel.org/linux-btrfs/20191210140438.GU2734@twin.jikos.cz/
[2] https://lore.kernel.org/linux-btrfs/cover.1575919745.git.dennis@kernel.org/
[3] https://lore.kernel.org/linux-btrfs/d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org/
[4] https://lore.kernel.org/linux-btrfs/20191209193846.18162-1-dennis@kernel.org/

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
 fs/btrfs/block-group.c      |  87 ++++-
 fs/btrfs/block-group.h      |  30 ++
 fs/btrfs/ctree.h            |  52 ++-
 fs/btrfs/discard.c          | 684 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  42 +++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |   8 +-
 fs/btrfs/free-space-cache.c | 611 +++++++++++++++++++++++++++-----
 fs/btrfs/free-space-cache.h |  41 ++-
 fs/btrfs/inode-map.c        |  13 +-
 fs/btrfs/inode.c            |   2 +-
 fs/btrfs/scrub.c            |   7 +-
 fs/btrfs/super.c            |  39 +-
 fs/btrfs/sysfs.c            | 205 ++++++++++-
 fs/btrfs/volumes.c          |   7 +
 include/linux/bitmap.h      |  35 ++
 mm/percpu.c                 |  61 +---
 18 files changed, 1789 insertions(+), 152 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h

Thanks,
Dennis
