Return-Path: <linux-btrfs+bounces-17134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7BB9A4DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B429A7ABFC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B963093BF;
	Wed, 24 Sep 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TixpUEbE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TixpUEbE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1889308F05
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724869; cv=none; b=VUlHc1s/KFhR1LeZcsChMWq1NheAPqBzW5yzhqQj7yUMf+mJcH0SoOxNdwy2UAT6ckxeHnrNMmAt9Mpyt3dUnppVqXuyaF5ebbzghNIlwarBX3ZsMMGIpjkAWvL6PEaWDyhx9Dl/RlwBOT8hYxVSiHCg0H7uSBvqWxAXjh1enuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724869; c=relaxed/simple;
	bh=XtvFE0MLGuIFTVVePR99Kztzvs53g5l3g4DTolaghcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=axzPlwNSxetVvDAXCWwL/qrB9Y3wpiXffpYMwkZyy6kyNQKwbBAcAsRMAq6E7D7rWIL214l+cmvpM4AsFi+s4nT5z/oHmTxBkWpu4PlXkK5n3f+xKKkQZv9g7uNwWfBaNcPUkiZPrtoojFkaVXkmXyp19RaYmsXU09+LJVC2hSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TixpUEbE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TixpUEbE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F34934EDE;
	Wed, 24 Sep 2025 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758724865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JpU9eus9sp2sIedpHbf7ALL8eZujD1SJOIIqKuwntM0=;
	b=TixpUEbE/XHqr2qhH7P4tUXbx/60YfPWOmz2czgBARK5/Kh4pSILmamRgaZs9/TJ+RRGep
	WBGQkKcLpP/1sMjYB8Rb0feYwR7T7DqeiHAJ7q/Y5xNLKA1OeJpO1P+9dTm8+x3bLmgFzV
	67xe1pggjlkhLrrfrpB7X2ZjcYLkQ8o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TixpUEbE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758724865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JpU9eus9sp2sIedpHbf7ALL8eZujD1SJOIIqKuwntM0=;
	b=TixpUEbE/XHqr2qhH7P4tUXbx/60YfPWOmz2czgBARK5/Kh4pSILmamRgaZs9/TJ+RRGep
	WBGQkKcLpP/1sMjYB8Rb0feYwR7T7DqeiHAJ7q/Y5xNLKA1OeJpO1P+9dTm8+x3bLmgFzV
	67xe1pggjlkhLrrfrpB7X2ZjcYLkQ8o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 185D313A61;
	Wed, 24 Sep 2025 14:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RCYKBgED1GjUBQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Sep 2025 14:41:05 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.18
Date: Wed, 24 Sep 2025 16:40:54 +0200
Message-ID: <cover.1758696658.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1F34934EDE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.51

Hi,

please pull the following updates for btrfs. There are no new features,
the changes are in the core code, notably tree-log error handling and
reporting improvements, and initial support for block size > page size.

(There's one build warning due to printk format mismatch reported on
i386, we'll fix it before rc1. I did not consider it serious enough to
rework and delay the whole pull request.)

Please pull, thanks.

Performance improvements:

- search data checksums in the commit root (previous transaction) to
  avoid locking contention, this improves parallelism of read heavy/low
  write workloads, and also reduces transaction commit time;
  on real and reproducer workload the sync time went from minutes to
  tens of seconds (workload and numbers are in the changelog)

Core:

- tree-log updates
  - error handling improvements, transaction aborts
  - add new error state 'O' (printed in status messages) when log replay
    fails and is aborted
  - reduced number of btrfs_path allocations when traversing the tree

- 'block size > page size' support
  - basic implementation with limitations, under experimental build
  - limitations: no direct io, raid56, encoded read (standalone and in
    send ioctl), encoded write
  - preparatory work for compression, removing implicit assumptions of
    page and block sizes
  - compression workspaces are now per-filesystem, we cannot assume
    common block size for work memory among different filesystems

- tree-checker now verifies INODE_EXTREF item (which is implementing
  hardlinks)

- tree leaf pretty printer updates, there were missing data from items,
  keys/items

- move config option CONFIG_BTRFS_REF_VERIFY to CONFIG_BTRFS_DEBUG,
  it's a debugging feature and not needed to be enabled separately

- more struct btrfs_path auto free updates

- use ref_tracker API for tracking delayed inodes, enabled by mount
  option 'ref_verify', allowing to better pinpoint leaking references

- in zoned mode, avoid selecting data relocation zoned for ordinary data
  block groups

- updated and enhanced error messages

- lots of cleanups and refactoring

----------------------------------------------------------------
The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag

for you to fetch changes up to 45c222468d33202c07c41c113301a4b9c8451b8f:

  btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot() (2025-09-23 09:02:17 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: try to search for data csums in commit root

David Sterba (5):
      btrfs: convert several int parameters to bool
      btrfs: fix typos in comments and strings
      btrfs: add unlikely annotations to branches leading to EUCLEAN
      btrfs: add unlikely annotations to branches leading to EIO
      btrfs: add unlikely annotations to branches leading to transaction abort

Filipe Manana (63):
      btrfs: abort transaction on specific error places when walking log tree
      btrfs: abort transaction in the process_one_buffer() log tree walk callback
      btrfs: use local variable for the transaction handle in replay_one_buffer()
      btrfs: return real error from read_alloc_one_name() in drop_one_dir_item()
      btrfs: abort transaction where errors happen during log tree replay
      btrfs: exit early when replaying hole file extent item from a log tree
      btrfs: process inline extent earlier in replay_one_extent()
      btrfs: use local key variable to pass arguments in replay_one_extent()
      btrfs: collapse unaccount_log_buffer() into clean_log_buffer()
      btrfs: use booleans in walk control structure for log replay
      btrfs: rename replay_dest member of struct walk_control to root
      btrfs: rename root to log in walk_down_log_tree() and walk_up_log_tree()
      btrfs: add and use a log root field to struct walk_control
      btrfs: deduplicate log root free in error paths from btrfs_recover_log_trees()
      btrfs: stop passing transaction parameter to log tree walk functions
      btrfs: stop setting log_root_tree->log_root to NULL in btrfs_recover_log_trees()
      btrfs: always drop log root tree reference in btrfs_replay_log()
      btrfs: pass walk_control structure to replay_xattr_deletes()
      btrfs: move up the definition of struct walk_control
      btrfs: pass walk_control structure to replay_dir_deletes()
      btrfs: pass walk_control structure to check_item_in_log()
      btrfs: pass walk_control structure to replay_one_extent()
      btrfs: pass walk_control structure to add_inode_ref() and helpers
      btrfs: pass walk_control structure to replay_one_dir_item() and replay_one_name()
      btrfs: pass walk_control structure to drop_one_dir_item() and helpers
      btrfs: pass walk_control structure to overwrite_item()
      btrfs: use level argument in log tree walk callback process_one_buffer()
      btrfs: use level argument in log tree walk callback replay_one_buffer()
      btrfs: use the inode item boolean everywhere in overwrite_item()
      btrfs: add current log leaf, key and slot to struct walk_control
      btrfs: avoid unnecessary path allocation at fixup_inode_link_count()
      btrfs: avoid path allocations when dropping extents during log replay
      btrfs: avoid unnecessary path allocation when replaying a dir item
      btrfs: remove redundant path release when processing dentry during log replay
      btrfs: remove redundant path release when overwriting item during log replay
      btrfs: add path for subvolume tree changes to struct walk_control
      btrfs: stop passing inode object IDs to __add_inode_ref() in log replay
      btrfs: remove pointless inode lookup when processing extrefs during log replay
      btrfs: abort transaction if we fail to find dir item during log replay
      btrfs: abort transaction if we fail to update inode in log replay dir fixup
      btrfs: dump detailed info and specific messages on log replay failures
      btrfs: send: index backref cache by node number instead of by sector number
      btrfs: print-tree: print missing fields for inode items
      btrfs: print-tree: print more information about dir items
      btrfs: print-tree: print dir items for dir index and xattr keys too
      btrfs: print-tree: print information about inode ref items
      btrfs: print-tree: print information about inode extref items
      btrfs: print-tree: print information about dir log items
      btrfs: print-tree: print range information for extent csum items
      btrfs: print-tree: print correct inline extent data size
      btrfs: print-tree: print compression type for file extent items
      btrfs: print-tree: move code for processing file extent item into helper
      btrfs: print-tree: print key types as human readable strings
      btrfs: store and use node size in local variable in check_eb_alignment()
      btrfs: mark extent buffer alignment checks as unlikely
      btrfs: mark as unlikely not uptodate extent buffer checks when navigating btrees
      btrfs: mark leaf space and overflow checks as unlikely on insert and extension
      btrfs: fix comment about nbytes increase at replay_one_extent()
      btrfs: simplify inline extent end calculation at replay_one_extent()
      btrfs: make the rule checking more readable for should_cow_block()
      btrfs: annotate btrfs_is_testing() as unlikely and make it return bool
      btrfs: remove pointless key offset setup in create_pending_snapshot()
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()

Jiapeng Chong (1):
      btrfs: remove duplicate inclusion of linux/types.h

Johannes Thumshirn (3):
      btrfs: zoned: directly call do_zone_finish() from btrfs_zone_finish_endio_workfn()
      btrfs: zoned: return error from btrfs_zone_finish_endio()
      btrfs: zoned: don't fail mount needlessly due to too many active zones

Leo Martins (4):
      btrfs: move ref-verify under CONFIG_BTRFS_DEBUG
      btrfs: implement ref_tracker for delayed_nodes
      btrfs: print leaked references in kill_all_delayed_nodes()
      btrfs: add mount option for ref_tracker

Miquel Sabaté Solà (1):
      btrfs: use kmalloc_array() for open-coded arithmetic in kmalloc()

Naohiro Aota (1):
      btrfs: zoned: refine extent allocator hint selection

Qu Wenruo (31):
      btrfs: replace double boolean parameters of cow_file_range()
      btrfs: pass btrfs_inode pointer directly into btrfs_compress_folios()
      btrfs: use blocksize to check if compression is making things larger
      btrfs: simplify support block size check
      btrfs: rework error handling of run_delalloc_nocow()
      btrfs: enhance error messages for delalloc range failure
      btrfs: make nocow_one_range() to do cleanup on error
      btrfs: keep folios locked inside run_delalloc_nocow()
      btrfs: add an fs_info parameter for compression workspace manager
      btrfs: add workspace manager initialization for zstd
      btrfs: add generic workspace manager initialization
      btrfs: migrate to use per-fs workspace manager
      btrfs: cleanup the per-module compression workspace managers
      btrfs: rename btrfs_compress_op to btrfs_compress_levels
      btrfs: reduce compression workspace buffer space to block size
      btrfs: support all block sizes which is no larger than page size
      btrfs: concentrate highmem handling for data verification
      btrfs: introduce btrfs_bio_for_each_block() helper
      btrfs: introduce btrfs_bio_for_each_block_all() helper
      btrfs: cache max and min order inside btrfs_fs_info
      btrfs: tree-checker: add inode extref checks
      btrfs: return any hit error from extent_writepage_io()
      btrfs: fix the incorrect max_bytes value for find_lock_delalloc_range()
      btrfs: prepare compression folio alloc/free for bs > ps cases
      btrfs: prepare zstd to support bs > ps cases
      btrfs: prepare lzo to support bs > ps cases
      btrfs: prepare zlib to support bs > ps cases
      btrfs: prepare scrub to support bs > ps cases
      btrfs: fix symbolic link reading when bs > ps
      btrfs: add extra ASSERT()s to catch unaligned bios
      btrfs: enable experimental bs > ps support

Sun YangKai (1):
      btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions

Thorsten Blum (1):
      btrfs: scrub: replace max_t()/min_t() with clamp() in scrub_throttle_dev_io()

Xichao Zhao (1):
      btrfs: use PTR_ERR_OR_ZERO() to simplify code inbtrfs_control_ioctl()

 fs/btrfs/Kconfig                    |   12 +-
 fs/btrfs/Makefile                   |    2 +-
 fs/btrfs/accessors.c                |    2 +-
 fs/btrfs/backref.c                  |   26 +-
 fs/btrfs/backref.h                  |    4 +-
 fs/btrfs/bio.c                      |   54 +-
 fs/btrfs/bio.h                      |    2 +
 fs/btrfs/block-group.c              |   30 +-
 fs/btrfs/block-group.h              |    2 +-
 fs/btrfs/btrfs_inode.h              |   16 +-
 fs/btrfs/compression.c              |  243 +++--
 fs/btrfs/compression.h              |   59 +-
 fs/btrfs/ctree.c                    |  135 +--
 fs/btrfs/defrag.c                   |    4 +-
 fs/btrfs/delayed-inode.c            |  186 ++--
 fs/btrfs/delayed-inode.h            |   93 ++
 fs/btrfs/delayed-ref.c              |   13 +-
 fs/btrfs/delayed-ref.h              |    9 +-
 fs/btrfs/dev-replace.c              |   12 +-
 fs/btrfs/direct-io.c                |   12 +
 fs/btrfs/disk-io.c                  |   97 +-
 fs/btrfs/disk-io.h                  |    3 +-
 fs/btrfs/export.c                   |    2 +-
 fs/btrfs/extent-io-tree.c           |    4 +-
 fs/btrfs/extent-io-tree.h           |    2 +-
 fs/btrfs/extent-tree.c              |  104 +-
 fs/btrfs/extent-tree.h              |    7 +-
 fs/btrfs/extent_io.c                |  127 ++-
 fs/btrfs/extent_io.h                |    3 +-
 fs/btrfs/extent_map.c               |   22 +-
 fs/btrfs/fiemap.c                   |    2 +-
 fs/btrfs/file-item.c                |   60 +-
 fs/btrfs/file.c                     |   49 +-
 fs/btrfs/free-space-cache.c         |    6 +-
 fs/btrfs/free-space-tree.c          |   60 +-
 fs/btrfs/fs.c                       |   48 +
 fs/btrfs/fs.h                       |   41 +-
 fs/btrfs/inode-item.c               |   10 +-
 fs/btrfs/inode.c                    |  506 ++++-----
 fs/btrfs/ioctl.c                    |   69 +-
 fs/btrfs/locking.c                  |    2 +-
 fs/btrfs/locking.h                  |    2 +-
 fs/btrfs/lzo.c                      |   93 +-
 fs/btrfs/messages.c                 |    1 +
 fs/btrfs/messages.h                 |    1 -
 fs/btrfs/misc.h                     |   49 +
 fs/btrfs/print-tree.c               |  256 ++++-
 fs/btrfs/qgroup.c                   |   44 +-
 fs/btrfs/raid-stripe-tree.c         |   17 +-
 fs/btrfs/raid56.c                   |  121 ++-
 fs/btrfs/raid56.h                   |    4 +-
 fs/btrfs/ref-verify.c               |    3 +-
 fs/btrfs/ref-verify.h               |    4 +-
 fs/btrfs/reflink.c                  |   15 +-
 fs/btrfs/relocation.c               |   81 +-
 fs/btrfs/root-tree.c                |   66 +-
 fs/btrfs/scrub.c                    |   95 +-
 fs/btrfs/scrub.h                    |    2 +-
 fs/btrfs/send.c                     |  373 +++----
 fs/btrfs/space-info.c               |    4 +-
 fs/btrfs/subpage.c                  |    2 +-
 fs/btrfs/subpage.h                  |    2 +-
 fs/btrfs/super.c                    |   34 +-
 fs/btrfs/sysfs.c                    |   16 +-
 fs/btrfs/tests/delayed-refs-tests.c |    4 +-
 fs/btrfs/tests/extent-map-tests.c   |    2 +-
 fs/btrfs/transaction.c              |   49 +-
 fs/btrfs/tree-checker.c             |   39 +-
 fs/btrfs/tree-log.c                 | 1920 ++++++++++++++++++++---------------
 fs/btrfs/verity.c                   |    8 +-
 fs/btrfs/volumes.c                  |   70 +-
 fs/btrfs/volumes.h                  |    4 +-
 fs/btrfs/zlib.c                     |   86 +-
 fs/btrfs/zoned.c                    |   72 +-
 fs/btrfs/zoned.h                    |    9 +-
 fs/btrfs/zstd.c                     |  198 ++--
 76 files changed, 3441 insertions(+), 2445 deletions(-)

