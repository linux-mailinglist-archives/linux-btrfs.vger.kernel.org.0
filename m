Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B64DA52
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTTiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:21 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37095 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFTTiU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id 186so1677750ywo.4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SHhPxX2GoI34deta+odVIYrDQ0OKyF/FGgdaroeOugc=;
        b=dX/IrL1eRQEvrwv2HtfuZIDaPs8qZla9zFFX2Mi7WBLqEGoSshFtECWBZYXdo2fqYs
         C/g0cn9qRkYHVi5297Q2RBx6xE8cJAD/OrZXjmokbfoTgJxyMvWVFy7599VrG+FX1or0
         /Mnv9R3Qx1JGQnuAOCBNbyEl4UQLEjWq2uCQVNnAaSOnU+ypQmBi+fJcC+XMY5Uh+KhS
         1kMLOzqQ9abhJtRWhYEO8fVQfRQcVJvtlcNRd1cwPzoA8qk/2L61ApoTjt1v1f2ly9t8
         651DhisvfHuUDH6CjKXBYxYiFZ4vL2qQjd33sJz6g8PouwDvx4AEdqVcvGl7lHae7QC4
         UM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=SHhPxX2GoI34deta+odVIYrDQ0OKyF/FGgdaroeOugc=;
        b=Cn6ZpX7vsysJESK94UvvTgika7GHnI47aR2s5fhNBqUhdPxP50eix8QLH3HFf/oO8l
         vztMuYO/SZolbbTPdcTWWzyP1VJXVk9fSVO2yNORboO4WbZvHEHcKXicRRVpd9p0lNPC
         BLYwk6OAu1/T/ImPP9+3e0YnmGF1mVTZKfrEACeiY1SgRGGx659otr+rW6zq8Vezlk2W
         onD7wi5cBmIr2lz8ir+jvXpLt1mjJO2hvFjugg5LbpenjKjIJhgeeKN1dpQpW8Gw3r7f
         5wsyPUeXmyeM9Zq9y4GXtkbbkYCpsqfTQYwP6JN1G9jPVbkb2ssZ4BCRzr2a0vyJvgx/
         iA/g==
X-Gm-Message-State: APjAAAUbTggp8cMLur7Yi+Y01m6OxOkx4esJPhST/XF7P2UYve4M6KAk
        YWoHOxb7dz+ElF5styIYKlOGIJkPE5E36w==
X-Google-Smtp-Source: APXvYqybvapx2DFo7w/w/kVm7oC1u4QSp5Ldtdr5uN2S7pUHw2HRG+0ddVl6yqEeHJFoUXKnrEAPfw==
X-Received: by 2002:a81:35c9:: with SMTP id c192mr67038978ywa.193.1561059499367;
        Thu, 20 Jun 2019 12:38:19 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j207sm123760ywj.35.2019.06.20.12.38.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/25] btrfs: export the block group caching helpers
Date:   Thu, 20 Jun 2019 15:37:48 -0400
Message-Id: <20190620193807.29311-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will make it so we can move them easily.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h | 14 +++++++++++
 fs/btrfs/extent-tree.c | 65 ++++++++++++++++++++++----------------------------
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index bc2ed52210a3..c8a63ccd6b58 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -167,5 +167,19 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg);
 bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg);
+void
+btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
+				      u64 num_bytes);
+int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache);
+int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
+			    int load_cache_only);
+
+static inline int
+btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
+{
+	smp_mb();
+	return cache->cached == BTRFS_CACHE_FINISHED ||
+		cache->cached == BTRFS_CACHE_ERROR;
+}
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 63b594532b92..82451a64f8ee 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -54,14 +54,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 static int find_next_key(struct btrfs_path *path, int level,
 			 struct btrfs_key *key);
 
-static noinline int
-block_group_cache_done(struct btrfs_block_group_cache *cache)
-{
-	smp_mb();
-	return cache->cached == BTRFS_CACHE_FINISHED ||
-		cache->cached == BTRFS_CACHE_ERROR;
-}
-
 static int block_group_bits(struct btrfs_block_group_cache *cache, u64 bits)
 {
 	return (cache->flags & bits) == bits;
@@ -234,9 +226,10 @@ static void fragment_free_space(struct btrfs_block_group_cache *block_group)
 #endif
 
 /*
- * this is only called by cache_block_group, since we could have freed extents
- * we need to check the pinned_extents for any extents that can't be used yet
- * since their free space will be released as soon as the transaction commits.
+ * this is only called by btrfs_cache_block_group, since we could have freed
+ * extents we need to check the pinned_extents for any extents that can't be
+ * used yet since their free space will be released as soon as the transaction
+ * commits.
  */
 u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
 		       u64 start, u64 end)
@@ -465,8 +458,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 	btrfs_put_block_group(block_group);
 }
 
-static int cache_block_group(struct btrfs_block_group_cache *cache,
-			     int load_cache_only)
+static int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
+				   int load_cache_only)
 {
 	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -3982,7 +3975,7 @@ static int update_block_group(struct btrfs_trans_handle *trans,
 		 * space back to the block group, otherwise we will leak space.
 		 */
 		if (!alloc && cache->cached == BTRFS_CACHE_NO)
-			cache_block_group(cache, 1);
+			btrfs_cache_block_group(cache, 1);
 
 		byte_in_group = bytenr - cache->key.objectid;
 		WARN_ON(byte_in_group > cache->key.offset);
@@ -4140,7 +4133,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
 	 * to one because the slow code to read in the free extents does check
 	 * the pinned extents.
 	 */
-	cache_block_group(cache, 1);
+	btrfs_cache_block_group(cache, 1);
 
 	pin_down_extent(cache, bytenr, num_bytes, 0);
 
@@ -4161,12 +4154,12 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 	if (!block_group)
 		return -EINVAL;
 
-	cache_block_group(block_group, 0);
+	btrfs_cache_block_group(block_group, 0);
 	caching_ctl = get_caching_control(block_group);
 
 	if (!caching_ctl) {
 		/* Logic error */
-		BUG_ON(!block_group_cache_done(block_group));
+		BUG_ON(!btrfs_block_group_cache_done(block_group));
 		ret = btrfs_remove_free_space(block_group, start, num_bytes);
 	} else {
 		mutex_lock(&caching_ctl->mutex);
@@ -4310,7 +4303,7 @@ void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 	list_for_each_entry_safe(caching_ctl, next,
 				 &fs_info->caching_block_groups, list) {
 		cache = caching_ctl->block_group;
-		if (block_group_cache_done(cache)) {
+		if (btrfs_block_group_cache_done(cache)) {
 			cache->last_byte_to_unpin = (u64)-1;
 			list_del_init(&caching_ctl->list);
 			put_caching_control(caching_ctl);
@@ -4942,9 +4935,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
  * Callers of this must check if cache->cached == BTRFS_CACHE_ERROR before using
  * any of the information in this block group.
  */
-static noinline void
-wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
-				u64 num_bytes)
+void
+btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
+				      u64 num_bytes)
 {
 	struct btrfs_caching_control *caching_ctl;
 
@@ -4952,14 +4945,13 @@ wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
 	if (!caching_ctl)
 		return;
 
-	wait_event(caching_ctl->wait, block_group_cache_done(cache) ||
+	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache) ||
 		   (cache->free_space_ctl->free_space >= num_bytes));
 
 	put_caching_control(caching_ctl);
 }
 
-static noinline int
-wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
+int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
@@ -4968,7 +4960,7 @@ wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 	if (!caching_ctl)
 		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
 
-	wait_event(caching_ctl->wait, block_group_cache_done(cache));
+	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache));
 	if (cache->cached == BTRFS_CACHE_ERROR)
 		ret = -EIO;
 	put_caching_control(caching_ctl);
@@ -5194,8 +5186,9 @@ static int find_free_extent_clustered(struct btrfs_block_group_cache *bg,
 		spin_unlock(&last_ptr->refill_lock);
 
 		ffe_ctl->retry_clustered = true;
-		wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
-				ffe_ctl->empty_cluster + ffe_ctl->empty_size);
+		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
+						      ffe_ctl->empty_cluster +
+						      ffe_ctl->empty_size);
 		return -EAGAIN;
 	}
 	/*
@@ -5261,8 +5254,8 @@ static int find_free_extent_unclustered(struct btrfs_block_group_cache *bg,
 	 */
 	if (!offset && !ffe_ctl->retry_unclustered && !ffe_ctl->cached &&
 	    ffe_ctl->loop > LOOP_CACHING_NOWAIT) {
-		wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
-						ffe_ctl->empty_size);
+		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
+						      ffe_ctl->empty_size);
 		ffe_ctl->retry_unclustered = true;
 		return -EAGAIN;
 	} else if (!offset) {
@@ -5562,10 +5555,10 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		}
 
 have_block_group:
-		ffe_ctl.cached = block_group_cache_done(block_group);
+		ffe_ctl.cached = btrfs_block_group_cache_done(block_group);
 		if (unlikely(!ffe_ctl.cached)) {
 			ffe_ctl.have_caching_bg = true;
-			ret = cache_block_group(block_group, 0);
+			ret = btrfs_cache_block_group(block_group, 0);
 			BUG_ON(ret < 0);
 			ret = 0;
 		}
@@ -7569,7 +7562,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 
 		block_group = btrfs_lookup_first_block_group(info, last);
 		while (block_group) {
-			wait_block_group_cache_done(block_group);
+			btrfs_wait_block_group_cache_done(block_group);
 			spin_lock(&block_group->lock);
 			if (block_group->iref)
 				break;
@@ -8314,7 +8307,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (block_group->has_caching_ctl)
 		caching_ctl = get_caching_control(block_group);
 	if (block_group->cached == BTRFS_CACHE_STARTED)
-		wait_block_group_cache_done(block_group);
+		btrfs_wait_block_group_cache_done(block_group);
 	if (block_group->has_caching_ctl) {
 		down_write(&fs_info->commit_root_sem);
 		if (!caching_ctl) {
@@ -8775,14 +8768,14 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 				cache->key.objectid + cache->key.offset);
 
 		if (end - start >= range->minlen) {
-			if (!block_group_cache_done(cache)) {
-				ret = cache_block_group(cache, 0);
+			if (!btrfs_block_group_cache_done(cache)) {
+				ret = btrfs_cache_block_group(cache, 0);
 				if (ret) {
 					bg_failed++;
 					bg_ret = ret;
 					continue;
 				}
-				ret = wait_block_group_cache_done(cache);
+				ret = btrfs_wait_block_group_cache_done(cache);
 				if (ret) {
 					bg_failed++;
 					bg_ret = ret;
-- 
2.14.3

