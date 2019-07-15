Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39A685CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfGOI42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 04:56:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:39840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729245AbfGOI42 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 04:56:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 659A2AEBF;
        Mon, 15 Jul 2019 08:56:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 659D9DA89D; Mon, 15 Jul 2019 10:57:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.3
Date:   Mon, 15 Jul 2019 10:57:01 +0200
Message-Id: <cover.1563178381.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there's majority of cleanups and refactoring, no big new features made
it to the final branch, the rest are fixes.

No merge conflicts. Please pull, thanks.

Hilights:

- chunks that have been trimmed and unchanged since last mount are
  tracked and skipped on repeated trims

- use hw assissed crc32c on more arches, speedups if native instructions
  or optimized implementation is available

- the RAID56 incompat bit is automatically removed when the last block
  group of that type is removed

Fixes:

- fsync fix for reflink on NODATACOW files that could lead to ENOSPC

- fix data loss after inode eviction, renaming it, and fsync it

- fix fsync not persisting dentry deletions due to inode evictions

- update ctime/mtime/iversion after hole punching

- fix compression type validation (reported by KASAN)

- send won't be allowed to start when relocation is in progress, this
  can cause spurious errors or produce incorrect send stream

Core:

- new tracepoints for space update

- tree-checker: better check for end of extents for some tree items

- preparatory work for more checksum algorithms

- run delayed iput at unlink time and don't push the work to cleaner
  thread where it's not properly throttled

- wrap block mapping to structures and helpers, base for further
  refactoring

- split large files, part 1:
  - space info handling
  - block group reservations
  - delayed refs
  - delayed allocation

- other cleanups and refactoring

----------------------------------------------------------------
The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-tag

for you to fetch changes up to e02d48eaaed77f6c36916a7aa65c451e1f9d9aab:

  btrfs: fix memory leak of path on error return path (2019-07-05 18:47:57 +0200)

----------------------------------------------------------------
Arnd Bergmann (1):
      btrfs: shut up bogus -Wmaybe-uninitialized warning

Colin Ian King (1):
      btrfs: fix memory leak of path on error return path

David Sterba (32):
      btrfs: detect fast implementation of crc32c on all architectures
      btrfs: fiemap: preallocate ulists for btrfs_check_shared
      btrfs: fix minimum number of chunk errors for DUP
      btrfs: raid56: allow the exact minimum number of devices for balance convert
      btrfs: remove mapping tree structures indirection
      btrfs: use raid_attr table in get_profile_num_devs
      btrfs: use raid_attr in btrfs_chunk_max_errors
      btrfs: use raid_attr to get allowed profiles for balance conversion
      btrfs: use raid_attr table to find profiles for integrity lowering
      btrfs: use raid_attr table for btrfs_bg_type_to_factor
      btrfs: factor out helper for counting data stripes
      btrfs: use u8 for raid_array members
      btrfs: factor out devs_max setting in __btrfs_alloc_chunk
      btrfs: refactor helper for bg flags to name conversion
      btrfs: constify map parameter for nr_parity_stripes and nr_data_stripes
      btrfs: read number of data stripes from map only once
      btrfs: use file:line format for assertion report
      btrfs: tests: add locks around add_extent_mapping
      btrfs: assert delayed ref lock in btrfs_find_delayed_ref_head
      btrfs: switch extent_buffer blocking_writers from atomic to int
      btrfs: switch extent_buffer spinning_writers from atomic to int
      btrfs: switch extent_buffer write_locks from atomic to int
      btrfs: raid56: clear incompat block group flags after removing the last one
      btrfs: add mask for all RAID1 types
      btrfs: use mask for RAID56 profiles
      btrfs: document BTRFS_MAX_MIRRORS
      btrfs: improve messages when updating feature flags
      btrfs: use common helpers for extent IO state insertion messages
      btrfs: drop default value assignments in enums
      btrfs: use raid_attr to adjust minimal stripe size in btrfs_calc_avail_data_space
      btrfs: use raid_attr for minimum stripe count in btrfs_calc_avail_data_space
      btrfs: lift bio_set_dev from bio allocation helpers

Filipe Manana (4):
      Btrfs: fix data loss after inode eviction, renaming it, and fsync it
      Btrfs: prevent send failures and crashes due to concurrent relocation
      Btrfs: fix fsync not persisting dentry deletions due to inode evictions
      Btrfs: add missing inode version, ctime and mtime updates when punching hole

Goldwyn Rodrigues (3):
      btrfs: Remove unused variable mode in btrfs_mount
      btrfs: Simplify update of space_info in __reserve_metadata_bytes()
      btrfs: Evaluate io_tree in find_lock_delalloc_range()

Johannes Thumshirn (13):
      btrfs: use btrfs_csum_data() instead of directly calling crc32c
      btrfs: resurrect btrfs_crc32c()
      btrfs: use btrfs_crc32c{,_final}() in for free space cache
      btrfs: don't assume ordered sums to be 4 bytes
      btrfs: don't assume compressed_bio sums to be 4 bytes
      btrfs: format checksums according to type for printing
      btrfs: add common checksum type validation
      btrfs: check for supported superblock checksum type before checksum validation
      btrfs: Simplify btrfs_check_super_csum() and get rid of size assumptions
      btrfs: add boilerplate code for directly including the crypto framework
      btrfs: directly call into crypto framework for checksumming
      btrfs: remove assumption about csum type form btrfs_print_data_csum_error()
      btrfs: correctly validate compression type

Josef Bacik (23):
      btrfs: run delayed iput at unlink time
      btrfs: move space_info to space-info.h
      btrfs: rename do_chunk_alloc to btrfs_chunk_alloc
      btrfs: export space_info_add_*_bytes
      btrfs: move the space_info handling code to space-info.c
      btrfs: move and export can_overcommit
      btrfs: move the space info update macro to space-info.h
      btrfs: move btrfs_space_info_add_*_bytes to space-info.c
      btrfs: export block_rsv_use_bytes
      btrfs: move dump_space_info to space-info.c
      btrfs: move reserve_metadata_bytes and supporting code to space-info.c
      btrfs: unexport can_overcommit
      btrfs: move btrfs_block_rsv definitions into it's own header
      btrfs: export btrfs_block_rsv_add_bytes
      btrfs: export __btrfs_block_rsv_release
      btrfs: cleanup the target logic in __btrfs_block_rsv_release
      btrfs: stop using block_rsv_release_bytes everywhere
      btrfs: migrate the block-rsv code to block-rsv.c
      btrfs: migrate the global_block_rsv helpers to block-rsv.c
      btrfs: migrate the delayed refs rsv code
      btrfs: migrate btrfs_trans_release_chunk_metadata
      btrfs: migrate the delalloc space stuff to it's own home
      btrfs: move the subvolume reservation stuff out of extent-tree.c

Liu Bo (1):
      Btrfs: remove unused variables in __btrfs_unlink_inode

Nikolay Borisov (17):
      btrfs: Don't opencode sync_blockdev in btrfs_init_dev_replace_tgtdev
      btrfs: Reduce critical section in btrfs_init_dev_replace_tgtdev
      btrfs: dev-replace: Remove impossible WARN_ON
      btrfs: Ensure btrfs_init_dev_replace_tgtdev sees up to date values
      btrfs: Streamline replace sem unlock in btrfs_dev_replace_start
      btrfs: Explicitly reserve space for devreplace item
      btrfs: Remove redundant assignment of tgt_device->commit_total_bytes
      btrfs: add new helper btrfs_lock_and_flush_ordered_range
      btrfs: Use newly introduced btrfs_lock_and_flush_ordered_range
      btrfs: Always use a cached extent_state in btrfs_lock_and_flush_ordered_range
      btrfs: Add comments on locking of several device-related fields
      btrfs: Return EAGAIN if we can't start no snpashot write in check_can_nocow
      btrfs: trim: make reserved device area adjustments more explicit
      btrfs: Don't trim returned range based on input value in find_first_clear_extent_bit
      btrfs: Document __etree_search
      btrfs: Introduce btrfs_io_geometry infrastructure
      btrfs: Use btrfs_get_io_geometry appropriately

Qu Wenruo (7):
      btrfs: extent-tree: Refactor add_pinned_bytes() to add|sub_pinned_bytes()
      btrfs: tree-checker: Check if the file extent end overflows
      btrfs: extent-tree: Add lockdep assert when updating space info
      btrfs: extent-tree: Add trace events for space info numbers update
      btrfs: remove the incorrect comment on RO fs when btrfs_run_delalloc_range() fails
      btrfs: Flush before reflinking any extent to prevent NOCOW write falling back to COW without data reservation
      btrfs: qgroup: Don't hold qgroup_ioctl_lock in btrfs_qgroup_inherit()

Su Yue (1):
      btrfs: switch order of unlocks of space_info and bg in do_trimming()

 fs/btrfs/Kconfig                  |    3 +-
 fs/btrfs/Makefile                 |    3 +-
 fs/btrfs/backref.c                |   17 +-
 fs/btrfs/backref.h                |    3 +-
 fs/btrfs/block-rsv.c              |  425 ++++++
 fs/btrfs/block-rsv.h              |  101 ++
 fs/btrfs/btrfs_inode.h            |   22 +-
 fs/btrfs/check-integrity.c        |   11 +-
 fs/btrfs/compression.c            |   65 +-
 fs/btrfs/compression.h            |    3 +-
 fs/btrfs/ctree.h                  |  282 ++--
 fs/btrfs/delalloc-space.c         |  494 +++++++
 fs/btrfs/delalloc-space.h         |   23 +
 fs/btrfs/delayed-ref.c            |  181 ++-
 fs/btrfs/delayed-ref.h            |   10 +
 fs/btrfs/dev-replace.c            |   31 +-
 fs/btrfs/disk-io.c                |  166 ++-
 fs/btrfs/disk-io.h                |    2 -
 fs/btrfs/extent-tree.c            | 2755 ++++---------------------------------
 fs/btrfs/extent_io.c              |  149 +-
 fs/btrfs/extent_io.h              |   10 +-
 fs/btrfs/file-item.c              |   43 +-
 fs/btrfs/file.c                   |   28 +-
 fs/btrfs/free-space-cache.c       |   16 +-
 fs/btrfs/inode-map.c              |    1 +
 fs/btrfs/inode.c                  |  109 +-
 fs/btrfs/ioctl.c                  |   23 +
 fs/btrfs/locking.c                |   62 +-
 fs/btrfs/ordered-data.c           |   56 +-
 fs/btrfs/ordered-data.h           |    8 +-
 fs/btrfs/print-tree.c             |    6 +-
 fs/btrfs/props.c                  |    8 +-
 fs/btrfs/qgroup.c                 |   24 +-
 fs/btrfs/raid56.h                 |    4 +-
 fs/btrfs/relocation.c             |    1 +
 fs/btrfs/root-tree.c              |   56 +
 fs/btrfs/scrub.c                  |   50 +-
 fs/btrfs/send.c                   |   16 +-
 fs/btrfs/space-info.c             | 1094 +++++++++++++++
 fs/btrfs/space-info.h             |  133 ++
 fs/btrfs/super.c                  |   30 +-
 fs/btrfs/sysfs.c                  |    1 +
 fs/btrfs/tests/extent-io-tests.c  |  117 +-
 fs/btrfs/tests/extent-map-tests.c |   22 +
 fs/btrfs/transaction.c            |   18 +
 fs/btrfs/transaction.h            |    1 +
 fs/btrfs/tree-checker.c           |   11 +
 fs/btrfs/tree-log.c               |   40 +-
 fs/btrfs/volumes.c                |  376 ++---
 fs/btrfs/volumes.h                |   52 +-
 include/trace/events/btrfs.h      |   40 +
 include/uapi/linux/btrfs_tree.h   |    2 +
 52 files changed, 3954 insertions(+), 3250 deletions(-)
 create mode 100644 fs/btrfs/block-rsv.c
 create mode 100644 fs/btrfs/block-rsv.h
 create mode 100644 fs/btrfs/delalloc-space.c
 create mode 100644 fs/btrfs/delalloc-space.h
 create mode 100644 fs/btrfs/space-info.c
 create mode 100644 fs/btrfs/space-info.h
