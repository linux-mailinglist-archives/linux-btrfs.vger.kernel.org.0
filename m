Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC09973E815
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjFZSWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjFZSWi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 14:22:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50431BD8;
        Mon, 26 Jun 2023 11:22:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 93C701F8B0;
        Mon, 26 Jun 2023 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687803672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Q7+R2TzbKocZNfaMpZNSY79C3rXZ/KF+787iPdM+Y94=;
        b=aYaHgweH1HJBu+oyk8ccDZcEbBDqjsrT4JUaCvmjuTziUMfvYLsdmxLFGQOtDI7De4qPNw
        kjKvJco9EdRxaKDlr42gBaZ9HTXnHurYj0PRJ0V7/bnjuV6mzHVClRvJvB4uDlR8H0wr41
        +zPQcaSwTmTtRL0kCk8UAKh8nRYH7S4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7FC3E2C141;
        Mon, 26 Jun 2023 18:21:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CFE17DA7FB; Mon, 26 Jun 2023 20:14:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.5
Date:   Mon, 26 Jun 2023 20:14:42 +0200
Message-Id: <cover.1687802358.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are mainly core changes, refactoring and optimizations.
Performance is improved in some areas, overall there may be a cumulative
improvement due to refactoring that removed lookups in the IO path or
simplified IO submission tracking.

No merge conflicts. Please pull, thanks.

Core:

- submit IO synchronously for fast checksums (crc32c and xxhash), remove
  high priority worker kthread

- read extent buffer in one go, simplify IO tracking, bio submission and
  locking

- remove additional tracking of redirtied extent buffers, originally
  added for zoned mode but actually not needed

- track ordered extent pointer in bio to avoid rbtree lookups during IO

- scrub, use recovered data stripes as cache to avoid unnecessary read

- in zoned mode, optimize logical to physical mappings of extents

- remove PageError handling, not set by VFS nor writeback

- cleanups, refactoring, better structure packing

- lots of error handling improvements

- more assertions, lockdep annotations

- print assertion failure with the exact line where it happens

- tracepoint updates

- more debugging prints

Performance:

- speedup in fsync(), better tracking of inode logged status can avoid
  transaction commit

- IO path structures track logical offsets in data structures and does
  not need to look it up

User visible changes:

- don't commit transaction for every created subvolume, this can reduce
  time when many subvolumes are created in a batch

- print affected files when relocation fails

- trigger orphan file cleanup during START_SYNC ioctl

Notable fixes:

- fix crash when disabling quota and relocation

- fix crashes when removing roots from drity list

- fix transacion abort during relocation when converting from newer
  profiles not covered by fallback

- in zoned mode, stop reclaiming block groups if filesystem becomes
  read-only

- fix rare race condition in tree mod log rewind that can miss some
  btree node slots

- with enabled fsverity, drop up-to-date page bit in case the
  verification fails

----------------------------------------------------------------
The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.5

for you to fetch changes up to 8a4a0b2a3eaf75ca8854f856ef29690c12b2f531:

  btrfs: fix race between quota disable and relocation (2023-06-19 20:29:25 +0200)

----------------------------------------------------------------
Anand Jain (11):
      btrfs: use SECTOR_SHIFT to convert physical offset to LBA
      btrfs: use SECTOR_SHIFT to convert LBA to physical offset
      btrfs: reduce struct btrfs_fs_devices size by moving fsid_change
      btrfs: streamline fsid checks in alloc_fs_devices
      btrfs: merge calls to alloc_fs_devices in device_list_add
      btrfs: add comment about metadata_uuid in btrfs_fs_devices
      btrfs: return bool from check_tree_block_fsid instead of int
      btrfs: simplify fsid and metadata_uuid comparisons
      btrfs: simplify how changed fsid and metadata_uuid is checked
      btrfs: consolidate uuid comparisons in btrfs_validate_super
      btrfs: add and fix comments in btrfs_fs_devices

Ben Dooks (1):
      btrfs: make btrfs_compressed_bioset static

Boris Burkov (2):
      btrfs: warn on invalid slot in tree mod log rewind
      btrfs: insert tree mod log move in push_node_left

Christoph Hellwig (80):
      btrfs: submit IO synchronously for fast checksum implementations
      btrfs: determine synchronous writers from bio or writeback control
      btrfs: remove hipri_workers workqueue
      btrfs: fix dirty_metadata_bytes for redirtied buffers
      btrfs: don't hold an extra reference for redirtied buffers
      btrfs: mark extent_buffer_under_io static
      btrfs: subpage: fix error handling in end_bio_subpage_eb_writepage
      btrfs: move setting the buffer uptodate out of validate_extent_buffer
      btrfs: merge verify_parent_transid and btrfs_buffer_uptodate
      btrfs: always read the entire extent_buffer
      btrfs: don't use btrfs_bio_ctrl for extent buffer reading
      btrfs: remove the mirror_num argument to btrfs_submit_compressed_read
      btrfs: use a separate end_io handler for read_extent_buffer
      btrfs: do not try to unlock the extent for non-subpage metadata reads
      btrfs: return bool from lock_extent_buffer_for_io
      btrfs: submit a writeback bio per extent_buffer
      btrfs: move page locking from lock_extent_buffer_for_io to write_one_eb
      btrfs: don't use btrfs_bio_ctrl for extent buffer writing
      btrfs: use a separate end_io handler for extent_buffer writing
      btrfs: remove the extent_buffer lookup in btree block checksumming
      btrfs: remove the io_pages field in struct extent_buffer
      btrfs: stop using PageError for extent_buffers
      btrfs: don't check for uptodate pages in read_extent_buffer_pages
      btrfs: stop using lock_extent in btrfs_buffer_uptodate
      btrfs: use per-buffer locking for extent_buffer reading
      btrfs: merge write_one_subpage_eb into write_one_eb
      btrfs: fix the btrfs_get_global_root return value
      btrfs: convert btrfs_get_global_root to use a switch statement
      btrfs: remove a pointless NULL check in btrfs_lookup_fs_root
      btrfs: optimize out btrfs_is_zoned for !CONFIG_BLK_DEV_ZONED
      btrfs: don't call btrfs_record_physical_zoned for failed append
      btrfs: mark the len field in struct btrfs_ordered_sum as unsigned
      btrfs: rename the bytenr field in struct btrfs_ordered_sum to logical
      btrfs: optimize the logical to physical mapping for zoned writes
      btrfs: record orig_physical only for the original bio
      btrfs: move split_extent_map to extent_map.c
      btrfs: reorder conditions in btrfs_extract_ordered_extent
      btrfs: return the new ordered_extent from btrfs_split_ordered_extent
      btrfs: split btrfs_alloc_ordered_extent to allocation and insertion helpers
      btrfs: atomically insert the new extent in btrfs_split_ordered_extent
      btrfs: handle completed ordered extents in btrfs_split_ordered_extent
      btrfs: defer splitting of ordered extents until I/O completion
      btrfs: pass the new logical address to split_extent_map
      btrfs: remove unused BTRFS_MAP_DISCARD
      btrfs: optimize simple reads in btrfsic_map_block
      btrfs: remove unused btrfs_map_block
      btrfs: rename __btrfs_map_block to btrfs_map_block
      btrfs: open code btrfs_map_sblock
      btrfs: open code need_full_stripe conditions
      btrfs: fix range_end calculation in extent_write_locked_range
      btrfs: factor out a btrfs_verify_page helper
      btrfs: fix fsverify read error handling in end_page_read
      btrfs: don't check PageError in btrfs_verify_page
      btrfs: don't fail writeback when allocating the compression context fails
      btrfs: rename cow_file_range_async to run_delalloc_compressed
      btrfs: don't check PageError in __extent_writepage
      btrfs: stop setting PageError in the data I/O path
      btrfs: remove PAGE_SET_ERROR
      btrfs: remove non-standard extent handling in __extent_writepage_io
      btrfs: move writeback_control::nr_to_write update to __extent_writepage
      btrfs: only call __extent_writepage_io from extent_write_locked_range
      btrfs: don't treat zoned writeback as being from an async helper thread
      btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split
      btrfs: limit write bios to a single ordered extent
      btrfs: merge the two calls to btrfs_add_ordered_extent in run_delalloc_nocow
      btrfs: pass an ordered_extent to btrfs_reloc_clone_csums
      btrfs: pass an ordered_extent to btrfs_submit_compressed_write
      btrfs: remove btrfs_add_ordered_extent
      btrfs: add a is_data_bbio helper
      btrfs: open code btrfs_bio_end_io in btrfs_dio_submit_io
      btrfs: add an ordered_extent pointer to struct btrfs_bio
      btrfs: use bbio->ordered in btrfs_csum_one_bio
      btrfs: factor out a can_finish_ordered_extent helper
      btrfs: factor out a btrfs_queue_ordered_fn helper
      btrfs: add a btrfs_finish_ordered_extent helper
      btrfs: open code end_extent_writepage in end_bio_extent_writepage
      btrfs: use btrfs_finish_ordered_extent to complete compressed writes
      btrfs: use btrfs_finish_ordered_extent to complete direct writes
      btrfs: use btrfs_finish_ordered_extent to complete buffered writes
      btrfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

David Sterba (13):
      btrfs: open code set_extent_defrag
      btrfs: open code set_extent_delalloc
      btrfs: open code set_extent_new
      btrfs: open code set_extent_dirty
      btrfs: open code set_extent_bits_nowait
      btrfs: open code set_extent_bits
      btrfs: drop NOFAIL from set_extent_bit allocation masks
      btrfs: pass NOWAIT for set/clear extent bits as another bit
      btrfs: drop gfp from parameter extent state helpers
      btrfs: print assertion failure report and stack trace from the same line
      btrfs: add xxhash to fast checksum implementations
      btrfs: disable allocation warnings for compression workspaces
      btrfs: add block-group tree to lockdep classes

Filipe Manana (51):
      btrfs: unexport btrfs_prev_leaf()
      btrfs: make btrfs_free_device() static
      btrfs: tag as unlikely the key comparison when checking sibling keys
      btrfs: avoid extra memory allocation when copying free space cache
      btrfs: avoid searching twice for previous node when merging free space entries
      btrfs: use precomputed end offsets at do_trimming()
      btrfs: simplify arguments to tree_insert_offset()
      btrfs: assert proper locks are held at tree_insert_offset()
      btrfs: assert tree lock is held when searching for free space entries
      btrfs: assert tree lock is held when linking free space
      btrfs: assert tree lock is held when removing free space entries
      btrfs: use inode_logged() at need_log_inode()
      btrfs: use inode_logged() at btrfs_record_unlink_dir()
      btrfs: update comments at btrfs_record_unlink_dir() to be more clear
      btrfs: remove pointless label and goto at btrfs_record_unlink_dir()
      btrfs: change for_rename argument of btrfs_record_unlink_dir() to bool
      btrfs: fix comment referring to no longer existing btrfs_clean_tree_block()
      btrfs: reorder some members of struct btrfs_delayed_ref_head
      btrfs: remove unused is_head field from struct btrfs_delayed_ref_node
      btrfs: remove pointless in_tree field from struct btrfs_delayed_ref_node
      btrfs: use a bool to track qgroup record insertion when adding ref head
      btrfs: make insert_delayed_ref() return a bool instead of an int
      btrfs: get rid of label and goto at insert_delayed_ref()
      btrfs: assert correct lock is held at btrfs_select_ref_head()
      btrfs: use bool type for delayed ref head fields that are used as booleans
      btrfs: use a single switch statement when initializing delayed ref head
      btrfs: remove unnecessary prototype declarations at disk-io.c
      btrfs: make btrfs_destroy_delayed_refs() return void
      btrfs: update documentation for a block group's bg_list member
      btrfs: add missing error handling when logging operation while COWing extent buffer
      btrfs: fix extent buffer leak after tree mod log failure at split_node()
      btrfs: avoid tree mod log ENOMEM failures when we don't need to log
      btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()
      btrfs: do not BUG_ON() on tree mod log failure at balance_level()
      btrfs: rename enospc label to out at balance_level()
      btrfs: avoid unnecessarily setting the fs to RO and error state at balance_level()
      btrfs: abort transaction at balance_level() when left child is missing
      btrfs: abort transaction at update_ref_for_cow() when ref count is zero
      btrfs: do not BUG_ON() on tree mod log failures at push_nodes_for_insert()
      btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()
      btrfs: do not BUG_ON() on tree mod log failures at insert_ptr()
      btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()
      btrfs: replace BUG_ON() at split_item() with proper error handling
      btrfs: do not BUG_ON() when dropping inode items from log root
      btrfs: send: do not BUG_ON() on unexpected symlink data extent
      btrfs: do not BUG_ON on failure to get dir index for new snapshot
      btrfs: do not BUG_ON after failure to migrate space during truncation
      btrfs: fix race when deleting quota root from the dirty cow roots list
      btrfs: fix race when deleting free space root from the dirty cow roots list
      btrfs: add comment to struct btrfs_fs_info::dirty_cowonly_roots
      btrfs: fix race between quota disable and relocation

Jeff Layton (1):
      btrfs: update i_version in update_dev_time

Jiapeng Chong (1):
      btrfs: scrub: remove more unused functions

Johannes Thumshirn (1):
      btrfs: unexport btrfs_run_discard_work and make it static

Josef Bacik (12):
      btrfs: move btrfs_check_trunc_cache_free_space into block-rsv.c
      btrfs: remove level argument from btrfs_set_block_flags
      btrfs: simplify btrfs_check_leaf_* helpers into a single helper
      btrfs: add btrfs_tree_block_status definitions to tree-checker.h
      btrfs: use btrfs_tree_block_status for leaf item errors
      btrfs: extend btrfs_leaf_check to return btrfs_tree_block_status
      btrfs: add __btrfs_check_node helper
      btrfs: move btrfs_verify_level_key into tree-checker.c
      btrfs: move split_flags/combine_flags helpers to inode-item.h
      btrfs: add __KERNEL__ check for btrfs_no_printk
      btrfs: add a btrfs_csum_type_size helper
      btrfs: rename del_ptr to btrfs_del_ptr and export it

Matt Corallo (1):
      btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile

Naohiro Aota (6):
      btrfs: export bitmap_test_range_all_{set,zero}
      btrfs: delete unused BGs while reclaiming BGs
      btrfs: move out now unused BG from the reclaim list
      btrfs: bail out reclaim process if filesystem is read-only
      btrfs: reinsert BGs failed to reclaim
      btrfs: tracepoints: also show actual number of the outstanding extents

Qu Wenruo (11):
      btrfs: print-tree: pass const extent buffer pointer
      btrfs: improve leaf dump and error handling
      btrfs: output affected files when relocation fails
      btrfs: scrub: use recovered data stripes as cache to avoid unnecessary read
      btrfs: handle tree backref walk error properly
      btrfs: trigger orphan inode cleanup during START_SYNC ioctl
      btrfs: subpage: dump extra subpage bitmaps for debug
      btrfs: subpage: make alloc_extent_buffer() handle previously uptodate range efficiently
      btrfs: use the same uptodate variable for end_bio_extent_readpage()
      btrfs: scrub: remove scrub_ctx::csum_list member
      btrfs: scrub: remove btrfs_fs_info::scrub_wr_completion_workers

Sweet Tea Dorminy (1):
      btrfs: don't commit transaction for every subvol create

Tejun Heo (1):
      btrfs: use alloc_ordered_workqueue() to create ordered workqueues

Tom Rix (1):
      btrfs: simplify transid initialization in btrfs_ioctl_wait_sync

 fs/btrfs/async-thread.c          |  44 +-
 fs/btrfs/async-thread.h          |   3 +
 fs/btrfs/bio.c                   | 122 +++---
 fs/btrfs/bio.h                   |  29 +-
 fs/btrfs/block-group.c           |  47 ++-
 fs/btrfs/block-group.h           |   9 +-
 fs/btrfs/block-rsv.c             |  19 +
 fs/btrfs/block-rsv.h             |   2 +
 fs/btrfs/btrfs_inode.h           |  23 +-
 fs/btrfs/check-integrity.c       |  21 +-
 fs/btrfs/compression.c           |  50 +--
 fs/btrfs/compression.h           |   7 +-
 fs/btrfs/ctree.c                 | 429 +++++++++++++-------
 fs/btrfs/ctree.h                 |   6 +-
 fs/btrfs/defrag.c                |   3 +-
 fs/btrfs/delayed-ref.c           | 110 ++---
 fs/btrfs/delayed-ref.h           |  25 +-
 fs/btrfs/dev-replace.c           |   6 +-
 fs/btrfs/discard.c               |  34 +-
 fs/btrfs/discard.h               |   1 -
 fs/btrfs/disk-io.c               | 451 ++++-----------------
 fs/btrfs/disk-io.h               |   7 +-
 fs/btrfs/extent-io-tree.c        |  37 +-
 fs/btrfs/extent-io-tree.h        |  62 +--
 fs/btrfs/extent-tree.c           | 186 ++++-----
 fs/btrfs/extent-tree.h           |   2 +-
 fs/btrfs/extent_io.c             | 848 +++++++++++----------------------------
 fs/btrfs/extent_io.h             |  11 +-
 fs/btrfs/extent_map.c            | 110 ++++-
 fs/btrfs/extent_map.h            |   6 +-
 fs/btrfs/file-item.c             |  90 ++---
 fs/btrfs/file-item.h             |   1 +
 fs/btrfs/file.c                  |  12 +-
 fs/btrfs/free-space-cache.c      | 122 +++---
 fs/btrfs/free-space-cache.h      |   2 -
 fs/btrfs/free-space-tree.c       |   3 +
 fs/btrfs/fs.h                    |   5 +-
 fs/btrfs/inode-item.h            |  16 +
 fs/btrfs/inode.c                 | 592 ++++++++++++++++-----------
 fs/btrfs/ioctl.c                 |  23 +-
 fs/btrfs/locking.c               |   5 +-
 fs/btrfs/lzo.c                   |   6 +-
 fs/btrfs/messages.c              |   8 -
 fs/btrfs/messages.h              |  15 +-
 fs/btrfs/misc.h                  |  20 +
 fs/btrfs/ordered-data.c          | 442 +++++++++++---------
 fs/btrfs/ordered-data.h          |  27 +-
 fs/btrfs/print-tree.c            |  16 +-
 fs/btrfs/print-tree.h            |   4 +-
 fs/btrfs/qgroup.c                |  20 +-
 fs/btrfs/raid56.c                |  49 ++-
 fs/btrfs/raid56.h                |   3 +
 fs/btrfs/relocation.c            |  61 +--
 fs/btrfs/relocation.h            |   3 +-
 fs/btrfs/scrub.c                 | 125 ++----
 fs/btrfs/send.c                  |  16 +-
 fs/btrfs/subpage.c               |  97 ++---
 fs/btrfs/subpage.h               |  12 +-
 fs/btrfs/super.c                 |   1 -
 fs/btrfs/tests/extent-io-tests.c |  16 +-
 fs/btrfs/transaction.c           |  16 +-
 fs/btrfs/transaction.h           |   3 -
 fs/btrfs/tree-checker.c          | 158 ++++++--
 fs/btrfs/tree-checker.h          |  29 +-
 fs/btrfs/tree-log.c              |  62 +--
 fs/btrfs/tree-log.h              |   2 +-
 fs/btrfs/tree-mod-log.c          | 257 ++++++++++--
 fs/btrfs/volumes.c               | 173 ++++----
 fs/btrfs/volumes.h               |  57 ++-
 fs/btrfs/zlib.c                  |   2 +-
 fs/btrfs/zoned.c                 | 159 ++++----
 fs/btrfs/zoned.h                 |   8 +-
 fs/btrfs/zstd.c                  |   2 +-
 include/trace/events/btrfs.h     |  39 +-
 tools/objtool/check.c            |   1 -
 75 files changed, 2780 insertions(+), 2710 deletions(-)
