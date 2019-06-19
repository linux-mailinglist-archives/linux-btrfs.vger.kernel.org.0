Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594DE4C031
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfFSRrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35632 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfFSRrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so41752qto.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ac76GIj+V4JthUD5/WgER5vA4Kn1J8VHSlTlWHVvat0=;
        b=a0zGLXE7SEXhqLkD6xvxBNXOGYqz4oTt9rKRSzyACDyGBfMqj1po9Yn8Dy1ZiSl2Gr
         rjqHrmbfR7KPW2mHSGzxX4kxmvi5PmdMo6k/WviPLw8hIEFR4pZHdc3aK4ARk776vxTk
         tpER3X9lT5td6eBXJp6vFgW9V2BivDEMjCnPrGzy1XV72vHnMZ4h/As5VYkZf5/q3hlC
         YmV4PvV4aCerSdkYkgH2+WiEKHIyfVbWNcLTia3xndqzcv8Po34xH7J9BQ78+LSSPS9O
         ROU3/9mnrG242r3xpbhDtPwOa+DOMLKQ5Qw3/wRBfRb6UTGS2t1LvjHfa6Up2tQL9X/V
         jUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ac76GIj+V4JthUD5/WgER5vA4Kn1J8VHSlTlWHVvat0=;
        b=jEvW2kaDrEaZ2lQ/6PaMIIJeYXbrsmcqXL7x6pO/mXt3HVEKQBGibylUxcE58ErQrg
         PL+zB7gilVeEu5d8QG2+nC0gZPIM53bJlRB7BaQh5rf2UeorjxpqVYe54bzbYF0U+uDb
         yvOemY45gLGI0Z1Fb94swmIhlgxbgoOnvj1oOoGHhncEMQgXLXNSNbZHFcLC8tL098Is
         ae9erwDOnt+XYiMt+CeQ2+BQ3KYd0DRcC7sr1rstvnGEq6ZYEmT8P6cN1t33WkN3CRhj
         eQBTnSIon2u6JIDhoHDrqQv3p1hxQiAKcLhfeES1hFGBCBeE7PuO5KIfKwDqm7BQKTVs
         SO1w==
X-Gm-Message-State: APjAAAVpwK3ttYzsDr9HPCPk7srfPl3woOkOtkcZqvBrYo9BCPDEnA/o
        FbejKTj3mtsl1l03QS/wdrHFrCJg3j29xw==
X-Google-Smtp-Source: APXvYqz1701XBEMGzsdCZyKRpGAVZMoZWs4nq5KqFZForIaI6QpSxgGFfFhMhHt4qpxL//qzZNzHiw==
X-Received: by 2002:ac8:7652:: with SMTP id i18mr96965365qtr.10.1560966460953;
        Wed, 19 Jun 2019 10:47:40 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a6sm6473771qth.76.2019.06.19.10.47.40
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: export and migrate use_block_rsv/unuse_block_rsv
Date:   Wed, 19 Jun 2019 13:47:24 -0400
Message-Id: <20190619174724.1675-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move these into block_rsv.c/h respectively, and export them for use by
alloc_tree_block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   | 82 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-rsv.h   | 13 ++++++-
 fs/btrfs/extent-tree.c | 92 ++------------------------------------------------
 3 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index bdc798d2ee5a..9754b2ca8126 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -6,6 +6,7 @@
 #include "block-rsv.h"
 #include "space-info.h"
 #include "math.h"
+#include "transaction.h"
 
 static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_rsv *block_rsv,
@@ -345,3 +346,84 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
 	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
 	WARN_ON(fs_info->delayed_refs_rsv.size > 0);
 }
+
+static struct btrfs_block_rsv *get_block_rsv(
+					const struct btrfs_trans_handle *trans,
+					const struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_block_rsv *block_rsv = NULL;
+
+	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+	    (root == fs_info->csum_root && trans->adding_csums) ||
+	    (root == fs_info->uuid_root))
+		block_rsv = trans->block_rsv;
+
+	if (!block_rsv)
+		block_rsv = root->block_rsv;
+
+	if (!block_rsv)
+		block_rsv = &fs_info->empty_block_rsv;
+
+	return block_rsv;
+}
+
+struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
+					    struct btrfs_root *root,
+					    u32 blocksize)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_block_rsv *block_rsv;
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	int ret;
+	bool global_updated = false;
+
+	block_rsv = get_block_rsv(trans, root);
+
+	if (unlikely(block_rsv->size == 0))
+		goto try_reserve;
+again:
+	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
+	if (!ret)
+		return block_rsv;
+
+	if (block_rsv->failfast)
+		return ERR_PTR(ret);
+
+	if (block_rsv->type == BTRFS_BLOCK_RSV_GLOBAL && !global_updated) {
+		global_updated = true;
+		btrfs_update_global_block_rsv(fs_info);
+		goto again;
+	}
+
+	/*
+	 * The global reserve still exists to save us from ourselves, so don't
+	 * warn_on if we are short on our delayed refs reserve.
+	 */
+	if (block_rsv->type != BTRFS_BLOCK_RSV_DELREFS &&
+	    btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
+		static DEFINE_RATELIMIT_STATE(_rs,
+				DEFAULT_RATELIMIT_INTERVAL * 10,
+				/*DEFAULT_RATELIMIT_BURST*/ 1);
+		if (__ratelimit(&_rs))
+			WARN(1, KERN_DEBUG
+				"BTRFS: block rsv returned %d\n", ret);
+	}
+try_reserve:
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, blocksize,
+					   BTRFS_RESERVE_NO_FLUSH);
+	if (!ret)
+		return block_rsv;
+	/*
+	 * If we couldn't reserve metadata bytes try and use some from
+	 * the global reserve if its space type is the same as the global
+	 * reservation.
+	 */
+	if (block_rsv->type != BTRFS_BLOCK_RSV_GLOBAL &&
+	    block_rsv->space_info == global_rsv->space_info) {
+		ret = btrfs_block_rsv_use_bytes(global_rsv, blocksize);
+		if (!ret)
+			return global_rsv;
+	}
+	return ERR_PTR(ret);
+}
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 8f302d1ac5e2..3dc49dc3c01d 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -6,7 +6,7 @@
 #ifndef BTRFS_BLOCK_RSV_H
 #define BTRFS_BLOCK_RSV_H
 
-
+struct btrfs_trans_handle;
 enum btrfs_reserve_flush_enum;
 
 /*
@@ -83,6 +83,9 @@ u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info);
 void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info);
 void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info);
+struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
+					    struct btrfs_root *root,
+					    u32 blocksize);
 
 static inline void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 					   struct btrfs_block_rsv *block_rsv,
@@ -90,4 +93,12 @@ static inline void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 {
 	__btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 }
+
+static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
+					 struct btrfs_block_rsv *block_rsv,
+					 u32 blocksize)
+{
+	btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
+	btrfs_block_rsv_release(fs_info, block_rsv, 0);
+}
 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5884b06dd15d..dffd338b01fc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4349,27 +4349,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-static struct btrfs_block_rsv *get_block_rsv(
-					const struct btrfs_trans_handle *trans,
-					const struct btrfs_root *root)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *block_rsv = NULL;
-
-	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
-	    (root == fs_info->csum_root && trans->adding_csums) ||
-	    (root == fs_info->uuid_root))
-		block_rsv = trans->block_rsv;
-
-	if (!block_rsv)
-		block_rsv = root->block_rsv;
-
-	if (!block_rsv)
-		block_rsv = &fs_info->empty_block_rsv;
-
-	return block_rsv;
-}
-
 /**
  * btrfs_migrate_to_delayed_refs_rsv - transfer bytes to our delayed refs rsv.
  * @fs_info - the fs info for our fs.
@@ -7037,73 +7016,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return buf;
 }
 
-static struct btrfs_block_rsv *
-use_block_rsv(struct btrfs_trans_handle *trans,
-	      struct btrfs_root *root, u32 blocksize)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *block_rsv;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	int ret;
-	bool global_updated = false;
-
-	block_rsv = get_block_rsv(trans, root);
-
-	if (unlikely(block_rsv->size == 0))
-		goto try_reserve;
-again:
-	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
-	if (!ret)
-		return block_rsv;
-
-	if (block_rsv->failfast)
-		return ERR_PTR(ret);
-
-	if (block_rsv->type == BTRFS_BLOCK_RSV_GLOBAL && !global_updated) {
-		global_updated = true;
-		btrfs_update_global_block_rsv(fs_info);
-		goto again;
-	}
-
-	/*
-	 * The global reserve still exists to save us from ourselves, so don't
-	 * warn_on if we are short on our delayed refs reserve.
-	 */
-	if (block_rsv->type != BTRFS_BLOCK_RSV_DELREFS &&
-	    btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
-		static DEFINE_RATELIMIT_STATE(_rs,
-				DEFAULT_RATELIMIT_INTERVAL * 10,
-				/*DEFAULT_RATELIMIT_BURST*/ 1);
-		if (__ratelimit(&_rs))
-			WARN(1, KERN_DEBUG
-				"BTRFS: block rsv returned %d\n", ret);
-	}
-try_reserve:
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, blocksize,
-					   BTRFS_RESERVE_NO_FLUSH);
-	if (!ret)
-		return block_rsv;
-	/*
-	 * If we couldn't reserve metadata bytes try and use some from
-	 * the global reserve if its space type is the same as the global
-	 * reservation.
-	 */
-	if (block_rsv->type != BTRFS_BLOCK_RSV_GLOBAL &&
-	    block_rsv->space_info == global_rsv->space_info) {
-		ret = btrfs_block_rsv_use_bytes(global_rsv, blocksize);
-		if (!ret)
-			return global_rsv;
-	}
-	return ERR_PTR(ret);
-}
-
-static void unuse_block_rsv(struct btrfs_fs_info *fs_info,
-			    struct btrfs_block_rsv *block_rsv, u32 blocksize)
-{
-	btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
-	btrfs_block_rsv_release(fs_info, block_rsv, 0);
-}
-
 /*
  * finds a free extent and does all the dirty work required for allocation
  * returns the tree buffer or an ERR_PTR on error.
@@ -7136,7 +7048,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	}
 #endif
 
-	block_rsv = use_block_rsv(trans, root, blocksize);
+	block_rsv = btrfs_use_block_rsv(trans, root, blocksize);
 	if (IS_ERR(block_rsv))
 		return ERR_CAST(block_rsv);
 
@@ -7194,7 +7106,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 out_free_reserved:
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 0);
 out_unuse:
-	unuse_block_rsv(fs_info, block_rsv, blocksize);
+	btrfs_unuse_block_rsv(fs_info, block_rsv, blocksize);
 	return ERR_PTR(ret);
 }
 
-- 
2.14.3

