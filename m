Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978D731CACA
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 14:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBPM7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 07:59:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:40628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhBPM7a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 07:59:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613480325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UoD8rh+gc1UbpxvVrLTfINayk37x4IFsN3LfqlkFkuo=;
        b=dGDbqTVsu1AfgxoA8u2wxCmlVp8ylkOZ+T5hrOgGpz0JX0hWHpm0NDq/JlN9FLSa6trNZm
        TEt7XDBXpBqSXw6Dfu8W46KNqk3khi0Uo5QPm0Usp7Pl/Uiau+qCVws93nyT8SpuJv+8dL
        yAWhTPLk62qnFV7rnrL+AOykBZJdx0I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6925CACBF;
        Tue, 16 Feb 2021 12:58:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 581EADA6EF; Tue, 16 Feb 2021 13:56:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.12
Date:   Tue, 16 Feb 2021 13:56:46 +0100
Message-Id: <cover.1613417746.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this update brings updates of space handling, performance improvements
or bug fixes. The subpage block size and zoned mode features have
reached state where they're usable but with limitations.

The branch merges cleanly on top of current master, there are some minor
conflicts reported by linux-next in iov_iter or kmap conversion.

Please pull, thanks.

- Performance or related

  - do not block on deleted block group mutex in the cleaner, avoids
    some long stalls

  - improved flushing: make it work better with ticket space
    reservations and avoid excessive transaction commits in some
    scenarios, slightly improves throughput for random write load

  - preemptive background flushing: separate the logic from ticket
    reservations, improve the accounting and decisions when to flush in
    low space conditions

  - less lock contention related to running delayed refs, let just one
    thread do the flushing when there are many inside transaction commit

  - dbench workload improvements: avoid unnecessary work when logging
    inodes, fewer fallbacks to transaction commit and thus less waiting
    for it (+7% throughput, -20% latency)

- Core

  - subpage block size
    - currently read-only support
    - refactor and generalize code where sectorsize is assumed to be
      page size, add the subpage handling everywhere
    - the read-write support is on the way, page sizes are still limited
      to 4K or 64K

  - zoned mode, first working version but with limitations
    - SMR/ZBC/ZNS friendly allocation mode, utilizing the "no fixed
      location for structures" and chunked allocation
    - superblock as the only fixed data structure needs special
      handling, uses 2 consecutive zones as a ring buffer
    - tree-log support with a dedicated block group to avoid unordered
      writes
    - emulated zones on non-zoned devices
    - not yet working
      - all non-single block group profiles, requires more
	zone write pointer synchronization between the multiple block
	groups
      - fitrim due to dependency on space cache, can be implemented

- Fixes

  - ref-verify: proper tree owner and node level tracking
  - fix pinned byte accounting, causing some early ENOSPC now more
    likely due to other changes in delayed refs

- Other

  - error handling fixes and improvements
  - more error injection points
  - more function documentation
  - more and updated tracepoints
  - subset of W=1 checked by default
  - update comments to allow more automatic kdoc parameter checks

----------------------------------------------------------------
The following changes since commit e0756cfc7d7cd08c98a53b6009c091a3f6a50be6:

  Merge tag 'trace-v5.11-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2021-02-08 11:32:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-tag

for you to fetch changes up to 9d294a685fbcb256ce8c5f7fd88a7596d0f52a8a:

  btrfs: zoned: enable to mount ZONED incompat flag (2021-02-09 02:52:24 +0100)

----------------------------------------------------------------
Abaci Team (1):
      btrfs: simplify condition in __btrfs_run_delayed_items

Filipe Manana (10):
      btrfs: send: remove stale code when checking for shared extents
      btrfs: remove wrong comment for can_nocow_extent()
      btrfs: remove unnecessary directory inode item update when deleting dir entry
      btrfs: stop setting nbytes when filling inode item for logging
      btrfs: avoid logging new ancestor inodes when logging new inode
      btrfs: skip logging directories already logged when logging all parents
      btrfs: skip logging inodes already logged when logging new entries
      btrfs: remove unnecessary check_parent_dirs_for_sync()
      btrfs: make concurrent fsyncs wait less when waiting for a transaction commit
      btrfs: fix extent buffer leak on failure to copy root

Johannes Thumshirn (7):
      block: add bio_add_zone_append_page
      btrfs: release path before calling to btrfs_load_block_group_zone_info
      btrfs: zoned: do not load fs_info::zoned from incompat flag
      btrfs: zoned: allow zoned filesystems on non-zoned block devices
      btrfs: zoned: check if bio spans across an ordered extent
      btrfs: zoned: cache if block group is on a sequential zone
      btrfs: save irq flags when looking up an ordered extent

Josef Bacik (34):
      btrfs: fix error handling in commit_fs_roots
      btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
      btrfs: noinline btrfs_should_cancel_balance
      btrfs: ref-verify: pass down tree block level when building refs
      btrfs: ref-verify: make sure owner is set for all refs
      btrfs: keep track of the root owner for relocation reads
      btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
      btrfs: handle space_info::total_bytes_pinned inside the delayed ref itself
      btrfs: account for new extents being deleted in total_bytes_pinned
      btrfs: fix reloc root leak with 0 ref reloc roots on recovery
      btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
      btrfs: do not warn if we can't find the reloc root when looking up backref
      btrfs: add asserts for deleting backref cache nodes
      btrfs: abort the transaction if we fail to inc ref in btrfs_copy_root
      btrfs: do not block on deleted bgs mutex in the cleaner
      btrfs: only let one thread pre-flush delayed refs in commit
      btrfs: delayed refs pre-flushing should only run the heads we have
      btrfs: only run delayed refs once before committing
      btrfs: move delayed ref flushing for qgroup into qgroup helper
      btrfs: remove bogus BUG_ON in alloc_reserved_tree_block
      btrfs: stop running all delayed refs during snapshot
      btrfs: run delayed refs less often in commit_cowonly_roots
      btrfs: make flush_space take a enum btrfs_flush_state instead of int
      btrfs: add a trace point for reserve tickets
      btrfs: track ordered bytes instead of just dio ordered bytes
      btrfs: introduce a FORCE_COMMIT_TRANS flush operation
      btrfs: improve preemptive background space flushing
      btrfs: rename need_do_async_reclaim
      btrfs: check reclaim_size in need_preemptive_reclaim
      btrfs: rework btrfs_calc_reclaim_metadata_size
      btrfs: simplify the logic in need_preemptive_flushing
      btrfs: implement space clamping for preemptive flushing
      btrfs: adjust the flush trace point to include the source
      btrfs: add a trace class for dumping the current ENOSPC state

Michal Rostecki (1):
      btrfs: let callers of btrfs_get_io_geometry pass the em

Naohiro Aota (36):
      iomap: support REQ_OP_ZONE_APPEND
      btrfs: zoned: defer loading zone info after opening trees
      btrfs: zoned: use regular super block location on zone emulation
      btrfs: zoned: disallow fitrim on zoned filesystems
      btrfs: zoned: implement zoned chunk allocator
      btrfs: zoned: verify device extent is aligned to zone
      btrfs: zoned: load zone's allocation offset
      btrfs: zoned: calculate allocation offset for conventional zones
      btrfs: zoned: track unusable bytes for zones
      btrfs: zoned: implement sequential extent allocation
      btrfs: zoned: redirty released extent buffers
      btrfs: zoned: advance allocation pointer after tree log node
      btrfs: zoned: reset zones of unused block groups
      btrfs: factor out helper adding a page to bio
      btrfs: zoned: use bio_add_zone_append_page
      btrfs: zoned: handle REQ_OP_ZONE_APPEND as writing
      btrfs: zoned: split ordered extent when bio is sent
      btrfs: extend btrfs_rmap_block for specifying a device
      btrfs: zoned: use ZONE_APPEND write for zoned mode
      btrfs: zoned: enable zone append writing for direct IO
      btrfs: zoned: introduce dedicated data write path for zoned filesystems
      btrfs: zoned: serialize metadata IO
      btrfs: zoned: wait for existing extents before truncating
      btrfs: zoned: do not use async metadata checksum on zoned filesystems
      btrfs: zoned: mark block groups to copy for device-replace
      btrfs: zoned: implement cloning for zoned device-replace
      btrfs: zoned: implement copying for zoned device-replace
      btrfs: zoned: support dev-replace in zoned filesystems
      btrfs: zoned: enable relocation on a zoned filesystem
      btrfs: zoned: relocate block group to repair IO failure in zoned filesystems
      btrfs: split alloc_log_tree()
      btrfs: zoned: extend zoned allocator to use dedicated tree-log block group
      btrfs: zoned: serialize log transaction on zoned filesystems
      btrfs: zoned: reorder log node allocation on zoned filesystem
      btrfs: zoned: deal with holes writing out tree-log pages
      btrfs: zoned: enable to mount ZONED incompat flag

Nigel Christian (1):
      btrfs: remove repeated word in struct member comment

Nikolay Borisov (24):
      btrfs: cleanup local variables in btrfs_file_write_iter
      btrfs: rename btrfs_find_highest_objectid to btrfs_init_root_free_objectid
      btrfs: rename btrfs_find_free_objectid to btrfs_get_free_objectid
      btrfs: rename btrfs_root::highest_objectid to free_objectid
      btrfs: make btrfs_root::free_objectid hold the next available objectid
      btrfs: remove new_dirid argument from btrfs_create_subvol_root
      btrfs: consolidate btrfs_previous_item ret val handling in btrfs_shrink_device
      btrfs: make btrfs_start_delalloc_root's nr argument a long
      btrfs: remove always true condition in btrfs_start_delalloc_roots
      btrfs: document modified parameter of add_extent_mapping
      btrfs: fix parameter description of btrfs_add_extent_mapping
      btrfs: fix function description formats in file-item.c
      btrfs: fix parameter description in delayed-ref.c functions
      btrfs: improve parameter description for __btrfs_write_out_cache
      btrfs: document now parameter of peek_discard_list
      btrfs: document fs_info in btrfs_rmap_block
      btrfs: fix description format of fs_info of btrfs_wait_on_delayed_iputs
      btrfs: document btrfs_check_shared parameters
      btrfs: fix parameter description of btrfs_inode_rsv_release/btrfs_delalloc_release_space
      btrfs: fix parameter description in space-info.c
      btrfs: fix parameter description for functions in extent_io.c
      btrfs: zoned: remove unused variable in btrfs_sb_log_location_bdev
      lib/zstd: convert constants to defines
      btrfs: enable W=1 checks for btrfs

Qu Wenruo (27):
      btrfs: make btrfs_dio_private::bytes u32
      btrfs: refactor btrfs_dec_test_* functions for ordered extents
      btrfs: rename parameter offset to disk_bytenr in submit_extent_page
      btrfs: refactor __extent_writepage_io() to improve readability
      btrfs: update comment for btrfs_dirty_pages
      btrfs: introduce helper to grab an existing extent buffer from a page
      btrfs: rework the order of btrfs_ordered_extent::flags
      btrfs: fix double accounting of ordered extent for subpage case in btrfs_invalidapge
      btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to PAGE_START_WRITEBACK
      btrfs: set UNMAPPED bit early in btrfs_clone_extent_buffer() for subpage support
      btrfs: introduce the skeleton of btrfs_subpage structure
      btrfs: make attach_extent_buffer_page() handle subpage case
      btrfs: make grab_extent_buffer_from_page() handle subpage case
      btrfs: support subpage for extent buffer page release
      btrfs: attach private to dummy extent buffer pages
      btrfs: introduce helpers for subpage uptodate status
      btrfs: introduce helpers for subpage error status
      btrfs: support subpage in set/clear_extent_buffer_uptodate()
      btrfs: support subpage in btrfs_clone_extent_buffer
      btrfs: support subpage in try_release_extent_buffer()
      btrfs: introduce read_extent_buffer_subpage()
      btrfs: support subpage in endio_readpage_update_page_status()
      btrfs: introduce subpage metadata validation check
      btrfs: introduce btrfs_subpage for data inodes
      btrfs: integrate page status update for data read path into begin/end_page_read
      btrfs: allow read-only mount of 4K sector size fs on 64K page system
      btrfs: explain page locking and readahead in read_extent_buffer_pages()

Roman Anasal (1):
      btrfs: send: use struct send_ctx *sctx for btrfs_compare_trees and changed_cb

Yang Li (1):
      btrfs: remove redundant NULL check before kvfree

Zhihao Cheng (1):
      btrfs: clarify error returns values in __load_free_space_cache

 block/bio.c                       |  33 ++
 fs/btrfs/Makefile                 |  19 +-
 fs/btrfs/backref.c                |  17 +-
 fs/btrfs/backref.h                |   9 +-
 fs/btrfs/block-group.c            | 178 +++++---
 fs/btrfs/block-group.h            |  21 +-
 fs/btrfs/btrfs_inode.h            |   3 +-
 fs/btrfs/compression.c            |  10 +-
 fs/btrfs/ctree.c                  |   9 +-
 fs/btrfs/ctree.h                  |  19 +-
 fs/btrfs/delalloc-space.c         |  29 +-
 fs/btrfs/delayed-inode.c          |   2 +-
 fs/btrfs/delayed-ref.c            |  79 ++--
 fs/btrfs/delayed-ref.h            |  28 +-
 fs/btrfs/dev-replace.c            | 186 +++++++-
 fs/btrfs/dev-replace.h            |   3 +
 fs/btrfs/discard.c                |   6 +-
 fs/btrfs/disk-io.c                | 183 ++++++--
 fs/btrfs/disk-io.h                |   6 +-
 fs/btrfs/extent-tree.c            | 361 ++++++++++------
 fs/btrfs/extent_io.c              | 791 +++++++++++++++++++++++++++-------
 fs/btrfs/extent_io.h              |  17 +-
 fs/btrfs/extent_map.c             |  18 +-
 fs/btrfs/file-item.c              |  22 +-
 fs/btrfs/file.c                   |  58 ++-
 fs/btrfs/free-space-cache.c       | 123 +++++-
 fs/btrfs/free-space-cache.h       |   2 +
 fs/btrfs/inode.c                  | 336 ++++++++++++---
 fs/btrfs/ioctl.c                  |  29 +-
 fs/btrfs/ordered-data.c           | 224 +++++++---
 fs/btrfs/ordered-data.h           |  57 ++-
 fs/btrfs/raid56.c                 |   3 +-
 fs/btrfs/ref-verify.c             |  43 +-
 fs/btrfs/reflink.c                |   5 +-
 fs/btrfs/relocation.c             |  99 ++++-
 fs/btrfs/scrub.c                  | 143 +++++++
 fs/btrfs/send.c                   |  31 +-
 fs/btrfs/space-info.c             | 365 ++++++++++++----
 fs/btrfs/space-info.h             |  25 +-
 fs/btrfs/subpage.c                | 278 ++++++++++++
 fs/btrfs/subpage.h                |  91 ++++
 fs/btrfs/super.c                  |   8 +-
 fs/btrfs/sysfs.c                  |   2 +
 fs/btrfs/tests/extent-map-tests.c |   2 +-
 fs/btrfs/transaction.c            | 152 ++++---
 fs/btrfs/transaction.h            |   5 +
 fs/btrfs/tree-log.c               | 288 ++++++-------
 fs/btrfs/volumes.c                | 364 +++++++++++++---
 fs/btrfs/volumes.h                |   8 +-
 fs/btrfs/zoned.c                  | 873 +++++++++++++++++++++++++++++++++++++-
 fs/btrfs/zoned.h                  | 157 ++++++-
 fs/iomap/direct-io.c              |  43 +-
 include/linux/bio.h               |   2 +
 include/linux/iomap.h             |   1 +
 include/linux/zstd.h              |   8 +-
 include/trace/events/btrfs.h      | 111 ++++-
 56 files changed, 4874 insertions(+), 1111 deletions(-)
 create mode 100644 fs/btrfs/subpage.c
 create mode 100644 fs/btrfs/subpage.h
