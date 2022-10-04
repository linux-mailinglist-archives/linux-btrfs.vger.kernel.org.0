Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600685F3CCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 08:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJDGhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJDGhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 02:37:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853992A956;
        Mon,  3 Oct 2022 23:37:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9FA041F8E6;
        Tue,  4 Oct 2022 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664865419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=E8xiuqV6Tyuvv60MzfW6Ex/VO/wBpUYc0P5cN7QRsjw=;
        b=IaoGWXm2/bomAIRwBROz+ptV3sPTRxWHSP9557aMVd7qXIX1hTu0zEyX19IukdcUxbd2MX
        lClwV2ySIzx6MQGicT8makADat05MbmuRtBIRGF6k7onPfiAW5fGqxddVe/wOoG7tKP1xW
        uoLFPV8n6lCN33oCZfHvLDtJ31kLvf0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 916432C143;
        Tue,  4 Oct 2022 06:36:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 277DBDA85B; Tue,  4 Oct 2022 08:31:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.1
Date:   Tue,  4 Oct 2022 08:31:21 +0200
Message-Id: <cover.1664798047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following updates for btrfs. There's a bunch of
performance improvements, most notably the FIEMAP speedup, the new block
group tree to speed up mount on large filesystems, more io_uring
integration, some sysfs exports and the usual fixes and core updates.

Thanks.

---

Performance:

- outstanding FIEMAP speed improvement
  - algorithmic change how extents are enumerated leads to orders of
    magnitude speed boost (uncached and cached)
  - extent sharing check speedup (2.2x uncached, 3x cached)
  - add more cancellation points, allowing to interrupt seeking in files
    with large number of extents
  - more efficient hole and data seeking (4x uncached, 1.3x cached)
  - sample results:
    256M, 32K extents:   4s ->  29ms  (~150x)
    512M, 64K extents:  30s ->  59ms  (~550x)
    1G,  128K extents: 225s -> 120ms (~1800x)

- improved inode logging, especially for directories (on dbench workload
  throughput +25%, max latency -21%)

- improved buffered IO, remove redundant extent state tracking, lowering
  memory consumption and avoiding rb tree traversal

- add sysfs tunable to let qgroup temporarily skip exact accounting when
  deleting snapshot, leading to a speedup but requiring a rescan after
  that, will be used by snapper

- support io_uring and buffered writes, until now it was just for direct
  IO, with the no-wait semantics implemented in the buffered write path
  it now works and leads to speed improvement in IOPS (2x), throughput
  (2.2x), latency (depends, 2x to 150x)

- small performance improvements when dropping and searching for extent
  maps as well as when flushing delalloc in COW mode (throughput +5MB/s)

User visible changes:

- new incompatible feature block-group-tree adding a dedicated tree for
  tracking block groups, this allows a much faster load during mount and
  avoids seeking unlike when it's scattered in the extent tree items
  - this reduces mount time for many-terabyte sized filesystems
  - conversion tool will be provided so existing filesystem can also be
    updated in place
  - to reduce test matrix and feature combinations requires no-holes
    and free-space-tree (mkfs defaults since 5.15)

- improved reporting of super block corruption detected by scrub

- scrub also tries to repair super block and does not wait until next
  commit

- discard stats and tunables are exported in sysfs
  (/sys/fs/btrfs/FSID/discard)

- qgroup status is exported in sysfs (/sys/sys/fs/btrfs/FSID/qgroups/)

- verify that super block was not modified when thawing filesystem

Fixes:

- FIEMAP fixes
  - fix extent sharing status, does not depend on the cached status where
    merged
  - flush delalloc so compressed extents are reported correctly

- fix alignment of VMA for memory mapped files on THP

- send: fix failures when processing inodes with no links (orphan files
  and directories)

- fix race between quota enable and quota rescan ioctl

- handle more corner cases for read-only compat feature verification

- fix missed extent on fsync after dropping extent maps

Core:

- lockdep annotations to validate various transactions states and state
  transitions

- preliminary support for fs-verity in send

- more effective memory use in scrub for subpage where sector is smaller
  than page

- block group caching progress logic has been removed, load is now
  synchronous

- simplify end IO callbacks and bio handling, use chained bios instead
  of own tracking

- add no-wait semantics to several functions (tree search, nocow,
  flushing, buffered write

- cleanups and refactoring

MM changes:

- export balance_dirty_pages_ratelimited_flags

----------------------------------------------------------------
The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-tag

for you to fetch changes up to cbddcc4fa3443fe8cfb2ff8e210deb1f6a0eea38:

  btrfs: set generation before calling btrfs_clean_tree_block in btrfs_init_new_buffer (2022-09-29 17:08:31 +0200)

----------------------------------------------------------------
Alexander Zhu (1):
      btrfs: fix alignment of VMA for memory mapped files on THP

BingJing Chang (2):
      btrfs: send: refactor arguments of get_inode_info()
      btrfs: send: fix failures when processing inodes with no links

Boris Burkov (1):
      btrfs: send: add support for fs-verity

Christoph Hellwig (13):
      btrfs: don't create integrity bioset for btrfs_bioset
      btrfs: move btrfs_bio allocation to volumes.c
      btrfs: pass the operation to btrfs_bio_alloc
      btrfs: don't take a bio_counter reference for cloned bios
      btrfs: use chained bios when cloning
      btrfs: properly abstract the parity raid bio handling
      btrfs: give struct btrfs_bio a real end_io handler
      btrfs: factor out low-level bio setup from submit_stripe_bio
      btrfs: decide bio cloning inside submit_stripe_bio
      btrfs: add fast path for single device io in __btrfs_map_block
      btrfs: stop allocation a btrfs_io_context for simple I/O
      btrfs: zoned: refactor device checks in btrfs_check_zoned_mode
      btrfs: stop tracking failed reads in the I/O tree

Christophe JAILLET (1):
      btrfs: qgroup: fix a typo in a comment

David Sterba (3):
      btrfs: sysfs: use sysfs_streq for string matching
      btrfs: sysfs: show discard stats and tunables in non-debug build
      btrfs: add KCSAN annotations for unlocked access to block_rsv->full

Ethan Lien (1):
      btrfs: remove unnecessary EXTENT_UPTODATE state in buffered I/O path

Filipe Manana (42):
      btrfs: don't drop dir index range items when logging a directory
      btrfs: remove the root argument from log_new_dir_dentries()
      btrfs: update stale comment for log_new_dir_dentries()
      btrfs: free list element sooner at log_new_dir_dentries()
      btrfs: avoid memory allocation at log_new_dir_dentries() for common case
      btrfs: remove root argument from btrfs_delayed_item_reserve_metadata()
      btrfs: store index number instead of key in struct btrfs_delayed_item
      btrfs: remove unused logic when looking up delayed items
      btrfs: shrink the size of struct btrfs_delayed_item
      btrfs: search for last logged dir index if it's not cached in the inode
      btrfs: move need_log_inode() to above log_conflicting_inodes()
      btrfs: move log_new_dir_dentries() above btrfs_log_inode()
      btrfs: log conflicting inodes without holding log mutex of the initial inode
      btrfs: skip logging parent dir when conflicting inode is not a dir
      btrfs: use delayed items when logging a directory
      btrfs: simplify adding and replacing references during log replay
      btrfs: simplify error handling at btrfs_del_root_ref()
      btrfs: fix race between quota enable and quota rescan ioctl
      btrfs: allow hole and data seeking to be interruptible
      btrfs: make hole and data seeking a lot more efficient
      btrfs: remove check for impossible block start for an extent map at fiemap
      btrfs: remove zero length check when entering fiemap
      btrfs: properly flush delalloc when entering fiemap
      btrfs: allow fiemap to be interruptible
      btrfs: rename btrfs_check_shared() to a more descriptive name
      btrfs: speedup checking for extent sharedness during fiemap
      btrfs: skip unnecessary extent buffer sharedness checks during fiemap
      btrfs: make fiemap more efficient and accurate reporting extent sharedness
      btrfs: remove useless used space increment during space reservation
      btrfs: fix missed extent on fsync after dropping extent maps
      btrfs: move btrfs_drop_extent_cache() to extent_map.c
      btrfs: use extent_map_end() at btrfs_drop_extent_map_range()
      btrfs: use cond_resched_rwlock_write() during inode eviction
      btrfs: move open coded extent map tree deletion out of inode eviction
      btrfs: add helper to replace extent map range with a new extent map
      btrfs: remove the refcount warning/check at free_extent_map()
      btrfs: remove unnecessary extent map initializations
      btrfs: assert tree is locked when clearing extent map from logging
      btrfs: remove unnecessary NULL pointer checks when searching extent maps
      btrfs: remove unnecessary next extent map search
      btrfs: avoid pointless extent map tree search when flushing delalloc
      btrfs: drop extent map range more efficiently

Gaosheng Cui (1):
      btrfs: remove btrfs_bit_radix_cachep declaration

Ioannis Angelakopoulos (7):
      btrfs: add macros for annotating wait events with lockdep
      btrfs: add lockdep annotations for num_writers wait event
      btrfs: add lockdep annotations for num_extwriters wait event
      btrfs: add lockdep annotations for transaction states wait events
      btrfs: add lockdep annotations for pending_ordered wait event
      btrfs: change the lockdep class of free space inode's invalidate_lock
      btrfs: add lockdep annotations for the ordered extents wait event

Jeff Layton (1):
      btrfs: remove stale prototype of btrfs_write_inode

Josef Bacik (65):
      btrfs: use btrfs_fs_closing for background bg work
      btrfs: simplify arguments of btrfs_update_space_info and rename
      btrfs: handle space_info setting of bg in btrfs_add_bg_to_space_info
      btrfs: convert block group bit field to use bit helpers
      btrfs: remove lock protection for BLOCK_GROUP_FLAG_TO_COPY
      btrfs: simplify block group traversal in btrfs_put_block_group_cache
      btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
      btrfs: remove lock protection for BLOCK_GROUP_FLAG_RELOCATING_REPAIR
      btrfs: delete btrfs_wait_space_cache_v1_finished
      btrfs: call __btrfs_remove_free_space_cache_locked on cache load failure
      btrfs: remove use btrfs_remove_free_space_cache instead of variant
      btrfs: rename clean_io_failure and remove extraneous args
      btrfs: unexport internal failrec functions
      btrfs: convert the io_failure_tree to a plain rb_tree
      btrfs: use find_first_extent_bit in btrfs_clean_io_failure
      btrfs: separate out the extent state and extent buffer init code
      btrfs: separate out the eb and extent state leak helpers
      btrfs: temporarily export alloc_extent_state helpers
      btrfs: move extent state init and alloc functions to their own file
      btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's
      btrfs: move simple extent bit helpers out of extent_io.c
      btrfs: export wait_extent_bit
      btrfs: move btrfs_debug_check_extent_io_range into extent-io-tree.c
      btrfs: temporarily export and move core extent_io_tree tree functions
      btrfs: temporarily export and then move extent state helpers
      btrfs: move a few exported extent_io_tree helpers to extent-io-tree.c
      btrfs: move core extent_io_tree functions to extent-io-tree.c
      btrfs: unexport btrfs_debug_check_extent_io_range
      btrfs: unexport all the temporary exports for extent-io-tree.c
      btrfs: remove struct tree_entry in extent-io-tree.c
      btrfs: use next_state instead of rb_next where we can
      btrfs: make tree_search return struct extent_state
      btrfs: make tree_search_for_insert return extent_state
      btrfs: make tree_search_prev_next return extent_state's
      btrfs: use next_state/prev_state in merge_state
      btrfs: move extent io tree unrelated prototypes to their appropriate header
      btrfs: drop exclusive_bits from set_extent_bit
      btrfs: remove the wake argument from clear_extent_bits
      btrfs: remove failed_start argument from set_extent_bit
      btrfs: drop extent_changeset from set_extent_bit
      btrfs: unify the lock/unlock extent variants
      btrfs: remove extent_io_tree::track_uptodate
      btrfs: get rid of extent_io_tree::dirty_bytes
      btrfs: don't clear CTL bits when trying to release extent state
      btrfs: replace delete argument with EXTENT_CLEAR_ALL_BITS
      btrfs: don't init io tree with private data for non-inodes
      btrfs: remove is_data_inode() checks in extent-io-tree.c
      btrfs: move btrfs_caching_type to block-group.h
      btrfs: move btrfs_full_stripe_locks_tree into block-group.h
      btrfs: move btrfs_init_async_reclaim_work prototype to space-info.h
      btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
      btrfs: move btrfs_swapfile_pin into volumes.h
      btrfs: move fs_info forward declarations to the top of ctree.h
      btrfs: move btrfs_csum_ptr to inode.c
      btrfs: move the fs_info related helpers closer to fs_info in ctree.h
      btrfs: move btrfs_ordered_sum_size into file-item.c
      btrfs: open code and remove btrfs_inode_sectorsize helper
      btrfs: open code and remove btrfs_insert_inode_hash helper
      btrfs: use a runtime flag to indicate an inode is a free space inode
      btrfs: add struct declarations in dev-replace.h
      btrfs: implement a nowait option for tree searches
      btrfs: make can_nocow_extent nowait compatible
      btrfs: add the ability to use NO_FLUSH for data reservations
      btrfs: add btrfs_try_lock_ordered_range
      btrfs: make btrfs_check_nocow_lock nowait compatible

Maciej S. Szmigiero (1):
      btrfs: don't print information about space cache or tree every remount

Omar Sandoval (2):
      btrfs: rename btrfs_insert_file_extent() to btrfs_insert_hole_extent()
      btrfs: get rid of block group caching progress logic

Qu Wenruo (26):
      btrfs: dump extra info if one free space cache has more bitmaps than it should
      btrfs: scrub: properly report super block errors in system log
      btrfs: scrub: try to fix super block errors
      btrfs: scrub: remove impossible sanity checks
      btrfs: scrub: use pointer array to replace sblocks_for_recheck
      btrfs: scrub: factor out initialization of scrub_block into helper
      btrfs: scrub: factor out allocation and initialization of scrub_sector into helper
      btrfs: scrub: introduce scrub_block::pages for more efficient memory usage for subpage
      btrfs: scrub: remove scrub_sector::page and use scrub_block::pages instead
      btrfs: scrub: move logical/physical/dev/mirror_num from scrub_sector to scrub_block
      btrfs: scrub: use larger block size for data extent scrub
      btrfs: check superblock to ensure the fs was not modified at thaw time
      btrfs: output human readable space info flag
      btrfs: dump all space infos if we abort transaction due to ENOSPC
      btrfs: enhance unsupported compat RO flags handling
      btrfs: don't save block group root into super block
      btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2
      btrfs: sysfs: introduce global qgroup attribute group
      btrfs: introduce BTRFS_QGROUP_STATUS_FLAGS_MASK for later expansion
      btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
      btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting
      btrfs: skip subtree scan if it's too high to avoid low stall in btrfs_commit_transaction()
      btrfs: update the comment for submit_extent_page()
      btrfs: switch page and disk_bytenr argument position for submit_extent_page()
      btrfs: move end_io_func argument to btrfs_bio_ctrl structure
      btrfs: relax block-group-tree feature dependency checks

Stefan Roesch (7):
      mm: export balance_dirty_pages_ratelimited_flags()
      btrfs: make prepare_pages nowait compatible
      btrfs: make lock_and_cleanup_extent_if_need nowait compatible
      btrfs: plumb NOWAIT through the write path
      btrfs: make btrfs_buffered_write nowait compatible
      btrfs: assert nowait mode is not used for some btree search functions
      btrfs: enable nowait async buffered writes

Tetsuo Handa (1):
      btrfs: set generation before calling btrfs_clean_tree_block in btrfs_init_new_buffer

Uros Bizjak (1):
      btrfs: use atomic_try_cmpxchg in free_extent_buffer

zhang songyi (1):
      btrfs: remove the unnecessary result variables

 fs/btrfs/Makefile                 |    2 +-
 fs/btrfs/backref.c                |  155 +-
 fs/btrfs/backref.h                |   20 +-
 fs/btrfs/block-group.c            |  182 +--
 fs/btrfs/block-group.h            |   39 +-
 fs/btrfs/block-rsv.c              |    3 +-
 fs/btrfs/block-rsv.h              |    9 +
 fs/btrfs/btrfs_inode.h            |   25 +-
 fs/btrfs/compression.c            |   54 +-
 fs/btrfs/ctree.c                  |   43 +-
 fs/btrfs/ctree.h                  |  370 ++---
 fs/btrfs/delalloc-space.c         |   13 +-
 fs/btrfs/delalloc-space.h         |    3 +-
 fs/btrfs/delayed-inode.c          |  292 ++--
 fs/btrfs/delayed-inode.h          |   34 +-
 fs/btrfs/dev-replace.c            |   16 +-
 fs/btrfs/dev-replace.h            |    4 +
 fs/btrfs/disk-io.c                |  303 ++--
 fs/btrfs/disk-io.h                |    7 +-
 fs/btrfs/extent-io-tree.c         | 1673 +++++++++++++++++++++
 fs/btrfs/extent-io-tree.h         |  126 +-
 fs/btrfs/extent-tree.c            |   33 +-
 fs/btrfs/extent_io.c              | 2923 +++++++++----------------------------
 fs/btrfs/extent_io.h              |   17 +-
 fs/btrfs/extent_map.c             |  347 ++++-
 fs/btrfs/extent_map.h             |    8 +
 fs/btrfs/file-item.c              |   38 +-
 fs/btrfs/file.c                   |  805 ++++++----
 fs/btrfs/free-space-cache.c       |  115 +-
 fs/btrfs/free-space-cache.h       |    1 -
 fs/btrfs/free-space-tree.c        |    8 -
 fs/btrfs/inode.c                  |  516 +++----
 fs/btrfs/ioctl.c                  |   24 +-
 fs/btrfs/locking.c                |   25 +
 fs/btrfs/locking.h                |    1 +
 fs/btrfs/misc.h                   |   35 +
 fs/btrfs/ordered-data.c           |   50 +-
 fs/btrfs/ordered-data.h           |   13 +-
 fs/btrfs/props.c                  |    5 +-
 fs/btrfs/qgroup.c                 |   96 +-
 fs/btrfs/qgroup.h                 |    3 +
 fs/btrfs/raid56.c                 |   45 +-
 fs/btrfs/raid56.h                 |    4 +-
 fs/btrfs/reflink.c                |   10 +-
 fs/btrfs/relocation.c             |   40 +-
 fs/btrfs/root-tree.c              |   16 +-
 fs/btrfs/scrub.c                  |  668 +++++----
 fs/btrfs/send.c                   |  461 +++---
 fs/btrfs/send.h                   |   15 +-
 fs/btrfs/space-info.c             |   96 +-
 fs/btrfs/space-info.h             |    9 +-
 fs/btrfs/super.c                  |  112 +-
 fs/btrfs/sysfs.c                  |  172 ++-
 fs/btrfs/tests/btrfs-tests.c      |    2 +-
 fs/btrfs/tests/extent-io-tests.c  |    7 +-
 fs/btrfs/tests/free-space-tests.c |   22 +-
 fs/btrfs/tests/inode-tests.c      |   10 +-
 fs/btrfs/transaction.c            |  162 +-
 fs/btrfs/tree-log.c               | 1593 ++++++++++++--------
 fs/btrfs/tree-log.h               |    8 +
 fs/btrfs/verity.c                 |    3 +-
 fs/btrfs/volumes.c                |  353 +++--
 fs/btrfs/volumes.h                |   50 +-
 fs/btrfs/zoned.c                  |  142 +-
 fs/verity/fsverity_private.h      |    2 -
 include/linux/fsverity.h          |    3 +
 include/trace/events/btrfs.h      |    2 -
 include/uapi/linux/btrfs.h        |    6 +
 include/uapi/linux/btrfs_tree.h   |    4 +
 mm/page-writeback.c               |    1 +
 70 files changed, 7212 insertions(+), 5242 deletions(-)
 create mode 100644 fs/btrfs/extent-io-tree.c
