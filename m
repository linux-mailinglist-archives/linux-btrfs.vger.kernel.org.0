Return-Path: <linux-btrfs+bounces-15637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DAB0E72A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C015816C004
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772628B50B;
	Tue, 22 Jul 2025 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kw6k5gql";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kw6k5gql"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA8288CA8
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226638; cv=none; b=QBCm6LEm9/B1suFQKhzpBaRytaQKejzClEUvAZsTvNawH6yyIjSl6JFFJlwp35oG866RfrzPUkUQLY3iJphLBtVxn20SkyNSQ6awSzoxCHRJzEmoy5fpNMRmYYQXCjh5/UFODlirEWGCC5IXRnaAWi+iH0es6+/p0o4r77SVAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226638; c=relaxed/simple;
	bh=kpfhFU7EnIkOqTIZV6QL6UZO2Fz5KbidaWaZ2ygj2bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n53g6AcdhheKrJIyYjKJMFvoqAQzQdIk9CpJFrjocmw7mWFbQOoqwh2RE5wQukeq9ewuYvSsT3KvzCVh0oXsMRStkOpyZj3+QdtOSC2FJhWxntIaBsuhtaEZ328Qsmuvghd89pdn9Qx+fTFi3/2QEjhuOxHNuetLG8kSIj9Ilz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kw6k5gql; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kw6k5gql; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 963DB218C8;
	Tue, 22 Jul 2025 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753226632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cuv0BW6Lv0a9BpPVG2ZQGHWUBUUsUvwgqBEVzkCsZzw=;
	b=Kw6k5gqlxVb4tTw7eybntuzrglJgXXoAeXDubh2lcDEH+29Xs1ZVLHwJRxp4OqVReeoYxZ
	yzZPUe+d80rSYbEqRNwEwO+2QijmU4bLF0e/wnCWGuggg1nYKSQA6p2le2p52L8nWqBE+q
	xHQWw0FEPYKBJkXdY5h0vv3Vkb2vaD0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Kw6k5gql
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753226632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cuv0BW6Lv0a9BpPVG2ZQGHWUBUUsUvwgqBEVzkCsZzw=;
	b=Kw6k5gqlxVb4tTw7eybntuzrglJgXXoAeXDubh2lcDEH+29Xs1ZVLHwJRxp4OqVReeoYxZ
	yzZPUe+d80rSYbEqRNwEwO+2QijmU4bLF0e/wnCWGuggg1nYKSQA6p2le2p52L8nWqBE+q
	xHQWw0FEPYKBJkXdY5h0vv3Vkb2vaD0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E6E713A32;
	Tue, 22 Jul 2025 23:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60jAIogdgGgHNgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 22 Jul 2025 23:23:52 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.17
Date: Wed, 23 Jul 2025 01:23:47 +0200
Message-ID: <cover.1753226358.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 963DB218C8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Hi,

there's are number of usability and feature updates, scattered
performance improvements and fixes.  Highlight of the core changes is
getting closer to enabling large folios (now behind a config option).

Please pull, thanks.

User visible changes:

- update defrag ioctl, add new flag to request no compression on
  existing extents

- restrict writes to block devices after mount

- in experimental config, enable large folios for data, almost complete
  but not widely tested

- add stats tracking duration of critical section in transaction commit
  to /sys/fs/btrfs/FSID/commit_stats

Performance improvements:

- caching of lookup results of free space bitmap (20% runtime
  improvement on an empty file creation benchmark)

- accessors to metadata (b-tree items) simplified and optimized, minor
  improvement in metadata-heavy workloads

- readahead on compressed data improves sequential read

- the xarray for extent buffers is indexed by denser keys, leading to
  better packing of the nodes (50-70% reduction of leaf nodes)

Notable fixes:

- stricter compression mount option parsing

- send properly emits fallocate command for file holes when protocol v2
  is used

- fix overallocation of chunks with mount option 'ssd_spread', due to
  interaction with size classes not finding the right chunk (workaround:
  manual reclaim by 'usage' balance filter)

- various quota enable/disable races with rescan, more verbose
  notifications about inconsistent state

- populate otime in tree-log during log replay

- handle ENOSPC when NOCOW file is used with mmap()

Core:

- large data folios enabled in experimental config

- improved error handling, transaction abort call sites

- in zoned mode, allocate reloc block group on mount to make sure
  there's always one available for zone reclaim under heavy load

- rework device opening, they're always open as read-only and delayed
  until the super block is created, allowing the restricted writes after
  mount

- preparatory work for adding blk_holder_ops, allowing device
  freeze/thaw in the future

Cleanups, refactoring:

- type and naming unifications (int/bool, return variables)

- rb-tree helper refactoring and simplifications

- reorder memory allocations to less critical places

- RCU string (used for device name) refactoring and API removal

- replace all remaining use of strcpy()

----------------------------------------------------------------
The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-tag

for you to fetch changes up to 005b0a0c24e1628313e951516b675109a92cacfe:

  btrfs: send: use fallocate for hole punching with send stream v2 (2025-07-22 01:23:14 +0200)

----------------------------------------------------------------
Al Viro (1):
      btrfs: open code fc_mount() to avoid releasing s_umount rw_sempahore

Boris Burkov (3):
      btrfs: sysfs: track current commit duration in commit_stats
      btrfs: use readahead_expand() on compressed extents
      btrfs: fix ssd_spread overallocation

Brahmajit Das (1):
      btrfs: replace strcpy() with strscpy()

Caleb Sander Mateos (1):
      btrfs: don't skip accounting in early ENOTTY return in btrfs_uring_encoded_read()

Christoph Hellwig (3):
      btrfs: always open the device read-only in btrfs_scan_one_device()
      btrfs: call btrfs_close_devices() from ->kill_sb
      btrfs: use the super_block as holder when mounting file systems

Dan Johnson (1):
      btrfs: fix comment in reserved space warning

Daniel Vacek (4):
      btrfs: relocation: simplify unused logic related to LINK_LOWER
      btrfs: factor out compression mount options parsing
      btrfs: harden parsing of compression mount options
      btrfs: index buffer_tree using node size

David Sterba (73):
      btrfs: move transaction aborts to the error site in remove_block_group_free_space()
      btrfs: move transaction aborts to the error site in add_block_group_free_space()
      btrfs: constify more pointer parameters
      btrfs: rename err to ret2 in resolve_indirect_refs()
      btrfs: rename err to ret2 in read_block_for_search()
      btrfs: rename err to ret2 in search_leaf()
      btrfs: rename err to ret2 in btrfs_search_slot()
      btrfs: rename err to ret2 in btrfs_search_old_slot()
      btrfs: rename err to ret2 in btrfs_setsize()
      btrfs: rename err to ret2 in btrfs_add_link()
      btrfs: rename err to ret2 in btrfs_truncate_inode_items()
      btrfs: rename err to ret in btrfs_try_lock_extent_bits()
      btrfs: rename err to ret in btrfs_lock_extent_bits()
      btrfs: rename err to ret in btrfs_alloc_from_bitmap()
      btrfs: rename err to ret in btrfs_init_inode_security()
      btrfs: rename err to ret in btrfs_setattr()
      btrfs: rename err to ret in btrfs_link()
      btrfs: rename err to ret in btrfs_symlink()
      btrfs: rename err to ret in calc_pct_ratio()
      btrfs: rename err to ret in btrfs_fill_super()
      btrfs: rename err to ret in quota_override_store()
      btrfs: rename err to ret in btrfs_wait_extents()
      btrfs: rename err to ret in btrfs_wait_tree_log_extents()
      btrfs: rename err to ret in btrfs_create_common()
      btrfs: rename err to ret in scrub_submit_extent_sector_read()
      btrfs: use on-stack variable for block reserve in btrfs_evict_inode()
      btrfs: use on-stack variable for block reserve in btrfs_truncate()
      btrfs: use on-stack variable for block reserve in btrfs_replace_file_extents()
      btrfs: use btrfs_is_data_reloc_root() where not done yet
      btrfs: use btrfs_root_id() where not done yet
      btrfs: open code rcu_string_free() and remove it
      btrfs: remove unused rcu-string printk helpers
      btrfs: remove unused levels of message helpers
      btrfs: switch all message helpers to be RCU safe
      btrfs: switch RCU helper versions to btrfs_err()
      btrfs: switch RCU helper versions to btrfs_warn()
      btrfs: switch RCU helper versions to btrfs_info()
      btrfs: switch RCU helper versions to btrfs_debug()
      btrfs: remove remaining unused message helpers
      btrfs: simplify debug print helpers without enabled printk
      btrfs: merge btrfs_printk_ratelimited() and its only caller
      btrfs: simplify range end calculations in truncate_block_zero_beyond_eof()
      btrfs: rename variables for locked range in defrag_prepare_one_folio()
      btrfs: add helper folio_end()
      btrfs: use folio_end() where appropriate
      btrfs: tree-log: add and rename extent bits for dirty_log_pages tree
      btrfs: rename error to ret in btrfs_may_delete()
      btrfs: rename error to ret in btrfs_mksubvol()
      btrfs: rename error to ret in btrfs_sysfs_add_fsid()
      btrfs: rename error to ret in btrfs_sysfs_add_mounted()
      btrfs: rename error to ret in device_list_add()
      btrfs: use our message helpers instead of pr_err/pr_warn/pr_info
      btrfs: use pgoff_t for page index variables
      btrfs: don't use token set/get accessors for btrfs_item members
      btrfs: don't use token set/get accessors in inode.c:fill_inode_item()
      btrfs: tree-log: don't use token set/get accessors in fill_inode_item()
      btrfs: accessors: delete token versions of set/get helpers
      btrfs: use struct qstr for subvolume ioctl helpers
      btrfs: pass dentry to btrfs_mksubvol() and btrfs_mksnapshot()
      btrfs: pass bool to indicate subvolume/snapshot creation type
      btrfs: rename inode number parameter passed to btrfs_check_dir_item_collision()
      btrfs: open code RCU for device name
      btrfs: remove struct rcu_string
      btrfs: accessors: simplify folio bounds checks
      btrfs: accessors: use type sizeof constants directly
      btrfs: accessors: inline eb bounds check and factor out the error report
      btrfs: accessors: compile-time fast path for u8
      btrfs: accessors: compile-time fast path for u16
      btrfs: accessors: set target address at initialization
      btrfs: accessors: factor out split memcpy with two sources
      btrfs: accessors: rename variable for folio offset
      btrfs: use clear_and_wake_up_bit() where open coded
      btrfs: defrag: add flag to force no-compression

Dmitry Antipov (1):
      btrfs: send: avoid extra calls to strlen() in gen_unique_name()

Filipe Manana (79):
      btrfs: unfold transaction aborts at btrfs_create_new_inode()
      btrfs: unfold transaction abort at __btrfs_inc_extent_ref()
      btrfs: unfold transaction abort at walk_up_proc()
      btrfs: remove pointless 'out' label from clone_finish_inode_update()
      btrfs: unfold transaction abort at clone_copy_inline_extent()
      btrfs: unfold transaction aborts when replaying log trees
      btrfs: abort transaction during log replay if walk_log_tree() failed
      btrfs: remove redundant path release when replaying a log tree
      btrfs: simplify error detection flow during log replay
      btrfs: unfold transaction abort at btrfs_copy_root()
      btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
      btrfs: unfold transaction abort at __btrfs_update_delayed_inode()
      btrfs: unfold transaction abort at btrfs_insert_one_raid_extent()
      btrfs: assert we join log transaction at btrfs_del_inode_ref_in_log()
      btrfs: free path sooner at __btrfs_unlink_inode()
      btrfs: use btrfs_del_item() at del_logged_dentry()
      btrfs: assert we join log transaction at btrfs_del_dir_entries_in_log()
      btrfs: allocate path earlier at btrfs_del_dir_entries_in_log()
      btrfs: allocate path earlier at btrfs_log_new_name()
      btrfs: allocate scratch eb earlier at btrfs_log_new_name()
      btrfs: pass NULL index to btrfs_del_inode_ref() where not needed
      btrfs: switch del_all argument of replay_dir_deletes() from int to bool
      btrfs: make btrfs_delete_delayed_insertion_item() return a boolean
      btrfs: add details to error messages at btrfs_delete_delayed_dir_index()
      btrfs: make btrfs_should_delete_dir_index() return a bool instead
      btrfs: make btrfs_readdir_delayed_dir_index() return a bool instead
      btrfs: reorganize logic at free_extent_buffer() for better readability
      btrfs: add comment for optimization in free_extent_buffer()
      btrfs: use refcount_t type for the extent buffer reference counter
      btrfs: always abort transaction on failure to add block group to free space tree
      btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at __add_block_group_free_space()
      btrfs: remove pointless out label from add_new_free_space_info()
      btrfs: remove pointless out label from update_free_space_extent_count()
      btrfs: make extent_buffer_test_bit() return a boolean instead
      btrfs: make free_space_test_bit() return a boolean instead
      btrfs: remove pointless out label from modify_free_space_bitmap()
      btrfs: remove pointless out label from remove_free_space_extent()
      btrfs: remove pointless out label from add_free_space_extent()
      btrfs: remove pointless out label from load_free_space_bitmaps()
      btrfs: remove pointless out label from load_free_space_extents()
      btrfs: add btrfs prefix to free space tree exported functions
      btrfs: rename free_space_set_bits() and make it less confusing
      btrfs: turn remove argument of modify_free_space_bitmap() to boolean
      btrfs: avoid double slot decrement at btrfs_convert_free_space_to_extents()
      btrfs: use fs_info from local variable in btrfs_convert_free_space_to_extents()
      btrfs: add and use helper to determine if using bitmaps in free space tree
      btrfs: cache if we are using free space bitmaps for a block group
      btrfs: use inode already stored in local variable at btrfs_rmdir()
      btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BTRFS_I()
      btrfs: split inode ref processing from __add_inode_ref() into a helper
      btrfs: split inode extref processing from __add_inode_ref() into a helper
      btrfs: add btrfs prefix to is_fstree() and make it return bool
      btrfs: split btrfs_is_fstree() into multiple if statements for readability
      btrfs: qgroup: remove pointless error check for add_qgroup_rb() call
      btrfs: qgroup: avoid memory allocation if qgroups are not enabled
      btrfs: clear dirty status from extent buffer on error at insert_new_root()
      btrfs: qgroup: fix race between quota disable and quota rescan ioctl
      btrfs: qgroup: remove no longer used fs_info->qgroup_ulist
      btrfs: qgroup: set quota enabled bit if quota disable fails flushing reservations
      btrfs: qgroup: fix qgroup create ioctl returning success after quotas disabled
      btrfs: qgroup: use btrfs_qgroup_enabled() in ioctls
      btrfs: avoid logging tree mod log elements for irrelevant extent buffers
      btrfs: reduce size of struct tree_mod_elem
      btrfs: set search_commit_root to false in iterate_inodes_from_logical()
      btrfs: send: directly return strcmp() result when comparing recorded refs
      btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
      btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
      btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()
      btrfs: update function comment for btrfs_check_nocow_lock()
      btrfs: assert we can NOCOW the range in btrfs_truncate_block()
      btrfs: make btrfs_check_nocow_lock() check more than one extent
      btrfs: set EXTENT_NORESERVE before range unlock in btrfs_truncate_block()
      btrfs: use cached state when falling back from NOCoW write to CoW write
      btrfs: remove btrfs_clear_extent_bits()
      btrfs: don't ignore inode missing when replaying log tree
      btrfs: don't skip remaining extrefs if dir not found during log replay
      btrfs: use saner variable type and name to indicate extrefs at add_inode_ref()
      btrfs: unfold transaction aborts when writing dirty block groups
      btrfs: send: use fallocate for hole punching with send stream v2

George Hu (1):
      btrfs: replace nested usage of min & max with clamp in btrfs_compress_set_level()

Johannes Thumshirn (6):
      btrfs: zoned: use filesystem size not disk size for reclaim decision
      btrfs: make btrfs_should_periodic_reclaim() static
      btrfs: zoned: reserve data_reloc block group on mount
      btrfs: change dump_block_groups() in btrfs_dump_space_info() from int to bool
      btrfs: remove redundant auto reclaim log message
      btrfs: don't print relocation messages from auto reclaim

Naohiro Aota (2):
      btrfs: zoned: do not remove unwritten non-data block group
      btrfs: zoned: requeue to unused block group list if zone finish failed

Pan Chuang (2):
      btrfs: pass struct rb_simple_node pointer directly in rb_simple_insert()
      btrfs: use rb_find_add() in rb_simple_insert()

Qianfeng Rong (1):
      btrfs: use folio_next_index() helper in check_range_has_page()

Qu Wenruo (14):
      btrfs: add comments on the extra btrfs specific subpage bitmaps
      btrfs: rename btrfs_subpage structure
      btrfs: enable large data folio support under CONFIG_BTRFS_EXPERIMENTAL
      btrfs: add extra warning when qgroup is marked inconsistent
      btrfs: get rid of re-entering of btrfs_get_tree()
      btrfs: add assertions to make super block creation more clear
      btrfs: call bdev_fput() to reclaim the blk_holder immediately
      btrfs: delay btrfs_open_devices() until super block is created
      btrfs: use fs_holder_ops for all opened devices
      btrfs: restrict writes to opened btrfs devices
      btrfs: populate otime when logging an inode item
      btrfs: reloc: unconditionally invalidate the page cache for each cluster
      btrfs: output more info when btrfs_subpage_assert() failed
      btrfs: enable large data folios for data reloc inode

Sun YangKai (3):
      btrfs: update comment for xarray fields in struct btrfs_root
      btrfs: remove unused parameters from btrfs_lookup_inode_extref()
      btrfs: remove partial support for lowest level from btrfs_search_forward()

Yangtao Li (13):
      btrfs: use rb_find_add() in btrfs_insert_inode_defrag()
      btrfs: use rb_find() in __btrfs_lookup_delayed_item()
      btrfs: use rb_find() in ulist_rbtree_search()
      btrfs: use rb_find_add() in ulist_rbtree_insert()
      btrfs: use rb_find() in lookup_block_entry()
      btrfs: use rb_find_add() in insert_block_entry()
      btrfs: use rb_find() in lookup_root_entry()
      btrfs: use rb_find_add() in insert_root_entry()
      btrfs: use rb_find_add() in insert_ref_entry()
      btrfs: use rb_find() in find_qgroup_rb()
      btrfs: use rb_find_add() in add_qgroup_rb()
      btrfs: use rb_find() in btrfs_qgroup_trace_subtree_after_cow()
      btrfs: use rb_find_add() in btrfs_qgroup_add_swapped_blocks()

 fs/btrfs/Kconfig                       |   2 +
 fs/btrfs/accessors.c                   | 162 ++++-------
 fs/btrfs/accessors.h                   |  37 ---
 fs/btrfs/backref.c                     |  47 ++--
 fs/btrfs/backref.h                     |  23 +-
 fs/btrfs/bio.c                         |  24 +-
 fs/btrfs/block-group.c                 |  86 +++---
 fs/btrfs/block-group.h                 |   5 +
 fs/btrfs/btrfs_inode.h                 |  13 +
 fs/btrfs/compression.c                 |  24 +-
 fs/btrfs/compression.h                 |   9 +-
 fs/btrfs/ctree.c                       | 199 +++++++-------
 fs/btrfs/ctree.h                       |  35 ++-
 fs/btrfs/defrag.c                      |  80 +++---
 fs/btrfs/delayed-inode.c               | 106 +++----
 fs/btrfs/delayed-inode.h               |   7 +-
 fs/btrfs/delayed-ref.c                 |  10 +-
 fs/btrfs/delayed-ref.h                 |   6 +-
 fs/btrfs/dev-replace.c                 |  18 +-
 fs/btrfs/dir-item.c                    |   4 +-
 fs/btrfs/dir-item.h                    |   2 +-
 fs/btrfs/disk-io.c                     |  21 +-
 fs/btrfs/extent-io-tree.c              |  20 +-
 fs/btrfs/extent-io-tree.h              |   9 +-
 fs/btrfs/extent-tree.c                 | 134 ++++-----
 fs/btrfs/extent-tree.h                 |   2 +-
 fs/btrfs/extent_io.c                   | 188 +++++++------
 fs/btrfs/extent_io.h                   |   6 +-
 fs/btrfs/extent_map.c                  |   6 +-
 fs/btrfs/fiemap.c                      |   2 +-
 fs/btrfs/file-item.c                   |   2 +-
 fs/btrfs/file.c                        | 178 +++++++-----
 fs/btrfs/free-space-cache.c            |   8 +-
 fs/btrfs/free-space-tree.c             | 375 +++++++++++++------------
 fs/btrfs/free-space-tree.h             |  52 ++--
 fs/btrfs/fs.h                          |  13 +-
 fs/btrfs/inode-item.c                  |  24 +-
 fs/btrfs/inode-item.h                  |  11 +-
 fs/btrfs/inode.c                       | 381 +++++++++++++-------------
 fs/btrfs/ioctl.c                       | 133 ++++-----
 fs/btrfs/messages.h                    | 107 ++------
 fs/btrfs/misc.h                        |  38 +--
 fs/btrfs/ordered-data.c                |   2 +-
 fs/btrfs/print-tree.c                  |   4 +-
 fs/btrfs/qgroup.c                      | 362 ++++++++++++------------
 fs/btrfs/raid-stripe-tree.c            |   7 +-
 fs/btrfs/rcu-string.h                  |  58 ----
 fs/btrfs/ref-verify.c                  | 146 +++++-----
 fs/btrfs/ref-verify.h                  |   4 +-
 fs/btrfs/reflink.c                     |  24 +-
 fs/btrfs/relocation.c                  | 140 ++++------
 fs/btrfs/relocation.h                  |   3 +-
 fs/btrfs/scrub.c                       |  26 +-
 fs/btrfs/send.c                        |  47 +++-
 fs/btrfs/space-info.c                  |  14 +-
 fs/btrfs/space-info.h                  |   3 +-
 fs/btrfs/subpage.c                     | 247 ++++++++---------
 fs/btrfs/subpage.h                     |  59 ++--
 fs/btrfs/super.c                       | 291 +++++++++++---------
 fs/btrfs/sysfs.c                       |  78 +++---
 fs/btrfs/tests/extent-io-tests.c       |  28 +-
 fs/btrfs/tests/free-space-tree-tests.c |  93 +++----
 fs/btrfs/tests/inode-tests.c           |  24 +-
 fs/btrfs/transaction.c                 |  48 ++--
 fs/btrfs/tree-checker.c                |  12 +-
 fs/btrfs/tree-log.c                    | 485 +++++++++++++++++++--------------
 fs/btrfs/tree-mod-log.c                |  77 ++++--
 fs/btrfs/ulist.c                       |  55 ++--
 fs/btrfs/volumes.c                     | 132 ++++-----
 fs/btrfs/volumes.h                     |  38 ++-
 fs/btrfs/xattr.c                       |   9 +-
 fs/btrfs/zoned.c                       | 115 ++++++--
 fs/btrfs/zoned.h                       |   3 +
 fs/btrfs/zstd.c                        |   3 +-
 include/trace/events/btrfs.h           |   5 +-
 include/uapi/linux/btrfs.h             |   3 +
 76 files changed, 2634 insertions(+), 2620 deletions(-)
 delete mode 100644 fs/btrfs/rcu-string.h

