Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B587DBF3E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjJ3RmJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjJ3RmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 13:42:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7A9C;
        Mon, 30 Oct 2023 10:42:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02B391FD91;
        Mon, 30 Oct 2023 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698687723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wACBdOFb6STjmPZ65T6qXGq/FF13z4B1T83IY8oXR3k=;
        b=c04hO3Mmg/TTO+ttl2njonBwzIN4Ov2cyzk8DXlVqLb4uVDHpP4fPXLK7P1vjzjxgELzHs
        XsHJV4FszBCD9wQXPqMbFjIGznifZ/7ObWq6I8Pp1Ico3m9PIp5QYNjDBXsKmauArfBIAj
        TVmKJnSPBdviVVhNjutEzharWdt4jJw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A5E062CEC5;
        Mon, 30 Oct 2023 17:42:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C88F4DA83C; Mon, 30 Oct 2023 18:35:06 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.7
Date:   Mon, 30 Oct 2023 18:35:03 +0100
Message-ID: <cover.1698679287.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this time around we have 3 new features, described below, and the rest
is refactoring, cleanups and some performance improvements.

The branch for this pull request is base for the vfs timestamps updates
(https://lore.kernel.org/all/20231027-vfs-ctime-6271b23ced64@brauner/)
and there will be merge conflicts.

I'll send another pull request for btrfs with fixes and minor cleanups
that have been sent after the base branch for vfs was frozen. The
patches would have been part of this pull request but sending them
separately will reduce merge conflicts with vfs branches.  (Branch
for-6.7-part2).  I can pick only the fixes and send them after rc1 if
you'd prefer that.

Please pull, thanks.

New features:

- raid-stripe-tree
  New tree for logical file extent mapping where the physical mapping
  may not match on multiple devices. This is now used in zoned mode to
  implement RAID0/RAID1* profiles, but can be used in non-zoned mode as
  well. The support for RAID56 is in development and will eventually
  fix the problems with the current implementation. This is a backward
  incompatible feature and has to be enabled at mkfs time.

- simple quota accounting (squota)
  A simplified mode of qgroup that accounts all space on the initial
  extent owners (a subvolume), the snapshots are then cheap to create
  and delete. The deletion of snapshots in fully accounting qgroups is a
  known CPU/IO performance bottleneck.
  The squota is not suitable for the general use case but works well for
  containers where the original subvolume exists for the whole time.
  This is a backward incompatible feature as it needs extending some
  structures, but can be enabled on an existing filesystem.

- temporary filesystem fsid (temp_fsid)
  The fsid identifies a filesystem and is hard coded in the structures,
  which disallows mounting the same fsid found on different devices.
  For a single device filesystem this is not strictly necessary, a new
  temporary fsid can be generated on mount e.g. after a device is
  cloned. This will be used by Steam Deck for root partition A/B
  testing, or can be used for VM root images.

Other user visible changes:

- filesystems with partially finished metadata_uuid conversion cannot
  be mounted anymore and the uuid fixup has to be done by btrfs-progs
  (btrfstune).

Performance improvements:

- reduce reservations for checksum deletions (with enabled free space
  tree by factor of 4), on a sample workload on file with many extents
  the deletion time decreased by 12%

- make extent state merges more efficient during insertions, reduce
  rb-tree iterations (run time of critical functions reduced by 5%)

Core changes:

- the integrity check functionality has been removed, this was a
  debugging feature and removal does not affect other integrity checks
  like checksums or tree-checker

- space reservation changes
  - more efficient delayed ref reservations, this avoids building up too
    much work or overusing or exhausting the global block reserve in
    some situations
  - move delayed refs reservation to the transaction start time, this
    prevents some ENOSPC corner cases related to exhaustion of global
    reserve
  - improvements in reducing excessive reservations for block group
    items
  - adjust overcommit logic in near full situations, account for one
    more chunk to eventually allocate metadata chunk, this is mostly
    relevant for small filesystems (<10GiB)

- single device filesystems are scanned but not registered (except seed
  devices), this allows temp_fsid to work

- qgroup iterations do not need GFP_ATOMIC allocations anymore

- cleanups, refactoring, reduced data structure size, function parameter
  simplifications, error handling fixes

----------------------------------------------------------------
The following changes since commit 401644852d0b2a278811de38081be23f74b5bb04:

  Merge tag 'fs_for_v6.6-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2023-10-11 14:21:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-tag

for you to fetch changes up to c6e8f898f56fae2cb5bc4396bec480f23cd8b066:

  btrfs: open code timespec64 in struct btrfs_inode (2023-10-12 16:44:19 +0200)

----------------------------------------------------------------
Anand Jain (11):
      btrfs: sipmlify uuid parameters of alloc_fs_devices()
      btrfs: comment about fsid and metadata_uuid relationship
      btrfs: scan but don't register device on single device filesystem
      btrfs: reject devices with CHANGING_FSID_V2
      btrfs: remove incomplete metadata_uuid conversion fixup logic
      btrfs: add helper function find_fsid_by_disk
      btrfs: support cloned-device mount capability
      btrfs: update comment for temp-fsid, fsid, and metadata_uuid
      btrfs: disable the seed feature for temp-fsid
      btrfs: disable the device add feature for temp-fsid
      btrfs: sysfs: show temp_fsid feature

Boris Burkov (18):
      btrfs: qgroup: introduce quota mode
      btrfs: qgroup: add new quota mode for simple quotas
      btrfs: sysfs: expose quota mode via sysfs
      btrfs: sysfs: add simple_quota incompat feature entry
      btrfs: qgroup: flush reservations during quota disable
      btrfs: create qgroup earlier in snapshot creation
      btrfs: add helper for recording simple quota deltas
      btrfs: rename tree_ref and data_ref owning_root
      btrfs: track owning root in btrfs_ref
      btrfs: track original extent owner in head_ref
      btrfs: new inline ref storing owning subvol of data extents
      btrfs: add helper for inline owner ref lookup
      btrfs: record simple quota deltas in delayed refs
      btrfs: qgroup: simple quota auto hierarchy for nested subvolumes
      btrfs: qgroup: check generation when recording simple quota delta
      btrfs: qgroup: track metadata relocation COW with simple quota
      btrfs: track data relocation with simple quota
      btrfs: qgroup: only set QUOTA_ENABLED when done reading qgroups

Christoph Hellwig (4):
      btrfs: zoned: introduce a zone_info struct in btrfs_load_block_group_zone_info
      btrfs: zoned: factor out per-zone logic from btrfs_load_block_group_zone_info
      btrfs: zoned: factor out single bg handling from btrfs_load_block_group_zone_info
      btrfs: zoned: factor out DUP bg handling from btrfs_load_block_group_zone_info

Colin Ian King (1):
      btrfs: remove redundant initialization of variable dirty in btrfs_update_time()

David Sterba (24):
      btrfs: move functions comments from qgroup.h to qgroup.c
      btrfs: reformat remaining kdoc style comments
      btrfs: drop __must_check annotations
      btrfs: reduce parameters of btrfs_pin_reserved_extent
      btrfs: reduce parameters of btrfs_pin_extent_for_log_replay
      btrfs: reduce arguments of helpers space accounting root item
      btrfs: reduce size of prelim_ref::level
      btrfs: reduce size and reorder compression members in struct btrfs_inode
      btrfs: reduce size of struct btrfs_ref
      btrfs: move extent_buffer::lock_owner to debug section
      btrfs: rename errno identifiers to error
      btrfs: merge ordered work callbacks in btrfs_work into one
      btrfs: relocation: use more natural types for tree_block bitfields
      btrfs: relocation: use enum for stages
      btrfs: relocation: switch bitfields to bool in reloc_control
      btrfs: relocation: open code mapping_tree_init
      btrfs: switch btrfs_backref_cache::is_reloc to bool
      btrfs: relocation: return bool from btrfs_should_ignore_reloc_root
      btrfs: relocation: constify parameters where possible
      btrfs: add specific helper for range bit test exists
      btrfs: change test_range_bit to scan the whole range
      btrfs: open code btrfs_ordered_inode_tree in btrfs_inode
      btrfs: reorder btrfs_inode to fill gaps
      btrfs: open code timespec64 in struct btrfs_inode

Filipe Manana (55):
      btrfs: update comment for reservation of metadata space for delayed items
      btrfs: pass a space_info argument to btrfs_reserve_metadata_bytes()
      btrfs: remove unnecessary logic when running new delayed references
      btrfs: remove the refcount warning/check at btrfs_put_delayed_ref()
      btrfs: remove refs_to_add argument from __btrfs_inc_extent_ref()
      btrfs: remove refs_to_drop argument from __btrfs_free_extent()
      btrfs: initialize key where it's used when running delayed data ref
      btrfs: remove pointless 'ref_root' variable from run_delayed_data_ref()
      btrfs: use a single variable for return value at run_delayed_extent_op()
      btrfs: use a single variable for return value at lookup_inline_extent_backref()
      btrfs: return -EUCLEAN if extent item is missing when searching inline backref
      btrfs: simplify check for extent item overrun at lookup_inline_extent_backref()
      btrfs: allow to run delayed refs by bytes to be released instead of count
      btrfs: reserve space for delayed refs on a per ref basis
      btrfs: remove pointless initialization at btrfs_delayed_refs_rsv_release()
      btrfs: stop doing excessive space reservation for csum deletion
      btrfs: always reserve space for delayed refs when starting transaction
      btrfs: abort transaction on generation mismatch when marking eb as dirty
      btrfs: use btrfs_crit at btrfs_mark_buffer_dirty()
      btrfs: mark transaction id check as unlikely at btrfs_mark_buffer_dirty()
      btrfs: remove pointless loop from btrfs_update_block_group()
      btrfs: remove stale comment from btrfs_free_extent()
      btrfs: remove useless comment from btrfs_pin_extent_for_log_replay()
      btrfs: simplify error check condition at btrfs_dirty_inode()
      btrfs: remove noinline from btrfs_update_inode()
      btrfs: remove redundant root argument from btrfs_update_inode_fallback()
      btrfs: remove redundant root argument from btrfs_update_inode()
      btrfs: remove redundant root argument from btrfs_update_inode_item()
      btrfs: remove redundant root argument from btrfs_delayed_update_inode()
      btrfs: remove redundant root argument from maybe_insert_hole()
      btrfs: remove redundant root argument from fixup_inode_link_count()
      btrfs: move btrfs_defrag_root() to defrag.{c,h}
      btrfs: remove noinline attribute from btrfs_cow_block()
      btrfs: use round_down() to align block offset at btrfs_cow_block()
      btrfs: rename and export __btrfs_cow_block()
      btrfs: export comp_keys() from ctree.c as btrfs_comp_keys()
      btrfs: move btrfs_realloc_node() from ctree.c into defrag.c
      btrfs: make extent state merges more efficient during insertions
      btrfs: update stale comment at extent_io_tree_release()
      btrfs: make wait_extent_bit() static
      btrfs: remove redundant memory barrier from extent_io_tree_release()
      btrfs: collapse wait_on_state() to its caller wait_extent_bit()
      btrfs: make tree iteration in extent_io_tree_release() more efficient
      btrfs: use extent_io_tree_release() to empty dirty log pages
      btrfs: make sure we cache next state in find_first_extent_bit()
      btrfs: stop reserving excessive space for block group item updates
      btrfs: stop reserving excessive space for block group item insertions
      btrfs: add and use helpers for reading and writing last_log_commit
      btrfs: add and use helpers for reading and writing log_transid
      btrfs: add and use helpers for reading and writing fs_info->generation
      btrfs: add and use helpers for reading and writing last_trans_committed
      btrfs: remove pointless barrier from btrfs_sync_file()
      btrfs: update comment for struct btrfs_inode::lock
      btrfs: remove pointless empty log context list check when syncing log
      btrfs: remove redundant log root tree index assignment during log sync

Jiapeng Chong (1):
      btrfs: qgroup: remove unused helpers for ulist aux data

Johannes Thumshirn (12):
      btrfs: add raid stripe tree definitions
      btrfs: read raid stripe tree from disk
      btrfs: add support for inserting raid stripe extents
      btrfs: delete stripe extent on extent deletion
      btrfs: lookup physical address from stripe extent
      btrfs: scrub: implement raid stripe tree support
      btrfs: zoned: support RAID0/1/10 on top of raid stripe tree
      btrfs: add raid stripe tree pretty printer
      btrfs: sysfs: announce presence of raid-stripe-tree
      btrfs: tracepoints: add events for raid stripe tree
      btrfs: tree-checker: add support for raid stripe tree
      btrfs: add raid stripe tree to features enabled with debug config

Josef Bacik (15):
      btrfs: move btrfs_crc32c_final into free-space-cache.c
      btrfs: remove btrfs_crc32c wrapper
      btrfs: move btrfs_extref_hash into inode-item.h
      btrfs: move btrfs_name_hash to dir-item.h
      btrfs: include asm/unaligned.h in accessors.h
      btrfs: include linux/iomap.h in file.c
      btrfs: add fscrypt related dependencies to respective headers
      btrfs: add btrfs_delayed_ref_head declaration to extent-tree.h
      btrfs: include trace header in where necessary
      btrfs: include linux/security.h in super.c
      btrfs: remove extraneous includes from ctree.h
      btrfs: don't arbitrarily slow down delalloc if we're committing
      btrfs: fix ->free_chunk_space math in btrfs_shrink_device
      btrfs: increase ->free_chunk_space in btrfs_grow_device
      btrfs: adjust overcommit logic when very close to full

Qu Wenruo (15):
      btrfs: do not require EXTENT_NOWAIT for btrfs_redirty_list_add()
      btrfs: qgroup: iterate qgroups without memory allocation for qgroup_reserve()
      btrfs: qgroup: use qgroup_iterator in btrfs_qgroup_free_refroot()
      btrfs: qgroup: use qgroup_iterator in qgroup_convert_meta()
      btrfs: qgroup: use qgroup_iterator in __qgroup_excl_accounting()
      btrfs: qgroup: use qgroup_iterator to replace tmp ulist in qgroup_update_refcnt()
      btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt()
      btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage
      btrfs: qgroup: prealloc btrfs_qgroup_list for __add_relation_rb()
      btrfs: check-integrity: remove btrfsic_check_bio() function
      btrfs: check-integrity: remove btrfsic_mount() function
      btrfs: check-integrity: remove btrfsic_unmount() function
      btrfs: check-integrity: remove CONFIG_BTRFS_FS_CHECK_INTEGRITY option
      btrfs: remove the need_raid_map parameter from btrfs_map_block()
      btrfs: warn on tree blocks which are not nodesize aligned

 fs/btrfs/Kconfig                     |   21 -
 fs/btrfs/Makefile                    |    3 +-
 fs/btrfs/accessors.h                 |   16 +
 fs/btrfs/async-thread.c              |   12 +-
 fs/btrfs/async-thread.h              |    6 +-
 fs/btrfs/backref.c                   |    5 +-
 fs/btrfs/backref.h                   |   10 +-
 fs/btrfs/bio.c                       |   47 +-
 fs/btrfs/block-group.c               |  178 +--
 fs/btrfs/block-rsv.c                 |   24 +-
 fs/btrfs/btrfs_inode.h               |   80 +-
 fs/btrfs/check-integrity.c           | 2871 ----------------------------------
 fs/btrfs/check-integrity.h           |   20 -
 fs/btrfs/compression.c               |    6 +-
 fs/btrfs/ctree.c                     |  340 ++--
 fs/btrfs/ctree.h                     |  142 +-
 fs/btrfs/defrag.c                    |  152 +-
 fs/btrfs/defrag.h                    |    2 +-
 fs/btrfs/delalloc-space.c            |    6 +-
 fs/btrfs/delayed-inode.c             |   27 +-
 fs/btrfs/delayed-inode.h             |    1 -
 fs/btrfs/delayed-ref.c               |  199 ++-
 fs/btrfs/delayed-ref.h               |   70 +-
 fs/btrfs/dev-replace.c               |    3 +-
 fs/btrfs/dir-item.c                  |    8 +-
 fs/btrfs/dir-item.h                  |    9 +
 fs/btrfs/disk-io.c                   |  142 +-
 fs/btrfs/disk-io.h                   |    3 +-
 fs/btrfs/extent-io-tree.c            |  272 ++--
 fs/btrfs/extent-io-tree.h            |    7 +-
 fs/btrfs/extent-tree.c               |  538 ++++---
 fs/btrfs/extent-tree.h               |   15 +-
 fs/btrfs/extent_io.c                 |   39 +-
 fs/btrfs/extent_io.h                 |    4 +-
 fs/btrfs/file-item.c                 |   17 +-
 fs/btrfs/file.c                      |   61 +-
 fs/btrfs/free-space-cache.c          |   28 +-
 fs/btrfs/free-space-tree.c           |   17 +-
 fs/btrfs/fs.h                        |   69 +-
 fs/btrfs/inode-item.c                |   21 +-
 fs/btrfs/inode-item.h                |    8 +
 fs/btrfs/inode.c                     |  182 +--
 fs/btrfs/ioctl.c                     |   23 +-
 fs/btrfs/locking.c                   |   20 +-
 fs/btrfs/messages.c                  |   32 +-
 fs/btrfs/messages.h                  |   14 +-
 fs/btrfs/ordered-data.c              |  127 +-
 fs/btrfs/ordered-data.h              |   17 +-
 fs/btrfs/print-tree.c                |   35 +
 fs/btrfs/props.c                     |    1 +
 fs/btrfs/qgroup.c                    |  872 +++++++----
 fs/btrfs/qgroup.h                    |  149 +-
 fs/btrfs/raid-stripe-tree.c          |  274 ++++
 fs/btrfs/raid-stripe-tree.h          |   50 +
 fs/btrfs/ref-verify.c                |    9 +-
 fs/btrfs/reflink.c                   |    3 +-
 fs/btrfs/relocation.c                |  208 ++-
 fs/btrfs/relocation.h                |    9 +-
 fs/btrfs/root-tree.c                 |   12 +-
 fs/btrfs/root-tree.h                 |    8 +-
 fs/btrfs/scrub.c                     |   78 +-
 fs/btrfs/send.c                      |    6 +-
 fs/btrfs/space-info.c                |   64 +-
 fs/btrfs/space-info.h                |    3 +-
 fs/btrfs/super.c                     |   87 +-
 fs/btrfs/sysfs.c                     |   53 +-
 fs/btrfs/tests/extent-buffer-tests.c |    6 +-
 fs/btrfs/tests/inode-tests.c         |   12 +-
 fs/btrfs/transaction.c               |  231 +--
 fs/btrfs/transaction.h               |   20 +-
 fs/btrfs/tree-checker.c              |   48 +-
 fs/btrfs/tree-log.c                  |   81 +-
 fs/btrfs/ulist.c                     |    3 +-
 fs/btrfs/uuid-tree.c                 |    6 +-
 fs/btrfs/verity.c                    |    4 +-
 fs/btrfs/volumes.c                   |  417 +++--
 fs/btrfs/volumes.h                   |   39 +-
 fs/btrfs/xattr.c                     |   12 +-
 fs/btrfs/zoned.c                     |  452 ++++--
 fs/btrfs/zstd.c                      |   11 +-
 include/trace/events/btrfs.h         |   83 +-
 include/uapi/linux/btrfs.h           |    3 +
 include/uapi/linux/btrfs_tree.h      |   60 +-
 83 files changed, 4030 insertions(+), 5293 deletions(-)
 delete mode 100644 fs/btrfs/check-integrity.c
 delete mode 100644 fs/btrfs/check-integrity.h
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h
