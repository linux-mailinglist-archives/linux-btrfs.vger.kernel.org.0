Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB5CF1ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfJHEtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfJHEtQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E49F2AE35
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to hugely reduce mount time
Date:   Tue,  8 Oct 2019 12:49:06 +0800
Message-Id: <20191008044909.157750-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from:
https://github.com/adam900710/linux/tree/bg_tree
Which is based on v5.4-rc1 tag.

This patchset will hugely reduce mount time of large fs by putting all
block group items into its own tree.

The old behavior will try to read out all block group items at mount
time, however due to the key of block group items are scattered across
tons of extent items, we must call btrfs_search_slot() for each block
group.

It works fine for small fs, but when number of block groups goes beyond
200, such tree search will become a random read, causing obvious slow
down.

On the other hand, btrfs_read_chunk_tree() is still very fast, since we
put CHUNK_ITEMS into their own tree and package them next to each other.

Following this idea, we could do the same thing for block group items,
so instead of triggering btrfs_search_slot() for each block group, we
just call btrfs_next_item() and under most case we could finish in
memory, and hugely speed up mount (see BENCHMARK below).

The only disadvantage is, this method introduce an incompatible feature,
so existing fs can't use this feature directly.
Either specify it at mkfs time, or use btrfs-progs offline convert tool.

[[Benchmark]]
Since I have upgraded my rig to all NVME storage, there is no HDD
test result.

Physical device:	NVMe SSD
VM device:		VirtIO block device, backup by sparse file
Nodesize:		4K  (to bump up tree height)
Extent data size:	4M
Fs size used:		1T

All file extents on disk is in 4M size, preallocated to reduce space usage
(as the VM uses loopback block device backed by sparse file)

Without patchset:
Use ftrace function graph:

 7)               |  open_ctree [btrfs]() {
 7)               |    btrfs_read_block_groups [btrfs]() {
 7) @ 805851.8 us |    }
 7) @ 911890.2 us |  }

 btrfs_read_block_groups() takes 88% of the total mount time,

With patchset, and use -O bg-tree mkfs option:

 6)               |  open_ctree [btrfs]() {
 6)               |    btrfs_read_block_groups [btrfs]() {
 6) * 91204.69 us |    }
 6) @ 192039.5 us |  }

  open_ctree() time is only 21% of original mount time.
  And btrfs_read_block_groups() only takes 47% of total open_ctree()
  execution time.

The reason is pretty obvious when considering how many tree blocks needs
to be read from disk:
- Original extent tree:
  nodes:	55
  leaves:	1025
  total:	1080
- Block group tree:
  nodes:	1
  leaves:	13
  total:	14

Not to mention all the tree blocks readahead works pretty fine for bg
tree, as we will read every item.
While readahead for extent tree will just be a diaster, as all block
groups are scatter across the whole extent tree.

Changelog:
v2:
- Rebase to v5.4-rc1
  Minor conflicts due to code moved to block-group.c
- Fix a bug where some block groups will not be loaded at mount time
  It's a bug in that refactor patch, not exposed by previous round of
  tests.
- Add a new patch to remove a dead check
- Update benchmark to NVMe based result
  Hardware upgrade is not always a good thing for benchmark.

Qu Wenruo (3):
  btrfs: block-group: Refactor btrfs_read_block_groups()
  btrfs: disk-io: Remove unnecessary check before freeing chunk root
  btrfs: Introduce new incompat feature, BG_TREE, to speed up mount time

 fs/btrfs/block-group.c          | 306 ++++++++++++++++++++------------
 fs/btrfs/ctree.h                |   5 +-
 fs/btrfs/disk-io.c              |  16 +-
 fs/btrfs/sysfs.c                |   2 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |   3 +
 6 files changed, 213 insertions(+), 120 deletions(-)

-- 
2.23.0

