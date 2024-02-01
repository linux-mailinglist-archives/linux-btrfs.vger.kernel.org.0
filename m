Return-Path: <linux-btrfs+bounces-2027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54217845EC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4231F27047
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8674264;
	Thu,  1 Feb 2024 17:41:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F08405B
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809295; cv=none; b=akRlCsNPmdP13i+KW717jrup81Nt/rzGqvzi1Bqm5EcBL1nmFFdxys1ZyTbZ9y3qCydzg/oj76lYaPuzI6sXf0n9vqgNiPJ3scthz/MV4A2lpgOch9x/incKjSDI5pmlPT1tGhAr9fMX406116XYlTNjKcplbaoulfMYe4IEEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809295; c=relaxed/simple;
	bh=kvV7l0d+gQXnpLquRUIYvLO1wpUcDAkduIcebjB0hBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drGgV9mgKVGfEGFF0ofgLTPo8v3jes3IG23viPO0Pw9+DVytbWJEeQbqvBgZ44N2Bq8QLmFGElUrd5Xgk0Sjx1sCRmMtl3VnjjV55ObYrkFnbeuZb/5yT/zE+6wPoNlXROUkHSjWjYb9ooJOQyltChKKgTgX5g4C1lwZpk9JWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DAA522119;
	Thu,  1 Feb 2024 17:41:26 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 475BE13594;
	Thu,  1 Feb 2024 17:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IHZpEcbXu2WcSwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 17:41:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: add forward declarations and headers, part 3
Date: Thu,  1 Feb 2024 18:41:00 +0100
Message-ID: <3b39ee269a5108574e3aa5a1740f260670928e63.1706808903.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 4DAA522119
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Do a cleanup in the rest of the headers:

- add forward declarations for types referenced by pointers
- add includes when types need them

This fixes potential compilation problems if the headers are reordered
or the missing includes are not provided indirectly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.h   | 11 ++++++++++-
 fs/btrfs/backref.h     | 16 ++++++++++++++--
 fs/btrfs/block-group.h | 13 +++++++++++++
 fs/btrfs/btrfs_inode.h | 19 +++++++++++++++++++
 fs/btrfs/ctree.h       | 25 ++++++++++++-------------
 fs/btrfs/delayed-ref.h | 10 ++++++++++
 fs/btrfs/extent-tree.h |  1 +
 fs/btrfs/fs.h          | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/qgroup.h      | 17 +++++++++++++----
 fs/btrfs/volumes.h     | 25 +++++++++++++++++++------
 10 files changed, 151 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ed7aa32972ad..fa099f61fc8c 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -3,8 +3,17 @@
 #ifndef BTRFS_ACCESSORS_H
 #define BTRFS_ACCESSORS_H
 
-#include <linux/stddef.h>
 #include <asm/unaligned.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/align.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <uapi/linux/btrfs_tree.h>
+
+struct extent_buffer;
 
 struct btrfs_map_token {
 	struct extent_buffer *eb;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ab4ca0eda605..523e594ac753 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -6,11 +6,23 @@
 #ifndef BTRFS_BACKREF_H
 #define BTRFS_BACKREF_H
 
-#include <linux/btrfs.h>
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <uapi/linux/btrfs.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "messages.h"
-#include "ulist.h"
+#include "locking.h"
 #include "disk-io.h"
 #include "extent_io.h"
+#include "ctree.h"
+
+struct extent_inode_elem;
+struct ulist;
+struct btrfs_extent_item;
+struct btrfs_trans_handle;
+struct btrfs_fs_info;
 
 /*
  * Used by implementations of iterate_extent_inodes_t (see definition below) to
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 962b11983901..5ef52b9ea371 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -3,9 +3,22 @@
 #ifndef BTRFS_BLOCK_GROUP_H
 #define BTRFS_BLOCK_GROUP_H
 
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/refcount.h>
+#include <linux/wait.h>
+#include <linux/sizes.h>
+#include <linux/rwsem.h>
+#include <linux/rbtree.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "free-space-cache.h"
 
 struct btrfs_chunk_map;
+struct btrfs_fs_info;
+struct btrfs_inode;
+struct btrfs_trans_handle;
 
 enum btrfs_disk_cache_state {
 	BTRFS_DC_WRITTEN,
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 83d78a6f3aa2..397371472c1c 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -8,13 +8,32 @@
 
 #include <linux/hash.h>
 #include <linux/refcount.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/compiler.h>
 #include <linux/fscrypt.h>
+#include <linux/lockdep.h>
+#include <uapi/linux/btrfs_tree.h>
 #include <trace/events/btrfs.h>
+#include "block-rsv.h"
+#include "btrfs_inode.h"
 #include "extent_map.h"
 #include "extent_io.h"
+#include "extent-io-tree.h"
 #include "ordered-data.h"
 #include "delayed-inode.h"
 
+struct extent_state;
+struct posix_acl;
+struct iov_iter;
+struct writeback_control;
+struct btrfs_root;
+struct btrfs_fs_info;
+struct btrfs_trans_handle;
+
 /*
  * Since we search a directory based on f_pos (struct dir_context::pos) we have
  * to start at 2 since '.' and '..' have f_pos of 0 and 1 respectively, so
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index eede81288196..c03c58246033 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -7,25 +7,24 @@
 #define BTRFS_CTREE_H
 
 #include <linux/pagemap.h>
+#include <linux/spinlock.h>
+#include <linux/rbtree.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/atomic.h>
+#include <linux/xarray.h>
+#include <linux/refcount.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "locking.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-io-tree.h"
 
+struct extent_buffer;
+struct btrfs_block_rsv;
 struct btrfs_trans_handle;
-struct btrfs_transaction;
-struct btrfs_pending_snapshot;
-struct btrfs_delayed_ref_root;
-struct btrfs_space_info;
 struct btrfs_block_group;
-struct btrfs_ordered_sum;
-struct btrfs_ref;
-struct btrfs_bio;
-struct btrfs_ioctl_encoded_io_args;
-struct btrfs_device;
-struct btrfs_fs_devices;
-struct btrfs_balance_control;
-struct btrfs_delayed_root;
-struct reloc_control;
 
 /* Read ahead values for struct btrfs_path.reada */
 enum {
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 62d679d40f4f..cbd632f145f0 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -6,7 +6,17 @@
 #ifndef BTRFS_DELAYED_REF_H
 #define BTRFS_DELAYED_REF_H
 
+#include <linux/types.h>
 #include <linux/refcount.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <uapi/linux/btrfs_tree.h>
+
+struct btrfs_trans_handle;
+struct btrfs_fs_info;
 
 /* these are the possible values of struct btrfs_delayed_ref_node->action */
 enum btrfs_delayed_ref_action {
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 3fbcb7776a03..af9f8800d5ac 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -13,6 +13,7 @@ struct btrfs_free_cluster;
 struct btrfs_fs_info;
 struct btrfs_root;
 struct btrfs_path;
+struct btrfs_ref;
 struct btrfs_disk_key;
 struct btrfs_delayed_ref_head;
 struct btrfs_delayed_ref_root;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 44a032bad045..201da02164b0 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -4,12 +4,50 @@
 #define BTRFS_FS_H
 
 #include <linux/blkdev.h>
-#include <linux/fs.h>
-#include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
+#include <linux/time64.h>
+#include <linux/compiler.h>
+#include <linux/math.h>
+#include <linux/atomic.h>
+#include <linux/blkdev.h>
+#include <linux/percpu_counter.h>
+#include <linux/completion.h>
+#include <linux/lockdep.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/rwlock_types.h>
+#include <linux/rwsem.h>
+#include <linux/semaphore.h>
+#include <linux/list.h>
+#include <linux/radix-tree.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
+#include <linux/wait_bit.h>
+#include <linux/sched.h>
+#include <linux/rbtree.h>
+#include <uapi/linux/btrfs.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "extent-io-tree.h"
 #include "async-thread.h"
 #include "block-rsv.h"
+#include "fs.h"
+
+struct inode;
+struct super_block;
+struct kobject;
+struct reloc_control;
+struct crypto_shash;
+struct ulist;
+struct btrfs_device;
+struct btrfs_block_group;
+struct btrfs_root;
+struct btrfs_fs_devices;
+struct btrfs_transaction;
+struct btrfs_delayed_root;
+struct btrfs_balance_control;
+struct btrfs_subpage_info;
+struct btrfs_stripe_hash_table;
+struct btrfs_space_info;
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index be18c862e64e..1f664261c064 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -6,12 +6,22 @@
 #ifndef BTRFS_QGROUP_H
 #define BTRFS_QGROUP_H
 
+#include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/kobject.h>
-#include "ulist.h"
-#include "delayed-ref.h"
-#include "misc.h"
+#include <linux/list.h>
+#include <uapi/linux/btrfs_tree.h>
+
+struct extent_buffer;
+struct extent_changeset;
+struct btrfs_delayed_extent_op;
+struct btrfs_fs_info;
+struct btrfs_root;
+struct btrfs_ioctl_quota_ctl_args;
+struct btrfs_trans_handle;
+struct btrfs_delayed_ref_root;
+struct btrfs_inode;
 
 /*
  * Btrfs qgroup overview
@@ -321,7 +331,6 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit);
 int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info);
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info);
-struct btrfs_delayed_extent_op;
 
 int btrfs_qgroup_trace_extent_nolock(
 		struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da7..21d4de0e3f1f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -6,13 +6,28 @@
 #ifndef BTRFS_VOLUMES_H
 #define BTRFS_VOLUMES_H
 
+#include <linux/blk_types.h>
+#include <linux/sizes.h>
+#include <linux/atomic.h>
 #include <linux/sort.h>
-#include <linux/btrfs.h>
-#include "async-thread.h"
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/log2.h>
+#include <linux/kobject.h>
+#include <linux/refcount.h>
+#include <linux/completion.h>
+#include <linux/rbtree.h>
+#include <uapi/linux/btrfs.h>
 #include "messages.h"
-#include "tree-checker.h"
 #include "rcu-string.h"
 
+struct block_device;
+struct bdev_handle;
+struct btrfs_fs_info;
+struct btrfs_block_group;
+struct btrfs_trans_handle;
+struct btrfs_zoned_device_info;
+
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
 extern struct mutex uuid_mutex;
@@ -77,7 +92,7 @@ enum btrfs_raid_types {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
 
-struct btrfs_zoned_device_info;
+struct btrfs_fs_devices;
 
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
@@ -557,8 +572,6 @@ static inline void btrfs_free_chunk_map(struct btrfs_chunk_map *map)
 	}
 }
 
-struct btrfs_balance_args;
-struct btrfs_balance_progress;
 struct btrfs_balance_control {
 	struct btrfs_balance_args data;
 	struct btrfs_balance_args meta;
-- 
2.42.1


