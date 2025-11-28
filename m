Return-Path: <linux-btrfs+bounces-19386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E819C90851
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 02:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D2350991
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8633224A067;
	Fri, 28 Nov 2025 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SqloRsJA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SqloRsJA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E124677F
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294193; cv=none; b=FnGGrcCk5XOfiKDeJymcsnNKaywDgtxU4W27tY7CjyDengW+fuM0kaq+S6sKA6NJOmbtyP+JOx1bLf+N4nXPuIZAkl9DsMvlbq0NGYxU+s3Ah2VXBxVsOrKe+WmDIE413Skn0KDIjcCIIt56pLHRHVSNe8rPHVXzrPX8k/VoY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294193; c=relaxed/simple;
	bh=1A0LuyiYy51H9ZQYjT4bH3eMA8wM7jvRDC+Ly0WfGP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i1x4Le2XXSxaKbuSzpWacr/68BZMCIJ2lURrHHac2Ld/e1QUDYUrR7u2r+dduqRrWBPMUsF38j8B0BCQIfodd4cn0wZkeSTERxcALm6lC2MoOnVHKMZ4MIpxGYFw1swwHhIPcgIF3RQITZ54C73mIZlxFh26+nhCyRW78oj/Gdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SqloRsJA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SqloRsJA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 149A7336C1;
	Fri, 28 Nov 2025 01:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764294188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8LVEzhEJW7XaPrmME3oKO8SGyHlgnyQ34afm/RYmcTc=;
	b=SqloRsJA+WjTV9HCBD7HxuBMlMV95SuRSUkiSsQAxlx3N4wXNOdhn4Bhclda8p/d9M3lwl
	o62J98CCRgd3sI8kM9033P89BCGpU9agiZI6UA/GYgASmn4KDgADlKsdDeYQihGaKddLz4
	QOdfqtERgNdLtKXvWVAlRzo3XAgL0As=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764294188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8LVEzhEJW7XaPrmME3oKO8SGyHlgnyQ34afm/RYmcTc=;
	b=SqloRsJA+WjTV9HCBD7HxuBMlMV95SuRSUkiSsQAxlx3N4wXNOdhn4Bhclda8p/d9M3lwl
	o62J98CCRgd3sI8kM9033P89BCGpU9agiZI6UA/GYgASmn4KDgADlKsdDeYQihGaKddLz4
	QOdfqtERgNdLtKXvWVAlRzo3XAgL0As=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F32D33EA63;
	Fri, 28 Nov 2025 01:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DB4IOyv+KGmzDwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Nov 2025 01:43:07 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.19
Date: Fri, 28 Nov 2025 02:43:04 +0100
Message-ID: <cover.1764293730.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi,

please pull the following branch with btrfs updates. Thanks.

Features:

- shutdown ioctl support (needs CONFIG_BTRFS_EXPERIMENTAL for now)
  - set filesystem state as being shut down (also named going down in
    other filesystems), where all active operations return EIO and this
    cannot be changed until unmount
  - pending operations are attempted to be finished but error messages
    may still show up depending on where exactly the shutdown happened

- scrub (and device replace) vs suspend/hibernate
  - a running scrub will prevent suspend, which can be annoying as
    suspend is an immediate request and scrub is not critical
  - filesystem freezing before suspend was not sufficient as the problem
    was in process freezing
  - behaviour change: on suspend scrub and device replace are cancelled,
    where scrub can record the last state and continue from there; the
    device replace has to be restarted from the beginning

- zone stats exported in sysfs, from the perspective of the filesystem
  this includes active, reclaimable, relocation etc zones

Performance:

- improvements when processing space reservation tickets by optimizing
  locking and shrinking critical sections, cumulative improvements in
  lockstat numbers show +15%

Notable fixes:

- use vmalloc fallback when allocating bios as high order allocations
  can happen with wide checksums (like sha256)

- scrub will always track the last position of progress so it's not
  starting from zero after an error

Core:

- under experimental config, checksum calculations are offloaded to
  process context, simplifies locking and allows to remove compression
  write worker kthread(s)
  - speed improvement in direct IO throughput with buffered IO fallback
    is +15% when not offloaded but this is more related to internal
    crypto subsystem improvements
  - this will be probably default in the future removing the sysfs
    tunable

- (experimental) block size > page size updates
  - support more operations when not using large folios (encoded
    read/write and send)
  - raid56

- more preparations for fscrypt support

Other:

- more conversions to auto-cleaned variables

- parameter cleanups and removals

- extended warning fixes

- improved printing of structured values like keys

- lots of other cleanups and refactoring

----------------------------------------------------------------
The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-tag

for you to fetch changes up to 9e0e6577b3e5e5cf7c1acd178eb648e8f830ba17:

  btrfs: remove unnecessary inode key in btrfs_log_all_parents() (2025-11-25 01:53:33 +0100)

----------------------------------------------------------------
Andy Shevchenko (1):
      btrfs: replace const_ilog2() with ilog2()

Baolin Liu (1):
      btrfs: simplify list initialization in btrfs_compr_pool_scan()

Boris Burkov (2):
      btrfs: ignore ENOMEM from alloc_bitmap()
      btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

David Sterba (6):
      btrfs: print-tree: use string format for key names
      btrfs: fix trivial -Wshadow warnings
      btrfs: subpage: rename macro variables to avoid shadowing
      btrfs: move and rename CSUM_FMT definition
      btrfs: make a few more ASSERTs verbose
      btrfs: remaining BTRFS_PATH_AUTO_FREE conversions

Filipe Manana (77):
      btrfs: use single return value variable in btrfs_relocate_block_group()
      btrfs: use end_pos variable where needed in btrfs_dirty_folio()
      btrfs: truncate ordered extent when skipping writeback past i_size
      btrfs: use variable for end offset in extent_writepage_io()
      btrfs: split assertion into two in extent_writepage_io()
      btrfs: add unlikely to unexpected error case in extent_writepages()
      btrfs: consistently round up or down i_size in btrfs_truncate()
      btrfs: avoid multiple i_size rounding in btrfs_truncate()
      btrfs: avoid repeated computations in btrfs_mark_ordered_io_finished()
      btrfs: remove fs_info argument from btrfs_try_granting_tickets()
      btrfs: remove fs_info argument from priority_reclaim_data_space()
      btrfs: remove fs_info argument from priority_reclaim_metadata_space()
      btrfs: remove fs_info argument from maybe_fail_all_tickets()
      btrfs: remove fs_info argument from calc_available_free_space()
      btrfs: remove fs_info argument from btrfs_can_overcommit()
      btrfs: remove fs_info argument from btrfs_dump_space_info()
      btrfs: remove fs_info argument from shrink_delalloc() and flush_space()
      btrfs: remove fs_info argument from btrfs_calc_reclaim_metadata_size()
      btrfs: remove fs_info argument from need_preemptive_reclaim()
      btrfs: remove fs_info argument from steal_from_global_rsv()
      btrfs: remove fs_info argument from handle_reserve_ticket()
      btrfs: remove fs_info argument from maybe_clamp_preempt()
      btrfs: fix parameter documentation for btrfs_reserve_data_bytes()
      btrfs: remove fs_info argument from __reserve_bytes()
      btrfs: remove fs_info argument from btrfs_reserve_metadata_bytes()
      btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()
      btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()
      btrfs: add macros to facilitate printing of keys
      btrfs: use the key format macros when printing keys
      btrfs: remove pointless data_end assignment in btrfs_extent_item()
      btrfs: return real error when failing tickets in maybe_fail_all_tickets()
      btrfs: avoid recomputing used space in btrfs_try_granting_tickets()
      btrfs: make btrfs_can_overcommit() return bool instead of int
      btrfs: avoid used space computation when trying to grant tickets
      btrfs: avoid used space computation when reserving space
      btrfs: inline btrfs_space_info_used()
      btrfs: bail out earlier from need_preemptive_reclaim() if we have tickets
      btrfs: increment loop count outside critical section during metadata reclaim
      btrfs: shorten critical section in btrfs_preempt_reclaim_metadata_space()
      btrfs: avoid unnecessary reclaim calculation in priority_reclaim_metadata_space()
      btrfs: assert space_info is locked in steal_from_global_rsv()
      btrfs: assign booleans to global reserve's full field
      btrfs: process ticket outside global reserve critical section
      btrfs: remove double underscore prefix from __reserve_bytes()
      btrfs: reduce space_info critical section in btrfs_chunk_alloc()
      btrfs: reduce block group critical section in btrfs_free_reserved_bytes()
      btrfs: reduce block group critical section in btrfs_add_reserved_bytes()
      btrfs: reduce block group critical section in do_trimming()
      btrfs: reduce block group critical section in pin_down_extent()
      btrfs: use local variable for space_info in pin_down_extent()
      btrfs: remove 'reserved' argument from btrfs_pin_extent()
      btrfs: change 'reserved' argument from pin_down_extent() to bool
      btrfs: reduce block group critical section in unpin_extent_range()
      btrfs: remove pointless label and goto from unpin_extent_range()
      btrfs: add data_race() in btrfs_account_ro_block_groups_free_space()
      btrfs: move ticket wakeup and finalization to remove_ticket()
      btrfs: avoid space_info locking when checking if tickets are served
      btrfs: annotate as unlikely fs aborted checks in space flushing code
      btrfs: move struct reserve_ticket definition to space-info.c
      btrfs: fix leaf leak in an error path in btrfs_del_items()
      btrfs: remove pointless return value update in btrfs_del_items()
      btrfs: add unlikely to critical error in btrfs_extend_item()
      btrfs: always use left leaf variable in __push_leaf_right()
      btrfs: remove duplicated leaf dirty status clearing in __push_leaf_right()
      btrfs: always use right leaf variable in __push_leaf_left()
      btrfs: abort transaction on item count overflow in __push_leaf_left()
      btrfs: update check_skip variable after unlocking current node
      btrfs: use bool type for btrfs_path members used as booleans
      btrfs: use booleans for delalloc arguments and struct find_free_extent_ctl
      btrfs: place all boolean fields together in struct find_free_extent_ctl
      btrfs: use test_and_set_bit() in btrfs_delayed_delete_inode_ref()
      btrfs: remove root argument from btrfs_del_dir_entries_in_log()
      btrfs: reduce arguments to btrfs_del_inode_ref_in_log()
      btrfs: send: add unlikely to all unexpected overflow checks
      btrfs: send: do not allocate memory for xattr data when checking it exists
      btrfs: remove redundant zero/NULL initializations in btrfs_alloc_root()
      btrfs: remove unnecessary inode key in btrfs_log_all_parents()

Gladyshev Ilya (1):
      btrfs: don't generate any code from ASSERT() in release builds

Johannes Thumshirn (1):
      btrfs: zoned: show statistics for zoned filesystems

Josef Bacik (3):
      btrfs: add orig_logical to btrfs_bio for encryption
      btrfs: don't rewrite ret from inode_permission
      btrfs: don't search back for dir inode item in INO_LOOKUP_USER

Mehdi Ben Hadj Khelifa (1):
      btrfs: refactor allocation size calculation in alloc_btrfs_io_context()

Miquel Sabaté Solà (5):
      btrfs: fix double free of qgroup record after failure to add delayed ref head
      btrfs: declare free_ipath() via DEFINE_FREE()
      btrfs: define the AUTO_KFREE/AUTO_KVFREE helper macros
      btrfs: apply the AUTO_K(V)FREE macros throughout the code
      btrfs: add ASSERTs on prealloc in qgroup functions

Omar Sandoval (1):
      btrfs: disable various operations on encrypted inodes

Qu Wenruo (38):
      btrfs: remove unnecessary NULL fs_info check from find_lock_delalloc_range()
      btrfs: introduce a new shutdown state
      btrfs: implement shutdown ioctl
      btrfs: implement remove_bdev and shutdown super operation callbacks
      btrfs: subpage: simplify the PAGECACHE_TAG_TOWRITE handling
      btrfs: scrub: add cancel/pause/removed bg checks for raid56 parity stripes
      btrfs: scrub: cancel the run if the process or fs is being frozen
      btrfs: scrub: cancel the run if there is a pending signal
      btrfs: replace BTRFS_MAX_BIO_SECTORS with BIO_MAX_VECS
      btrfs: headers cleanup to remove unnecessary local includes
      btrfs: remove btrfs_bio::fs_info by extracting it from btrfs_bio::inode
      btrfs: make sure all btrfs_bio::end_io are called in task context
      btrfs: remove btrfs_fs_info::compressed_write_workers
      btrfs: relax btrfs_inode::ordered_tree_lock IRQ locking context
      btrfs: introduce btrfs_bio::async_csum
      btrfs: use kvcalloc for btrfs_bio::csum allocation
      btrfs: make sure extent and csum paths are always released in scrub_raid56_parity_stripe()
      btrfs: scrub: factor out parity scrub code into a helper
      btrfs: raid56: remove sector_ptr::has_paddr member
      btrfs: raid56: move sector_ptr::uptodate into a dedicated bitmap
      btrfs: raid56: remove sector_ptr structure
      btrfs: make btrfs_csum_one_bio() handle bs > ps without large folios
      btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
      btrfs: make read verification handle bs > ps cases without large folios
      btrfs: enable encoded read/write/send for bs > ps cases
      btrfs: scrub: always update btrfs_scrub_progress::last_physical
      btrfs: raid56: add an overview for the btrfs_raid_bio structure
      btrfs: raid56: introduce a new parameter to locate a sector
      btrfs: raid56: prepare generate_pq_vertical() for bs > ps cases
      btrfs: raid56: prepare recover_vertical() to support bs > ps cases
      btrfs: raid56: prepare verify_one_sector() to support bs > ps cases
      btrfs: raid56: prepare verify_bio_data_sectors() to support bs > ps cases
      btrfs: raid56: prepare set_bio_pages_uptodate() to support bs > ps cases
      btrfs: raid56: prepare steal_rbio() to support bs > ps cases
      btrfs: raid56: prepare rbio_bio_add_io_paddr() to support bs > ps cases
      btrfs: raid56: prepare finish_parity_scrub() to support bs > ps cases
      btrfs: raid56: enable bs > ps support
      btrfs: raid56: remove the "_step" infix

Rajeev Tapadia (1):
      btrfs: fix comment in alloc_bitmap() and drop stale TODO

Sun YangKai (6):
      btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
      btrfs: tests: do trivial BTRFS_PATH_AUTO_FREE conversions
      btrfs: factor out root promotion logic into promote_child_to_root()
      btrfs: optimize balance_level() path reference handling
      btrfs: simplify leaf traversal after path release in btrfs_next_old_leaf()
      btrfs: remove redundant level reset in btrfs_del_items()

Sweet Tea Dorminy (1):
      btrfs: disable verity on encrypted inodes

Xuanqiang Luo (1):
      btrfs: remove redundant refcount check in btrfs_put_transaction()

Zhen Ni (1):
      btrfs: fix incomplete parameter rename in btrfs_decompress()

 fs/btrfs/accessors.h              |   1 +
 fs/btrfs/acl.c                    |  25 +-
 fs/btrfs/backref.c                |  37 +-
 fs/btrfs/backref.h                |   7 +-
 fs/btrfs/bio.c                    | 290 +++++++++----
 fs/btrfs/bio.h                    |  39 +-
 fs/btrfs/block-group.c            |  83 ++--
 fs/btrfs/block-group.h            |   2 +-
 fs/btrfs/block-rsv.c              |  14 +-
 fs/btrfs/btrfs_inode.h            |  20 +-
 fs/btrfs/compression.c            |  47 +--
 fs/btrfs/compression.h            |  15 +-
 fs/btrfs/ctree.c                  | 240 ++++++-----
 fs/btrfs/ctree.h                  |  18 +-
 fs/btrfs/defrag.c                 |   5 +-
 fs/btrfs/delalloc-space.c         |   4 +-
 fs/btrfs/delayed-inode.c          |  26 +-
 fs/btrfs/delayed-ref.c            |  45 +-
 fs/btrfs/dev-replace.c            |   4 +-
 fs/btrfs/dir-item.c               |   4 +-
 fs/btrfs/direct-io.c              |  10 +-
 fs/btrfs/disk-io.c                |  64 ++-
 fs/btrfs/disk-io.h                |   3 +-
 fs/btrfs/extent-tree.c            | 172 ++++----
 fs/btrfs/extent-tree.h            |  27 +-
 fs/btrfs/extent_io.c              |  57 ++-
 fs/btrfs/extent_io.h              |   1 -
 fs/btrfs/extent_map.h             |   3 +-
 fs/btrfs/file-item.c              |  89 ++--
 fs/btrfs/file-item.h              |   4 +-
 fs/btrfs/file.c                   |  32 +-
 fs/btrfs/free-space-cache.c       |  24 +-
 fs/btrfs/free-space-tree.c        |  55 +--
 fs/btrfs/fs.h                     |  36 +-
 fs/btrfs/inode-item.c             |   5 +-
 fs/btrfs/inode.c                  | 194 +++++----
 fs/btrfs/ioctl.c                  | 173 ++++----
 fs/btrfs/messages.c               |   1 +
 fs/btrfs/messages.h               |   3 +-
 fs/btrfs/misc.h                   |   7 +
 fs/btrfs/ordered-data.c           |  74 ++--
 fs/btrfs/print-tree.c             |  16 +-
 fs/btrfs/qgroup.c                 | 182 ++++----
 fs/btrfs/raid-stripe-tree.c       |  18 +-
 fs/btrfs/raid56.c                 | 859 ++++++++++++++++++++++----------------
 fs/btrfs/raid56.h                 | 103 ++++-
 fs/btrfs/reflink.c                |  15 +-
 fs/btrfs/relocation.c             |  85 ++--
 fs/btrfs/root-tree.c              |   4 +-
 fs/btrfs/scrub.c                  | 270 +++++++-----
 fs/btrfs/send.c                   | 113 +++--
 fs/btrfs/space-info.c             | 464 ++++++++++----------
 fs/btrfs/space-info.h             |  43 +-
 fs/btrfs/subpage.c                |  67 ++-
 fs/btrfs/subpage.h                |   1 -
 fs/btrfs/super.c                  |  77 +++-
 fs/btrfs/sysfs.c                  |  58 ++-
 fs/btrfs/sysfs.h                  |   3 +-
 fs/btrfs/tests/extent-io-tests.c  |   3 +-
 fs/btrfs/tests/extent-map-tests.c |   6 +-
 fs/btrfs/tests/qgroup-tests.c     |  16 +-
 fs/btrfs/transaction.c            |  48 ++-
 fs/btrfs/transaction.h            |   4 -
 fs/btrfs/tree-checker.c           |  23 +-
 fs/btrfs/tree-log.c               | 183 ++++----
 fs/btrfs/tree-log.h               |   8 +-
 fs/btrfs/uuid-tree.c              | 120 ++----
 fs/btrfs/verity.c                 |  32 +-
 fs/btrfs/volumes.c                | 199 ++++-----
 fs/btrfs/volumes.h                |  10 +-
 fs/btrfs/xattr.c                  |  41 +-
 fs/btrfs/zoned.c                  |  53 ++-
 fs/btrfs/zoned.h                  |   7 +-
 include/uapi/linux/btrfs.h        |   9 +
 74 files changed, 2788 insertions(+), 2312 deletions(-)

