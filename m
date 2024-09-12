Return-Path: <linux-btrfs+bounces-7975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271C976E6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF581F22D4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2813E02E;
	Thu, 12 Sep 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mXeo3Xyl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mXeo3Xyl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DF43144;
	Thu, 12 Sep 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157294; cv=none; b=Yhkb8uxHLnxR1mJRxeqbwbTYjY4VEFLs9C8XVq84g6u3ggwKLswOjDnAkH3vOZJ51vP84lvKfgNfVerYqkm3GynRl0hqPm9UVNryV/iZ+wy+ZkN4EgQfmCGZLAcR+SbmK+q3Q9H2u09LLLuiFjBlohgWNVeJN493ak9ARI9ek7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157294; c=relaxed/simple;
	bh=Wn8FoEwW+D2QuE42oVTj1YP+4D8UCzzDjZm7CDVaXfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmpSK0m4L6EvtkqOkecJV/ZCV48jg24/eNyGjX4ykmSTv77wVTY3u+zpDSyOkNZgCpExGJ9cAaXhO8MFqnwitKCgzflVk+R00lL19ZsSyINMSTbpFPartI1xh8enN5bQIXCVsTuTjY7v+2eSWAClE/cD3Fb++cav0Z+/iOgEbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mXeo3Xyl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mXeo3Xyl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03EB41FB82;
	Thu, 12 Sep 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726157289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nT3s6Lc7/ILovJ0HaNwI1dJWTyKHFyAO/l3//LkMJI8=;
	b=mXeo3Xyl3O6A6IoxoZMa2uo76qY24wqU/T6wjVqkiNMf4AthtYjTPON22YwNqghy3gnrRq
	BfdLC07TEQC77CyP9PICxOwuQy7c8qRRqkSt9kPXC22KXa9qGOHrPQ3kJnkLNW7mda5I4J
	OM/hiCrCXh8K5senCfW4SEpneGHqhLA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mXeo3Xyl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726157289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nT3s6Lc7/ILovJ0HaNwI1dJWTyKHFyAO/l3//LkMJI8=;
	b=mXeo3Xyl3O6A6IoxoZMa2uo76qY24wqU/T6wjVqkiNMf4AthtYjTPON22YwNqghy3gnrRq
	BfdLC07TEQC77CyP9PICxOwuQy7c8qRRqkSt9kPXC22KXa9qGOHrPQ3kJnkLNW7mda5I4J
	OM/hiCrCXh8K5senCfW4SEpneGHqhLA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1D4B13A73;
	Thu, 12 Sep 2024 16:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LGIGO+gR42ZfJAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 12 Sep 2024 16:08:08 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.12
Date: Thu, 12 Sep 2024 18:08:02 +0200
Message-ID: <cover.1726154772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03EB41FB82
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

this update brings mostly refactoring, cleanups, minor performance
optimizations and usual fixes. The folio API conversions are most
noticeable.

There's one less visible change that could have a high impact. The
extent lock scope for read is reduced, not held for the entire
operation. In the buffered read case it's left to page or inode lock,
some direct io read synchronization is still needed.

This used to prevent deadlocks induced by page faults during direct io,
so there was a 4K limitation on the requests, e.g. for io_uring. In the
future this will allow smoother integration with iomap where the extent
read lock was a major obstacle.

Please pull, thanks.

User visible changes:

- the FSTRIM ioctl updates the processed range even after an error or
  interruption

- cleaner thread is woken up in SYNC ioctl instead of waking the
  transaction thread that can take some delay before waking up the
  cleaner, this can speed up cleaning of deleted subvolumes

- print an error message when opening a device fail, e.g. when it's
  unexpectedly read-only

Core changes:

- improved extent map handling in various ways (locking, iteration, ...)

- new assertions and locking annotations

- raid-stripe-tree locking fixes

- use xarray for tracking dirty qgroup extents, switched from rb-tree

- turn the subpage test to compile-time condition if possible (e.g. on
  x86_64 with 4K pages), this allows to skip a lot of ifs and remove
  dead code

- more preparatory work for compression in subpage mode

Cleanups and refactoring

- folio API conversions, many simple cases where page is passed so
  switch it to folios

- more subpage code refactoring, update page state bitmap processing

- introduce auto free for btrfs_path structure, use for the simple cases

----------------------------------------------------------------
The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-tag

for you to fetch changes up to bd610c0937aaf03b2835638ada1fab8b0524c61a:

  btrfs: only unlock the to-be-submitted ranges inside a folio (2024-09-10 16:51:22 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: add comment about locking in cow_file_range_inline()

David Sterba (14):
      btrfs: rename btrfs_submit_bio() to btrfs_submit_bbio()
      btrfs: rename __btrfs_submit_bio() and drop double underscores
      btrfs: rename __extent_writepage() and drop double underscores
      btrfs: rename __compare_inode_defrag() and drop double underscores
      btrfs: constify arguments of compare_inode_defrag()
      btrfs: rename __need_auto_defrag() and drop double underscores
      btrfs: rename __btrfs_add_inode_defrag() and drop double underscores
      btrfs: rename __btrfs_run_defrag_inode() and drop double underscores
      btrfs: clear defragmented inodes using postorder in btrfs_cleanup_defrag_inodes()
      btrfs: return void from btrfs_add_inode_defrag()
      btrfs: drop transaction parameter from btrfs_add_inode_defrag()
      btrfs: always pass readahead state to defrag
      btrfs: rework BTRFS_I as macro to preserve parameter const
      btrfs: constify more pointer parameters

Filipe Manana (5):
      btrfs: reduce size and overhead of extent_map_block_end()
      btrfs: reschedule when updating chunk maps at the end of a device replace
      btrfs: more efficient chunk map iteration when device replace finishes
      btrfs: directly wake up cleaner kthread in the BTRFS_IOC_SYNC ioctl
      btrfs: add and use helper to verify the calling task has locked the inode

Johannes Thumshirn (8):
      btrfs: update stripe extents for existing logical addresses
      btrfs: update stripe_extent delete loop assumptions
      btrfs: don't dump stripe-tree on lookup error
      btrfs: rename btrfs_io_stripe::is_scrub to rst_search_commit_root
      btrfs: set search_commit_root on stripe io in case of relocation
      btrfs: don't readahead the relocation inode on RST
      btrfs: change RST lookup error message level to debug
      btrfs: reduce chunk_map lookups in btrfs_map_block()

Josef Bacik (49):
      btrfs: convert btrfs_readahead() to only use folio
      btrfs: convert btrfs_read_folio() to only use a folio
      btrfs: convert end_page_read() to take a folio
      btrfs: convert begin_page_folio() to take a folio instead
      btrfs: convert submit_extent_page() to use a folio
      btrfs: convert btrfs_do_readpage() to only use a folio
      btrfs: update the writepage tracepoint to take a folio
      btrfs: convert __extent_writepage_io() to take a folio
      btrfs: convert extent_write_locked_range() to use folios
      btrfs: convert __extent_writepage() to be completely folio based
      btrfs: convert add_ra_bio_pages() to use only folios
      btrfs: utilize folio more in btrfs_page_mkwrite()
      btrfs: convert can_finish_ordered_extent() to use a folio
      btrfs: convert btrfs_finish_ordered_extent() to take a folio
      btrfs: convert btrfs_mark_ordered_io_finished() to take a folio
      btrfs: convert writepage_delalloc() to take a folio
      btrfs: convert find_lock_delalloc_range() to use a folio
      btrfs: convert lock_delalloc_pages() to take a folio
      btrfs: convert __unlock_for_delalloc() to take a folio
      btrfs: convert __process_pages_contig() to take a folio
      btrfs: convert process_one_page() to operate only on folios
      btrfs: convert extent_clear_unlock_delalloc() to take a folio
      btrfs: convert extent_write_locked_range() to take a folio
      btrfs: convert run_delalloc_cow() to take a folio
      btrfs: convert cow_file_range_inline() to take a folio
      btrfs: convert cow_file_range() to take a folio
      btrfs: convert fallback_to_cow() to take a folio
      btrfs: convert run_delalloc_nocow() to take a folio
      btrfs: convert btrfs_cleanup_ordered_extents() to use folios
      btrfs: convert btrfs_cleanup_ordered_extents() to take a folio
      btrfs: convert run_delalloc_compressed() to take a folio
      btrfs: convert btrfs_run_delalloc_range() to take a folio
      btrfs: convert struct async_chunk to hold a folio
      btrfs: convert submit_uncompressed_range() to take a folio
      btrfs: convert btrfs_writepage_fixup_worker() to use a folio
      btrfs: convert btrfs_writepage_cow_fixup() to use folio
      btrfs: convert struct btrfs_writepage_fixup to use a folio
      btrfs: convert uncompress_inline() to take a folio
      btrfs: convert read_inline_extent() to use a folio
      btrfs: convert btrfs_get_extent() to take a folio
      btrfs: convert __get_extent_map() to take a folio
      btrfs: convert find_next_dirty_byte() to take a folio
      btrfs: convert wait_subpage_spinlock() to only use a folio
      btrfs: convert btrfs_set_range_writeback() to use a folio
      btrfs: convert insert_inline_extent() to use a folio
      btrfs: convert extent_range_clear_dirty_for_io() to use a folio
      btrfs: introduce EXTENT_DIO_LOCKED
      btrfs: take the dio extent lock during O_DIRECT operations
      btrfs: do not hold the extent lock for entire read

Junchao Sun (2):
      btrfs: qgroup: use goto style to handle errors in add_delayed_ref()
      btrfs: qgroup: use xarray to track dirty extents in transaction

Leo Martins (3):
      btrfs: DEFINE_FREE for struct btrfs_path
      btrfs: use btrfs_path auto free in zoned.c
      btrfs: BTRFS_PATH_AUTO_FREE in orphan.c

Li Zetao (14):
      btrfs: convert clear_page_extent_mapped() to take a folio
      btrfs: convert get_next_extent_buffer() to take a folio
      btrfs: convert try_release_subpage_extent_buffer() to take a folio
      btrfs: convert try_release_extent_buffer() to take a folio
      btrfs: convert read_key_bytes() to take a folio
      btrfs: convert submit_eb_subpage() to take a folio
      btrfs: convert submit_eb_page() to take a folio
      btrfs: convert try_release_extent_state() to take a folio
      btrfs: convert try_release_extent_mapping() to take a folio
      btrfs: convert zlib_decompress() to take a folio
      btrfs: convert lzo_decompress() to take a folio
      btrfs: convert zstd_decompress() to take a folio
      btrfs: convert btrfs_decompress() to take a folio
      btrfs: convert copy_inline_to_page() to use folio

Li Zhang (1):
      btrfs: print message on device opening error during mount

Luca Stefani (1):
      btrfs: always update fstrim_range on failure in FITRIM ioctl

Qu Wenruo (11):
      btrfs: move uuid tree related code to uuid-tree.[ch]
      btrfs: make btrfs_is_subpage() to return false directly for 4K page size
      btrfs: subpage: fix the bitmap dump which can cause bitmap corruption
      btrfs: refactor __extent_writepage_io() to do sector-by-sector submission
      btrfs: remove the nr_ret parameter from __extent_writepage_io()
      btrfs: subpage: remove btrfs_fs_info::subpage_info member
      btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()
      btrfs: make compression path to be subpage compatible
      btrfs: remove btrfs_folio_end_all_writers()
      btrfs: merge btrfs_folio_unlock_writer() into btrfs_folio_end_writer_lock()
      btrfs: only unlock the to-be-submitted ranges inside a folio

Thorsten Blum (1):
      btrfs: send: fix grammar in comments

 fs/btrfs/backref.c               |   6 +-
 fs/btrfs/bio.c                   |  54 ++-
 fs/btrfs/bio.h                   |   6 +-
 fs/btrfs/block-group.c           |  34 +-
 fs/btrfs/block-group.h           |  11 +-
 fs/btrfs/block-rsv.c             |   2 +-
 fs/btrfs/block-rsv.h             |   2 +-
 fs/btrfs/btrfs_inode.h           |  24 +-
 fs/btrfs/compression.c           |  82 ++--
 fs/btrfs/compression.h           |  16 +-
 fs/btrfs/ctree.c                 |  18 +-
 fs/btrfs/ctree.h                 |  11 +-
 fs/btrfs/defrag.c                |  97 ++---
 fs/btrfs/defrag.h                |   3 +-
 fs/btrfs/delayed-ref.c           |  36 +-
 fs/btrfs/delayed-ref.h           |   4 +-
 fs/btrfs/dev-replace.c           |  43 +-
 fs/btrfs/direct-io.c             |  73 ++--
 fs/btrfs/discard.c               |   4 +-
 fs/btrfs/disk-io.c               |  16 +-
 fs/btrfs/extent-io-tree.c        |  55 ++-
 fs/btrfs/extent-io-tree.h        |  38 +-
 fs/btrfs/extent-tree.c           |   4 +-
 fs/btrfs/extent_io.c             | 865 +++++++++++++++++----------------------
 fs/btrfs/extent_io.h             |  12 +-
 fs/btrfs/extent_map.c            |   9 +-
 fs/btrfs/file-item.c             |   4 +-
 fs/btrfs/file-item.h             |   2 +-
 fs/btrfs/file.c                  |  26 +-
 fs/btrfs/fs.h                    |   2 +-
 fs/btrfs/inode-item.c            |  10 +-
 fs/btrfs/inode-item.h            |   4 +-
 fs/btrfs/inode.c                 | 368 +++++++++--------
 fs/btrfs/ioctl.c                 |  11 +-
 fs/btrfs/lzo.c                   |  12 +-
 fs/btrfs/ordered-data.c          |  30 +-
 fs/btrfs/ordered-data.h          |   6 +-
 fs/btrfs/orphan.c                |  24 +-
 fs/btrfs/qgroup.c                |  66 ++-
 fs/btrfs/qgroup.h                |   1 -
 fs/btrfs/raid-stripe-tree.c      |  46 ++-
 fs/btrfs/reflink.c               |  35 +-
 fs/btrfs/relocation.c            |  22 +-
 fs/btrfs/scrub.c                 |  12 +-
 fs/btrfs/send.c                  |   4 +-
 fs/btrfs/space-info.c            |  25 +-
 fs/btrfs/space-info.h            |  10 +-
 fs/btrfs/subpage.c               | 277 ++++++-------
 fs/btrfs/subpage.h               |  60 ++-
 fs/btrfs/tests/extent-io-tests.c |  10 +-
 fs/btrfs/transaction.c           |   5 +-
 fs/btrfs/tree-log.c              |   2 +-
 fs/btrfs/tree-mod-log.c          |  14 +-
 fs/btrfs/tree-mod-log.h          |   6 +-
 fs/btrfs/uuid-tree.c             | 179 ++++++++
 fs/btrfs/uuid-tree.h             |   2 +
 fs/btrfs/verity.c                |  20 +-
 fs/btrfs/volumes.c               | 228 ++---------
 fs/btrfs/volumes.h               |   4 +-
 fs/btrfs/xattr.c                 |   2 +-
 fs/btrfs/zlib.c                  |  33 +-
 fs/btrfs/zoned.c                 |  36 +-
 fs/btrfs/zoned.h                 |   4 +-
 fs/btrfs/zstd.c                  |  35 +-
 include/trace/events/btrfs.h     |  18 +-
 65 files changed, 1583 insertions(+), 1597 deletions(-)

