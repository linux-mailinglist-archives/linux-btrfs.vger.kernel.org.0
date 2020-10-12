Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7328C24D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgJLU0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 16:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgJLU0c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 16:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602534389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NF0wPKsPGT5xcgBZLk5MCtQgcJTyJkgfjBxpBMLzGz8=;
        b=LqIxIi8PSKt57ZwhuHYiaZDFtukSsrjttxZa5y4+pID4NIeWQcvPGx7ugFQOiMb8NM+I0J
        tp3mwLuu2ZmSF20Mo4EC2e4bBo56w9/qE+DL22uUAFz+beG842LVjPamz6MToYdL/8v93Z
        ywH+RC3aDSqb8qbo3QnDCTuBDKT2Yns=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF775AFB2;
        Mon, 12 Oct 2020 20:26:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46BEADA7C3; Mon, 12 Oct 2020 22:25:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.10
Date:   Mon, 12 Oct 2020 22:25:02 +0200
Message-Id: <cover.1602519695.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are mostly core updates with a few user visible bits and fixes.

Please pull, thanks.

Hilights:

- fsync performance improvements
  - less contention of log mutex (throughput +4%, latency -14%,
    dbench with 32 clients)
  - skip unnecessary commits for link and rename (throughput +6%,
    latency -30%, rename latency -75%, dbench with 16 clients)
  - make fast fsync wait only for writeback (throughput +10..40%,
    runtime -1..-20%, dbench with 1 to 64 clients on various file/block
    sizes)

- direct io is now implemented using the iomap infrastructure, that's
  the main part, we still have a workaround that requires an iomap API
  update, coming in 5.10

- new sysfs exports:
  - information about the exclusive filesystem operation status
    (balance, device add/remove/replace, ...)
  - supported send stream version

Core:

- use ticket space reservations for data, fair policy using the same
  infrastructure as metadata

- preparatory work to switch locking from our custom tree locks to
  standard rwsem, now the locking context is propagated to all
  callers, actual switch is expected to happen in the next dev cycle

- seed device structures are now using list API

- extent tracepoints print proper tree id

- unified range checks for extent buffer helpers

- send: avoid using temporary buffer for copying data

- remove unnecessary RCU protection from space infos

- remove unused readpage callback for metadata, enabling several
  cleanups

- replace indirect function calls for end io hooks and remove
  extent_io_ops completely

Fixes:

- more lockdep warning fixes

- fix qgroup reservation for delayed inode and an occasional
  reservation leak for preallocated files

- fix device replace of a seed device

- fix metadata reservation for fallocate that leads to transaction
  aborts

- reschedule if necessary when logging directory items or when cloning
  lots of extents

- tree-checker: fix false alert caused by legacy btrfs root item

- send: fix rename/link conflicts for orphanized inodes

- properly initialize device stats for seed devices

- skip devices without magic signature when mounting

Other:

- error handling improvements, BUG_ONs replaced by proper handling,
  fuzz fixes

- various function parameter cleanups

- various W=1 cleanups

- error/info messages improved

Mishaps:

- commit 62cf5391209a ("btrfs: move btrfs_rm_dev_replace_free_srcdev
  outside of all locks") is a rebase leftover after the patch got
  merged to 5.9-rc8 as a466c85edc6f ("btrfs: move
  btrfs_rm_dev_replace_free_srcdev outside of all locks"), the
  remaining part is trivial and the patch is in the middle of the
  series so I'm keeping it there instead of rebasing

----------------------------------------------------------------
The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-tag

for you to fetch changes up to 1fd4033dd011a3525bacddf37ab9eac425d25c4f:

  btrfs: rename BTRFS_INODE_ORDERED_DATA_CLOSE flag (2020-10-07 12:18:00 +0200)

----------------------------------------------------------------
Anand Jain (16):
      btrfs: improve device scanning messages
      btrfs: fix replace of seed device
      btrfs: add btrfs_sysfs_add_device helper
      btrfs: add btrfs_sysfs_remove_device helper
      btrfs: make btrfs_sysfs_remove_devices_dir return void
      btrfs: simplify parameters of btrfs_sysfs_add_devices_dir
      btrfs: split and refactor btrfs_sysfs_remove_devices_dir
      btrfs: initialize sysfs devid and device link for seed device
      btrfs: handle errors in btrfs_sysfs_add_fs_devices
      btrfs: reada: lock all seed/sprout devices in __reada_start_machine
      btrfs: use sprout device_list_mutex in btrfs_init_devices_late
      btrfs: remove tmp variable for list traversal in btrfs_init_dev_replace_tgtdev
      btrfs: remove unnecessary tmp variable in btrfs_assign_next_active_device()
      btrfs: simplify gotos in open_seed_device
      btrfs: move btrfs_dev_replace_update_device_in_mapping_tree to drop declaration
      btrfs: skip devices without magic signature when mounting

David Sterba (8):
      btrfs: remove const from btrfs_feature_set_name
      btrfs: compression: move declarations to header
      btrfs: remove unnecessarily shadowed variables
      btrfs: scrub: rename ratelimit state varaible to avoid shadowing
      btrfs: send: remove indirect callback parameter for changed_cb
      btrfs: send: use helpers for unaligned access to header members
      btrfs: free-space-cache: use unaligned helpers to access data
      btrfs: use unaligned helpers for stack and header set/get helpers

Denis Efremov (2):
      btrfs: use kvzalloc() to allocate clone_roots in btrfs_ioctl_send()
      btrfs: use kvcalloc for allocation in btrfs_ioctl_send()

Filipe Manana (11):
      btrfs: do not take the log_mutex of the subvolume when pinning the log
      btrfs: do not commit logs and transactions during link and rename operations
      btrfs: make fast fsyncs wait only for writeback
      btrfs: fix metadata reservation for fallocate that leads to transaction aborts
      btrfs: remove item_size member of struct btrfs_clone_extent_info
      btrfs: rename struct btrfs_clone_extent_info to a more generic name
      btrfs: rename btrfs_punch_hole_range() to a more generic name
      btrfs: rename btrfs_insert_clone_extent() to a more generic name
      btrfs: reschedule if necessary when logging directory items
      btrfs: send, orphanize first all conflicting inodes when processing references
      btrfs: send, recompute reference path after orphanization of a directory

Goldwyn Rodrigues (5):
      btrfs: switch to iomap for direct IO
      btrfs: enumerate the type of exclusive operation in progress
      btrfs: sysfs: export currently running exclusive operation
      fs: remove no longer used dio_end_io()
      btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK

Johannes Thumshirn (1):
      btrfs: reschedule when cloning lots of extents

Josef Bacik (43):
      btrfs: change nr to u64 in btrfs_start_delalloc_roots
      btrfs: remove orig from shrink_delalloc
      btrfs: handle U64_MAX for shrink_delalloc
      btrfs: make shrink_delalloc take space_info as an arg
      btrfs: make ALLOC_CHUNK use the space info flags
      btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
      btrfs: call btrfs_try_granting_tickets when unpinning anything
      btrfs: call btrfs_try_granting_tickets when reserving space
      btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
      btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
      btrfs: check tickets after waiting on ordered extents
      btrfs: add flushing states for handling data reservations
      btrfs: add the data transaction commit logic into may_commit_transaction
      btrfs: add btrfs_reserve_data_bytes and use it
      btrfs: use ticketing for data space reservations
      btrfs: serialize data reservations if we are flushing
      btrfs: use the same helper for data and metadata reservations
      btrfs: drop the commit_cycles stuff for data reservations
      btrfs: don't force commit if we are data
      btrfs: run delayed iputs before committing the transaction for data
      btrfs: flush delayed refs when trying to reserve data space
      btrfs: do async reclaim for data reservations
      btrfs: add a comment explaining the data flush steps
      btrfs: fix possible infinite loop in data async reclaim
      btrfs: dio iomap DSYNC workaround
      btrfs: move btrfs_rm_dev_replace_free_srcdev outside of all locks
      btrfs: do not hold device_list_mutex when closing devices
      btrfs: rename extent_buffer::lock_nested to extent_buffer::lock_recursed
      btrfs: introduce btrfs_path::recurse
      btrfs: add nesting tags to the locking helpers
      btrfs: introduce BTRFS_NESTING_COW for cow'ing blocks
      btrfs: introduce BTRFS_NESTING_LEFT/BTRFS_NESTING_RIGHT
      btrfs: introduce BTRFS_NESTING_LEFT/RIGHT_COW
      btrfs: introduce BTRFS_NESTING_SPLIT for split blocks
      btrfs: introduce BTRFS_NESTING_NEW_ROOT for adding new roots
      btrfs: use BTRFS_NESTED_NEW_ROOT for double splits
      btrfs: sysfs: init devices outside of the chunk_mutex
      btrfs: pretty print leaked root name
      btrfs: kill the RCU protection for fs_info->space_info
      btrfs: do not create raid sysfs entries under any locks
      btrfs: init device stats for seed devices
      btrfs: return error if we're unable to read device stats
      btrfs: cleanup cow block on error

Leon Romanovsky (1):
      btrfs: sysfs: fix unused-but-set-variable warnings

Madhuparna Bhowmik (1):
      btrfs: annotate device name rcu_string with __rcu

Marcos Paulo de Souza (1):
      btrfs: make read_block_group_item return void

Nikolay Borisov (55):
      btrfs: remove spurious BUG_ON in btrfs_get_extent
      btrfs: remove fsid argument from btrfs_sysfs_update_sprout_fsid
      btrfs: remove err variable from btrfs_get_extent
      btrfs: factor out reada loop in __reada_start_machine
      btrfs: factor out loop logic from btrfs_free_extra_devids
      btrfs: make close_fs_devices return void
      btrfs: simplify setting/clearing fs_info to btrfs_fs_devices
      btrfs: switch seed device to list api
      btrfs: document some invariants of seed code
      btrfs: remove alloc_list splice in btrfs_prepare_sprout
      btrfs: rework error detection in init_tree_roots
      btrfs: use RCU for quick device check in btrfs_init_new_device
      btrfs: refactor locked condition in btrfs_init_new_device
      btrfs: remove redundant code from btrfs_free_stale_devices
      btrfs: don't opencode sync_blockdev in btrfs_init_new_device
      btrfs: make inode_tree_del take btrfs_inode
      btrfs: make btrfs_lookup_first_ordered_extent take btrfs_inode
      btrfs: make ordered extent tracepoint take btrfs_inode
      btrfs: make btrfs_dec_test_ordered_pending take btrfs_inode
      btrfs: convert btrfs_inode_sectorsize to take btrfs_inode
      btrfs: make btrfs_invalidatepage work on btrfs_inode
      btrfs: make btrfs_writepage_endio_finish_ordered btrfs_inode-centric
      btrfs: make get_extent_skip_holes take btrfs_inode
      btrfs: make btrfs_find_ordered_sum take btrfs_inode
      btrfs: make copy_inline_to_page take btrfs_inode
      btrfs: make btrfs_zero_range_check_range_boundary take btrfs_inode
      btrfs: make extent_fiemap take btrfs_inode
      btrfs: re-arrange statements in setup_items_for_insert
      btrfs: eliminate total_size parameter from setup_items_for_insert
      btrfs: sink total_data parameter in setup_items_for_insert
      btrfs: add kerneldoc for setup_items_for_insert
      btrfs: improve error message in setup_items_for_insert
      btrfs: remove btree_readpage
      btrfs: simplify metadata pages reading
      btrfs: remove btree_get_extent
      btrfs: remove btrfs_get_extent indirection from __do_readpage
      btrfs: remove mirror_num argument from extent_read_full_page
      btrfs: promote extent_read_full_page to btrfs_readpage
      btrfs: sink mirror_num argument in extent_read_full_page
      btrfs: sink read_flags argument into extent_read_full_page
      btrfs: sink mirror_num argument in __do_readpage
      btrfs: open code extent_read_full_page to its sole caller
      btrfs: clean BTRFS_I usage in btrfs_destroy_inode
      btrfs: switch btrfs_remove_ordered_extent to btrfs_inode
      btrfs: sink inode argument in insert_ordered_extent_file_extent
      btrfs: remove inode argument from add_pending_csums
      btrfs: remove inode argument from btrfs_start_ordered_extent
      btrfs: replace readpage_end_io_hook with direct calls
      btrfs: remove extent_io_ops::readpage_end_io_hook
      btrfs: call submit_bio_hook directly in submit_one_bio
      btrfs: don't opencode is_data_inode in end_bio_extent_readpage
      btrfs: stop calling submit_bio_hook for data inodes
      btrfs: call submit_bio_hook directly for metadata pages
      btrfs: remove struct extent_io_ops
      btrfs: rename BTRFS_INODE_ORDERED_DATA_CLOSE flag

Omar Sandoval (4):
      btrfs: send: get rid of i_size logic in send_write()
      btrfs: send: avoid copying file data
      btrfs: send: use btrfs_file_extent_end() in send_write_or_clone()
      btrfs: sysfs: export supported send stream version

Qu Wenruo (11):
      btrfs: tracepoints: output proper root owner for trace_find_free_extent()
      btrfs: cleanup calculation of lockend in lock_and_cleanup_extent_if_need()
      btrfs: add owner and fs_info to alloc_state io_tree
      btrfs: qgroup: fix wrong qgroup metadata reserve for delayed inode
      btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations
      btrfs: extent_io: do extra check for extent buffer read write functions
      btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent()
      btrfs: extent-tree: kill the BUG_ON() in insert_inline_extent_backref()
      btrfs: ctree: check key order before merging tree blocks
      btrfs: use own btree inode io_tree owner id
      btrfs: tree-checker: fix false alert caused by legacy btrfs root item

Randy Dunlap (1):
      btrfs: delete duplicated words + other fixes in comments

YueHaibing (1):
      btrfs: remove unused function calc_global_rsv_need_space()

 fs/btrfs/Kconfig                     |   1 +
 fs/btrfs/backref.c                   |   1 -
 fs/btrfs/block-group.c               |  66 +--
 fs/btrfs/btrfs_inode.h               |  30 +-
 fs/btrfs/compression.c               |  35 --
 fs/btrfs/compression.h               |  35 ++
 fs/btrfs/ctree.c                     | 204 +++++++--
 fs/btrfs/ctree.h                     | 103 +++--
 fs/btrfs/delalloc-space.c            | 123 +-----
 fs/btrfs/delayed-inode.c             |   6 +-
 fs/btrfs/dev-replace.c               |  72 ++--
 fs/btrfs/disk-io.c                   | 157 +++----
 fs/btrfs/disk-io.h                   |   9 +-
 fs/btrfs/extent-io-tree.h            |   3 +-
 fs/btrfs/extent-tree.c               | 206 +++++++--
 fs/btrfs/extent_io.c                 | 216 +++++-----
 fs/btrfs/extent_io.h                 |  23 +-
 fs/btrfs/file-item.c                 |   4 +-
 fs/btrfs/file.c                      | 316 +++++++++-----
 fs/btrfs/free-space-cache.c          |  23 +-
 fs/btrfs/inode.c                     | 788 ++++++++++++++++-------------------
 fs/btrfs/ioctl.c                     |  68 +--
 fs/btrfs/locking.c                   |  45 +-
 fs/btrfs/locking.h                   |  78 ++++
 fs/btrfs/ordered-data.c              | 113 +++--
 fs/btrfs/ordered-data.h              |  24 +-
 fs/btrfs/print-tree.c                |  38 ++
 fs/btrfs/print-tree.h                |   4 +
 fs/btrfs/qgroup.c                    |   2 +-
 fs/btrfs/reada.c                     |  30 +-
 fs/btrfs/reflink.c                   |  46 +-
 fs/btrfs/relocation.c                |  11 +-
 fs/btrfs/root-tree.c                 |  13 +-
 fs/btrfs/scrub.c                     |   8 +-
 fs/btrfs/send.c                      | 365 ++++++++++------
 fs/btrfs/send.h                      |   1 -
 fs/btrfs/space-info.c                | 323 +++++++++-----
 fs/btrfs/space-info.h                |   2 +
 fs/btrfs/struct-funcs.c              |  10 -
 fs/btrfs/super.c                     |   6 +-
 fs/btrfs/sysfs.c                     | 253 +++++++----
 fs/btrfs/sysfs.h                     |  11 +-
 fs/btrfs/tests/extent-buffer-tests.c |   3 +-
 fs/btrfs/tests/inode-tests.c         |   7 +-
 fs/btrfs/transaction.c               |  15 +-
 fs/btrfs/transaction.h               |   8 +
 fs/btrfs/tree-checker.c              |  17 +-
 fs/btrfs/tree-log.c                  | 284 +++++++------
 fs/btrfs/tree-log.h                  |  32 +-
 fs/btrfs/volumes.c                   | 403 +++++++++---------
 fs/btrfs/volumes.h                   |   8 +-
 fs/direct-io.c                       |  19 -
 include/linux/fs.h                   |   2 -
 include/trace/events/btrfs.h         |  28 +-
 include/uapi/linux/btrfs_tree.h      |  14 +
 55 files changed, 2719 insertions(+), 1993 deletions(-)
