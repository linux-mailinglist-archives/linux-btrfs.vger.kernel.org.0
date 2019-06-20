Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5D4DA53
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfFTTiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:23 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45478 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:22 -0400
Received: by mail-yb1-f196.google.com with SMTP id v104so1653757ybi.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7AuFZ+3qPDMEDsRyZwzeYvzb73Dd0PtvLIPiDxQgQ7k=;
        b=AOZbQgY+HADCYMF7SamMmzYv57B2dEf0hEv3UAPebNo/JIvpQykka6QERoOnd62Fas
         ux4AZ8aScavIQK87nM/vx1N/+tgHB0tKH/9+WN7NkbG4sI7W3mQJ76wk6ZiuNw1Z0jw1
         QUE40BG4DtxaiC/BWLnzbaxJ1XbVIi0bwEZO10Evv2x1tztfaF+HQNoFOSu6gfGWXUUP
         9RvxGfffA96fTgvQ6+rwjEkaHvqWJ0Nh5pLwqG0L3IVK+5CTCq3LG+6ICgQzvJ8x7wuB
         9u9n+7XXgwwWvUq8VYQfKQKeAQn5C+MJZe7yo8TQqI9Spa6gzBIIW0o910yPoWCxyn59
         AWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7AuFZ+3qPDMEDsRyZwzeYvzb73Dd0PtvLIPiDxQgQ7k=;
        b=paoM/jV5INnWXaAeq49qJz982y3IeWMDamHpRqDhtySsBQ/9Tteq3ReDRpoKCfboPH
         ibmX2K/MsdcwnYQRLYOWZ8tkWfBkE8gbJ7u0kcvOOW0nnfvGUpxjR/jtS976iTzneufo
         +mMnZH2uzQkOkC5mw/dIYHyLyjzhZVr7i0+tr5tUg7jwW9oKHcfFc3OfmZv5+yBOlQVZ
         43q3t2YX2yRzUIsGHAKkBKMpHFhSoaIoG51qZpir8vLDeyZDR+QV3bKEXVxn/P193POR
         o47RI7TLAG3GzqC7ZFdZSjVMnS2pM1Y3Lfm4lfreFgg77TWPqQg+BGOgF9BYxI1HfxJb
         jckA==
X-Gm-Message-State: APjAAAV9jEEamrFuitB0w7YVfeRdbkRWklFiLdZgUFFpD98hK+HjwYEV
        NhgjGfXI0oQAauspO4dwCpFBoBvT+kpe7A==
X-Google-Smtp-Source: APXvYqzGwPKGNGS1fzvbzLwbSRe3Qj7gtkbdfJTVEiGX8Wq5qf96NOb/6EAWm3Lz4HgF24jUblOM6A==
X-Received: by 2002:a25:43:: with SMTP id 64mr66090938yba.115.1561059500947;
        Thu, 20 Jun 2019 12:38:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p141sm103334ywg.78.2019.06.20.12.38.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/25] btrfs: export the excluded extents helpers
Date:   Thu, 20 Jun 2019 15:37:49 -0400
Message-Id: <20190620193807.29311-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We'll need this to move the caching stuff around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  3 +++
 fs/btrfs/extent-tree.c | 40 +++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c4ae6714e3d4..409852f7af9f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2460,6 +2460,9 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
 }
 
+int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
+			      u64 start, u64 num_bytes);
+void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 82451a64f8ee..eea5a15802f1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -99,8 +99,8 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	return 0;
 }
 
-static int add_excluded_extent(struct btrfs_fs_info *fs_info,
-			       u64 start, u64 num_bytes)
+int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
+			      u64 start, u64 num_bytes)
 {
 	u64 end = start + num_bytes - 1;
 	set_extent_bits(&fs_info->freed_extents[0],
@@ -110,7 +110,7 @@ static int add_excluded_extent(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static void free_excluded_extents(struct btrfs_block_group_cache *cache)
+void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	u64 start, end;
@@ -135,8 +135,8 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 	if (cache->key.objectid < BTRFS_SUPER_INFO_OFFSET) {
 		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->key.objectid;
 		cache->bytes_super += stripe_len;
-		ret = add_excluded_extent(fs_info, cache->key.objectid,
-					  stripe_len);
+		ret = btrfs_add_excluded_extent(fs_info, cache->key.objectid,
+						stripe_len);
 		if (ret)
 			return ret;
 	}
@@ -169,7 +169,7 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 			}
 
 			cache->bytes_super += len;
-			ret = add_excluded_extent(fs_info, start, len);
+			ret = btrfs_add_excluded_extent(fs_info, start, len);
 			if (ret) {
 				kfree(logical);
 				return ret;
@@ -449,7 +449,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 	caching_ctl->progress = (u64)-1;
 
 	up_read(&fs_info->commit_root_sem);
-	free_excluded_extents(block_group);
+	btrfs_free_excluded_extents(block_group);
 	mutex_unlock(&caching_ctl->mutex);
 
 	wake_up(&caching_ctl->wait);
@@ -458,8 +458,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 	btrfs_put_block_group(block_group);
 }
 
-static int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
-				   int load_cache_only)
+int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
+			    int load_cache_only)
 {
 	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -557,7 +557,7 @@ static int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 		wake_up(&caching_ctl->wait);
 		if (ret == 1) {
 			put_caching_control(caching_ctl);
-			free_excluded_extents(cache);
+			btrfs_free_excluded_extents(cache);
 			return 0;
 		}
 	} else {
@@ -4165,7 +4165,8 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 		mutex_lock(&caching_ctl->mutex);
 
 		if (start >= caching_ctl->progress) {
-			ret = add_excluded_extent(fs_info, start, num_bytes);
+			ret = btrfs_add_excluded_extent(fs_info, start,
+							num_bytes);
 		} else if (start + num_bytes <= caching_ctl->progress) {
 			ret = btrfs_remove_free_space(block_group,
 						      start, num_bytes);
@@ -4179,7 +4180,8 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 			num_bytes = (start + num_bytes) -
 				caching_ctl->progress;
 			start = caching_ctl->progress;
-			ret = add_excluded_extent(fs_info, start, num_bytes);
+			ret = btrfs_add_excluded_extent(fs_info, start,
+							num_bytes);
 		}
 out_lock:
 		mutex_unlock(&caching_ctl->mutex);
@@ -7637,7 +7639,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		 */
 		if (block_group->cached == BTRFS_CACHE_NO ||
 		    block_group->cached == BTRFS_CACHE_ERROR)
-			free_excluded_extents(block_group);
+			btrfs_free_excluded_extents(block_group);
 
 		btrfs_remove_free_space_cache(block_group);
 		ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
@@ -7939,7 +7941,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			 * We may have excluded something, so call this just in
 			 * case.
 			 */
-			free_excluded_extents(cache);
+			btrfs_free_excluded_extents(cache);
 			btrfs_put_block_group(cache);
 			goto error;
 		}
@@ -7954,14 +7956,14 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		if (found_key.offset == btrfs_block_group_used(&cache->item)) {
 			cache->last_byte_to_unpin = (u64)-1;
 			cache->cached = BTRFS_CACHE_FINISHED;
-			free_excluded_extents(cache);
+			btrfs_free_excluded_extents(cache);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			cache->last_byte_to_unpin = (u64)-1;
 			cache->cached = BTRFS_CACHE_FINISHED;
 			add_new_free_space(cache, found_key.objectid,
 					   found_key.objectid +
 					   found_key.offset);
-			free_excluded_extents(cache);
+			btrfs_free_excluded_extents(cache);
 		}
 
 		ret = btrfs_add_block_group_cache(info, cache);
@@ -8087,14 +8089,14 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 		 * We may have excluded something, so call this just in
 		 * case.
 		 */
-		free_excluded_extents(cache);
+		btrfs_free_excluded_extents(cache);
 		btrfs_put_block_group(cache);
 		return ret;
 	}
 
 	add_new_free_space(cache, chunk_offset, chunk_offset + size);
 
-	free_excluded_extents(cache);
+	btrfs_free_excluded_extents(cache);
 
 #ifdef CONFIG_BTRFS_DEBUG
 	if (btrfs_should_fragment_free_space(cache)) {
@@ -8181,7 +8183,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * Free the reserved super bytes from this block group before
 	 * remove it.
 	 */
-	free_excluded_extents(block_group);
+	btrfs_free_excluded_extents(block_group);
 	btrfs_free_ref_tree_range(fs_info, block_group->key.objectid,
 				  block_group->key.offset);
 
-- 
2.14.3

