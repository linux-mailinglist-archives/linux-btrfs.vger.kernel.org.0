Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074BF2D9AB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 16:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407990AbgLNPSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 10:18:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:42328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbgLNPSQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 10:18:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607959052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IjuEVXs+m5cmEPKGKU9KP93+gGn4KZ5zKAN1pJa7Rec=;
        b=VHbkYUOOEACrIDIGQ4I1Wt6+BtGRUIeEhMpW1y/zh1zF8dkYvrLJ1zpdQ00tw/nkkkpXZ2
        isUur2H3Nvn+Sl8aB6ibOG7KhO2ozwDT4V+A8LRIsNHiBmSwgAEwT6yRhmBXLbVEqaaL2J
        1IJGQSK1zCpYp0PDJU5nKcZru7c+nmU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D9B8AC7F;
        Mon, 14 Dec 2020 15:17:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05BC7DA7C3; Mon, 14 Dec 2020 16:15:53 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.11
Date:   Mon, 14 Dec 2020 16:15:53 +0100
Message-Id: <cover.1607955523.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

we have a mix of all kinds of changes, feature updates, core stuff,
performance improvements and lots of cleanups and preparatory changes.

There are no merge conflicts against current master branch, in past
weeks some conflicts emerged in linux-next but IIRC were trivial.
Please pull, thanks.

User visible:

- export filesystem generation in sysfs

- new features for mount option 'rescue'
  - what's currently supported is exported in sysfs
  - ignorebadroots/ibadroots - continue even if some essential tree
    roots are not usable (extent, uuid, data reloc, device, csum, free
    space)
  - ignoredatacsums/idatacsums - skip checksum verification on data
  - all - now enables ignorebadroots + ignoredatacsums + nologreplay

- export read mirror policy settings to sysfs, new policies will be
  added in the future

- remove inode number cache feature (mount -o inode_cache), obsoleted
  in 5.9

User visible fixes:

- async discard scheduling fixes on high loads

- update inode byte counter atomically so stat() does not report wrong
  value in some cases

- free space tree fixes
  - correctly report status of v2 after remount
  - clear v1 cache inodes when v2 is newly enabled after remount

Core:

- switch own tree lock implementation to standard rw semaphore
  - one-level lock nesting is not required anymore, the last use of this
    was in free space that's now loaded asynchronously
  - own implementation of adaptive spinning before taking mutex has been
    part of rwsem
  - performance seems to be better in general, much better (+tens of
    percents) for some workloads
  - lockdep does not complain

- finish direct IO conversion to iomap infrastructure, remove temporary
  workaround for DSYNC after iomap API updates

- preparatory work to support data and metadata blocks smaller than page
  - generalize code that assumes sectorsize == PAGE_SIZE, lots of
    refactoring
  - planned namely for 64K pages (eg. arm64, ppc64)
  - scrub read-only support

- preparatory work for zoned allocation mode (SMR/ZBC/ZNS friendly)
  - disable incompatible features
  - round-robin superblock write

- free space cache (v1) is loaded asynchronously, remove tree path
  recursion

- slightly improved time tacking for transaction kthread wake ups

Performance improvements (note that the numbers depend on load type or
other features and weren't run on the same machine):

- skip unnecessary work:
  - do not start readahead for csum tree when scrubbing non-data block
    groups
  - do not start and wait for delalloc on snapshot roots on transaction
    commit
  - fix race when defragmenting leads to unnecessary IO

- dbench speedups (+throughput%/-max latency%)
  - skip unnecessary searches for xattrs when logging an inode
    (+10.8/-8.2)
  - stop incrementing log batch when joining log transaction (1-2)
  - unlock path before checking if extent is shared during nocow
    writeback (+5.0/-20.5), on fio load +9.7% throughput/-9.8% runtime
  - several tree log improvements, eg. removing unnecessary operations,
    fixing races that lead to additional work (+12.7/-8.2)

- tree-checker error branches annotated with unlikely() (+3% throughput)

Other:

- cleanups

- lockdep fixes

- more btrfs_inode conversions

- error variable cleanups

----------------------------------------------------------------
The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-tag

for you to fetch changes up to b42fe98c92698d2a10094997e5f4d2dd968fd44f:

  btrfs: scrub: allow scrub to work with subpage sectorsize (2020-12-09 19:16:11 +0100)

----------------------------------------------------------------
Anand Jain (7):
      btrfs: sysfs: export filesystem generation
      btrfs: add helper for string match ignoring leading/trailing whitespace
      btrfs: create read policy framework
      btrfs: sysfs: add per-fs attribute for read policy
      btrfs: drop unused argument step from btrfs_free_extra_devids
      btrfs: drop never met disk total bytes check in verify_one_dev_extent
      btrfs: remove unused argument seed from btrfs_find_device

Boris Burkov (12):
      btrfs: lift read-write mount setup from mount and remount
      btrfs: start orphan cleanup on ro->rw remount
      btrfs: only mark bg->needs_free_space if free space tree is on
      btrfs: create free space tree on ro->rw remount
      btrfs: clear oneshot options on mount and remount
      btrfs: clear free space tree on ro->rw remount
      btrfs: keep sb cache_generation consistent with space_cache
      btrfs: use superblock state to print space_cache mount option
      btrfs: warn when remount will not change the free space tree
      btrfs: remove free space items when disabling space cache v1
      btrfs: skip space_cache v1 setup when not using it
      btrfs: fix lockdep warning when creating free space tree

David Sterba (22):
      btrfs: use the right number of levels for lockdep keysets
      btrfs: generate lockdep keyset names at compile time
      btrfs: send: use helpers to access root_item::ctransid
      btrfs: check-integrity: use proper helper to access btrfs_header
      btrfs: use root_item helpers for limit and flags in btrfs_create_tree
      btrfs: add set/get accessors for root_item::drop_level
      btrfs: remove unnecessary casts in printk
      btrfs: use precalculated sectorsize_bits from fs_info
      btrfs: replace div_u64 by shift in free_space_bitmap_size
      btrfs: replace s_blocksize_bits with fs_info::sectorsize_bits
      btrfs: store precalculated csum_size in fs_info
      btrfs: precalculate checksums per leaf once
      btrfs: use cached value of fs_info::csum_size everywhere
      btrfs: switch cached fs_info::csum_size from u16 to u32
      btrfs: remove unnecessary local variables for checksum size
      btrfs: check integrity: remove local copy of csum_size
      btrfs: scrub: remove local copy of csum_size from context
      btrfs: reorder extent buffer members for better packing
      btrfs: remove stub device info from messages when we have no fs_info
      btrfs: tree-checker: annotate all error branches as unlikely
      btrfs: drop casts of bio bi_sector
      btrfs: remove recalc_thresholds from free space ops

Filipe Manana (16):
      btrfs: assert we are holding the reada_lock when releasing a readahead zone
      btrfs: do not start readahead for csum tree when scrubbing non-data block groups
      btrfs: do not start and wait for delalloc on snapshot roots on transaction commit
      btrfs: refactor btrfs_drop_extents() to make it easier to extend
      btrfs: fix race when defragmenting leads to unnecessary IO
      btrfs: update the number of bytes used by an inode atomically
      btrfs: skip unnecessary searches for xattrs when logging an inode
      btrfs: stop incrementing log batch when joining log transaction
      btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
      btrfs: unlock path before checking if extent is shared during nocow writeback
      btrfs: fix race causing unnecessary inode logging during link and rename
      btrfs: fix race that results in logging old extents during a fast fsync
      btrfs: fix race that causes unnecessary logging of ancestor inodes
      btrfs: fix race that makes inode logging fallback to transaction commit
      btrfs: fix race leading to unnecessary transaction commit when logging inode
      btrfs: do not block inode logging for so long during transaction commit

Goldwyn Rodrigues (14):
      btrfs: calculate num_pages, reserve_bytes once in btrfs_buffered_write
      btrfs: use iosize while reading compressed pages
      btrfs: use round_down while calculating start position in btrfs_dirty_pages()
      btrfs: set EXTENT_NORESERVE bits side btrfs_dirty_pages()
      btrfs: split btrfs_direct_IO to read and write
      btrfs: move pos increment and pagecache extension to btrfs_buffered_write
      btrfs: check FS error state bit early during write
      btrfs: introduce btrfs_write_check()
      btrfs: introduce btrfs_inode_lock()/unlock()
      btrfs: push inode locking and unlocking into buffered/direct write
      btrfs: use shared lock for direct writes within EOF
      btrfs: remove btrfs_inode::dio_sem
      btrfs: call iomap_dio_complete() without inode_lock
      btrfs: remove dio iomap DSYNC workaround

Josef Bacik (41):
      btrfs: unify the ro checking for mount options
      btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
      btrfs: sysfs: export supported rescue= mount options
      btrfs: add a helper to print out rescue= options
      btrfs: show rescue=usebackuproot in /proc/mounts
      btrfs: introduce mount option rescue=ignorebadroots
      btrfs: introduce mount option rescue=ignoredatacsums
      btrfs: introduce mount option rescue=all
      btrfs: switch extent buffer tree lock to rw_semaphore
      btrfs: locking: remove all the blocking helpers
      btrfs: locking: rip out path->leave_spinning
      btrfs: do not shorten unpin len for caching block groups
      btrfs: update last_byte_to_unpin in switch_commit_roots
      btrfs: explicitly protect ->last_byte_to_unpin in unpin_extent_range
      btrfs: cleanup btrfs_discard_update_discardable usage
      btrfs: load free space cache into a temporary ctl
      btrfs: load the free space cache inode extents from commit root
      btrfs: load free space cache asynchronously
      btrfs: protect fs_info->caching_block_groups by block_group_cache_lock
      btrfs: remove lockdep classes for the fs tree
      btrfs: cleanup extent buffer readahead
      btrfs: use btrfs_read_node_slot in btrfs_realloc_node
      btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
      btrfs: use btrfs_read_node_slot in do_relocation
      btrfs: use btrfs_read_node_slot in replace_path
      btrfs: use btrfs_read_node_slot in walk_down_tree
      btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
      btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
      btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
      btrfs: pass root owner to read_tree_block
      btrfs: pass the root owner and level around for readahead
      btrfs: pass the owner_root and level to alloc_extent_buffer
      btrfs: set the lockdep class for extent buffers on creation
      btrfs: cleanup the locking in btrfs_next_old_leaf
      btrfs: unlock to current level in btrfs_next_old_leaf
      btrfs: remove btrfs_path::recurse
      btrfs: locking: remove the recursion handling code
      btrfs: merge back btrfs_read_lock_root_node helpers
      btrfs: use btrfs_tree_read_lock in btrfs_search_slot
      btrfs: remove the recurse parameter from __btrfs_tree_read_lock
      btrfs: remove extent_buffer::recursed

Naohiro Aota (9):
      btrfs: introduce ZONED feature flag
      btrfs: get zone information of zoned block devices
      btrfs: check and enable ZONED mode
      btrfs: introduce max_zone_append_size
      btrfs: disallow space_cache in ZONED mode
      btrfs: disallow NODATACOW in ZONED mode
      btrfs: disable fallocate in ZONED mode
      btrfs: disallow mixed-bg in ZONED mode
      btrfs: implement log-structured superblock for ZONED mode

Nikolay Borisov (31):
      btrfs: use helpers to convert from seconds to jiffies in transaction_kthread
      btrfs: remove redundant time check in transaction kthread loop
      btrfs: record delta directly in transaction_kthread
      btrfs: calculate more accurate remaining time to sleep in transaction_kthread
      btrfs: open code insert_orphan_item
      btrfs: make btrfs_inode_safe_disk_i_size_write take btrfs_inode
      btrfs: make insert_prealloc_file_extent take btrfs_inode
      btrfs: make btrfs_truncate_inode_items take btrfs_inode
      btrfs: make btrfs_finish_ordered_io btrfs_inode-centric
      btrfs: make btrfs_delayed_update_inode take btrfs_inode
      btrfs: make btrfs_update_inode_item take btrfs_inode
      btrfs: make btrfs_update_inode take btrfs_inode
      btrfs: make maybe_insert_hole take btrfs_inode
      btrfs: make find_first_non_hole take btrfs_inode
      btrfs: make btrfs_insert_replace_extent take btrfs_inode
      btrfs: make btrfs_truncate_block take btrfs_inode
      btrfs: make btrfs_cont_expand take btrfs_inode
      btrfs: make btrfs_update_inode_fallback take btrfs_inode
      btrfs: merge __set_extent_bit and set_extent_bit
      btrfs: remove useless return value statement in split_node
      btrfs: simplify return values in setup_nodes_for_search
      btrfs: remove err variable from btrfs_delete_subvolume
      btrfs: eliminate err variable from merge_reloc_root
      btrfs: remove err variable from do_relocation
      btrfs: return bool from should_end_transaction
      btrfs: return bool from btrfs_should_end_transaction
      btrfs: move btrfs_find_highest_objectid/btrfs_find_free_objectid to disk-io.c
      btrfs: replace calls to btrfs_find_free_ino with btrfs_find_free_objectid
      btrfs: remove inode number cache feature
      btrfs: remove crc_check logic from free space
      btrfs: always set NODATASUM/NODATACOW in __create_free_space_inode

Pavel Begunkov (4):
      btrfs: discard: speed up async discard up to iops_limit
      btrfs: discard: store async discard delay as ns not as jiffies
      btrfs: don't miss async discards after scheduled work override
      btrfs: discard: reschedule work after sysfs param update

Qu Wenruo (41):
      btrfs: fix the comment on lock_extent_buffer_for_io
      btrfs: update the comment for find_first_extent_bit
      btrfs: sink the failed_start parameter to set_extent_bit
      btrfs: replace fs_info and private_data with inode in btrfs_wq_submit_bio
      btrfs: sink parameter start and len to check_data_csum
      btrfs: rename pages_locked in process_pages_contig()
      btrfs: only require sector size alignment for page read
      btrfs: rename page_size to io_size in submit_extent_page
      btrfs: assert page mapping lock in attach_extent_buffer_page
      btrfs: make buffer_radix take sector size units
      btrfs: grab fs_info from extent_buffer in btrfs_mark_buffer_dirty
      btrfs: make csum_tree_block() handle node smaller than page
      btrfs: extract extent buffer verification from btrfs_validate_metadata_buffer()
      btrfs: pass bvec to csum_dirty_buffer instead of page
      btrfs: scrub: distinguish scrub page from regular page
      btrfs: scrub: remove the force parameter from scrub_pages
      btrfs: scrub: refactor scrub_find_csum()
      btrfs: tests: remove invalid extent-io test
      btrfs: add structure to keep track of extent range in end_bio_extent_readpage
      btrfs: introduce helper to handle page status update in end_bio_extent_readpage()
      btrfs: use fixed width int type for extent_state::state
      btrfs: scrub: remove the anonymous structure from scrub_page
      btrfs: remove unused parameter phy_offset from btrfs_validate_metadata_buffer
      btrfs: only clear EXTENT_LOCK bit in extent_invalidatepage
      btrfs: use nodesize to determine if we need readahead in btrfs_lookup_bio_sums
      btrfs: use detach_page_private() in alloc_extent_buffer()
      btrfs: rename bio_offset of extent_submit_bio_start_t to dio_file_offset
      btrfs: pass bio_offset to check_data_csum() directly
      btrfs: make btrfs_verify_data_csum follow sector size
      btrfs: factor out btree page submission code to a helper
      btrfs: calculate inline extent buffer page size based on page size
      btrfs: don't allow tree block to cross page boundary for subpage support
      btrfs: update num_extent_pages to support subpage sized extent buffer
      btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
      btrfs: remove btrfs_find_ordered_sum call from btrfs_lookup_bio_sums
      btrfs: refactor btrfs_lookup_bio_sums to handle out-of-order bvecs
      btrfs: scrub: reduce width of extent_len/stripe_len from 64 to 32 bits
      btrfs: scrub: always allocate one full page for one sector for RAID56
      btrfs: scrub: support subpage tree block scrub
      btrfs: scrub: support subpage data scrub
      btrfs: scrub: allow scrub to work with subpage sectorsize

Tom Rix (1):
      btrfs: sysfs: remove unneeded semicolon

 fs/btrfs/Makefile                 |   3 +-
 fs/btrfs/backref.c                |  19 +-
 fs/btrfs/block-group.c            | 268 ++++++-------
 fs/btrfs/block-group.h            |   2 +
 fs/btrfs/block-rsv.c              |   8 +
 fs/btrfs/btrfs_inode.h            |  23 +-
 fs/btrfs/check-integrity.c        |  11 +-
 fs/btrfs/compression.c            |  28 +-
 fs/btrfs/ctree.c                  | 258 +++---------
 fs/btrfs/ctree.h                  | 213 +++++++---
 fs/btrfs/delayed-inode.c          |  23 +-
 fs/btrfs/delayed-inode.h          |   3 +-
 fs/btrfs/dev-replace.c            |  20 +-
 fs/btrfs/dir-item.c               |   1 -
 fs/btrfs/discard.c                |  46 ++-
 fs/btrfs/discard.h                |   3 +-
 fs/btrfs/disk-io.c                | 689 ++++++++++++++++++--------------
 fs/btrfs/disk-io.h                |  25 +-
 fs/btrfs/export.c                 |   1 -
 fs/btrfs/extent-io-tree.h         |  71 ++--
 fs/btrfs/extent-tree.c            | 111 ++----
 fs/btrfs/extent_io.c              | 656 ++++++++++++++++++------------
 fs/btrfs/extent_io.h              |  50 +--
 fs/btrfs/file-item.c              | 344 ++++++++++------
 fs/btrfs/file.c                   | 737 ++++++++++++++++++----------------
 fs/btrfs/free-space-cache.c       | 558 +++++++++++---------------
 fs/btrfs/free-space-cache.h       |  22 +-
 fs/btrfs/free-space-tree.c        |  26 +-
 fs/btrfs/inode-item.c             |   6 -
 fs/btrfs/inode-map.c              | 582 ---------------------------
 fs/btrfs/inode-map.h              |  16 -
 fs/btrfs/inode.c                  | 815 ++++++++++++++++++++------------------
 fs/btrfs/ioctl.c                  |  64 ++-
 fs/btrfs/locking.c                | 459 ++-------------------
 fs/btrfs/locking.h                |  24 +-
 fs/btrfs/ordered-data.c           |  45 ---
 fs/btrfs/ordered-data.h           |   5 +-
 fs/btrfs/print-tree.c             |  15 +-
 fs/btrfs/qgroup.c                 |  52 +--
 fs/btrfs/raid56.c                 |   8 +-
 fs/btrfs/reada.c                  |  34 +-
 fs/btrfs/ref-verify.c             |  27 +-
 fs/btrfs/reflink.c                |  18 +-
 fs/btrfs/relocation.c             | 116 ++----
 fs/btrfs/scrub.c                  | 340 +++++++++-------
 fs/btrfs/send.c                   |   6 +-
 fs/btrfs/struct-funcs.c           |  18 +-
 fs/btrfs/super.c                  | 179 ++++++---
 fs/btrfs/sysfs.c                  | 117 +++++-
 fs/btrfs/tests/btrfs-tests.c      |   3 +-
 fs/btrfs/tests/extent-io-tests.c  |  26 +-
 fs/btrfs/tests/free-space-tests.c |   1 -
 fs/btrfs/tests/qgroup-tests.c     |   4 -
 fs/btrfs/transaction.c            | 126 +++---
 fs/btrfs/transaction.h            |   3 +-
 fs/btrfs/tree-checker.c           | 337 ++++++++--------
 fs/btrfs/tree-defrag.c            |   1 -
 fs/btrfs/tree-log.c               | 183 +++++----
 fs/btrfs/uuid-tree.c              |   3 +-
 fs/btrfs/volumes.c                | 143 ++++---
 fs/btrfs/volumes.h                |  21 +-
 fs/btrfs/xattr.c                  |   8 +-
 fs/btrfs/zoned.c                  | 616 ++++++++++++++++++++++++++++
 fs/btrfs/zoned.h                  | 160 ++++++++
 include/uapi/linux/btrfs.h        |   1 +
 include/uapi/linux/btrfs_tree.h   |   3 +-
 66 files changed, 4491 insertions(+), 4313 deletions(-)
 delete mode 100644 fs/btrfs/inode-map.c
 delete mode 100644 fs/btrfs/inode-map.h
 create mode 100644 fs/btrfs/zoned.c
 create mode 100644 fs/btrfs/zoned.h
