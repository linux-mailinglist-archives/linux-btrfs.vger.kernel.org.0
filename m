Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28678B6B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjH1RsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjH1Rrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 13:47:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BEEE;
        Mon, 28 Aug 2023 10:47:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0619A1F37E;
        Mon, 28 Aug 2023 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693244852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x1KcSaCuJS1wX6OggZuTb1whEVcSggKJ9PLr7vA7hGM=;
        b=d7OQ+lAWQJNq6DIlz+FQiHTUXPD/btUv6VDF6aZoh3ymbm8pi08b1oCmj26yA48+qZhgGU
        wdOpmnf6qvYePJ2c0DDQOd4Nq/AdSsKHnhPw/l/UytP9VtKu6SzMzO7LFmOsOQmsgPfwCT
        uNcH+i73A14I6ovMHljUPGhXm0h8HQg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F09002C142;
        Mon, 28 Aug 2023 17:47:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E463BDA867; Mon, 28 Aug 2023 19:40:57 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.6
Date:   Mon, 28 Aug 2023 19:40:40 +0200
Message-ID: <cover.1693225246.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are no new features, the bulk of the changes are fixes,
refactoring and cleanups. The notable fix is the scrub performance
restoration after rewrite in 6.4, though still only partial.

There's one change to mm/, removing prototype of folio_account_redirty().

Please pull, thanks.

User visible changes:

- sysfs, export if ACLs have been built in (CONFIG_BTRFS_FS_POSIX_ACL)

- print name and pid when device scanning processes race

Fixes:

- scrub performance drop due to rewrite in 6.4 partially restored
  - do IO grouping by blg_plug/blk_unplug again
  - avoid unnecessary tree searches when processing stripes, in extent
    and checksum trees
  - the drop is noticeable on fast PCIe devices, -66% and restored to
    -33% of the original
  - backports to 6.4 planned

- handle more corner cases of transaction commit during orphan cleanup
  or delayed ref processing

- use correct fsid/metadata_uuid when validating super block

- copy directory permissions and time when creating a stub subvolume

Core:

- debugging feature integrity checker deprecated, to be removed in 6.7

- in zoned mode, zones are activated just before the write, making error
  handling easier, now the overcommit mechanism can be enabled again
  which improves performance by avoiding more frequent flushing

- v0 extent handling completely removed, deprecated long time ago

- error handling improvements

- tests
  - extent buffer bitmap tests
  - pinned extent splitting tests

- cleanups and refactoring
  - compression writeback
  - extent buffer bitmap
  - space flushing, ENOSPC handling

----------------------------------------------------------------
The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-tag

for you to fetch changes up to c02d35d89b317994bd713ba82e160c5e7f22d9c8:

  btrfs: zoned: skip splitting and logical rewriting on pre-alloc write (2023-08-22 14:19:59 +0200)

----------------------------------------------------------------
Anand Jain (7):
      btrfs: sysfs: show if ACL support has been compiled in
      btrfs: print name and pid when device scanning processes race
      btrfs: add a helper to read the superblock metadata_uuid
      btrfs: simplify memcpy either of metadata_uuid or fsid
      btrfs: use the correct superblock to compare fsid in btrfs_validate_super
      btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super
      btrfs: drop redundant check to use fs_devices::metadata_uuid

Boris Burkov (2):
      btrfs: free qgroup rsv on io failure
      btrfs: fix start transaction qgroup rsv double free

Christoph Hellwig (28):
      btrfs: simplify the no-bioc fast path condition in btrfs_map_block
      btrfs: pass a flags argument to cow_file_range
      btrfs: don't create inline extents in fallback_to_cow
      btrfs: split page locking out of __process_pages_contig
      btrfs: remove btrfs_writepage_endio_finish_ordered
      btrfs: remove end_extent_writepage
      btrfs: reduce debug spam from submit_compressed_extents
      btrfs: remove the return value from submit_uncompressed_range
      btrfs: remove the return value from extent_write_locked_range
      btrfs: improve the delalloc_to_write calculation in writepage_delalloc
      btrfs: reduce the number of arguments to btrfs_run_delalloc_range
      btrfs: clean up the check for uncompressed ranges in submit_one_async_extent
      btrfs: don't clear async_chunk->inode in async_cow_start
      btrfs: merge async_cow_start and compress_file_range
      btrfs: merge submit_compressed_extents and async_cow_submit
      btrfs: streamline compress_file_range
      btrfs: further simplify the compress or not logic in compress_file_range
      btrfs: use a separate label for the incompressible case in compress_file_range
      btrfs: share the code to free the page array in compress_file_range
      btrfs: don't redirty pages in compress_file_range
      btrfs: refactor the zoned device handling in cow_file_range
      btrfs: don't redirty locked_page in run_delalloc_zoned
      btrfs: fix zoned handling in submit_uncompressed_range
      mm: remove folio_account_redirty
      btrfs: fix error handling when in a COW window in run_delalloc_nocow
      btrfs: cleanup the COW fallback logic in run_delalloc_nocow
      btrfs: consolidate the error handling in run_delalloc_nocow
      btrfs: move the !zoned assert into run_delalloc_cow

Colin Ian King (2):
      btrfs: scrub: remove redundant division of stripe_nr
      btrfs: remove redundant initialization of variables in log_new_ancestors

David Sterba (1):
      btrfs: use helper sizeof_field in struct accessors

Filipe Manana (25):
      btrfs: update documentation for add_new_free_space()
      btrfs: rename add_new_free_space() to btrfs_add_new_free_space()
      btrfs: make btrfs_destroy_marked_extents() return void
      btrfs: make btrfs_destroy_pinned_extent() return void
      btrfs: make find_first_extent_bit() return a boolean
      btrfs: open code trivial btrfs_add_excluded_extent()
      btrfs: move btrfs_free_excluded_extents() into block-group.c
      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
      btrfs: update comment for btrfs_join_transaction_nostart()
      btrfs: print target number of bytes when dumping free space
      btrfs: print block group super and delalloc bytes when dumping space info
      btrfs: print available space for a block group when dumping a space info
      btrfs: print available space across all block groups when dumping space info
      btrfs: don't steal space from global rsv after a transaction abort
      btrfs: store the error that turned the fs into error state
      btrfs: return real error when orphan cleanup fails due to a transaction abort
      btrfs: fail priority metadata ticket with real fs error
      btrfs: make btrfs_cleanup_fs_roots() static
      btrfs: make find_free_dev_extent() static
      btrfs: merge find_free_dev_extent() and find_free_dev_extent_start()
      btrfs: avoid starting new transaction when flushing delayed items and refs
      btrfs: avoid starting and committing empty transaction when flushing space
      btrfs: avoid start and commit empty transaction when starting qgroup rescan
      btrfs: avoid start and commit empty transaction when flushing qgroups
      btrfs: remove pointless empty list check when reading delayed dir indexes

Goldwyn Rodrigues (1):
      btrfs: remove duplicate free_async_extent_pages() on reservation error

Josef Bacik (6):
      btrfs: move comments to btrfs_loop_type definition
      btrfs: wait on uncached block groups on every allocation loop
      btrfs: set page extent mapped after read_folio in relocate_one_page
      btrfs: tests: add extent_map tests for dropping with odd layouts
      btrfs: tests: add a test for btrfs_add_extent_mapping
      btrfs: tests: test invalid splitting when skipping pinned drop extent_map

Julia Lawall (1):
      btrfs: zoned: use vcalloc instead of for vzalloc in btrfs_get_dev_zone_info

Lee Trager (1):
      btrfs: copy dir permission and time when creating a stub subvolume

Minjie Du (1):
      btrfs: use folio_next_index() helper in extent_write_cache_pages

Naohiro Aota (12):
      btrfs: introduce struct to consolidate extent buffer write context
      btrfs: zoned: introduce block group context to btrfs_eb_write_context
      btrfs: zoned: return int from btrfs_check_meta_write_pointer
      btrfs: zoned: defer advancing meta write pointer
      btrfs: zoned: update meta write pointer on zone finish
      btrfs: zoned: reserve zones for an active metadata/system block group
      btrfs: zoned: activate metadata block group on write time
      btrfs: zoned: no longer count fresh BG region as zone unusable
      btrfs: zoned: don't activate non-DATA BG on allocation
      btrfs: zoned: re-enable metadata over-commit for zoned mode
      btrfs: zoned: do not zone finish data relocation block group
      btrfs: zoned: skip splitting and logical rewriting on pre-alloc write

Qu Wenruo (22):
      btrfs: add comments for btrfs_map_block()
      btrfs: raid56: remove unused BTRFS_RBIO_REBUILD_MISSING
      btrfs: tracepoints: simplify raid56 events
      btrfs: deprecate integrity checker feature
      btrfs: scrub: remove unused btrfs_path in scrub_simple_mirror()
      btrfs: move eb subpage preallocation out of the loop
      btrfs: tests: enhance extent buffer bitmap tests
      btrfs: tests: add self tests for extent buffer memory operations
      btrfs: refactor extent buffer bitmaps operations
      btrfs: use write_extent_buffer() to implement write_extent_buffer_*id()
      btrfs: refactor main loop in copy_extent_buffer_full()
      btrfs: copy all pages at once at the end of btrfs_clone_extent_buffer()
      btrfs: refactor main loop in memcpy_extent_buffer()
      btrfs: refactor main loop in memmove_extent_buffer()
      btrfs: handle errors properly in update_inline_extent_backref()
      btrfs: output extra debug info if we failed to find an inline backref
      btrfs: remove v0 extent handling
      btrfs: scrub: avoid unnecessary extent tree search preparing stripes
      btrfs: scrub: avoid unnecessary csum tree search preparing stripes
      btrfs: scrub: fix grouping of read IO
      btrfs: scrub: don't go ordered workqueue for dev-replace
      btrfs: scrub: move write back of repaired sectors to scrub_stripe_read_repair_worker()

Ruan Jinjie (1):
      btrfs: use LIST_HEAD() to initialize the list_head

 fs/btrfs/Kconfig                  |   4 +-
 fs/btrfs/accessors.h              |  23 +-
 fs/btrfs/backref.c                |  29 +-
 fs/btrfs/block-group.c            |  73 ++--
 fs/btrfs/block-group.h            |   4 +-
 fs/btrfs/btrfs_inode.h            |   6 +-
 fs/btrfs/delayed-inode.c          |   3 -
 fs/btrfs/dev-replace.c            |   6 +-
 fs/btrfs/disk-io.c                | 177 ++++-----
 fs/btrfs/disk-io.h                |   1 -
 fs/btrfs/extent-io-tree.c         |  14 +-
 fs/btrfs/extent-io-tree.h         |   6 +-
 fs/btrfs/extent-tree.c            | 290 ++++++++------
 fs/btrfs/extent-tree.h            |  16 +-
 fs/btrfs/extent_io.c              | 684 +++++++++++++--------------------
 fs/btrfs/extent_io.h              |  35 +-
 fs/btrfs/file-item.c              |  34 +-
 fs/btrfs/file-item.h              |   6 +-
 fs/btrfs/file.c                   |   3 +-
 fs/btrfs/free-space-cache.c       |  18 +-
 fs/btrfs/free-space-tree.c        |  13 +-
 fs/btrfs/fs.h                     |  15 +-
 fs/btrfs/inode.c                  | 790 +++++++++++++++-----------------------
 fs/btrfs/messages.c               |  16 +-
 fs/btrfs/messages.h               |   2 -
 fs/btrfs/ordered-data.c           |   8 +-
 fs/btrfs/print-tree.c             |  10 +-
 fs/btrfs/qgroup.c                 |  19 +-
 fs/btrfs/raid56.c                 |  29 +-
 fs/btrfs/raid56.h                 |   1 -
 fs/btrfs/relocation.c             |  33 +-
 fs/btrfs/scrub.c                  | 240 +++++++-----
 fs/btrfs/send.c                   |   6 +-
 fs/btrfs/space-info.c             |  85 ++--
 fs/btrfs/super.c                  |   6 +
 fs/btrfs/sysfs.c                  |   7 +
 fs/btrfs/tests/extent-io-tests.c  | 306 ++++++++++++---
 fs/btrfs/tests/extent-map-tests.c | 412 ++++++++++++++++++++
 fs/btrfs/transaction.c            |  39 +-
 fs/btrfs/tree-log.c               |   8 +-
 fs/btrfs/volumes.c                |  94 +++--
 fs/btrfs/volumes.h                |   3 +-
 fs/btrfs/zoned.c                  | 292 +++++++++++---
 fs/btrfs/zoned.h                  |  28 +-
 include/linux/writeback.h         |   5 -
 include/trace/events/btrfs.h      |  30 +-
 include/uapi/linux/btrfs_tree.h   |   6 +-
 mm/page-writeback.c               |  49 +--
 48 files changed, 2289 insertions(+), 1695 deletions(-)
