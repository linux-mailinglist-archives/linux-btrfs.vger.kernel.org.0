Return-Path: <linux-btrfs+bounces-1272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849A5825AE8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 20:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F24A1F23BA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E735F05;
	Fri,  5 Jan 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TiY+DajG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TiY+DajG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1435EF3;
	Fri,  5 Jan 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18C421F8B3;
	Fri,  5 Jan 2024 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704481446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=eMG+dLQCXvidlTTg8O92qT268IeVX8E990nQkSfGYF8=;
	b=TiY+DajGiWyQQ4L213F3AQq/TerVwcQR7Pb5EbsNeibbbZ7mAoUiQe0ppH1JyJGcZJU/0M
	irw00jlL3xh/1tnul2Aill0HrBh/cLI9PJnTzjIuCl6SJnOLaeItT38r2cEX4akLpQs8ko
	xzm7R4iVcmXVRVSDmNYNtHQtpzCEqBM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704481446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=eMG+dLQCXvidlTTg8O92qT268IeVX8E990nQkSfGYF8=;
	b=TiY+DajGiWyQQ4L213F3AQq/TerVwcQR7Pb5EbsNeibbbZ7mAoUiQe0ppH1JyJGcZJU/0M
	irw00jlL3xh/1tnul2Aill0HrBh/cLI9PJnTzjIuCl6SJnOLaeItT38r2cEX4akLpQs8ko
	xzm7R4iVcmXVRVSDmNYNtHQtpzCEqBM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E01B3136F5;
	Fri,  5 Jan 2024 19:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ya0rNqVSmGWRZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 05 Jan 2024 19:04:05 +0000
Date: Fri, 5 Jan 2024 20:03:53 +0100
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.8
Message-ID: <cover.1704481157.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi,

there are no exciting changes for users, it's been mostly API
conversions and some fixes or refactoring.  The mount API conversion is
a base for future improvements that would come with VFS. Metadata
processing has been converted to folios, not yet enabling the large
folios but it's one patch away once everything gets tested enough.

There are possible minor merge conflicts reported by linux-next.
Please pull, thanks.

Core changes:

- convert extent buffers to folios
  - direct API conversion where possible
  - performance can drop by a few percent on metadata heavy workloads,
    the folio sizes are not constant and the calculations add up in the
    item helpers
  - both regular and subpage modes
  - data cannot be converted yet, we need to port that to iomap and
    there are some other generic changes required

- convert mount to the new API, there should be no user visible change
  - options deprecated long time ago have been removed: inode_cache,
    recovery
  - the new logic that splits mount to two phases slightly changes
    timing of device scanning for multi-device filesystems
  - LSM options will now work (like for selinux), previous fix attempt
    https://lore.kernel.org/selinux/20210316144823.2188946-1-omosnace@redhat.com/

- convert delayed nodes radix tree to xarray, preserving the
  preload-like logic that still allows to allocate with GFP_NOFS

- more validation of sysfs value of scrub_speed_max

- refactor chunk map structure, reduce size and improve performance

- extent map refactoring, smaller data structures, improved performance

- reduce size of struct extent_io_tree, embedded in several structures

- temporary pages used for compression are cached and attached to a
  shrinker, this may slightly improve performance

- in zoned mode, remove redirty extent buffer tracking, zeros are
  written in case an out-of-order is detected and proper data are
  written to the actual write pointer

- cleanups, refactoring, error message improvements, updated tests

- verify and update branch name or tag
- remove unwanted text

----------------------------------------------------------------
The following changes since commit 3f7168591ebf7bbdb91797d02b1afaf00a4289b1:

  Merge tag '6.7-rc5-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2023-12-14 19:57:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-tag

for you to fetch changes up to e94dfb7a2935cb91faca88bf7136177d1ce0dda8:

  btrfs: pass btrfs_io_geometry into btrfs_max_io_len (2023-12-15 23:03:59 +0100)

----------------------------------------------------------------
Christian Brauner (1):
      fs: indicate request originates from old mount API

David Disseldorp (1):
      btrfs: sysfs: validate scrub_speed_max value

David Sterba (15):
      btrfs: use page alloc/free wrappers for compression pages
      btrfs: use shrinker for compression page pool
      btrfs: scrub: remove unused scrub_ctx::sectors_per_bio
      btrfs: remove unused btrfs_ordered_extent::outstanding_isize
      btrfs: raid56: remove unused btrfs_plug_cb::work
      btrfs: remove unused definition of tree_entry in extent-io-tree.c
      btrfs: remove unused btrfs_root::type
      btrfs: move lockdep class setting out of extent_io_tree_init
      btrfs: drop error message in extent_io_tree insert_state()
      btrfs: constify fs_info parameter in __btrfs_panic()
      btrfs: enhance extent_io_tree error reports
      btrfs: always set extent_io_tree::inode and drop fs_info
      btrfs: allocate btrfs_inode::file_extent_tree only without NO_HOLES
      btrfs: fix typos found by codespell
      btrfs: switch btrfs_root::delayed_nodes_tree to xarray from radix-tree

Filipe Manana (22):
      btrfs: remove duplicate btrfs_clear_buffer_dirty() prototype from disk-io.h
      btrfs: remove log_extents_lock and logged_list from struct btrfs_root
      btrfs: use bool for return type of btrfs_block_can_be_shared()
      btrfs: make the logic from btrfs_block_can_be_shared() easier to read
      btrfs: mark sanity checks when getting chunk map as unlikely
      btrfs: split assert into two different asserts when removing block group
      btrfs: unexport extent_map_block_end()
      btrfs: use btrfs_next_item() at scrub.c:find_first_extent_item()
      btrfs: use a dedicated data structure for chunk maps
      btrfs: remove stripe size local variable from insert_dev_extents()
      btrfs: remove no longer used EXTENT_MAP_DELALLOC block start value
      btrfs: assert extent map is not in a list when setting it up
      btrfs: tests: fix error messages for test case 4 of extent map tests
      btrfs: tests: do not ignore NULL extent maps for extent maps tests
      btrfs: tests: print all values as decimal in messages for extent map tests
      btrfs: unexport add_extent_mapping()
      btrfs: remove redundant value assignment at btrfs_add_extent_mapping()
      btrfs: log messages at unpin_extent_range() during unexpected cases
      btrfs: avoid useless rbtree iterations when attempting to merge extent map
      btrfs: make extent_map_end() argument const
      btrfs: refactor mergable_maps() for more readability
      btrfs: use the flags of an extent map to identify the compression type

Johannes Thumshirn (18):
      btrfs: rename EXTENT_BUFFER_NO_CHECK to EXTENT_BUFFER_ZONED_ZEROOUT
      btrfs: zoned: don't clear dirty flag of extent buffer
      btrfs: remove now unneeded btrfs_redirty_list_add
      btrfs: use memset_page instead of opencoding it
      btrfs: reflow btrfs_free_tree_block
      btrfs: factor out helper for single device IO check
      btrfs: re-introduce struct btrfs_io_geometry
      btrfs: factor out block-mapping for RAID0
      btrfs: factor out RAID1 block mapping
      btrfs: factor out block mapping for DUP profiles
      btrfs: factor out block mapping for RAID10
      btrfs: reduce scope of data_stripes in btrfs_map_block
      btrfs: factor out block mapping for RAID5/6
      btrfs: factor out block mapping for single profiles
      btrfs: change block mapping to switch/case in btrfs_map_block
      btrfs: open code set_io_stripe for RAID56
      btrfs: pass struct btrfs_io_geometry to set_io_stripe
      btrfs: pass btrfs_io_geometry into btrfs_max_io_len

Josef Bacik (20):
      btrfs: split out the mount option validation code into its own helper
      btrfs: set default compress type at btrfs_init_fs_info time
      btrfs: move space cache settings into open_ctree
      btrfs: do not allow free space tree rebuild on extent tree v2
      btrfs: split out ro->rw and rw->ro helpers into their own functions
      btrfs: add a NOSPACECACHE mount option flag
      btrfs: add fs_parameter definitions
      btrfs: add parse_param callback for the new mount API
      btrfs: add fs context handling functions
      btrfs: add reconfigure callback for fs_context
      btrfs: add get_tree callback for new mount API
      btrfs: handle the ro->rw transition for mounting different subvolumes
      btrfs: switch to the new mount API
      btrfs: move the device specific mount options to super.c
      btrfs: remove old mount API code
      btrfs: move one shot mount option clearing to super.c
      btrfs: set clear_cache if we use usebackuproot
      btrfs: remove code for inode_cache and recovery mount options
      btrfs: cache that we don't have security.capability set
      btrfs: don't double put our subpage reference in alloc_extent_buffer

Qu Wenruo (12):
      btrfs: do not utilize goto to implement delayed inode ref deletion
      btrfs: migrate to use folio private instead of page private
      btrfs: allow extent buffer helpers to skip cross-page handling
      btrfs: fix mismatching parameter names for btrfs_get_extent()
      btrfs: refactor alloc_extent_buffer() to allocate-then-attach method
      btrfs: migrate extent_buffer::pages[] to folio
      btrfs: cleanup metadata page pointer usage
      btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios
      btrfs: migrate subpage code to folio interfaces
      btrfs: migrate various end io functions to folios
      btrfs: migrate eb_bitmap_offset() to folio interfaces
      btrfs: migrate btrfs_repair_io_failure() to folio interfaces

 fs/btrfs/accessors.c              |   98 +-
 fs/btrfs/accessors.h              |    4 +-
 fs/btrfs/bio.c                    |   17 +-
 fs/btrfs/bio.h                    |    4 +-
 fs/btrfs/block-group.c            |  167 ++-
 fs/btrfs/block-group.h            |    6 +-
 fs/btrfs/btrfs_inode.h            |   10 +-
 fs/btrfs/compression.c            |  139 ++-
 fs/btrfs/compression.h            |    5 +
 fs/btrfs/ctree.c                  |   63 +-
 fs/btrfs/ctree.h                  |   17 +-
 fs/btrfs/defrag.c                 |   13 +-
 fs/btrfs/delayed-inode.c          |  109 +-
 fs/btrfs/dev-replace.c            |   28 +-
 fs/btrfs/disk-io.c                |  155 ++-
 fs/btrfs/disk-io.h                |    3 -
 fs/btrfs/extent-io-tree.c         |  123 +-
 fs/btrfs/extent-io-tree.h         |   18 +-
 fs/btrfs/extent-tree.c            |  112 +-
 fs/btrfs/extent_io.c              | 1051 ++++++++++-------
 fs/btrfs/extent_io.h              |   80 +-
 fs/btrfs/extent_map.c             |  189 ++-
 fs/btrfs/extent_map.h             |   77 +-
 fs/btrfs/file-item.c              |   15 +-
 fs/btrfs/file.c                   |   27 +-
 fs/btrfs/free-space-cache.c       |    4 +-
 fs/btrfs/fs.h                     |   18 +-
 fs/btrfs/inode.c                  |  153 ++-
 fs/btrfs/lru_cache.c              |    2 +-
 fs/btrfs/lzo.c                    |    4 +-
 fs/btrfs/messages.c               |    2 +-
 fs/btrfs/messages.h               |    2 +-
 fs/btrfs/ordered-data.c           |    5 +-
 fs/btrfs/ordered-data.h           |    7 -
 fs/btrfs/qgroup.c                 |    2 +-
 fs/btrfs/raid56.c                 |    7 +-
 fs/btrfs/raid56.h                 |    2 +-
 fs/btrfs/reflink.c                |    6 +-
 fs/btrfs/relocation.c             |    7 +-
 fs/btrfs/scrub.c                  |   63 +-
 fs/btrfs/subpage.c                |  371 +++---
 fs/btrfs/subpage.h                |   82 +-
 fs/btrfs/super.c                  | 2351 +++++++++++++++++++------------------
 fs/btrfs/super.h                  |    5 +-
 fs/btrfs/sysfs.c                  |    4 +
 fs/btrfs/tests/btrfs-tests.c      |    5 +-
 fs/btrfs/tests/btrfs-tests.h      |    1 +
 fs/btrfs/tests/extent-io-tests.c  |    4 +-
 fs/btrfs/tests/extent-map-tests.c |  143 +--
 fs/btrfs/tests/inode-tests.c      |   60 +-
 fs/btrfs/tree-checker.h           |    2 +-
 fs/btrfs/tree-log.c               |   17 +-
 fs/btrfs/volumes.c                |  934 +++++++++------
 fs/btrfs/volumes.h                |   47 +-
 fs/btrfs/xattr.c                  |   55 +-
 fs/btrfs/zlib.c                   |    6 +-
 fs/btrfs/zoned.c                  |   66 +-
 fs/btrfs/zoned.h                  |   12 +-
 fs/btrfs/zstd.c                   |    7 +-
 fs/namespace.c                    |   11 +
 include/trace/events/btrfs.h      |   78 +-
 61 files changed, 3885 insertions(+), 3190 deletions(-)

