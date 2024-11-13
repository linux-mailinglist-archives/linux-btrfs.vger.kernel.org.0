Return-Path: <linux-btrfs+bounces-9611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3189C7AD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FEA1F2224A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD9206051;
	Wed, 13 Nov 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P5OhSvbU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P5OhSvbU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E011632CC;
	Wed, 13 Nov 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521596; cv=none; b=C9qlsWsbjGq+U4QEUKKVhOm7IxvZI1/aEsOoQoZJokqq/EkzsHN76SzFH2D9SOuogah5ekyrvEThM6rppOxUmy6wcBSK0T83SH0PpjXLei0au5fq8jU1ahtmD090UGV/LS0J0D6pf2EZQ4jL47MqpxlvJ9t8bnXW4TlR5jhNOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521596; c=relaxed/simple;
	bh=F52WRbWQSO/yAsYaMMN0EtbDG7lOPQrbUUIvq1lNTpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HB6oVz4a6df2W9rN6Zm9z/fMZ2WJ0wN87WKHD0hlzdbzm3z8GzLeC8ckGX7061s48nbB3VB6qDPVwhk3JpJ4pyKU/L+ANjq4aPT2Vv5Q0LlGBVHpG+1jzGvjRY5BCcuEg5jw6zfOPxn9lgtUok/G2IOxXgX0mvRG/KTzWkD6smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P5OhSvbU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P5OhSvbU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FF571F395;
	Wed, 13 Nov 2024 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731521592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lA69RuZMe9AMJXFhQAr7v/Y0SI4deWgaHyS+QBpri7k=;
	b=P5OhSvbUyN156X7JIaXJs3w6yZMXPsVFVrKM0tM2BQcSkU1vhv+hm/3LxvzDgEPiM3uRDt
	rwl7Br1AlbLV835YD8mrH/KxZyKy/uhqyDs0YnC0piO6YxUN5aUmZVMNogZGcqxKeGZ+lt
	O0DnrdipV65+t5rdrUx+8vx2vhe13PQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731521592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lA69RuZMe9AMJXFhQAr7v/Y0SI4deWgaHyS+QBpri7k=;
	b=P5OhSvbUyN156X7JIaXJs3w6yZMXPsVFVrKM0tM2BQcSkU1vhv+hm/3LxvzDgEPiM3uRDt
	rwl7Br1AlbLV835YD8mrH/KxZyKy/uhqyDs0YnC0piO6YxUN5aUmZVMNogZGcqxKeGZ+lt
	O0DnrdipV65+t5rdrUx+8vx2vhe13PQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1556A13A6E;
	Wed, 13 Nov 2024 18:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TCDhBDjsNGdrVgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 13 Nov 2024 18:13:12 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.13
Date: Wed, 13 Nov 2024 19:13:03 +0100
Message-ID: <cover.1731515050.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull the following updates for btrfs.

Changes outside of btrfs: add io_uring command flag to track a dying
task (the rest will go via the block git tree).

User visible changes:

- wire encoded read (ioctl) to io_uring commands, this can be used on
  itself, in the future this will allow 'send' to be asynchronous
  - as a consequence, the encoded read ioctl can also work in
    non-blocking mode

- new ioctl to wait for cleaned subvolumes, no need to use the generic
  and root-only SEARCH_TREE ioctl, will be used by "btrfs subvol sync"

- recognize different paths/symlinks for the same devices and don't
  report them during rescanning, this can be observed with LVM or DM

- seeding device use case change, the sprout device (the one capturing
  new writes) will not clear the read-only status of the super block;
  this prevents accumulating space from deleted snapshots

Performance improvements:

- reduce lock contention when traversing extent buffers

- reduce extent tree lock contention when searching for inline backref

- switch from rb-trees to xarray for delayed ref tracking, improvements
  due to better cache locality, branching factors and more compact data
  structures

- enable extent map shrinker again (prevent memory exhaustion under
  some types of IO load), reworked to run in a single worker thread
  (there used to be problems causing long stalls under memory pressure)

Core changes:

- raid-stripe-tree feature updates
  - make device replace and scrub work
  - implement partial deletion of stripe extents
  - new selftests

- split the config option BTRFS_DEBUG and add EXPERIMENTAL for features
  that are experimental or with known problems so we don't misuse
  debugging config for that

- subpage mode updates (sector < page)
  - update compression implementations
  - update writepage, writeback

- continued folio API conversions
  - buffered writes

- make buffered write copy one page at a time, preparatory work for
  future integration with large folios, may cause performance drop

- proper locking of root item regarding starting send

- error handling improvements

- code cleanups and refactoring
  - dead code removal
  - unused parameter reduction
  - lockdep assertions

----------------------------------------------------------------
The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-tag

for you to fetch changes up to e82c936293aafb4f33b153c684c37291b3eed377:

  btrfs: send: check for read-only send root under critical section (2024-11-11 14:34:23 +0100)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: use filemap_get_folio() helper

Boris Burkov (1):
      btrfs: do not clear read-only when adding sprout device

Christoph Hellwig (1):
      btrfs: fix a typo in btrfs_use_zone_append

David Sterba (26):
      btrfs: zstd: assert the timer pointer in callback
      btrfs: drop unused parameter path from btrfs_tree_mod_log_rewind()
      btrfs: drop unused parameter ctx from batch_delete_dir_index_items()
      btrfs: drop unused parameter fs_info from wait_reserve_ticket()
      btrfs: drop unused parameter fs_info from do_reclaim_sweep()
      btrfs: send: drop unused parameter num from iterate_inode_ref_t callbacks
      btrfs: send: drop unused parameter index from iterate_inode_ref_t callbacks
      btrfs: scrub: drop unused parameter sctx from scrub_submit_extent_sector_read()
      btrfs: drop unused parameter map from scrub_simple_mirror()
      btrfs: qgroup: drop unused parameter fs_info from __del_qgroup_rb()
      btrfs: drop unused transaction parameter from btrfs_qgroup_add_swapped_blocks()
      btrfs: lzo: drop unused paramter level from lzo_alloc_workspace()
      btrfs: drop unused parameter argp from btrfs_ioctl_quota_rescan_wait()
      btrfs: drop unused parameter inode from read_inline_extent()
      btrfs: drop unused parameter offset from __cow_file_range_inline()
      btrfs: drop unused parameter file_offset from btrfs_encoded_read_regular_fill_pages()
      btrfs: drop unused parameter iov_iter from btrfs_write_check()
      btrfs: drop unused parameter refs from visit_node_for_delete()
      btrfs: drop unused parameter mask from try_release_extent_state()
      btrfs: drop unused parameter fs_info from folio_range_has_eb()
      btrfs: drop unused parameter options from open_ctree()
      btrfs: drop unused parameter data from btrfs_fill_super()
      btrfs: drop unused parameter transaction from alloc_log_tree()
      btrfs: drop unused parameter fs_info from btrfs_match_dir_item_name()
      btrfs: drop unused parameter level from alloc_heuristic_ws()
      btrfs: add new ioctl to wait for cleaned subvolumes

Dr. David Alan Gilbert (3):
      btrfs: remove unused btrfs_free_squota_rsv()
      btrfs: remove unused btrfs_is_parity_mirror()
      btrfs: remove unused btrfs_try_tree_write_lock()

Filipe Manana (40):
      btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record
      btrfs: store fs_info in a local variable at btrfs_qgroup_trace_extent_post()
      btrfs: remove unnecessary delayed refs locking at btrfs_qgroup_trace_extent()
      btrfs: always use delayed_refs local variable at btrfs_qgroup_trace_extent()
      btrfs: remove pointless initialization at btrfs_qgroup_trace_extent()
      btrfs: qgroup: run delayed iputs after ordered extent completion
      btrfs: add and use helper to remove extent map from its inode's tree
      btrfs: make the extent map shrinker run asynchronously as a work queue job
      btrfs: simplify tracking progress for the extent map shrinker
      btrfs: rename extent map shrinker members from struct btrfs_fs_info
      btrfs: re-enable the extent map shrinker
      btrfs: remove redundant level argument from read_block_for_search()
      btrfs: simplify arguments for btrfs_verify_level_key()
      btrfs: remove redundant initializations for struct btrfs_tree_parent_check
      btrfs: remove local generation variable from read_block_for_search()
      btrfs: remove BUG_ON() at btrfs_destroy_delayed_refs()
      btrfs: move btrfs_destroy_delayed_refs() to delayed-ref.c
      btrfs: remove fs_info parameter from btrfs_destroy_delayed_refs()
      btrfs: remove fs_info parameter from btrfs_cleanup_one_transaction()
      btrfs: remove duplicated code to drop delayed ref during transaction abort
      btrfs: use helper to find first ref head at btrfs_destroy_delayed_refs()
      btrfs: remove num_entries atomic counter from delayed ref root
      btrfs: change return type of btrfs_delayed_ref_lock() to boolean
      btrfs: simplify obtaining a delayed ref head
      btrfs: move delayed ref head unselection to delayed-ref.c
      btrfs: pass fs_info to functions that search for delayed ref heads
      btrfs: pass fs_info to btrfs_delete_ref_head()
      btrfs: assert delayed refs lock is held at find_ref_head()
      btrfs: assert delayed refs lock is held at find_first_ref_head()
      btrfs: assert delayed refs lock is held at add_delayed_ref_head()
      btrfs: add comments regarding locking to struct btrfs_delayed_ref_root
      btrfs: track delayed ref heads in an xarray
      btrfs: remove no longer used delayed ref head search functionality
      btrfs: update stale comment for struct btrfs_delayed_ref_node::add_list
      btrfs: remove hole from struct btrfs_delayed_node
      btrfs: simplify logic to decrement snapshot counter at btrfs_mksnapshot()
      btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
      btrfs: remove check for NULL fs_info at btrfs_folio_end_lock_bitmap()
      btrfs: send: check for dead send root under critical section
      btrfs: send: check for read-only send root under critical section

Haisu Wang (1):
      btrfs: simplify range tracking in cow_file_range()

Johannes Thumshirn (8):
      btrfs: don't take dev_replace rwsem on task already holding it
      btrfs: remove code duplication in ordered extent finishing
      btrfs: tests: add selftests for raid-stripe-tree
      btrfs: handle empty list of NOCOW ordered extents with checksum list
      btrfs: return ENODATA in case RST lookup fails
      btrfs: scrub: skip initial RST lookup errors
      btrfs: implement partial deletion of RAID stripe extents
      btrfs: tests: implement case for partial RAID stripe-tree delete

Leo Martins (2):
      btrfs: push cleanup into btrfs_read_locked_inode()
      btrfs: remove conditional path allocation in btrfs_read_locked_inode()

Mark Harmstone (8):
      btrfs: fix wrong sizeof in btrfs_do_encoded_write()
      btrfs: remove pointless iocb::ki_pos addition in btrfs_encoded_read()
      btrfs: change btrfs_encoded_read() so that reading of extent is done by caller
      btrfs: don't sleep in btrfs_encoded_read() if IOCB_NOWAIT is set
      btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()
      btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)
      btrfs: add struct io_btrfs_cmd as type for io_uring_cmd_to_pdu()
      btrfs: avoid superfluous calls to free_extent_map() in btrfs_encoded_read()

Pavel Begunkov (1):
      io_uring/cmd: let cmds to know about dying task

Qu Wenruo (21):
      btrfs: make assert_rbio() to only check CONFIG_BTRFS_ASSERT
      btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG
      btrfs: zlib: make the compression path to handle sector size < page size
      btrfs: zstd: make the compression path to handle sector size < page size
      btrfs: compression: add an ASSERT() to ensure the read-in length is sane
      btrfs: wait for writeback if sector size is smaller than page size
      btrfs: make extent_range_clear_dirty_for_io() to handle sector size < page size cases
      btrfs: do not assume the full page range is not dirty in extent_writepage_io()
      btrfs: move the delalloc range bitmap search into extent_io.c
      btrfs: mark all dirty sectors as locked inside writepage_delalloc()
      btrfs: allow compression even if the range is not page aligned
      btrfs: avoid unnecessary device path update for the same device
      btrfs: canonicalize the device path before adding it
      btrfs: remove the dirty_page local variable
      btrfs: simplify the page uptodate preparation for prepare_pages()
      btrfs: remove btrfs_set_range_writeback()
      btrfs: remove unused btrfs_folio_start_writer_lock()
      btrfs: unify to use writer locks for subpage locking
      btrfs: rename btrfs_folio_(set|start|end)_writer_lock()
      btrfs: make buffered write to copy one page a time
      btrfs: convert btrfs_buffered_write() to use folios

Riyan Dhiman (1):
      btrfs: remove redundant stop_loop variable in scrub_stripe()

Robbie Ko (2):
      btrfs: reduce lock contention when eb cache miss for btree search
      btrfs: reduce extent tree lock contention when searching for inline backref

Shen Lichuan (1):
      btrfs: correct typos in multiple comments across various files

Thorsten Blum (1):
      btrfs: use str_yes_no() helper function in btrfs_dump_free_space()

Youling Tang (1):
      btrfs: remove unused page_to_inode and page_to_fs_info macros

 fs/btrfs/Kconfig                        |  26 ++
 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/backref.c                      |   3 +-
 fs/btrfs/bio.c                          |   2 +-
 fs/btrfs/block-group.c                  |   2 +-
 fs/btrfs/btrfs_inode.h                  |  15 +-
 fs/btrfs/compression.c                  |  14 +-
 fs/btrfs/compression.h                  |   2 +-
 fs/btrfs/ctree.c                        | 148 +++++----
 fs/btrfs/delayed-inode.h                |   2 +-
 fs/btrfs/delayed-ref.c                  | 327 +++++++++++--------
 fs/btrfs/delayed-ref.h                  |  64 ++--
 fs/btrfs/dev-replace.c                  |   4 +-
 fs/btrfs/dir-item.c                     |  11 +-
 fs/btrfs/dir-item.h                     |   3 +-
 fs/btrfs/direct-io.c                    |   2 +-
 fs/btrfs/disk-io.c                      |  93 +-----
 fs/btrfs/disk-io.h                      |   6 +-
 fs/btrfs/extent-tree.c                  | 104 +++---
 fs/btrfs/extent_io.c                    | 111 +++++--
 fs/btrfs/extent_map.c                   | 122 ++++----
 fs/btrfs/extent_map.h                   |   3 +-
 fs/btrfs/fiemap.c                       |   6 +-
 fs/btrfs/file.c                         | 351 ++++++++-------------
 fs/btrfs/file.h                         |   7 +-
 fs/btrfs/free-space-cache.c             |  22 +-
 fs/btrfs/fs.h                           |  16 +-
 fs/btrfs/inode.c                        | 495 +++++++++++++++--------------
 fs/btrfs/ioctl.c                        | 478 +++++++++++++++++++++++++++-
 fs/btrfs/ioctl.h                        |   2 +
 fs/btrfs/locking.c                      |  15 -
 fs/btrfs/locking.h                      |   1 -
 fs/btrfs/lzo.c                          |   2 +-
 fs/btrfs/qgroup.c                       |  90 +++---
 fs/btrfs/qgroup.h                       |  17 +-
 fs/btrfs/raid-stripe-tree.c             |  92 +++++-
 fs/btrfs/raid-stripe-tree.h             |   5 +
 fs/btrfs/raid56.c                       |   3 +-
 fs/btrfs/relocation.c                   |   2 +-
 fs/btrfs/scrub.c                        |  37 +--
 fs/btrfs/send.c                         |  61 ++--
 fs/btrfs/send.h                         |   2 +-
 fs/btrfs/space-info.c                   |  12 +-
 fs/btrfs/subpage.c                      | 204 ++----------
 fs/btrfs/subpage.h                      |  39 +--
 fs/btrfs/super.c                        |  33 +-
 fs/btrfs/sysfs.c                        |   4 +-
 fs/btrfs/tests/btrfs-tests.c            |   4 +
 fs/btrfs/tests/btrfs-tests.h            |   2 +
 fs/btrfs/tests/raid-stripe-tree-tests.c | 538 ++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c                  |   8 +-
 fs/btrfs/transaction.h                  |   2 +-
 fs/btrfs/tree-checker.c                 |  16 +-
 fs/btrfs/tree-checker.h                 |   4 +-
 fs/btrfs/tree-log.c                     |   3 +-
 fs/btrfs/tree-mod-log.c                 |   1 -
 fs/btrfs/tree-mod-log.h                 |   1 -
 fs/btrfs/volumes.c                      | 163 ++++++++--
 fs/btrfs/volumes.h                      |  11 +-
 fs/btrfs/xattr.c                        |   5 +-
 fs/btrfs/zlib.c                         |   2 +-
 fs/btrfs/zoned.c                        |   4 +-
 fs/btrfs/zstd.c                         |   4 +-
 include/linux/io_uring_types.h          |   1 +
 include/trace/events/btrfs.h            |  39 +--
 include/uapi/linux/btrfs.h              |  25 ++
 io_uring/uring_cmd.c                    |   6 +-
 67 files changed, 2470 insertions(+), 1432 deletions(-)
 create mode 100644 fs/btrfs/tests/raid-stripe-tree-tests.c

