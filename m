Return-Path: <linux-btrfs+bounces-12515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C3A6DFEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FA7188C112
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F51263F27;
	Mon, 24 Mar 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QRV0vKMq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QRV0vKMq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB391799F
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834281; cv=none; b=p6rNZYIjWqCcKoVyVr7oGXwUjYCdiDe0IUpinqTHLLtzoqz6YiH54WsXF1/EZrEeculcpo9VxfEGIeHKFvanDjxbmcnrjj59fSGnso1VvtacqyZLAuqs4K9MJfoqnBMCseA9khS6ALw/Kh4D4LCaiTTQ+gAQis6n8jPjeMLHYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834281; c=relaxed/simple;
	bh=BtyM6FCWAzgjXMgvvYIRLPMPsksTzthUGMIeibZhiG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T46dzuIoVVQ+QUHxGN3e3H8zs9s0oYOn5tIUkOFuM6r2hrSeic7cRrFcLMZwcJjr0JzI9eLZbixKKSC5yTUBcbdrto5Dnwb4rMyOqx4ItIekhliNRVNxtTR9Gc0+SalTOuh+TFaGd4iXXg9EA/2SByyLVkBcP7epkEI/Mubwm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QRV0vKMq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QRV0vKMq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B69A2118A;
	Mon, 24 Mar 2025 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742834276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6wfMeqlxfE/mHa5vtUvRJSgBMVJHYPN0NVfIYIkhARc=;
	b=QRV0vKMqjHI5C0OfSKIDXR/RifGfbdc5zzF+wZJi2lv86ybkzMsuR88BDwSW5l3Zcu2OBA
	1QMIWFrCV0xhF+b75avUFAOLQf8WQhCliSLvJBykSgjcAtaWRpzPgXLZdsg5ymOecxPE+A
	gngDTJ3DAt5u55MeDve79MN4BKLZzhY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742834276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6wfMeqlxfE/mHa5vtUvRJSgBMVJHYPN0NVfIYIkhARc=;
	b=QRV0vKMqjHI5C0OfSKIDXR/RifGfbdc5zzF+wZJi2lv86ybkzMsuR88BDwSW5l3Zcu2OBA
	1QMIWFrCV0xhF+b75avUFAOLQf8WQhCliSLvJBykSgjcAtaWRpzPgXLZdsg5ymOecxPE+A
	gngDTJ3DAt5u55MeDve79MN4BKLZzhY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58A54137AC;
	Mon, 24 Mar 2025 16:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1qqeFWSK4WeqdgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Mar 2025 16:37:56 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.15
Date: Mon, 24 Mar 2025 17:37:51 +0100
Message-ID: <cover.1742834133.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

please pull the following btrfs updates, thanks.

User visible changes:

- fall back to buffered write if direct io is done on a file that requires
  checksums
  - this avoids a problem with checksum mismatch errors, observed e.g. on
    virtual images when writes to pages under writeback cause the checksum
    mismatch reports
  - this may lead to some performance degradation but currently the
    recommended setup for VM images is to use the NOCOW file attribute that
    also disables checksums

- fast/realtime zstd levels -15 to -1
  - supported by mount options (compress=zstd:-5) and defrag ioctl
  - improved speed, reduced compression ratio, check the commit for sample
    measurements

- defrag ioctl extended to accept negative compression levels

- subpage mode
  - remove warning when subpage mode is used, the feature is now reasonably
    complete and tested
  - in debug mode allow to create 2K b-tree nodes to allow testing subpage on
    x86_64 with 4K pages too

Performance improvements:

- in send, better file path caching improves runtime (on sample load by -30%)

- on s390x with hardware zlib support prepare the input buffer in a better way
  to get the best results from the acceleration

- minor speed improvement in encoded read, avoid memory allocation in
  synchronous mode

Core:

- enable stable writes on inodes, replacing manually waiting for writeback
  and allowing to skip that on inodes without checksums

- add last checks and warnings for out-of-band dirty writes to pages,
  requiring a fixup ("fixup worker"), this should not be necessary since 5.8
  where get_user_page() and pin_user_pages*() prevent this
  - long history behind that, we'll be happy to remove the whole infrastructure
    in the near future

- more folio API conversions and preparations for large folio support

- subpage cleanups and refactoring, split handling of data and metadata to
  allow future support for large folios

- readpage works as block-by-block, no change for normal mode, this is
  preparation for future subpage updates

- block group refcount fixes and hardening

- delayed iput fixes

- in zoned mode, fix zone activation on filesystem with missing devices

- cleanups:
  - inode parameter cleanups
  - path auto-freeing updates
  - code flow simplifications in send
  - redundant parameter cleanups

----------------------------------------------------------------
The following changes since commit 4701f33a10702d5fc577c32434eb62adde0a1ae1:

  Linux 6.14-rc7 (2025-03-16 12:55:17 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-tag

for you to fetch changes up to 35fec1089ebb5617f85884d3fa6a699ce6337a75:

  btrfs: zoned: fix zone finishing with missing devices (2025-03-18 20:35:57 +0100)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: sysfs: accept size suffixes for read policy values

Boris Burkov (5):
      btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
      btrfs: harden block_group::bg_list against list_del() races
      btrfs: make btrfs_discard_workfn() block_group ref explicit
      btrfs: explicitly ref count block_group on new_bgs list
      btrfs: codify pattern for adding block_group to bg_list

Dan Carpenter (1):
      btrfs: return a literal instead of a variable in btrfs_init_dev_replace()

Daniel Vacek (3):
      btrfs: keep private struct on stack for sync reads in btrfs_encoded_read_regular_fill_pages()
      btrfs: zstd: enable negative compression levels mount option
      btrfs: defrag: extend ioctl to accept compression levels

David Sterba (55):
      btrfs: add __cold attribute to extent_io_tree_panic()
      btrfs: async-thread: switch local variables need_order bool
      btrfs: zstd: move zstd_parameters to the workspace
      btrfs: zstd: remove local variable for storing page offsets
      btrfs: unify ordering of btrfs_key initializations
      btrfs: simplify returns and labels in btrfs_init_fs_root()
      btrfs: update include and forward declarations in headers
      btrfs: pass struct btrfs_inode to can_nocow_extent()
      btrfs: pass struct btrfs_inode to extent_range_clear_dirty_for_io()
      btrfs: pass struct btrfs_inode to btrfs_read_locked_inode()
      btrfs: pass struct btrfs_inode to btrfs_iget_locked()
      btrfs: pass struct btrfs_inode to new_simple_dir()
      btrfs: pass struct btrfs_inode to btrfs_inode_type()
      btrfs: pass struct btrfs_inode to btrfs_defrag_file()
      btrfs: use struct btrfs_inode inside create_pending_snapshot()
      btrfs: pass struct btrfs_inode to fill_stack_inode_item()
      btrfs: pass struct btrfs_inode to btrfs_fill_inode()
      btrfs: pass struct btrfs_inode to btrfs_load_inode_props()
      btrfs: pass struct btrfs_inode to btrfs_inode_inherit_props()
      btrfs: props: switch prop_handler::apply to struct btrfs_inode
      btrfs: props: switch prop_handler::extract to struct btrfs_inode
      btrfs: pass struct btrfs_inode to clone_copy_inline_extent()
      btrfs: pass struct btrfs_inode to btrfs_double_mmap_lock()
      btrfs: pass struct btrfs_inode to btrfs_double_mmap_unlock()
      btrfs: pass struct btrfs_inode to btrfs_extent_same_range()
      btrfs: use struct btrfs_inode inside btrfs_remap_file_range()
      btrfs: use struct btrfs_inode inside btrfs_remap_file_range_prep()
      btrfs: use struct btrfs_inode inside btrfs_get_parent()
      btrfs: use struct btrfs_inode inside btrfs_get_name()
      btrfs: don't pass nodesize to __alloc_extent_buffer()
      btrfs: merge alloc_dummy_extent_buffer() helpers
      btrfs: simplify parameters of metadata folio helpers
      btrfs: add __pure attribute to eb page and folio counters
      btrfs: use num_extent_folios() in for loop bounds
      btrfs: do trivial BTRFS_PATH_AUTO_FREE conversions
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_dev_replace()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_run_dev_replace()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_check_dir_item_collision()
      btrfs: use BTRFS_PATH_AUTO_FREE in load_global_roots()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_root_free_objectid()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_get_name()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_extent_info()
      btrfs: use BTRFS_PATH_AUTO_FREE in run_delayed_extent_op()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_bio_sums()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_remove_free_space_inode()
      btrfs: use BTRFS_PATH_AUTO_FREE in populate_free_space_tree()
      btrfs: use BTRFS_PATH_AUTO_FREE in clear_free_space_tree()
      btrfs: use BTRFS_PATH_AUTO_FREE in load_free_space_tree()
      btrfs: parameter constification in ioctl.c
      btrfs: pass btrfs_root pointers to send ioctl parameters
      btrfs: pass root pointers to search tree ioctl helpers
      btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
      btrfs: simplify local variables in btrfs_ioctl_resize()
      btrfs: pass struct to btrfs_ioctl_subvol_getflags()
      btrfs: unify inode variable naming

Filipe Manana (57):
      btrfs: avoid assigning twice to block_start at btrfs_do_readpage()
      btrfs: send: remove duplicated logic from fs_path_reset()
      btrfs: send: make fs_path_len() inline and constify its argument
      btrfs: send: always use fs_path_len() to determine a path's length
      btrfs: send: simplify return logic from fs_path_prepare_for_add()
      btrfs: send: simplify return logic from fs_path_add()
      btrfs: send: implement fs_path_add_path() using fs_path_add()
      btrfs: send: simplify return logic from fs_path_add_from_extent_buffer()
      btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
      btrfs: send: simplify return logic from __get_cur_name_and_parent()
      btrfs: send: simplify return logic from is_inode_existent()
      btrfs: send: simplify return logic from get_cur_inode_state()
      btrfs: send: factor out common logic when sending xattrs
      btrfs: send: only use boolean variables at process_recorded_refs()
      btrfs: send: add and use helper to rename current inode when processing refs
      btrfs: send: simplify return logic from send_remove_xattr()
      btrfs: send: simplify return logic from record_new_ref_if_needed()
      btrfs: send: simplify return logic from record_deleted_ref_if_needed()
      btrfs: send: simplify return logic from record_new_ref()
      btrfs: send: simplify return logic from record_deleted_ref()
      btrfs: send: simplify return logic from record_changed_ref()
      btrfs: send: remove unnecessary return variable from process_new_xattr()
      btrfs: send: simplify return logic from process_changed_xattr()
      btrfs: send: simplify return logic from send_verity()
      btrfs: send: simplify return logic from send_rename()
      btrfs: send: simplify return logic from send_link()
      btrfs: send: simplify return logic from send_unlink()
      btrfs: send: simplify return logic from send_rmdir()
      btrfs: send: keep the current inode's path cached
      btrfs: send: avoid path allocation for the current inode when issuing commands
      btrfs: send: simplify return logic from send_set_xattr()
      btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
      btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
      btrfs: fix reclaimed bytes accounting after automatic block group reclaim
      btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
      btrfs: move __btrfs_bio_end_io() code into its single caller
      btrfs: move btrfs_cleanup_bio() code into its single caller
      btrfs: fix non-empty delayed iputs list on unmount due to async workers
      btrfs: avoid unnecessary bio dereference at run_one_async_done()
      btrfs: send: remove unnecessary inode lookup at send_encoded_inline_extent()
      btrfs: send: simplify return logic from send_encoded_extent()
      btrfs: return a btrfs_inode from btrfs_iget_logging()
      btrfs: return a btrfs_inode from read_one_inode()
      btrfs: pass a btrfs_inode to fixup_inode_link_count()
      btrfs: make btrfs_iget() return a btrfs inode instead
      btrfs: make btrfs_iget_path() return a btrfs inode instead
      btrfs: remove unnecessary fs_info argument from create_reloc_inode()
      btrfs: remove unnecessary fs_info argument from delete_block_group_cache()
      btrfs: remove unnecessary fs_info argument from btrfs_add_block_group_cache()
      btrfs: tests: fix chunk map leak after failure to add it to the tree
      btrfs: avoid unnecessary memory allocation and copy at overwrite_item()
      btrfs: use variables to store extent buffer and slot at overwrite_item()
      btrfs: update outdated comment for overwrite_item()
      btrfs: use memcmp_extent_buffer() at replay_one_extent()
      btrfs: remove redundant else statement from btrfs_log_inode_parent()
      btrfs: simplify condition for logging new dentries at btrfs_log_inode_parent()
      btrfs: remove end_no_trans label from btrfs_log_inode_parent()

Johannes Thumshirn (3):
      btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
      btrfs: zoned: fix zone activation with missing devices
      btrfs: zoned: fix zone finishing with missing devices

Mark Harmstone (2):
      btrfs: avoid linker error in btrfs_find_create_tree_block()
      btrfs: don't clobber ret in btrfs_validate_super()

Matthew Wilcox (Oracle) (2):
      btrfs: update some folio related comments
      btrfs: convert io_ctl_prepare_pages() to work on folios

Qu Wenruo (32):
      btrfs: remove duplicated metadata folio flag update in end_bbio_meta_read()
      btrfs: always fallback to buffered write if the inode requires checksum
      btrfs: zlib: refactor S390x HW acceleration buffer preparation
      btrfs: expose per-inode stable writes flag
      btrfs: factor out nocow ordered extent and extent map generation into a helper
      btrfs: move ordered extent cleanup to where they are allocated
      btrfs: remove btrfs_fs_info::sectors_per_page
      btrfs: factor out metadata subpage detection into a dedicated helper
      btrfs: make subpage attach and detach handle metadata properly
      btrfs: use metadata specific helpers to simplify extent buffer helpers
      btrfs: simplify subpage handling of btrfs_clear_buffer_dirty()
      btrfs: simplify subpage handling of write_one_eb()
      btrfs: simplify subpage handling of read_extent_buffer_pages_nowait()
      btrfs: require strict data/metadata split for subpage checks
      btrfs: prevent inline data extents read from touching blocks beyond its range
      btrfs: fix the qgroup data free range for inline data extents
      btrfs: introduce a read path dedicated extent lock helper
      btrfs: make btrfs_do_readpage() to do block-by-block read
      btrfs: allow buffered write to avoid full page read if it's block aligned
      btrfs: allow inline data extents creation if block size < page size
      btrfs: remove the subpage related warning message
      btrfs: properly limit inline data extent according to block size
      btrfs: allow debug builds to accept 2K block size
      btrfs: reject out-of-band dirty folios during writeback
      btrfs: run btrfs_error_commit_super() early
      btrfs: add extra warning if delayed iput is added when it's not allowed
      btrfs: subpage: make btrfs_is_subpage() check against a folio
      btrfs: add a size parameter to btrfs_alloc_subpage()
      btrfs: replace PAGE_SIZE with folio_size for subpage.[ch]
      btrfs: prepare btrfs_launcher_folio() for large folios support
      btrfs: prepare extent_io.c for future large folio support
      btrfs: prepare btrfs_page_mkwrite() for large folios

Sun YangKai (3):
      btrfs: simplify the return value handling in search_ioctl()
      btrfs: remove unnecessary btrfs_key local variable in btrfs_search_forward()
      btrfs: avoid redundant path slot assignment in btrfs_search_forward()

 fs/btrfs/accessors.h              |   1 +
 fs/btrfs/acl.h                    |   2 +
 fs/btrfs/async-thread.c           |  11 +-
 fs/btrfs/backref.c                |   4 +-
 fs/btrfs/bio.c                    |  38 +--
 fs/btrfs/block-group.c            | 155 ++++++----
 fs/btrfs/btrfs_inode.h            |  17 +-
 fs/btrfs/compression.c            |  31 +-
 fs/btrfs/compression.h            |  26 +-
 fs/btrfs/ctree.c                  |  18 +-
 fs/btrfs/ctree.h                  |   2 +-
 fs/btrfs/defrag.c                 |  78 ++---
 fs/btrfs/defrag.h                 |   4 +-
 fs/btrfs/delayed-inode.c          |  99 ++++---
 fs/btrfs/delayed-inode.h          |   2 +-
 fs/btrfs/delayed-ref.h            |   2 +
 fs/btrfs/dev-replace.c            |  33 +--
 fs/btrfs/dir-item.c               |  24 +-
 fs/btrfs/dir-item.h               |   1 +
 fs/btrfs/direct-io.c              |  19 +-
 fs/btrfs/direct-io.h              |   2 +
 fs/btrfs/discard.c                |  34 ++-
 fs/btrfs/discard.h                |   1 +
 fs/btrfs/disk-io.c                | 109 ++++---
 fs/btrfs/export.c                 |  51 ++--
 fs/btrfs/extent-io-tree.c         |   8 +-
 fs/btrfs/extent-tree.c            |  63 ++--
 fs/btrfs/extent-tree.h            |   1 -
 fs/btrfs/extent_io.c              | 589 ++++++++++++++++++++++----------------
 fs/btrfs/extent_io.h              |   9 +-
 fs/btrfs/file-item.c              |  30 +-
 fs/btrfs/file-item.h              |   2 +
 fs/btrfs/file.c                   |  28 +-
 fs/btrfs/file.h                   |   2 +
 fs/btrfs/free-space-cache.c       |  57 ++--
 fs/btrfs/free-space-tree.c        |  45 ++-
 fs/btrfs/fs.c                     |   1 -
 fs/btrfs/fs.h                     |  26 +-
 fs/btrfs/inode-item.c             |   6 +-
 fs/btrfs/inode.c                  | 587 +++++++++++++++++++------------------
 fs/btrfs/ioctl.c                  | 217 +++++++-------
 fs/btrfs/ioctl.h                  |   4 +-
 fs/btrfs/locking.c                |   1 -
 fs/btrfs/ordered-data.c           |  23 +-
 fs/btrfs/ordered-data.h           |   9 +-
 fs/btrfs/print-tree.h             |   2 +
 fs/btrfs/props.c                  |  66 ++---
 fs/btrfs/props.h                  |   8 +-
 fs/btrfs/qgroup.c                 |   2 +-
 fs/btrfs/qgroup.h                 |   3 +
 fs/btrfs/raid-stripe-tree.h       |   1 +
 fs/btrfs/reflink.c                | 100 +++----
 fs/btrfs/relocation.c             |  30 +-
 fs/btrfs/scrub.c                  |   4 +-
 fs/btrfs/send.c                   | 544 ++++++++++++++++-------------------
 fs/btrfs/send.h                   |   4 +-
 fs/btrfs/space-info.c             |   2 +-
 fs/btrfs/subpage.c                | 224 +++++++++------
 fs/btrfs/subpage.h                |  56 +++-
 fs/btrfs/super.c                  |   6 +-
 fs/btrfs/sysfs.c                  |  14 +-
 fs/btrfs/sysfs.h                  |   1 +
 fs/btrfs/tests/extent-io-tests.c  |   6 +-
 fs/btrfs/tests/extent-map-tests.c |   1 +
 fs/btrfs/transaction.c            |  39 ++-
 fs/btrfs/tree-log.c               | 392 ++++++++++++-------------
 fs/btrfs/verity.c                 |   4 +-
 fs/btrfs/volumes.c                |  16 +-
 fs/btrfs/volumes.h                |   4 +
 fs/btrfs/xattr.h                  |   2 +
 fs/btrfs/zlib.c                   |  83 ++++--
 fs/btrfs/zoned.c                  |   9 +
 fs/btrfs/zstd.c                   |  66 +++--
 include/uapi/linux/btrfs.h        |  16 +-
 74 files changed, 2263 insertions(+), 1914 deletions(-)

