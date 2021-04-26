Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2933036BA85
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbhDZUCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 16:02:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:44580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241785AbhDZUCM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 16:02:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619467289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hhmMue4wFDzUcfHHTz2GRC6I6Q4mpO4N5AXEH3ko3V8=;
        b=mswcfgGyTnEmWPjM9oA1XeC8NME+PqAGJN8PCiOtGuZIW7WYKRiBZU9BCJ4/P+z6mo+35Z
        Mzwtl0s2Xort0UBZnBuRSaTBEbAueyq2rqdYzc+sbNCD6eYmClHxH1GP1gOTqdM3E2xnN1
        fQj16YNw0il/+1IGx34vvuY9qqNr/Xo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A078AE72;
        Mon, 26 Apr 2021 20:01:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8755DDA7F9; Mon, 26 Apr 2021 21:59:07 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.13
Date:   Mon, 26 Apr 2021 21:59:06 +0200
Message-Id: <cover.1619466460.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

the updates this time are mostly stabilization, preparation and minor
improvements.

Please pull, thanks.

User visible improvements:

- readahead for send, improving run time of full send by 10% and for
  incremental by 25%

- make reflinks respect O_SYNC, O_DSYNC and S_SYNC flags

- export supported sectorsize values in sysfs (currently only page size,
  more once full subpage support lands)

- more graceful errors and warnings on 32bit systems when logical
  addresses for metadata reach the limit posed by unsigned long in
  page::index
  - error: fail mount if there's a metadata block beyond the limit
  - error: new metadata block would be at unreachable address
  - warn when 5/8th of the limit is reached, for 4K page systems it's
    10T, for 64K page it's 160T

- zoned mode
  - relocated zones get reset at the end instead of discard
  - automatic background reclaim of zones that have 75%+ of unusable
    space, the threshold is tunable in sysfs

Fixes:

- fsync and tree mod log fixes

- fix inefficient preemptive reclaim calculations

- fix exhaustion of the system chunk array due to concurrent allocations

- fix fallback to no compression when racing with remount

- preemptive fix for dm-crypt on zoned device that does not properly
  advertise zoned support

Core changes:

- add inode lock to synchronize mmap and other block updates (eg.
  deduplication, fallocate, fsync)

- kmap conversions to new kmap_local API

- subpage support (continued)
  - new helpers for page state/extent buffer tracking
  - metadata changes now support read and write

- error handling through out relocation call paths

- many other cleanups and code simplifications

----------------------------------------------------------------
The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-tag

for you to fetch changes up to 18bb8bbf13c1839b43c9e09e76d397b753989af2:

  btrfs: zoned: automatically reclaim zones (2021-04-20 20:46:31 +0200)

----------------------------------------------------------------
Anand Jain (3):
      btrfs: unexport btrfs_extent_readonly() and make it static
      btrfs: change return type to bool in btrfs_extent_readonly
      btrfs: scrub: drop a few function declarations

Arnd Bergmann (1):
      btrfs: zoned: bail out in btrfs_alloc_chunk for bad input

BingJing Chang (1):
      btrfs: fix a potential hole punching failure

Filipe Manana (21):
      btrfs: add btree read ahead for full send operations
      btrfs: add btree read ahead for incremental send operations
      btrfs: fix race between memory mapped writes and fsync
      btrfs: fix race between marking inode needs to be logged and log syncing
      btrfs: remove stale comment and logic from btrfs_inode_in_log()
      btrfs: move the tree mod log code into its own file
      btrfs: use booleans where appropriate for the tree mod log functions
      btrfs: use a bit to track the existence of tree mod log users
      btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at btrfs_free_tree_block()
      btrfs: remove unnecessary leaf check at btrfs_tree_mod_log_free_eb()
      btrfs: add and use helper to get lowest sequence number for the tree mod log
      btrfs: update debug message when checking seq number of a delayed ref
      btrfs: update outdated comment at btrfs_orphan_cleanup()
      btrfs: update outdated comment at btrfs_replace_file_extents()
      btrfs: make reflinks respect O_SYNC O_DSYNC and S_SYNC flags
      btrfs: fix exhaustion of the system chunk array due to concurrent allocations
      btrfs: improve btree readahead for full send operations
      btrfs: fix race between transaction aborts and fsyncs leading to use-after-free
      btrfs: fix metadata extent leak after failure to create subvolume
      btrfs: fix race when picking most recent mod log operation for an old root
      btrfs: zoned: fix unpaired block group unfreeze during device replace

Goldwyn Rodrigues (2):
      btrfs: remove force argument from run_delalloc_nocow()
      btrfs: remove mirror argument from btrfs_csum_verify_data()

Ira Weiny (4):
      btrfs: convert kmap to kmap_local_page, simple cases
      btrfs: raid56: convert kmaps to kmap_local_page
      btrfs: integrity-checker: use kmap_local_page in __btrfsic_submit_bio
      btrfs: integrity-checker: convert block context kmap's to kmap_local_page

Jiapeng Chong (1):
      btrfs: assign proper values to a bool variable in dev_extent_hole_check_zoned

Johannes Thumshirn (5):
      btrfs: remove duplicated in_range() macro
      btrfs: zoned: fail mount if the device does not support zone append
      btrfs: zoned: reset zones of relocated block groups
      btrfs: rename delete_unused_bgs_mutex to reclaim_bgs_lock
      btrfs: zoned: automatically reclaim zones

Josef Bacik (44):
      btrfs: add a i_mmap_lock to our inode
      btrfs: use btrfs_inode_lock/btrfs_inode_unlock inode lock helpers
      btrfs: exclude mmaps while doing remap
      btrfs: exclude mmap from happening during all fallocate operations
      btrfs: use percpu_read_positive instead of sum_positive for need_preempt
      btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
      btrfs: convert BUG_ON()'s in relocate_tree_block
      btrfs: handle errors from select_reloc_root()
      btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
      btrfs: check record_root_in_trans related failures in select_reloc_root
      btrfs: do proper error handling in record_reloc_root_in_trans
      btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
      btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
      btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
      btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
      btrfs: handle btrfs_record_root_in_trans failure in create_subvol
      btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
      btrfs: handle btrfs_record_root_in_trans failure in start_transaction
      btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
      btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
      btrfs: handle record_root_in_trans failure in create_pending_snapshot
      btrfs: return an error from btrfs_record_root_in_trans
      btrfs: have proper error handling in btrfs_init_reloc_root
      btrfs: do proper error handling in create_reloc_root
      btrfs: validate root::reloc_root after recording root in trans
      btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
      btrfs: change insert_dirty_subvol to return errors
      btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
      btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
      btrfs: do proper error handling in btrfs_update_reloc_root
      btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
      btrfs: handle btrfs_cow_block errors in replace_path
      btrfs: handle btrfs_search_slot failure in replace_path
      btrfs: handle errors in reference count manipulation in replace_path
      btrfs: handle extent reference errors in do_relocation
      btrfs: tree-checker: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
      btrfs: remove the extent item sanity checks in relocate_block_group
      btrfs: do proper error handling in create_reloc_inode
      btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
      btrfs: do not panic in __add_reloc_root
      btrfs: cleanup error handling in prepare_to_merge
      btrfs: handle extent corruption with select_one_root properly
      btrfs: do proper error handling in merge_reloc_roots
      btrfs: check return value of btrfs_commit_transaction in relocation

Matthew Wilcox (Oracle) (1):
      btrfs: add and use readahead_batch_length

Naohiro Aota (1):
      btrfs: zoned: move log tree node allocation out of log_root_tree->log_mutex

Nikolay Borisov (8):
      btrfs: make btrfs_replace_file_extents take btrfs_inode
      btrfs: make find_desired_extent take btrfs_inode
      btrfs: replace offset_in_entry with in_range
      btrfs: replace open coded while loop with proper construct
      btrfs: simplify commit logic in try_flush_qgroup
      btrfs: remove btrfs_inode parameter from btrfs_delayed_inode_reserve_metadata
      btrfs: simplify code flow in btrfs_delayed_inode_reserve_metadata
      btrfs: don't opencode extent_changeset_free

Qu Wenruo (19):
      btrfs: fix comment for btrfs ordered extent flag bits
      btrfs: add sysfs interface for supported sectorsize
      btrfs: use min() to replace open-code in btrfs_invalidatepage()
      btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
      btrfs: subpage: introduce helpers for dirty status
      btrfs: subpage: introduce helpers for writeback status
      btrfs: subpage: do more sanity checks on metadata page dirtying
      btrfs: subpage: support metadata checksum calculation at write time
      btrfs: make alloc_extent_buffer() check subpage dirty bitmap
      btrfs: support page uptodate assertions in subpage mode
      btrfs: make set/clear_extent_buffer_dirty() subpage compatible
      btrfs: make set_btree_ioerr accept extent buffer and be subpage compatible
      btrfs: subpage: add overview comments
      btrfs: introduce end_bio_subpage_eb_writepage() function
      btrfs: introduce write_one_subpage_eb() function
      btrfs: make lock_extent_buffer_for_io() to be subpage compatible
      btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
      btrfs: handle remount to no compress during compression
      btrfs: more graceful errors/warnings on 32bit systems when reaching limits

Wan Jiabing (1):
      btrfs: move forward declarations to the beginning of extent_io.h

 fs/btrfs/Makefile            |   2 +-
 fs/btrfs/backref.c           |  33 +-
 fs/btrfs/block-group.c       | 207 ++++++++-
 fs/btrfs/block-group.h       |   3 +
 fs/btrfs/btrfs_inode.h       |  33 +-
 fs/btrfs/check-integrity.c   |  14 +-
 fs/btrfs/compression.c       |  15 +-
 fs/btrfs/ctree.c             | 984 +++----------------------------------------
 fs/btrfs/ctree.h             |  80 ++--
 fs/btrfs/delayed-inode.c     |  35 +-
 fs/btrfs/delayed-ref.c       |  31 +-
 fs/btrfs/disk-io.c           | 162 +++++--
 fs/btrfs/extent-tree.c       |  21 +-
 fs/btrfs/extent_io.c         | 439 ++++++++++++++++---
 fs/btrfs/extent_io.h         |   4 +-
 fs/btrfs/file-item.c         |   1 +
 fs/btrfs/file.c              | 118 +++---
 fs/btrfs/free-space-cache.c  |   9 +-
 fs/btrfs/inode.c             | 125 +++---
 fs/btrfs/ioctl.c             |  51 ++-
 fs/btrfs/lzo.c               |   9 +-
 fs/btrfs/ordered-data.c      |  19 +-
 fs/btrfs/ordered-data.h      |   4 +-
 fs/btrfs/qgroup.c            |  47 +--
 fs/btrfs/raid56.c            |  70 +--
 fs/btrfs/reflink.c           |  65 ++-
 fs/btrfs/relocation.c        | 448 +++++++++++++++-----
 fs/btrfs/scrub.c             |  13 +-
 fs/btrfs/send.c              |  43 +-
 fs/btrfs/space-info.c        |   4 +-
 fs/btrfs/subpage.c           | 140 ++++++
 fs/btrfs/subpage.h           |   7 +
 fs/btrfs/super.c             |  26 ++
 fs/btrfs/sysfs.c             |  50 +++
 fs/btrfs/transaction.c       |  59 ++-
 fs/btrfs/transaction.h       |   9 +-
 fs/btrfs/tree-checker.c      |   5 +
 fs/btrfs/tree-log.c          |  21 +-
 fs/btrfs/tree-mod-log.c      | 929 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-mod-log.h      |  53 +++
 fs/btrfs/volumes.c           | 123 ++++--
 fs/btrfs/volumes.h           |   1 +
 fs/btrfs/zoned.c             |   7 +
 fs/btrfs/zoned.h             |   6 +
 include/linux/pagemap.h      |   9 +
 include/trace/events/btrfs.h |  12 +
 46 files changed, 2964 insertions(+), 1582 deletions(-)
 create mode 100644 fs/btrfs/tree-mod-log.c
 create mode 100644 fs/btrfs/tree-mod-log.h
