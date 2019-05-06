Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1438A14AEA
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEFNaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 May 2019 09:30:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfEFNaT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 May 2019 09:30:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B7BCAF0F;
        Mon,  6 May 2019 13:30:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8A3DDA888; Mon,  6 May 2019 15:31:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.2
Date:   Mon,  6 May 2019 15:31:12 +0200
Message-Id: <cover.1557148716.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this time the majority of changes are cleanups, though there's still a
number of changes of user interest. Please pull, thanks.

User visible changes:

- better read time and write checks to catch errors early and before
  writing data to disk (to catch potential memory corruption on data that
  get checksummed)

- qgroups + metadata relocation: last speed up patch int the series to
  address the slowness, there should be no overhead comparing balance with
  and without qgroups

- FIEMAP ioctl does not start a transaction unnecessarily, this can result
  in a speed up and less blocking due to IO

- LOGICAL_INO (v1, v2) does not start transaction unnecessarily, this can
  speed up the mentioned ioctl and scrub as well

- fsync on files with many (but not too many) hardlinks is faster, finer
  decision if the links should be fsynced individually or completely

- send tries harder to find ranges to clone

- trim/discard will skip unallocated chunks that haven't been touched
  since the last mount


Fixes:

- send flushes delayed allocation before start, otherwise it could miss
  some changes in case of a very recent rw->ro switch of a subvolume

- fix fallocate with qgroups that could lead to space accounting underflow,
  reported as a warning

- trim/discard ioctl honours the requested range

- starting send and dedupe on a subvolume at the same time will let only
  one of them succeed, this is to prevent changes that send could miss due
  to dedupe; both operations are restartable


Core changes:

- more tree-checker validations, errors reported by fuzzing tools
  - device item
  - inode item
  - block group profiles

- tracepoints for extent buffer locking

- async cow preallocates memory to avoid errors happening too deep in the
  call chain

- metadata reservations for delalloc reworked to better adapt in
  many-writers/low-space scenarios

- improved space flushing logic for intense DIO vs buffered workloads

- lots of cleanups
  - removed unused struct members
  - redundant argument removal
  - properties and xattrs
  - extent buffer locking
  - selftests
  - use common file type conversions
  - many-argument functions reduction

----------------------------------------------------------------
The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-tag

for you to fetch changes up to b1c16ac978fd40ae636e629bb69a652df7eebdc2:

  btrfs: Use kvmalloc for allocating compressed path context (2019-05-02 13:48:19 +0200)

----------------------------------------------------------------
Anand Jain (22):
      btrfs: merge _btrfs_set_prop helpers
      btrfs: drop redundant forward declaration in props.c
      btrfs: rename fs_info argument to fs_private
      btrfs: refactor btrfs_set_prop and add btrfs_set_prop_trans
      btrfs: drop unused parameter in mount_subvol
      btrfs: prop: open code btrfs_set_prop in inherit_prop
      btrfs: rename btrfs_setxattr to btrfs_setxattr_trans
      btrfs: rename do_setxattr to btrfs_setxattr
      btrfs: export btrfs_setxattr
      btrfs: remove redundant readonly root check in btrfs_setxattr_trans
      btrfs: split btrfs_setxattr calls regarding transaction
      btrfs: cleanup btrfs_setxattr_trans and drop transaction parameter
      btrfs: refactor btrfs_set_props to validate externally
      btrfs: export btrfs_set_prop
      btrfs: start transaction in btrfs_ioctl_setflags()
      btrfs: drop useless inode i_flags copy and restore
      btrfs: modify local copy of btrfs_inode flags
      btrfs: drop old_fsflags in btrfs_ioctl_setflags
      btrfs: drop local copy of inode i_mode
      btrfs: start transaction in xattr_handler_set_prop
      btrfs: delete unused function btrfs_set_prop_trans
      btrfs: merge calls of btrfs_setxattr and btrfs_setxattr_trans in btrfs_set_prop

Arnd Bergmann (1):
      btrfs: use BUG() instead of BUG_ON(1)

David Sterba (107):
      btrfs: scrub: return EAGAIN when fs is closing
      btrfs: switch extent_io_tree::track_uptodate to bool
      btrfs: add assertion helpers for spinning writers
      btrfs: use assertion helpers for spinning writers
      btrfs: add assertion helpers for spinning readers
      btrfs: use assertion helpers for spinning readers
      btrfs: add assertion helpers for extent buffer read lock counters
      btrfs: use assertion helpers for extent buffer read lock counters
      btrfs: add assertion helpers for extent buffer write lock counters
      btrfs: use assertion helpers for extent buffer write lock counters
      btrfs: switch extent_buffer::lock_nested to bool
      btrfs: tests: handle fs_info allocation failure in extent_io tests
      btrfs: tests: don't leak fs_info in extent_io bitmap tests
      btrfs: tests: print file:line for error messages
      btrfs: tests: add table of most common errors
      btrfs: tests: use standard error message after fs_info allocation failure
      btrfs: tests: use standard error message after root allocation failure
      btrfs: tests: use standard error message after extent buffer allocation failure
      btrfs: tests: use standard error message after path allocation failure
      btrfs: tests: use standard error message after inode allocation failure
      btrfs: tests: use standard error message after block group allocation failure
      btrfs: tests: properly initialize fs_info of extent buffer
      btrfs: tests: return errors from extent map tests
      btrfs: tests: return errors from extent map test case 1
      btrfs: tests: return errors from extent map test case 2
      btrfs: tests: return errors from extent map test case 3
      btrfs: tests: return errors from extent map test case 4
      btrfs: tests: return error from all extent map test cases
      btrfs: tests: use standard error message after extent map allocation failure
      btrfs: tests: use SZ_ constants everywhere
      btrfs: tests: fix comments about tested extent map ranges
      btrfs: tests: drop messages when some tests finish
      btrfs: tests: unify messages when tests start
      btrfs: remove stale definition of BUFFER_LRU_MAX
      btrfs: move tree block wait and write helpers to tree-log
      btrfs: get fs_info from eb in lock_extent_buffer_for_io
      btrfs: get fs_info from eb in repair_eb_io_failure
      btrfs: get fs_info from eb in write_one_eb
      btrfs: get fs_info from eb in leaf_data_end
      btrfs: get fs_info from eb in btrfs_exclude_logged_extents
      btrfs: get fs_info from eb in check_tree_block_fsid
      btrfs: get fs_info from eb in tree_mod_log_eb_copy
      btrfs: get fs_info from eb in clean_tree_block
      btrfs: get fs_info from eb in btrfs_leaf_free_space
      btrfs: get fs_info from eb in read_node_slot
      btrfs: get fs_info from eb in btree_read_extent_buffer_pages
      btrfs: get fs_info from eb in btrfs_verify_level_key
      btrfs: qgroup: remove obsolete fs_info members
      btrfs: tree-checker: get fs_info from eb in generic_err
      btrfs: tree-checker: get fs_info from eb in file_extent_err
      btrfs: tree-checker: get fs_info from eb in check_csum_item
      btrfs: tree-checker: get fs_info from eb in dir_item_err
      btrfs: tree-checker: get fs_info from eb in check_dir_item
      btrfs: tree-checker: get fs_info from eb in block_group_err
      btrfs: tree-checker: get fs_info from eb in check_block_group_item
      btrfs: tree-checker: get fs_info from eb in check_extent_data_item
      btrfs: tree-checker: get fs_info from eb in check_leaf_item
      btrfs: tree-checker: get fs_info from eb in check_leaf
      btrfs: tree-checker: get fs_info from eb in chunk_err
      btrfs: tree-checker: get fs_info from eb in dev_item_err
      btrfs: tree-checker: get fs_info from eb in check_dev_item
      btrfs: tree-checker: get fs_info from eb in check_inode_item
      btrfs: get fs_info from eb in btrfs_check_leaf_full
      btrfs: get fs_info from eb in btrfs_check_leaf_relaxed
      btrfs: get fs_info from eb in btrfs_check_node
      btrfs: get fs_info from eb in should_balance_chunk
      btrfs: get fs_info from eb in btrfs_check_chunk_valid
      btrfs: get fs_info from eb in read_one_chunk
      btrfs: get fs_info from eb in read_one_dev
      btrfs: get fs_info from trans in write_one_cache_group
      btrfs: get fs_info from trans in btrfs_setup_space_cache
      btrfs: get fs_info from trans in btrfs_write_dirty_block_groups
      btrfs: get fs_info from trans in update_block_group
      btrfs: get fs_info from trans in btrfs_create_tree
      btrfs: get fs_info from trans in btrfs_need_log_full_commit
      btrfs: get fs_info from trans in btrfs_set_log_full_commit
      btrfs: get fs_info from trans in create_free_space_inode
      btrfs: get fs_info from trans in btrfs_write_out_cache
      btrfs: get fs_info from trans in push_node_left
      btrfs: get fs_info from trans in balance_node_right
      btrfs: get fs_info from trans in insert_ptr
      btrfs: get fs_info from trans in copy_for_split
      btrfs: get fs_info from trans in init_first_rw_device
      btrfs: get fs_info from trans in btrfs_finish_sprout
      btrfs: get fs_info from trans in btrfs_run_dev_stats
      btrfs: get fs_info from trans in btrfs_run_dev_replace
      btrfs: get fs_info from block group in next_block_group
      btrfs: get fs_info from block group in pin_down_extent
      btrfs: get fs_info from block group in lookup_free_space_inode
      btrfs: get fs_info from block group in load_free_space_cache
      btrfs: get fs_info from block group in write_pinned_extent_entries
      btrfs: get fs_info from block group in btrfs_find_space_cluster
      btrfs: get fs_info from block group in search_free_space_info
      btrfs: get fs_info from eb in __push_leaf_right
      btrfs: get fs_info from eb in __push_leaf_left
      btrfs: get fs_info from device in btrfs_rm_dev_item
      btrfs: get fs_info from device in btrfs_scrub_cancel_dev
      btrfs: get fs_info from device in btrfs_rm_dev_replace_free_srcdev
      btrfs: remove unused parameter fs_info from split_item
      btrfs: remove unused parameter fs_info from btrfs_truncate_item
      btrfs: remove unused parameter fs_info from btrfs_extend_item
      btrfs: remove unused parameter fs_info from tree_move_down
      btrfs: remove unused parameter fs_info from from tree_advance
      btrfs: remove unused parameter fs_info from CHECK_FE_ALIGNED
      btrfs: remove unused parameter fs_info from emit_last_fiemap_cache
      btrfs: remove unused parameter fs_info from btrfs_add_delayed_extent_op
      btrfs: remove unused parameter fs_info from btrfs_set_disk_extent_flags

Dennis Zhou (1):
      btrfs: zstd: remove indirect calls for local functions

Filipe Manana (8):
      Btrfs: remove no longer used 'sync' member from transaction handle
      Btrfs: remove no longer used member num_dirty_bgs from transaction
      Btrfs: remove no longer used function to run delayed refs asynchronously
      Btrfs: do not start a transaction at iterate_extent_inodes()
      Btrfs: do not start a transaction during fiemap
      Btrfs: send, flush dellaloc in order to avoid data loss
      Btrfs: fix race between send and deduplication that lead to failures and crashes
      Btrfs: improve performance on fsync of files with multiple hardlinks

Goldwyn Rodrigues (2):
      btrfs: Initialize inode::i_mapping once in btrfs_symlink
      btrfs: Perform locking/unlocking in btrfs_remap_file_range()

Jeff Mahoney (1):
      btrfs: replace pending/pinned chunks lists with io tree

Johannes Thumshirn (3):
      btrfs: factor our read/write stage off csum_tree_block into its callers
      btrfs: warn if extent buffer mapping crosses a page boundary in csum_tree_block
      btrfs: reduce kmap_atomic time for checksumming

Josef Bacik (3):
      btrfs: fix panic during relocation after ENOSPC before writeback happens
      btrfs: track DIO bytes in flight
      btrfs: reserve delalloc metadata differently

Nathan Chancellor (1):
      btrfs: Turn an 'else if' into an 'else' in btrfs_uuid_tree_add

Nikolay Borisov (36):
      btrfs: Remove EXTENT_WRITEBACK
      btrfs: Remove EXTENT_IOBITS
      btrfs: Exploit the fact that pages passed to extent_readpages are always contiguous
      btrfs: Remove unused -EIO assignment in end_bio_extent_readpage
      btrfs: Correctly free extent buffer in case btree_read_extent_buffer_pages fails
      btrfs: Use less confusing condition for uptodate parameter to btrfs_writepage_endio_finish_ordered
      btrfs: Honour FITRIM range constraints during free space trim
      btrfs: combine device update operations during transaction commit
      btrfs: Handle pending/pinned chunks before blockgroup relocation during device shrink
      btrfs: Rename and export clear_btree_io_tree
      btrfs: Populate ->orig_block_len during read_one_chunk
      btrfs: Introduce new bits for device allocation tree
      btrfs: Implement set_extent_bits_nowait
      btrfs: Stop using call_rcu for device freeing
      btrfs: Transpose btrfs_close_devices/btrfs_mapping_tree_free in close_ctree
      btrfs: Remove 'trans' argument from find_free_dev_extent(_start)
      btrfs: Factor out in_range macro
      btrfs: Optimize unallocated chunks discard
      btrfs: Implement find_first_clear_extent_bit
      btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit
      btrfs: Remove redundant inode argument from btrfs_add_ordered_sum
      btrfs: Define submit_bio_hook's type directly
      btrfs: Change submit_bio_hook to taking an inode directly
      btrfs: Remove 'tree' argument from read_extent_buffer_pages
      btrfs: Pass 0 for bio_offset to btrfs_wq_submit_bio
      btrfs: Always pass 0 bio_offset for btree_submit_bio_start
      btrfs: Remove bio_offset argument from submit_bio_hook
      btrfs: Document btrfs_csum_one_bio
      btrfs: Preallocate chunks in cow_file_range_async
      btrfs: Rename async_cow to async_chunk
      btrfs: Remove fs_info from struct async_chunk
      btrfs: Make compress_file_range take only struct async_chunk
      btrfs: Replace clear_extent_bit with unlock_extent
      btrfs: Set io_tree only once in submit_compressed_extents
      btrfs: Factor out common extent locking code in submit_compressed_extents
      btrfs: Use kvmalloc for allocating compressed path context

Phillip Potter (1):
      btrfs: use common file type conversion

Qu Wenruo (39):
      btrfs: Don't panic when we can't find a root key
      btrfs: Introduce fs_info to extent_io_tree
      btrfs: Introduce extent_io_tree::owner to distinguish different io_trees
      btrfs: tracepoints: Add trace events for extent_io_tree
      btrfs: reloc: Fix NULL pointer dereference due to expanded reloc_root lifespan
      btrfs: Make btrfs_(set|clear)_header_flag return void
      btrfs: Check the first key and level for cached extent buffer
      btrfs: Always output error message when key/level verification fails
      btrfs: extent_io: Move the BUG_ON() in flush_write_bio() one level up
      btrfs: extent_io: Handle errors better in extent_write_full_page()
      btrfs: extent_io: Handle errors better in btree_write_cache_pages()
      btrfs: extent_io: Kill dead condition in extent_write_cache_pages()
      btrfs: extent_io: Handle errors better in extent_write_locked_range()
      btrfs: extent_io: add proper error handling to lock_extent_buffer_for_io()
      btrfs: extent_io: Handle errors better in extent_writepages()
      btrfs: disk-io: Show the timing of corrupted tree block explicitly
      btrfs: Move btrfs_check_chunk_valid() to tree-check.[ch] and export it
      btrfs: tree-checker: Make chunk item checker messages more readable
      btrfs: tree-checker: Make btrfs_check_chunk_valid() return EUCLEAN instead of EIO
      btrfs: tree-checker: Check chunk item at tree block read time
      btrfs: tree-checker: Verify dev item
      btrfs: tree-checker: Enhance chunk checker to validate chunk profile
      btrfs: tree-checker: Verify inode item
      btrfs: inode: Verify inode mode to avoid NULL pointer dereference
      btrfs: tree-checker: Remove comprehensive root owner check
      btrfs: Do mandatory tree block check before submitting bio
      btrfs: trace: Introduce trace events for sleepable tree lock
      btrfs: trace: Introduce trace events for all btrfs tree locking events
      btrfs: delayed-ref: Introduce better documented delayed ref structures
      btrfs: extent-tree: Open-code process_func in __btrfs_mod_ref
      btrfs: delayed-ref: Use btrfs_ref to refactor btrfs_add_delayed_tree_ref()
      btrfs: delayed-ref: Use btrfs_ref to refactor btrfs_add_delayed_data_ref()
      btrfs: ref-verify: Use btrfs_ref to refactor btrfs_ref_tree_mod()
      btrfs: extent-tree: Use btrfs_ref to refactor add_pinned_bytes()
      btrfs: extent-tree: Use btrfs_ref to refactor btrfs_inc_extent_ref()
      btrfs: extent-tree: Use btrfs_ref to refactor btrfs_free_extent()
      btrfs: qgroup: Don't scan leaf if we're modifying reloc tree
      btrfs: tree-checker: Allow error injection for tree-checker
      btrfs: ctree: Dump the leaf before BUG_ON in btrfs_set_item_key_safe

Robbie Ko (2):
      Btrfs: send, improve clone range
      Btrfs: fix data bytes_may_use underflow with fallocate due to failed quota reserve

 fs/btrfs/acl.c                         |   6 +-
 fs/btrfs/backref.c                     |  38 +-
 fs/btrfs/btrfs_inode.h                 |   8 -
 fs/btrfs/compression.c                 |   2 +-
 fs/btrfs/ctree.c                       | 254 +++++++------
 fs/btrfs/ctree.h                       |  78 ++--
 fs/btrfs/delayed-inode.c               |   5 +-
 fs/btrfs/delayed-ref.c                 |  46 ++-
 fs/btrfs/delayed-ref.h                 | 122 +++++-
 fs/btrfs/dev-replace.c                 |   8 +-
 fs/btrfs/dev-replace.h                 |   3 +-
 fs/btrfs/dir-item.c                    |   5 +-
 fs/btrfs/disk-io.c                     | 225 ++++++------
 fs/btrfs/disk-io.h                     |   7 +-
 fs/btrfs/extent-tree.c                 | 651 ++++++++++++---------------------
 fs/btrfs/extent_io.c                   | 356 ++++++++++++------
 fs/btrfs/extent_io.h                   |  89 +++--
 fs/btrfs/extent_map.c                  |  38 ++
 fs/btrfs/file-item.c                   |  32 +-
 fs/btrfs/file.c                        |  47 ++-
 fs/btrfs/free-space-cache.c            |  45 +--
 fs/btrfs/free-space-cache.h            |  18 +-
 fs/btrfs/free-space-tree.c             |  24 +-
 fs/btrfs/free-space-tree.h             |   1 -
 fs/btrfs/inode-item.c                  |   8 +-
 fs/btrfs/inode.c                       | 329 +++++++++--------
 fs/btrfs/ioctl.c                       | 181 ++++-----
 fs/btrfs/locking.c                     | 157 ++++++--
 fs/btrfs/ordered-data.c                |  14 +-
 fs/btrfs/ordered-data.h                |   3 +-
 fs/btrfs/print-tree.c                  |   2 +-
 fs/btrfs/props.c                       | 242 ++++++------
 fs/btrfs/props.h                       |   7 +-
 fs/btrfs/qgroup.c                      |   5 +-
 fs/btrfs/ref-verify.c                  |  53 +--
 fs/btrfs/ref-verify.h                  |  10 +-
 fs/btrfs/relocation.c                  | 123 ++++---
 fs/btrfs/root-tree.c                   |  13 +-
 fs/btrfs/scrub.c                       |   6 +-
 fs/btrfs/send.c                        | 114 +++++-
 fs/btrfs/super.c                       |   4 +-
 fs/btrfs/tests/btrfs-tests.c           |  17 +-
 fs/btrfs/tests/btrfs-tests.h           |  17 +-
 fs/btrfs/tests/extent-buffer-tests.c   |   8 +-
 fs/btrfs/tests/extent-io-tests.c       |  35 +-
 fs/btrfs/tests/extent-map-tests.c      | 213 +++++++----
 fs/btrfs/tests/free-space-tests.c      |  11 +-
 fs/btrfs/tests/free-space-tree-tests.c |  14 +-
 fs/btrfs/tests/inode-tests.c           |  34 +-
 fs/btrfs/tests/qgroup-tests.c          |  20 +-
 fs/btrfs/transaction.c                 |  64 +---
 fs/btrfs/transaction.h                 |   4 +-
 fs/btrfs/tree-checker.c                | 513 ++++++++++++++++++++------
 fs/btrfs/tree-checker.h                |  11 +-
 fs/btrfs/tree-log.c                    | 289 +++++++++++----
 fs/btrfs/tree-log.h                    |  10 +-
 fs/btrfs/uuid-tree.c                   |   6 +-
 fs/btrfs/volumes.c                     | 469 ++++++++----------------
 fs/btrfs/volumes.h                     |  39 +-
 fs/btrfs/xattr.c                       |  65 ++--
 fs/btrfs/xattr.h                       |   7 +-
 fs/btrfs/zstd.c                        |  11 +-
 include/trace/events/btrfs.h           | 243 +++++++++++-
 include/uapi/linux/btrfs_tree.h        |   2 +
 64 files changed, 3287 insertions(+), 2194 deletions(-)
