Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27BD1EA408
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgFAMha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 08:37:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgFAMh3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 08:37:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A8FCAFDB;
        Mon,  1 Jun 2020 12:37:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03955DA79B; Mon,  1 Jun 2020 14:37:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.8
Date:   Mon,  1 Jun 2020 14:37:21 +0200
Message-Id: <cover.1591014060.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following updates to btrfs. Thanks.

Highlights:

- speedup dead root detection during orphan cleanup, eg. when there are
  many deleted subvolumes waiting to be cleaned, the trees are now looked
  up in radix tree instead of a O(N^2) search

- snapshot creation with inherited qgroup will mark the qgroup
  inconsistent, requires a rescan

- send will emit file capabilities after chown, this produces a stream
  that does not need postprocessing to set the capabilities again

- direct io ported to iomap infrastructure, cleaned up and simplified
  code, notably removing last use of struct buffer_head in btrfs code

Core changes:

- factor out backreference iteration, to be used by ordinary
  backreferences and relocation code

- improved global block reserve utilization
  * better logic to serialize requests
  * increased maximum available for unlink
  * improved handling on large pages (64K)

- direct io cleanups and fixes
  * simplify layering, where cloned bios were unnecessarily created for
    some cases
  * error handling fixes (submit, endio)
  * remove repair worker thread, used to avoid deadlocks during
    repair

- refactored block group reading code, preparatory work for new type of
  block group storage that should improve mount time on large filesystems

Cleanups:

- cleaned up (and slightly sped up) set/get helpers for metadata data
  structure members

- root bit REF_COWS got renamed to SHAREABLE to reflect the that the
  blocks of the tree get shared either among subvolumes or with the
  relocation trees

Fixes:

- when subvolume deletion fails due to ENOSPC, the filesystem is not
  turned read-only

- device scan deals with devices from other filesystems that changed
  ownership due to overwrite (mkfs)

- fix a race between scrub and block group removal/allocation

- fix long standing bug of a runaway balance operation, printing the same
  line to the syslog, caused by a stale status bit on a reloc tree that
  prevented progress

- fix corrupt log due to concurrent fsync of inodes with shared extents

- fix space underflow for NODATACOW and buffered writes when it for some
  reason needs to fallback to COW mode

----------------------------------------------------------------
The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-tag

for you to fetch changes up to 2166e5edce9ac1edf3b113d6091ef72fcac2d6c4:

  btrfs: fix space_info bytes_may_use underflow during space cache writeout (2020-05-28 14:01:53 +0200)

----------------------------------------------------------------
Anand Jain (5):
      btrfs: drop useless goto in open_fs_devices
      btrfs: include non-missing as a qualifier for the latest_bdev
      btrfs: free alien device after device add
      btrfs: drop stale reference to volume_mutex
      btrfs: unexport btrfs_compress_set_level()

Christoph Hellwig (1):
      btrfs: split btrfs_direct_IO to read and write part

David Sterba (26):
      btrfs: don't force read-only after error in drop snapshot
      btrfs: sort error decoder entries
      btrfs: add more codes to decoder table
      btrfs: remove more obsolete v0 extent ref declarations
      btrfs: use the token::eb for all set/get helpers
      btrfs: drop eb parameter from set/get token helpers
      btrfs: don't use set/get token for single assignment in overwrite_item
      btrfs: don't use set/get token in leaf_space_used
      btrfs: preset set/get token with first page and drop condition
      btrfs: add separate bounds checker for set/get helpers
      btrfs: speed up btrfs_get_##bits helpers
      btrfs: speed up btrfs_get_token_##bits helpers
      btrfs: speed up btrfs_set_##bits helpers
      btrfs: speed up btrfs_set_token_##bits helpers
      btrfs: speed up and simplify generic_bin_search
      btrfs: remove unused map_private_extent_buffer
      btrfs: constify extent_buffer in the API functions
      btrfs: drop unnecessary offset_in_page in extent buffer helpers
      btrfs: optimize split page read in btrfs_get_##bits
      btrfs: optimize split page read in btrfs_get_token_##bits
      btrfs: optimize split page write in btrfs_set_##bits
      btrfs: optimize split page write in btrfs_set_token_##bits
      btrfs: update documentation of set/get helpers
      btrfs: simplify root lookup by id
      btrfs: open code read_fs_root
      btrfs: simplify iget helpers

Eric Biggers (1):
      btrfs: use crypto_shash_digest() instead of open coding

Filipe Manana (16):
      btrfs: remove pointless assertion on reclaim_size counter
      btrfs: simplify error handling of clean_pinned_extents()
      btrfs: remove useless check for copy_items() return value
      btrfs: fix a race between scrub and block group removal/allocation
      btrfs: rename member 'trimming' of block group to a more generic name
      btrfs: move the block group freeze/unfreeze helpers into block-group.c
      btrfs: scrub, only lookup for csums if we are dealing with a data extent
      btrfs: fix corrupt log due to concurrent fsync of inodes with shared extents
      btrfs: make checksum item extension more efficient
      btrfs: do not ignore error from btrfs_next_leaf() when inserting checksums
      btrfs: remove useless 'fail_unlock' label from btrfs_csum_file_blocks()
      btrfs: include error on messages about failure to write space/inode caches
      btrfs: turn space cache writeout failure messages into debug messages
      btrfs: fix wrong file range cleanup after an error filling dealloc range
      btrfs: fix space_info bytes_may_use underflow after nocow buffered write
      btrfs: fix space_info bytes_may_use underflow during space cache writeout

Goldwyn Rodrigues (6):
      fs: export generic_file_buffered_read()
      iomap: add a filesystem hook for direct I/O bio submission
      iomap: remove lockdep_assert_held()
      btrfs: switch to iomap_dio_rw() for dio
      fs: remove dio_end_io()
      btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK

Josef Bacik (6):
      btrfs: improve global reserve stealing logic
      btrfs: allow to use up to 90% of the global block rsv for unlink
      btrfs: account for trans_block_rsv in may_commit_transaction
      btrfs: only check priority tickets for priority flushing
      btrfs: run btrfs_try_granting_tickets if a priority ticket fails
      btrfs: force chunk allocation if our global rsv is larger than metadata

Jules Irenge (2):
      btrfs: add missing annotation for btrfs_lock_cluster()
      btrfs: add missing annotation for btrfs_tree_lock()

Marcos Paulo de Souza (1):
      btrfs: send: emit file capabilities after chown

Nikolay Borisov (4):
      btrfs: use list_for_each_entry_safe in free_reloc_roots
      btrfs: make btrfs_read_disk_super return struct btrfs_disk_super
      btrfs: open code key_search
      btrfs: remove redundant local variable in read_block_for_search

Omar Sandoval (15):
      block: add bio_for_each_bvec_all()
      btrfs: fix error handling when submitting direct I/O bio
      btrfs: fix double __endio_write_update_ordered in direct I/O
      btrfs: look at full bi_io_vec for repair decision
      btrfs: don't do repair validation for checksum errors
      btrfs: clarify btrfs_lookup_bio_sums documentation
      btrfs: rename __readpage_endio_check to check_data_csum
      btrfs: make btrfs_check_repairable() static
      btrfs: remove unused btrfs_dio_private::private
      btrfs: convert btrfs_dio_private->pending_bios to refcount_t
      btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
      btrfs: get rid of one layer of bios in direct I/O
      btrfs: simplify direct I/O read repair
      btrfs: get rid of endio_repair_workers
      btrfs: unify buffered and direct I/O read repair

Qu Wenruo (44):
      btrfs: backref: introduce the skeleton of btrfs_backref_iter
      btrfs: backref: implement btrfs_backref_iter_next()
      btrfs: reloc: use btrfs_backref_iter infrastructure
      btrfs: reloc: rename mark_block_processed and __mark_block_processed
      btrfs: reloc: add backref_cache::pending_edge and backref_cache::useless_node
      btrfs: reloc: add backref_cache::fs_info member
      btrfs: reloc: make reloc root search-specific for relocation backref cache
      btrfs: reloc: refactor direct tree backref processing into its own function
      btrfs: reloc: refactor indirect tree backref processing into its own function
      btrfs: reloc: use wrapper to replace open-coded edge linking
      btrfs: reloc: pass essential members for alloc_backref_node()
      btrfs: reloc: remove the open-coded goto loop for breadth-first search
      btrfs: reloc: refactor finishing part of upper linkage into finish_upper_links()
      btrfs: reloc: refactor useless nodes handling into its own function
      btrfs: reloc: add btrfs_ prefix for backref_node/edge/cache
      btrfs: backref: move btrfs_backref_(node|edge|cache) structures to backref.h
      btrfs: rename tree_entry to rb_simple_node and export it
      btrfs: backref: rename and move backref_cache_init()
      btrfs: backref: rename and move alloc_backref_node()
      btrfs: backref: rename and move alloc_backref_edge()
      btrfs: backref: rename and move link_backref_edge()
      btrfs: backref: rename and move free_backref_(node|edge)
      btrfs: backref: rename and move drop_backref_node()
      btrfs: backref: rename and move remove_backref_node()
      btrfs: backref: rename and move backref_cache_cleanup()
      btrfs: backref: rename and move backref_tree_panic()
      btrfs: backref: rename and move should_ignore_root()
      btrfs: reloc: open code read_fs_root() for handle_indirect_tree_backref()
      btrfs: backref: rename and move handle_one_tree_block()
      btrfs: backref: rename and move finish_upper_links()
      btrfs: reloc: move error handling of build_backref_tree() to backref.c
      btrfs: backref: distinguish reloc and non-reloc use of indirect resolution
      btrfs: remove the redundant parameter level in btrfs_bin_search()
      btrfs: qgroup: mark qgroup inconsistent if we're inherting snapshot to a new qgroup
      btrfs: block-group: don't set the wrong READA flag for btrfs_read_block_groups()
      btrfs: block-group: refactor how we read one block group item
      btrfs: block-group: refactor how we delete one block group item
      btrfs: block-group: refactor how we insert a block group item
      btrfs: block-group: rename write_one_cache_group()
      btrfs: rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE
      btrfs: inode: cleanup the log-tree exceptions in btrfs_truncate_inode_items()
      btrfs: don't set SHAREABLE flag for data reloc tree
      btrfs: reloc: fix reloc root leak and NULL pointer dereference
      btrfs: reloc: clear DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance

Robbie Ko (2):
      btrfs: speedup dead root detection during orphan cleanup
      btrfs: reduce lock contention when creating snapshot

Tiezhu Yang (1):
      btrfs: remove duplicated include in block-group.c

YueHaibing (2):
      btrfs: remove unused function heads_to_leaves
      btrfs: remove unused function btrfs_dev_extent_chunk_tree_uuid

Zheng Wei (1):
      btrfs: tree-checker: remove duplicate definition of 'inode_item_err'

 .clang-format                   |    1 +
 Documentation/block/biovecs.rst |    2 +
 fs/btrfs/Kconfig                |    1 +
 fs/btrfs/backref.c              |  837 ++++++++++++++++++++++++-
 fs/btrfs/backref.h              |  297 +++++++++
 fs/btrfs/block-group.c          |  233 ++++---
 fs/btrfs/block-group.h          |   14 +-
 fs/btrfs/block-rsv.c            |    5 +-
 fs/btrfs/btrfs_inode.h          |   44 +-
 fs/btrfs/compression.c          |   36 +-
 fs/btrfs/compression.h          |    2 -
 fs/btrfs/ctree.c                |  180 +++---
 fs/btrfs/ctree.h                |  121 ++--
 fs/btrfs/disk-io.c              |   93 +--
 fs/btrfs/disk-io.h              |    4 +-
 fs/btrfs/export.c               |   17 +-
 fs/btrfs/extent-io-tree.h       |    1 +
 fs/btrfs/extent-tree.c          |   23 +-
 fs/btrfs/extent_io.c            |  288 ++++-----
 fs/btrfs/extent_io.h            |   67 +-
 fs/btrfs/file-item.c            |   62 +-
 fs/btrfs/file.c                 |  111 +++-
 fs/btrfs/free-space-cache.c     |   81 +--
 fs/btrfs/inode.c                | 1319 ++++++++++++++-------------------------
 fs/btrfs/ioctl.c                |  102 ++-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/misc.h                 |   54 ++
 fs/btrfs/props.c                |    9 +-
 fs/btrfs/qgroup.c               |   14 +
 fs/btrfs/relocation.c           | 1319 +++++++++------------------------------
 fs/btrfs/root-tree.c            |   12 +-
 fs/btrfs/scrub.c                |   59 +-
 fs/btrfs/send.c                 |   89 ++-
 fs/btrfs/space-info.c           |   81 ++-
 fs/btrfs/space-info.h           |    1 +
 fs/btrfs/struct-funcs.c         |  223 +++----
 fs/btrfs/super.c                |   38 +-
 fs/btrfs/transaction.c          |   78 +--
 fs/btrfs/transaction.h          |    3 +-
 fs/btrfs/tree-checker.c         |    4 -
 fs/btrfs/tree-defrag.c          |    2 +-
 fs/btrfs/tree-log.c             |  192 +++---
 fs/btrfs/uuid-tree.c            |    6 +-
 fs/btrfs/volumes.c              |   80 +--
 fs/direct-io.c                  |   19 -
 fs/iomap/direct-io.c            |   17 +-
 include/linux/bio.h             |    8 +
 include/linux/fs.h              |    4 +-
 include/linux/iomap.h           |    2 +
 include/trace/events/btrfs.h    |    1 +
 include/uapi/linux/btrfs_tree.h |    9 -
 mm/filemap.c                    |    3 +-
 52 files changed, 3224 insertions(+), 3045 deletions(-)
