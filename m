Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7454F14A811
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA0QbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 11:31:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:35112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgA0QbO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 11:31:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 23954AAC2;
        Mon, 27 Jan 2020 16:31:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F2AA7DA730; Mon, 27 Jan 2020 17:30:52 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.6
Date:   Mon, 27 Jan 2020 17:30:48 +0100
Message-Id: <cover.1580142284.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following updates for btrfs, thanks.

Features, highlights:

* async discard
  * "mount -o discard=async" to enable it
  * freed extents are not discarded immediatelly, but grouped together and
    trimmed later, with IO rate limiting
  * the "sync" mode submits short extents that could have been ignored
    completely by the device, for SATA prior to 3.1 the requests are
    unqueued and have a big impact on performance
  * the actual discard IO requests have been moved out of transaction
    commit to a worker thread, improving commit latency
  * IO rate and request size can be tuned by sysfs files, for now enabled
    only with CONFIG_BTRFS_DEBUG as we might need to add/delete the files
    and don't have a stable-ish ABI for general use, defaults are
    conservative

* export device state info in sysfs, eg. missing, writeable

* no discard of extents known to be untouched on disk (eg. after
  reservation)

* device stats reset is logged with process name and PID that called the
  ioctl

Fixes:

* fix missing hole after hole punching and fsync when using NO_HOLES

* writeback: range cyclic mode could miss some dirty pages and lead to OOM

* two more corner cases for metadata_uuid change after power loss during
  the change

* fix infinite loop during fsync after mix of rename operations

Core changes:

* qgroup assign returns ENOTCONN when quotas not enabled, used to return
  EINVAL that was confusing

* device closing does not need to allocate memory anymore

* snapshot aware code got removed, disabled for years due to performance
  problems, reimplmentation will allow to select wheter defrag breaks or
  does not break COW on shared extents

* tree-checker:
  * check leaf chunk item size, cross check against number of stripes
  * verify location keys for DIR_ITEM, DIR_INDEX and XATTR items

* new self test for physical -> logical mapping code, used for super block
  range exclusion

* assertion helpers/macros updated to avoid objtool "unreachable code"
  reports on older compilers or config option combinations

----------------------------------------------------------------
The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-tag

for you to fetch changes up to 4e19443da1941050b346f8fc4c368aa68413bc88:

  btrfs: free block groups after free'ing fs trees (2020-01-23 17:24:39 +0100)

----------------------------------------------------------------
Anand Jain (6):
      btrfs: sysfs, rename devices kobject holder to devices_kobj
      btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
      btrfs: sysfs, rename btrfs_sysfs_add_device()
      btrfs: sysfs, merge btrfs_sysfs_add devices_kobj and fsid
      btrfs: device stats, log when stats are zeroed
      btrfs: sysfs, add devid/dev_state kobject and device attributes

David Sterba (5):
      btrfs: use raid_attr table in calc_stripe_length for nparity
      btrfs: fill ncopies for all raid table entries
      btrfs: remove unused member btrfs_device::work
      btrfs: safely advance counter when looking up bio csums
      btrfs: separate definition of assertion failure handlers

Dennis Zhou (24):
      bitmap: genericize percpu bitmap region iterators
      btrfs: rename DISCARD mount option to to DISCARD_SYNC
      btrfs: keep track of which extents have been discarded
      btrfs: keep track of free space bitmap trim status cleanliness
      btrfs: add the beginning of async discard, discard workqueue
      btrfs: handle empty block_group removal for async discard
      btrfs: discard one region at a time in async discard
      btrfs: sysfs: add removal calls for debug/
      btrfs: sysfs: make UUID/debug have its own kobject
      btrfs: sysfs: add UUID/debug/discard directory
      btrfs: track discardable extents for async discard
      btrfs: keep track of discardable_bytes for async discard
      btrfs: calculate discard delay based on number of extents
      btrfs: add kbps discard rate limit for async discard
      btrfs: limit max discard size for async discard
      btrfs: make max async discard size tunable
      btrfs: have multiple discard lists
      btrfs: only keep track of data extents for async discard
      btrfs: keep track of discard reuse stats
      btrfs: add async discard implementation overview
      btrfs: increase the metadata allowance for the free_space_cache
      btrfs: make smaller extents more likely to go into bitmaps
      btrfs: ensure removal of discardable_* in free_bitmap()
      btrfs: add correction to handle -1 edge case in async discard

Filipe Manana (2):
      Btrfs: fix missing hole after hole punching and fsync when using NO_HOLES
      Btrfs: fix infinite loop during fsync after rename operations

Johannes Thumshirn (6):
      btrfs: fix possible NULL-pointer dereference in integrity checks
      btrfs: remove superfluous BUG_ON() in integrity checks
      btrfs: remove impossible WARN_ON in btrfs_destroy_dev_replace_tgtdev()
      btrfs: decrement number of open devices after closing the device not before
      btrfs: reset device back to allocation state when removing
      btrfs: remove unnecessary wrapper get_alloc_profile

Josef Bacik (6):
      btrfs: don't pass system_chunk into can_overcommit
      btrfs: kill min_allocable_bytes in inc_block_group_ro
      btrfs: fix improper setting of scanned for range cyclic write cache pages
      btrfs: drop log root for dropped roots
      btrfs: set trans->drity in btrfs_commit_transaction
      btrfs: free block groups after free'ing fs trees

Marcos Paulo de Souza (2):
      btrfs: qgroup: remove one-time use variables for quota_root checks
      btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not enabled

Nikolay Borisov (12):
      btrfs: Don't discard unwritten extents
      btrfs: Open code __btrfs_free_reserved_extent in btrfs_free_reserved_extent
      btrfs: Rename __btrfs_free_reserved_extent to btrfs_pin_reserved_extent
      btrfs: Remove WARN_ON in walk_log_tree
      btrfs: Remove redundant WARN_ON in walk_down_log_tree
      btrfs: Opencode ordered_data_tree_panic
      btrfs: Move and unexport btrfs_rmap_block
      btrfs: selftests: Add support for dummy devices
      btrfs: Add self-tests for btrfs_rmap_block
      btrfs: Refactor btrfs_rmap_block to improve readability
      btrfs: Handle another split brain scenario with metadata uuid feature
      btrfs: Fix split-brain handling when changing FSID to metadata uuid

Omar Sandoval (11):
      btrfs: use simple_dir_inode_operations for placeholder subvolume directory
      btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
      btrfs: get rid of at_offset parameter to btrfs_lookup_bio_sums()
      btrfs: remove dead snapshot-aware defrag code
      btrfs: make btrfs_ordered_extent naming consistent with btrfs_file_extent_item
      btrfs: remove unnecessary pg_offset assignments in __extent_writepage()
      btrfs: remove trivial goto label in __extent_writepage()
      btrfs: remove redundant i_size check in __extent_writepage_io()
      btrfs: drop create parameter to btrfs_get_extent()
      btrfs: simplify compressed/inline check in __extent_writepage_io()
      btrfs: remove struct find_free_extent.ram_bytes

Qu Wenruo (6):
      btrfs: relocation: Output current relocation stage at btrfs_relocate_block_group()
      btrfs: tree-checker: Check leaf chunk item size
      btrfs: tree-checker: Clean up fs_info parameter from error message wrapper
      btrfs: tree-checker: Refactor inode key check into seperate function
      btrfs: tree-checker: Refactor root key check into separate function
      btrfs: tree-checker: Verify location key for DIR_ITEM/DIR_INDEX

Su Yue (2):
      btrfs: Call find_fsid from find_fsid_inprogress
      btrfs: Factor out metadata_uuid code from find_fsid.

Yunfeng Ye (1):
      btrfs: remove unused condition check in btrfs_page_mkwrite()

zhengbin (1):
      btrfs: Remove unneeded semicolon

 fs/btrfs/Makefile                 |   2 +-
 fs/btrfs/block-group.c            | 212 ++++++++--
 fs/btrfs/block-group.h            |  40 ++
 fs/btrfs/check-integrity.c        |   4 +-
 fs/btrfs/compression.c            |   4 +-
 fs/btrfs/ctree.h                  |  81 +++-
 fs/btrfs/dev-replace.c            |   1 +
 fs/btrfs/discard.c                | 702 ++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h                |  41 ++
 fs/btrfs/disk-io.c                |  37 +-
 fs/btrfs/disk-io.h                |   4 +-
 fs/btrfs/extent-tree.c            |  50 +--
 fs/btrfs/extent_io.c              |  54 +--
 fs/btrfs/extent_io.h              |   6 +-
 fs/btrfs/file-item.c              |  41 +-
 fs/btrfs/file.c                   |  23 +-
 fs/btrfs/free-space-cache.c       | 619 ++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h       |  41 +-
 fs/btrfs/inode-map.c              |  13 +-
 fs/btrfs/inode.c                  | 834 ++++----------------------------------
 fs/btrfs/ioctl.c                  |   2 +-
 fs/btrfs/ordered-data.c           |  81 ++--
 fs/btrfs/ordered-data.h           |  26 +-
 fs/btrfs/print-tree.c             |   2 +-
 fs/btrfs/qgroup.c                 |  44 +-
 fs/btrfs/relocation.c             |  20 +-
 fs/btrfs/scrub.c                  |   7 +-
 fs/btrfs/space-info.c             |  42 +-
 fs/btrfs/super.c                  |  39 +-
 fs/btrfs/sysfs.c                  | 394 ++++++++++++++++--
 fs/btrfs/sysfs.h                  |   5 +-
 fs/btrfs/tests/btrfs-tests.c      |  29 ++
 fs/btrfs/tests/btrfs-tests.h      |   1 +
 fs/btrfs/tests/extent-map-tests.c | 154 ++++++-
 fs/btrfs/tests/inode-tests.c      |  44 +-
 fs/btrfs/transaction.c            |  30 +-
 fs/btrfs/tree-checker.c           | 225 +++++++---
 fs/btrfs/tree-log.c               | 455 +++++++--------------
 fs/btrfs/volumes.c                | 284 ++++++-------
 fs/btrfs/volumes.h                |  10 +-
 include/linux/bitmap.h            |  35 ++
 include/trace/events/btrfs.h      |   6 +-
 mm/percpu.c                       |  61 +--
 43 files changed, 3042 insertions(+), 1763 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h
