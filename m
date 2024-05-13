Return-Path: <linux-btrfs+bounces-4934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E74A8C4514
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C748F1F223C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522E8155386;
	Mon, 13 May 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VeBnFO3+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kn9w/Qh5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89023CB;
	Mon, 13 May 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617700; cv=none; b=PfKv2uQwOu1NX1JK9d8FfubWEqFKcfLxeDzUdjdIWVtakTi6+7ojIc8tKoRM+7eN2FkC6+gK9EecRNwP9eynHE3BrM2jyPbHSx8bpodFYTVwdMrM3a6RInvYrDOJSS4mtxTUrG7xFjMmffxa8whVIprC4et7sgM28BedOVk2Ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617700; c=relaxed/simple;
	bh=zcLnKNJr4jbI4uqq+p59ZBl6tAxVOliGl2+smkj02XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3rxDuP2ssH50QL5wAwfOb4EJty/mwrxoLk3jFQ6KfxRNfoGOh62/L18o8jd7n92bpcJ0E1dLU6c7c6wqoHOqXMS3rXG0/tYa0oPESWO8bL8xtDigs0DVrwR941Z9Fe3purbbRXaflxdz7+oIxzhJct6ftS2wfsNPLUMi59S96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VeBnFO3+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kn9w/Qh5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 575675C613;
	Mon, 13 May 2024 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715617696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3M+pmnICfa+u35Bp9lHsUm7e484xllcOKWW6NDPbOPc=;
	b=VeBnFO3+Mfk/bnH2BnJo5wk0HQ4C9LRGtjtzGxgnvOhfJBA1MoLGuzsC7amKMusXOvIg66
	vYwwNiuL2BQqeVY44fKnjemTHpfjBeuZU3SmwMhV2NGub+ypLVMdMqJBVVvytgiCrj6G3O
	RV/ifIVSLy+rKZpng4tk2NFyqwkCpHw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Kn9w/Qh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715617695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3M+pmnICfa+u35Bp9lHsUm7e484xllcOKWW6NDPbOPc=;
	b=Kn9w/Qh5X1c+5E2M9ogLFQ1DGO3qZ1nYQ28GuubaCpWKukdanOvk6gNQeM9cmcAHw20ySA
	oOqOAH2PH7/prVvqE1WR7zASr2VDanKRy5E6MhoKH90evYeQNsTKwzvNGo2U+rxhAVKmRo
	ePnPSYsyg6qQTSkBPvfGxONe+lHTmiU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 505351372E;
	Mon, 13 May 2024 16:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AW+aE58/QmaKZAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 13 May 2024 16:28:15 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.10
Date: Mon, 13 May 2024 18:20:55 +0200
Message-ID: <cover.1715616501.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 575675C613
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

Hi,

this update brings a few minor performance improvements, otherwise
there's a lot of refactoring, cleanups and other sort of not user
visible changes.

Please pull, thanks.


Performance improvements

- inline b-tree locking functions, improvement in metadata-heavy changes

- relax locking on a range that's being reflinked, allows read operations to
  run in parallel

- speed up NOCOW write checks (throughput +9% on a sample test)

- extent locking ranges have been reduced in several places, namely
  around delayed ref processing

Core

- more page to folio conversions
  - relocation
  - send
  - compression
  - inline extent handling
  - super block write and wait

- extent_map structure optimizations
  - reduced structure size
  - code simplifications
  - add shrinker for allocated objects, the numbers can go high and could
    exhaust memory on smaller systems (reported) as they may not get an
    opportunity to be freed fast enough

- extent locking optimizations
  - reduce locking ranges where it does not seem to be necessary and
    are safe due to other means of synchronization
  - potential improvements due to lower contention, allocation/freeing
    and state management operations of extent state tracking structures

- delayed ref cleanups and simplifications

- updated trace points

- improved error handling, warnings and assertions

- cleanups and refactoring, unification of error handling paths

----------------------------------------------------------------
The following changes since commit dccb07f2914cdab2ac3a5b6c98406f765acab803:

  Merge tag 'for-6.9-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2024-05-06 13:43:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag

for you to fetch changes up to 0e39c9e524479b85c1b83134df0cfc6e3cb5353a:

  btrfs: qgroup: fix initialization of auto inherit array (2024-05-07 21:31:11 +0200)

----------------------------------------------------------------
Anand Jain (20):
      btrfs: rename err to ret in btrfs_initxattrs()
      btrfs: rename err to ret in btrfs_rmdir()
      btrfs: rename err to ret in btrfs_cont_expand()
      btrfs: rename err to ret in btrfs_ioctl_snap_destroy()
      btrfs: rename err to ret in __set_extent_bit()
      btrfs: rename err to ret in convert_extent_bit()
      btrfs: rename err to ret in __btrfs_end_transaction()
      btrfs: rename err to ret in create_reloc_inode()
      btrfs: rename err to ret in btrfs_dirty_pages()
      btrfs: rename err to ret in prepare_pages()
      btrfs: rename err to ret in btrfs_direct_write()
      btrfs: report filemap_fdata<write|wait>_range() error
      btrfs: rename werr and err to ret in btrfs_write_marked_extents()
      btrfs: rename werr and err to ret in __btrfs_wait_marked_extents()
      btrfs: rename err and ret to ret in build_backref_tree()
      btrfs: reuse ret instead of err in relocate_tree_blocks()
      btrfs: drop variable err in quick_update_accounting()
      btrfs: rename return variables in btrfs_qgroup_rescan_worker()
      btrfs: simplify return variables in lookup_extent_data_ref()
      btrfs: simplify return variables in btrfs_drop_subtree()

Boris Burkov (1):
      btrfs: free PERTRANS at the end of cleanup_transaction()

Dan Carpenter (2):
      btrfs: qgroup: delete unnecessary check in btrfs_qgroup_check_inherit()
      btrfs: qgroup: fix initialization of auto inherit array

David Sterba (1):
      btrfs: use btrfs_is_testing() everywhere

Filipe Manana (39):
      btrfs: remove pointless BUG_ON() when creating snapshot
      btrfs: locking: inline btrfs_tree_lock() and btrfs_tree_read_lock()
      btrfs: locking: rename __btrfs_tree_lock() and __btrfs_tree_read_lock()
      btrfs: remove pointless readahead callback wrapper
      btrfs: remove pointless writepages callback wrapper
      btrfs: avoid pointless wake ups of drew lock readers
      btrfs: stop locking the source extent range during reflink
      btrfs: remove not needed mod_start and mod_len from struct extent_map
      btrfs: remove pointless return value assignment at btrfs_finish_one_ordered()
      btrfs: remove list_empty() check at warn_about_uncommitted_trans()
      btrfs: remove no longer used btrfs_clone_chunk_map()
      btrfs: move btrfs_page_mkwrite() from inode.c into file.c
      btrfs: add function comment to btrfs_lookup_csums_list()
      btrfs: remove search_commit parameter from btrfs_lookup_csums_list()
      btrfs: remove use of a temporary list at btrfs_lookup_csums_list()
      btrfs: simplify error path for btrfs_lookup_csums_list()
      btrfs: make NOCOW checks for existence of checksums in a range more efficient
      btrfs: open code csum_exist_in_range()
      btrfs: pass an inode to btrfs_add_extent_mapping()
      btrfs: tests: error out on unexpected extent map reference count
      btrfs: simplify add_extent_mapping() by removing pointless label
      btrfs: export find_next_inode() as btrfs_find_first_inode()
      btrfs: use btrfs_find_first_inode() at btrfs_prune_dentries()
      btrfs: pass the extent map tree's inode to add_extent_mapping()
      btrfs: pass the extent map tree's inode to clear_em_logging()
      btrfs: pass the extent map tree's inode to remove_extent_mapping()
      btrfs: pass the extent map tree's inode to replace_extent_mapping()
      btrfs: pass the extent map tree's inode to setup_extent_mapping()
      btrfs: pass the extent map tree's inode to try_merge_map()
      btrfs: add a global per cpu counter to track number of used extent maps
      btrfs: add a shrinker for extent maps
      btrfs: update comment for btrfs_set_inode_full_sync() about locking
      btrfs: add tracepoints for extent map shrinker events
      btrfs: rename some variables at try_release_extent_mapping()
      btrfs: use btrfs_get_fs_generation() at try_release_extent_mapping()
      btrfs: remove i_size restriction at try_release_extent_mapping()
      btrfs: be better releasing extent maps at try_release_extent_mapping()
      btrfs: make try_release_extent_mapping() return a bool
      btrfs: initialize delayed inodes xarray without GFP_ATOMIC

Goldwyn Rodrigues (3):
      btrfs: page to folio conversion: prealloc_file_extent_cluster()
      btrfs: convert relocate_one_page() to folios and rename
      btrfs: convert put_file_data() to folios

Josef Bacik (38):
      btrfs: add a helper to get the delayed ref node from the data/tree ref
      btrfs: embed data_ref and tree_ref in btrfs_delayed_ref_node
      btrfs: do not use a function to initialize btrfs_ref
      btrfs: move ref_root into btrfs_ref
      btrfs: pass btrfs_ref to init_delayed_ref_common
      btrfs: initialize btrfs_delayed_ref_head with btrfs_ref
      btrfs: move ref specific initialization into init_delayed_ref_common
      btrfs: simplify delayed ref tracepoints
      btrfs: unify the btrfs_add_delayed_*_ref helpers into one helper
      btrfs: rename ->len to ->num_bytes in btrfs_ref
      btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node
      btrfs: rename btrfs_data_ref->ino to ->objectid
      btrfs: make __btrfs_inc_extent_ref take a btrfs_delayed_ref_node
      btrfs: drop unnecessary arguments from __btrfs_free_extent
      btrfs: make the insert backref helpers take a btrfs_delayed_ref_node
      btrfs: stop referencing btrfs_delayed_data_ref directly
      btrfs: stop referencing btrfs_delayed_tree_ref directly
      btrfs: remove the btrfs_delayed_ref_node container helpers
      btrfs: replace btrfs_delayed_*_ref with btrfs_*_ref
      btrfs: set start on clone before calling copy_extent_buffer_full
      btrfs: change root->root_key.objectid to btrfs_root_id()
      btrfs: handle errors in btrfs_reloc_clone_csums properly
      btrfs: push all inline logic into cow_file_range
      btrfs: unlock all the pages with successful inline extent creation
      btrfs: move extent bit and page cleanup into cow_file_range_inline
      btrfs: lock extent when doing inline extent in compression
      btrfs: push the extent lock into btrfs_run_delalloc_range
      btrfs: push extent lock into run_delalloc_nocow
      btrfs: adjust while loop condition in run_delalloc_nocow
      btrfs: push extent lock down in run_delalloc_nocow
      btrfs: remove unlock_extent from run_delalloc_compressed
      btrfs: push extent lock into run_delalloc_cow
      btrfs: push extent lock into cow_file_range
      btrfs: push lock_extent into cow_file_range_inline
      btrfs: move can_cow_file_range_inline() outside of the extent lock
      btrfs: push lock_extent down in cow_file_range()
      btrfs: push extent lock down in submit_one_async_extent
      btrfs: add a cached state to extent_clear_unlock_delalloc

Matthew Wilcox (Oracle) (5):
      bio: Export bio_add_folio_nofail to modules
      btrfs: convert super block writes to folio in wait_dev_supers()
      btrfs: convert super block writes to folio in write_dev_supers()
      btrfs: use the folio iterator in btrfs_end_super_write()
      btrfs: count super block write errors in device instead of tracking folio error state

Naohiro Aota (1):
      btrfs: drop unused argument of calcu_metadata_size()

Qu Wenruo (9):
      btrfs: compression: add error handling for missed page cache
      btrfs: compression: convert page allocation to folio interfaces
      btrfs: make insert_inline_extent() accept one page directly
      btrfs: migrate insert_inline_extent() to folio interfaces
      btrfs: introduce btrfs_alloc_folio_array()
      btrfs: compression: migrate compression/decompression paths to folios
      btrfs: add extra comments on extent_map members
      btrfs: simplify the inline extent map creation
      btrfs: add extra sanity checks for create_io_em()

Tavian Barnes (2):
      btrfs: add helper to clear EXTENT_BUFFER_READING
      btrfs: warn if EXTENT_BUFFER_UPTODATE is set while reading

Thorsten Blum (1):
      btrfs: remove duplicate included header from fs.h

 block/bio.c                       |   1 +
 fs/btrfs/backref.c                |  48 +-
 fs/btrfs/block-rsv.c              |  11 +-
 fs/btrfs/btrfs_inode.h            |  10 +-
 fs/btrfs/compression.c            | 119 +++--
 fs/btrfs/compression.h            |  42 +-
 fs/btrfs/ctree.c                  |  51 +--
 fs/btrfs/defrag.c                 |   2 +-
 fs/btrfs/delayed-inode.c          |   2 +-
 fs/btrfs/delayed-ref.c            | 365 +++++----------
 fs/btrfs/delayed-ref.h            | 148 +++---
 fs/btrfs/disk-io.c                | 157 +++----
 fs/btrfs/export.c                 |   8 +-
 fs/btrfs/extent-io-tree.c         |  58 +--
 fs/btrfs/extent-tree.c            | 366 +++++++--------
 fs/btrfs/extent_io.c              | 223 +++++----
 fs/btrfs/extent_io.h              |  11 +-
 fs/btrfs/extent_map.c             | 316 ++++++++++---
 fs/btrfs/extent_map.h             |  67 ++-
 fs/btrfs/file-item.c              |  90 ++--
 fs/btrfs/file-item.h              |   3 +-
 fs/btrfs/file.c                   | 327 ++++++++++----
 fs/btrfs/fs.h                     |   5 +-
 fs/btrfs/inode-item.c             |  16 +-
 fs/btrfs/inode.c                  | 923 +++++++++++++++++---------------------
 fs/btrfs/ioctl.c                  |  86 ++--
 fs/btrfs/locking.c                |  26 +-
 fs/btrfs/locking.h                |  18 +-
 fs/btrfs/lzo.c                    |  89 ++--
 fs/btrfs/ordered-data.c           |   8 +-
 fs/btrfs/ordered-data.h           |   1 +
 fs/btrfs/props.c                  |   2 +-
 fs/btrfs/qgroup.c                 |  79 ++--
 fs/btrfs/ref-verify.c             |   8 +-
 fs/btrfs/reflink.c                |  56 +--
 fs/btrfs/relocation.c             | 417 ++++++++---------
 fs/btrfs/root-tree.c              |   3 +-
 fs/btrfs/send.c                   |  74 +--
 fs/btrfs/super.c                  |  33 +-
 fs/btrfs/sysfs.c                  |   8 +-
 fs/btrfs/tests/btrfs-tests.c      |   3 +-
 fs/btrfs/tests/extent-map-tests.c | 216 +++++----
 fs/btrfs/transaction.c            |  76 ++--
 fs/btrfs/tree-checker.c           |   2 +-
 fs/btrfs/tree-log.c               |  46 +-
 fs/btrfs/tree-mod-log.c           |   2 +-
 fs/btrfs/volumes.c                |  15 -
 fs/btrfs/volumes.h                |  10 +-
 fs/btrfs/xattr.c                  |  10 +-
 fs/btrfs/zlib.c                   | 112 ++---
 fs/btrfs/zstd.c                   |  80 ++--
 include/trace/events/btrfs.h      | 158 +++++--
 52 files changed, 2650 insertions(+), 2357 deletions(-)

