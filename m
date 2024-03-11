Return-Path: <linux-btrfs+bounces-3196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E708788E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC021C20B34
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486954FAA;
	Mon, 11 Mar 2024 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="imRXjqn8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PkMS8ScY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFCA54BFE;
	Mon, 11 Mar 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185161; cv=none; b=RzgkTXJsm0TdmiAmVw1+xYwYfB3eUmqw7N5crbNZmGT5R8o3Yb45NwMNHlU4k84i1Vq6oYf71wxNidL7xviweThzRARLQI4FDntfcV6I8jN8rxVrVBxfod3YZvkCXTICBl8DXLxPacGrDyKe5VIj2ZmZJVT/WjAMy3yPMZ3d+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185161; c=relaxed/simple;
	bh=RrY96Of+19Qplk+rzqdVAE5FfdpexzxLDgAjo/HRIPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkRGLYOgd886JbnMkHETYYxsecJI6SOOa2SRQ3OZ/tqmazpqXnOG/bMRSl2xlxcLZEWMKT9Ooq/rOxeVADr4TLxlTnCJ+gFXJSW3dxu9yFToPDnPR/7J93teBPlPKPOPRQlbeCunrN+BZax5Fn+Un/poVuDfFQuf3lFcvRrMBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=imRXjqn8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PkMS8ScY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAF3C34FCD;
	Mon, 11 Mar 2024 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710185156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LRb+QDVqmSBBfop+NmgzD1v195yCdoVF4ZrnYqydg0A=;
	b=imRXjqn8Y3gat5grVn6HHxZ0KjbpcBKxMOd2sELqedc07gpk0nFONUp9xQljeik2gBOh5N
	aeqBqsKysY3/aOtEc0IzdTDFUFC1x/6fY3VK2tVBkXGAZCObbUPlrTYpk13nmCLbEnL85E
	cay+MECztdWObBl4ahlwhMoNPI0Sidc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710185155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LRb+QDVqmSBBfop+NmgzD1v195yCdoVF4ZrnYqydg0A=;
	b=PkMS8ScYtXNCrOCMZLxLm2S/mjX8DXlQn6LIu9ym/904zFJ8yK17gF2BbVdvlX/PrHlArE
	gVaEijiZeXvkOiDaVtm+oj/FObNal/5/+mvGzlPzrO7J01bY27inKzdE6KHfSnOuEr/92m
	ZEWQAaNJ043QkLS4AgJODTkmB2Rv8UQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C41D113695;
	Mon, 11 Mar 2024 19:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hnPbL8Na72UPTQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 11 Mar 2024 19:25:55 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.9
Date: Mon, 11 Mar 2024 20:18:45 +0100
Message-ID: <cover.1710183792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PkMS8ScY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -0.51
X-Rspamd-Queue-Id: CAF3C34FCD
X-Spam-Flag: NO

Hi,

there are mostly stabilization, refactoring and cleanup changes. There rest are
minor performance optimizations due to caching or lock contention reduction and
a few notable fixes.

Please pull, thanks.

Performance improvements:

- minor speedup in logging when repeatedly allocated structure is preallocated
  only once, improves latency and decreases lock contention

- minor throughput increase (+6%), reduced lock contention after clearing
  delayed allocation bits, applies to several common workload types

- skip full quota rescan if a new relation is added in the same transaction

Fixes:

- zstd fix for inline compressed file in subpage mode, updated version from the
  6.8 time

- proper qgroup inheritance ioctl parameter validation

- more fiemap followup fixes after reduced locking done in 6.8
  - fix race when detecting delalloc ranges

Core changes:

- more debugging code
  - added assertions for a very rare crash in raid56 calculation
  - tree-checker dumps page state to give more insights into possible reference
    counting issues

- add checksum calculation offloading sysfs knob, for now enabled under DEBUG
  only to determine a good heuristic for deciding the offload or synchronous,
  depends on various factors (block group profile, device speed) and is not as
  clear as initially thought (checksum type)

- error handling improvements, added assertions

- more page to folio conversion (defrag, truncate), cached size and shift

- preparation for more fine grained locking of sectors in subpage mode

- cleanups and refactoring
  - include cleanups, forward declarations
  - pointer-to-structure helpers
  - redundant argument removals
  - removed unused code
  - slab cache updates, last use of SLAB_MEM_SPREAD removed

----------------------------------------------------------------
The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-tag

for you to fetch changes up to 1cab1375ba6d5337a25acb346996106c12bb2dd0:

  btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations (2024-03-05 18:14:19 +0100)

----------------------------------------------------------------
for-6.9-tag

----------------------------------------------------------------
Anand Jain (1):
      btrfs: include device major and minor numbers in the device scan notice

Chengming Zhou (1):
      btrfs: remove SLAB_MEM_SPREAD flag use

Colin Ian King (1):
      btrfs: zlib: Fix spelling mistake "infalte" -> "inflate"

David Sterba (62):
      btrfs: replace sb::s_blocksize by fs_info::sectorsize
      btrfs: replace i_blocksize by fs_info::sectorsize
      btrfs: remove unused included headers
      btrfs: handle errors returned from unpin_extent_cache()
      btrfs: return errors from unpin_extent_range()
      btrfs: make btrfs_error_unpin_extent_range() return void
      btrfs: handle directory and dentry mismatch in btrfs_may_delete()
      btrfs: handle invalid range and start in merge_extent_mapping()
      btrfs: handle block group lookup error when it's being removed
      btrfs: handle root deletion lookup error in btrfs_del_root()
      btrfs: handle invalid root reference found in btrfs_find_root()
      btrfs: handle invalid root reference found in btrfs_init_root_free_objectid()
      btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
      btrfs: handle invalid extent item reference found in check_committed_ref()
      btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
      btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed_item()
      btrfs: change BUG_ON to assertion when checking for delayed_node root
      btrfs: defrag: change BUG_ON to assertion in btrfs_defrag_leaves()
      btrfs: change BUG_ON to assertion in btrfs_read_roots()
      btrfs: change BUG_ON to assertion when verifying lockdep class setup
      btrfs: change BUG_ON to assertion when verifying root in btrfs_alloc_reserved_file_extent()
      btrfs: change BUG_ON to assertion in reset_balance_state()
      btrfs: unify handling of return values of btrfs_insert_empty_items()
      btrfs: move transaction abort to the error site in btrfs_delete_free_space_tree()
      btrfs: move transaction abort to the error site in btrfs_create_free_space_tree()
      btrfs: move transaction abort to the error site btrfs_rebuild_free_space_tree()
      btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()
      btrfs: add helpers to get inode from page/folio pointers
      btrfs: add helpers to get fs_info from page/folio pointers
      btrfs: add helper to get fs_info from struct inode pointer
      btrfs: hoist fs_info out of loops in end_bbio_data_write and end_bbio_data_read
      btrfs: add forward declarations and headers, part 1
      btrfs: add forward declarations and headers, part 2
      btrfs: add forward declarations and headers, part 3
      btrfs: push errors up from add_async_extent()
      btrfs: update comment and drop assertion in extent item lookup in find_parent_nodes()
      btrfs: handle invalid extent item reference found in extent_from_logical()
      btrfs: handle invalid extent item reference found in find_first_extent_item()
      btrfs: handle invalid root reference found in may_destroy_subvol()
      btrfs: send: handle unexpected data in header buffer in begin_cmd()
      btrfs: send: handle unexpected inode in header process_recorded_refs()
      btrfs: send: handle path ref underflow in header iterate_inode_ref()
      btrfs: change BUG_ON to assertion in tree_move_down()
      btrfs: change BUG_ONs to assertions in btrfs_qgroup_trace_subtree()
      btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()
      btrfs: delete pointless BUG_ONs on extent item size
      btrfs: delete BUG_ON in btrfs_init_locked_inode()
      btrfs: factor out validation of btrfs_ioctl_vol_args::name
      btrfs: factor out validation of btrfs_ioctl_vol_args_v2::name
      btrfs: move balance args conversion helpers to volumes.c
      btrfs: open code btrfs_backref_iter_free()
      btrfs: open code btrfs_backref_get_eb()
      btrfs: uninline some static inline helpers from backref.h
      btrfs: uninline btrfs_init_delayed_root()
      btrfs: drop static inline specifiers from tree-mod-log.c
      btrfs: uninline some static inline helpers from tree-log.h
      btrfs: open code trivial btrfs_lru_cache_size()
      btrfs: uninline some static inline helpers from delayed-ref.h
      btrfs: handle transaction commit errors in flush_reservations()
      btrfs: pass btrfs_device to btrfs_scratch_superblocks()
      btrfs: merge btrfs_del_delalloc_inode() helpers
      btrfs: pass a valid extent map cache pointer to __get_extent_map()

Filipe Manana (19):
      btrfs: remove extent_map_tree forward declaration at extent_io.h
      btrfs: document what the spinlock unused_bgs_lock protects
      btrfs: add comment about list_is_singular() use at btrfs_delete_unused_bgs()
      btrfs: preallocate temporary extent buffer for inode logging when needed
      btrfs: stop passing root argument to btrfs_add_delalloc_inodes()
      btrfs: stop passing root argument to __btrfs_del_delalloc_inode()
      btrfs: assert root delalloc lock is held at __btrfs_del_delalloc_inode()
      btrfs: rename btrfs_add_delalloc_inodes() to singular form
      btrfs: reduce inode lock critical section when setting and clearing delalloc
      btrfs: add lockdep assertion to remaining delalloc callbacks
      btrfs: use assertion instead of BUG_ON when adding/removing to delalloc list
      btrfs: remove do_list variable at btrfs_set_delalloc_extent()
      btrfs: remove do_list variable at btrfs_clear_delalloc_extent()
      btrfs: remove no longer used btrfs_transaction_in_commit()
      btrfs: send: avoid duplicated search for last extent when sending hole
      btrfs: avoid unnecessary ref initialization when freeing log tree block
      btrfs: fix off-by-one chunk length calculation at contains_pending_extent()
      btrfs: fix race when detecting delalloc ranges during fiemap
      btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations

Goldwyn Rodrigues (1):
      btrfs: page to folio conversion in btrfs_truncate_block()

Johannes Thumshirn (1):
      btrfs: remove duplicate recording of physical address

Josef Bacik (1):
      btrfs: WARN_ON_ONCE() in our leak detection code

Kunwu Chan (6):
      btrfs: use KMEM_CACHE() to create btrfs_delayed_node cache
      btrfs: use KMEM_CACHE() to create btrfs_ordered_extent cache
      btrfs: use KMEM_CACHE() to create btrfs_trans_handle cache
      btrfs: use KMEM_CACHE() to create btrfs_path cache
      btrfs: use KMEM_CACHE() to create delayed ref caches
      btrfs: use KMEM_CACHE() to create btrfs_free_space cache

Lijuan Li (2):
      btrfs: mark __btrfs_add_free_space static
      btrfs: mark btrfs_put_caching_control() static

Matthew Wilcox (Oracle) (3):
      btrfs: add set_folio_extent_mapped() helper
      btrfs: convert defrag_prepare_one_page() to use a folio
      btrfs: use a folio array throughout the defrag process

Naohiro Aota (2):
      btrfs: use READ/WRITE_ONCE for fs_devices->read_policy
      btrfs: introduce offload_csum_mode to tweak checksum offloading behavior

Neal Gompa (1):
      btrfs: sysfs: drop unnecessary double logical negation in acl_show()

Qu Wenruo (13):
      btrfs: remove the pg_offset parameter from btrfs_get_extent()
      btrfs: remove unused variable bio_offset from end_bbio_data_read()
      btrfs: cache folio size and shift in extent_buffer
      btrfs: zstd: fix and simplify the inline extent decompression (v2)
      btrfs: raid56: extra debugging for raid6 syndrome generation
      btrfs: unexport btrfs_subpage_start_writer() and btrfs_subpage_end_and_test_writer()
      btrfs: subpage: make reader lock utilize bitmap
      btrfs: subpage: make writer lock utilize bitmap
      btrfs: compression: remove dead comments in btrfs_compress_heuristic()
      btrfs: tree-checker: dump the page status if hit something wrong
      btrfs: qgroup: always free reserved space for extent records
      btrfs: qgroup: validate btrfs_qgroup_inherit parameter
      btrfs: qgroup: allow quick inherit if snapshot is created and added to the same parent

 fs/btrfs/accessors.c             |  15 +-
 fs/btrfs/accessors.h             |  50 +----
 fs/btrfs/acl.c                   |   1 -
 fs/btrfs/acl.h                   |  11 ++
 fs/btrfs/async-thread.c          |   1 -
 fs/btrfs/async-thread.h          |   3 +
 fs/btrfs/backref.c               | 119 ++++++++++--
 fs/btrfs/backref.h               | 136 +++-----------
 fs/btrfs/bio.c                   |  17 +-
 fs/btrfs/bio.h                   |   2 +
 fs/btrfs/block-group.c           |  15 +-
 fs/btrfs/block-group.h           |  14 +-
 fs/btrfs/block-rsv.c             |   1 -
 fs/btrfs/block-rsv.h             |   7 +
 fs/btrfs/btrfs_inode.h           |  25 ++-
 fs/btrfs/compression.c           |  18 +-
 fs/btrfs/compression.h           |  12 +-
 fs/btrfs/ctree.c                 |  10 +-
 fs/btrfs/ctree.h                 |  28 ++-
 fs/btrfs/defrag.c                | 104 +++++------
 fs/btrfs/defrag.h                |  10 +
 fs/btrfs/delalloc-space.c        |   2 -
 fs/btrfs/delalloc-space.h        |   4 +
 fs/btrfs/delayed-inode.c         |  21 ++-
 fs/btrfs/delayed-inode.h         |  21 +--
 fs/btrfs/delayed-ref.c           |  85 +++++++--
 fs/btrfs/delayed-ref.h           |  82 ++-------
 fs/btrfs/dev-replace.c           |   5 +-
 fs/btrfs/dev-replace.h           |   4 +
 fs/btrfs/dir-item.h              |   6 +
 fs/btrfs/disk-io.c               |  30 ++-
 fs/btrfs/disk-io.h               |  20 +-
 fs/btrfs/export.c                |  12 +-
 fs/btrfs/export.h                |   4 +
 fs/btrfs/extent-io-tree.c        |   6 +-
 fs/btrfs/extent-io-tree.h        |   7 +
 fs/btrfs/extent-tree.c           |  51 ++++--
 fs/btrfs/extent-tree.h           |  10 +
 fs/btrfs/extent_io.c             | 387 +++++++++++++++++++++++++--------------
 fs/btrfs/extent_io.h             |  44 ++++-
 fs/btrfs/extent_map.c            |  23 ++-
 fs/btrfs/extent_map.h            |   8 +
 fs/btrfs/file-item.c             |   6 -
 fs/btrfs/file-item.h             |  13 ++
 fs/btrfs/file.c                  |  43 +++--
 fs/btrfs/file.h                  |  15 ++
 fs/btrfs/free-space-cache.c      |  12 +-
 fs/btrfs/free-space-cache.h      |  15 +-
 fs/btrfs/free-space-tree.c       |  56 +++---
 fs/btrfs/free-space-tree.h       |   6 +
 fs/btrfs/fs.h                    |  59 +++++-
 fs/btrfs/inode-item.c            |   1 -
 fs/btrfs/inode-item.h            |   5 +-
 fs/btrfs/inode.c                 | 238 +++++++++++++-----------
 fs/btrfs/ioctl.c                 | 120 +++++++-----
 fs/btrfs/ioctl.h                 |   9 +
 fs/btrfs/locking.c               |   3 +-
 fs/btrfs/locking.h               |   8 +-
 fs/btrfs/lru_cache.h             |   7 +-
 fs/btrfs/lzo.c                   |   4 +-
 fs/btrfs/messages.c              |   2 -
 fs/btrfs/misc.h                  |   2 +
 fs/btrfs/ordered-data.c          |   6 +-
 fs/btrfs/ordered-data.h          |  15 ++
 fs/btrfs/orphan.c                |   1 -
 fs/btrfs/orphan.h                |   5 +
 fs/btrfs/print-tree.h            |   3 +
 fs/btrfs/props.c                 |   3 +-
 fs/btrfs/props.h                 |   7 +-
 fs/btrfs/qgroup.c                | 148 +++++++++++++--
 fs/btrfs/qgroup.h                |  20 +-
 fs/btrfs/raid-stripe-tree.c      |   1 -
 fs/btrfs/raid-stripe-tree.h      |   5 +
 fs/btrfs/raid56.c                |  31 +++-
 fs/btrfs/raid56.h                |   9 +
 fs/btrfs/rcu-string.h            |   6 +
 fs/btrfs/ref-verify.h            |   9 +
 fs/btrfs/reflink.c               |  12 +-
 fs/btrfs/reflink.h               |   4 +-
 fs/btrfs/relocation.c            |   5 +-
 fs/btrfs/relocation.h            |   9 +
 fs/btrfs/root-tree.c             |  17 +-
 fs/btrfs/root-tree.h             |  10 +
 fs/btrfs/scrub.c                 |   9 +-
 fs/btrfs/scrub.h                 |   6 +
 fs/btrfs/send.c                  |  64 ++++---
 fs/btrfs/send.h                  |   8 +-
 fs/btrfs/space-info.c            |   1 -
 fs/btrfs/space-info.h            |   9 +
 fs/btrfs/subpage.c               |  74 ++++++--
 fs/btrfs/subpage.h               |  21 ++-
 fs/btrfs/super.c                 |   9 +-
 fs/btrfs/super.h                 |   7 +
 fs/btrfs/sysfs.c                 |  53 +++++-
 fs/btrfs/sysfs.h                 |   9 +
 fs/btrfs/tests/extent-io-tests.c |  28 ++-
 fs/btrfs/tests/inode-tests.c     |  40 ++--
 fs/btrfs/transaction.c           |  19 +-
 fs/btrfs/transaction.h           |  18 +-
 fs/btrfs/tree-checker.c          |   8 +-
 fs/btrfs/tree-checker.h          |   2 +
 fs/btrfs/tree-log.c              | 141 ++++++++++----
 fs/btrfs/tree-log.h              |  49 ++---
 fs/btrfs/tree-mod-log.c          |  13 +-
 fs/btrfs/tree-mod-log.h          |   8 +-
 fs/btrfs/ulist.c                 |   1 -
 fs/btrfs/ulist.h                 |   1 +
 fs/btrfs/uuid-tree.c             |   3 +-
 fs/btrfs/uuid-tree.h             |   5 +
 fs/btrfs/verity.c                |   1 -
 fs/btrfs/verity.h                |   7 +
 fs/btrfs/volumes.c               |  98 +++++++---
 fs/btrfs/volumes.h               |  53 +++++-
 fs/btrfs/xattr.h                 |   6 +-
 fs/btrfs/zlib.c                  |   2 +-
 fs/btrfs/zoned.c                 |   2 -
 fs/btrfs/zoned.h                 |  15 ++
 fs/btrfs/zstd.c                  |  75 +++-----
 include/uapi/linux/btrfs.h       |   1 +
 119 files changed, 2131 insertions(+), 1116 deletions(-)

