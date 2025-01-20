Return-Path: <linux-btrfs+bounces-11015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A2A17216
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 18:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E697618857CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D91E9B29;
	Mon, 20 Jan 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Qb2WRqNT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Qb2WRqNT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941A182BC;
	Mon, 20 Jan 2025 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394899; cv=none; b=SwNG1rHl3H8SVeKbaCn3nsZub1NUgBuhfr62zzN9v0kUCMouTFUneR5ETVqdN/OU7byDGhTAkj7OzG3wemv0QROW98mu7rvr7yZMPOqQFJtufxZH/vX+sHGdP8wHGS41i53nHVUlOBxgkgWvxO3FaukB3wXtYUVRAPK7ZfK2YSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394899; c=relaxed/simple;
	bh=Yx3br7Kyf60akXuFPIf/O0519Y24QtB8JL02Zx8kRUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEbnaLsWR85EKnBI50bZlWG1qPoLr2pCNexhSP/DZfglahm9Vlmc4Fd2JpcRoNbtJooxbXEDZazDUkGizQQcBJYqozjx7ekcLFP1dN+jz7x3R5mKPfwt2ddBoiX9dys4q4KlOINc+MFM/2gzVX/RF1qy75nTcuFEHWVDPbDXY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Qb2WRqNT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Qb2WRqNT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02D371F7BE;
	Mon, 20 Jan 2025 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737394895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/slj1zj1/I4zfZl7hgFWcJpLFl0061uW3/MeNXXesSI=;
	b=Qb2WRqNTxwwPPvSkv2n2E2GS0NE1DteDC8wCi3nnCVJeA9/eZFrK3heoZt4cphc+ZLRfw+
	CoxcuqzaJT0yxwIGarx2J50zd2G2s1SHFtgm+osQMfjL2mHM2DbvDlFUTWUpb7NO2bPrE8
	lQqcwiV8dv11kMF4Upc/8/yMpYX6PdE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737394895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/slj1zj1/I4zfZl7hgFWcJpLFl0061uW3/MeNXXesSI=;
	b=Qb2WRqNTxwwPPvSkv2n2E2GS0NE1DteDC8wCi3nnCVJeA9/eZFrK3heoZt4cphc+ZLRfw+
	CoxcuqzaJT0yxwIGarx2J50zd2G2s1SHFtgm+osQMfjL2mHM2DbvDlFUTWUpb7NO2bPrE8
	lQqcwiV8dv11kMF4Upc/8/yMpYX6PdE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFABF1393E;
	Mon, 20 Jan 2025 17:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDmCOs6KjmfidwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 Jan 2025 17:41:34 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.14
Date: Mon, 20 Jan 2025 18:41:27 +0100
Message-ID: <cover.1737393999.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull the following updates to btrfs. There are some new features
or feature previews, the reset the usual mix of core changes.  There's
also one minor rb-tree API update.

Please pull, thanks.

User visible changes, features:

- rebuilding of the free space tree at mount time is done in more
  transactions, fix potential hangs when the transaction thread is
  blocked due to large amount of block groups

- more read IO balancing strategies (experimental config), add two new
  ways how to select a device for read if the profiles allow that (all RAID1*),
  the current default selects the device by pid which is good on average
  but less performant for single reader workloads

  - select preferred device for all reads (namely for testing)
  - round-robin, balance reads across devices relevant for the requested IO
    range

- add encoded write ioctl support to io_uring (read was added in 6.12), basis
  for writing send stream using that instead of syscalls, non-blocking
  mode is not yet implemented

- support FS_IOC_READ_VERITY_METADATA, applications can use the metadata to do
  their own verification

- pass inode's i_write_hint to bios, for parity with other filesystems, ioctls
  F_GET_RW_HINT/F_SET_RW_HINT

Core:

- in zoned mode: allow to directly reclaim a block group by simply resetting
  it, then it can be reused and another block group does not need to be
  allocated

- super block validation now also does more comprehensive sys array validation,
  adding it to the points where superblock is validated (post-read, pre-write)

- subpage mode fixes
  - fix double accounting of blocks due to some races
  - improved or fixed error handling in a few cases (compression, delalloc)

- raid stripe tree
  - fix various cases with extent range splitting or deleting
  - implement hole punching to extent range
  - reduce number of stripe tree lookups during bio submission
  - more self-tests

- updated self-tests (delayed refs)

- error handling improvements

- cleanups, refactoring
  - remove rest of backref caching infrastructure from relocation, not needed
    anymore
  - error message updates
  - remove unnecessary calls when extent buffer was marked dirty
  - unused parameter removal
  - code moved to new files

Other code changes: add rb_find_add_cached() to the rb-tree API

----------------------------------------------------------------
The following changes since commit 5bc55a333a2f7316b58edc7573e8e893f7acb532:

  Linux 6.13-rc7 (2025-01-12 14:37:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-tag

for you to fetch changes up to 9d0c23db26cb58c9fc6ee8817e8f9ebeb25776e5:

  btrfs: selftests: add a selftest for deleting two out of three extents (2025-01-14 15:57:55 +0100)

----------------------------------------------------------------
Allison Karlitskaya (1):
      btrfs: handle FS_IOC_READ_VERITY_METADATA ioctl

Anand Jain (10):
      btrfs: initialize fs_devices->fs_info earlier in btrfs_init_devices_late()
      btrfs: sysfs: refactor output formatting in btrfs_read_policy_show()
      btrfs: sysfs: add btrfs_read_policy_to_enum() helper and refactor read policy store
      btrfs: sysfs: handle value associated with read balancing policy
      btrfs: add tracking of read blocks for read policy
      btrfs: introduce RAID1 round-robin read balancing
      btrfs: add read policy to set a preferred device
      btrfs: print status of experimental mode when loading module
      btrfs: configure read policy via module parameter
      btrfs: print read policy on module load

Colin Ian King (1):
      btrfs: send: remove redundant assignments to variable ret

David Sterba (18):
      btrfs: drop unused parameter fs_info to btrfs_delete_delayed_insertion_item()
      btrfs: remove stray comment about SRCU
      btrfs: use SECTOR_SIZE defines in btrfs_issue_discard()
      btrfs: rename __unlock_for_delalloc() and drop underscores
      btrfs: open code set_page_extent_mapped()
      btrfs: rename __get_extent_map() and pass btrfs_inode
      btrfs: use btrfs_inode in extent_writepage()
      btrfs: make wait_on_extent_buffer_writeback() static inline
      btrfs: drop one time used local variable in end_bbio_meta_write()
      btrfs: open code __free_extent_buffer()
      btrfs: rename btrfs_release_extent_buffer_pages() to mention folios
      btrfs: switch grab_extent_buffer() to folios
      btrfs: change return type to bool type of check_eb_alignment()
      btrfs: unwrap folio locking helpers
      btrfs: remove unused define WAIT_PAGE_LOCK for extent io
      btrfs: split waiting from read_extent_buffer_pages(), drop parameter wait
      btrfs: remove redundant variables from __process_folios_contig() and lock_delalloc_folios()
      btrfs: async-thread: rename DFT_THRESHOLD to DEFAULT_THRESHOLD

Filipe Manana (38):
      btrfs: remove no longer needed strict argument from can_nocow_extent()
      btrfs: remove the snapshot check from check_committed_ref()
      btrfs: avoid redundant call to get inline ref type at check_committed_ref()
      btrfs: simplify return logic at check_committed_ref()
      btrfs: simplify arguments for btrfs_cross_ref_exist()
      btrfs: add function comment for check_committed_ref()
      btrfs: add assertions and comment about path expectations to btrfs_cross_ref_exist()
      btrfs: move abort_should_print_stack() to transaction.h
      btrfs: move csum related functions from ctree.c into fs.c
      btrfs: move the exclusive operation functions into fs.c
      btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
      btrfs: move the folio ordered helpers from ctree.h into fs.h
      btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
      btrfs: move btrfs_alloc_write_mask() into fs.h
      btrfs: move extent-tree function declarations out of ctree.h
      btrfs: remove pointless comment from ctree.h
      btrfs: use uuid_is_null() to verify if an uuid is empty
      btrfs: uncollapse transaction aborts during renames
      btrfs: tree-log: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: free-space-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: extent-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: block-group: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: delayed-inode: remove unnecessary call to btrfs_mark_buffer_dirty()
      btrfs: dev-replace: remove unnecessary call to btrfs_mark_buffer_dirty()
      btrfs: dir-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: file: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: file-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: free-space-cache: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: inode: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: inode-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: ioctl: remove unnecessary call to btrfs_mark_buffer_dirty()
      btrfs: qgroup: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: raid-stripe-tree: remove unnecessary call to btrfs_mark_buffer_dirty()
      btrfs: relocation: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: root-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: uuid-tree: remove unnecessary call to btrfs_mark_buffer_dirty()
      btrfs: volumes: remove unnecessary calls to btrfs_mark_buffer_dirty()
      btrfs: xattr: remove unnecessary call to btrfs_mark_buffer_dirty()

Hao-ran Zheng (1):
      btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()

Jing Xia (1):
      btrfs: pass write-hint for buffered IO

Johannes Thumshirn (19):
      btrfs: don't BUG_ON() in btrfs_drop_extents()
      btrfs: remove unused variable length in btrfs_insert_one_raid_extent()
      btrfs: cache stripe tree usage in struct btrfs_io_geometry
      btrfs: cache RAID stripe tree decision in btrfs_io_context
      btrfs: pass btrfs_io_geometry to is_single_device_io
      btrfs: selftests: correct RAID stripe-tree feature flag setting
      btrfs: don't try to delete RAID stripe-extents if we don't need to
      btrfs: assert RAID stripe-extent length is always greater than 0
      btrfs: fix front delete range calculation for RAID stripe extents
      btrfs: fix tail delete of RAID stripe-extents
      btrfs: fix deletion of a range spanning parts two RAID stripe extents
      btrfs: implement hole punching for RAID stripe extents
      btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
      btrfs: selftests: check for correct return value of failed lookup
      btrfs: selftests: don't split RAID extents in half
      btrfs: selftests: test RAID stripe-tree deletion spanning two items
      btrfs: selftests: add selftest for punching holes into the RAID stripe extents
      btrfs: selftests: add test for punching a hole into 3 RAID stripe-extents
      btrfs: selftests: add a selftest for deleting two out of three extents

Josef Bacik (12):
      btrfs: move select_delayed_ref() and export it
      btrfs: selftests: add delayed ref self test cases
      btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
      btrfs: remove the changed list for backref cache
      btrfs: add a comment for new_bytenr in backref_cache_node
      btrfs: simplify loop in select_reloc_root()
      btrfs: remove clone_backref_node() from relocation
      btrfs: don't build backref tree for COW-only blocks
      btrfs: do not handle non-shareable roots in backref cache
      btrfs: simplify btrfs_backref_release_cache()
      btrfs: remove the ->lowest and ->leaves members from struct btrfs_backref_node
      btrfs: remove detached list from struct btrfs_backref_cache

Mark Harmstone (1):
      btrfs: add io_uring interface for encoded writes

Naohiro Aota (3):
      btrfs: factor out btrfs_return_free_space()
      btrfs: drop fs_info argument from btrfs_update_space_info_*()
      btrfs: zoned: reclaim unused zone by zone resetting

Qu Wenruo (15):
      btrfs: use PTR_ERR() instead of PTR_ERR_OR_ZERO() for btrfs_get_extent()
      btrfs: improve the warning and error message for btrfs_remove_qgroup()
      btrfs: open-code btrfs_copy_from_user()
      btrfs: output the reason for open_ctree() failure
      btrfs: handle free space tree rebuild in multiple transactions
      btrfs: validate system chunk array at btrfs_validate_super()
      btrfs: fix double accounting race when btrfs_run_delalloc_range() failed
      btrfs: fix double accounting race when extent_writepage_io() failed
      btrfs: fix error handling of submit_uncompressed_range()
      btrfs: do proper folio cleanup when cow_file_range() failed
      btrfs: do proper folio cleanup when run_delalloc_nocow() failed
      btrfs: subpage: fix the bitmap dump of the locked flags
      btrfs: subpage: dump the involved bitmap when ASSERT() failed
      btrfs: add extra error messages for delalloc range related errors
      btrfs: remove the unused locked_folio parameter from btrfs_cleanup_ordered_extents()

Roger L. Beckermeyer III (6):
      rbtree: add rb_find_add_cached() to rbtree.h
      btrfs: update btrfs_add_block_group_cache() to use rb helper
      btrfs: update prelim_ref_insert() to use rb helpers
      btrfs: update __btrfs_add_delayed_item() to use rb helper
      btrfs: update btrfs_add_chunk_map() to use rb helpers
      btrfs: update tree_insert() to use rb helpers

Wolfram Sang (1):
      btrfs: don't include linux/rwlock_types.h directly

 fs/btrfs/Makefile                       |    2 +-
 fs/btrfs/async-thread.c                 |    6 +-
 fs/btrfs/backref.c                      |  172 ++----
 fs/btrfs/backref.h                      |   16 +-
 fs/btrfs/bio.c                          |   11 +-
 fs/btrfs/block-group.c                  |   64 +-
 fs/btrfs/block-rsv.c                    |   10 +-
 fs/btrfs/btrfs_inode.h                  |    2 +-
 fs/btrfs/ctree.c                        |   68 +--
 fs/btrfs/ctree.h                        |   29 -
 fs/btrfs/delalloc-space.c               |    2 +-
 fs/btrfs/delayed-inode.c                |   49 +-
 fs/btrfs/delayed-ref.c                  |   89 ++-
 fs/btrfs/delayed-ref.h                  |    1 +
 fs/btrfs/dev-replace.c                  |    3 -
 fs/btrfs/dir-item.c                     |    2 -
 fs/btrfs/direct-io.c                    |    3 +-
 fs/btrfs/disk-io.c                      |   75 ++-
 fs/btrfs/disk-io.h                      |    3 -
 fs/btrfs/extent-tree.c                  |  202 +++---
 fs/btrfs/extent-tree.h                  |    7 +-
 fs/btrfs/extent_io.c                    |  250 +++++---
 fs/btrfs/extent_io.h                    |   16 +-
 fs/btrfs/file-item.c                    |    3 -
 fs/btrfs/file.c                         |  106 ++--
 fs/btrfs/free-space-cache.c             |    7 +-
 fs/btrfs/free-space-tree.c              |   11 +-
 fs/btrfs/fs.c                           |  130 ++++
 fs/btrfs/fs.h                           |   31 +-
 fs/btrfs/inode-item.c                   |    5 -
 fs/btrfs/inode.c                        |  325 ++++++----
 fs/btrfs/ioctl.c                        |  222 ++++---
 fs/btrfs/ioctl.h                        |    1 -
 fs/btrfs/locking.h                      |    5 +
 fs/btrfs/qgroup.c                       |   39 +-
 fs/btrfs/raid-stripe-tree.c             |  146 ++++-
 fs/btrfs/relocation.c                   |  369 +++++------
 fs/btrfs/root-tree.c                    |    2 -
 fs/btrfs/send.c                         |    3 +-
 fs/btrfs/space-info.c                   |   69 ++-
 fs/btrfs/space-info.h                   |   15 +-
 fs/btrfs/subpage.c                      |   47 +-
 fs/btrfs/subpage.h                      |   13 +
 fs/btrfs/super.c                        |   20 +-
 fs/btrfs/sysfs.c                        |  174 +++++-
 fs/btrfs/sysfs.h                        |    6 +
 fs/btrfs/tests/btrfs-tests.c            |   18 +
 fs/btrfs/tests/btrfs-tests.h            |    6 +
 fs/btrfs/tests/delayed-refs-tests.c     | 1015 +++++++++++++++++++++++++++++++
 fs/btrfs/tests/raid-stripe-tree-tests.c |  661 +++++++++++++++++++-
 fs/btrfs/transaction.c                  |    3 +-
 fs/btrfs/transaction.h                  |   18 +-
 fs/btrfs/tree-checker.c                 |   96 +--
 fs/btrfs/tree-checker.h                 |    7 +-
 fs/btrfs/tree-log.c                     |    4 -
 fs/btrfs/uuid-tree.c                    |    2 -
 fs/btrfs/volumes.c                      |  240 +++++---
 fs/btrfs/volumes.h                      |   21 +
 fs/btrfs/xattr.c                        |    1 -
 fs/btrfs/zoned.c                        |  124 ++++
 fs/btrfs/zoned.h                        |    7 +
 include/linux/rbtree.h                  |   37 ++
 include/trace/events/btrfs.h            |    3 +-
 63 files changed, 3751 insertions(+), 1343 deletions(-)
 create mode 100644 fs/btrfs/tests/delayed-refs-tests.c

