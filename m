Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5803FB6E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhH3NW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:22:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:22:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1892F200AB;
        Mon, 30 Aug 2021 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630329691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/mxb5bwbKvhJ2pxEIrBosdQjLxp69cwkKXuCcp+7EAc=;
        b=OXRsTxXrNJp8FCs4sDGAW5nQUG/JqzcCp2xIyPvm9ayTTeAnakus70WQFkPHfeU7k0J2OQ
        QX4ZnuHzU46o/GKuQ+GDPp/cwcxit1iCtyUVpTe7nXr6wQ2Kb+OU3i+c5RBHvuQ/DPW1wU
        2JSgKN6Cu5PsW3vDGcL8qxvvA6CkvyE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0D5EFA3B8C;
        Mon, 30 Aug 2021 13:21:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0C48DA733; Mon, 30 Aug 2021 15:18:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.15
Date:   Mon, 30 Aug 2021 15:18:39 +0200
Message-Id: <cover.1630327914.git.dsterba@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

the highlights of this round are integrations with fs-verity and
idmapped mounts, the rest is usual mix of minor improvements, speedups
and cleanups.

Please note there are some patches outside of btrfs, namely updating
some VFS interfaces, all straightforward and acked.

Please pull, thanks.

---
Features:

- fs-verity support, using standard ioctls, backward compatible with
  read-only limitation on inodes with previously enabled fs-verity

- idmapped mount support

- make mount with rescue=ibadroots more tolerant to partially damaged
  trees

- allow raid0 on a single device and raid10 on two devices, degenerate
  cases but might be useful as an intermediate step during conversion to
  other profiles

- zoned mode block group auto reclaim can be disabled via sysfs knob

Performance improvements:

- continue readahead of node siblings even if target node is in memory,
  could speed up full send (on sample test +11%)

- batching of delayed items can speed up creating many files

- fsync/tree-log speedups
  - avoid unnecessary work (gains +2% throughput, -2% run time on
    sample load)
  - reduced lock contention on renames (on dbench +4% throughput, up to
    -30% latency)

Fixes:

- various zoned mode fixes

- preemptive flushing threshold tuning, avoid excessive work on almost
  full filesystems

Core:

- continued subpage support, preparation for implementing remaining
  features like compression and defragmentation; with some limitations,
  write is now enabled on 64K page systems with 4K sectors, still
  considered experimental
  - no readahead on compressed reads
  - inline extents disabled
  - disabled raid56 profile conversion and mount

- improved flushing logic, fixing early ENOSPC on some workloads

- inode flags have been internally split to read-only and read-write
  incompat bit parts, used by fs-verity

- new tree items for fs-verity
  - descriptor item
  - Merkle tree item

- inode operations extended to be namespace-aware

- cleanups and refactoring

Generic code changes:

- fs: new export filemap_fdatawrite_wbc

- fs: removed sync_inode

- block: bio_trim argument type fixups

- vfs: add namespace-aware lookup

----------------------------------------------------------------
The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-tag

for you to fetch changes up to 0d977e0eba234e01a60bdde27314dc21374201b3:

  btrfs: reset replace target device to allocation state on close (2021-08-23 13:57:18 +0200)

----------------------------------------------------------------
Anand Jain (4):
      btrfs: check-integrity: drop unnecessary function prototypes
      btrfs: cleanup fs_devices pointer usage in btrfs_trim_fs
      btrfs: simplify return values in btrfs_check_raid_min_devices
      btrfs: sysfs: document structures and their associated files

Boris Burkov (3):
      btrfs: add ro compat flags to inodes
      btrfs: initial fsverity support
      btrfs: verity metadata orphan items

Chaitanya Kulkarni (2):
      block: fix argument type of bio_trim()
      btrfs: fix argument type of btrfs_bio_clone_partial()

Christian Brauner (20):
      namei: add mapping aware lookup helper
      btrfs: handle idmaps in btrfs_new_inode()
      btrfs: allow idmapped rename inode op
      btrfs: allow idmapped getattr inode op
      btrfs: allow idmapped mknod inode op
      btrfs: allow idmapped create inode op
      btrfs: allow idmapped mkdir inode op
      btrfs: allow idmapped symlink inode op
      btrfs: allow idmapped tmpfile inode op
      btrfs: allow idmapped setattr inode op
      btrfs: allow idmapped permission inode op
      btrfs: check whether fsgid/fsuid are mapped during subvolume creation
      btrfs: allow idmapped SNAP_CREATE/SUBVOL_CREATE ioctls
      btrfs: allow idmapped SNAP_DESTROY ioctls
      btrfs: relax restrictions for SNAP_DESTROY_V2 with subvolids
      btrfs: allow idmapped SET_RECEIVED_SUBVOL ioctls
      btrfs: allow idmapped SUBVOL_SETFLAGS ioctl
      btrfs: allow idmapped INO_LOOKUP_USER ioctl
      btrfs: handle ACLs on idmapped mounts
      btrfs: allow idmapped mount

David Sterba (18):
      btrfs: add special case to setget helpers for 64k pages
      btrfs: drop from __GFP_HIGHMEM all allocations
      btrfs: compression: drop kmap/kunmap from lzo
      btrfs: compression: drop kmap/kunmap from zlib
      btrfs: compression: drop kmap/kunmap from zstd
      btrfs: compression: drop kmap/kunmap from generic helpers
      btrfs: check-integrity: drop kmap/kunmap for block pages
      btrfs: switch uptodate to bool in btrfs_writepage_endio_finish_ordered
      btrfs: remove uptodate parameter from btrfs_dec_test_first_ordered_pending
      btrfs: make btrfs_next_leaf static inline
      btrfs: tree-checker: use table values for stripe checks
      btrfs: tree-checker: add missing stripe checks for raid1c3/4 profiles
      btrfs: uninline btrfs_bg_flags_to_raid_index
      btrfs: merge alloc_device helpers
      btrfs: simplify data stripe calculation helpers
      btrfs: constify and cleanup variables in comparators
      btrfs: allow degenerate raid0/raid10
      btrfs: print if fsverity support is built in when loading module

Desmond Cheong Zhi Xi (1):
      btrfs: reset replace target device to allocation state on close

Filipe Manana (14):
      btrfs: continue readahead of siblings even if target node is in memory
      btrfs: improve the batch insertion of delayed items
      btrfs: stop doing GFP_KERNEL memory allocations in the ref verify tool
      btrfs: remove racy and unnecessary inode transaction update when using no-holes
      btrfs: avoid unnecessary log mutex contention when syncing log
      btrfs: remove unnecessary list head initialization when syncing log
      btrfs: avoid unnecessary lock and leaf splits when updating inode in the log
      btrfs: remove ignore_offset argument from btrfs_find_all_roots()
      btrfs: eliminate some false positives when checking if inode was logged
      btrfs: do not pin logs too early during renames
      btrfs: remove unnecessary NULL check for the new inode during rename exchange
      btrfs: remove no longer needed full sync flag check at inode_logged()
      btrfs: update comment at log_conflicting_inodes()
      btrfs: avoid unnecessarily logging directories that had no changes

Goldwyn Rodrigues (4):
      btrfs: allocate file_ra_state on stack in readahead_cache
      btrfs: allocate btrfs_ioctl_quota_rescan_args on stack
      btrfs: allocate btrfs_ioctl_defrag_range_args on stack
      btrfs: allocate backref_ctx on stack in find_extent_clone

Johannes Thumshirn (2):
      btrfs: zoned: remove max_zone_append_size logic
      btrfs: zoned: allow disabling of zone auto reclaim

Josef Bacik (11):
      btrfs: wake up async_delalloc_pages waiters after submit
      btrfs: include delalloc related info in dump space info tracepoint
      btrfs: enable a tracepoint when we fail tickets
      btrfs: use delalloc_bytes to determine flush amount for shrink_delalloc
      btrfs: wait on async extents when flushing delalloc
      fs: add a filemap_fdatawrite_wbc helper
      btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
      9p: migrate from sync_inode to filemap_fdatawrite_wbc
      fs: kill sync_inode
      btrfs: reduce the preemptive flushing threshold to 90%
      btrfs: do not do preemptive flushing if the majority is global rsv

Marcos Paulo de Souza (7):
      btrfs: remove max argument from generic_bin_search
      btrfs: pass NULL as trans to btrfs_search_slot if we only want to search
      btrfs: use btrfs_next_leaf instead of btrfs_next_item when slots > nritems
      btrfs: remove unneeded return variable in btrfs_lookup_file_extent
      btrfs: introduce btrfs_lookup_match_dir
      btrfs: introduce btrfs_search_backwards function
      btrfs: tree-log: check btrfs_lookup_data_extent return value

Naohiro Aota (5):
      btrfs: drop unnecessary ASSERT from btrfs_submit_direct()
      btrfs: zoned: suppress reclaim error message on EAGAIN
      btrfs: zoned: fix block group alloc_offset calculation
      btrfs: zoned: add asserts on splitting extent_map
      btrfs: zoned: fix ordered extent boundary calculation

Nikolay Borisov (1):
      btrfs: make btrfs_finish_chunk_alloc private to block-group.c

Qu Wenruo (22):
      btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group items
      btrfs: remove unused start and end parameters from btrfs_run_delalloc_range()
      btrfs: reset this_bio_flag to avoid inheriting old flags
      btrfs: subpage: check if there are compressed extents inside one page
      btrfs: disable compressed readahead for subpage
      btrfs: grab correct extent map for subpage compressed extent read
      btrfs: rework btrfs_decompress_buf2page()
      btrfs: rework lzo_decompress_bio() to make it subpage compatible
      btrfs: reloc: factor out relocation page read and dirty part
      btrfs: make relocate_one_page() handle subpage case
      btrfs: subpage: fix writeback which does not have ordered extent
      btrfs: subpage: disable inline extent creation
      btrfs: subpage: allow submit_extent_page() to do bio split
      btrfs: subpage: reject raid56 filesystem and profile conversion
      btrfs: subpage: fix race between prepare_pages() and btrfs_releasepage()
      btrfs: subpage: fix a potential use-after-free in writeback helper
      btrfs: subpage: fix false alert when relocating partial preallocated data extents
      btrfs: subpage: fix relocation potentially overwriting last page data
      btrfs: allow read-write for 4K sectorsize on 64K page size systems
      btrfs: unify regular and subpage error paths in __extent_writepage()
      btrfs: remove the dead comment in writepage_delalloc()
      btrfs: fix NULL pointer dereference when deleting device by invalid id

 block/bio.c                     |  12 +-
 fs/9p/vfs_file.c                |   7 +-
 fs/btrfs/Makefile               |   1 +
 fs/btrfs/acl.c                  |  11 +-
 fs/btrfs/backref.c              |   6 +-
 fs/btrfs/backref.h              |   2 +-
 fs/btrfs/block-group.c          | 114 +++++-
 fs/btrfs/btrfs_inode.h          |  27 +-
 fs/btrfs/check-integrity.c      |  60 +--
 fs/btrfs/compression.c          | 169 ++++-----
 fs/btrfs/compression.h          |   5 +-
 fs/btrfs/ctree.c                |  62 +--
 fs/btrfs/ctree.h                |  94 +++--
 fs/btrfs/delayed-inode.c        | 227 ++++-------
 fs/btrfs/dir-item.c             |  76 ++--
 fs/btrfs/disk-io.c              |  13 +-
 fs/btrfs/extent-tree.c          |  12 +-
 fs/btrfs/extent_io.c            | 318 +++++++++++-----
 fs/btrfs/extent_io.h            |   2 +-
 fs/btrfs/file-item.c            |   5 +-
 fs/btrfs/file.c                 |  23 +-
 fs/btrfs/free-space-cache.c     |  26 +-
 fs/btrfs/inode.c                | 295 +++++++++++----
 fs/btrfs/ioctl.c                | 188 +++++-----
 fs/btrfs/lzo.c                  | 236 +++++-------
 fs/btrfs/ordered-data.c         |   5 +-
 fs/btrfs/ordered-data.h         |   2 +-
 fs/btrfs/qgroup.c               |   8 +-
 fs/btrfs/raid56.c               |  18 +-
 fs/btrfs/ref-verify.c           |  10 +-
 fs/btrfs/relocation.c           | 306 +++++++++------
 fs/btrfs/send.c                 |  35 +-
 fs/btrfs/space-info.c           |  98 ++++-
 fs/btrfs/struct-funcs.c         |   8 +-
 fs/btrfs/subpage.c              |  24 +-
 fs/btrfs/subpage.h              |   3 +
 fs/btrfs/super.c                |  56 ++-
 fs/btrfs/sysfs.c                | 108 +++++-
 fs/btrfs/tests/qgroup-tests.c   |  30 +-
 fs/btrfs/tree-checker.c         |  38 +-
 fs/btrfs/tree-log.c             | 102 +++--
 fs/btrfs/verity.c               | 811 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c              | 234 ++++--------
 fs/btrfs/volumes.h              |  29 +-
 fs/btrfs/zlib.c                 |  54 +--
 fs/btrfs/zoned.c                |  22 +-
 fs/btrfs/zoned.h                |   1 -
 fs/btrfs/zstd.c                 |  39 +-
 fs/fs-writeback.c               |  19 +-
 fs/namei.c                      |  43 ++-
 include/linux/bio.h             |   2 +-
 include/linux/blk_types.h       |   1 +
 include/linux/fs.h              |   3 +-
 include/linux/namei.h           |   1 +
 include/trace/events/btrfs.h    |  21 +-
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  35 ++
 mm/filemap.c                    |  36 +-
 58 files changed, 2769 insertions(+), 1425 deletions(-)
 create mode 100644 fs/btrfs/verity.c
