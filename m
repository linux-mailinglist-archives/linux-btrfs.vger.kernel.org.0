Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF58489FF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiAJTMW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 14:12:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33526 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiAJTMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 14:12:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6BED1F383;
        Mon, 10 Jan 2022 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641841939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fIYt9skUtJ3OWlAjnaa5zHJU/iRNXVvgKiZ/SkNoQXU=;
        b=DQk03LXgy+1kkw/K+ql3iGV+QFfKl1QFYBHi9KyiZ8YOFLm9ch99pRoSmkX0bi3WAKQ/MV
        naZUqqkKrFDTa8wg5vSWZL2GwYLUbR0lY0vDu8oARYoDK0nQ1wxiRIMksLm4ikjLx/RvtK
        L/C4y+6qq3UlYIzpfmJ9jDcFxM0sczE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AB10FA3B83;
        Mon, 10 Jan 2022 19:12:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1FDDBDA7A9; Mon, 10 Jan 2022 20:11:46 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.17
Date:   Mon, 10 Jan 2022 20:11:44 +0100
Message-Id: <cover.1641841093.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

the end of the year pull request branch is intentionally not that
exciting. Most of the changes are under the hood, but there are some
minor user visible improvements and several performance improvements
too.

Please pull, thanks.

Features:

- make send work with concurrent block group relocation, not allowed to
  prevent send failing or silently producing some bad stream but with
  more fine grained locking and checks it's possible, the send vs
  deduplication exclusion could reuse the same logic in the future

- new exclusive operation 'balance paused' to allow adding a device to
  filesystem with paused balance

- new sysfs file for fsid stored in the per-device directory to help
  distinguish devices when seeding is enabled, the fsid may differ from
  the one reported by the filesystem

Performance improvements:

- less metadata needed for directory logging, directory deletion is
  20-40% faster

- in zoned mode, cache zone information during mount to speed up
  repeated queries (about 50% speedup)

- free space tree entries get indexed and searched by size (latency
  -30%, search run time -30%)

- less contention in tree node locking when inserting a key and no
  splits are needed (files/sec in fsmark improves by 1-20%)

Fixes:

- fix ENOSPC failure when attempting direct IO write into NOCOW range

- fix deadlock between quota enable and other quota operations

- global reserve minimum calculations fixed to account for free space
  tree

- in zoned mode, fix condition for chunk allocation that may not find
  the right zone for reuse and could lead to early ENOSPC

Core:

- global reserve stealing got simplified and cleaned up in evict

- remove async transaction commit based on manual transaction refs,
  reuse existing kthread and mechanisms to let it commit transaction
  before timeout

- preparatory work for extent tree v2, add wrappers for global tree
  roots, truncation path cleanups

- remove readahead framework, it's a bit overengineered and used only
  for scrub, and yet it does not cover all its needs, there is another
  readahead built in the b-tree search that is now used, performance
  drop on HDD is about 5% which is acceptable and scrub is often
  throttled anyway, on SSDs there's no reported drop but slight
  improvement

- self tests report extent tree state when error occurs

- replace assert with debugging information when an uncommitted
  transaction is found at unmount time

Other:

- error handling improvements

- other cleanups and refactoring

----------------------------------------------------------------
The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-tag

for you to fetch changes up to 36c86a9e1be3b29f9f075a946df55dfe1d818019:

  btrfs: output more debug messages for uncommitted transaction (2022-01-07 14:18:27 +0100)

----------------------------------------------------------------
Anand Jain (3):
      btrfs: switch seeding_dev in init_new_device to bool
      btrfs: consolidate device_list_mutex in prepare_sprout to its parent
      btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device

Filipe Manana (14):
      btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range
      btrfs: fix deadlock between quota enable and other quota operations
      btrfs: only copy dir index keys when logging a directory
      btrfs: remove no longer needed logic for replaying directory deletes
      btrfs: reduce the scope of the tree log mutex during transaction commit
      btrfs: make send work with concurrent block group relocation
      btrfs: allow generic_bin_search() to take low boundary as an argument
      btrfs: try to unlock parent nodes earlier when inserting a key
      btrfs: remove useless condition check before splitting leaf
      btrfs: move leaf search logic out of btrfs_search_slot()
      btrfs: remove BUG_ON() after splitting leaf
      btrfs: remove stale comment about locking at btrfs_search_slot()
      btrfs: skip transaction commit after failure to create subvolume
      btrfs: respect the max size in the header when activating swap file

Johannes Thumshirn (4):
      btrfs: zoned: encapsulate inode locking for zoned relocation
      btrfs: zoned: simplify btrfs_check_meta_write_pointer
      btrfs: zoned: sink zone check into btrfs_repair_one_zone
      btrfs: zoned: drop redundant check for REQ_OP_ZONE_APPEND and btrfs_is_zoned

Josef Bacik (63):
      btrfs: use btrfs_item_size_nr/btrfs_item_offset_nr everywhere
      btrfs: add btrfs_set_item_*_nr() helpers
      btrfs: make btrfs_file_extent_inline_item_len take a slot
      btrfs: introduce item_nr token variant helpers
      btrfs: drop the _nr from the item helpers
      btrfs: remove the btrfs_item_end() helper
      btrfs: rename btrfs_item_end_nr to btrfs_item_data_end
      btrfs: handle priority ticket failures in their respective helpers
      btrfs: check for priority ticket granting before flushing
      btrfs: check ticket->steal in steal_from_global_block_rsv
      btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
      btrfs: remove global rsv stealing logic for orphan cleanup
      btrfs: get rid of root->orphan_cleanup_state
      btrfs: change root to fs_info for btrfs_reserve_metadata_bytes
      btrfs: only use ->max_extent_size if it is set in the bitmap
      btrfs: index free space entries on size
      btrfs: add self test for bytes_index free space cache
      btrfs: remove unused BTRFS_FS_BARRIER flag
      btrfs: rework async transaction committing
      btrfs: pass fs_info to trace_btrfs_transaction_commit
      btrfs: remove trans_handle->root
      btrfs: pass the root to add_keyed_refs
      btrfs: move comment in find_parent_nodes()
      btrfs: remove SANITY_TESTS check form find_parent_nodes
      btrfs: remove BUG_ON() in find_parent_nodes()
      btrfs: remove BUG_ON(!eie) in find_parent_nodes
      btrfs: add a btrfs_block_group_root() helper
      btrfs: make remove_extent_backref pass the root
      btrfs: use chunk_root in find_free_extent_update_loop
      btrfs: do not special case the extent root for switch commit roots
      btrfs: remove unnecessary extent root check in btrfs_defrag_leaves
      btrfs: don't use the extent root in btrfs_chunk_alloc_add_chunk_item
      btrfs: don't use extent_root in iterate_extent_inodes
      btrfs: don't use the extent_root in flush_space
      btrfs: init root block_rsv at init root time
      btrfs: stop accessing ->extent_root directly
      btrfs: fix csum assert to check objectid of the root
      btrfs: set BTRFS_FS_STATE_NO_CSUMS if we fail to load the csum root
      btrfs: stop accessing ->csum_root directly
      btrfs: stop accessing ->free_space_root directly
      btrfs: remove useless WARN_ON in record_root_in_trans
      btrfs: track the csum, extent, and free space trees in a rb tree
      btrfs: check the root node for uptodate before returning it
      btrfs: add an inode-item.h
      btrfs: move btrfs_truncate_inode_items to inode-item.c
      btrfs: move extent locking outside of btrfs_truncate_inode_items
      btrfs: remove free space cache inode check in btrfs_truncate_inode_items
      btrfs: move btrfs_kill_delayed_inode_items into evict
      btrfs: remove found_extent from btrfs_truncate_inode_items
      btrfs: add truncate control struct
      btrfs: only update i_size in truncate paths that care
      btrfs: only call inode_sub_bytes in truncate paths that care
      btrfs: control extent reference updates with a control flag for truncate
      btrfs: use a flag to control when to clear the file extent range
      btrfs: pass the ino via truncate control
      btrfs: add inode to truncate control
      btrfs: convert BUG_ON() in btrfs_truncate_inode_items to ASSERT
      btrfs: convert BUG() for pending_del_nr into an ASSERT
      btrfs: combine extra if statements in btrfs_truncate_inode_items
      btrfs: make should_throttle loop local in btrfs_truncate_inode_items
      btrfs: do not check -EAGAIN when truncating inodes in the log root
      btrfs: include the free space tree in the global rsv minimum calculation
      btrfs: reserve extra space for the free space tree

Naohiro Aota (4):
      btrfs: zoned: cache reported zone during mount
      btrfs: zoned: unset dedicated block group on allocation failure
      btrfs: add extent allocator hook to decide to allocate chunk or not
      btrfs: zoned: fix chunk allocation condition for zoned allocator

Nikolay Borisov (11):
      btrfs: remove spurious unlock/lock of unused_bgs_lock
      btrfs: get next entry in tree_search_offset before doing checks
      btrfs: eliminate if in main loop in tree_search_offset
      btrfs: consolidate bitmap_clear_bits/__bitmap_clear_bits
      btrfs: consolidate unlink_free_space/__unlink_free_space functions
      btrfs: make __btrfs_add_free_space take just block group reference
      btrfs: change name and type of private member of btrfs_free_space_ctl
      btrfs: introduce exclusive operation BALANCE_PAUSED state
      btrfs: make device add compatible with paused balance in btrfs_exclop_start_try_lock
      btrfs: allow device add if balance is paused
      btrfs: refactor unlock_up

Omar Sandoval (2):
      btrfs: send: remove unused found_type parameter to lookup_dir_item_inode()
      btrfs: send: remove unused type parameter to iterate_inode_ref_t

Qu Wenruo (11):
      btrfs: remove unnecessary @nr_written parameters
      btrfs: don't check stripe length if the profile is not stripe based
      btrfs: update SCRUB_MAX_PAGES_PER_BLOCK
      btrfs: scrub: merge SCRUB_PAGES_PER_RD_BIO and SCRUB_PAGES_PER_WR_BIO
      btrfs: scrub: remove the unnecessary path parameter for scrub_raid56_parity()
      btrfs: scrub: use btrfs_path::reada for extent tree readahead
      btrfs: remove reada infrastructure
      btrfs: scrub: cleanup the argument list of scrub_chunk()
      btrfs: scrub: cleanup the argument list of scrub_stripe()
      btrfs: selftests: dump extent io tree if extent-io-tree test failed
      btrfs: output more debug messages for uncommitted transaction

Su Yue (2):
      btrfs: remove unused parameter fs_devices from btrfs_init_workqueues
      btrfs: remove unnecessary parameter type from compression_decompress_bio

Yang Li (1):
      btrfs: fix argument list that the kdoc format and script verified

 fs/btrfs/Makefile                      |    2 +-
 fs/btrfs/backref.c                     |   77 ++-
 fs/btrfs/block-group.c                 |   35 +-
 fs/btrfs/block-rsv.c                   |   84 ++-
 fs/btrfs/block-rsv.h                   |    5 +-
 fs/btrfs/btrfs_inode.h                 |   18 +-
 fs/btrfs/compression.c                 |   11 +-
 fs/btrfs/ctree.c                       |  548 ++++++++++------
 fs/btrfs/ctree.h                       |  156 ++---
 fs/btrfs/delalloc-space.c              |    2 +-
 fs/btrfs/delayed-inode.c               |    3 +-
 fs/btrfs/delayed-ref.c                 |   25 +-
 fs/btrfs/dev-replace.c                 |   11 +-
 fs/btrfs/dir-item.c                    |   12 +-
 fs/btrfs/disk-io.c                     |  382 ++++++++---
 fs/btrfs/disk-io.h                     |   11 +
 fs/btrfs/extent-tree.c                 |  144 +++--
 fs/btrfs/extent_io.c                   |   52 +-
 fs/btrfs/file-item.c                   |   33 +-
 fs/btrfs/free-space-cache.c            |  322 ++++++----
 fs/btrfs/free-space-cache.h            |   10 +-
 fs/btrfs/free-space-tree.c             |   50 +-
 fs/btrfs/inode-item.c                  |  344 +++++++++-
 fs/btrfs/inode-item.h                  |   96 +++
 fs/btrfs/inode.c                       |  643 +++++--------------
 fs/btrfs/ioctl.c                       |   71 ++-
 fs/btrfs/print-tree.c                  |    8 +-
 fs/btrfs/props.c                       |    7 +-
 fs/btrfs/qgroup.c                      |   24 +-
 fs/btrfs/reada.c                       | 1086 --------------------------------
 fs/btrfs/ref-verify.c                  |    8 +-
 fs/btrfs/reflink.c                     |    2 +-
 fs/btrfs/relocation.c                  |   41 +-
 fs/btrfs/root-tree.c                   |    6 +-
 fs/btrfs/scrub.c                       |  230 +++----
 fs/btrfs/send.c                        |  417 +++++++++---
 fs/btrfs/space-info.c                  |   93 +--
 fs/btrfs/space-info.h                  |    2 +-
 fs/btrfs/super.c                       |    1 -
 fs/btrfs/sysfs.c                       |   11 +
 fs/btrfs/tests/btrfs-tests.c           |    1 +
 fs/btrfs/tests/extent-buffer-tests.c   |   17 +-
 fs/btrfs/tests/extent-io-tests.c       |   52 ++
 fs/btrfs/tests/free-space-tests.c      |  186 +++++-
 fs/btrfs/tests/free-space-tree-tests.c |    5 +-
 fs/btrfs/tests/qgroup-tests.c          |    5 +-
 fs/btrfs/transaction.c                 |  162 ++---
 fs/btrfs/transaction.h                 |    3 +-
 fs/btrfs/tree-checker.c                |   56 +-
 fs/btrfs/tree-defrag.c                 |    8 -
 fs/btrfs/tree-log.c                    |  619 +++++++++---------
 fs/btrfs/uuid-tree.c                   |   10 +-
 fs/btrfs/verity.c                      |    2 +-
 fs/btrfs/volumes.c                     |  121 ++--
 fs/btrfs/volumes.h                     |    9 +-
 fs/btrfs/xattr.c                       |    8 +-
 fs/btrfs/zoned.c                       |  120 +++-
 fs/btrfs/zoned.h                       |   30 +-
 include/trace/events/btrfs.h           |   10 +-
 include/uapi/linux/btrfs_tree.h        |    4 +-
 60 files changed, 3278 insertions(+), 3233 deletions(-)
 create mode 100644 fs/btrfs/inode-item.h
 delete mode 100644 fs/btrfs/reada.c
