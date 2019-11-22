Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279191075B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfKVQXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 11:23:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:50040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfKVQXx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 11:23:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33B80ACB7;
        Fri, 22 Nov 2019 16:23:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F4AADA898; Fri, 22 Nov 2019 17:23:50 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.5
Date:   Fri, 22 Nov 2019 17:23:44 +0100
Message-Id: <cover.1574439340.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are some new features, followed by cleanups. Please pull, thanks.

User visible changes:

- new block group profiles: RAID1 with 3- and 4- copies
  - RAID1 in btrfs has always 2 copies, now add support for 3 and 4
  - this is an incompat feature (named RAID1C34)
  - recommended use of RAID1C3 is replacement of RAID6 profile on metadata,
    this brings a more reliable resiliency against 2 device loss/damage

- support for new checksums
  - per-filesystem, set at mkfs time
  - fast hash (crc32c successor): xxhash, 64bit digest
  - strong hashes (both 256bit): sha256 (slower, FIPS), blake2b (faster)
  - the blake2b module goes via the crypto tree, btrfs.ko has a soft
    dependency

- speed up lseek, don't take inode locks unnecessarily, this can speed up
  parallel SEEK_CUR/SEEK_SET/SEEK_END by 80%

- send:
  - allow clone operations within the same file
  - limit maximum number of sent clone references to avoid slow backref walking

- error message improvements: device scan prints process name and PID

Core changes:

- cleanups
  - remove unique workqueue helpers, used to provide a way to avoid deadlocks
    in the workqueue code, now done in a simpler way
  - remove lots of indirect function calls in compression code
  - extent IO tree code moved out of extent_io.c
  - cleanup backup superblock handling at mount time
  - transaction life cycle documentation and cleanups
  - locking code cleanups, annotations and documentation
  - add more cold, const, pure function attributes
  - removal of unused or redundant struct members or variables

- new tree-checker sanity tests
  - try to detect missing INODE_ITEM, cross-reference checks of DIR_ITEM,
    DIR_INDEX, INODE_REF, and XATTR_* items

- remove own bio scheduling code (used to avoid checksum submissions being
  stuck behind other IO), replaced by cgroup controller-based code to allow
  better control and avoid priority inversions in cases where the custom and
  cgroup scheduling disagreed

Fixes:

- avoid getting stuck during cyclic writebacks

- fix trimming of ranges crossing block group boundaries

- fix rename exchange on subvolumes, all involved subvolumes need to be
  recorded in the transaction

----------------------------------------------------------------
The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-tag

for you to fetch changes up to fa17ed069c61286b26382e23b57a62930657b9c1:

  btrfs: drop bdev argument from submit_extent_page (2019-11-18 23:43:58 +0100)

----------------------------------------------------------------
Anand Jain (3):
      btrfs: balance: use term redundancy instead of integrity in message
      btrfs: print process name and pid that calls device scanning
      btrfs: use bool argument in free_root_pointers()

Chengguang Xu (3):
      btrfs: props: remove unnecessary hash_init()
      btrfs: use enum for extent type defines
      btrfs: use better definition of number of compression type

Chris Mason (5):
      Btrfs: stop using btrfs_schedule_bio()
      Btrfs: delete the entire async bio submission framework
      Btrfs: only associate the locked page with one async_chunk struct
      Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios
      Btrfs: extent_write_locked_range() should attach inode->i_wb

Dan Carpenter (1):
      btrfs: clean up locking name in scrub_enumerate_chunks()

David Sterba (54):
      btrfs: make locking assertion helpers static inline
      btrfs: make btrfs_assert_tree_locked static inline
      btrfs: move btrfs_set_path_blocking to other locking functions
      btrfs: move btrfs_unlock_up_safe to other locking functions
      btrfs: add 64bit safe helper for power of two checks
      btrfs: use has_single_bit_set for clarity
      btrfs: drop unused parameter is_new from btrfs_iget
      btrfs: add __cold attribute to more functions
      btrfs: add const function attribute
      btrfs: add __pure attribute to functions
      btrfs: opencode extent_buffer_get
      btrfs: export compression and decompression callbacks
      btrfs: switch compression callbacks to direct calls
      btrfs: compression: attach workspace manager to the ops
      btrfs: compression: let workspace manager init take only the type
      btrfs: compression: inline init_workspace_manager
      btrfs: compression: let workspace manager cleanup take only the type
      btrfs: compression: inline cleanup_workspace_manager
      btrfs: compression: export alloc/free/get/put callbacks of all algos
      btrfs: compression: inline get_workspace
      btrfs: compression: inline put_workspace
      btrfs: compression: pass type to btrfs_get_workspace
      btrfs: compression: inline alloc_workspace
      btrfs: compression: pass type to btrfs_put_workspace
      btrfs: compression: inline free_workspace
      btrfs: compression: remove ops pointer from workspace_manager
      btrfs: tracepoints: drop typecasts from printk
      btrfs: tracepoints: constify all pointers
      btrfs: assert extent_map bdevs and lookup_map and split
      btrfs: get bdev from latest_dev for dio bh_result
      btrfs: sysfs: export supported checksums
      btrfs: add member for a specific checksum driver
      btrfs: add blake2b to checksumming algorithms
      btrfs: move block_group_item::used to block group
      btrfs: move block_group_item::flags to block group
      btrfs: remove embedded block_group_cache::item
      btrfs: rename block_group_item on-stack accessors to follow naming
      btrfs: rename extent buffer block group item accessors
      btrfs: add dedicated members for start and length of a block group
      btrfs: sink write_flags to __extent_writepage_io
      btrfs: sink write flags to cow_file_range_async
      btrfs: add support for 3-copy replication (raid1c3)
      btrfs: add support for 4-copy replication (raid1c4)
      btrfs: add incompat for raid1 with 3, 4 copies
      btrfs: drop incompat bit for raid1c34 after last block group is gone
      btrfs: merge blocking_writers branches in btrfs_tree_read_lock
      btrfs: set blocking_writers directly, no increment or decrement
      btrfs: access eb::blocking_writers according to ACCESS_ONCE policies
      btrfs: document extent buffer locking
      btrfs: rename btrfs_block_group_cache
      btrfs: get bdev directly from fs_devices in submit_extent_page
      btrfs: drop bio_set_dev where not needed
      btrfs: remove extent_map::bdev
      btrfs: drop bdev argument from submit_extent_page

Filipe Manana (8):
      Btrfs: make btrfs_wait_extents() static
      Btrfs: fix negative subv_writers counter and data space leak after buffered write
      Btrfs: fix metadata space leak on fixup worker failure to set range as delalloc
      Btrfs: remove wait queue from space_info structure
      Btrfs: remove unnecessary delalloc mutex for inodes
      Btrfs: send, allow clone operations within the same file
      Btrfs: send, skip backreference walking for extents with many references
      Btrfs: fix block group remaining RO forever after error during device replace

Goldwyn Rodrigues (1):
      btrfs: simplify inode locking for RWF_NOWAIT

Johannes Thumshirn (10):
      btrfs: raid56: reduce indentation in lock_stripe_add
      btrfs: remove pointless local variable in lock_stripe_add()
      btrfs: reduce indentation in btrfs_may_alloc_data_chunk
      btrfs: remove pointless indentation in btrfs_read_sys_array()
      btrfs: add xxhash64 to checksumming algorithms
      btrfs: add sha256 to checksumming algorithm
      btrfs: sysfs: show used checksum driver per filesystem
      btrfs: remove cached space_info in btrfs_statfs()
      btrfs: change btrfs_fs_devices::seeding to bool
      btrfs: change btrfs_fs_devices::rotating to bool

Josef Bacik (9):
      btrfs: separate out the extent leak code
      btrfs: separate out the extent io init function
      btrfs: move extent_io_tree defs to their own header
      btrfs: export find_delalloc_range
      btrfs: move the failrec tree stuff into extent-io-tree.h
      btrfs: use refcount_inc_not_zero in kill_all_nodes
      btrfs: check page->mapping when loading free space cache
      btrfs: use btrfs_block_group_cache_done in update_block_group
      btrfs: record all roots for rename exchange on a subvol

Marcos Paulo de Souza (2):
      btrfs: block-group: Rework documentation of check_system_chunk function
      btrfs: ioctl: Try to use btrfs_fs_info instead of *file

Nikolay Borisov (17):
      btrfs: Add assert to catch nested transaction commit
      btrfs: Don't opencode btrfs_find_name_in_backref in backref_in_log
      btrfs: Properly handle backref_in_log retval
      btrfs: Open-code name_in_log_ref in replay_one_name
      btrfs: User assert to document transaction requirement
      btrfs: Rename btrfs_join_transaction_nolock
      btrfs: Speed up btrfs_file_llseek
      btrfs: Simplify btrfs_file_llseek
      btrfs: Return offset from find_desired_extent
      btrfs: Cleanup and simplify find_newest_super_backup
      btrfs: Remove newest_gen argument from find_oldest_super_backup
      btrfs: Add read_backup_root
      btrfs: Factor out tree roots initialization during mount
      btrfs: Don't use objectid_mutex during mount
      btrfs: Remove unused next_root_backup function
      btrfs: Rename find_oldest_super_backup to init_backup_root_slot
      btrfs: Streamline btrfs_fs_info::backup_root_index semantics

Omar Sandoval (7):
      btrfs: get rid of unnecessary memset() of work item
      btrfs: don't prematurely free work in run_ordered_work()
      btrfs: don't prematurely free work in end_workqueue_fn()
      btrfs: don't prematurely free work in reada_start_machine_worker()
      btrfs: don't prematurely free work in scrub_missing_raid56_worker()
      btrfs: get rid of unique workqueue helper functions
      btrfs: get rid of pointless wtag variable in async-thread.c

Qu Wenruo (16):
      btrfs: tree-checker: Try to detect missing INODE_ITEM
      btrfs: tree-checker: Add check for INODE_REF
      btrfs: ctree: Reduce one indent level for btrfs_search_slot()
      btrfs: ctree: Reduce one indent level for btrfs_search_old_slot()
      btrfs: ctree: Remove stray comment of setting up path lock
      btrfs: transaction: describe transaction states and transitions
      btrfs: transaction: Cleanup unused TRANS_STATE_BLOCKED
      btrfs: tree-checker: Refactor prev_key check for ino into a function
      btrfs: Enhance error output for write time tree checker
      btrfs: Remove btrfs_bio::flags member
      btrfs: tree-checker: Check item size before reading file extent type
      btrfs: volumes: Use more straightforward way to calculate map length
      btrfs: Ensure we trim ranges across block group boundary
      btrfs: block-group: Refactor btrfs_read_block_groups()
      btrfs: block-group: Reuse the item key from caller of read_one_block_group()
      btrfs: scrub: Don't check free space before marking a block group RO

Tejun Heo (1):
      btrfs: Avoid getting stuck during cyclic writebacks

 fs/btrfs/Kconfig                       |   2 +
 fs/btrfs/async-thread.c                | 113 +++----
 fs/btrfs/async-thread.h                |  37 +--
 fs/btrfs/block-group.c                 | 589 +++++++++++++++++----------------
 fs/btrfs/block-group.h                 |  51 +--
 fs/btrfs/btrfs_inode.h                 |   3 -
 fs/btrfs/compression.c                 | 269 +++++++++++----
 fs/btrfs/compression.h                 |  46 +--
 fs/btrfs/ctree.c                       | 287 +++++++---------
 fs/btrfs/ctree.h                       |  51 +--
 fs/btrfs/delalloc-space.c              |  21 +-
 fs/btrfs/delayed-inode.c               |  18 +-
 fs/btrfs/dev-replace.c                 |   2 +-
 fs/btrfs/dev-replace.h                 |   2 +-
 fs/btrfs/disk-io.c                     | 365 ++++++++++----------
 fs/btrfs/disk-io.h                     |   4 +-
 fs/btrfs/export.c                      |   4 +-
 fs/btrfs/extent-io-tree.h              | 248 ++++++++++++++
 fs/btrfs/extent-tree.c                 | 146 ++++----
 fs/btrfs/extent_io.c                   | 120 ++++---
 fs/btrfs/extent_io.h                   | 231 +------------
 fs/btrfs/extent_map.c                  |   6 +-
 fs/btrfs/extent_map.h                  |  11 +-
 fs/btrfs/file-item.c                   |   1 -
 fs/btrfs/file.c                        |  74 ++---
 fs/btrfs/free-space-cache.c            | 118 +++----
 fs/btrfs/free-space-cache.h            |  39 +--
 fs/btrfs/free-space-tree.c             | 133 ++++----
 fs/btrfs/free-space-tree.h             |  18 +-
 fs/btrfs/inode.c                       | 170 ++++++----
 fs/btrfs/ioctl.c                       |  49 ++-
 fs/btrfs/locking.c                     | 309 ++++++++++++++---
 fs/btrfs/locking.h                     |  13 +-
 fs/btrfs/lzo.c                         |  53 +--
 fs/btrfs/misc.h                        |  11 +
 fs/btrfs/ordered-data.c                |   7 +-
 fs/btrfs/ordered-data.h                |   2 +-
 fs/btrfs/print-tree.c                  |   6 +-
 fs/btrfs/props.c                       |   6 +-
 fs/btrfs/qgroup.c                      |  11 +-
 fs/btrfs/qgroup.h                      |   2 +-
 fs/btrfs/raid56.c                      | 101 +++---
 fs/btrfs/reada.c                       |  19 +-
 fs/btrfs/relocation.c                  |  43 ++-
 fs/btrfs/scrub.c                       | 100 +++---
 fs/btrfs/send.c                        |  45 ++-
 fs/btrfs/space-info.c                  |   8 +-
 fs/btrfs/space-info.h                  |   3 +-
 fs/btrfs/super.c                       |  26 +-
 fs/btrfs/sysfs.c                       |  47 ++-
 fs/btrfs/sysfs.h                       |   2 +-
 fs/btrfs/tests/btrfs-tests.c           |  11 +-
 fs/btrfs/tests/btrfs-tests.h           |   4 +-
 fs/btrfs/tests/free-space-tests.c      |  15 +-
 fs/btrfs/tests/free-space-tree-tests.c | 101 +++---
 fs/btrfs/transaction.c                 |  98 +++++-
 fs/btrfs/transaction.h                 |   5 +-
 fs/btrfs/tree-checker.c                | 211 +++++++++---
 fs/btrfs/tree-log.c                    | 136 ++++----
 fs/btrfs/volumes.c                     | 494 ++++++++-------------------
 fs/btrfs/volumes.h                     |  24 +-
 fs/btrfs/zlib.c                        |  52 +--
 fs/btrfs/zstd.c                        |  47 +--
 include/trace/events/btrfs.h           | 131 ++++----
 include/uapi/linux/btrfs.h             |   5 +-
 include/uapi/linux/btrfs_tree.h        |  23 +-
 66 files changed, 2780 insertions(+), 2619 deletions(-)
 create mode 100644 fs/btrfs/extent-io-tree.h
