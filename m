Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03E29481C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440510AbgJUG0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:42414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbgJUG0B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I+uOWQuzjUZurRDFzVjcKzf1NWVeKZ+oKYHYpHI+Q74=;
        b=H5ydqD5Cug1LYwDTrZNyrIkwbD9DEq91LBhngUQLPRw2nJk4mUOua4vFhnNebnaqe4GPnT
        ZckVnbtkcHTUVaC7LNa/xYWlhXHx8gQ1SCfew2Dp2mn8FQk8Rlu4a9ZVN4IO8SXR0eIk1B
        Zb9d5bhsT8Uz3hM0WKHjS0azNEfzVp0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E9BEAC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:25:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 00/68] btrfs: add basic rw support for subpage sector size
Date:   Wed, 21 Oct 2020 14:24:46 +0800
Message-Id: <20201021062554.68132-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches can be fetched from github:
https://github.com/adam900710/linux/tree/subpage_data_fullpage_write

=== Overview ===
To make 64K page size systems to mount 4K sector size btrfs and to
regular read-write.

=== What works ===
- Subpage data read
  Both uncompressed and compressed data

- Subpage metadata read/write
  So far single thread "fsstress" loops hasn't crash the system with all
  debug options enabled.
  (Currently running with "-n 2048" in a 1024 run loop).

  This also means, we can do subpage sized pure metadata operations like
  reflink. (e.g. we can result 4K sector using reflink without problem)

- Full page data write
  Only tested uncompressed data yet.
  This means all data write will happen in page size, including:
  * buffered write
  * dio write
  * hole punch for unaligned range
  This means even just one 4K sector is dirtied, we will writeback the
  full 64K page as an data extent.

=== What doesn't works ===
- Balance
- Scrub
  All failed with csum check failure, may be quick to solve, but the
  current development status and patchset size is enough for a milestone.

- Dev replace
  Unable to submit subpage data writes.


=== Challenges and solutions ===
- Metadata
  * One 64K page can contain several tree blocks
    Instead of full page read/write/lock, we use extent io tree to do
    sector aligned read/write/lock, and avoid full page lock if
    possible.

  * Metadata can cross 64K page boundary
    This only happens for certain converted fs. Consider how little used
    just reject them for now and fix convert.

  Overall, metadata is not that complex as metadata has very limited
  interfaces.

- Data
  * Data has more page status and uses ordered extents
  * Data subpage write can be handled by iomap
    Instead of using extent io tree for each page status, goes full page
    write back.
    So that I won't waste time to implement something which is designed
    to be replaced.

- Testing
  * No way to test under 86_64
    Currently I'm using an RK3399 board with NVME driver, planning to
    move to a Xavier AGX board.
    But we plan to add 2K sector size support as a pure testing sector
    size for x86_64 (but still 4K as minimal node size) to test subpage
    routines and make my life a little easier.

=== TODO ===
- More testing 
  Obviously

- Balance and scrub support
- Limited data subpage write
  Mostly for balance and replace, as a workaround.

- Iomap support for true subpage data writeback

=== Patchset structure ===
Patch 01~03:	Small bug fixes
Patch 04~22:	Generic cleanup and refactors, which make sense without
		subpage support
Patch 23~27:	Subpage specific cleanup and refactors.
Patch 28~42:	Enablement for subpage RO mount
Patch 43~52:	Enablement for subpage metadata write
Patch 53~68:	Enablement for subpage data write (although still in
		page size)

=== Changelog ===
v2:
- Migrating to extent_io_tree based status/locking mechanism
  This gets rid of the ad-hoc subpage_eb_mapping structure and extra
  timing to verify the extent buffers.

  This also brings some extra cleanups for btree inode extent io tree
  hooks which makes no sense for both subpage and regular sector size.

  This also completely removes the requirement for page status like
  Locked/Uptodate/Dirty. Now metadata pages only utilize Private status,
  while private pointer is always NULL.

- Submit proper subpage sized read for metadata
  With the help of extent io tree, we no longer need to bother full page
  read. Now submit subpage sized metadata read and do subpage locking.

- Remove some unnecessary refactors
  Some refactors like extracting detach_extent_buffer_pages() doesn't
  really make the code cleaner. We can easily add subpage specific
  branch.

- Address the comments from v1

v3:
- Add compressed data read fix

- Also update page status according to extent status for btree inode
  This makes us to reuse more code from the existing code base.

- Add metadata write support
  Only manually tested (with a fs created under x86_64, and script to do
  metadata only operations under aarch64 with 64K page size).

- More cleanup/refactors during metadata write support development.

v4:
- Add more refactors
  The mostly obvious one is the refactor of __set/__clear_extent_bit()
  to make the less common options less visible, and allow me to add more
  options more easily.

- Add full data page write support

- More bug fixes for existing patches
  Mostly the bug found during fsstress tests.

- Reduce page locking to minimal for metadata
  I hit a possible ABBA lock, where extent io tree locking and page
  locking leads to dead lock.
  To resolve it without adding more requirement for page locking
  sequence, subpage metadata only rely on extent io tree locking.
  Page locking is only reserved for unavoidable cases, like calling
  clear_page_dirty_for_io().

Goldwyn Rodrigues (1):
  btrfs: use iosize while reading compressed pages

Qu Wenruo (67):
  btrfs: extent-io-tests: remove invalid tests
  btrfs: extent_io: fix the comment on lock_extent_buffer_for_io().
  btrfs: extent_io: update the comment for find_first_extent_bit()
  btrfs: extent_io: sink the @failed_start parameter for
    set_extent_bit()
  btrfs: make btree inode io_tree has its special owner
  btrfs: disk-io: replace @fs_info and @private_data with @inode for
    btrfs_wq_submit_bio()
  btrfs: inode: sink parameter @start and @len for check_data_csum()
  btrfs: extent_io: unexport extent_invalidatepage()
  btrfs: extent_io: remove the forward declaration and rename
    __process_pages_contig
  btrfs: extent_io: rename pages_locked in process_pages_contig()
  btrfs: extent_io: only require sector size alignment for page read
  btrfs: extent_io: remove the extent_start/extent_len for
    end_bio_extent_readpage()
  btrfs: extent_io: integrate page status update into
    endio_readpage_release_extent()
  btrfs: extent_io: rename page_size to io_size in submit_extent_page()
  btrfs: extent_io: add assert_spin_locked() for
    attach_extent_buffer_page()
  btrfs: extent_io: extract the btree page submission code into its own
    helper function
  btrfs: extent_io: calculate inline extent buffer page size based on
    page size
  btrfs: extent_io: make btrfs_fs_info::buffer_radix to take sector size
    devided values
  btrfs: extent_io: sink less common parameters for __set_extent_bit()
  btrfs: extent_io: sink less common parameters for __clear_extent_bit()
  btrfs: disk_io: grab fs_info from extent_buffer::fs_info directly for
    btrfs_mark_buffer_dirty()
  btrfs: disk-io: make csum_tree_block() handle sectorsize smaller than
    page size
  btrfs: disk-io: extract the extent buffer verification from
    btree_readpage_end_io_hook()
  btrfs: disk-io: accept bvec directly for csum_dirty_buffer()
  btrfs: inode: make btrfs_readpage_end_io_hook() follow sector size
  btrfs: introduce a helper to determine if the sectorsize is smaller
    than PAGE_SIZE
  btrfs: extent_io: allow find_first_extent_bit() to find a range with
    exact bits match
  btrfs: extent_io: don't allow tree block to cross page boundary for
    subpage support
  btrfs: extent_io: update num_extent_pages() to support subpage sized
    extent buffer
  btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
  btrfs: disk-io: only clear EXTENT_LOCK bit for extent_invalidatepage()
  btrfs: extent-io: make type of extent_state::state to be at least 32
    bits
  btrfs: extent_io: use extent_io_tree to handle subpage extent buffer
    allocation
  btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support
    subpage size
  btrfs: extent_io: make the assert test on page uptodate able to handle
    subpage
  btrfs: extent_io: implement subpage metadata read and its endio
    function
  btrfs: extent_io: implement try_release_extent_buffer() for subpage
    metadata support
  btrfs: extent_io: extra the core of test_range_bit() into
    test_range_bit_nolock()
  btrfs: extent_io: introduce EXTENT_READ_SUBMITTED to handle subpage
    data read
  btrfs: set btree inode track_uptodate for subpage support
  btrfs: allow RO mount of 4K sector size fs on 64K page system
  btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check
    on subpage metadata
  btrfs: disk-io: support subpage metadata csum calculation at write
    time
  btrfs: extent_io: prevent extent_state from being merged for btree io
    tree
  btrfs: extent_io: make set_extent_buffer_dirty() to support subpage
    sized metadata
  btrfs: extent_io: add subpage support for clear_extent_buffer_dirty()
  btrfs: extent_io: make set_btree_ioerr() accept extent buffer
  btrfs: extent_io: introduce write_one_subpage_eb() function
  btrfs: extent_io: make lock_extent_buffer_for_io() subpage compatible
  btrfs: extent_io: introduce submit_btree_subpage() to submit a page
    for subpage metadata write
  btrfs: extent_io: introduce end_bio_subpage_eb_writepage() function
  btrfs: inode: make can_nocow_extent() check only return 1 if the range
    is no smaller than PAGE_SIZE
  btrfs: file: calculate reserve space based on PAGE_SIZE for buffered
    write
  btrfs: file: make hole punching page aligned for subpage
  btrfs: file: make btrfs_dirty_pages() follow page size to mark extent
    io tree
  btrfs: file: make btrfs_file_write_iter() to be page aligned
  btrfs: output extra info for space info update underflow
  btrfs: delalloc-space: make data space reservation to be page aligned
  btrfs: scrub: allow scrub to work with subpage sectorsize
  btrfs: inode: make btrfs_truncate_block() to do page alignment
  btrfs: file: make hole punch and zero range to be page aligned
  btrfs: file: make btrfs_fallocate() to use PAGE_SIZE as blocksize
  btrfs: inode: always mark the full page range delalloc for
    btrfs_page_mkwrite()
  btrfs: inode: require page alignement for direct io
  btrfs: inode: only do NOCOW write for page aligned extent
  btrfs: reflink: do full page writeback for reflink prepare
  btrfs: support subpage read write for test

 fs/btrfs/block-group.c           |    2 +-
 fs/btrfs/btrfs_inode.h           |   12 +
 fs/btrfs/ctree.c                 |    5 +-
 fs/btrfs/ctree.h                 |   43 +-
 fs/btrfs/delalloc-space.c        |   19 +-
 fs/btrfs/disk-io.c               |  425 ++++++--
 fs/btrfs/disk-io.h               |    8 +-
 fs/btrfs/extent-io-tree.h        |  145 ++-
 fs/btrfs/extent-tree.c           |    2 +-
 fs/btrfs/extent_io.c             | 1576 ++++++++++++++++++++++--------
 fs/btrfs/extent_io.h             |   27 +-
 fs/btrfs/extent_map.c            |    2 +-
 fs/btrfs/file.c                  |  140 ++-
 fs/btrfs/free-space-cache.c      |    2 +-
 fs/btrfs/inode.c                 |  117 ++-
 fs/btrfs/reflink.c               |   36 +-
 fs/btrfs/relocation.c            |    2 +-
 fs/btrfs/scrub.c                 |    8 -
 fs/btrfs/space-info.h            |    4 +-
 fs/btrfs/struct-funcs.c          |   18 +-
 fs/btrfs/tests/extent-io-tests.c |   26 +-
 fs/btrfs/transaction.c           |    4 +-
 fs/btrfs/volumes.c               |    2 +-
 include/trace/events/btrfs.h     |    1 +
 24 files changed, 1927 insertions(+), 699 deletions(-)

-- 
2.28.0

