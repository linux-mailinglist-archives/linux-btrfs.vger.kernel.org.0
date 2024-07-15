Return-Path: <linux-btrfs+bounces-6479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D480931A03
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5795282086
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E873440;
	Mon, 15 Jul 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UliV2yYS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ffSVRwU/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0126CDB1;
	Mon, 15 Jul 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067148; cv=none; b=inpA9mLKTw2Xk5qwaXl54u1gwfvnDHzjY4CSDkmK8T0HMlUwj499bGfpALJDXYBcDPQNLjJnYWqZ5C0kRoboJxrphdISftwYHynly6GuRU1ek7ofpErf9aHqG9uB0Ow9Qcpvgi8OCq8s313APNj0bvRxhCT35bNO7gFubB7fDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067148; c=relaxed/simple;
	bh=rpvG0awgeLdWVDZqZxFXVl3Y47kwWfYV7M92CEq03Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdlpD3MND1Ok6/dGsvu0GWb/itjbYhDaKumuNcLnbF0r+VV+l19/egIihy6aN0AocseQem97dbXWgi8ZdtwpUDTgJQ//isVFjHEXYtrxDkNpdUDkGF/QIqx6d+w4vFPJmLmyImSVkdLV4PkHfOO3UODseIxv2mBpjtOEbW9Ez/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UliV2yYS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ffSVRwU/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A68951F833;
	Mon, 15 Jul 2024 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721067143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F5l9DkZojnB/nXR+sG9YqxBsXUPdh+wkC/bWR67H/0s=;
	b=UliV2yYS2xL8SleZDZGqc3gfwEE77/sWea2Zx8y1J2jIVTAyf4M7WvciLrQjLTW/xKXfH1
	GVgl1VwSNMK5+3I84iX2CiahuDzfdv/rTNn8IogTfFcN2NcBDiBcmMvpo4DZcdfcVTFfC8
	pQ7mn2pxEQK9iJGcZiDDtCmupqVFdDU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721067142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F5l9DkZojnB/nXR+sG9YqxBsXUPdh+wkC/bWR67H/0s=;
	b=ffSVRwU/SEfPX/Ji6CkXw6HAA6v3XLsklqpyxGw+baNU8T+fTXWviYxvbVw4G5WUQI2TpL
	rSfYORp/1VCskFWk5e4/IaCnR08UPquZbiroj2GOqoREqRITACjdKcxOzWeensnurp8pnT
	k+zztxNQHwJVgtAdrjfJNVo5X8mCaug=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EF5C137EB;
	Mon, 15 Jul 2024 18:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMTJJoZmlWYMMAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 15 Jul 2024 18:12:22 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.11
Date: Mon, 15 Jul 2024 20:12:20 +0200
Message-ID: <cover.1721066206.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: *

Hi,

please pull the changes described below. The hilights are new logic
behind background block group reclaim, automatic removal of qgroup
after removing a subvolume and new 'rescue=' mount options. The rest is
optimizations, cleanups and refactoring.

There's a merge conflict caused by the latency fixes from last week in
extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
been in linux-next for a few days.

User visible features:

- dynamic block group reclaim:
  - tunable framework to avoid situations where eager data allocations
    prevent creating new metadata chunks due to lack of unallocated
    space
  - reuse sysfs knob bg_reclaim_threshold (otherwise used only in zoned
    mode) for a fixed value threshold
  - new on/off sysfs knob "dynamic_reclaim" calculating the value based
    on heuristics, aiming to keep spare working space for relocating
    chunks but not to needlessly relocate partially utilized block
    groups or reclaim newly allocated ones
  - stats are exported in sysfs per block group type, files "reclaim_*"
  - this may increase IO load at unexpected times but the corner case of
    no allocatable block groups is known to be worse

- automatically remove qgroup of deleted subvolumes
  - adjust qgroup removal conditions, make sure all related subvolume
    data are already removed, or return EBUSY, also take into account
    setting of sysfs drop_subtree_threshold
  - also works in squota mode

- mount option updates: new modes of 'rescue=' that allow to mount (as
  read-only) images that could have been partially converted by
  user space tools
  - ignoremetacsums  - invalid metadata checksums are ignored
  - ignoresuperflags - super block flags that track conversion in
                       progress (like UUID or checksums)

Core:

- size of struct btrfs_inode is now below 1024 (on a release config),
  improved memory packing and other secondary effects

- switch tracking of open inodes from rb-tree to xarray, minor
  performance improvement

- reduce number of empty transaction commits when there are no dirty
  data/metadata

- memory allocation optimizations (reduced numbers, reordering out of
  critical sections)

- extent map structure optimizations and refactoring, more sanity checks

- more subpage in zoned mode preparations or fixes

- general snapshot code cleanups, improvements and documentation

- tree-checker updates: more file extent ram_bytes fixes, continued

- raid-stripe-tree update (not backward compatible):
  - remove extent encoding field from the structure, can be inferred
    from other information
  - requires btrfs-progs 6.9.1 or newer

- cleanups and refactoring
  - error message updates
  - error handling improvements
  - return type and parameter cleanups and improvements

----------------------------------------------------------------
The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-tag

for you to fetch changes up to 8e7860543a94784d744c7ce34b78a2e11beefa5c:

  btrfs: fix extent map use-after-free when adding pages to compressed bio (2024-07-11 16:32:22 +0200)

----------------------------------------------------------------
Anand Jain (7):
      btrfs: drop bytenr_orig and fix comment in btrfs_scan_one_device()
      btrfs: move btrfs_block_group_root() to block-group.c
      btrfs: rename err to ret in btrfs_cleanup_fs_roots()
      btrfs: rename ret to err in btrfs_recover_relocation()
      btrfs: rename ret to ret2 in btrfs_recover_relocation()
      btrfs: rename err to ret in btrfs_recover_relocation()
      btrfs: rename err to ret in btrfs_drop_snapshot()

Boris Burkov (7):
      btrfs: preallocate ulist memory for qgroup rsv
      btrfs: report reclaim stats in sysfs
      btrfs: store fs_info in space_info
      btrfs: dynamic block_group reclaim threshold
      btrfs: periodic block_group reclaim
      btrfs: prevent pathological periodic reclaim loops
      btrfs: urgent periodic reclaim pass

David Sterba (24):
      btrfs: qgroup: do quick checks if quotas are enabled before starting ioctls
      btrfs: remove duplicate name variable declarations
      btrfs: rename macro local variables that clash with other variables
      btrfs: use for-local variables that shadow function variables
      btrfs: remove unused define EXTENT_SIZE_PER_ITEM
      btrfs: keep const when returning value from get_unaligned_le8()
      btrfs: constify parameters of write_eb_member() and its users
      btrfs: simplify range parameters of btrfs_wait_ordered_roots()
      btrfs: constify pointer parameters where applicable
      btrfs: abort transaction if we don't find extref in btrfs_del_inode_extref()
      btrfs: only print error message when checking item size in print_extent_item()
      btrfs: abort transaction on errors in btrfs_free_chunk()
      btrfs: qgroup: preallocate memory before adding a relation
      btrfs: qgroup: warn about inconsistent qgroups when relation update fails
      btrfs: pass a btrfs_inode to btrfs_readdir_put_delayed_items()
      btrfs: pass a btrfs_inode to btrfs_readdir_get_delayed_items()
      btrfs: pass a btrfs_inode to is_data_inode()
      btrfs: switch btrfs_block_group::inode to struct btrfs_inode
      btrfs: pass a btrfs_inode to btrfs_ioctl_send()
      btrfs: switch btrfs_pending_snapshot::dir to btrfs_inode
      btrfs: switch btrfs_ordered_extent::inode to struct btrfs_inode
      btrfs: pass a btrfs_inode to btrfs_compress_heuristic()
      btrfs: pass a btrfs_inode to btrfs_set_prop()
      btrfs: enhance compression error messages

Filipe Manana (51):
      btrfs: zoned: make btrfs_get_dev_zone() static
      btrfs: remove no longer used btrfs_migrate_to_delayed_refs_rsv()
      btrfs: fix misspelled end IO compression callbacks
      btrfs: fix function name in comment for btrfs_remove_ordered_extent()
      btrfs: use an xarray to track open inodes in a root
      btrfs: preallocate inodes xarray entry to avoid transaction abort
      btrfs: reduce nesting and deduplicate error handling at btrfs_iget_path()
      btrfs: remove inode_lock from struct btrfs_root and use xarray locks
      btrfs: unify index_cnt and csum_bytes from struct btrfs_inode
      btrfs: don't allocate file extent tree for non regular files
      btrfs: remove location key from struct btrfs_inode
      btrfs: remove objectid from struct btrfs_inode on 64 bits platforms
      btrfs: rename rb_root member of extent_map_tree from map to root
      btrfs: use a regular rb_root instead of cached rb_root for extent_map_tree
      btrfs: make btrfs_finish_ordered_extent() return void
      btrfs: use a btrfs_inode in the log context (struct btrfs_log_ctx)
      btrfs: pass a btrfs_inode to btrfs_fdatawrite_range()
      btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()
      btrfs: use a btrfs_inode local variable at btrfs_sync_file()
      btrfs: qgroup: avoid start/commit empty transaction when flushing reservations
      btrfs: avoid create and commit empty transaction when committing super
      btrfs: send: make ensure_commit_roots_uptodate() simpler and more efficient
      btrfs: send: avoid create/commit empty transaction at ensure_commit_roots_uptodate()
      btrfs: scrub: avoid create/commit empty transaction at finish_extent_writes_for_zoned()
      btrfs: add and use helper to commit the current transaction
      btrfs: send: get rid of the label and gotos at ensure_commit_roots_uptodate()
      btrfs: move fiemap code into its own file
      btrfs: reduce critical section at btrfs_wait_ordered_roots()
      btrfs: reduce critical section at btrfs_wait_ordered_extents()
      btrfs: add comment about locking to btrfs_split_ordered_extent()
      btrfs: avoid removal and re-insertion of split ordered extent
      btrfs: mark ordered extent insertion failure checks as unlikely
      btrfs: update panic message when splitting ordered extent
      btrfs: remove pointless code when creating and deleting a subvolume
      btrfs: avoid transaction commit on any fsync after subvolume creation
      btrfs: remove super block argument from btrfs_iget()
      btrfs: remove super block argument from btrfs_iget_path()
      btrfs: remove super block argument from btrfs_iget_locked()
      btrfs: do not BUG_ON() when freeing tree block after error
      btrfs: use label to deduplicate error path at btrfs_force_cow_block()
      btrfs: remove NULL transaction support for btrfs_lookup_extent_info()
      btrfs: simplify setting the full backref flag at update_ref_for_cow()
      btrfs: replace BUG_ON() with error handling at update_ref_for_cow()
      btrfs: remove superfluous metadata check at btrfs_lookup_extent_info()
      btrfs: reduce nesting for extent processing at btrfs_lookup_extent_info()
      btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
      btrfs: avoid allocating and running pointless delayed extent operations
      btrfs: move the direct IO code into its own file
      btrfs: fix data race when accessing the last_trans field of a root
      btrfs: fix bitmap leak when loading free space cache on duplicate entry
      btrfs: fix extent map use-after-free when adding pages to compressed bio

Jeff Johnson (1):
      btrfs: add MODULE_DESCRIPTION()

Johannes Thumshirn (8):
      btrfs: pass struct btrfs_io_geometry into handle_ops_on_dev_replace()
      btrfs: pass reloc_control to relocate_data_extent()
      btrfs: pass a reloc_control to relocate_file_extent_cluster()
      btrfs: pass a reloc_control to relocate_one_folio()
      btrfs: don't pass fs_info to describe_relocation()
      btrfs: pass a struct reloc_control to prealloc_file_extent_cluster()
      btrfs: pass reloc_control to setup_relocation_extent_mapping()
      btrfs: remove raid-stripe-tree encoding field from stripe_extent

Josef Bacik (15):
      btrfs: don't do extra find_extent_buffer() in do_walk_down()
      btrfs: remove all extra btrfs_check_eb_owner() calls
      btrfs: use btrfs_read_extent_buffer() in do_walk_down()
      btrfs: push lookup_info into struct walk_control
      btrfs: factor out eb uptodate check from do_walk_down()
      btrfs: remove local variable need_account in do_walk_down()
      btrfs: unify logic to decide if we need to walk down into a node during snapshot delete
      btrfs: extract the reference dropping code into it's own helper
      btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()
      btrfs: handle errors from ref mods during UPDATE_BACKREF in walk_down_proc()
      btrfs: replace BUG_ON with ASSERT in walk_down_proc()
      btrfs: clean up our handling of refs == 0 in snapshot delete
      btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc()
      btrfs: handle errors from btrfs_dec_ref() properly
      btrfs: add documentation around snapshot delete

Junchao Sun (1):
      btrfs: qgroup: delete a TODO about using kmem cache to allocate structures

Mark Harmstone (1):
      btrfs: fix typo in error message in btrfs_validate_super()

Qu Wenruo (37):
      btrfs: raid56: do extra dumping for CONFIG_BTRFS_ASSERT
      btrfs: slightly loosen the requirement for qgroup removal
      btrfs: automatically remove the subvolume qgroup
      btrfs: rename extent_map::orig_block_len to disk_num_bytes
      btrfs: export the expected file extent through can_nocow_extent()
      btrfs: introduce new members for extent_map
      btrfs: introduce extra sanity checks for extent maps
      btrfs: remove extent_map::orig_start member
      btrfs: remove extent_map::block_len member
      btrfs: remove extent_map::block_start member
      btrfs: cleanup duplicated parameters related to can_nocow_file_extent_args
      btrfs: cleanup duplicated parameters related to btrfs_alloc_ordered_extent
      btrfs: cleanup duplicated parameters related to create_io_em()
      btrfs: cleanup duplicated parameters related to btrfs_create_dio_extent()
      btrfs: make __extent_writepage_io() to write specified range only
      btrfs: subpage: introduce helpers to handle subpage delalloc locking
      btrfs: lock subpage ranges in one go for writepage_delalloc()
      btrfs: do not clear page dirty inside extent_write_locked_range()
      btrfs: make extent_write_locked_range() handle subpage writeback correctly
      btrfs: cleanup recursive include of the same header
      btrfs: do not directly include rwlock_types.h
      btrfs: uapi: record temporary super flags used by btrfstune
      btrfs: subpage: remove the unused error bitmap dumping
      btrfs: print-tree: add generation and type dump for EXTENT_DATA_KEY
      btrfs: cleanup the bytenr usage inside btrfs_extent_item_to_extent_map()
      btrfs: ignore incorrect btrfs_file_extent_item::ram_bytes
      btrfs: make validate_extent_map() catch ram_bytes mismatch
      btrfs: fix the ram_bytes assignment for truncated ordered extents
      btrfs: tree-checker: add extra ram_bytes and disk_num_bytes check
      btrfs: remove unused Opt enums
      btrfs: output the unrecognized super block flags as hex
      btrfs: introduce new "rescue=ignoremetacsums" mount option
      btrfs: introduce new "rescue=ignoresuperflags" mount option
      btrfs: remove the extra_gfp parameter from btrfs_alloc_folio_array()
      btrfs: rename the extra_gfp parameter of btrfs_alloc_page_array()
      btrfs: move extent_range_clear_dirty_for_io() into inode.c
      btrfs: remove the BUG_ON() inside extent_range_clear_dirty_for_io()

 fs/btrfs/Makefile                 |    2 +-
 fs/btrfs/accessors.h              |   15 +-
 fs/btrfs/bio.c                    |    4 +-
 fs/btrfs/block-group.c            |   53 +-
 fs/btrfs/block-group.h            |    3 +-
 fs/btrfs/btrfs_inode.h            |  156 ++--
 fs/btrfs/compression.c            |   25 +-
 fs/btrfs/compression.h            |    2 +-
 fs/btrfs/ctree.c                  |  108 +--
 fs/btrfs/ctree.h                  |   18 +-
 fs/btrfs/defrag.c                 |   18 +-
 fs/btrfs/delalloc-space.c         |    2 +-
 fs/btrfs/delalloc-space.h         |    2 +-
 fs/btrfs/delayed-inode.c          |   47 +-
 fs/btrfs/delayed-inode.h          |   10 +-
 fs/btrfs/delayed-ref.c            |   51 +-
 fs/btrfs/delayed-ref.h            |    8 +-
 fs/btrfs/dev-replace.c            |    4 +-
 fs/btrfs/dir-item.c               |    8 +-
 fs/btrfs/dir-item.h               |    6 +-
 fs/btrfs/direct-io.c              | 1052 ++++++++++++++++++++++++++
 fs/btrfs/direct-io.h              |   14 +
 fs/btrfs/disk-io.c                |  128 ++--
 fs/btrfs/disk-io.h                |   18 +-
 fs/btrfs/export.c                 |    6 +-
 fs/btrfs/extent-io-tree.c         |    4 +
 fs/btrfs/extent-tree.c            |  685 ++++++++++-------
 fs/btrfs/extent-tree.h            |    8 +-
 fs/btrfs/extent_io.c              | 1092 ++++-----------------------
 fs/btrfs/extent_io.h              |   19 +-
 fs/btrfs/extent_map.c             |  246 +++++--
 fs/btrfs/extent_map.h             |   56 +-
 fs/btrfs/fiemap.c                 |  930 +++++++++++++++++++++++
 fs/btrfs/fiemap.h                 |   11 +
 fs/btrfs/file-item.c              |   52 +-
 fs/btrfs/file.c                   |  355 +--------
 fs/btrfs/file.h                   |    4 +-
 fs/btrfs/free-space-cache.c       |   12 +-
 fs/btrfs/free-space-tree.c        |   10 +-
 fs/btrfs/fs.h                     |   17 +-
 fs/btrfs/inode-item.c             |    4 +-
 fs/btrfs/inode.c                  | 1475 ++++++++-----------------------------
 fs/btrfs/ioctl.c                  |   94 ++-
 fs/btrfs/ioctl.h                  |    2 +-
 fs/btrfs/locking.h                |    1 -
 fs/btrfs/lru_cache.h              |    1 -
 fs/btrfs/lzo.c                    |   43 +-
 fs/btrfs/messages.c               |    3 +-
 fs/btrfs/misc.h                   |    4 +-
 fs/btrfs/ordered-data.c           |  146 ++--
 fs/btrfs/ordered-data.h           |   27 +-
 fs/btrfs/print-tree.c             |   10 +-
 fs/btrfs/props.c                  |   20 +-
 fs/btrfs/props.h                  |    4 +-
 fs/btrfs/qgroup.c                 |  221 ++++--
 fs/btrfs/qgroup.h                 |   25 +-
 fs/btrfs/raid-stripe-tree.c       |   13 -
 fs/btrfs/raid-stripe-tree.h       |    3 +-
 fs/btrfs/raid56.c                 |  118 ++-
 fs/btrfs/reflink.c                |    8 +-
 fs/btrfs/relocation.c             |  157 ++--
 fs/btrfs/scrub.c                  |   13 +-
 fs/btrfs/send.c                   |   49 +-
 fs/btrfs/send.h                   |    4 +-
 fs/btrfs/space-info.c             |  265 ++++++-
 fs/btrfs/space-info.h             |   48 ++
 fs/btrfs/subpage.c                |  162 +++-
 fs/btrfs/subpage.h                |    9 +-
 fs/btrfs/super.c                  |   51 +-
 fs/btrfs/super.h                  |    2 +-
 fs/btrfs/sysfs.c                  |   85 ++-
 fs/btrfs/tests/btrfs-tests.c      |    5 +-
 fs/btrfs/tests/extent-map-tests.c |  120 +--
 fs/btrfs/tests/inode-tests.c      |  176 +++--
 fs/btrfs/transaction.c            |   31 +-
 fs/btrfs/transaction.h            |    9 +-
 fs/btrfs/tree-checker.c           |   37 +-
 fs/btrfs/tree-log.c               |   74 +-
 fs/btrfs/tree-log.h               |    6 +-
 fs/btrfs/ulist.c                  |   21 +-
 fs/btrfs/ulist.h                  |    2 +
 fs/btrfs/uuid-tree.c              |   10 +-
 fs/btrfs/uuid-tree.h              |    4 +-
 fs/btrfs/volumes.c                |   62 +-
 fs/btrfs/volumes.h                |    2 +-
 fs/btrfs/xattr.c                  |    4 +-
 fs/btrfs/xattr.h                  |    2 +-
 fs/btrfs/zlib.c                   |   56 +-
 fs/btrfs/zoned.c                  |   30 +-
 fs/btrfs/zoned.h                  |   11 +-
 fs/btrfs/zstd.c                   |   70 +-
 include/trace/events/btrfs.h      |   19 +-
 include/uapi/linux/btrfs_tree.h   |   22 +-
 93 files changed, 5186 insertions(+), 3915 deletions(-)
 create mode 100644 fs/btrfs/direct-io.c
 create mode 100644 fs/btrfs/direct-io.h
 create mode 100644 fs/btrfs/fiemap.c
 create mode 100644 fs/btrfs/fiemap.h

