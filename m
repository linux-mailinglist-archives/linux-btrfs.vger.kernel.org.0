Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4030B6EE446
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Apr 2023 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjDYOvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Apr 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjDYOvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Apr 2023 10:51:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02D189;
        Tue, 25 Apr 2023 07:51:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 485CF21994;
        Tue, 25 Apr 2023 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682434296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ooAyF9pS62NXBvcqS9VCxUkPrUWAa9g2Snay2e75hgI=;
        b=enNtfXP/ipX2ABlj48YWS3Km9xgR053P5UqwUy5hV+LW7O+fWZ9qTBAleDWMR8uvMj9MrR
        kfQlKDY62aixrOfuMqSgsBAAoVto4tLF3MW8AANKSNlq8Q/WmRcR/OiCHdRtoTaxr2oyXR
        O5vny4s0Ib6o62tHtX1UGvIIqdf0tM0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 33A1D2C141;
        Tue, 25 Apr 2023 14:51:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F29BDA8D8; Tue, 25 Apr 2023 16:51:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.4
Date:   Tue, 25 Apr 2023 16:51:23 +0200
Message-Id: <cover.1682378675.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are mostly core changes and cleanups, some notable fixes and two
performance improvements in directory logging. The IO path cleanups are
removing or refactoring old code, scrub main loop has been completely
rewritten also refactoring old code.

There are some changes to non-btrfs code, mostly trivial, the cgroup
punt bio logic is only moved from generic code.

Please pull, thanks.

Performance improvements:

- improve logging changes in a directory during one transaction, avoid
  iterating over items and reduce lock contention (fsync time 4x lower)

- when logging directory entries during one transaction, reduce locking
  of subvolume trees by checking tree-log instead (improvement in
  throughput and latency for concurrent access to a subvolume)

Notable fixes:

- dev-replace
  - properly honor read mode when requested to avoid reading from source
    device
  - target device won't be used for eventual read repair, this is
    unreliable for NODATASUM files
  - when there are unpaired (and unrepairable) metadata during replace,
    exit early with error and don't try to finish whole operation

- scrub ioctl properly rejects unknown flags

- fix global block reserve calculations

- fix partial direct io write when there's a page fault in the middle,
  iomap will try to continue with partial request but the btrfs part did
  not match that, this can lead to zeros written instead of data

Core changes:

- io path
  - continued cleanups and refactoring around bio handling
  - extent io submit path simplifications and cleanups
  - flush write path simplifications and cleanups
  - rework logic of passing sync mode of bio, with further cleanups

- rewrite scrub code flow, restructure how the stripes are enumerated
  and verified in a more unified way

- allow to set lower threshold for block group reclaim in debug mode to
  aid zoned mode testing

- remove obsolete time-based delayed ref throttling logic when
  truncating items

- DREW locks are not using percpu variables anymore

- more warning fixes (-Wmaybe-uninitialized)

- u64 division simplifications

- error handling improvements

Non-btrfs code changes:

- push cgroup punt bio logic to btrfs code (there was no other user of
  that), the functionality can be now selected separately by
  BLK_CGROUP_PUNT_BIO

- crc32c_impl removed after removing last uses in btrfs code

- add btrfs_assertfail() to objtool table

----------------------------------------------------------------
The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-tag

for you to fetch changes up to f372463124df5f980de6ee0cd6000a3e43df0e01:

  btrfs: mark btrfs_assertfail() __noreturn (2023-04-17 19:52:19 +0200)

----------------------------------------------------------------
Anand Jain (11):
      btrfs: avoid reusing return variable in nested block in btrfs_lookup_bio_sums
      btrfs: switch search_file_offset_in_bio to return bool
      btrfs: open code btrfs_bin_search()
      btrfs: avoid repetitive define BTRFS_FEATURE_INCOMPAT_SUPP
      btrfs: remove redundant clearing of NODISCARD
      btrfs: move last_flush_error to write_dev_flush and wait_dev_flush
      btrfs: open code check_barrier_error()
      btrfs: change wait_dev_flush() return type to bool
      btrfs: use test_and_clear_bit() in wait_dev_flush()
      btrfs: warn for any missed cleanup at btrfs_close_one_device
      btrfs: remove redundant release of btrfs_device::alloc_state

Boris Burkov (7):
      btrfs: add function to create and return an ordered extent
      btrfs: pass flags as unsigned long to btrfs_add_ordered_extent
      btrfs: stash ordered extent in dio_data during iomap dio
      btrfs: don't split NOCOW extent_maps in btrfs_extract_ordered_extent
      btrfs: split partial dio bios before submit
      btrfs: set default discard iops_limit to 1000
      btrfs: reinterpret async discard iops_limit=0 as no delay

Christoph Hellwig (52):
      btrfs: raid56: no need for irqsafe locking
      btrfs: move all btree inode initialization into btrfs_init_btree_inode
      btrfs: embed a btrfs_bio into struct compressed_bio
      btrfs: remove redundant free_extent_map in btrfs_submit_compressed_read
      btrfs: use the bbio file offset in btrfs_submit_compressed_read
      btrfs: use the bbio file offset in add_ra_bio_pages
      btrfs: factor out a btrfs_add_compressed_bio_pages helper
      btrfs: factor out a btrfs_free_compressed_pages helper
      btrfs: don't clear page->mapping in btrfs_free_compressed_pages
      btrfs: fold finish_compressed_bio_write into btrfs_finish_compressed_write_work
      btrfs: don't set force_bio_submit in read_extent_buffer_subpage
      btrfs: remove the force_bio_submit to submit_extent_page
      btrfs: store the bio opf in struct btrfs_bio_ctrl
      btrfs: remove the sync_io flag in struct btrfs_bio_ctrl
      btrfs: add a wbc pointer to struct btrfs_bio_ctrl
      btrfs: move the compress_type check out of btrfs_bio_add_page
      btrfs: rename the this_bio_flag variable in btrfs_do_readpage
      btrfs: remove the compress_type argument to submit_extent_page
      btrfs: remove the submit_extent_page return value
      btrfs: simplify the error handling in __extent_writepage_io
      btrfs: check for contiguity in submit_extent_page
      btrfs: simplify main loop in submit_extent_page
      btrfs: remove search_file_offset_in_bio
      btrfs: cleanup the main loop in btrfs_lookup_bio_sums
      btrfs: remove unused members from struct btrfs_encoded_read_private
      btrfs: cleanup main loop in btrfs_encoded_read_regular_fill_pages
      btrfs: move zero filling of compressed read bios into common code
      btrfs: pass a btrfs_bio to btrfs_submit_bio
      btrfs: pass a btrfs_bio to btrfs_submit_compressed_read
      btrfs: store a pointer to the original btrfs_bio in struct compressed_bio
      btrfs: simplify finding the inode in submit_one_bio
      btrfs: store a pointer to a btrfs_bio in struct btrfs_bio_ctrl
      btrfs: return a btrfs_bio from btrfs_bio_alloc
      btrfs: make btrfs_split_bio work on struct btrfs_bio
      btrfs: move the bi_sector assignment out of btrfs_add_compressed_bio_pages
      btrfs: simplify adding pages in btrfs_add_compressed_bio_pages
      btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent
      btrfs: simplify splitting logic in btrfs_extract_ordered_extent
      btrfs: sink parameter len to btrfs_split_ordered_extent
      btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent
      btrfs: simplify extent map splitting and rename split_zoned_em
      btrfs: pass an ordered_extent to btrfs_extract_ordered_extent
      btrfs: move kthread_associate_blkcg out of btrfs_submit_compressed_write
      btrfs: don't free the async_extent in submit_uncompressed_range
      btrfs: also use kthread_associate_blkcg for uncompressible ranges
      btrfs, mm: remove the punt_to_cgroup field in struct writeback_control
      btrfs, block: move REQ_CGROUP_PUNT to btrfs
      block: async_bio_lock does not need to be bh-safe
      block: make blkcg_punt_bio_submit optional
      btrfs: tree-log: factor out a clean_log_buffer helper
      btrfs: don't print the crc32c implementation at module load time
      libcrc32c: remove crc32c_impl

David Sterba (1):
      btrfs: locking: use atomic for DREW lock writers

Filipe Manana (30):
      btrfs: remove btrfs_lru_cache_is_full() inline function
      btrfs: pass a bool to btrfs_block_rsv_migrate() at evict_refill_and_join()
      btrfs: pass a bool size update argument to btrfs_block_rsv_add_bytes()
      btrfs: remove check for NULL block reserve at btrfs_block_rsv_check()
      btrfs: update documentation for BTRFS_RESERVE_FLUSH_EVICT flush method
      btrfs: update flush method assertion when reserving space
      btrfs: initialize ret to -ENOSPC at __reserve_bytes()
      btrfs: simplify btrfs_should_throttle_delayed_refs()
      btrfs: collapse should_end_transaction() into btrfs_should_end_transaction()
      btrfs: remove bytes_used argument from btrfs_make_block_group()
      btrfs: count extents before taking inode's spinlock when reserving metadata
      btrfs: remove redundant counter check at btrfs_truncate_inode_items()
      btrfs: simplify variables in btrfs_block_rsv_refill()
      btrfs: remove obsolete delayed ref throttling logic when truncating items
      btrfs: don't throttle on delayed items when evicting deleted inode
      btrfs: calculate the right space for a single delayed ref when refilling
      btrfs: accurately calculate number of delayed refs when flushing
      btrfs: constify fs_info argument of the metadata size calculation helpers
      btrfs: constify fs_info argument for the reclaim items calculation helpers
      btrfs: add helper to calculate space for delayed references
      btrfs: calculate correct amount of space for delayed reference when evicting
      btrfs: fix calculation of the global block reserve's size
      btrfs: use a constant for the number of metadata units needed for an unlink
      btrfs: calculate the right space for delayed refs when updating global reserve
      btrfs: simplify exit paths of btrfs_evict_inode()
      btrfs: make btrfs_block_rsv_full() check more boolean when starting transaction
      btrfs: correctly calculate delayed ref bytes when starting transaction
      btrfs: remove pointless loop at btrfs_get_next_valid_item()
      btrfs: avoid iterating over all indexes when logging directory
      btrfs: use log root when iterating over index keys when logging directory

Genjian Zhang (1):
      btrfs: fix uninitialized variable warnings

Johannes Thumshirn (4):
      btrfs: open code btrfs_csum_ptr
      btrfs: sink calc_bio_boundaries into its only caller
      btrfs: use __bio_add_page for adding a single page in repair_one_sector
      btrfs: use __bio_add_page to add single a page in rbio_add_io_sector

Josef Bacik (7):
      btrfs: use btrfs_handle_fs_error in btrfs_fill_super
      btrfs: replace BUG_ON with ASSERT in btrfs_read_node_slot
      btrfs: handle errors from btrfs_read_node_slot in split
      btrfs: add missing iputs on orphan cleanup failure
      btrfs: drop root refs properly when orphan cleanup fails
      btrfs: handle errors in walk_down_tree properly
      btrfs: abort the transaction if we get an error during snapshot drop

Josh Poimboeuf (1):
      btrfs: mark btrfs_assertfail() __noreturn

Naohiro Aota (1):
      btrfs: sysfs: relax bg_reclaim_threshold for debugging purposes

Qu Wenruo (32):
      btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN
      btrfs: reduce div64 calls by limiting the number of stripes of a chunk to u32
      btrfs: simplify the bioc argument for handle_ops_on_dev_replace()
      btrfs: reduce type width of btrfs_io_contexts
      btrfs: use an efficient way to represent source of duplicated stripes
      btrfs: replace btrfs_io_context::raid_map with a fixed u64 value
      btrfs: dev-replace: properly follow its read mode
      btrfs: open_ctree() error handling cleanup
      btrfs: do not use replace target device as an extra mirror
      btrfs: scrub: remove unused path inside scrub_stripe()
      btrfs: scrub: remove root and csum_root arguments from scrub_simple_mirror()
      btrfs: scrub: use dedicated super block verification function to scrub one super block
      btrfs: introduce btrfs_bio::fs_info member
      btrfs: introduce a new helper to submit write bio for repair
      btrfs: scrub: introduce structure for new BTRFS_STRIPE_LEN based interface
      btrfs: scrub: introduce helper to find and fill sector info for a scrub_stripe
      btrfs: scrub: introduce a helper to verify one metadata block
      btrfs: scrub: introduce a helper to verify one scrub_stripe
      btrfs: scrub: introduce the main read repair worker for scrub_stripe
      btrfs: scrub: introduce a writeback helper for scrub_stripe
      btrfs: scrub: introduce error reporting functionality for scrub_stripe
      btrfs: scrub: introduce helper to queue a stripe for scrub
      btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure
      btrfs: scrub: use scrub_stripe to implement RAID56 P/Q scrub
      btrfs: scrub: remove scrub_parity structure
      btrfs: scrub: remove the old writeback infrastructure
      btrfs: scrub: remove the old scrub recheck code
      btrfs: scrub: remove scrub_block and scrub_sector structures
      btrfs: scrub: remove scrub_bio structure
      btrfs: remove unused raid56 functions which were dedicated for scrub
      btrfs: scrub: reject unsupported scrub flags
      btrfs: dev-replace: error out if we have unrepaired metadata error during

 block/Kconfig                     |    3 +
 block/blk-cgroup.c                |   78 +-
 block/blk-cgroup.h                |   15 +-
 block/blk-core.c                  |    3 -
 fs/btrfs/Kconfig                  |    1 +
 fs/btrfs/bio.c                    |  211 +-
 fs/btrfs/bio.h                    |   22 +-
 fs/btrfs/block-group.c            |   40 +-
 fs/btrfs/block-group.h            |   13 +-
 fs/btrfs/block-rsv.c              |   21 +-
 fs/btrfs/block-rsv.h              |    2 +-
 fs/btrfs/btrfs_inode.h            |   35 +-
 fs/btrfs/compression.c            |  299 +--
 fs/btrfs/compression.h            |   20 +-
 fs/btrfs/ctree.c                  |   91 +-
 fs/btrfs/ctree.h                  |   17 +-
 fs/btrfs/delalloc-space.c         |    2 +-
 fs/btrfs/delayed-ref.c            |   49 +-
 fs/btrfs/delayed-ref.h            |   22 +-
 fs/btrfs/discard.c                |   21 +-
 fs/btrfs/disk-io.c                |  147 +-
 fs/btrfs/extent-tree.c            |   37 +-
 fs/btrfs/extent_io.c              |  550 ++---
 fs/btrfs/file-item.c              |   93 +-
 fs/btrfs/file-item.h              |    3 +-
 fs/btrfs/fs.h                     |   53 +-
 fs/btrfs/inode-item.c             |   15 +-
 fs/btrfs/inode.c                  |  375 ++--
 fs/btrfs/ioctl.c                  |    5 +
 fs/btrfs/locking.c                |   25 +-
 fs/btrfs/locking.h                |    5 +-
 fs/btrfs/lru_cache.h              |    5 -
 fs/btrfs/lzo.c                    |   17 +-
 fs/btrfs/messages.c               |    2 +-
 fs/btrfs/messages.h               |    2 +-
 fs/btrfs/ordered-data.c           |  120 +-
 fs/btrfs/ordered-data.h           |   10 +-
 fs/btrfs/raid56.c                 |  162 +-
 fs/btrfs/raid56.h                 |   12 +-
 fs/btrfs/relocation.c             |    6 +-
 fs/btrfs/scrub.c                  | 4142 ++++++++++++-------------------------
 fs/btrfs/send.c                   |    2 +-
 fs/btrfs/space-info.c             |   32 +-
 fs/btrfs/space-info.h             |    1 +
 fs/btrfs/super.c                  |    3 +-
 fs/btrfs/sysfs.c                  |    5 +
 fs/btrfs/tests/extent-map-tests.c |    1 -
 fs/btrfs/transaction.c            |   28 +-
 fs/btrfs/tree-checker.c           |   14 +
 fs/btrfs/tree-log.c               |  171 +-
 fs/btrfs/volumes.c                |  593 +++---
 fs/btrfs/volumes.h                |   85 +-
 fs/btrfs/zlib.c                   |    2 -
 fs/btrfs/zoned.c                  |    4 +-
 fs/btrfs/zstd.c                   |    1 -
 include/linux/bio.h               |    5 +
 include/linux/blk_types.h         |   18 +-
 include/linux/crc32c.h            |    1 -
 include/linux/writeback.h         |    5 -
 include/trace/events/btrfs.h      |    2 +-
 include/uapi/linux/btrfs.h        |    1 +
 lib/libcrc32c.c                   |    6 -
 tools/objtool/check.c             |    1 +
 63 files changed, 2880 insertions(+), 4852 deletions(-)
