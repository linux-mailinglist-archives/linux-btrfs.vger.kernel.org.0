Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE34C02F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfFSRrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36873 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFSRrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so87459qkl.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=a51SSNGHqs8KLiUu4N7/r95Zirdm2L8wg8DCIoU74xM=;
        b=SxKrQUOmyKbkEC5Mrh+gsTohe041xCBwVqmozA3yb7niXOjuVRUKCKWtA+1vHCSvGA
         ZVD7AkVBIlqPxtwOE3bBaprNA1kaVgtnUrmWLc1ackgQJ/eN7/uM8Q5cKLCZt51Briy5
         4ARkjMeXJk2iIiWjhEaPXwCRthzUzqMHQQz1L2LwBKIAWyQk6Zf5mD26y1RrMZ+SwP5z
         n2rxrtcvt8MfDC6MWvnC2vrzaod24juKhLqEL2wz3NVU/QjNN1XyTJx0w7Qm9rW/sNYs
         TWMtkhAMev83hUMh7FYeLKOQ5gojm4JEK0kAgbFLtcyUjhxmrUsnr2ZDIhTMkApjyTKx
         CdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=a51SSNGHqs8KLiUu4N7/r95Zirdm2L8wg8DCIoU74xM=;
        b=nNjr0fFI1kuEBaq7/f+AjxSz1sw+W9Uql1jY+cEQk2qLwmGxfUs+3U6n/c4KOh8cR2
         sNGChwI5/AeMwozVy+mYBTYf1ztdRAlfInidu7l/4ph0mBnArD09o9aAJ2w6tkmFgRFY
         m/8BweC6HiRV7RW2VJ4aMhJ3uxYyuBQvCpOOfrP++8hJnyKsMsAYTEFvYOln0+MyPgpM
         hXX9eyT7+sKUCM5BKkvyM+/8oLa2rTuXeFn4uUVargHNOWK2VQhSg/oB9syfcHb+vV69
         nGXYc2vglyxh2F0TIHUPotP5eBRL+7BwwdRsRgoSEC8HvHFGu5z6AthsHWJiXKYPLa9P
         dhAQ==
X-Gm-Message-State: APjAAAVohrM7b2eMG5fir47B1m1emZvRA7un/HXeolAEuBypzWmoFGgb
        kG9A0QTV8x37U4bdFbH6yfNs8Vqohu3xig==
X-Google-Smtp-Source: APXvYqy4+XEZqcfmgjKOKDEyTpnmpeXQL0VlkVFNxawRZwPO+Rt1tWLo6ATrq57ckhBRKzDZvqrqvw==
X-Received: by 2002:a37:9d50:: with SMTP id g77mr100648913qke.311.1560966457693;
        Wed, 19 Jun 2019 10:47:37 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b23sm12036374qte.19.2019.06.19.10.47.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: migrate the block-rsv code to block-rsv.c
Date:   Wed, 19 Jun 2019 13:47:22 -0400
Message-Id: <20190619174724.1675-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This moves everything out of extent-tree.c to block-rsv.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile      |   3 +-
 fs/btrfs/block-rsv.c   | 257 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.c | 249 -----------------------------------------------
 3 files changed, 259 insertions(+), 250 deletions(-)
 create mode 100644 fs/btrfs/block-rsv.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index ae5fad57bc9c..032700ae7704 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -10,7 +10,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
-	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o
+	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
+	   block-rsv.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
new file mode 100644
index 000000000000..aa6cea5785fd
--- /dev/null
+++ b/fs/btrfs/block-rsv.c
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+#include "ctree.h"
+#include "block-rsv.h"
+#include "space-info.h"
+#include "math.h"
+
+static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_block_rsv *block_rsv,
+				    struct btrfs_block_rsv *dest, u64 num_bytes,
+				    u64 *qgroup_to_release_ret)
+{
+	struct btrfs_space_info *space_info = block_rsv->space_info;
+	u64 qgroup_to_release = 0;
+	u64 ret;
+
+	spin_lock(&block_rsv->lock);
+	if (num_bytes == (u64)-1) {
+		num_bytes = block_rsv->size;
+		qgroup_to_release = block_rsv->qgroup_rsv_size;
+	}
+	block_rsv->size -= num_bytes;
+	if (block_rsv->reserved >= block_rsv->size) {
+		num_bytes = block_rsv->reserved - block_rsv->size;
+		block_rsv->reserved = block_rsv->size;
+		block_rsv->full = 1;
+	} else {
+		num_bytes = 0;
+	}
+	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
+				    block_rsv->qgroup_rsv_size;
+		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
+	} else {
+		qgroup_to_release = 0;
+	}
+	spin_unlock(&block_rsv->lock);
+
+	ret = num_bytes;
+	if (num_bytes > 0) {
+		if (dest) {
+			spin_lock(&dest->lock);
+			if (!dest->full) {
+				u64 bytes_to_add;
+
+				bytes_to_add = dest->size - dest->reserved;
+				bytes_to_add = min(num_bytes, bytes_to_add);
+				dest->reserved += bytes_to_add;
+				if (dest->reserved >= dest->size)
+					dest->full = 1;
+				num_bytes -= bytes_to_add;
+			}
+			spin_unlock(&dest->lock);
+		}
+		if (num_bytes)
+			btrfs_space_info_add_old_bytes(fs_info, space_info,
+						       num_bytes);
+	}
+	if (qgroup_to_release_ret)
+		*qgroup_to_release_ret = qgroup_to_release;
+	return ret;
+}
+
+int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
+			    struct btrfs_block_rsv *dst, u64 num_bytes,
+			    bool update_size)
+{
+	int ret;
+
+	ret = btrfs_block_rsv_use_bytes(src, num_bytes);
+	if (ret)
+		return ret;
+
+	btrfs_block_rsv_add_bytes(dst, num_bytes, update_size);
+	return 0;
+}
+
+void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type)
+{
+	memset(rsv, 0, sizeof(*rsv));
+	spin_lock_init(&rsv->lock);
+	rsv->type = type;
+}
+
+void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
+				   struct btrfs_block_rsv *rsv,
+				   unsigned short type)
+{
+	btrfs_init_block_rsv(rsv, type);
+	rsv->space_info = btrfs_find_space_info(fs_info,
+					    BTRFS_BLOCK_GROUP_METADATA);
+}
+
+struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
+					      unsigned short type)
+{
+	struct btrfs_block_rsv *block_rsv;
+
+	block_rsv = kmalloc(sizeof(*block_rsv), GFP_NOFS);
+	if (!block_rsv)
+		return NULL;
+
+	btrfs_init_metadata_block_rsv(fs_info, block_rsv, type);
+	return block_rsv;
+}
+
+void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
+			  struct btrfs_block_rsv *rsv)
+{
+	if (!rsv)
+		return;
+	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
+	kfree(rsv);
+}
+
+int btrfs_block_rsv_add(struct btrfs_root *root,
+			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
+			enum btrfs_reserve_flush_enum flush)
+{
+	int ret;
+
+	if (num_bytes == 0)
+		return 0;
+
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
+	if (!ret)
+		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, true);
+
+	return ret;
+}
+
+int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
+{
+	u64 num_bytes = 0;
+	int ret = -ENOSPC;
+
+	if (!block_rsv)
+		return 0;
+
+	spin_lock(&block_rsv->lock);
+	num_bytes = div_factor(block_rsv->size, min_factor);
+	if (block_rsv->reserved >= num_bytes)
+		ret = 0;
+	spin_unlock(&block_rsv->lock);
+
+	return ret;
+}
+
+int btrfs_block_rsv_refill(struct btrfs_root *root,
+			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
+			   enum btrfs_reserve_flush_enum flush)
+{
+	u64 num_bytes = 0;
+	int ret = -ENOSPC;
+
+	if (!block_rsv)
+		return 0;
+
+	spin_lock(&block_rsv->lock);
+	num_bytes = min_reserved;
+	if (block_rsv->reserved >= num_bytes)
+		ret = 0;
+	else
+		num_bytes -= block_rsv->reserved;
+	spin_unlock(&block_rsv->lock);
+
+	if (!ret)
+		return 0;
+
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
+	if (!ret) {
+		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
+		return 0;
+	}
+
+	return ret;
+}
+
+u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+			      struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes, u64 *qgroup_to_release)
+{
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_block_rsv *target = NULL;
+
+	/*
+	 * If we are the delayed_rsv then push to the global rsv, otherwise dump
+	 * into the delayed rsv if it is not full.
+	 */
+	if (block_rsv == delayed_rsv) {
+		target = global_rsv;
+	} else if (block_rsv != global_rsv) {
+		if (!delayed_rsv->full)
+			target = delayed_rsv;
+	}
+
+	if (target && block_rsv->space_info != target->space_info)
+		target = NULL;
+
+	return block_rsv_release_bytes(fs_info, block_rsv, target, num_bytes,
+				       qgroup_to_release);
+}
+
+int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes)
+{
+	int ret = -ENOSPC;
+	spin_lock(&block_rsv->lock);
+	if (block_rsv->reserved >= num_bytes) {
+		block_rsv->reserved -= num_bytes;
+		if (block_rsv->reserved < block_rsv->size)
+			block_rsv->full = 0;
+		ret = 0;
+	}
+	spin_unlock(&block_rsv->lock);
+	return ret;
+}
+
+void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
+			       u64 num_bytes, bool update_size)
+{
+	spin_lock(&block_rsv->lock);
+	block_rsv->reserved += num_bytes;
+	if (update_size)
+		block_rsv->size += num_bytes;
+	else if (block_rsv->reserved >= block_rsv->size)
+		block_rsv->full = 1;
+	spin_unlock(&block_rsv->lock);
+}
+
+int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
+			     struct btrfs_block_rsv *dest, u64 num_bytes,
+			     int min_factor)
+{
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	u64 min_bytes;
+
+	if (global_rsv->space_info != dest->space_info)
+		return -ENOSPC;
+
+	spin_lock(&global_rsv->lock);
+	min_bytes = div_factor(global_rsv->size, min_factor);
+	if (global_rsv->reserved < min_bytes + num_bytes) {
+		spin_unlock(&global_rsv->lock);
+		return -ENOSPC;
+	}
+	global_rsv->reserved -= num_bytes;
+	if (global_rsv->reserved < global_rsv->size)
+		global_rsv->full = 0;
+	spin_unlock(&global_rsv->lock);
+
+	btrfs_block_rsv_add_bytes(dest, num_bytes, true);
+	return 0;
+}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d1fce37107b4..23bce6b89c6e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4370,58 +4370,6 @@ static struct btrfs_block_rsv *get_block_rsv(
 	return block_rsv;
 }
 
-int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
-			      u64 num_bytes)
-{
-	int ret = -ENOSPC;
-	spin_lock(&block_rsv->lock);
-	if (block_rsv->reserved >= num_bytes) {
-		block_rsv->reserved -= num_bytes;
-		if (block_rsv->reserved < block_rsv->size)
-			block_rsv->full = 0;
-		ret = 0;
-	}
-	spin_unlock(&block_rsv->lock);
-	return ret;
-}
-
-void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
-			       u64 num_bytes, bool update_size)
-{
-	spin_lock(&block_rsv->lock);
-	block_rsv->reserved += num_bytes;
-	if (update_size)
-		block_rsv->size += num_bytes;
-	else if (block_rsv->reserved >= block_rsv->size)
-		block_rsv->full = 1;
-	spin_unlock(&block_rsv->lock);
-}
-
-int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *dest, u64 num_bytes,
-			     int min_factor)
-{
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	u64 min_bytes;
-
-	if (global_rsv->space_info != dest->space_info)
-		return -ENOSPC;
-
-	spin_lock(&global_rsv->lock);
-	min_bytes = div_factor(global_rsv->size, min_factor);
-	if (global_rsv->reserved < min_bytes + num_bytes) {
-		spin_unlock(&global_rsv->lock);
-		return -ENOSPC;
-	}
-	global_rsv->reserved -= num_bytes;
-	if (global_rsv->reserved < global_rsv->size)
-		global_rsv->full = 0;
-	spin_unlock(&global_rsv->lock);
-
-	btrfs_block_rsv_add_bytes(dest, num_bytes, true);
-	return 0;
-}
-
 /**
  * btrfs_migrate_to_delayed_refs_rsv - transfer bytes to our delayed refs rsv.
  * @fs_info - the fs info for our fs.
@@ -4507,203 +4455,6 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_block_rsv *block_rsv,
-				    struct btrfs_block_rsv *dest, u64 num_bytes,
-				    u64 *qgroup_to_release_ret)
-{
-	struct btrfs_space_info *space_info = block_rsv->space_info;
-	u64 qgroup_to_release = 0;
-	u64 ret;
-
-	spin_lock(&block_rsv->lock);
-	if (num_bytes == (u64)-1) {
-		num_bytes = block_rsv->size;
-		qgroup_to_release = block_rsv->qgroup_rsv_size;
-	}
-	block_rsv->size -= num_bytes;
-	if (block_rsv->reserved >= block_rsv->size) {
-		num_bytes = block_rsv->reserved - block_rsv->size;
-		block_rsv->reserved = block_rsv->size;
-		block_rsv->full = 1;
-	} else {
-		num_bytes = 0;
-	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
-		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
-				    block_rsv->qgroup_rsv_size;
-		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
-	} else {
-		qgroup_to_release = 0;
-	}
-	spin_unlock(&block_rsv->lock);
-
-	ret = num_bytes;
-	if (num_bytes > 0) {
-		if (dest) {
-			spin_lock(&dest->lock);
-			if (!dest->full) {
-				u64 bytes_to_add;
-
-				bytes_to_add = dest->size - dest->reserved;
-				bytes_to_add = min(num_bytes, bytes_to_add);
-				dest->reserved += bytes_to_add;
-				if (dest->reserved >= dest->size)
-					dest->full = 1;
-				num_bytes -= bytes_to_add;
-			}
-			spin_unlock(&dest->lock);
-		}
-		if (num_bytes)
-			btrfs_space_info_add_old_bytes(fs_info, space_info,
-						       num_bytes);
-	}
-	if (qgroup_to_release_ret)
-		*qgroup_to_release_ret = qgroup_to_release;
-	return ret;
-}
-
-int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
-			    struct btrfs_block_rsv *dst, u64 num_bytes,
-			    bool update_size)
-{
-	int ret;
-
-	ret = btrfs_block_rsv_use_bytes(src, num_bytes);
-	if (ret)
-		return ret;
-
-	btrfs_block_rsv_add_bytes(dst, num_bytes, update_size);
-	return 0;
-}
-
-void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type)
-{
-	memset(rsv, 0, sizeof(*rsv));
-	spin_lock_init(&rsv->lock);
-	rsv->type = type;
-}
-
-void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
-				   struct btrfs_block_rsv *rsv,
-				   unsigned short type)
-{
-	btrfs_init_block_rsv(rsv, type);
-	rsv->space_info = btrfs_find_space_info(fs_info,
-					    BTRFS_BLOCK_GROUP_METADATA);
-}
-
-struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      unsigned short type)
-{
-	struct btrfs_block_rsv *block_rsv;
-
-	block_rsv = kmalloc(sizeof(*block_rsv), GFP_NOFS);
-	if (!block_rsv)
-		return NULL;
-
-	btrfs_init_metadata_block_rsv(fs_info, block_rsv, type);
-	return block_rsv;
-}
-
-void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_rsv *rsv)
-{
-	if (!rsv)
-		return;
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
-	kfree(rsv);
-}
-
-int btrfs_block_rsv_add(struct btrfs_root *root,
-			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
-			enum btrfs_reserve_flush_enum flush)
-{
-	int ret;
-
-	if (num_bytes == 0)
-		return 0;
-
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
-	if (!ret)
-		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, true);
-
-	return ret;
-}
-
-int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
-{
-	u64 num_bytes = 0;
-	int ret = -ENOSPC;
-
-	if (!block_rsv)
-		return 0;
-
-	spin_lock(&block_rsv->lock);
-	num_bytes = div_factor(block_rsv->size, min_factor);
-	if (block_rsv->reserved >= num_bytes)
-		ret = 0;
-	spin_unlock(&block_rsv->lock);
-
-	return ret;
-}
-
-int btrfs_block_rsv_refill(struct btrfs_root *root,
-			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
-			   enum btrfs_reserve_flush_enum flush)
-{
-	u64 num_bytes = 0;
-	int ret = -ENOSPC;
-
-	if (!block_rsv)
-		return 0;
-
-	spin_lock(&block_rsv->lock);
-	num_bytes = min_reserved;
-	if (block_rsv->reserved >= num_bytes)
-		ret = 0;
-	else
-		num_bytes -= block_rsv->reserved;
-	spin_unlock(&block_rsv->lock);
-
-	if (!ret)
-		return 0;
-
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
-	if (!ret) {
-		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
-		return 0;
-	}
-
-	return ret;
-}
-
-u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-			      struct btrfs_block_rsv *block_rsv,
-			      u64 num_bytes, u64 *qgroup_to_release)
-{
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
-	struct btrfs_block_rsv *target = NULL;
-
-	/*
-	 * If we are the delayed_rsv then push to the global rsv, otherwise dump
-	 * into the delayed rsv if it is not full.
-	 */
-	if (block_rsv == delayed_rsv) {
-		target = global_rsv;
-	} else if (block_rsv != global_rsv) {
-		if (!delayed_rsv->full)
-			target = delayed_rsv;
-	}
-
-	if (target && block_rsv->space_info != target->space_info)
-		target = NULL;
-
-	return block_rsv_release_bytes(fs_info, block_rsv, target, num_bytes,
-				       qgroup_to_release);
-}
-
 /**
  * btrfs_inode_rsv_release - release any excessive reservation.
  * @inode - the inode we need to release from.
-- 
2.14.3

