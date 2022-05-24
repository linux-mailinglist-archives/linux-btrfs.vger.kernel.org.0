Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6ED532DE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiEXPzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiEXPzT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 11:55:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D095DC1;
        Tue, 24 May 2022 08:55:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BEE21F91F;
        Tue, 24 May 2022 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653407716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=U+eYpjRWjnFysiQ2gI+WTbpbCrEjq2uWoVe1d7zu9Xo=;
        b=eH8HK8WAPurFHjWvMtbOX36rV2Z2eEqb0P4xEQkF8WMsSgoxrcsJgddraghxvMcXzAPa8W
        DUsEgBS5jDoIX+/B09nyduBYQcWlMK4D7SQoV0hQI7eHEC1pPB7VgVDY9wN+O/MHoVpyOX
        n0kfNV70abBlfGWRzQRw7gn2lwRypDg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFE9213ADF;
        Tue, 24 May 2022 15:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sr2zMeP/jGKLSQAAMHmgww
        (envelope-from <dsterba@suse.com>); Tue, 24 May 2022 15:55:15 +0000
Date:   Tue, 24 May 2022 17:50:53 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.19
Message-ID: <cover.1653327652.git.dsterba@suse.com>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following updates, thanks. There are some minor changes
to code outside of btrfs (VFS, iomap), adding simple helpers or exports.
No merge conflicts but there were some trivial reported in linux-next in
the iomap code.

Features:

- subpage:
  - support on PAGE_SIZE > 4K (previously only 64K)
  - make it work with raid56

- repair super block num_devices automatically if it does not match
  the number of device items

- defrag can convert inline extents to regular extents, up to now inline
  files were skipped but the setting of mount option max_inline could
  affect the decision logic

- zoned:
  - minimal accepted zone size is explicitly set to 4MiB
  - make zone reclaim less aggressive and don't reclaim if there are
    enough free zones
  - add per-profile sysfs tunable of the reclaim threshold

- allow automatic block group reclaim for non-zoned filesystems, with
  sysfs tunables

- tree-checker: new check, compare extent buffer owner against owner
  rootid

Performance:

- avoid blocking on space reservation when doing nowait direct io
  writes, (+7% throughput for reads and writes)

- NOCOW write throughput improvement due to refined locking (+3%)

- send: reduce pressure to page cache by dropping extent pages right
  after they're processed

Core:

- convert all radix trees to xarray

- add iterators for b-tree node items

- support printk message index

- user bulk page allocation for extent buffers

- switch to bio_alloc API, use on-stack bios where convenient, other bio
  cleanups

- use rw lock for block groups to favor concurrent reads

- simplify workques, don't allocate high priority threads for all normal
  queues as we need only one

- refactor scrub, process chunks based on their constraints and
  similarity

- allocate direct io structures on stack and pass around only pointers,
  avoids allocation and reduces potential error handling

Fixes:

- fix count of reserved transaction items for various inode operations

- fix deadlock between concurrent dio writes when low on free data space

- fix a few cases when zones need to be finished

VFS, iomap:

- add helper to check if sb write has started (usable for assertions)

- new helper iomap_dio_alloc_bio, export iomap_dio_bio_end_io

----------------------------------------------------------------
The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-tag

for you to fetch changes up to 0a05fafe9def0d9f0fbef3dfc8094925af9e3185:

  btrfs: zoned: introduce a minimal zone size 4M and reject mount (2022-05-17 20:15:25 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: use a local variable for fs_devices pointer in btrfs_dev_replace_finishing

Christoph Hellwig (28):
      btrfs: factor check and flush helpers from __btrfsic_submit_bio
      btrfs: check-integrity: split submit_bio from btrfsic checking
      btrfs: check-integrity: simplify bio allocation in btrfsic_read_block
      btrfs: use on-stack bio in repair_io_failure
      btrfs: use on-stack bio in scrub_recheck_block
      btrfs: use on-stack bio in scrub_repair_page_from_good_copy
      btrfs: move the call to bio_set_dev out of submit_stripe_bio
      btrfs: pass a block_device to btrfs_bio_clone
      btrfs: pass bio opf to rbio_add_io_page
      btrfs: don't allocate a btrfs_bio for raid56 per-stripe bios
      btrfs: don't allocate a btrfs_bio for scrub bios
      btrfs: stop using the btrfs_bio saved iter in index_rbio_pages
      btrfs: remove the zoned/zone_size union in struct btrfs_fs_info
      btrfs: move btrfs_readpage to extent_io.c
      btrfs: remove unused bio_flags argument to btrfs_submit_metadata_bio
      btrfs: do not return errors from btrfs_submit_metadata_bio
      btrfs: do not return errors from btrfs_submit_compressed_read
      btrfs: do not return errors from submit_bio_hook_t instances
      btrfs: simplify WQ_HIGHPRI handling in struct btrfs_workqueue
      btrfs: use normal workqueues for scrub
      btrfs: use a normal workqueue for rmw_workers
      btrfs: add a btrfs_dio_rw wrapper
      iomap: allow the file system to provide a bio_set for direct I/O
      iomap: add per-iomap_iter private data
      btrfs: allocate dio_data on stack
      btrfs: remove the disk_bytenr in struct btrfs_dio_private
      btrfs: move struct btrfs_dio_private to inode.c
      btrfs: allocate the btrfs_dio_private as part of the iomap dio bio

David Sterba (9):
      btrfs: sink parameter is_data to btrfs_set_disk_extent_flags
      btrfs: remove btrfs_delayed_extent_op::is_data
      btrfs: remove unused parameter bio_flags from btrfs_wq_submit_bio
      btrfs: remove trivial helper update_nr_written
      btrfs: simplify handling of bio_ctrl::bio_flags
      btrfs: open code extent_set_compress_type helpers
      btrfs: rename io_failure_record::bio_flags to compress_type
      btrfs: rename bio_flags in parameters and switch type
      btrfs: rename bio_ctrl::bio_flags to compress_type

Filipe Manana (31):
      btrfs: avoid unnecessary btree search restarts when reading node
      btrfs: release upper nodes when reading stale btree node from disk
      btrfs: update outdated comment for read_block_for_search()
      btrfs: remove trivial wrapper btrfs_read_buffer()
      btrfs: only reserve the needed data space amount during fallocate
      btrfs: remove useless dio wait call when doing fallocate zero range
      btrfs: remove inode_dio_wait() calls when starting reflink operations
      btrfs: remove ordered extent check and wait during fallocate
      btrfs: lock the inode first before flushing range when punching hole
      btrfs: remove ordered extent check and wait during hole punching and zero range
      btrfs: add and use helper to assert an inode range is clean
      btrfs: avoid blocking on page locks with nowait dio on compressed range
      btrfs: avoid blocking nowait dio when locking file range
      btrfs: avoid double nocow check when doing nowait dio writes
      btrfs: stop allocating a path when checking if cross reference exists
      btrfs: free path at can_nocow_extent() before checking for checksum items
      btrfs: release path earlier at can_nocow_extent()
      btrfs: avoid blocking when allocating context for nowait dio read/write
      btrfs: avoid blocking on space revervation when doing nowait dio writes
      btrfs: move common NOCOW checks against a file extent into a helper
      btrfs: do not test for free space inode during NOCOW check against file extent
      btrfs: use BTRFS_DIR_START_INDEX at btrfs_create_new_inode()
      btrfs: remove search start argument from first_logical_byte()
      btrfs: use rbtree with leftmost node cached for tracking lowest block group
      btrfs: use a read/write lock for protecting the block groups tree
      btrfs: return block group directly at btrfs_next_block_group()
      btrfs: avoid double search for block group during NOCOW writes
      btrfs: fix deadlock between concurrent dio writes when low on free data space
      btrfs: send: keep the current inode open while processing it
      btrfs: send: avoid trashing the page cache
      btrfs: do not account twice for inode ref when reserving metadata units

Gabriel Niebler (18):
      btrfs: introduce btrfs_for_each_slot iterator macro
      btrfs: use btrfs_for_each_slot in find_first_block_group
      btrfs: use btrfs_for_each_slot in mark_block_group_to_copy
      btrfs: use btrfs_for_each_slot in btrfs_search_dir_index_item
      btrfs: use btrfs_for_each_slot in btrfs_real_readdir
      btrfs: use btrfs_for_each_slot in did_create_dir
      btrfs: use btrfs_for_each_slot in can_rmdir
      btrfs: use btrfs_for_each_slot in is_ancestor
      btrfs: use btrfs_for_each_slot in process_all_refs
      btrfs: use btrfs_for_each_slot in process_all_new_xattrs
      btrfs: use btrfs_for_each_slot in process_all_extents
      btrfs: use btrfs_for_each_slot in btrfs_unlink_all_paths
      btrfs: use btrfs_for_each_slot in btrfs_read_chunk_tree
      btrfs: use btrfs_for_each_slot in btrfs_listxattr
      btrfs: turn delayed_nodes_tree into an XArray
      btrfs: turn name_cache radix tree into XArray in send_ctx
      btrfs: turn fs_info member buffer_radix into XArray
      btrfs: turn fs_roots_radix in btrfs_fs_info into an XArray

Goldwyn Rodrigues (2):
      btrfs: do not pass compressed_bio to submit_compressed_bio()
      btrfs: derive compression type from extent map during reads

Johannes Thumshirn (2):
      btrfs: zoned: make auto-reclaim less aggressive
      btrfs: zoned: introduce a minimal zone size 4M and reject mount

Jonathan Lassoff (1):
      btrfs: add messages to printk index

Josef Bacik (3):
      btrfs: make the bg_reclaim_threshold per-space info
      btrfs: allow block group background reclaim for non-zoned filesystems
      btrfs: change the bg_reclaim_threshold valid region from 0 to 100

Lv Ruyi (1):
      btrfs: remove unnecessary check of iput argument

Naohiro Aota (8):
      fs: add a lockdep check function for sb_start_write()
      btrfs: assert that relocation is protected with sb_start_write()
      btrfs: zoned: introduce btrfs_zoned_bg_is_full
      btrfs: zoned: consolidate zone finish functions
      btrfs: zoned: finish block group when there are no more allocatable bytes left
      btrfs: zoned: properly finish block group on metadata write
      btrfs: zoned: zone finish unused block group
      btrfs: zoned: fix comparison of alloc_offset vs meta_write_pointer

Nikolay Borisov (3):
      btrfs: remove checks for arg argument in btrfs_ioctl_balance
      btrfs: simplify code flow in btrfs_ioctl_balance
      btrfs: improve error reporting in lookup_inline_extent_backref

Omar Sandoval (16):
      btrfs: reserve correct number of items for unlink and rmdir
      btrfs: reserve correct number of items for rename
      btrfs: fix anon_dev leak in create_subvol()
      btrfs: get rid of btrfs_add_nondir()
      btrfs: remove unnecessary btrfs_i_size_write(0) calls
      btrfs: remove unnecessary inode_set_bytes(0) call
      btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
      btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
      btrfs: remove redundant name and name_len parameters to create_subvol
      btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
      btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
      btrfs: set inode flags earlier in btrfs_new_inode()
      btrfs: allocate inode outside of btrfs_new_inode()
      btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
      btrfs: reserve correct number of items for inode creation
      btrfs: move common inode creation code into btrfs_create_new_inode()

Qu Wenruo (44):
      btrfs: scrub: rename members related to scrub_block::pagev
      btrfs: scrub: rename scrub_page to scrub_sector
      btrfs: scrub: rename scrub_bio::pagev and related members
      btrfs: warn when extent buffer leak test fails
      btrfs: tree-checker: check extent buffer owner against owner rootid
      btrfs: replace memset with memzero_page in data checksum verification
      btrfs: use dummy extent buffer for super block sys chunk array read
      btrfs: make nodesize >= PAGE_SIZE case to reuse the non-subpage routine
      btrfs: expand subpage support to any PAGE_SIZE > 4K
      btrfs: simplify parameters of submit_read_repair() and rename
      btrfs: avoid double clean up when submit_one_bio() failed
      btrfs: fix the error handling for submit_extent_page() for btrfs_do_readpage()
      btrfs: return correct error number for __extent_writepage_io()
      btrfs: repair super block num_devices automatically
      btrfs: reduce width for stripe_len from u64 to u32
      btrfs: raid56: open code rbio_nr_pages()
      btrfs: raid56: make btrfs_raid_bio more compact
      btrfs: raid56: introduce new cached members for btrfs_raid_bio
      btrfs: raid56: introduce btrfs_raid_bio::stripe_sectors
      btrfs: raid56: introduce btrfs_raid_bio::bio_sectors
      btrfs: raid56: make rbio_add_io_page() subpage compatible
      btrfs: raid56: make finish_parity_scrub() subpage compatible
      btrfs: raid56: make __raid_recover_endio_io() subpage compatible
      btrfs: raid56: make finish_rmw() subpage compatible
      btrfs: raid56: open code rbio_stripe_page_index()
      btrfs: raid56: make raid56_add_scrub_pages() subpage compatible
      btrfs: raid56: remove btrfs_raid_bio::bio_pages array
      btrfs: raid56: make set_bio_pages_uptodate() subpage compatible
      btrfs: raid56: make steal_rbio() subpage compatible
      btrfs: raid56: make alloc_rbio_essential_pages() subpage compatible
      btrfs: raid56: enable subpage support for RAID56
      btrfs: move definition of btrfs_raid_types to volumes.h
      btrfs: use ilog2() to replace if () branches for btrfs_bg_flags_to_raid_index()
      btrfs: calculate physical_end using dev_extent_len directly in scrub_stripe()
      btrfs: scrub: introduce a helper to locate an extent item
      btrfs: scrub: introduce dedicated helper to scrub simple-mirror based range
      btrfs: scrub: introduce dedicated helper to scrub simple-stripe based range
      btrfs: scrub: cleanup the non-RAID56 branches in scrub_stripe()
      btrfs: scrub: use scrub_simple_mirror() to handle RAID56 data stripe scrub
      btrfs: scrub: refactor scrub_raid56_parity()
      btrfs: scrub: use find_first_extent_item to for extent item search
      btrfs: scrub: move scrub_remap_extent() call into scrub_extent()
      btrfs: add "0x" prefix for unsupported optional features
      btrfs: allow defrag to convert inline extents to regular extents

Schspa Shi (1):
      btrfs: use non-bh spin_lock in zstd timer callback

Sweet Tea Dorminy (4):
      btrfs: restore inode creation before xattr setting
      btrfs: factor out allocating an array of pages
      btrfs: allocate page arrays using bulk page allocator
      btrfs: wait between incomplete batch memory allocations

Yu Zhe (1):
      btrfs: remove unnecessary type casts

 fs/btrfs/acl.c                  |   39 +-
 fs/btrfs/async-thread.c         |  122 +--
 fs/btrfs/async-thread.h         |    7 +-
 fs/btrfs/block-group.c          |  205 +++--
 fs/btrfs/block-group.h          |    7 +-
 fs/btrfs/btrfs_inode.h          |   25 -
 fs/btrfs/check-integrity.c      |  172 ++--
 fs/btrfs/check-integrity.h      |    6 +-
 fs/btrfs/compression.c          |   60 +-
 fs/btrfs/compression.h          |    4 +-
 fs/btrfs/ctree.c                |  102 ++-
 fs/btrfs/ctree.h                |  165 +++-
 fs/btrfs/delalloc-space.c       |    9 +-
 fs/btrfs/delayed-inode.c        |   84 +-
 fs/btrfs/delayed-ref.c          |    4 +-
 fs/btrfs/delayed-ref.h          |    1 -
 fs/btrfs/dev-replace.c          |   52 +-
 fs/btrfs/dir-item.c             |   31 +-
 fs/btrfs/disk-io.c              |  310 +++----
 fs/btrfs/disk-io.h              |   10 +-
 fs/btrfs/extent-tree.c          |   61 +-
 fs/btrfs/extent_io.c            |  619 +++++++------
 fs/btrfs/extent_io.h            |   47 +-
 fs/btrfs/file.c                 |  286 +++---
 fs/btrfs/free-space-cache.c     |    9 +-
 fs/btrfs/free-space-tree.c      |    2 +-
 fs/btrfs/inode.c                | 1870 +++++++++++++++++++-------------------
 fs/btrfs/ioctl.c                |  268 +++---
 fs/btrfs/props.c                |   40 +-
 fs/btrfs/props.h                |    4 -
 fs/btrfs/qgroup.c               |    7 +-
 fs/btrfs/qgroup.h               |   12 +-
 fs/btrfs/raid56.c               |  809 ++++++++++-------
 fs/btrfs/raid56.h               |    9 +-
 fs/btrfs/reflink.c              |   23 +-
 fs/btrfs/relocation.c           |   19 +-
 fs/btrfs/root-tree.c            |    3 +-
 fs/btrfs/scrub.c                | 1889 ++++++++++++++++++++-------------------
 fs/btrfs/send.c                 |  400 ++++-----
 fs/btrfs/space-info.c           |   11 +-
 fs/btrfs/space-info.h           |    8 +
 fs/btrfs/subpage.c              |   55 +-
 fs/btrfs/subpage.h              |    2 +
 fs/btrfs/super.c                |    9 +-
 fs/btrfs/sysfs.c                |   43 +-
 fs/btrfs/tests/btrfs-tests.c    |   24 +-
 fs/btrfs/transaction.c          |  116 ++-
 fs/btrfs/tree-checker.c         |   55 ++
 fs/btrfs/tree-checker.h         |    1 +
 fs/btrfs/tree-log.c             |   11 +-
 fs/btrfs/volumes.c              |  127 +--
 fs/btrfs/volumes.h              |   42 +-
 fs/btrfs/xattr.c                |   40 +-
 fs/btrfs/zoned.c                |  217 +++--
 fs/btrfs/zoned.h                |   23 +-
 fs/btrfs/zstd.c                 |   14 +-
 fs/erofs/data.c                 |    2 +-
 fs/ext4/file.c                  |    4 +-
 fs/f2fs/file.c                  |    4 +-
 fs/gfs2/file.c                  |    4 +-
 fs/iomap/direct-io.c            |   25 +-
 fs/xfs/xfs_file.c               |    6 +-
 fs/zonefs/super.c               |    4 +-
 include/linux/fs.h              |    5 +
 include/linux/iomap.h           |   16 +-
 include/trace/events/btrfs.h    |   30 +-
 include/uapi/linux/btrfs_tree.h |   13 -
 67 files changed, 4482 insertions(+), 4221 deletions(-)
