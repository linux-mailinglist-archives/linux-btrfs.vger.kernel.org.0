Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE44DA51
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFTTiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41783 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTiT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so4375724qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=U0halpEC7x+kTO0lyD10AwJ15J9g52O738mFilSAooI=;
        b=rsPk5Dya8TtG5ZRRgdSnLpgAgGFy7KMKaJSF+82kanlC/Dz6W5kmYQR393b0r6/E2W
         ZYOv1rLPjK0yX7KjQ0I+wlChauU5J6xxpT9kKoujfH+XSujQ5VXCPcBhOSV75Qn42CWD
         dkXqwM/hVNLsX9V9/ubFyZLmzg9nQMcIChNWjuS6PgEUtzbN3poq7JqrQ8qO5vY5hzTr
         Eq+KJZtnd8FZmhe932llLieuux0pPeMeTuBibhrXJ9uTKImhRb26m1prBc7c56tJ3a7B
         972n5wEHJOtIqK+0BlN7IFJVJeJbP+YLziKOf9G8f/piT7j5nTxqaVGuJZdAhZW25bLV
         9L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=U0halpEC7x+kTO0lyD10AwJ15J9g52O738mFilSAooI=;
        b=JCWqgYhmKJGWg5JWkxahokV9TyoxJhJQEU6NHxLdluOUzJBL9ask14VN3xwPo2VajD
         h4ZB6Bj+ejbRu0TCu+jP6oMDMkIWxZ/RSkucm6h9zQ2iJKjgBXqoCfmQt+r0CRb1mr8D
         S0sTKyy1sX0iO5U9vuP182ovAxN/HTuDtsxzRCvVhCYqQdVHB0rNLcXSNvjnu/lM/MPY
         4BgPehuTLYj/68Kx851LX11UB7+J31VB1fSXx/1/JlXYVUogZ8bXp5qEMyNcYxTEwd6h
         pMoTnI+AS33JNO3IRLQ072MSGRzgNmBsrQU/ZLMDAb+ny9AOkST4BWtqa2OHy4DRjzDx
         54Gw==
X-Gm-Message-State: APjAAAVg7aXv5JyJqQeFuy/cIbrcO4nVCb3Djh2LO+CxZNaS+Mjv+ADI
        s01GAAzhfzPr5axeJNyFeZj1dzsZtAgevQ==
X-Google-Smtp-Source: APXvYqz68bXC5JKZs2KOEEMnPD5AYVQZPlCOVYiUwi6LvSMjfD5j4w3krZY430eEyzKz+QQRFwilzg==
X-Received: by 2002:ac8:28e2:: with SMTP id j31mr73747306qtj.274.1561059497852;
        Thu, 20 Jun 2019 12:38:17 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u4sm298233qkb.16.2019.06.20.12.38.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/25] btrfs: migrate nocow and reservation helpers
Date:   Thu, 20 Jun 2019 15:37:47 -0400
Message-Id: <20190620193807.29311-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are relatively straightforward as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |  6 ++++
 fs/btrfs/ctree.h       |  6 ----
 fs/btrfs/extent-tree.c | 82 -------------------------------------------------
 4 files changed, 89 insertions(+), 88 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b15d7070bcfd..aeb2c806b2b0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4,6 +4,7 @@
  */
 #include "ctree.h"
 #include "block-group.h"
+#include "space-info.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -121,3 +122,85 @@ btrfs_next_block_group(struct btrfs_block_group_cache *cache)
 	spin_unlock(&fs_info->block_group_cache_lock);
 	return cache;
 }
+
+bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group_cache *bg;
+	bool ret = true;
+
+	bg = btrfs_lookup_block_group(fs_info, bytenr);
+	if (!bg)
+		return false;
+
+	spin_lock(&bg->lock);
+	if (bg->ro)
+		ret = false;
+	else
+		atomic_inc(&bg->nocow_writers);
+	spin_unlock(&bg->lock);
+
+	/* no put on block group, done by btrfs_dec_nocow_writers */
+	if (!ret)
+		btrfs_put_block_group(bg);
+
+	return ret;
+
+}
+
+void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group_cache *bg;
+
+	bg = btrfs_lookup_block_group(fs_info, bytenr);
+	ASSERT(bg);
+	if (atomic_dec_and_test(&bg->nocow_writers))
+		wake_up_var(&bg->nocow_writers);
+	/*
+	 * Once for our lookup and once for the lookup done by a previous call
+	 * to btrfs_inc_nocow_writers()
+	 */
+	btrfs_put_block_group(bg);
+	btrfs_put_block_group(bg);
+}
+
+void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg)
+{
+	wait_var_event(&bg->nocow_writers, !atomic_read(&bg->nocow_writers));
+}
+
+void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
+					const u64 start)
+{
+	struct btrfs_block_group_cache *bg;
+
+	bg = btrfs_lookup_block_group(fs_info, start);
+	ASSERT(bg);
+	if (atomic_dec_and_test(&bg->reservations))
+		wake_up_var(&bg->reservations);
+	btrfs_put_block_group(bg);
+}
+
+void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg)
+{
+	struct btrfs_space_info *space_info = bg->space_info;
+
+	ASSERT(bg->ro);
+
+	if (!(bg->flags & BTRFS_BLOCK_GROUP_DATA))
+		return;
+
+	/*
+	 * Our block group is read only but before we set it to read only,
+	 * some task might have had allocated an extent from it already, but it
+	 * has not yet created a respective ordered extent (and added it to a
+	 * root's list of ordered extents).
+	 * Therefore wait for any task currently allocating extents, since the
+	 * block group's reservations counter is incremented while a read lock
+	 * on the groups' semaphore is held and decremented after releasing
+	 * the read access on that semaphore and creating the ordered extent.
+	 */
+	down_write(&space_info->groups_sem);
+	up_write(&space_info->groups_sem);
+
+	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index ddd91c7ed44a..bc2ed52210a3 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -161,5 +161,11 @@ struct btrfs_block_group_cache *
 btrfs_next_block_group(struct btrfs_block_group_cache *cache);
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group(struct btrfs_block_group_cache *cache);
+void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
+					 const u64 start);
+void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg);
+bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
+void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
+void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4c6e643bc65d..c4ae6714e3d4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2460,12 +2460,6 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
 }
 
-void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
-					 const u64 start);
-void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg);
-bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
-void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
-void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 01a45674382e..63b594532b92 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3560,51 +3560,6 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return readonly;
 }
 
-bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct btrfs_block_group_cache *bg;
-	bool ret = true;
-
-	bg = btrfs_lookup_block_group(fs_info, bytenr);
-	if (!bg)
-		return false;
-
-	spin_lock(&bg->lock);
-	if (bg->ro)
-		ret = false;
-	else
-		atomic_inc(&bg->nocow_writers);
-	spin_unlock(&bg->lock);
-
-	/* no put on block group, done by btrfs_dec_nocow_writers */
-	if (!ret)
-		btrfs_put_block_group(bg);
-
-	return ret;
-
-}
-
-void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct btrfs_block_group_cache *bg;
-
-	bg = btrfs_lookup_block_group(fs_info, bytenr);
-	ASSERT(bg);
-	if (atomic_dec_and_test(&bg->nocow_writers))
-		wake_up_var(&bg->nocow_writers);
-	/*
-	 * Once for our lookup and once for the lookup done by a previous call
-	 * to btrfs_inc_nocow_writers()
-	 */
-	btrfs_put_block_group(bg);
-	btrfs_put_block_group(bg);
-}
-
-void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg)
-{
-	wait_var_event(&bg->nocow_writers, !atomic_read(&bg->nocow_writers));
-}
-
 static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	u64 extra_flags = chunk_to_extended(flags) &
@@ -4279,43 +4234,6 @@ btrfs_inc_block_group_reservations(struct btrfs_block_group_cache *bg)
 	atomic_inc(&bg->reservations);
 }
 
-void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
-					const u64 start)
-{
-	struct btrfs_block_group_cache *bg;
-
-	bg = btrfs_lookup_block_group(fs_info, start);
-	ASSERT(bg);
-	if (atomic_dec_and_test(&bg->reservations))
-		wake_up_var(&bg->reservations);
-	btrfs_put_block_group(bg);
-}
-
-void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg)
-{
-	struct btrfs_space_info *space_info = bg->space_info;
-
-	ASSERT(bg->ro);
-
-	if (!(bg->flags & BTRFS_BLOCK_GROUP_DATA))
-		return;
-
-	/*
-	 * Our block group is read only but before we set it to read only,
-	 * some task might have had allocated an extent from it already, but it
-	 * has not yet created a respective ordered extent (and added it to a
-	 * root's list of ordered extents).
-	 * Therefore wait for any task currently allocating extents, since the
-	 * block group's reservations counter is incremented while a read lock
-	 * on the groups' semaphore is held and decremented after releasing
-	 * the read access on that semaphore and creating the ordered extent.
-	 */
-	down_write(&space_info->groups_sem);
-	up_write(&space_info->groups_sem);
-
-	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
-}
-
 /**
  * btrfs_add_reserved_bytes - update the block_group and space info counters
  * @cache:	The cache we are manipulating
-- 
2.14.3

