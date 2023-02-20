Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B169D40F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBTT0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 14:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBTT0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 14:26:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DCD13D5B;
        Mon, 20 Feb 2023 11:26:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DCA5E33893;
        Mon, 20 Feb 2023 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676921165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X/yYnG44gTdXUcqMRIxo+cfObb3PPFOBWdM2v5Ayie0=;
        b=Z7D98O05rcCIgeoO38xdXt/CcAjfZN9OQ3mEvpf/lBI70+809yEckZIGN18TRdNyN748SC
        8qhPbv+v243j5rXJxZVnhb2+rst+4chpj+vEkJD5lb2sDl8cYkMPsP9AmaJC+st5XTYvAw
        QbuQ5HZM8qr41BrEt5xvEI3baTcYSfQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CC77B2C141;
        Mon, 20 Feb 2023 19:26:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0930DA7F3; Mon, 20 Feb 2023 20:20:11 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.3
Date:   Mon, 20 Feb 2023 20:20:08 +0100
Message-Id: <cover.1676908729.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there's a usual mix of performance improvements and new features. The
core change is reworking how checksums are processed, with followup
cleanups and simplifications. There are two minor changes in block layer
and iomap code.

Please pull, thanks.

Features:

- block group allocation class heuristics
  - pack files by size (up to 128k, up to 8M, more) to avoid
    fragmentation in block groups, assuming that file size and life time
    is correlated, in particular this may help during balance
  - with tracepoints and extensible in the future

Performance:

- send: cache directory utimes and only emit the command when necessary
  - speedup up to 10x
  - smaller final stream produced (no redundant utimes commands issued),
  - compatibility not affected

- fiemap: skip backref checks for shared leaves
  - speedup 3x on sample filesystem with all leaves shared (e.g. on
    snapshots)

- micro optimized b-tree key lookup, speedup in metadata operations
  (sample benchmark: fs_mark +10% of files/sec)

Core changes:

- change where checksumming is done in the io path
  - checksum and read repair does verification at lower layer
  - cascaded cleanups and simplifications

- raid56 refactoring and cleanups

Fixes:

- sysfs: make sure that a run-time change of a feature is correctly
  tracked by the feature files

- scrub: better reporting of tree block errors

Other:

- locally enable -Wmaybe-uninitialized after fixing all warnings

- misc cleanups, spelling fixes

Other code:

- block: export bio_split_rw

- iomap: remove IOMAP_F_ZONE_APPEND

----------------------------------------------------------------
The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-tag

for you to fetch changes up to 964a54e5e1a0d70cd80bd5a0885a1938463625b1:

  btrfs: make kobj_type structures constant (2023-02-15 19:38:55 +0100)

----------------------------------------------------------------
Boris Burkov (6):
      btrfs: pass find_free_extent_ctl to allocator tracepoints
      btrfs: add more find_free_extent tracepoints
      btrfs: introduce size class to block group allocator
      btrfs: load block group size class when caching
      btrfs: don't use size classes for zoned file systems
      btrfs: hold block group refcount during async discard

Christoph Hellwig (48):
      btrfs: remove the wait argument to btrfs_start_ordered_extent
      block: export bio_split_rw
      btrfs: better document struct btrfs_bio
      btrfs: add a btrfs_inode pointer to struct btrfs_bio
      btrfs: remove the direct I/O read checksum lookup optimization
      btrfs: simplify parameters of btrfs_lookup_bio_sums
      btrfs: refactor error handling in btrfs_submit_bio
      btrfs: save the bio iter for checksum validation in common code
      btrfs: pre-load data checksum for reads in btrfs_submit_bio
      btrfs: add a btrfs_data_csum_ok helper
      btrfs: handle checksum validation and repair at the storage layer
      btrfs: open code btrfs_bio_free_csum
      btrfs: remove btrfs_bio_for_each_sector
      btrfs: remove now unused checksumming helpers
      btrfs: remove struct btrfs_bio::device field
      btrfs: remove the io_failure_record infrastructure
      btrfs: rename btrfs_bio::iter field
      btrfs: remove struct btrfs_bio::is_metadata flag
      btrfs: open code the submit_bio_start helpers
      btrfs: simplify the btrfs_csum_one_bio calling convention
      btrfs: handle checksum generation in the storage layer
      btrfs: handle recording of zoned writes in the storage layer
      btrfs: support cloned bios in btree_csum_one_bio
      btrfs: allow btrfs_submit_bio to split bios
      btrfs: pass the iomap bio to btrfs_submit_bio
      btrfs: remove struct btrfs_io_geometry
      btrfs: open code submit_encoded_read_bio
      btrfs: remove the fs_info argument to btrfs_submit_bio
      btrfs: remove now spurious bio submission helpers
      btrfs: calculate file system wide queue limit for zoned mode
      btrfs: split zone append bios in btrfs_submit_bio
      iomap: remove IOMAP_F_ZONE_APPEND
      btrfs: raid56: simplify error handling and code flow in raid56_parity_write
      btrfs: raid56: simplify code flow in rmw_rbio
      btrfs: raid56: wait for I/O completion in submit_read_bios
      btrfs: raid56: add a bio_list_put helper
      btrfs: raid56: fold recover_assemble_read_bios into recover_rbio
      btrfs: raid56: fold rmw_read_wait_recover into rmw_read_bios
      btrfs: raid56: submit the read bios from scrub_assemble_read_bios
      btrfs: raid56: handle endio in rmw_rbio
      btrfs: raid56: handle endio in recover_rbio
      btrfs: raid56: handle endio in scrub_rbio
      btrfs: use file_offset to limit bios size in calc_bio_boundaries
      btrfs: set bbio->file_offset in alloc_new_bio
      btrfs: pass a btrfs_bio to btrfs_use_append
      btrfs: never return true for reads in btrfs_use_zone_append
      btrfs: don't rely on unchanging ->bi_bdev for zone append remaps
      btrfs: remove the bdev argument to btrfs_rmap_block

Colin Ian King (1):
      btrfs: fix spelling mistakes found using codespell

Filipe Manana (24):
      btrfs: use a negative value for BTRFS_LOG_FORCE_COMMIT
      btrfs: use a single variable to track return value for log_dir_items()
      btrfs: send: directly return from did_overwrite_ref() and simplify it
      btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
      btrfs: send: directly return from will_overwrite_ref() and simplify it
      btrfs: send: avoid extra b+tree searches when checking reference overrides
      btrfs: send: remove send_progress argument from can_rmdir()
      btrfs: send: avoid duplicated orphan dir allocation and initialization
      btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
      btrfs: send: reduce searches on parent root when checking if dir can be removed
      btrfs: send: iterate waiting dir move rbtree only once when processing refs
      btrfs: send: initialize all the red black trees earlier
      btrfs: send: genericize the backref cache to allow it to be reused
      btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
      btrfs: send: cache information about created directories
      btrfs: allow a generation number to be associated with lru cache entries
      btrfs: add an api to delete a specific entry from the lru cache
      btrfs: send: use the lru cache to implement the name cache
      btrfs: send: update size of roots array for backref cache entries
      btrfs: send: cache utimes operations for directories if possible
      btrfs: assert commit root semaphore is held when accessing backref cache
      btrfs: skip backref walking during fiemap if we know the leaf is shared
      btrfs: eliminate extra call when doing binary search on extent buffer
      btrfs: do unsigned integer division in the extent buffer binary search loop

Johannes Thumshirn (4):
      btrfs: drop unused trans parameter of drop_delayed_ref
      btrfs: remove trans parameter of merge_ref
      btrfs: drop trans parameter of insert_delayed_ref
      btrfs: directly pass in fs_info to btrfs_merge_delayed_refs

Josef Bacik (15):
      btrfs: move btrfs_abort_transaction to transaction.c
      btrfs: fix uninitialized variable warning in btrfs_cleanup_ordered_extents
      btrfs: fix uninitialized variable warning in get_inode_gen
      btrfs: fix uninitialized variable warning in btrfs_update_block_group
      btrfs: fix uninitialized variable warnings in __set_extent_bit and convert_extent_bit
      btrfs: fix uninitialized variable warning in btrfs_sb_log_location
      btrfs: fix uninitialized variable warning in run_one_async_start
      btrfs: turn on -Wmaybe-uninitialized
      btrfs: always lock the block before calling btrfs_clean_tree_block
      btrfs: add trans argument to btrfs_clean_tree_block
      btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
      btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
      btrfs: rename btrfs_clean_tree_block to btrfs_clear_buffer_dirty
      btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
      btrfs: replace btrfs_wait_tree_block_writeback by wait_on_extent_buffer_writeback

Naohiro Aota (1):
      btrfs: zoned: fix uninitialized variable warning in btrfs_get_dev_zones

Peng Hao (1):
      btrfs: go to matching label when cleaning em in btrfs_submit_direct

Qu Wenruo (6):
      btrfs: scrub: improve tree block error reporting
      btrfs: sysfs: update fs features directory asynchronously
      btrfs: raid56: reduce overhead to calculate the bio length
      btrfs: remove stripe boundary calculation for buffered I/O
      btrfs: remove stripe boundary calculation for compressed I/O
      btrfs: remove stripe boundary calculation for encoded I/O

Thomas Weißschuh (1):
      btrfs: make kobj_type structures constant

Yushan Zhou (1):
      btrfs: use PAGE_{ALIGN, ALIGNED, ALIGN_DOWN} macro

ye xingchen (1):
      btrfs: remove duplicate include header in extent-tree.c

 block/blk-merge.c                 |   3 +-
 fs/btrfs/Makefile                 |   6 +-
 fs/btrfs/backref.c                |  33 +-
 fs/btrfs/bio.c                    | 557 +++++++++++++++++++++++++++----
 fs/btrfs/bio.h                    |  67 +---
 fs/btrfs/block-group.c            | 273 +++++++++++++--
 fs/btrfs/block-group.h            |  24 +-
 fs/btrfs/btrfs_inode.h            |  22 +-
 fs/btrfs/compression.c            | 276 +++------------
 fs/btrfs/compression.h            |   3 -
 fs/btrfs/ctree.c                  |  62 ++--
 fs/btrfs/ctree.h                  |  15 +
 fs/btrfs/defrag.c                 |   4 +-
 fs/btrfs/delayed-ref.c            |  24 +-
 fs/btrfs/delayed-ref.h            |   2 +-
 fs/btrfs/discard.c                |  41 ++-
 fs/btrfs/disk-io.c                | 225 ++-----------
 fs/btrfs/disk-io.h                |  14 +-
 fs/btrfs/extent-io-tree.c         |  10 +-
 fs/btrfs/extent-io-tree.h         |   1 -
 fs/btrfs/extent-tree.c            | 181 +++-------
 fs/btrfs/extent-tree.h            |  81 +++++
 fs/btrfs/extent_io.c              | 582 ++++----------------------------
 fs/btrfs/extent_io.h              |  36 +-
 fs/btrfs/file-item.c              |  72 ++--
 fs/btrfs/file-item.h              |   8 +-
 fs/btrfs/file.c                   |   2 +-
 fs/btrfs/free-space-tree.c        |   2 +-
 fs/btrfs/fs.c                     |   4 +
 fs/btrfs/fs.h                     |  11 +-
 fs/btrfs/inode.c                  | 641 +++++------------------------------
 fs/btrfs/ioctl.c                  |   2 +-
 fs/btrfs/lru_cache.c              | 166 +++++++++
 fs/btrfs/lru_cache.h              |  80 +++++
 fs/btrfs/lzo.c                    |   2 +-
 fs/btrfs/messages.c               |  30 --
 fs/btrfs/messages.h               |  34 --
 fs/btrfs/ordered-data.c           |  25 +-
 fs/btrfs/ordered-data.h           |   3 +-
 fs/btrfs/qgroup.c                 |   2 +-
 fs/btrfs/raid56.c                 | 334 +++++++------------
 fs/btrfs/raid56.h                 |   4 +-
 fs/btrfs/relocation.c             |   2 +-
 fs/btrfs/scrub.c                  |  51 ++-
 fs/btrfs/send.c                   | 684 ++++++++++++++++++++------------------
 fs/btrfs/super.c                  |   3 +-
 fs/btrfs/sysfs.c                  |  41 +--
 fs/btrfs/sysfs.h                  |   3 +-
 fs/btrfs/tests/extent-map-tests.c |   2 +-
 fs/btrfs/transaction.c            |  34 ++
 fs/btrfs/transaction.h            |  31 ++
 fs/btrfs/tree-log.c               |  87 ++---
 fs/btrfs/tree-log.h               |   9 +-
 fs/btrfs/volumes.c                | 116 ++-----
 fs/btrfs/volumes.h                |  18 -
 fs/btrfs/zoned.c                  | 146 ++++----
 fs/btrfs/zoned.h                  |  20 +-
 fs/iomap/direct-io.c              |  10 +-
 include/linux/bio.h               |   4 +
 include/linux/iomap.h             |   3 +-
 include/trace/events/btrfs.h      | 127 +++++--
 61 files changed, 2457 insertions(+), 2898 deletions(-)
 create mode 100644 fs/btrfs/lru_cache.c
 create mode 100644 fs/btrfs/lru_cache.h
