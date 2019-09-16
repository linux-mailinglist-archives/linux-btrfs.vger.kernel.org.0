Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F4183B39C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfIPLyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 07:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfIPLyu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 07:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EC8BAE1B;
        Mon, 16 Sep 2019 11:54:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44BB1DA984; Mon, 16 Sep 2019 13:55:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.4
Date:   Mon, 16 Sep 2019 13:55:05 +0200
Message-Id: <cover.1568631647.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this update continues with work on code refactoring, sanity checks and
space handling. There are some less user visible changes, nothing that
would particularly stand out.

Please pull, thanks.


User visible changes:

- tree checker, more sanity checks of:
  - ROOT_ITEM (key, size, generation, level, alignment, flags)
  - EXTENT_ITEM and METADATA_ITEM checks (key, size, offset, alignment,
    refs)
  - tree block reference items
  - EXTENT_DATA_REF (key, hash, offset)

- deprecate flag BTRFS_SUBVOL_CREATE_ASYNC for subvolume creation ioctl,
  scheduled removal in 5.7

- delete stale and unused UAPI definitions BTRFS_DEV_REPLACE_ITEM_STATE_*

- improved export of debugging information available via existing sysfs
  directory structure

- try harder to delete relations between qgroups and allow to delete
  orphan entries

- remove unreliable space checks before relocation starts


Core:

- space handling:
  - improved ticket reservations and other high level logic in order to
    remove special cases
  - factor flushing infrastructure and use it for different contexts,
    allows to remove some special case handling
  - reduce metadata reservation when only updating inodes
  - reduce global block reserve minimum size (affects small filesystems)
  - improved overcommit logic wrt global block reserve

- tests:
  - fix memory leaks in extent IO tree
  - catch all TRIM range


Fixes:

- fix ENOSPC errors, leading to transaction aborts, when cloning extents

- several fixes for inode number cache (mount option inode_cache)

- fix potential soft lockups during send when traversing large trees

- fix unaligned access to space cache pages with SLUB debug on (PowerPC)


Other:

- refactoring public/private functions, moving to new or more appropriate
  files

- defines converted to enums

- error handling improvements

- more assertions and comments

- old code deletion

----------------------------------------------------------------
The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4

for you to fetch changes up to 6af112b11a4bc1b560f60a618ac9c1dcefe9836e:

  btrfs: Relinquish CPUs in btrfs_compare_trees (2019-09-09 14:59:20 +0200)

----------------------------------------------------------------
Anand Jain (7):
      btrfs: reset device stat using btrfs_dev_stat_set
      btrfs: opencode reset of all device stats
      btrfs: replace: BTRFS_DEV_REPLACE_ITEM_STATE_x defines should go
      btrfs: dev stats item key conversion per cpu type is not needed
      btrfs: dev stat drop useless goto
      btrfs: proper error handling when invalid device is found in find_next_devid
      btrfs: use proper error values on allocation failure in clone_fs_devices

Arnd Bergmann (1):
      btrfs: reduce stack usage for btrfsic_process_written_block

Christophe Leroy (1):
      btrfs: fix allocation of free space cache v1 bitmap pages

Dan Carpenter (1):
      btrfs: fix error pointer check in __btrfs_map_block()

David Sterba (33):
      btrfs: assert extent map tree lock in add_extent_mapping
      btrfs: assert tree mod log lock in __tree_mod_log_insert
      btrfs: remove unused btrfs_device::flush_bio_sent
      btrfs: remove unused key type set/get helpers
      btrfs: tree-log: convert defines to enums
      btrfs: async-thread: convert defines to enums
      btrfs: tree-log: use symbolic name for first replay stage
      btrfs: sysfs: add debugging exports
      btrfs: delete debugfs code
      btrfs: move sysfs declarations out of ctree.h
      btrfs: factor sysfs code out of link_block_group
      btrfs: sysfs: unexport btrfs_raid_ktype
      btrfs: factor out sysfs code for creating space infos
      btrfs: sysfs: unexport space_info_ktype
      btrfs: sysfs: replace direct access to feature set names with a helper
      btrfs: factor out sysfs code for sending device uevent
      btrfs: factor out sysfs code for deleting block group and space infos
      btrfs: factor out sysfs code for updating sprout fsid
      btrfs: cleanup kobject.h includes
      btrfs: sysfs: move type conversion helpers to sysfs.c
      btrfs: sysfs: move helper macros to sysfs.c
      btrfs: define compression levels statically
      btrfs: compression: replace set_level callbacks by a common helper
      btrfs: move cond_wake_up functions out of ctree
      btrfs: move math functions to misc.h
      btrfs: move private raid56 definitions from ctree.h
      btrfs: rename and export read_node_slot
      btrfs: move functions for tree compare to send.c
      btrfs: move struct io_ctl to free-space-cache.h
      btrfs: move dev_stats helpers to volumes.c
      btrfs: define separate btrfs_set/get_XX helpers
      btrfs: assume valid token for btrfs_set/get_token helpers
      btrfs: tie extent buffer and it's token together

Eric Sandeen (1):
      btrfs: use common vfs LABEL ioctl definitions

Filipe Manana (11):
      Btrfs: factor out extent dropping code from hole punch handler
      Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents
      Btrfs: fix hang when loading existing inode cache off disk
      Btrfs: fix inode cache block reserve leak on failure to allocate data space
      Btrfs: fix inode cache waiters hanging on failure to start caching thread
      Btrfs: fix inode cache waiters hanging on path allocation failure
      Btrfs: wake up inode cache waiters sooner to reduce waiting time
      Btrfs: remove unnecessary condition in btrfs_clone() to avoid too much nesting
      Btrfs: fix memory leaks in the test test_find_first_clear_extent_bit
      Btrfs: make test_find_first_clear_extent_bit fail on incorrect results
      Btrfs: fix use-after-free when using the tree modification log

Hans van Kranenburg (1):
      btrfs: clarify btrfs_ioctl_get_dev_stats padding

Jia-Ju Bai (1):
      btrfs: Add an assertion to warn incorrect case in insert_inline_extent()

Johannes Thumshirn (2):
      btrfs: turn checksum type define into an enum
      btrfs: create structure to encode checksum type and length

Josef Bacik (44):
      btrfs: move btrfs_add_free_space out of a header file
      btrfs: move basic block_group definitions to their own header
      btrfs: migrate the block group lookup code
      btrfs: migrate the block group ref counting stuff
      btrfs: migrate nocow and reservation helpers
      btrfs: export the block group caching helpers
      btrfs: export the excluded extents helpers
      btrfs: export the caching control helpers
      btrfs: temporarily export fragment_free_space
      btrfs: make caching_thread use btrfs_find_next_key
      btrfs: migrate the block group caching code
      btrfs: temporarily export inc_block_group_ro
      btrfs: migrate the block group removal code
      btrfs: migrate the block group read/creation code
      btrfs: temporarily export btrfs_get_restripe_target
      btrfs: migrate inc/dec_block_group_ro code
      btrfs: migrate the dirty bg writeout code
      btrfs: export block group accounting helpers
      btrfs: migrate the block group space accounting helpers
      btrfs: migrate the chunk allocation code
      btrfs: migrate the alloc_profile helpers
      btrfs: migrate the block group cleanup code
      btrfs: unexport the temporary exported functions
      btrfs: add a flush step for delayed iputs
      btrfs: unify error handling for ticket flushing
      btrfs: factor out the ticket flush handling
      btrfs: refactor priority_reclaim_metadata_space
      btrfs: introduce an evict flushing state
      btrfs: rename the btrfs_calc_*_metadata_size helpers
      btrfs: only reserve metadata_size for inodes
      btrfs: do not allow reservations if we have pending tickets
      btrfs: roll tracepoint into btrfs_space_info_update helper
      btrfs: add space reservation tracepoint for reserved bytes
      btrfs: stop partially refilling tickets when releasing space
      btrfs: refactor the ticket wakeup code
      btrfs: rework wake_all_tickets
      btrfs: fix may_commit_transaction to deal with no partial filling
      btrfs: remove orig_bytes from reserve_ticket
      btrfs: rename btrfs_space_info_add_old_bytes
      btrfs: change the minimum global reserve size
      btrfs: always reserve our entire size for the global reserve
      btrfs: use btrfs_try_granting_tickets in update_global_rsv
      btrfs: do not account global reserve in can_overcommit
      btrfs: add enospc debug messages for ticket failure

Nikolay Borisov (19):
      btrfs: Remove unused locking functions
      btrfs: Return number of compressed extents directly in compress_file_range
      btrfs: Move free_pages_out label in inline extent handling branch in compress_file_range
      btrfs: Remove delalloc_end argument from extent_clear_unlock_delalloc
      btrfs: Remove leftover of in-band dedupe
      btrfs: Remove unnecessary check from join_running_log_trans
      btrfs: Refactor btrfs_calc_avail_data_space
      btrfs: Make reada_tree_block_flagged private
      btrfs: refactor variable scope in run_delalloc_nocow
      btrfs: improve comments around nocow path
      btrfs: simplify extent type checks in run_delalloc_nocow
      btrfs: streamline code in run_delalloc_nocow in case of inline extents
      btrfs: comment and minor simplifications in run_delalloc_nocow
      btrfs: improve error handling in run_delalloc_nocow
      btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
      btrfs: Make btrfs_find_name_in_backref return btrfs_inode_ref struct
      btrfs: Make btrfs_find_name_in_ext_backref return struct btrfs_inode_extref
      btrfs: Don't assign retval of btrfs_try_tree_write_lock/btrfs_tree_read_lock_atomic
      btrfs: Relinquish CPUs in btrfs_compare_trees

Omar Sandoval (3):
      btrfs: use correct count in btrfs_file_write_iter()
      btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
      btrfs: stop clearing EXTENT_DIRTY in inode I/O tree

Qu Wenruo (12):
      btrfs: volumes: Unexport find_free_dev_extent_start()
      btrfs: volumes: Add comment for find_free_dev_extent_start()
      btrfs: extent-tree: Add comment for inc_block_group_ro()
      btrfs: volumes: Remove ENOSPC-prone btrfs_can_relocate()
      btrfs: delayed-inode: Kill the BUG_ON() in btrfs_delete_delayed_dir_index()
      btrfs: extent-tree: Make sure we only allocate extents from block groups with the same type
      btrfs: tree-checker: Add ROOT_ITEM check
      btrfs: qgroup: Try our best to delete qgroup relations
      btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check
      btrfs: tree-checker: Add simple keyed refs check
      btrfs: tree-checker: Add EXTENT_DATA_REF check
      btrfs: Detect unbalanced tree with empty leaf before crashing btree operations

YueHaibing (1):
      btrfs: remove set but not used variable 'offset'

 fs/btrfs/Makefile                      |     2 +-
 fs/btrfs/async-thread.c                |     8 +-
 fs/btrfs/block-group.c                 |  3173 ++++++++
 fs/btrfs/block-group.h                 |   250 +
 fs/btrfs/block-rsv.c                   |    48 +-
 fs/btrfs/check-integrity.c             |     7 +-
 fs/btrfs/compression.c                 |    21 +-
 fs/btrfs/compression.h                 |    11 +-
 fs/btrfs/ctree.c                       |   452 +-
 fs/btrfs/ctree.h                       |   417 +-
 fs/btrfs/dedupe.h                      |    12 -
 fs/btrfs/delalloc-space.c              |    34 +-
 fs/btrfs/delayed-inode.c               |    18 +-
 fs/btrfs/delayed-ref.c                 |    10 +-
 fs/btrfs/dev-replace.c                 |     3 +-
 fs/btrfs/disk-io.c                     |    40 +-
 fs/btrfs/disk-io.h                     |     2 -
 fs/btrfs/extent-tree.c                 | 12422 +++++++++++--------------------
 fs/btrfs/extent_io.c                   |    12 +-
 fs/btrfs/extent_io.h                   |     6 +-
 fs/btrfs/extent_map.c                  |     2 +
 fs/btrfs/file.c                        |   435 +-
 fs/btrfs/free-space-cache.c            |    42 +-
 fs/btrfs/free-space-cache.h            |    24 +-
 fs/btrfs/free-space-tree.c             |     1 +
 fs/btrfs/free-space-tree.h             |     2 +
 fs/btrfs/inode-item.c                  |    62 +-
 fs/btrfs/inode-map.c                   |    32 +-
 fs/btrfs/inode.c                       |   397 +-
 fs/btrfs/ioctl.c                       |   430 +-
 fs/btrfs/locking.c                     |    37 +-
 fs/btrfs/locking.h                     |     2 -
 fs/btrfs/lzo.c                         |     8 +-
 fs/btrfs/math.h                        |    28 -
 fs/btrfs/misc.h                        |    50 +
 fs/btrfs/ordered-data.c                |     1 +
 fs/btrfs/props.c                       |     2 +-
 fs/btrfs/qgroup.c                      |    48 +-
 fs/btrfs/raid56.c                      |    16 +
 fs/btrfs/reada.c                       |    30 +
 fs/btrfs/relocation.c                  |     3 +-
 fs/btrfs/root-tree.c                   |     2 +-
 fs/btrfs/scrub.c                       |     1 +
 fs/btrfs/send.c                        |   375 +
 fs/btrfs/space-info.c                  |   372 +-
 fs/btrfs/space-info.h                  |    30 +-
 fs/btrfs/struct-funcs.c                |    73 +-
 fs/btrfs/super.c                       |    32 +-
 fs/btrfs/sysfs.c                       |   270 +-
 fs/btrfs/sysfs.h                       |    82 +-
 fs/btrfs/tests/btrfs-tests.c           |     1 +
 fs/btrfs/tests/extent-io-tests.c       |    31 +-
 fs/btrfs/tests/free-space-tests.c      |     1 +
 fs/btrfs/tests/free-space-tree-tests.c |     1 +
 fs/btrfs/tests/inode-tests.c           |    24 +-
 fs/btrfs/transaction.c                 |     6 +-
 fs/btrfs/tree-checker.c                |   432 ++
 fs/btrfs/tree-log.c                    |    55 +-
 fs/btrfs/volumes.c                     |   102 +-
 fs/btrfs/volumes.h                     |     9 -
 fs/btrfs/zlib.c                        |    11 +-
 fs/btrfs/zstd.c                        |    12 +-
 include/trace/events/btrfs.h           |     3 +-
 include/uapi/linux/btrfs.h             |    13 +-
 include/uapi/linux/btrfs_tree.h        |     9 +-
 65 files changed, 10557 insertions(+), 9990 deletions(-)
 create mode 100644 fs/btrfs/block-group.c
 create mode 100644 fs/btrfs/block-group.h
 delete mode 100644 fs/btrfs/dedupe.h
 delete mode 100644 fs/btrfs/math.h
 create mode 100644 fs/btrfs/misc.h
