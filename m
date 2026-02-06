Return-Path: <linux-btrfs+bounces-21407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAu5DrQmhmlSKAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21407-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 18:36:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C7E1012BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D85301A38F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D523D902B;
	Fri,  6 Feb 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mPYVe4hW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EynYC4sz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41753A0E8F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399138; cv=none; b=XdyAS2o8GHhbhLRVXWcRGIp6AmgZ43nBPRMf4Sh7C1nGEvgjeM3i7mMWvSI7CXffQwmYfxyn9K7lXRvsnULEhz93zzZsHErtfSVbK+UFMAz9M6FEJJM6pkykkcvpMX3+koYTUfn+XY0mTxQX+o3s2MYJunp+LqXz+OHai/xo/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399138; c=relaxed/simple;
	bh=afphzd+8+EiIXozIeE0K34htjABB0IdWA2ApgntdOnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zmfk6CS2NhY6mJPayKeVGLExlqspXHR/A56x54n8g8MPaF0muA/+amSC8ia3+5EpYdM7ni7dHshLB0hKn58c2CWzUODNtbsf8x7FItEuDjg3pXzrRNkPypuwpbw+3xh74KSMJGYa50lWmI/Z1lrVvOqo0sqKLXzBjVhduL4VMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mPYVe4hW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EynYC4sz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9A6B5BCC2;
	Fri,  6 Feb 2026 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770399136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pCCVdtN2ArhpPQCjhlCM5NuI7bXoSzu9DGaiE1KDgSI=;
	b=mPYVe4hW55TbkBsgQdfkURMS4ohRTnmD4i3PjVfBKo6nxNxPcHytRz9m3UHLaH5V/Ln64E
	BezWZkC4RV7BgqCDQoAu0xQOn3Y7Lpg3y4Cn8c9hlEIoKHsa7jzTDUp9qkDlaOE3rRITim
	4Y/drjI6anOLz5IgJDFEOtPxXsD4Bnk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770399135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pCCVdtN2ArhpPQCjhlCM5NuI7bXoSzu9DGaiE1KDgSI=;
	b=EynYC4szpiT3CBT2SXiD9ESheYk3ODErrkvY7fByUMgbuel4YnhIFZRAZBvaM9at0c2RSs
	ZKpE1Jm2jSjfUXMFKURMuzupovLRj4v5VBGSSZLNjFxTYn+XT8n8SdWPodHnx3KMc9QWn+
	aIW/irQRc1q3xsbx5fc9FkZx/nbIJc8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D8F3EA63;
	Fri,  6 Feb 2026 17:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQOHMJ8lhmkeTgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 06 Feb 2026 17:32:15 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.20/7.0
Date: Fri,  6 Feb 2026 18:32:12 +0100
Message-ID: <cover.1770394394.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21407-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86C7E1012BB
X-Rspamd-Action: no action

Hi,

please pull the following btrfs updates. Thanks.

User visible changes, feature updates:

- when using block size > page size, enable direct IO

- fallback to buffered IO if the data profile has duplication,
  workaround to avoid checksum mismatches on block group profiles with
  redundancy, real direct IO is possible on single or RAID0

- redo export of zoned statistics, moved from sysfs to /proc/pid/mountstats
  due to size limitations of the former

Experimental features:

- remove offload checksum tunable, intended to find best way to do it
  but since we've switched to offload to thread for everything we don't
  need it anymore

- initial support for remap-tree feature, a translation layer of logical
  block addresses that allow changes without moving/rewriting blocks to
  do eg. relocation, or other changes that require COW

Notable fixes:

- automatic removal of accidentally leftover chunks when free-space-tree
  is enabled since mkfs.btrfs v6.16.1

- zoned mode

  - do not try to append to conventional zones when RAID is mixing zoned
    and conventional drives

  - fixup write pointers when mixing zoned and conventional on DUP/RAID*
    profiles

- when using squota, relax deletion rules for qgroups with 0 members to
  allow easier recovery from accounting bugs, also add more checks to
  detect bad accounting

- fix periodic reclaim scanning, properly check boundary conditions not
  to trigger it unexpectedly or miss the time to run it

- trim

  - continue after first error

  - change reporting to the first detected error

  - add more cancellation points

  - reduce contention of big device lock that can block other operations
    when there's lots of trimmed space

- when chunk allocation is forced (needs experimental build) fix
  transaction abort when unexpected space layout is detected

Core:

- switch to crypto library API for checksumming, removed module
  dependencies, pointer indirections, etc.

- error handling improvements

- adjust how and where transaction commit or abort are done and are
  maybe not necessary

- minor compression optimization to skip single block ranges

- improve how compression folios are handled

- new and updated selftests

- cleanups, refactoring

  - auto-freeing and other automatic variable cleanup conversion

  - structure size optimizations

  - condition annotations

----------------------------------------------------------------
The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.20-tag

for you to fetch changes up to 161ab30da6899f31f8128cec7c833e99fa4d06d2:

  btrfs: get rid of compressed_bio::compressed_folios[] (2026-02-03 07:59:07 +0100)

----------------------------------------------------------------
Boris Burkov (5):
      btrfs: check squota parent usage on membership change
      btrfs: relax squota parent qgroup deletion rule
      btrfs: fix block_group_tree dirty_list corruption
      btrfs: fix EEXIST abort due to non-consecutive gaps in chunk allocation
      btrfs: tests: add unit tests for pending extent walking functions

David Sterba (9):
      btrfs: merge setting ret and return ret
      btrfs: simplify internal btrfs_printk helpers
      btrfs: pass level to _btrfs_printk() to avoid parsing level from string
      btrfs: remove ASSERT compatibility for gcc < 8.x
      btrfs: split btrfs_fs_closing() and change return type to bool
      btrfs: embed delayed root to struct btrfs_fs_info
      btrfs: reorder members in btrfs_delayed_root for better packing
      btrfs: don't use local variables for fs_info->delayed_root
      btrfs: pass btrfs_fs_info to btrfs_first_delayed_node()

Eric Biggers (1):
      btrfs: switch to library APIs for checksums

Filipe Manana (48):
      btrfs: remove duplicated root key setup in btrfs_create_tree()
      btrfs: update stale comment in __cow_file_range_inline()
      btrfs: avoid transaction commit on error in del_balance_item()
      btrfs: use single return variable in btrfs_find_orphan_roots()
      btrfs: remove redundant path release in btrfs_find_orphan_roots()
      btrfs: don't call btrfs_handle_fs_error() after failure to join transaction
      btrfs: don't call btrfs_handle_fs_error() after failure to delete orphan item
      btrfs: don't call btrfs_handle_fs_error() in qgroup_account_snapshot()
      btrfs: don't call btrfs_handle_fs_error() in btrfs_commit_transaction()
      btrfs: tag as unlikely error conditions in the transaction commit path
      btrfs: move unlikely checks around btrfs_is_shutdown() into the helper
      btrfs: avoid transaction commit on error in insert_balance_item()
      btrfs: update comment for delalloc flush and oe wait in btrfs_clone_files()
      btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
      btrfs: remove unnecessary else branch in run_one_delayed_ref()
      btrfs: tag as unlikely error handling in run_one_delayed_ref()
      btrfs: add and use helper to compute the available space for a block group
      btrfs: use the btrfs_block_group_end() helper everywhere
      btrfs: use the btrfs_extent_map_end() helper everywhere
      btrfs: make load_block_group_size_class() return void
      btrfs: allocate path on stack in load_block_group_size_class()
      btrfs: don't pass block group argument to load_block_group_size_class()
      btrfs: assert block group is locked in btrfs_use_block_group_size_class()
      btrfs: remove bogus root search condition in sample_block_group_extent_item()
      btrfs: deal with missing root in sample_block_group_extent_item()
      btrfs: unfold transaction aborts in btrfs_finish_one_ordered()
      btrfs: qgroup: return correct error when deleting qgroup relation item
      btrfs: remove pointless out labels from ioctl.c
      btrfs: remove pointless out labels from send.c
      btrfs: remove pointless out labels from qgroup.c
      btrfs: remove pointless out labels from disk-io.c
      btrfs: remove pointless out labels from extent-tree.c
      btrfs: remove pointless out labels from free-space-cache.c
      btrfs: remove pointless out labels from inode.c
      btrfs: remove pointless out labels from uuid-tree.c
      btrfs: remove out label in load_extent_tree_free()
      btrfs: remove out_failed label in find_lock_delalloc_range()
      btrfs: remove out label in btrfs_csum_file_blocks()
      btrfs: remove out label in btrfs_mark_extent_written()
      btrfs: remove out label in lzo_decompress()
      btrfs: remove out label in scrub_find_fill_first_stripe()
      btrfs: remove out label in finish_verity()
      btrfs: remove out label in btrfs_check_rw_degradable()
      btrfs: remove out label in btrfs_init_space_info()
      btrfs: remove out label in btrfs_wait_for_commit()
      btrfs: abort transaction on error in btrfs_remove_block_group()
      btrfs: do not BUG_ON() in btrfs_remove_block_group()
      btrfs: raid56: fix memory leak of btrfs_raid_bio::stripe_uptodate_bitmap

Johannes Thumshirn (10):
      btrfs: zoned: don't zone append to conventional zone
      btrfs: rename btrfs_create_block_group_cache to btrfs_create_block_group
      btrfs: zoned: re-flow prepare_allocation_zoned()
      btrfs: zoned: show statistics about zoned filesystems in mountstats
      btrfs: move space_info_flag_to_str() to space-info.h
      btrfs: zoned: print block-group type for zoned statistics
      btrfs: remove bogus NULL checks in __btrfs_write_out_cache()
      btrfs: don't pass io_ctl to __btrfs_write_out_cache()
      btrfs: zoned: use local fs_info variable in btrfs_load_block_group_dup()
      btrfs: fix copying the flags of btrfs_bio after split

Julia Lawall (1):
      btrfs: update outdated comment in __add_block_group_free_space()

Mark Harmstone (17):
      btrfs: add definitions and constants for remap-tree
      btrfs: add METADATA_REMAP chunk type
      btrfs: allow remapped chunks to have zero stripes
      btrfs: remove remapped block groups from the free-space-tree
      btrfs: don't add metadata items for the remap tree to the extent tree
      btrfs: rename struct btrfs_block_group field commit_used to last_used
      btrfs: add extended version of struct block_group_item
      btrfs: allow mounting filesystems with remap-tree incompat flag
      btrfs: redirect I/O for remapped block groups
      btrfs: handle deletions from remapped block group
      btrfs: handle setting up relocation of block group with remap-tree
      btrfs: move existing remaps before relocating block group
      btrfs: replace identity remaps with actual remaps when doing relocations
      btrfs: add do_remap parameter to btrfs_discard_extent()
      btrfs: allow balancing remap tree
      btrfs: handle discarding fully-remapped block groups
      btrfs: populate fully_remapped_bgs_list on mount

Massimiliano Pellizzer (1):
      btrfs: remove dead assignment in prepare_one_folio()

Naohiro Aota (6):
      btrfs: zoned: fixup last alloc pointer after extent removal for RAID1
      btrfs: zoned: fixup last alloc pointer after extent removal for DUP
      btrfs: zoned: fixup last alloc pointer after extent removal for RAID0/10
      btrfs: tests: add cleanup functions for test specific functions
      btrfs: add cleanup function for btrfs_free_chunk_map
      btrfs: zoned: factor out the zone loading part into a testable function

Qu Wenruo (27):
      btrfs: enable direct IO for bs > ps cases
      btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
      btrfs: search for larger extent maps inside btrfs_do_readpage()
      btrfs: concentrate the error handling of submit_one_sector()
      btrfs: replace for_each_set_bit() with for_each_set_bitmap()
      btrfs: shrink the size of btrfs_bio
      btrfs: refactor the main loop of cow_file_range()
      btrfs: add mount time auto fix for orphan fst entries
      btrfs: reject single block sized compression early
      btrfs: remove experimental offload csum mode
      btrfs: shrink the size of btrfs_device
      btrfs: lzo: use folio_iter to handle lzo_decompress_bio()
      btrfs: zlib: use folio_iter to handle zlib_decompress_bio()
      btrfs: zstd: use folio_iter to handle zstd_decompress_bio()
      btrfs: fallback to buffered IO if the data profile has duplication
      btrfs: tests: remove invalid file extent map tests
      btrfs: tests: prepare extent map tests for strict alignment checks
      btrfs: add strict extent map alignment checks
      btrfs: lzo: introduce lzo_compress_bio() helper
      btrfs: zstd: introduce zstd_compress_bio() helper
      btrfs: zlib: introduce zlib_compress_bio() helper
      btrfs: introduce btrfs_compress_bio() helper
      btrfs: switch to btrfs_compress_bio() interface for compressed writes
      btrfs: remove the old btrfs_compress_folios() infrastructure
      btrfs: get rid of compressed_folios[] usage for compressed read
      btrfs: get rid of compressed_folios[] usage for encoded writes
      btrfs: get rid of compressed_bio::compressed_folios[]

Sun YangKai (5):
      btrfs: update comment for visit_node_for_delete()
      btrfs: use true/false for boolean parameters in btrfs_inc_ref()/btrfs_dec_ref()
      btrfs: simplify boolean argument for btrfs_inc_ref()/btrfs_dec_ref()
      btrfs: fix periodic reclaim condition
      btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()

Zhen Ni (2):
      btrfs: remove unreachable return after btrfs_backref_panic() in btrfs_backref_finish_upper_links()
      btrfs: simplify check for zoned NODATASUM writes in btrfs_submit_chunk()

jinbaohong (5):
      btrfs: use READA_FORWARD_ALWAYS for device extent verification
      btrfs: continue trimming remaining devices on failure
      btrfs: preserve first error in btrfs_trim_fs()
      btrfs: handle user interrupt properly in btrfs_trim_fs()
      btrfs: fix transaction commit blocking during trim of unallocated space

 fs/btrfs/Kconfig                        |   13 +-
 fs/btrfs/Makefile                       |    3 +-
 fs/btrfs/accessors.h                    |   30 +
 fs/btrfs/backref.c                      |    4 +-
 fs/btrfs/bio.c                          |   35 +-
 fs/btrfs/bio.h                          |   19 +-
 fs/btrfs/block-group.c                  |  455 +++++---
 fs/btrfs/block-group.h                  |   31 +-
 fs/btrfs/block-rsv.c                    |    8 +
 fs/btrfs/block-rsv.h                    |    1 +
 fs/btrfs/compression.c                  |  217 ++--
 fs/btrfs/compression.h                  |   40 +-
 fs/btrfs/ctree.c                        |   49 +-
 fs/btrfs/ctree.h                        |    9 +
 fs/btrfs/defrag.c                       |   10 +-
 fs/btrfs/delayed-inode.c                |   53 +-
 fs/btrfs/delayed-inode.h                |   15 -
 fs/btrfs/direct-io.c                    |   29 +-
 fs/btrfs/discard.c                      |   52 +-
 fs/btrfs/disk-io.c                      |  284 +++--
 fs/btrfs/extent-io-tree.c               |    7 +-
 fs/btrfs/extent-tree.c                  |  457 ++++++--
 fs/btrfs/extent-tree.h                  |    4 +-
 fs/btrfs/extent_io.c                    |   77 +-
 fs/btrfs/extent_map.c                   |   12 +
 fs/btrfs/file-item.c                    |   20 +-
 fs/btrfs/file.c                         |   60 +-
 fs/btrfs/free-space-cache.c             |  108 +-
 fs/btrfs/free-space-cache.h             |    1 +
 fs/btrfs/free-space-tree.c              |  150 ++-
 fs/btrfs/free-space-tree.h              |    6 +-
 fs/btrfs/fs.c                           |  102 +-
 fs/btrfs/fs.h                           |   79 +-
 fs/btrfs/inode-item.c                   |    7 +-
 fs/btrfs/inode.c                        |  599 ++++++-----
 fs/btrfs/ioctl.c                        |   46 +-
 fs/btrfs/locking.c                      |    1 +
 fs/btrfs/lzo.c                          |  295 ++++--
 fs/btrfs/messages.c                     |   26 +-
 fs/btrfs/messages.h                     |   76 +-
 fs/btrfs/qgroup.c                       |  125 ++-
 fs/btrfs/raid56.c                       |    1 +
 fs/btrfs/reflink.c                      |   11 +-
 fs/btrfs/relocation.c                   | 1765 ++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h                   |   17 +
 fs/btrfs/root-tree.c                    |   47 +-
 fs/btrfs/scrub.c                        |   56 +-
 fs/btrfs/send.c                         |   76 +-
 fs/btrfs/space-info.c                   |   73 +-
 fs/btrfs/space-info.h                   |   16 +
 fs/btrfs/super.c                        |   17 +-
 fs/btrfs/sysfs.c                        |   55 +-
 fs/btrfs/tests/btrfs-tests.c            |    3 +
 fs/btrfs/tests/btrfs-tests.h            |    7 +
 fs/btrfs/tests/chunk-allocation-tests.c |  476 +++++++++
 fs/btrfs/tests/extent-map-tests.c       |   16 +-
 fs/btrfs/tests/free-space-tree-tests.c  |    4 +-
 fs/btrfs/tests/inode-tests.c            |  126 +--
 fs/btrfs/transaction.c                  |   78 +-
 fs/btrfs/tree-checker.c                 |   84 +-
 fs/btrfs/tree-checker.h                 |    5 +
 fs/btrfs/tree-log.c                     |    2 +-
 fs/btrfs/uuid-tree.c                    |   16 +-
 fs/btrfs/verity.c                       |   13 +-
 fs/btrfs/volumes.c                      |  631 ++++++++---
 fs/btrfs/volumes.h                      |   57 +-
 fs/btrfs/zlib.c                         |   97 +-
 fs/btrfs/zoned.c                        |  398 +++++--
 fs/btrfs/zoned.h                        |   17 +
 fs/btrfs/zstd.c                         |  139 +--
 include/uapi/linux/btrfs.h              |    1 +
 include/uapi/linux/btrfs_tree.h         |   34 +-
 72 files changed, 5871 insertions(+), 2082 deletions(-)
 create mode 100644 fs/btrfs/tests/chunk-allocation-tests.c

