Return-Path: <linux-btrfs+bounces-2025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB7845EC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84EC1C27508
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8F7428B;
	Thu,  1 Feb 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="peuMIJwV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="peuMIJwV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8274274
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809285; cv=none; b=ZyvoymB1F11Rzw+Yr/8HFA6xdFefQtHQzWHIkarqCoB7bS2e1hA24WopItxmLDgESnlZ+MigUQ+hiTd212YLfkfxC79OUVh847KruFr14TW4SRC3DYkpvch7vpTgvryAYSNhhpUH0iV+MhmycarZk6UDzHTgytjj4E21oz57FLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809285; c=relaxed/simple;
	bh=ZxDP/Wew4xiezlbDsugbzaMrQ0Mf+JIANn3UQV4QXIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEtX3mlQPp1nHg3hx1jwxoHxLaHx+353FgxndJVTPmYcKm3mAjLJha6Yk76oWsgjwwyxB/XJbxvpuMBOcJvYM7XdwaPUCKBjOzSKAQ0BbodWAVIpLkhHlPkm5d/z3ECDzUOuy9bSUQs1QfAjLm2lxSTdOb7YRIt1VK+g+e/CMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=peuMIJwV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=peuMIJwV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AAE91F38C;
	Thu,  1 Feb 2024 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706809281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXRXcR99yaXf/V35LGljxwjPb5hzcewjFidk76rfmmQ=;
	b=peuMIJwVzelpanToX771QlfD7dSpCQgJ40Ljpu4u16nRzDmERDbdVoYTOqDXgB2pSEqlbN
	RcBwjNbYH0RtQF8Q38inGfYd2ghv7u6ocXw9oRbN/mJFDsWSgsCKRCZHF4PrWxhTuvP507
	hTOIlZjm7XEU3h5SvAF8XcZgaeCVN98=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706809281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXRXcR99yaXf/V35LGljxwjPb5hzcewjFidk76rfmmQ=;
	b=peuMIJwVzelpanToX771QlfD7dSpCQgJ40Ljpu4u16nRzDmERDbdVoYTOqDXgB2pSEqlbN
	RcBwjNbYH0RtQF8Q38inGfYd2ghv7u6ocXw9oRbN/mJFDsWSgsCKRCZHF4PrWxhTuvP507
	hTOIlZjm7XEU3h5SvAF8XcZgaeCVN98=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 839D413594;
	Thu,  1 Feb 2024 17:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xpkeIMHXu2WWSwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 17:41:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: add forward declarations and headers, part 1
Date: Thu,  1 Feb 2024 18:40:56 +0100
Message-ID: <47099ac9ebe4b2df4a1e029dbfa2ac2587667cbc.1706808903.git.dsterba@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

Do a cleanup in the short headers:

- add forward declarations for types referenced by pointers
- add includes when types need them

This fixes potential compilation problems if the headers are reordered
or the missing includes are not provided indirectly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/acl.h              | 11 +++++++++++
 fs/btrfs/async-thread.h     |  3 +++
 fs/btrfs/defrag.h           | 10 ++++++++++
 fs/btrfs/delalloc-space.h   |  4 ++++
 fs/btrfs/dev-replace.h      |  4 ++++
 fs/btrfs/dir-item.h         |  6 ++++++
 fs/btrfs/disk-io.h          |  4 ++++
 fs/btrfs/export.h           |  4 ++++
 fs/btrfs/extent_map.h       |  1 +
 fs/btrfs/file.h             | 15 +++++++++++++++
 fs/btrfs/ioctl.h            |  9 +++++++++
 fs/btrfs/ordered-data.h     |  2 ++
 fs/btrfs/orphan.h           |  5 +++++
 fs/btrfs/print-tree.h       |  3 +++
 fs/btrfs/props.c            |  1 +
 fs/btrfs/props.h            |  7 ++++++-
 fs/btrfs/raid-stripe-tree.h |  5 +++++
 fs/btrfs/rcu-string.h       |  6 ++++++
 fs/btrfs/ref-verify.h       |  9 +++++++++
 fs/btrfs/reflink.h          |  4 +++-
 fs/btrfs/relocation.h       |  9 +++++++++
 fs/btrfs/root-tree.h        | 10 ++++++++++
 fs/btrfs/scrub.h            |  6 ++++++
 fs/btrfs/super.h            |  7 +++++++
 fs/btrfs/sysfs.h            |  9 +++++++++
 fs/btrfs/tree-mod-log.h     |  8 +++++++-
 fs/btrfs/uuid-tree.h        |  5 +++++
 fs/btrfs/verity.h           |  7 +++++++
 fs/btrfs/xattr.h            |  6 +++++-
 29 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/acl.h b/fs/btrfs/acl.h
index a270e71ec05f..48b9ddae4a46 100644
--- a/fs/btrfs/acl.h
+++ b/fs/btrfs/acl.h
@@ -3,8 +3,15 @@
 #ifndef BTRFS_ACL_H
 #define BTRFS_ACL_H
 
+struct posix_acl;
+struct inode;
+struct btrfs_trans_handle;
+
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 
+struct mnt_idmap;
+struct dentry;
+
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
 int btrfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type);
@@ -13,6 +20,10 @@ int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 
 #else
 
+#include <linux/errno.h>
+
+struct btrfs_trans_handle;
+
 #define btrfs_get_acl NULL
 #define btrfs_set_acl NULL
 static inline int __btrfs_set_acl(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 62b8a0d57898..04c2f3175828 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -7,11 +7,14 @@
 #ifndef BTRFS_ASYNC_THREAD_H
 #define BTRFS_ASYNC_THREAD_H
 
+#include <linux/compiler_types.h>
 #include <linux/workqueue.h>
+#include <linux/list.h>
 
 struct btrfs_fs_info;
 struct btrfs_workqueue;
 struct btrfs_work;
+
 typedef void (*btrfs_func_t)(struct btrfs_work *arg);
 typedef void (*btrfs_ordered_func_t)(struct btrfs_work *arg, bool);
 
diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
index 5a62763528d1..878528e086fb 100644
--- a/fs/btrfs/defrag.h
+++ b/fs/btrfs/defrag.h
@@ -3,6 +3,16 @@
 #ifndef BTRFS_DEFRAG_H
 #define BTRFS_DEFRAG_H
 
+#include <linux/types.h>
+#include <linux/compiler_types.h>
+
+struct inode;
+struct file_ra_state;
+struct btrfs_fs_info;
+struct btrfs_root;
+struct btrfs_trans_handle;
+struct btrfs_ioctl_defrag_range_args;
+
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag);
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index c5d573f2366e..ce4f889e4f17 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -3,7 +3,11 @@
 #ifndef BTRFS_DELALLOC_SPACE_H
 #define BTRFS_DELALLOC_SPACE_H
 
+#include <linux/types.h>
+
 struct extent_changeset;
+struct btrfs_inode;
+struct btrfs_fs_info;
 
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 675082ccec89..23e480efe5e6 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -6,11 +6,15 @@
 #ifndef BTRFS_DEV_REPLACE_H
 #define BTRFS_DEV_REPLACE_H
 
+#include <linux/types.h>
+#include <linux/compiler_types.h>
+
 struct btrfs_ioctl_dev_replace_args;
 struct btrfs_fs_info;
 struct btrfs_trans_handle;
 struct btrfs_dev_replace;
 struct btrfs_block_group;
+struct btrfs_device;
 
 int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info);
 int btrfs_run_dev_replace(struct btrfs_trans_handle *trans);
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index e40a226373d7..00b3d83d7569 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -3,9 +3,15 @@
 #ifndef BTRFS_DIR_ITEM_H
 #define BTRFS_DIR_ITEM_H
 
+#include <linux/types.h>
 #include <linux/crc32c.h>
 
 struct fscrypt_str;
+struct btrfs_fs_info;
+struct btrfs_key;
+struct btrfs_path;
+struct btrfs_root;
+struct btrfs_trans_handle;
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9413726b329b..21ff41bfe2b5 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -6,6 +6,10 @@
 #ifndef BTRFS_DISK_IO_H
 #define BTRFS_DISK_IO_H
 
+#include <linux/sizes.h>
+#include "ctree.h"
+#include "fs.h"
+
 #define BTRFS_SUPER_MIRROR_MAX	 3
 #define BTRFS_SUPER_MIRROR_SHIFT 12
 
diff --git a/fs/btrfs/export.h b/fs/btrfs/export.h
index eba6bc4f5a61..464582273af9 100644
--- a/fs/btrfs/export.h
+++ b/fs/btrfs/export.h
@@ -4,6 +4,10 @@
 #define BTRFS_EXPORT_H
 
 #include <linux/exportfs.h>
+#include <linux/types.h>
+
+struct dentry;
+struct super_block;
 
 extern const struct export_operations btrfs_export_ops;
 
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index e380fc08bbe4..7fd55cf91f53 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -5,6 +5,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include "misc.h"
 #include "compression.h"
 
 #define EXTENT_MAP_LAST_BYTE ((u64)-4)
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 82b34fbb295f..77aaca208c7b 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -3,6 +3,21 @@
 #ifndef BTRFS_FILE_H
 #define BTRFS_FILE_H
 
+#include <linux/types.h>
+
+struct file;
+struct extent_state;
+struct kiocb;
+struct iov_iter;
+struct page;
+struct btrfs_ioctl_encoded_io_args;
+struct btrfs_drop_extents_args;
+struct btrfs_inode;
+struct btrfs_root;
+struct btrfs_path;
+struct btrfs_replace_extent_info;
+struct btrfs_trans_handle;
+
 extern const struct file_operations btrfs_file_operations;
 
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index d51b9a2f2f6e..2c5dc25ec670 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -3,6 +3,15 @@
 #ifndef BTRFS_IOCTL_H
 #define BTRFS_IOCTL_H
 
+#include <linux/types.h>
+
+struct file;
+struct dentry;
+struct mnt_idmap;
+struct fileattr;
+struct btrfs_fs_info;
+struct btrfs_ioctl_balance_args;
+
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 127ef8bf0ffd..6fc0521000ac 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_ORDERED_DATA_H
 #define BTRFS_ORDERED_DATA_H
 
+#include "async-thread.h"
+
 struct btrfs_ordered_sum {
 	/*
 	 * Logical start address and length for of the blocks covered by
diff --git a/fs/btrfs/orphan.h b/fs/btrfs/orphan.h
index 3faab5cbb59a..aa54a88a60de 100644
--- a/fs/btrfs/orphan.h
+++ b/fs/btrfs/orphan.h
@@ -3,6 +3,11 @@
 #ifndef BTRFS_ORPHAN_H
 #define BTRFS_ORPHAN_H
 
+#include <linux/types.h>
+
+struct btrfs_trans_handle;
+struct btrfs_root;
+
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 offset);
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index c42bc666d5ee..8504bf1702c7 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -9,6 +9,9 @@
 /* Buffer size to contain tree name and possibly additional data (offset) */
 #define BTRFS_ROOT_NAME_BUF_LEN				48
 
+struct extent_buffer;
+struct btrfs_key;
+
 void btrfs_print_leaf(const struct extent_buffer *l);
 void btrfs_print_tree(const struct extent_buffer *c, bool follow);
 const char *btrfs_root_name(const struct btrfs_key *key, char *buf);
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f9bf591a0718..f7bc90031eb6 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/hashtable.h>
+#include <linux/xattr.h>
 #include "messages.h"
 #include "props.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 6e283196e38a..f60cd89feb29 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -6,7 +6,12 @@
 #ifndef BTRFS_PROPS_H
 #define BTRFS_PROPS_H
 
-#include "ctree.h"
+#include <linux/compiler_types.h>
+
+struct inode;
+struct btrfs_inode;
+struct btrfs_path;
+struct btrfs_trans_handle;
 
 int __init btrfs_props_init(void);
 
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index cdb58b38fcb5..c9c258f84903 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -6,6 +6,10 @@
 #ifndef BTRFS_RAID_STRIPE_TREE_H
 #define BTRFS_RAID_STRIPE_TREE_H
 
+#include <linux/types.h>
+#include <uapi/linux/btrfs_tree.h>
+#include "fs.h"
+
 #define BTRFS_RST_SUPP_BLOCK_GROUP_MASK    (BTRFS_BLOCK_GROUP_DUP |		\
 					    BTRFS_BLOCK_GROUP_RAID1_MASK |	\
 					    BTRFS_BLOCK_GROUP_RAID0 |		\
@@ -13,6 +17,7 @@
 
 struct btrfs_io_context;
 struct btrfs_io_stripe;
+struct btrfs_fs_info;
 struct btrfs_ordered_extent;
 struct btrfs_trans_handle;
 
diff --git a/fs/btrfs/rcu-string.h b/fs/btrfs/rcu-string.h
index 5c2b66d155ef..1c2d7cb1fe6f 100644
--- a/fs/btrfs/rcu-string.h
+++ b/fs/btrfs/rcu-string.h
@@ -6,6 +6,12 @@
 #ifndef BTRFS_RCU_STRING_H
 #define BTRFS_RCU_STRING_H
 
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/rcupdate.h>
+#include <linux/printk.h>
+
 struct rcu_string {
 	struct rcu_head rcu;
 	char str[];
diff --git a/fs/btrfs/ref-verify.h b/fs/btrfs/ref-verify.h
index 855de37719b5..3511e1a5c96b 100644
--- a/fs/btrfs/ref-verify.h
+++ b/fs/btrfs/ref-verify.h
@@ -6,7 +6,16 @@
 #ifndef BTRFS_REF_VERIFY_H
 #define BTRFS_REF_VERIFY_H
 
+#include <linux/types.h>
+#include <linux/rbtree_types.h>
+
+struct btrfs_fs_info;
+struct btrfs_ref;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
+
+#include <linux/spinlock.h>
+
 int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info);
 void btrfs_free_ref_cache(struct btrfs_fs_info *fs_info);
 int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/reflink.h b/fs/btrfs/reflink.h
index ecb309b4dad0..1e291f7d85c4 100644
--- a/fs/btrfs/reflink.h
+++ b/fs/btrfs/reflink.h
@@ -3,7 +3,9 @@
 #ifndef BTRFS_REFLINK_H
 #define BTRFS_REFLINK_H
 
-#include <linux/fs.h>
+#include <linux/types.h>
+
+struct file;
 
 loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
 			      struct file *file_out, loff_t pos_out,
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 5fb60f2deb53..788c86d8633a 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -3,6 +3,15 @@
 #ifndef BTRFS_RELOCATION_H
 #define BTRFS_RELOCATION_H
 
+#include <linux/types.h>
+
+struct extent_buffer;
+struct btrfs_fs_info;
+struct btrfs_root;
+struct btrfs_trans_handle;
+struct btrfs_ordered_extent;
+struct btrfs_pending_snapshot;
+
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index 8b2c3859e464..6f929cf3bd49 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -3,7 +3,17 @@
 #ifndef BTRFS_ROOT_TREE_H
 #define BTRFS_ROOT_TREE_H
 
+#include <linux/types.h>
+
 struct fscrypt_str;
+struct extent_buffer;
+struct btrfs_key;
+struct btrfs_root;
+struct btrfs_root_item;
+struct btrfs_path;
+struct btrfs_fs_info;
+struct btrfs_block_rsv;
+struct btrfs_trans_handle;
 
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7639103ebf9d..f0df597b75c7 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -3,6 +3,12 @@
 #ifndef BTRFS_SCRUB_H
 #define BTRFS_SCRUB_H
 
+#include <linux/types.h>
+
+struct btrfs_fs_info;
+struct btrfs_device;
+struct btrfs_scrub_progress;
+
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
 		    int readonly, int is_dev_replace);
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index f18253ca280d..cbcab434b5ec 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,6 +3,13 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
+#include <linux/types.h>
+#include <linux/fs.h>
+#include "fs.h"
+
+struct super_block;
+struct btrfs_fs_info;
+
 bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 			 unsigned long flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 86c7eef12873..e6a284c59809 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -3,8 +3,17 @@
 #ifndef BTRFS_SYSFS_H
 #define BTRFS_SYSFS_H
 
+#include <linux/types.h>
+#include <linux/compiler_types.h>
 #include <linux/kobject.h>
 
+struct btrfs_fs_info;
+struct btrfs_device;
+struct btrfs_fs_devices;
+struct btrfs_block_group;
+struct btrfs_space_info;
+struct btrfs_qgroup;
+
 enum btrfs_feature_set {
 	FEAT_COMPAT,
 	FEAT_COMPAT_RO,
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
index 94f10afeee97..ff00c8e8a393 100644
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -3,7 +3,13 @@
 #ifndef BTRFS_TREE_MOD_LOG_H
 #define BTRFS_TREE_MOD_LOG_H
 
-#include "ctree.h"
+#include <linux/list.h>
+
+struct extent_buffer;
+struct btrfs_fs_info;
+struct btrfs_path;
+struct btrfs_root;
+struct btrfs_seq_list;
 
 /* Represents a tree mod log user. */
 struct btrfs_seq_list {
diff --git a/fs/btrfs/uuid-tree.h b/fs/btrfs/uuid-tree.h
index 5350c87fe2ca..080ede0227ae 100644
--- a/fs/btrfs/uuid-tree.h
+++ b/fs/btrfs/uuid-tree.h
@@ -3,6 +3,11 @@
 #ifndef BTRFS_UUID_TREE_H
 #define BTRFS_UUID_TREE_H
 
+#include <linux/types.h>
+
+struct btrfs_trans_handle;
+struct btrfs_fs_info;
+
 int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
diff --git a/fs/btrfs/verity.h b/fs/btrfs/verity.h
index 91c10f7d0a46..d696659e43e4 100644
--- a/fs/btrfs/verity.h
+++ b/fs/btrfs/verity.h
@@ -3,8 +3,13 @@
 #ifndef BTRFS_VERITY_H
 #define BTRFS_VERITY_H
 
+struct inode;
+struct btrfs_inode;
+
 #ifdef CONFIG_FS_VERITY
 
+#include <linux/fsverity.h>
+
 extern const struct fsverity_operations btrfs_verityops;
 
 int btrfs_drop_verity_items(struct btrfs_inode *inode);
@@ -12,6 +17,8 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
 
 #else
 
+#include <linux/errno.h>
+
 static inline int btrfs_drop_verity_items(struct btrfs_inode *inode)
 {
 	return 0;
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index 118118ca3e1d..b9376ea258ff 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -6,7 +6,11 @@
 #ifndef BTRFS_XATTR_H
 #define BTRFS_XATTR_H
 
-#include <linux/xattr.h>
+struct dentry;
+struct inode;
+struct qstr;
+struct xattr_handler;
+struct btrfs_trans_handle;
 
 extern const struct xattr_handler * const btrfs_xattr_handlers[];
 
-- 
2.42.1


