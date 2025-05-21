Return-Path: <linux-btrfs+bounces-14173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A221ABF4CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E517B1D56
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C057272E45;
	Wed, 21 May 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nr82jxWc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nr82jxWc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDC2701D3
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831887; cv=none; b=GhSmf9B6cNd0eL1T8qhUs8G71MemJYpW3mf0hjPo64kRihnhwXL6botQAFmh0ixdaBbwCAmBdh/AVNnfX0PzsGNGgJf1fXPBBNhmgHgFLhdPOZNa1Zzb8N4itWuBrH89Qegiz7ZgpCFk+AwQCg5oXRUMhmUOnmP025V3CL+lU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831887; c=relaxed/simple;
	bh=dWR+tcPoEG8n2BnyHoFZ6lmBKYAFYE2zAL1AjR9XkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqTvhl9VuxIhAbuiT2DVJRwvk+kxB+8vsmdZqnyY+plrhuwEbz1rQu89Qhp28rgk6fxp6yiwbZ722Y/aLG7g2fkBbVLXPZ3sveqEJ+ABM5u4oPMrh/bAkjh5tm8yLFqtcXKcCLFwiiM8F4KKy6yfFfgiddFmAgep3R6Ty3zpEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nr82jxWc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nr82jxWc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9603520ACE;
	Wed, 21 May 2025 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747831881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8J42c1LkVdPPnPlurxrNDQClL1rnKlkqniHECxRXW58=;
	b=nr82jxWcYPM38DsZ5rS4GNB1zcvSbUhfmv2Ulz8Q90P9xknxU3JgU1JlPSjLzPJymlZUXi
	2VWGw+WNuH+3cVFu4i89JZbysQUx6UWJrHge+1ol9lt1tTsKD4tX63KaWGPRiZn702IUgv
	ez6HlyVx9wGMWoM73mHFBUGpQ0o1+EE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nr82jxWc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747831881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8J42c1LkVdPPnPlurxrNDQClL1rnKlkqniHECxRXW58=;
	b=nr82jxWcYPM38DsZ5rS4GNB1zcvSbUhfmv2Ulz8Q90P9xknxU3JgU1JlPSjLzPJymlZUXi
	2VWGw+WNuH+3cVFu4i89JZbysQUx6UWJrHge+1ol9lt1tTsKD4tX63KaWGPRiZn702IUgv
	ez6HlyVx9wGMWoM73mHFBUGpQ0o1+EE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F6A513AA0;
	Wed, 21 May 2025 12:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6G7/IknMLWg9eQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 21 May 2025 12:51:21 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.16
Date: Wed, 21 May 2025 14:51:16 +0200
Message-ID: <cover.1747826882.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9603520ACE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

Hi,

please pull the following updates for btrfs. Apart from numerous
cleanups, there are some performance improvements and one minor mount
option update. There's one more radix-tree conversion (one remaining),
and continued work towards enabling large folios (almost finished).

Thanks.

Performance:

- extent buffer conversion to xarray gains throughput and runtime
  improvements on metadata heavy operations doing writeback (sample test
  shows +50% throughput, -33% runtime)

- extent io tree cleanups lead to performance improvements by avoiding
  unnecessary searches or repeated searches

- more efficient extent unpinning when committing transaction (estimated
  run time improvement 3-5%)

User visible changes:

- remove standalone mount option 'nologreplay', deprecated in 5.9,
  replacement is 'rescue=nologreplay'

- in scrub, update reporting, add back device stats message after
  detected errors (accidentally removed during recent refactoring)

Core:

- convert extent buffer radix tree to xarray

- in subpage mode, move block perfect compression out of experimental
  build

- in zoned mode, introduce sub block groups to allow managing special
  block groups, like the one for relocation or tree-log, to handle some
  corner cases of ENOSPC

- in scrub, simplify bitmaps for block tracking status

- continued preparations for large folios
  - remove assertions for folio order 0
  - add support where missing: compression, buffered write, defrag, hole
    punching, subpage, send

- fix fsync of files with no hard links not persisting deletion

- reject tree blocks which are not nodesize aligned, a precaution from
  4.9 times

- move transaction abort calls closer to the error sites

- remove usage of some struct bio_vec internals

- simplifications in extent map

- extent IO cleanups and optimizations

- error handling improvements

- enhanced ASSERT() macro with optional format strings

- cleanups
  - remove unused code
  - naming unifications, dropped __, added prefix
  - merge similar functions
  - use common helpers for various data structures

----------------------------------------------------------------
The following changes since commit 088d13246a4672bc03aec664675138e3f5bff68c:

  Merge tag 'kbuild-fixes-v6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild ()

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-tag

for you to fetch changes up to eeb133a6341280a1315c12b5b24a42e1fbf35487:

  btrfs: move misplaced comment of btrfs_path::keep_locks (2025-05-17 21:15:08 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix broken drop_caches on extent buffer folios

Charles Han (1):
      btrfs: update and correct description of btrfs_get_or_create_delayed_node()

Christoph Hellwig (7):
      btrfs: remove the alignment checks in end_bbio_data_read()
      btrfs: track the next file offset in struct btrfs_bio_ctrl
      btrfs: pass a physical address to btrfs_repair_io_failure()
      btrfs: move kmapping out of btrfs_check_sector_csum()
      btrfs: simplify bvec iteration in index_one_bio()
      btrfs: scrub: use virtual addresses directly
      btrfs: use bvec_kmap_local() in btrfs_decompress_buf2page()

Daniel Vacek (6):
      btrfs: remove unused flag EXTENT_BUFFER_READ_ERR
      btrfs: remove unused flag EXTENT_BUFFER_READAHEAD
      btrfs: remove unused flag EXTENT_BUFFER_CORRUPT
      btrfs: remove unused flag EXTENT_BUFFER_IN_TREE
      btrfs: move folio initialization to one place in attach_eb_folio_to_filemap()
      btrfs: get rid of goto in alloc_test_extent_buffer()

David Sterba (43):
      btrfs: use rb_entry_safe() where possible to simplify code
      btrfs: do more trivial BTRFS_PATH_AUTO_FREE conversions
      btrfs: use BTRFS_PATH_AUTO_FREE in may_destroy_subvol()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_set_inode_index_count()
      btrfs: use BTRFS_PATH_AUTO_FREE in can_nocow_extent()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_encoded_read_inline()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_inode_extref()
      btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_inode_extref()
      btrfs: tree-checker: more unlikely annotations
      btrfs: rename iov_iter iterator parameter in btrfs_buffered_write()
      btrfs: enhance ASSERT() to take optional format string
      btrfs: use verbose ASSERT() in volumes.c
      btrfs: add debug build only WARN
      btrfs: convert WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN
      btrfs: convert ASSERT(0) with handled errors to DEBUG_WARN()
      btrfs: use list_first_entry() everywhere
      btrfs: remove unused btrfs_io_stripe::length
      btrfs: use unsigned types for constants defined as bit shifts
      btrfs: merge __setup_root() to btrfs_alloc_root()
      btrfs: drop redundant local variable in raid_wait_write_end_io()
      btrfs: change return type of btrfs_lookup_bio_sums() to int
      btrfs: change return type of btrfs_csum_one_bio() to int
      btrfs: change return type of btree_csum_one_bio() to int
      btrfs: change return type of btrfs_bio_csum() to int
      btrfs: rename ret to status in btrfs_submit_chunk()
      btrfs: rename error to ret in btrfs_submit_chunk()
      btrfs: simplify reading bio status in end_compressed_writeback()
      btrfs: rename ret to status in btrfs_submit_compressed_read()
      btrfs: rename ret2 to ret in btrfs_submit_compressed_read()
      btrfs: change return type of btrfs_alloc_dummy_sum() to int
      btrfs: raid56: rename parameter err to status in endio helpers
      btrfs: trivial conversion to return bool instead of int
      btrfs: switch int dev_replace_is_ongoing variables/parameters to bool
      btrfs: reformat comments in acls_after_inode_item()
      btrfs: on unknown chunk allocation policy fallback to regular
      btrfs: rename btrfs_discard workqueue to btrfs-discard
      btrfs: move transaction aborts to the error site in convert_free_space_to_bitmaps()
      btrfs: move transaction aborts to the error site in convert_free_space_to_extents()
      btrfs: move transaction aborts to the error site in remove_from_free_space_tree()
      btrfs: move transaction aborts to the error site in add_to_free_space_tree()
      btrfs: send: remove btrfs_debug() calls
      btrfs: update list of features built under experimental config
      btrfs: update Kconfig option descriptions

Filipe Manana (87):
      btrfs: fix fsync of files with no hard links not persisting deletion
      btrfs: remove leftover EXTENT_UPTODATE clear from an inode's io_tree
      btrfs: stop searching for EXTENT_DIRTY bit in the excluded extents io tree
      btrfs: remove EXTENT_UPTODATE io tree flag
      btrfs: update comment for try_release_extent_state()
      btrfs: allow folios to be released while ordered extent is finishing
      btrfs: pass a pointer to get_range_bits() to cache first search result
      btrfs: use clear_extent_bit() at try_release_extent_state()
      btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
      btrfs: use clear_extent_bits() instead of clear_extent_bit() where possible
      btrfs: simplify last record detection at test_range_bit_exists()
      btrfs: fix documentation for tree_search_for_insert()
      btrfs: remove redundant check at find_first_extent_bit_state()
      btrfs: simplify last record detection at test_range_bit()
      btrfs: remove redundant record start offset check at test_range_bit()
      btrfs: tracepoints: use btrfs_root_id() to get the id of a root
      btrfs: remove extent_io_tree_to_inode() and is_inode_io_tree()
      btrfs: add btrfs prefix to trace events for extent state alloc and free
      btrfs: add btrfs prefix to main lock, try lock and unlock extent functions
      btrfs: add btrfs prefix to dio lock and unlock extent functions
      btrfs: rename __lock_extent() and __try_lock_extent()
      btrfs: rename the functions to clear bits for an extent range
      btrfs: rename set_extent_bit() to include a btrfs prefix
      btrfs: rename the functions to search for bits in extent ranges
      btrfs: rename the functions to get inode and fs_info from an extent io tree
      btrfs: directly grab inode at __btrfs_debug_check_extent_io_range()
      btrfs: rename the functions to init and release an extent io tree
      btrfs: rename the functions to count, test and get bit ranges in io trees
      btrfs: rename free_extent_state() to include a btrfs prefix
      btrfs: rename remaining exported functions from extent-io-tree.h
      btrfs: remove double underscore prefix from __set_extent_bit()
      btrfs: make btrfs_find_contiguous_extent_bit() return bool instead of int
      btrfs: tracepoints: add btrfs prefix to names where it's missing
      btrfs: tracepoints: remove no longer used tracepoints for eb locking
      btrfs: rename exported extent map compression functions
      btrfs: rename extent map functions to get block start, end and check if in tree
      btrfs: rename functions to allocate and free extent maps
      btrfs: rename remaining exported extent map functions
      btrfs: rename __lookup_extent_mapping() to remove double underscore prefix
      btrfs: rename __tree_search() to remove double underscore prefix
      btrfs: remove duplicate error check at btrfs_clear_extent_bit_changeset()
      btrfs: exit after state split error at btrfs_clear_extent_bit_changeset()
      btrfs: add missing error return to btrfs_clear_extent_bit_changeset()
      btrfs: use bools for local variables at btrfs_clear_extent_bit_changeset()
      btrfs: avoid extra tree search at btrfs_clear_extent_bit_changeset()
      btrfs: simplify last record detection at btrfs_clear_extent_bit_changeset()
      btrfs: remove duplicate error check at btrfs_convert_extent_bit()
      btrfs: exit after state split error at btrfs_convert_extent_bit()
      btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
      btrfs: avoid unnecessary next node searches when clearing bits from extent range
      btrfs: avoid repeated extent state processing when converting extent bits
      btrfs: avoid re-searching tree when converting bits in an extent range
      btrfs: simplify last record detection at btrfs_convert_extent_bit()
      btrfs: exit after state insertion failure at set_extent_bit()
      btrfs: exit after state split error at set_extent_bit()
      btrfs: simplify last record detection at set_extent_bit()
      btrfs: avoid repeated extent state processing when setting extent bits
      btrfs: avoid re-searching tree when setting bits in an extent range
      btrfs: remove unnecessary NULL checks before freeing extent state
      btrfs: don't BUG_ON() when unpinning extents during transaction commit
      btrfs: remove variable to track trimmed bytes at btrfs_finish_extent_commit()
      btrfs: make extent unpinning more efficient when committing transaction
      btrfs: simplify getting and extracting previous transaction during commit
      btrfs: simplify getting and extracting previous transaction at clean_pinned_extents()
      btrfs: simplify cow only root list extraction during transaction commit
      btrfs: raid56: use list_last_entry() at cache_rbio()
      btrfs: simplify extracting delayed node at btrfs_first_delayed_node()
      btrfs: simplify extracting delayed node at btrfs_first_prepared_delayed_node()
      btrfs: simplify csum list release at btrfs_put_ordered_extent()
      btrfs: defrag: use list_last_entry() at defrag_collect_targets()
      btrfs: use verbose assert at peek_discard_list()
      btrfs: fix qgroup reservation leak on failure to allocate ordered extent
      btrfs: check we grabbed inode reference when allocating an ordered extent
      btrfs: fold error checks when allocating ordered extent and update comments
      btrfs: use boolean for delalloc argument to btrfs_free_reserved_bytes()
      btrfs: use boolean for delalloc argument to btrfs_free_reserved_extent()
      btrfs: fix invalid data space release when truncating block in NOCOW mode
      btrfs: remove superfluous return value check at btrfs_dio_iomap_begin()
      btrfs: return real error from __filemap_get_folio() calls
      btrfs: simplify error return logic when getting folio at prepare_one_folio()
      btrfs: log error codes during failures when writing super blocks
      btrfs: fix harmless race getting delayed ref head count when running delayed refs
      btrfs: fix wrong start offset for delalloc space release during mmap write
      btrfs: pass true to btrfs_delalloc_release_space() at btrfs_page_mkwrite()
      btrfs: simplify early error checking in btrfs_page_mkwrite()
      btrfs: don't return VM_FAULT_SIGBUS on failure to set delalloc for mmap write
      btrfs: use a single variable to track return value at btrfs_page_mkwrite()

Josef Bacik (3):
      btrfs: convert the buffer_radix to an xarray
      btrfs: set DIRTY and WRITEBACK tags on the buffer_tree
      btrfs: use buffer xarray for extent buffer writeback operations

Mark Harmstone (1):
      btrfs: fix typo in space info explanation

Naohiro Aota (13):
      btrfs: pass btrfs_space_info to btrfs_reserve_data_bytes()
      btrfs: pass struct btrfs_inode to btrfs_free_reserved_data_space_noquota()
      btrfs: factor out init_space_info() from create_space_info()
      btrfs: factor out do_async_reclaim_{data,metadata}_space()
      btrfs: factor out check_removing_space_info() from btrfs_free_block_groups()
      btrfs: add space_info argument to btrfs_chunk_alloc()
      btrfs: add space_info parameter for block group creation
      btrfs: introduce btrfs_space_info sub-group
      btrfs: introduce tree-log sub-space_info
      btrfs: tweak extent/chunk allocation for space_info sub-space
      btrfs: use proper data space_info for zoned mode
      btrfs: add block reserve for treelog
      btrfs: add support for reclaiming from sub-space space_info

Qu Wenruo (32):
      btrfs: move block perfect compression out of experimental features
      btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
      btrfs: cleanup the reserved space inside loop of btrfs_buffered_write()
      btrfs: factor out space reservation code from btrfs_buffered_write()
      btrfs: factor out the main loop of btrfs_buffered_write() into a helper
      btrfs: refactor how we handle reserved space inside copy_one_range()
      btrfs: prepare btrfs_buffered_write() for large data folios
      btrfs: prepare btrfs_punch_hole_lock_range() for large data folios
      btrfs: fix the file offset calculation inside btrfs_decompress_buf2page()
      btrfs: send: remove the again label inside put_file_data()
      btrfs: send: prepare put_file_data() for large data folios
      btrfs: prepare btrfs_page_mkwrite() for large data folios
      btrfs: prepare prepare_one_folio() for large data folios
      btrfs: prepare end_bbio_data_write() for large data folios
      btrfs: subpage: prepare for large data folios
      btrfs: zlib: prepare copy_data_into_buffer() for large data folios
      btrfs: remove unnecessary early exits in delalloc folio lock and unlock
      btrfs: use folio_contains() for EOF detection
      btrfs: prepare compression paths for large data folios
      btrfs: enable large data folios support for defrag
      btrfs: raid56: store a physical address in structure sector_ptr
      btrfs: subpage: reject tree blocks which are not nodesize aligned
      btrfs: merge btrfs_read_dev_one_super() into btrfs_read_disk_super()
      btrfs: get rid of btrfs_read_dev_super()
      btrfs: scrub: update device stats when an error is detected
      btrfs: scrub: move error reporting members to stack
      btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
      btrfs: scrub: aggregate small bitmaps into a larger one
      btrfs: handle unaligned EOF truncation correctly for subpage cases
      btrfs: handle aligned EOF truncation correctly for subpage cases
      btrfs: scrub: reduce memory usage of struct scrub_sector_verification
      btrfs: remove standalone "nologreplay" mount option

Sun YangKai (1):
      btrfs: move misplaced comment of btrfs_path::keep_locks

Yangtao Li (3):
      btrfs: reuse exit helper for cleanup in btrfs_bioset_init()
      btrfs: simplify return logic from btrfs_delayed_ref_init()
      btrfs: remove BTRFS_REF_LAST from enum btrfs_ref_type

 fs/btrfs/Kconfig                  |  32 +-
 fs/btrfs/async-thread.c           |   3 +-
 fs/btrfs/backref.c                |  12 +-
 fs/btrfs/backref.h                |   4 +-
 fs/btrfs/bio.c                    |  55 ++-
 fs/btrfs/bio.h                    |   3 +-
 fs/btrfs/block-group.c            | 196 ++++----
 fs/btrfs/block-group.h            |  11 +-
 fs/btrfs/block-rsv.c              |  11 +
 fs/btrfs/block-rsv.h              |   1 +
 fs/btrfs/btrfs_inode.h            |   7 +-
 fs/btrfs/compression.c            |  75 +--
 fs/btrfs/compression.h            |  11 +-
 fs/btrfs/ctree.h                  |   2 +-
 fs/btrfs/defrag.c                 | 141 +++---
 fs/btrfs/delalloc-space.c         |  51 +-
 fs/btrfs/delalloc-space.h         |   4 +-
 fs/btrfs/delayed-inode.c          |  73 ++-
 fs/btrfs/delayed-ref.c            |   9 +-
 fs/btrfs/delayed-ref.h            |   1 -
 fs/btrfs/dev-replace.c            |  22 +-
 fs/btrfs/dev-replace.h            |   2 +-
 fs/btrfs/direct-io.c              |  75 ++-
 fs/btrfs/discard.c                |   4 +-
 fs/btrfs/disk-io.c                | 199 +++-----
 fs/btrfs/disk-io.h                |   5 +-
 fs/btrfs/extent-io-tree.c         | 510 +++++++++++---------
 fs/btrfs/extent-io-tree.h         | 187 ++++----
 fs/btrfs/extent-tree.c            | 162 ++++---
 fs/btrfs/extent-tree.h            |   4 +-
 fs/btrfs/extent_io.c              | 960 ++++++++++++++++++--------------------
 fs/btrfs/extent_io.h              |   9 +-
 fs/btrfs/extent_map.c             | 175 ++++---
 fs/btrfs/extent_map.h             |  45 +-
 fs/btrfs/fiemap.c                 |   9 +-
 fs/btrfs/file-item.c              |  49 +-
 fs/btrfs/file-item.h              |   6 +-
 fs/btrfs/file.c                   | 782 +++++++++++++++++--------------
 fs/btrfs/free-space-cache.c       |  52 +--
 fs/btrfs/free-space-tree.c        |  62 ++-
 fs/btrfs/fs.h                     |   6 +-
 fs/btrfs/inode-item.c             |  31 +-
 fs/btrfs/inode.c                  | 680 +++++++++++++++------------
 fs/btrfs/ioctl.c                  |  18 +-
 fs/btrfs/locking.c                |   8 +-
 fs/btrfs/locking.h                |   2 +-
 fs/btrfs/lzo.c                    |   5 +-
 fs/btrfs/messages.h               |  83 +++-
 fs/btrfs/ordered-data.c           |  73 +--
 fs/btrfs/qgroup.c                 |  55 +--
 fs/btrfs/raid56.c                 | 219 ++++-----
 fs/btrfs/reflink.c                |  15 +-
 fs/btrfs/relocation.c             | 112 +++--
 fs/btrfs/scrub.c                  | 458 +++++++++++-------
 fs/btrfs/send.c                   |  88 +---
 fs/btrfs/space-info.c             | 174 ++++---
 fs/btrfs/space-info.h             |  12 +-
 fs/btrfs/subpage.c                |   6 +-
 fs/btrfs/super.c                  |  24 +-
 fs/btrfs/sysfs.c                  |  27 +-
 fs/btrfs/tests/btrfs-tests.c      |  32 +-
 fs/btrfs/tests/extent-io-tests.c  |  61 ++-
 fs/btrfs/tests/extent-map-tests.c | 102 ++--
 fs/btrfs/tests/inode-tests.c      | 107 +++--
 fs/btrfs/transaction.c            |  74 +--
 fs/btrfs/tree-checker.c           |  22 +-
 fs/btrfs/tree-log.c               |  66 +--
 fs/btrfs/volumes.c                | 345 +++++++-------
 fs/btrfs/volumes.h                |  11 +-
 fs/btrfs/zlib.c                   |   9 +-
 fs/btrfs/zoned.c                  |  28 +-
 fs/btrfs/zstd.c                   |  10 +-
 include/trace/events/btrfs.h      |  89 ++--
 73 files changed, 3791 insertions(+), 3282 deletions(-)

