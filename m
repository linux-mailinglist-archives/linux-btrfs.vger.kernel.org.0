Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E504DA50
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFTTiS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:18 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38608 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id x7so1675150ybg.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=z+eZApoRhypRMHCO/7tBkqi/J/iAGf+xVuV7jB5vu/Q=;
        b=v0YjXxtyvBmrJ642+nc0fXa6DoQyw1pnQEsO3u359JliIJPQF04SVi3iM50sgAo8HY
         sAzO6ydcV5qL1PFQq78u8JPOOwkRWbvkij6b4qS8kzvMRj+pU3o+ztkAZwZFMHAdgGzw
         URV7hd7pJAe96opIOdLBQ7Q/yT1Q36BTnWms+DaAR728Tbexe/o6xkj2iecNLa2rSIKh
         h9Lh2EMb7Uy/44dqItL2kVEnZWdf2G0mT112UPOPiI6ZDonTFhTiny95qbTtIMXYch3i
         iyxl4EnIwDd4oQXrELahWKTWtMFLjDlqL1r/bByBqxtyTna14Ue+PFLXiFtAN1bocMbp
         suNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=z+eZApoRhypRMHCO/7tBkqi/J/iAGf+xVuV7jB5vu/Q=;
        b=IQ3WaTPFYy84eGPU46N+ZcNGuRnAjO35R9xTKrbkIkWZkoqsRZe2JICPPwBH6cgyi/
         JTsocIxv6h8DsIQATFsaRO0YzDMIoMUWAGUiz5d+jb1F2zlwgW0JSkouJ7561E33Evhy
         1cBcmF3chl1UF+WPYUmA2Sr8xAE7rmvRgh1oSFSERpG2blYYg/07AqoQRni/bM6WY+2u
         IEfciAHhLFECReMXkMjqqkTlkWk74tcBcBNS+hNbKYbAC0RKkc8OgSUKKkZ4GIwmyfIF
         AfS3OYvFZDHKcRIwwWxiXJjlI2VWg5vi2hAPXJJtz4VvTZfYX7ihiQuxLwn6Dovv0LQU
         UhPw==
X-Gm-Message-State: APjAAAUPr6lRC9E2Hwyiru2J6BOG3HVC+F2dcc4e/Y+9McSGsw8ypWSh
        NqPqtdXZkC9bM3uGdtMPU8QlPjCqEMpErQ==
X-Google-Smtp-Source: APXvYqwR4x7szEOPwilzcokkfmodWPkGMA/+ClxqqqtNouQpWXixuyjofyWyxtkR1/dKVF2UZZHIHQ==
X-Received: by 2002:a25:6c54:: with SMTP id h81mr49578934ybc.218.1561059496280;
        Thu, 20 Jun 2019 12:38:16 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r125sm123039ywh.33.2019.06.20.12.38.15
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/25] btrfs: migrate the block group ref counting stuff
Date:   Thu, 20 Jun 2019 15:37:46 -0400
Message-Id: <20190620193807.29311-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Another easy set to move over to block-group.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 24 ++++++++++++++++++++++++
 fs/btrfs/block-group.h |  2 ++
 fs/btrfs/ctree.h       |  3 ---
 fs/btrfs/extent-tree.c | 25 -------------------------
 4 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f56b38bbe4b4..b15d7070bcfd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -5,6 +5,30 @@
 #include "ctree.h"
 #include "block-group.h"
 
+void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
+{
+	atomic_inc(&cache->count);
+}
+
+void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
+{
+	if (atomic_dec_and_test(&cache->count)) {
+		WARN_ON(cache->pinned > 0);
+		WARN_ON(cache->reserved > 0);
+
+		/*
+		 * If not empty, someone is still holding mutex of
+		 * full_stripe_lock, which can only be released by caller.
+		 * And it will definitely cause use-after-free when caller
+		 * tries to release full stripe lock.
+		 *
+		 * No better way to resolve, but only to warn.
+		 */
+		WARN_ON(!RB_EMPTY_ROOT(&cache->full_stripe_locks_root.root));
+		kfree(cache->free_space_ctl);
+		kfree(cache);
+	}
+}
 
 /*
  * This will return the block group at or after bytenr if contains is 0, else
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 05e5ac134140..ddd91c7ed44a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -159,5 +159,7 @@ struct btrfs_block_group_cache *
 btrfs_lookup_block_group(struct btrfs_fs_info *info, u64 bytenr);
 struct btrfs_block_group_cache *
 btrfs_next_block_group(struct btrfs_block_group_cache *cache);
+void btrfs_get_block_group(struct btrfs_block_group_cache *cache);
+void btrfs_put_block_group(struct btrfs_block_group_cache *cache);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5b24ea48ed84..4c6e643bc65d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2466,7 +2466,6 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg);
 bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg);
-void btrfs_put_block_group(struct btrfs_block_group_cache *cache);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
@@ -2483,8 +2482,6 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
 			  u64 objectid, u64 offset, u64 bytenr);
-void btrfs_get_block_group(struct btrfs_block_group_cache *cache);
-void btrfs_put_block_group(struct btrfs_block_group_cache *cache);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     u64 parent, u64 root_objectid,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b9af50d19b0d..01a45674382e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -67,31 +67,6 @@ static int block_group_bits(struct btrfs_block_group_cache *cache, u64 bits)
 	return (cache->flags & bits) == bits;
 }
 
-void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
-{
-	atomic_inc(&cache->count);
-}
-
-void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
-{
-	if (atomic_dec_and_test(&cache->count)) {
-		WARN_ON(cache->pinned > 0);
-		WARN_ON(cache->reserved > 0);
-
-		/*
-		 * If not empty, someone is still holding mutex of
-		 * full_stripe_lock, which can only be released by caller.
-		 * And it will definitely cause use-after-free when caller
-		 * tries to release full stripe lock.
-		 *
-		 * No better way to resolve, but only to warn.
-		 */
-		WARN_ON(!RB_EMPTY_ROOT(&cache->full_stripe_locks_root.root));
-		kfree(cache->free_space_ctl);
-		kfree(cache);
-	}
-}
-
 /*
  * this adds the block group to the fs_info rb tree for the block group
  * cache
-- 
2.14.3

