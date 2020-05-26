Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7C1C4AC4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEDX6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgEDX6a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 665A0ABAD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/7] btrfs: Introduce new incompat feature SKINNY_BG_TREE to hugely reduce mount time
Date:   Tue,  5 May 2020 07:58:18 +0800
Message-Id: <20200504235825.4199-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from:
https://github.com/adam900710/linux/tree/skinny_bg_tree
Which is based on david/misc-next branch.

This patchset will hugely reduce mount time of large fs by putting all
block group items into its own tree, and further compact the block group
item design to take full usage of btrfs_key.

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
This can be improved to RO compatible, as long as btrfs can go skip_bg
automatically (another patchset needed)

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

With patchset, and use -O skinny-bg-tree mkfs option:

 5)               |  open_ctree [btrfs]() {
 5)               |    btrfs_read_block_groups [btrfs]() {
 5) * 63395.75 us |    }
 5) @ 143106.9 us |  }

  open_ctree() time is only 15% of original mount time.
  And btrfs_read_block_groups() only takes 7% of total open_ctree()
  execution time.

The reason is pretty obvious when considering how many tree blocks needs
to be read from disk:

          |  Extent tree  |  Skinny bg tree  |
----------+---------------+-------------------
  nodes   |            55 |                1 |
  leaves  |          1025 |                7 |
  total   |          1080 |                8 |
Not to mention all the tree blocks readahead works pretty fine for bg
tree, as we will read every item.
While readahead for extent tree will just be a diaster, as all block
groups are scatter across the whole extent tree.

Changelog:
(v2~v3 are all original bg-tree design)
v2:
- Rebase to v5.4-rc1
  Minor conflicts due to code moved to block-group.c
- Fix a bug where some block groups will not be loaded at mount time
  It's a bug in that refactor patch, not exposed by previous round of
  tests.
- Add a new patch to remove a dead check
- Update benchmark to NVMe based result
  Hardware upgrade is not always a good thing for benchmark.

v3:
- Add a separate patch to fix possible memory leak
- Add Reviewed-by tag for the refactor patch
- Reword the refactor patch to mention the change of use
  btrfs_fs_incompat()

v4:
- Move to skinny bg tree design
  Since we're going to introduce an incompatible feature, it's better to
  do it to extreme.

- Refactor block group item operations into their own functions
  So that block group item operations would hide the skinny bg item and
  regular bg item operations from callers, making code much easier to
  read.

- Add tree checker patch

Qu Wenruo (7):
  btrfs: block-group: Don't set the wrong READA flag for
    btrfs_read_block_groups()
  btrfs: block-group: Refactor how we read one block group item
  btrfs: block-group: Refactor how we delete one block group item
  btrfs: block-group: Refactor how we insert a block group item
  btrfs: block-group: Rename write_one_cahce_group()
  btrfs: Introduce new incompat feature, SKINNY_BG_TREE, to hugely
    reduce mount time
  btrfs: tree-checker: Introduce checks for skinny block group item

 fs/btrfs/block-group.c          | 317 +++++++++++++++++++++++++-------
 fs/btrfs/block-rsv.c            |   2 +
 fs/btrfs/ctree.h                |   4 +-
 fs/btrfs/disk-io.c              |  18 +-
 fs/btrfs/sysfs.c                |   2 +
 fs/btrfs/tree-checker.c         |  56 +++++-
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  11 ++
 8 files changed, 335 insertions(+), 76 deletions(-)

-- 
2.26.2

