Return-Path: <linux-btrfs+bounces-11422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2BDA330B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4616A188B806
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAC201253;
	Wed, 12 Feb 2025 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fo2EDTYG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OTqcLKbX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F3200B99
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391748; cv=none; b=Q1M4cx414UruOs4vRbPNDB4JFHsRfEq4FM9X4HznI9xw1r1CWkv8BGea74udhBzq2RuD90r1dU8ycmCTvaVPwE7BkbAbWw/sQ91JcDNhY0uLqkAlZgCxkxkNKf97ftewleI3/9MdY7K9Qbl2TN3Cf3PwBlmyybgoU1aWldibGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391748; c=relaxed/simple;
	bh=oqi3sd1luO0lcmvt2mKE5m/Ek+8yn9At3sHpLwuXanM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLHWcHLNKENW/Oxvk8nv5ZkLDO+uZzsIb2WhaKizuRLoPtBSZsWOLpaUJidDHD78B1dqa7XnXOenvKln3avc7vArDUVIH9MNyOo7v4xQ8DbiXjpLB2WKjnyTUkOFCnyA8rEvX4+S+qdujzLTtNt6SwZmTlHS3j6WV0LOpYW7CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fo2EDTYG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OTqcLKbX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED5C5337B7;
	Wed, 12 Feb 2025 20:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULKG6dKUUpmOiTHbJPoUZELThCHn7K5V7bw88UFQAkA=;
	b=Fo2EDTYGtpIl71eK6lmI8n8JlZDA5lwdW1rn8VPAUpTCrO8HKqm2bTAIEpetZXfczanzKq
	/g6SnDQmMe2YiOSh5e/9mYTS3xER4c/BFyDHrLV1sZNgKbIH7K0GLYtC0eYe0HWLmw8bQg
	XN0cdI1sM5uv2xqMWTjLD2zmk8ALLQw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULKG6dKUUpmOiTHbJPoUZELThCHn7K5V7bw88UFQAkA=;
	b=OTqcLKbXp96Bt1zuhg6rbslxFs6T+T053/l/U50Ki4zOJLz7fUImb3CVGLUP7DZC/MzaH6
	D2iPZfrIxY5ryY6xNYdofw1jjzcFCYMhH4gb7f1krbIT/nhINgtmVFsTJngVNH4ytz67au
	8ysNZnaw7N8oY+LL4OoT3RIclUQdYgg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5F3F13AEF;
	Wed, 12 Feb 2025 20:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8yMiOAADrWexJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:22:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 7/7] btrfs: update include and forward declarations in headers
Date: Wed, 12 Feb 2025 21:22:16 +0100
Message-ID: <d9e4a9bd7209b38251d06a7779840d6ecf589147.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Pass over all header files and add missing forward declarations,
includes or fix include types.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.h        | 1 +
 fs/btrfs/acl.h              | 2 ++
 fs/btrfs/ctree.h            | 2 +-
 fs/btrfs/delayed-ref.h      | 2 ++
 fs/btrfs/dir-item.h         | 1 +
 fs/btrfs/direct-io.h        | 2 ++
 fs/btrfs/discard.h          | 1 +
 fs/btrfs/extent-tree.h      | 1 -
 fs/btrfs/file-item.h        | 2 ++
 fs/btrfs/file.h             | 2 ++
 fs/btrfs/fs.c               | 1 -
 fs/btrfs/ioctl.h            | 2 ++
 fs/btrfs/locking.c          | 1 -
 fs/btrfs/ordered-data.h     | 1 +
 fs/btrfs/print-tree.h       | 2 ++
 fs/btrfs/props.h            | 1 +
 fs/btrfs/qgroup.h           | 3 +++
 fs/btrfs/raid-stripe-tree.h | 1 +
 fs/btrfs/send.c             | 1 -
 fs/btrfs/space-info.c       | 2 +-
 fs/btrfs/subpage.c          | 1 -
 fs/btrfs/sysfs.h            | 1 +
 fs/btrfs/volumes.h          | 4 ++++
 fs/btrfs/xattr.h            | 2 ++
 24 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 7a7e0ef69973..15ea6348800b 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "extent_io.h"
 
 struct extent_buffer;
 
diff --git a/fs/btrfs/acl.h b/fs/btrfs/acl.h
index 48b9ddae4a46..0458cd51ed48 100644
--- a/fs/btrfs/acl.h
+++ b/fs/btrfs/acl.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ACL_H
 #define BTRFS_ACL_H
 
+#include <linux/types.h>
+
 struct posix_acl;
 struct inode;
 struct btrfs_trans_handle;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1096a80a64e7..075a06db43a1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -6,7 +6,7 @@
 #ifndef BTRFS_CTREE_H
 #define BTRFS_CTREE_H
 
-#include "linux/cleanup.h"
+#include <linux/cleanup.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/mutex.h>
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index a35067cebb97..f5ae880308d3 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -14,6 +14,8 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "fs.h"
+#include "messages.h"
 
 struct btrfs_trans_handle;
 struct btrfs_fs_info;
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 28d69970bc70..8462579a95f4 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -10,6 +10,7 @@ struct fscrypt_str;
 struct btrfs_fs_info;
 struct btrfs_key;
 struct btrfs_path;
+struct btrfs_inode;
 struct btrfs_root;
 struct btrfs_trans_handle;
 
diff --git a/fs/btrfs/direct-io.h b/fs/btrfs/direct-io.h
index 3dc3ea926afe..df5d45ee6de7 100644
--- a/fs/btrfs/direct-io.h
+++ b/fs/btrfs/direct-io.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct kiocb;
+
 int __init btrfs_init_dio(void);
 void __cold btrfs_destroy_dio(void);
 
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index dddb0f9101ba..2c5e85394092 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_DISCARD_H
 #define BTRFS_DISCARD_H
 
+#include <linux/types.h>
 #include <linux/sizes.h>
 
 struct btrfs_fs_info;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index cfa52264f678..0ed682d9ed7b 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -4,7 +4,6 @@
 #define BTRFS_EXTENT_TREE_H
 
 #include <linux/types.h>
-#include "misc.h"
 #include "block-group.h"
 #include "locking.h"
 
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 0e13661a71f3..6181a70ec3ef 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -3,8 +3,10 @@
 #ifndef BTRFS_FILE_ITEM_H
 #define BTRFS_FILE_ITEM_H
 
+#include <linux/blk_types.h>
 #include <linux/list.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "ctree.h"
 #include "accessors.h"
 
 struct extent_map;
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index de89e644be29..d7df81388cbe 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -9,6 +9,8 @@ struct file;
 struct extent_state;
 struct kiocb;
 struct iov_iter;
+struct inode;
+struct folio;
 struct page;
 struct btrfs_ioctl_encoded_io_args;
 struct btrfs_drop_extents_args;
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 09cfb43580cb..b2bb86f8d7cf 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "messages.h"
-#include "ctree.h"
 #include "fs.h"
 #include "accessors.h"
 #include "volumes.h"
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index ce915fcda43b..18c45851e0b6 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -9,6 +9,8 @@ struct file;
 struct dentry;
 struct mnt_idmap;
 struct fileattr;
+struct inode;
+struct io_uring_cmd;
 struct btrfs_fs_info;
 struct btrfs_ioctl_balance_args;
 
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 9a7a7b723305..81e62b652e21 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -9,7 +9,6 @@
 #include <linux/page-flags.h>
 #include <asm/bug.h>
 #include <trace/events/btrfs.h>
-#include "misc.h"
 #include "ctree.h"
 #include "extent_io.h"
 #include "locking.h"
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4e152736d06c..be36083297a7 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -17,6 +17,7 @@
 struct inode;
 struct page;
 struct extent_state;
+struct btrfs_block_group;
 struct btrfs_inode;
 struct btrfs_root;
 struct btrfs_fs_info;
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index 8504bf1702c7..d0e620bf5f5a 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_PRINT_TREE_H
 #define BTRFS_PRINT_TREE_H
 
+#include <linux/types.h>
+
 /* Buffer size to contain tree name and possibly additional data (offset) */
 #define BTRFS_ROOT_NAME_BUF_LEN				48
 
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 63546d0a9444..86849d4e7938 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_PROPS_H
 #define BTRFS_PROPS_H
 
+#include <linux/types.h>
 #include <linux/compiler_types.h>
 
 struct inode;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index e233cc79af18..a979fd59a4da 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -22,6 +22,9 @@ struct btrfs_ioctl_quota_ctl_args;
 struct btrfs_trans_handle;
 struct btrfs_delayed_ref_root;
 struct btrfs_inode;
+struct btrfs_transaction;
+struct btrfs_block_group;
+struct btrfs_qgroup_swapped_blocks;
 
 /*
  * Btrfs qgroup overview
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 541836421778..69942ad43140 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <uapi/linux/btrfs_tree.h>
 #include "fs.h"
+#include "accessors.h"
 
 #define BTRFS_RST_SUPP_BLOCK_GROUP_MASK    (BTRFS_BLOCK_GROUP_DUP |		\
 					    BTRFS_BLOCK_GROUP_RAID1_MASK |	\
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f437138fefbc..d513f7fd5fe8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -16,7 +16,6 @@
 #include <linux/compat.h>
 #include <linux/crc32c.h>
 #include <linux/fsverity.h>
-
 #include "send.h"
 #include "ctree.h"
 #include "backref.h"
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a341d087567a..ff089e3e4103 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "linux/spinlock.h"
+#include <linux/spinlock.h>
 #include <linux/minmax.h>
 #include "misc.h"
 #include "ctree.h"
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 8c160a460ba0..a8389844ea0a 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -2,7 +2,6 @@
 
 #include <linux/slab.h>
 #include "messages.h"
-#include "ctree.h"
 #include "subpage.h"
 #include "btrfs_inode.h"
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 3fc5c6f90dc4..0f94ae923210 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -7,6 +7,7 @@
 #include <linux/compiler_types.h>
 #include <linux/kobject.h>
 
+struct block_device;
 struct btrfs_fs_info;
 struct btrfs_device;
 struct btrfs_fs_devices;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 120f65e21eeb..e247d551da67 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -7,6 +7,7 @@
 #define BTRFS_VOLUMES_H
 
 #include <linux/blk_types.h>
+#include <linux/blkdev.h>
 #include <linux/sizes.h>
 #include <linux/atomic.h>
 #include <linux/sort.h>
@@ -18,14 +19,17 @@
 #include <linux/completion.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/btrfs.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "messages.h"
 #include "rcu-string.h"
+#include "extent-io-tree.h"
 
 struct block_device;
 struct bdev_handle;
 struct btrfs_fs_info;
 struct btrfs_block_group;
 struct btrfs_trans_handle;
+struct btrfs_transaction;
 struct btrfs_zoned_device_info;
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index 8dc4cf49f6f0..0ce10e4ec836 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_XATTR_H
 #define BTRFS_XATTR_H
 
+#include <linux/types.h>
+
 struct dentry;
 struct inode;
 struct qstr;
-- 
2.47.1


