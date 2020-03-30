Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537FD198380
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 20:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC3Sig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 14:38:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:46912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgC3Sig (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 14:38:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F29BAD11;
        Mon, 30 Mar 2020 18:38:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE454DA72D; Mon, 30 Mar 2020 20:37:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.7
Date:   Mon, 30 Mar 2020 20:37:58 +0200
Message-Id: <cover.1585581921.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there's a number of core changes that make things work better in
general, code is simpler and cleaner. Please pull, thanks.

Core changes:

 - per-inode file extent tree, for in memory tracking of contiguous
   extent ranges to make sure i_size adjustments are accurate

 - tree root structures are protected by reference counts, replacing
   SRCU that did not cover some cases

 - leak detetctor for tree root structures

 - per-transaction pinned extent tracking

 - buffer heads are replaced by bios for super block access

 - speedup of extent back reference resolution, on an example test
   scenario the runtime of send went down from a hour to minutes

 - factor out locking scheme used for subvolume writer and NOCOW
   exclusion, abstracted as DREW lock, double reader-writer exclusion
   (allow either readers or writers)

 - cleanup and abstract extent allocation policies, preparation for
   zoned device support

 - make reflink/clone_range work on inline extents

 - add more cancellation point for relocation, improves long response
   from 'balance cancel'

 - add page migration callback for data pages

 - switch to guid for uuids, with additional cleanups of the interface

 - make ranged full fsyncs more efficient

 - removal of obsolete ioctl flag BTRFS_SUBVOL_CREATE_ASYNC

 - remove b-tree readahead from delayed refs paths, avoiding seek and
   read unnecessary blocks

Features:

 - v2 of ioctl to delete subvolumes, allowing to delete by id and more
   future extensions

Fixes:

 - fix qgroup rescan worker that could block umount

 - fix crash during unmount due to race with delayed inode workers

 - fix dellaloc flushing logic that could create unnecessary chunks
   under heavy load

 - fix missing file extent item for hole after ranged fsync

 - several fixes in relocation error handling

Other:

 - more documentation of relocation, device replace, space reservations

 - many random cleanups

----------------------------------------------------------------
The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-tag

for you to fetch changes up to 6ff06729c22ec0b7498d900d79cc88cfb8aceaeb:

  btrfs: fix missing semaphore unlock in btrfs_sync_file (2020-03-25 16:29:16 +0100)

----------------------------------------------------------------
Anand Jain (4):
      btrfs: sysfs, use btrfs_sysfs_remove_fsid to celanup errors in add_fsid
      btrfs: sysfs, rename device_link add/remove functions
      btrfs: sysfs, unify handler name of devinfo/missing
      btrfs: slightly simplify global block reserve calculations

Andy Shevchenko (4):
      uuid: Add inline helpers to import / export UUIDs
      uuid: Provide a GUID generator for raw buffer
      btrfs: switch to use new generic UUID API
      uuid: Remove no more needed macro

David Sterba (29):
      btrfs: move root node locking helpers to locking.c
      btrfs: add wrapper for transaction abort predicate
      btrfs: remove extent_page_data::tree
      btrfs: drop argument tree from submit_extent_page
      btrfs: add assertions for tree == inode->io_tree to extent IO helpers
      btrfs: drop argument tree from btrfs_lock_and_flush_ordered_range
      btrfs: sink argument tree to extent_read_full_page
      btrfs: sink argument tree to __extent_read_full_page
      btrfs: sink arugment tree to contiguous_readpages
      btrfs: sink argument tree to __do_readpage
      btrfs: raid56: simplify tracking of Q stripe presence
      btrfs: define support masks for ioctl volume args v2
      btrfs: use ioctl args support mask for subvolume create/delete
      btrfs: use ioctl args support mask for device delete
      btrfs: use struct_size to calculate size of raid hash table
      btrfs: move mapping of block for discard to its caller
      btrfs: open code trivial helper btrfs_header_fsid
      btrfs: open code trivial helper btrfs_header_chunk_tree_uuid
      btrfs: simplify parameters of btrfs_set_disk_extent_flags
      btrfs: adjust message level for unrecognized mount option
      btrfs: raid56: simplify sort_parity_stripes
      btrfs: replace u_long type cast with unsigned long
      btrfs: adjust delayed refs message level
      btrfs: reduce pointer intdirections in btree_readpage_end_io_hook
      btrfs: merge unlocking to common exit block in btrfs_commit_transaction
      btrfs: inline checksum name and driver definitions
      btrfs: simplify tree block checksumming loop
      btrfs: return void from csum_tree_block
      btrfs: balance: factor out convert profile validation

Filipe Manana (10):
      Btrfs: don't iterate mod seq list when putting a tree mod seq
      Btrfs: avoid unnecessary splits when setting bits on an extent io tree
      Btrfs: fix crash during unmount due to race with delayed inode workers
      Btrfs: move all reflink implementation code into its own file
      Btrfs: simplify inline extent handling when doing reflinks
      Btrfs: implement full reflink support for inline extents
      btrfs: fix missing file extent item for hole after ranged fsync
      btrfs: add helper to get the end offset of a file extent item
      btrfs: factor out inode items copy loop from btrfs_log_inode()
      btrfs: make ranged full fsyncs more efficient

Gustavo A. R. Silva (3):
      btrfs: delayed-inode: Replace zero-length array with flexible-array member
      btrfs: rcu-string: Replace zero-length array with flexible-array member
      btrfs: scrub: Replace zero-length array with flexible-array member

Johannes Thumshirn (11):
      btrfs: don't kmap() pages from block devices
      btrfs: reduce scope of btrfs_scratch_superblocks()
      btrfs: use the page cache for super block reading
      btrfs: use bios instead of buffer_heads from super block writeout
      btrfs: remove btrfsic_submit_bh()
      btrfs: remove buffer_heads from btrfsic_process_written_block()
      btrfs: remove buffer_heads form super block mirror integrity checking
      btrfs: use inode from io_ctl in io_ctl_prepare_pages
      btrfs: make the uptodate argument of io_ctl_add_pages() boolean
      btrfs: use standard debug config option to enable free-space-cache debug prints
      btrfs: simplify error handling in __btrfs_write_out_cache()

Josef Bacik (80):
      btrfs: use btrfs_ordered_update_i_size in clone_finish_inode_update
      btrfs: introduce per-inode file extent tree
      btrfs: use the file extent tree infrastructure
      btrfs: replace all uses of btrfs_ordered_update_i_size
      btrfs: delete the ordered isize update code
      btrfs: push __setup_root into btrfs_alloc_root
      btrfs: move fs root init stuff into btrfs_init_fs_root
      btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
      btrfs: export and use btrfs_read_tree_root for tree-log
      btrfs: make relocation use btrfs_read_tree_root()
      btrfs: remove btrfs_read_fs_root, not used anymore
      btrfs: open code btrfs_read_fs_root_no_name
      btrfs: make the fs root init functions static
      btrfs: handle NULL roots in btrfs_put/btrfs_grab_fs_root
      btrfs: add a comment describing block reserves
      btrfs: add a comment describing delalloc space reservation
      btrfs: describe the space reservation system in general
      btrfs: hold a ref on fs roots while they're in the radix tree
      btrfs: hold a ref on the root in resolve_indirect_ref
      btrfs: hold a root ref in btrfs_get_dentry
      btrfs: hold a ref on the root in __btrfs_run_defrag_inode
      btrfs: hold a ref on the root in fixup_tree_root_location
      btrfs: hold a ref on the root in create_subvol
      btrfs: hold a ref on the root in search_ioctl
      btrfs: hold a ref on the root in btrfs_search_path_in_tree
      btrfs: hold a ref on the root in btrfs_search_path_in_tree_user
      btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info
      btrfs: hold ref on root in btrfs_ioctl_default_subvol
      btrfs: hold a ref on the root in build_backref_tree
      btrfs: hold a ref on the root in prepare_to_merge
      btrfs: hold a ref on the root in merge_reloc_roots
      btrfs: hold a ref on the root in record_reloc_root_in_trans
      btrfs: hold a ref on the root in find_data_references
      btrfs: hold a ref on the root in create_reloc_inode
      btrfs: hold a ref on the root in btrfs_recover_relocation
      btrfs: push grab_fs_root into read_fs_root
      btrfs: hold a ref for the root in btrfs_find_orphan_roots
      btrfs: hold a ref on the root in scrub_print_warning_inode
      btrfs: hold a ref on the root in btrfs_ioctl_send
      btrfs: hold a ref on the root in get_subvol_name_from_objectid
      btrfs: hold a ref on the root in create_pending_snapshot
      btrfs: hold a ref on the root in btrfs_recover_log_trees
      btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry
      btrfs: export and rename free_fs_info
      btrfs: hold a ref on the root in open_ctree
      btrfs: use btrfs_put_fs_root to free roots always
      btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root
      btrfs: free more things in btrfs_free_fs_info
      btrfs: move fs_info init work into it's own helper function
      btrfs: make the init of static elements in fs_info separate
      btrfs: add a leak check for roots
      btrfs: rename btrfs_put_fs_root and btrfs_grab_fs_root
      btrfs: handle logged extent failure properly
      btrfs: bail out of uuid tree scanning if we're closing
      btrfs: set update the uuid generation as soon as possible
      btrfs: fix btrfs_calc_reclaim_metadata_size calculation
      btrfs: fix ref-verify to catch operations on 0 ref extents
      btrfs: drop block from cache on error in relocation
      btrfs: unset reloc control if we fail to recover
      btrfs: reloc: clean dirty subvols if we fail to start a transaction
      btrfs: do not init a reloc root if we aren't relocating
      btrfs: free the reloc_control in a consistent way
      btrfs: clear DEAD_RELOC_TREE before dropping the reloc root
      btrfs: hold a ref on the root->reloc_root
      btrfs: remove a BUG_ON() from merge_reloc_roots()
      btrfs: make the extent buffer leak check per fs info
      btrfs: move ino_cache_inode dropping out of btrfs_free_fs_root
      btrfs: move the root freeing stuff into btrfs_put_root
      btrfs: make inodes hold a ref on their roots
      btrfs: hold a ref on the root on the dead roots list
      btrfs: don't take an extra root ref at allocation time
      btrfs: make btrfs_cleanup_fs_roots use the radix tree lock
      btrfs: kill the subvol_srcu
      btrfs: do not use readahead for running delayed refs
      btrfs: do not readahead in build_backref_tree
      btrfs: reloc: reorder reservation before root selection
      btrfs: restart relocate_tree_blocks properly
      btrfs: track reloc roots based on their commit root bytenr
      btrfs: do not resolve backrefs for roots that are being deleted
      btrfs: use nofs allocations for running delayed items

Jules Irenge (1):
      btrfs: Add missing lock annotation for release_extent_buffer()

Madhuparna Bhowmik (1):
      btrfs: add RCU locks around block group initialization

Marcos Paulo de Souza (3):
      btrfs: export helpers for subvolume name/id resolution
      btrfs: add new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
      btrfs: ioctl: resize: only show message if size is changed

Naohiro Aota (21):
      btrfs: change full_search to bool in find_free_extent_update_loop
      btrfs: handle invalid profile in chunk allocation
      btrfs: introduce chunk allocation policy
      btrfs: refactor find_free_dev_extent_start()
      btrfs: introduce alloc_chunk_ctl
      btrfs: factor out init_alloc_chunk_ctl
      btrfs: factor out gather_device_info()
      btrfs: factor out decide_stripe_size()
      btrfs: factor out create_chunk()
      btrfs: parameterize dev_extent_min for chunk allocation
      btrfs: introduce extent allocation policy
      btrfs: move hint_byte into find_free_extent_ctl
      btrfs: move variables for clustered allocation into find_free_extent_ctl
      btrfs: factor out do_allocation() for extent allocation
      btrfs: drop unnecessary arguments from clustered allocation functions
      btrfs: factor out release_block_group()
      btrfs: factor out found_extent() for extent allocation
      btrfs: drop unnecessary arguments from find_free_extent_update_loop()
      btrfs: factor out chunk_allocation_failed() for extent allocation
      btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered allocation
      btrfs: factor out prepare_allocation() for extent allocation

Nikolay Borisov (25):
      btrfs: Perform pinned cleanup directly in btrfs_destroy_delayed_refs
      btrfs: Make btrfs_pin_extent take trans handle
      btrfs: Introduce unaccount_log_buffer
      btrfs: Call btrfs_pin_reserved_extent only during active transaction
      btrfs: Make btrfs_pin_reserved_extent take transaction handle
      btrfs: Make btrfs_pin_extent_for_log_replay take transaction handle
      btrfs: Make pin_down_extent take transaction handle
      btrfs: Pass transaction handle to write_pinned_extent_entries
      btrfs: Mark pinned log extents as excluded
      btrfs: Factor out pinned extent clean up in btrfs_delete_unused_bgs
      btrfs: switch to per-transaction pinned extents
      btrfs: Export btrfs_release_disk_super
      btrfs: call btrfs_check_uuid_tree_entry directly in btrfs_uuid_tree_iterate
      btrfs: make btrfs_check_uuid_tree private to disk-io.c
      btrfs: Implement DREW lock
      btrfs: convert snapshot/nocow exlcusion to drew lock
      btrfs: Rename __btrfs_alloc_chunk to btrfs_alloc_chunk
      btrfs: Remove impossible BUG_ON in get_tree_block_key
      btrfs: Open code insert_extent_backref
      btrfs: Remove __ prefix from btrfs_block_rsv_release
      btrfs: Remove block_rsv parameter from btrfs_drop_snapshot
      btrfs: account ticket size at add/delete time
      btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC support
      btrfs: Remove transid argument from btrfs_ioctl_snap_create_transid
      btrfs: Remove async_transid from btrfs_mksubvol/create_subvol/create_snapshot

Qu Wenruo (10):
      btrfs: Add overview of device replace
      btrfs: relocation: Add introduction of how relocation works
      btrfs: relocation: Remove is_cowonly_root()
      btrfs: Don't submit any btree write bio if the fs has errors
      btrfs: qgroup: ensure qgroup_rescan_running is only set when the worker is at least queued
      btrfs: qgroup: Remove the unnecesaary spin lock for qgroup_rescan_running
      btrfs: relocation: add error injection points for cancelling balance
      btrfs: relocation: Check cancel request after each data page read
      btrfs: relocation: Check cancel request after each extent found
      btrfs: relocation: Use btrfs_find_all_leafs to locate data extent parent tree leaves

Robbie Ko (1):
      btrfs: fix missing semaphore unlock in btrfs_sync_file

Roman Gushchin (1):
      btrfs: implement migratepage callback for data pages

Su Yue (1):
      btrfs: update the comment of btrfs_control_ioctl()

Takashi Iwai (1):
      btrfs: sysfs: Use scnprintf() instead of snprintf()

ethanwu (4):
      btrfs: backref, only collect file extent items matching backref offset
      btrfs: backref, don't add refs from shared block when resolving normal backref
      btrfs: backref, only search backref entries from leaves of the same root
      btrfs: backref, use correct count to resolve normal data refs

 fs/btrfs/Makefile             |    2 +-
 fs/btrfs/async-thread.c       |    8 +
 fs/btrfs/async-thread.h       |    1 +
 fs/btrfs/backref.c            |  185 +++++---
 fs/btrfs/backref.h            |    4 +
 fs/btrfs/block-group.c        |   87 ++--
 fs/btrfs/block-rsv.c          |  105 ++++-
 fs/btrfs/block-rsv.h          |   12 +-
 fs/btrfs/btrfs_inode.h        |    6 +
 fs/btrfs/check-integrity.c    |  200 ++------
 fs/btrfs/check-integrity.h    |    2 -
 fs/btrfs/ctree.c              |   74 +--
 fs/btrfs/ctree.h              |   82 ++--
 fs/btrfs/delalloc-space.c     |  106 ++++-
 fs/btrfs/delayed-inode.c      |   24 +-
 fs/btrfs/delayed-inode.h      |    2 +-
 fs/btrfs/delayed-ref.c        |    3 +-
 fs/btrfs/dev-replace.c        |   44 +-
 fs/btrfs/disk-io.c            |  914 ++++++++++++++++++-----------------
 fs/btrfs/disk-io.h            |   34 +-
 fs/btrfs/export.c             |   32 +-
 fs/btrfs/export.h             |    5 +
 fs/btrfs/extent-io-tree.h     |    7 +-
 fs/btrfs/extent-tree.c        |  493 ++++++++++---------
 fs/btrfs/extent_io.c          |  204 +++++---
 fs/btrfs/extent_io.h          |   11 +-
 fs/btrfs/file-item.c          |  131 ++++-
 fs/btrfs/file.c               |   80 ++--
 fs/btrfs/free-space-cache.c   |   43 +-
 fs/btrfs/free-space-tree.c    |    4 +-
 fs/btrfs/inode-map.c          |    2 +-
 fs/btrfs/inode.c              |  154 ++++--
 fs/btrfs/ioctl.c              | 1050 ++++++++---------------------------------
 fs/btrfs/locking.c            |  135 ++++++
 fs/btrfs/locking.h            |   20 +
 fs/btrfs/ordered-data.c       |  140 +-----
 fs/btrfs/ordered-data.h       |   10 +-
 fs/btrfs/props.c              |    2 +-
 fs/btrfs/qgroup.c             |   28 +-
 fs/btrfs/raid56.c             |   41 +-
 fs/btrfs/rcu-string.h         |    2 +-
 fs/btrfs/ref-verify.c         |    9 +
 fs/btrfs/reflink.c            |  804 +++++++++++++++++++++++++++++++
 fs/btrfs/reflink.h            |   12 +
 fs/btrfs/relocation.c         |  661 ++++++++++++--------------
 fs/btrfs/root-tree.c          |   43 +-
 fs/btrfs/scrub.c              |    7 +-
 fs/btrfs/send.c               |   79 +---
 fs/btrfs/space-info.c         |  202 +++++++-
 fs/btrfs/space-info.h         |    7 +
 fs/btrfs/super.c              |   35 +-
 fs/btrfs/sysfs.c              |   73 ++-
 fs/btrfs/sysfs.h              |    4 +-
 fs/btrfs/tests/btrfs-tests.c  |   44 +-
 fs/btrfs/tests/qgroup-tests.c |    2 +
 fs/btrfs/transaction.c        |  113 +++--
 fs/btrfs/transaction.h        |   13 +
 fs/btrfs/tree-log.c           |  483 +++++++++++--------
 fs/btrfs/uuid-tree.c          |   57 ++-
 fs/btrfs/volumes.c            |  774 ++++++++++++++++--------------
 fs/btrfs/volumes.h            |   12 +-
 include/linux/uuid.h          |   22 +-
 include/trace/events/btrfs.h  |    6 +-
 include/uapi/linux/btrfs.h    |   37 +-
 lib/uuid.c                    |   10 +
 65 files changed, 4462 insertions(+), 3536 deletions(-)
 create mode 100644 fs/btrfs/reflink.c
 create mode 100644 fs/btrfs/reflink.h
