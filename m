Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A430441EC7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKAQtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 12:49:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKAQtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 12:49:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59D1121940;
        Mon,  1 Nov 2021 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635785192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6WmRK/pKNEq2GqzpqfkBhRUaMryquglMrL21zOx0OYc=;
        b=Rl3YRU2ui7ZDaPTN4gUxhME4BvEq5INonuzcGgbSfjRNJiKxJrWsMVue9D17JEcrmv84Z2
        rH0S3/CBPfN7i48ZNJbgaKD1jVr8drcWqIp7KnV6l6OYJ25aFgLxYa88iU4hDfqz2YI80G
        OZh18avKfTBJQZ/Oipkxo813pv+cGUE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5029AA3B83;
        Mon,  1 Nov 2021 16:46:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82710DA781; Mon,  1 Nov 2021 17:45:57 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.16
Date:   Mon,  1 Nov 2021 17:45:56 +0100
Message-Id: <cover.1635773880.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

the updates this time are more under the hood and enhancing existing
features (subpage with compression and zoned namespaces).

There's a merge conflict due to the last minute 5.15 changes (kmap
reverts) and the conflict is not trivial. I've prepared another branch
that makes the changes as a separate commit possibly easier to merge,
same as the manual merge diff should look like.

The branch is for-5.16-resolve (with a signed tag for-5.16-resolve-tag).
A git merge resolving conflicts by leaving the new code results in zero
merge diff.

If there's anything else I can do regarding the merge, let me know.
Otherwise, please pull, thanks.


Performance related:

* misc small inode logging improvements (+3% throughput, -11% latency on
  sample dbench workload)

* more efficient directory logging: bulk item insertion, less tree
  searches and locking

* speed up bulk insertion of items into a b-tree, which is used when
  logging directories, when running delayed items for directories (fsync
  and transaction commits) and when running the slow path (full sync) of
  an fsync (bulk creation run time -4%, deletion -12%)

Core:

* continued subpage support
  * make defragmentation work
  * make compression write work

* zoned mode
  * support ZNS (zoned namespaces), zone capacity is number of usable
    blocks in each zone
  * add dedicated block group (zoned) for relocation, to prevent out of
    order writes in some cases
  * greedy block group reclaim, pick the ones with least usable space
    first

* preparatory work for send protocol updates

* error handling improvements

* cleanups and refactoring

Fixes:

* lockdep warnings
  * in show_devname callback, on seeding device
  * device delete on loop device due to conversions to workqueues

* fix deadlock between chunk allocation and chunk btree modifications

* fix tracking of missing device count and status

----------------------------------------------------------------
The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:

  Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-tag

for you to fetch changes up to d1ed82f3559e151804743df0594f45d7ff6e55fa:

  btrfs: remove root argument from check_item_in_log() (2021-10-29 12:39:13 +0200)

----------------------------------------------------------------
Anand Jain (12):
      btrfs: drop unnecessary ret in ioctl_quota_rescan_status
      btrfs: rename and switch to bool btrfs_chunk_readonly
      btrfs: convert latest_bdev type to btrfs_device and rename
      btrfs: use latest_dev in btrfs_show_devname
      btrfs: update latest_dev when we create a sprout device
      btrfs: remove stale comment about the btrfs_show_devname
      btrfs: reduce btrfs_update_block_group alloc argument to bool
      btrfs: use num_device to check for the last surviving seed device
      btrfs: add comments for device counts in struct btrfs_fs_devices
      btrfs: sysfs: convert scnprintf and snprintf to sysfs_emit
      btrfs: fix comment about sector sizes supported in 64K systems
      btrfs: call btrfs_check_rw_degradable only if there is a missing device

Christoph Hellwig (2):
      btrfs: use bvec_kmap_local in btrfs_csum_one_bio
      btrfs: check-integrity: stop storing the block device name in btrfsic_dev_state

David Sterba (1):
      btrfs: send: prepare for v2 protocol

Filipe Manana (26):
      btrfs: check if a log tree exists at inode_logged()
      btrfs: remove no longer needed checks for NULL log context
      btrfs: do not log new dentries when logging that a new name exists
      btrfs: always update the logged transaction when logging new names
      btrfs: avoid expensive search when dropping inode items from log
      btrfs: add helper to truncate inode items when logging inode
      btrfs: avoid expensive search when truncating inode items from the log
      btrfs: avoid search for logged i_size when logging inode if possible
      btrfs: avoid attempt to drop extents when logging inode for the first time
      btrfs: do not commit delayed inode when logging a file in full sync mode
      btrfs: remove root argument from btrfs_log_inode() and its callees
      btrfs: remove redundant log root assignment from log_dir_items()
      btrfs: factor out the copying loop of dir items from log_dir_items()
      btrfs: insert items in batches when logging a directory when possible
      btrfs: keep track of the last logged keys when logging a directory
      btrfs: assert that extent buffers are write locked instead of only locked
      btrfs: loop only once over data sizes array when inserting an item batch
      btrfs: unexport setup_items_for_insert()
      btrfs: use single bulk copy operations when logging directories
      btrfs: fix lost error handling when replaying directory deletes
      btrfs: fix deadlock between chunk allocation and chunk btree modifications
      btrfs: update comments for chunk allocation -ENOSPC cases
      btrfs: remove root argument from drop_one_dir_item()
      btrfs: remove root argument from btrfs_unlink_inode()
      btrfs: remove root argument from add_link()
      btrfs: remove root argument from check_item_in_log()

Johannes Thumshirn (9):
      btrfs: introduce btrfs_is_data_reloc_root
      btrfs: zoned: add a dedicated data relocation block group
      btrfs: zoned: only allow one process to add pages to a relocation inode
      btrfs: zoned: use regular writes for relocation
      btrfs: check for relocation inodes on zoned btrfs in should_nocow
      btrfs: zoned: allow preallocation for relocation inodes
      btrfs: rename setup_extent_mapping in relocation code
      btrfs: zoned: let the for_treelog test in the allocator stand out
      btrfs: zoned: use greedy gc for auto reclaim

Josef Bacik (11):
      btrfs: do not take the uuid_mutex in btrfs_rm_device
      btrfs: change handle_fs_error in recover_log_trees to aborts
      btrfs: change error handling for btrfs_delete_*_in_log
      btrfs: add a BTRFS_FS_ERROR helper
      btrfs: do not infinite loop in data reclaim if we aborted
      btrfs: do not call close_fs_devices in btrfs_rm_device
      btrfs: handle device lookup with btrfs_dev_lookup_args
      btrfs: add a btrfs_get_dev_args_from_path helper
      btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls
      fs: export an inode_update_time helper
      btrfs: update device path inode time instead of bd_inode

Kai Song (1):
      btrfs: zoned: use kmemdup() to replace kmalloc + memcpy

Li Zhang (1):
      btrfs: clear MISSING device status bit in btrfs_close_one_device

Marcos Paulo de Souza (1):
      btrfs: send: simplify send_create_inode_if_needed

Naohiro Aota (17):
      btrfs: zoned: load zone capacity information from devices
      btrfs: zoned: move btrfs_free_excluded_extents out of btrfs_calc_zone_unusable
      btrfs: zoned: calculate free space from zone capacity
      btrfs: zoned: tweak reclaim threshold for zone capacity
      btrfs: zoned: consider zone as full when no more SB can be written
      btrfs: zoned: locate superblock position using zone capacity
      btrfs: zoned: finish superblock zone once no space left for new SB
      btrfs: zoned: load active zone information from devices
      btrfs: zoned: introduce physical_map to btrfs_block_group
      btrfs: zoned: implement active zone tracking
      btrfs: zoned: load active zone info for block group
      btrfs: zoned: activate block group on allocation
      btrfs: zoned: activate new block group
      btrfs: move ffe_ctl one level up
      btrfs: zoned: avoid chunk allocation if active block group has enough space
      btrfs: zoned: finish fully written block group
      btrfs: zoned: finish relocating block group

Nikolay Borisov (6):
      btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
      btrfs: rename root fields in delayed refs structs
      btrfs: rely on owning_root field in btrfs_add_delayed_tree_ref to detect CHUNK_ROOT
      btrfs: add additional parameters to btrfs_init_tree_ref/btrfs_init_data_ref
      btrfs: pull up qgroup checks from delayed-ref core to init time
      btrfs: make btrfs_ref::real_root optional

Omar Sandoval (1):
      btrfs: fix deadlock when defragging transparent huge pages

Qu Wenruo (50):
      btrfs: subpage: only call btrfs_alloc_subpage() when sectorsize is smaller than PAGE_SIZE
      btrfs: subpage: make btrfs_alloc_subpage() return btrfs_subpage directly
      btrfs: subpage: introduce btrfs_subpage_bitmap_info
      btrfs: subpage: pack all subpage bitmaps into a larger bitmap
      btrfs: defrag: pass file_ra_state instead of file to btrfs_defrag_file()
      btrfs: defrag: also check PagePrivate for subpage cases in cluster_pages_for_defrag()
      btrfs: defrag: replace hard coded PAGE_SIZE with sectorsize
      btrfs: defrag: factor out page preparation into a helper
      btrfs: defrag: introduce helper to collect target file extents
      btrfs: defrag: introduce helper to defrag a contiguous prepared range
      btrfs: defrag: introduce helper to defrag a range
      btrfs: defrag: introduce helper to defrag one cluster
      btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()
      btrfs: defrag: remove the old infrastructure
      btrfs: defrag: enable defrag for subpage case
      btrfs: unexport repair_io_failure()
      btrfs: rename btrfs_bio to btrfs_io_context
      btrfs: remove btrfs_bio_alloc() helper
      btrfs: rename struct btrfs_io_bio to btrfs_bio
      btrfs: make sure btrfs_io_context::fs_info is always initialized
      btrfs: remove btrfs_raid_bio::fs_info member
      btrfs: remove unused parameter nr_pages in add_ra_bio_pages()
      btrfs: remove unnecessary parameter delalloc_start for writepage_delalloc()
      btrfs: use async_chunk::async_cow to replace the confusing pending pointer
      btrfs: don't pass compressed pages to btrfs_writepage_endio_finish_ordered()
      btrfs: subpage: make add_ra_bio_pages() compatible
      btrfs: introduce compressed_bio::pending_sectors to trace compressed bio
      btrfs: subpage: add bitmap for PageChecked flag
      btrfs: handle errors properly inside btrfs_submit_compressed_read()
      btrfs: handle errors properly inside btrfs_submit_compressed_write()
      btrfs: introduce submit_compressed_bio() for compression
      btrfs: introduce alloc_compressed_bio() for compression
      btrfs: determine stripe boundary at bio allocation time in btrfs_submit_compressed_read
      btrfs: determine stripe boundary at bio allocation time in btrfs_submit_compressed_write
      btrfs: remove unused function btrfs_bio_fits_in_stripe()
      btrfs: refactor submit_compressed_extents()
      btrfs: cleanup for extent_write_locked_range()
      btrfs: subpage: make compress_file_range() compatible
      btrfs: subpage: make btrfs_submit_compressed_write() compatible
      btrfs: subpage: make end_compressed_bio_writeback() compatible
      btrfs: subpage: make extent_write_locked_range() compatible
      btrfs: factor uncompressed async extent submission code into a new helper
      btrfs: subpage: make lzo_compress_pages() compatible
      btrfs: rework page locking in __extent_writepage()
      btrfs: handle page locking in btrfs_page_end_writer_lock with no writers
      btrfs: subpage: avoid potential deadlock with compression and delalloc
      btrfs: subpage: only allow compression if the range is fully page aligned
      btrfs: rename btrfs_dio_private::logical_offset to file_offset
      btrfs: remove btrfs_bio::logical member
      btrfs: make btrfs_super_block size match BTRFS_SUPER_INFO_SIZE

Sidong Yang (1):
      btrfs: reflink: initialize return value to 0 in btrfs_extent_same()

Su Yue (1):
      btrfs: update comment for fs_devices::seed_list in btrfs_rm_device

 fs/btrfs/block-group.c               |  242 +++++---
 fs/btrfs/block-group.h               |    8 +-
 fs/btrfs/btrfs_inode.h               |   46 +-
 fs/btrfs/check-integrity.c           |  205 +++----
 fs/btrfs/compression.c               |  681 +++++++++++++----------
 fs/btrfs/compression.h               |    4 +-
 fs/btrfs/ctree.c                     |  156 +++---
 fs/btrfs/ctree.h                     |   84 ++-
 fs/btrfs/delayed-inode.c             |   41 +-
 fs/btrfs/delayed-ref.c               |   17 +-
 fs/btrfs/delayed-ref.h               |   51 +-
 fs/btrfs/dev-replace.c               |   16 +-
 fs/btrfs/disk-io.c                   |   51 +-
 fs/btrfs/disk-io.h                   |    5 +-
 fs/btrfs/extent-tree.c               |  326 +++++++----
 fs/btrfs/extent_io.c                 |  334 ++++++-----
 fs/btrfs/extent_io.h                 |   10 +-
 fs/btrfs/extent_map.c                |    4 +-
 fs/btrfs/file-item.c                 |   21 +-
 fs/btrfs/file.c                      |   35 +-
 fs/btrfs/free-space-cache.c          |   24 +-
 fs/btrfs/inode.c                     |  611 +++++++++++----------
 fs/btrfs/ioctl.c                     | 1004 ++++++++++++++++------------------
 fs/btrfs/locking.h                   |    7 +-
 fs/btrfs/lzo.c                       |  270 +++++----
 fs/btrfs/raid56.c                    |  175 +++---
 fs/btrfs/raid56.h                    |   22 +-
 fs/btrfs/reada.c                     |   26 +-
 fs/btrfs/ref-verify.c                |    4 +-
 fs/btrfs/reflink.c                   |    4 +-
 fs/btrfs/relocation.c                |   81 +--
 fs/btrfs/scrub.c                     |  139 ++---
 fs/btrfs/send.c                      |   38 +-
 fs/btrfs/send.h                      |    7 +
 fs/btrfs/space-info.c                |   28 +-
 fs/btrfs/subpage.c                   |  290 +++++++---
 fs/btrfs/subpage.h                   |   56 +-
 fs/btrfs/super.c                     |   28 +-
 fs/btrfs/sysfs.c                     |   93 ++--
 fs/btrfs/tests/extent-buffer-tests.c |    2 +-
 fs/btrfs/tests/extent-io-tests.c     |   12 +-
 fs/btrfs/tests/inode-tests.c         |    4 +-
 fs/btrfs/transaction.c               |   11 +-
 fs/btrfs/tree-log.c                  |  745 ++++++++++++++++---------
 fs/btrfs/tree-log.h                  |   18 +-
 fs/btrfs/volumes.c                   |  592 +++++++++++---------
 fs/btrfs/volumes.h                   |  119 ++--
 fs/btrfs/xattr.c                     |    2 +-
 fs/btrfs/zoned.c                     |  531 ++++++++++++++++--
 fs/btrfs/zoned.h                     |   39 +-
 fs/inode.c                           |    7 +-
 include/linux/fs.h                   |    2 +
 include/uapi/linux/btrfs.h           |   11 +-
 53 files changed, 4439 insertions(+), 2900 deletions(-)
