Return-Path: <linux-btrfs+bounces-2026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58C845EC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C9BB2841A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3D74275;
	Thu,  1 Feb 2024 17:41:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B474276
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809289; cv=none; b=URLUlKHvjlvTBNTJ1EmfGIYuoXHKD1AU1Z9bHOYoTt0Jy21PN3U0Omj67gOExWa/MRET05KEm2V6/w90QSlu7Cq8t13TK+oylBM1ez/Z2u3UbHYa/Z7QI3jtfkasCCLQahCsx99B4pr66jQxEHjhjqFLl1zxTdhHmMH7hdfs0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809289; c=relaxed/simple;
	bh=LyBh1HS2vmFQewLRi9lifz4W7424QBUVleNO4pDDk4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7SRMQTtKhPamnbPrP9y9FWBgq/hmXXZotdwCqA0TJt2Rn5TxGDjB3N458SesoP/eI1RfLFETGJpNTmWlqSp0YcHB25f21cEtXhXAq40LgbuErqMSd8RONON55zHeOcVuCZcYDRwiQqlPoRRuLbHFO6B9N1yRzE1buOC+JGznD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7DB521EB6;
	Thu,  1 Feb 2024 17:41:23 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E0ED413594;
	Thu,  1 Feb 2024 17:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id A8rnNsPXu2WZSwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 17:41:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: add forward declarations and headers, part 2
Date: Thu,  1 Feb 2024 18:40:58 +0100
Message-ID: <1d2cddb3f392eb925237243082d02ac5b10579f1.1706808903.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706808903.git.dsterba@suse.com>
References: <cover.1706808903.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E7DB521EB6
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Do a cleanup in more headers:

- add forward declarations for types referenced by pointers
- add includes when types need them

This fixes potential compilation problems if the headers are reordered
or the missing includes are not provided indirectly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.h              |  2 ++
 fs/btrfs/block-rsv.h        |  7 +++++++
 fs/btrfs/compression.h      | 10 ++++++++--
 fs/btrfs/delayed-inode.h    |  8 ++++++++
 fs/btrfs/disk-io.h          | 16 ++++++++++++----
 fs/btrfs/extent-io-tree.h   |  7 +++++++
 fs/btrfs/extent-tree.h      |  9 +++++++++
 fs/btrfs/extent_io.h        | 25 ++++++++++++++++++++-----
 fs/btrfs/extent_map.h       |  7 +++++++
 fs/btrfs/file-item.h        | 11 +++++++++++
 fs/btrfs/free-space-cache.h | 13 +++++++++++++
 fs/btrfs/free-space-tree.h  |  6 ++++++
 fs/btrfs/inode-item.h       |  5 +++--
 fs/btrfs/locking.h          |  8 ++++++--
 fs/btrfs/lru_cache.h        |  2 ++
 fs/btrfs/misc.h             |  2 ++
 fs/btrfs/ordered-data.h     | 13 +++++++++++++
 fs/btrfs/raid56.h           |  9 +++++++++
 fs/btrfs/send.h             |  8 +++++---
 fs/btrfs/space-info.h       |  9 +++++++++
 fs/btrfs/subpage.h          |  5 +++++
 fs/btrfs/transaction.h      | 17 ++++++++++++++++-
 fs/btrfs/tree-checker.h     |  2 ++
 fs/btrfs/tree-log.h         |  8 ++++++++
 fs/btrfs/ulist.h            |  1 +
 fs/btrfs/zoned.h            | 15 +++++++++++++++
 26 files changed, 206 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index bbaed317161a..d9dd5276093d 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -7,12 +7,14 @@
 #ifndef BTRFS_BIO_H
 #define BTRFS_BIO_H
 
+#include <linux/types.h>
 #include <linux/bio.h>
 #include <linux/workqueue.h>
 #include "tree-checker.h"
 
 struct btrfs_bio;
 struct btrfs_fs_info;
+struct btrfs_inode;
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
 
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index b0bd12b8652f..b621199b0130 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -3,8 +3,15 @@
 #ifndef BTRFS_BLOCK_RSV_H
 #define BTRFS_BLOCK_RSV_H
 
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/spinlock.h>
+
 struct btrfs_trans_handle;
 struct btrfs_root;
+struct btrfs_space_info;
+struct btrfs_block_rsv;
+struct btrfs_fs_info;
 enum btrfs_reserve_flush_enum;
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index da7bf570d9a0..a31e8fc938ac 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -7,10 +7,18 @@
 #define BTRFS_COMPRESSION_H
 
 #include <linux/sizes.h>
+#include <linux/mm.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
 #include "bio.h"
 
+struct address_space;
+struct page;
+struct inode;
 struct btrfs_inode;
 struct btrfs_ordered_extent;
+struct btrfs_bio;
 
 /*
  * We want to make sure that amount of RAM required to uncompress an extent is
@@ -32,8 +40,6 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 
 #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
 
-struct page;
-
 struct compressed_bio {
 	/* Number of compressed folios in the array */
 	unsigned int nr_folios;
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 5cceb31bbd16..3870a4bf7189 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -7,15 +7,23 @@
 #ifndef BTRFS_DELAYED_INODE_H
 #define BTRFS_DELAYED_INODE_H
 
+#include <linux/types.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/wait.h>
+#include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/refcount.h>
 #include "ctree.h"
 
+struct btrfs_disk_key;
+struct btrfs_fs_info;
+struct btrfs_inode;
+struct btrfs_root;
+struct btrfs_trans_handle;
+
 enum btrfs_delayed_item_type {
 	BTRFS_DELAYED_INSERTION_ITEM,
 	BTRFS_DELAYED_DELETION_ITEM
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 21ff41bfe2b5..375f62ae3709 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -7,9 +7,21 @@
 #define BTRFS_DISK_IO_H
 
 #include <linux/sizes.h>
+#include <linux/compiler_types.h>
 #include "ctree.h"
 #include "fs.h"
 
+struct block_device;
+struct super_block;
+struct extent_buffer;
+struct btrfs_device;
+struct btrfs_fs_devices;
+struct btrfs_fs_info;
+struct btrfs_super_block;
+struct btrfs_trans_handle;
+struct btrfs_tree_parent_check;
+struct btrfs_transaction;
+
 #define BTRFS_SUPER_MIRROR_MAX	 3
 #define BTRFS_SUPER_MIRROR_SHIFT 12
 
@@ -29,10 +41,6 @@ static inline u64 btrfs_sb_offset(int mirror)
 	return BTRFS_SUPER_INFO_OFFSET;
 }
 
-struct btrfs_device;
-struct btrfs_fs_devices;
-struct btrfs_tree_parent_check;
-
 void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info);
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ebe6390d65e9..9d3a52d8f59a 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -3,9 +3,16 @@
 #ifndef BTRFS_EXTENT_IO_TREE_H
 #define BTRFS_EXTENT_IO_TREE_H
 
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <linux/refcount.h>
+#include <linux/list.h>
+#include <linux/wait.h>
 #include "misc.h"
 
 struct extent_changeset;
+struct btrfs_fs_info;
+struct btrfs_inode;
 
 /* Bits for the extent state */
 enum {
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 2e066035ccee..3fbcb7776a03 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -3,11 +3,20 @@
 #ifndef BTRFS_EXTENT_TREE_H
 #define BTRFS_EXTENT_TREE_H
 
+#include <linux/types.h>
 #include "misc.h"
 #include "block-group.h"
+#include "locking.h"
 
+struct extent_buffer;
 struct btrfs_free_cluster;
+struct btrfs_fs_info;
+struct btrfs_root;
+struct btrfs_path;
+struct btrfs_disk_key;
 struct btrfs_delayed_ref_head;
+struct btrfs_delayed_ref_root;
+struct btrfs_extent_inline_ref;
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 992a9044fa24..ab5f7df29f12 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -7,12 +7,32 @@
 #include <linux/refcount.h>
 #include <linux/fiemap.h>
 #include <linux/btrfs_tree.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
+#include <linux/rwsem.h>
+#include <linux/list.h>
+#include <linux/slab.h>
 #include "compression.h"
 #include "messages.h"
 #include "ulist.h"
 #include "misc.h"
 
+struct page;
+struct file;
+struct folio;
+struct inode;
+struct fiemap_extent_info;
+struct readahead_control;
+struct address_space;
+struct writeback_control;
+struct extent_io_tree;
+struct extent_map_tree;
+struct btrfs_block_group;
+struct btrfs_fs_info;
+struct btrfs_inode;
+struct btrfs_root;
 struct btrfs_trans_handle;
+struct btrfs_tree_parent_check;
 
 enum {
 	EXTENT_BUFFER_UPTODATE,
@@ -64,11 +84,6 @@ enum {
 #define BITMAP_LAST_BYTE_MASK(nbits) \
 	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
 
-struct btrfs_root;
-struct btrfs_inode;
-struct btrfs_fs_info;
-struct extent_io_tree;
-struct btrfs_tree_parent_check;
 
 int __init extent_buffer_init_cachep(void);
 void __cold extent_buffer_free_cachep(void);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 7fd55cf91f53..c5a098c99cc6 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -3,11 +3,18 @@
 #ifndef BTRFS_EXTENT_MAP_H
 #define BTRFS_EXTENT_MAP_H
 
+#include <linux/compiler_types.h>
+#include <linux/rwlock_types.h>
 #include <linux/rbtree.h>
+#include <linux/list.h>
 #include <linux/refcount.h>
 #include "misc.h"
+#include "extent_map.h"
 #include "compression.h"
 
+struct btrfs_inode;
+struct btrfs_fs_info;
+
 #define EXTENT_MAP_LAST_BYTE ((u64)-4)
 #define EXTENT_MAP_HOLE ((u64)-3)
 #define EXTENT_MAP_INLINE ((u64)-2)
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 606731bef247..15c05cc0fce6 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -3,9 +3,20 @@
 #ifndef BTRFS_FILE_ITEM_H
 #define BTRFS_FILE_ITEM_H
 
+#include <linux/list.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "accessors.h"
 
 struct extent_map;
+struct btrfs_file_extent_item;
+struct btrfs_fs_info;
+struct btrfs_path;
+struct btrfs_bio;
+struct btrfs_trans_handle;
+struct btrfs_root;
+struct btrfs_ordered_sum;
+struct btrfs_path;
+struct btrfs_inode;
 
 #define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
 		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 33b4da3271b1..aa4da36f68dd 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -6,6 +6,19 @@
 #ifndef BTRFS_FREE_SPACE_CACHE_H
 #define BTRFS_FREE_SPACE_CACHE_H
 
+#include <linux/rbtree.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include "fs.h"
+
+struct inode;
+struct page;
+struct btrfs_fs_info;
+struct btrfs_path;
+struct btrfs_trans_handle;
+struct btrfs_trim_block_group;
+
 /*
  * This is the trim state of an extent or bitmap.
  *
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index 6d5551d0ced8..e6c6d6f4f221 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -6,7 +6,13 @@
 #ifndef BTRFS_FREE_SPACE_TREE_H
 #define BTRFS_FREE_SPACE_TREE_H
 
+#include <linux/bits.h>
+
 struct btrfs_caching_control;
+struct btrfs_fs_info;
+struct btrfs_path;
+struct btrfs_block_group;
+struct btrfs_trans_handle;
 
 /*
  * The default size for new free space bitmap items. The last bitmap in a block
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 4337bb26f419..c4aded82709b 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -6,14 +6,15 @@
 #include <linux/types.h>
 #include <linux/crc32c.h>
 
+struct fscrypt_str;
+struct extent_buffer;
 struct btrfs_trans_handle;
 struct btrfs_root;
 struct btrfs_path;
 struct btrfs_key;
 struct btrfs_inode_extref;
 struct btrfs_inode;
-struct extent_buffer;
-struct fscrypt_str;
+struct btrfs_truncate_control;
 
 /*
  * Return this if we need to call truncate_block for the last bit of the
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 7d6ee1e609bf..9576f485a300 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -8,8 +8,14 @@
 
 #include <linux/atomic.h>
 #include <linux/wait.h>
+#include <linux/lockdep.h>
 #include <linux/percpu_counter.h>
 #include "extent_io.h"
+#include "locking.h"
+
+struct extent_buffer;
+struct btrfs_path;
+struct btrfs_root;
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
@@ -157,8 +163,6 @@ enum btrfs_lockdep_trans_states {
 static_assert(BTRFS_NESTING_MAX <= MAX_LOCKDEP_SUBCLASSES,
 	      "too many lock subclasses defined");
 
-struct btrfs_path;
-
 void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
 void btrfs_tree_lock(struct extent_buffer *eb);
 void btrfs_tree_unlock(struct extent_buffer *eb);
diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index 00328c856be6..390a12b61fd2 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -3,8 +3,10 @@
 #ifndef BTRFS_LRU_CACHE_H
 #define BTRFS_LRU_CACHE_H
 
+#include <linux/types.h>
 #include <linux/maple_tree.h>
 #include <linux/list.h>
+#include "lru_cache.h"
 
 /*
  * A cache entry. This is meant to be embedded in a structure of a user of
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 40f2d9f1a17a..dde4904aead9 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_MISC_H
 #define BTRFS_MISC_H
 
+#include <linux/types.h>
+#include <linux/bitmap.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/math64.h>
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 6fc0521000ac..34413fc5b4bd 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -6,8 +6,21 @@
 #ifndef BTRFS_ORDERED_DATA_H
 #define BTRFS_ORDERED_DATA_H
 
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/refcount.h>
+#include <linux/completion.h>
+#include <linux/rbtree.h>
+#include <linux/wait.h>
 #include "async-thread.h"
 
+struct inode;
+struct page;
+struct extent_state;
+struct btrfs_inode;
+struct btrfs_root;
+struct btrfs_fs_info;
+
 struct btrfs_ordered_sum {
 	/*
 	 * Logical start address and length for of the blocks covered by
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 470213688872..0d7b4c2fb6ae 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -7,9 +7,18 @@
 #ifndef BTRFS_RAID56_H
 #define BTRFS_RAID56_H
 
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/bio.h>
+#include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include "volumes.h"
 
+struct page;
+struct sector_ptr;
+struct btrfs_fs_info;
+
 enum btrfs_rbio_ops {
 	BTRFS_RBIO_WRITE,
 	BTRFS_RBIO_READ_REBUILD,
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 4f5509cb1803..dd1c9f02b011 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -8,6 +8,11 @@
 #define BTRFS_SEND_H
 
 #include <linux/types.h>
+#include <linux/sizes.h>
+#include <linux/align.h>
+
+struct inode;
+struct btrfs_ioctl_send_args;
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 /* Conditional support for the upcoming protocol version. */
@@ -25,9 +30,6 @@
 #define BTRFS_SEND_BUF_SIZE_V1				SZ_64K
 #define BTRFS_SEND_BUF_SIZE_V2	ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE)
 
-struct inode;
-struct btrfs_ioctl_send_args;
-
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
 	BTRFS_TLV_U16,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 92c595fed1b0..a733458fd13b 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -4,8 +4,17 @@
 #define BTRFS_SPACE_INFO_H
 
 #include <trace/events/btrfs.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/kobject.h>
+#include <linux/lockdep.h>
+#include <linux/wait.h>
+#include <linux/rwsem.h>
 #include "volumes.h"
 
+struct btrfs_fs_info;
+struct btrfs_block_group;
+
 /*
  * Different levels for to flush space when doing space reservations.
  *
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 793c2b314a58..55fc42db707e 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -4,6 +4,11 @@
 #define BTRFS_SUBPAGE_H
 
 #include <linux/spinlock.h>
+#include <linux/atomic.h>
+
+struct address_space;
+struct folio;
+struct btrfs_fs_info;
 
 /*
  * Extra info for subpapge bitmap.
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 2bf8bbdfd0b3..681109c5f441 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -6,12 +6,27 @@
 #ifndef BTRFS_TRANSACTION_H
 #define BTRFS_TRANSACTION_H
 
+#include <linux/atomic.h>
 #include <linux/refcount.h>
+#include <linux/list.h>
+#include <linux/time64.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
 #include "btrfs_inode.h"
 #include "delayed-ref.h"
-#include "ctree.h"
+#include "extent-io-tree.h"
+#include "block-rsv.h"
+#include "messages.h"
 #include "misc.h"
 
+struct dentry;
+struct inode;
+struct btrfs_pending_snapshot;
+struct btrfs_fs_info;
+struct btrfs_root_item;
+struct btrfs_root;
+struct btrfs_path;
+
 /* Radix-tree tag for roots that are part of the trasaction. */
 #define BTRFS_ROOT_TRANS_TAG			0
 
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 14b9fbe82da4..5c809b50b2d0 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -6,10 +6,12 @@
 #ifndef BTRFS_TREE_CHECKER_H
 #define BTRFS_TREE_CHECKER_H
 
+#include <linux/types.h>
 #include <uapi/linux/btrfs_tree.h>
 
 struct extent_buffer;
 struct btrfs_chunk;
+struct btrfs_key;
 
 /* All the extra info needed to verify the parentness of a tree block. */
 struct btrfs_tree_parent_check {
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index af219e8840d2..254082a189c3 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -6,10 +6,18 @@
 #ifndef BTRFS_TREE_LOG_H
 #define BTRFS_TREE_LOG_H
 
+#include <linux/list.h>
+#include <linux/fs.h>
 #include "messages.h"
 #include "ctree.h"
 #include "transaction.h"
 
+struct inode;
+struct dentry;
+struct btrfs_ordered_extent;
+struct btrfs_root;
+struct btrfs_trans_handle;
+
 /* return value for btrfs_log_dentry_safe that means we don't need to log it at all */
 #define BTRFS_NO_LOG_SYNC 256
 
diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
index b2cef187ea8e..8e200fe1a2dd 100644
--- a/fs/btrfs/ulist.h
+++ b/fs/btrfs/ulist.h
@@ -7,6 +7,7 @@
 #ifndef BTRFS_ULIST_H
 #define BTRFS_ULIST_H
 
+#include <linux/types.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index f573bda496fb..77c4321e331f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -4,12 +4,27 @@
 #define BTRFS_ZONED_H
 
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/blkdev.h>
+#include <linux/blkzoned.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include "messages.h"
 #include "volumes.h"
 #include "disk-io.h"
 #include "block-group.h"
 #include "btrfs_inode.h"
+#include "fs.h"
+
+struct block_device;
+struct extent_buffer;
+struct btrfs_bio;
+struct btrfs_ordered_extent;
+struct btrfs_fs_info;
+struct btrfs_space_info;
+struct btrfs_eb_write_context;
+struct btrfs_fs_devices;
 
 #define BTRFS_DEFAULT_RECLAIM_THRESH           			(75)
 
-- 
2.42.1


