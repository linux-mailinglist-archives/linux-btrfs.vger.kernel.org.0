Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0705B23494F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbgGaQmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 12:42:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:55752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbgGaQmk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 12:42:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED9B4AC61;
        Fri, 31 Jul 2020 16:42:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C3E9DA82B; Fri, 31 Jul 2020 18:42:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.9
Date:   Fri, 31 Jul 2020 18:42:03 +0200
Message-Id: <cover.1596213437.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

we don't have any big feature updates this time, there are lots of small
enhacements or fixes. A hilight perhaps are the parallel fsync
performance improvements, numbers below.

Regarding the dio/iomap that was reverted last time, the required API
changes are likely to land in the upcoming cycle, the btrfs part will be
updated afterwards.

Please pull, thanks.

---

User visible changes:

- new mount option rescue= to group all recovery-related mount options
  so we don't have many specific options, currently introducing only
  aliases for existing options, future extensions are in development to
  allow read-only mount with partially damaged structures
  - usebackuproot is an alias for rescue=usebackuproot
  - nologreplay is an alias for rescue=nologreplay

- start deprecation of mount option inode_cache, removal scheduled to
  5.11

- removed deprecated mount options alloc_start and subvolrootid

- device stats corruption counter gets incremented when a checksum
  mismatch is found

- qgroup information exported in sysfs /sys/fs/btrfs/<UUID>/qgroups/<id>

- add link /sys/fs/btrfs/<UUID>/bdi pointing to the associated backing
  dev info

- FS_INFO ioctl enhancements:
  - add flags to request/describe newly added items
  - new item: numeric checksum type and checksum size
  - new item: generation
  - new item: metadata_uuid

- seed device: with one new read-write device added, print the new
  device information in /proc/mounts

- balance: detect cancellation by Ctrl-C in existing cancellation points

Performance improvements:

- optimized versions of various helpers on little-endian architectures,
  where we don't have to do LE/BE conversion from on-disk format

- tree-log/fsync optimizations leading to lower max latency reported by
  dbench, reduced by about 12%

- all chunk tree leaves are prefetched at mount time, can improve mount
  time on large (terabyte-sized) filesystems

- speed up parallel fsync of files with reflinked/deduped extents, with
  jobs 16 to 1024 the throughput gets improved roughly by 50% on average
  and runtime decreased roughly by 30% on average, notable outlier is
  128 jobs with +121.2% on throughput and -54.6% runtime

- another speed up of parallel fsync, reduce number of checksum tree
  lookups and contention, the improvements start to show up with 2
  tasks with +20% throughput and -16% runtime up to 64 with +200%
  throughput and -66% runtime

Core:

- umount-time qgroup leak checker

- qgroups
  - add a way to unreserve partial range after failure, avoiding some
    EDQUOT errors
  - improved flushing logic when EDQUOT is hit

- possible EINTR interruption caused by failed reservations after
  transaction start is better handled and documented

- transaction abort errors are unified to EROFS in case it's not the
  original reason of abort or we don't have other way to determine the
  reason

Fixes:

- make truncate succeed on a NOCOW file even if data space is exhausted

- fix cancelling balance on filesystem with exhausted metadata space

- anon block device:
  - preallocate anon bdev when subvolume is created to report failure
    early
  - shorten time the anon bdev id is allocated
  - don't allocate anon bdev for internal roots

- minor memory leak in ref-verify

- refuse invalid combinations of compression and NOCOW file flags

- lockdep fixes, updating the device locks

- remove obsolete fallback logic for block group profile adjustments
  when switching from 1 to more devices, causing allocation of unwanted
  block groups

Other:

- cleanups, refactoring, simplifications
  - conversions from struct inode to struct btrfs_inode in internal
    functions
  - removal of unused struct members

----------------------------------------------------------------
The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-tag

for you to fetch changes up to 5e548b32018d96c377fda4bdac2bf511a448ca67:

  btrfs: do not set the full sync flag on the inode during page release (2020-07-27 12:55:48 +0200)

----------------------------------------------------------------
Anand Jain (3):
      btrfs: let btrfs_return_cluster_to_free_space() return void
      btrfs: use helper btrfs_get_block_group
      btrfs: don't traverse into the seed devices in show_devname

David Sterba (18):
      btrfs: scrub: remove kmap/kunmap of pages
      btrfs: scrub: unify naming of page address variables
      btrfs: scrub: simplify superblock checksum calculation
      btrfs: scrub: remove temporary csum array in scrub_checksum_super
      btrfs: scrub: clean up temporary page variables in scrub_checksum_super
      btrfs: scrub: simplify data block checksum calculation
      btrfs: scrub: clean up temporary page variables in scrub_checksum_data
      btrfs: scrub: simplify tree block checksum calculation
      btrfs: scrub: clean up temporary page variables in scrub_checksum_tree_block
      btrfs: add little-endian optimized key helpers
      btrfs: don't use UAPI types for fiemap callback
      btrfs: remove unused btrfs_root::defrag_trans_start
      btrfs: start deprecation of mount option inode_cache
      btrfs: allow use of global block reserve for balance item deletion
      btrfs: remove deprecated mount option alloc_start
      btrfs: remove deprecated mount option subvolrootid
      btrfs: prefetch chunk tree leaves at mount
      btrfs: add missing check for nocow and compression inode flags

Denis Efremov (1):
      btrfs: tests: remove if duplicate in __check_free_space_extents()

Filipe Manana (13):
      btrfs: remove no longer necessary chunk mutex locking cases
      btrfs: remove the start argument from btrfs_free_reserved_data_space_noquota()
      btrfs: use btrfs_alloc_data_chunk_ondemand() when allocating space for relocation
      btrfs: remove no longer used log_list member of struct btrfs_ordered_extent
      btrfs: remove no longer used trans_list member of struct btrfs_ordered_extent
      btrfs: only commit the delayed inode when doing a full fsync
      btrfs: only commit delayed items at fsync if we are logging a directory
      btrfs: stop incremening log_batch for the log root tree when syncing log
      btrfs: remove no longer needed use of log_writers for the log root tree
      btrfs: reduce contention on log trees when logging checksums
      btrfs: fix race between page release and a fast fsync
      btrfs: release old extent maps during page release
      btrfs: do not set the full sync flag on the inode during page release

Johannes Thumshirn (7):
      btrfs: get mapping tree directly from fsinfo in find_first_block_group
      btrfs: factor out reading of bg from find_frist_block_group
      btrfs: use free_root_extent_buffer to free root
      btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
      btrfs: add filesystem generation to FS_INFO ioctl
      btrfs: add metadata_uuid to FS_INFO ioctl
      btrfs: open-code remount flag setting in btrfs_remount

Josef Bacik (10):
      btrfs: convert block group refcount to refcount_t
      btrfs: don't WARN if we abort a transaction with EROFS
      btrfs: document special case error codes for fs errors
      btrfs: return EROFS for BTRFS_FS_STATE_ERROR cases
      btrfs: sysfs: use NOFS for device creation
      btrfs: open device without device_list_mutex
      btrfs: move the chunk_mutex in btrfs_read_chunk_tree
      btrfs: fix lockdep splat from btrfs_dump_space_info
      btrfs: don't adjust bg flags and use default allocation profiles
      btrfs: if we're restriping, use the target restripe profile

Liao Pingfang (1):
      btrfs: check-integrity: remove unnecessary failure messages during memory allocation

Marcos Paulo de Souza (1):
      btrfs: add multi-statement protection to btrfs_set/clear_and_info macros

Nikolay Borisov (74):
      btrfs: don't balance btree inode pages from buffered write path
      btrfs: read stripe len directly in btrfs_rmap_block
      btrfs: simplify checks when adding excluded ranges
      btrfs: make __btrfs_add_ordered_extent take struct btrfs_inode
      btrfs: make get_extent_allocation_hint take btrfs_inode
      btrfs: make btrfs_lookup_ordered_extent take btrfs_inode
      btrfs: make btrfs_reloc_clone_csums take btrfs_inode
      btrfs: make create_io_em take btrfs_inode
      btrfs: make extent_clear_unlock_delalloc take btrfs_inode
      btrfs: make btrfs_csum_one_bio takae btrfs_inode
      btrfs: make __btrfs_drop_extents take btrfs_inode
      btrfs: remove hole check in prealloc_file_extent_cluster
      btrfs: perform data management operations outside of inode lock
      btrfs: use for loop in prealloc_file_extent_cluster
      btrfs: tracepoints: fix btrfs_trigger_flush symbolic string for flags
      btrfs: tracepoints: fix extent type symbolic name print
      btrfs: tracepoints: move FLUSH_ACTIONS define
      btrfs: tracepoints: fix qgroup reservation type printing
      btrfs: tracepoints: switch extent_io_tree_owner to using EM macro
      btrfs: tracepoints: convert flush states to using EM macros
      btrfs: make qgroup_free_reserved_data take btrfs_inode
      btrfs: make __btrfs_qgroup_release_data take btrfs_inode
      btrfs: make btrfs_qgroup_free_data take btrfs_inode
      btrfs: make cow_file_range_inline take btrfs_inode
      btrfs: make btrfs_add_ordered_extent take btrfs_inode
      btrfs: make cow_file_range take btrfs_inode
      btrfs: make btrfs_add_ordered_extent_compress take btrfs_inode
      btrfs: make btrfs_submit_compressed_write take btrfs_inode
      btrfs: make submit_compressed_extents take btrfs_inode
      btrfs: make btrfs_qgroup_release_data take btrfs_inode
      btrfs: make insert_reserved_file_extent take btrfs_inode
      btrfs: make fallback_to_cow take btrfs_inode
      btrfs: make run_delalloc_nocow take btrfs_inode
      btrfs: make cow_file_range_async take btrfs_inode
      btrfs: make btrfs_dec_test_first_ordered_pending take btrfs_inode
      btrfs: make __endio_write_update_ordered take btrfs_inode
      btrfs: make btrfs_cleanup_ordered_extents take btrfs_inode
      btrfs: make inode_can_compress take btrfs_inode
      btrfs: make inode_need_compress take btrfs_inode
      btrfs: make need_force_cow take btrfs_inode
      btrfs: make btrfs_run_delalloc_range take btrfs_inode
      btrfs: make btrfs_add_ordered_extent_dio take btrfs_inode
      btrfs: make btrfs_create_dio_extent take btrfs_inode
      btrfs: make btrfs_new_extent_direct take btrfs_inode
      btrfs: make __extent_writepage_io take btrfs_inode
      btrfs: make writepage_delalloc take btrfs_inode
      btrfs: make btrfs_set_extent_delalloc take btrfs_inode
      btrfs: make btrfs_dirty_pages take btrfs_inode
      btrfs: make btrfs_qgroup_reserve_data take btrfs_inode
      btrfs: make btrfs_free_reserved_data_space_noquota take btrfs_fs_info
      btrfs: make btrfs_free_reserved_data_space take btrfs_inode
      btrfs: make btrfs_delalloc_release_space take btrfs_inode
      btrfs: make btrfs_check_data_free_space take btrfs_inode
      btrfs: make btrfs_delalloc_reserve_space take btrfs_inode
      btrfs: remove BTRFS_I calls in btrfs_writepage_fixup_worker
      btrfs: make prealloc_file_extent_cluster take btrfs_inode
      btrfs: make btrfs_set_inode_last_trans take btrfs_inode
      btrfs: make btrfs_qgroup_check_reserved_leak take btrfs_inode
      btrfs: make get_state_failrec return failrec directly
      btrfs: streamline btrfs_get_io_failure_record logic
      btrfs: record btrfs_device directly in btrfs_io_bio
      btrfs: don't check for btrfs_device::bdev in btrfs_end_bio
      btrfs: increment device corruption error in case of checksum error
      btrfs: remove needless ASSERT check of orig_bio in end_compressed_bio_read
      btrfs: increment corrupt device counter during compressed read
      btrfs: sysfs: add bdi link to the fsid directory
      btrfs: always initialize btrfs_bio::tgtdev_map/raid_map pointers
      btrfs: raid56: remove redundant device check in rbio_add_io_page
      btrfs: raid56: assign bio in while() when using bio_list_pop
      btrfs: raid56: use in_range where applicable
      btrfs: raid56: don't opencode swap() in __raid_recover_end_io
      btrfs: remove fail label in check_compressed_csum
      btrfs: raid56: remove out label in __raid56_parity_recover
      btrfs: remove done label in writepage_delalloc

Qu Wenruo (22):
      btrfs: introduce "rescue=" mount option
      btrfs: inode: refactor the parameters of insert_reserved_file_extent()
      btrfs: inode: move qgroup reserved space release to the callers of insert_reserved_file_extent()
      btrfs: file: reserve qgroup space after the hole punch range is locked
      btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak
      btrfs: qgroup: catch reserved space leaks at unmount time
      btrfs: allow btrfs_truncate_block() to fallback to nocow for data space reservation
      btrfs: add comments for btrfs_check_can_nocow() and can_nocow_extent()
      btrfs: refactor btrfs_check_can_nocow() into two variants
      btrfs: use __u16 for the return value of btrfs_qgroup_level()
      btrfs: qgroup: export qgroups in sysfs
      btrfs: don't allocate anonymous block device for user invisible roots
      btrfs: free anon block device right after subvolume deletion
      btrfs: preallocate anon block device at first phase of snapshot creation
      btrfs: qgroup: allow to unreserve range without releasing other ranges
      btrfs: qgroup: try to flush qgroup space when we get -EDQUOT
      btrfs: qgroup: remove ASYNC_COMMIT mechanism in favor of reserve retry-after-EDQUOT
      btrfs: qgroup: free per-trans reserved space when a subvolume gets dropped
      btrfs: relocation: allow signal to cancel balance
      btrfs: avoid possible signal interruption of btrfs_drop_snapshot() on relocation tree
      btrfs: relocation: review the call sites which can be interrupted by signal
      btrfs: add comments for btrfs_reserve_flush_enum

Tom Rix (1):
      btrfs: ref-verify: fix memory leak in add_block_entry

 fs/btrfs/block-group.c                 | 211 +++++--------
 fs/btrfs/block-group.h                 |   3 +-
 fs/btrfs/btrfs_inode.h                 |  11 +
 fs/btrfs/check-integrity.c             |  27 +-
 fs/btrfs/compression.c                 |  30 +-
 fs/btrfs/compression.h                 |   4 +-
 fs/btrfs/ctree.c                       |  17 ++
 fs/btrfs/ctree.h                       | 127 ++++++--
 fs/btrfs/delalloc-space.c              |  36 +--
 fs/btrfs/delalloc-space.h              |  10 +-
 fs/btrfs/disk-io.c                     |  92 +++++-
 fs/btrfs/disk-io.h                     |   2 +
 fs/btrfs/extent-io-tree.h              |   5 +-
 fs/btrfs/extent-tree.c                 |  17 +-
 fs/btrfs/extent_io.c                   | 241 ++++++++-------
 fs/btrfs/extent_io.h                   |   4 +-
 fs/btrfs/file-item.c                   |   4 +-
 fs/btrfs/file.c                        | 143 +++++----
 fs/btrfs/free-space-cache.c            |  23 +-
 fs/btrfs/free-space-cache.h            |   2 +-
 fs/btrfs/inode-map.c                   |   3 +-
 fs/btrfs/inode.c                       | 530 ++++++++++++++++++---------------
 fs/btrfs/ioctl.c                       |  86 +++++-
 fs/btrfs/ordered-data.c                |  63 ++--
 fs/btrfs/ordered-data.h                |  19 +-
 fs/btrfs/qgroup.c                      | 359 ++++++++++++++++------
 fs/btrfs/qgroup.h                      |  24 +-
 fs/btrfs/raid56.c                      |  65 ++--
 fs/btrfs/ref-verify.c                  |   2 +
 fs/btrfs/reflink.c                     |  26 +-
 fs/btrfs/relocation.c                  |  71 ++---
 fs/btrfs/scrub.c                       | 153 +++-------
 fs/btrfs/space-info.c                  |   2 +-
 fs/btrfs/super.c                       | 144 ++++++---
 fs/btrfs/sysfs.c                       | 163 +++++++++-
 fs/btrfs/sysfs.h                       |   7 +
 fs/btrfs/tests/free-space-tree-tests.c |   2 -
 fs/btrfs/tests/inode-tests.c           |  14 +-
 fs/btrfs/transaction.c                 |   8 +-
 fs/btrfs/transaction.h                 |  28 +-
 fs/btrfs/tree-defrag.c                 |   5 +-
 fs/btrfs/tree-log.c                    |  50 ++--
 fs/btrfs/volumes.c                     | 133 ++++++---
 fs/btrfs/volumes.h                     |   2 +-
 include/trace/events/btrfs.h           | 137 +++++----
 include/uapi/linux/btrfs.h             |  21 +-
 include/uapi/linux/btrfs_tree.h        |   4 +-
 47 files changed, 1909 insertions(+), 1221 deletions(-)
