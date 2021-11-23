Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9560C45A306
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhKWMre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 07:47:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhKWMrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 07:47:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E93AA1FD64;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637671464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=vdDGSVqYCtWdYdyKng+UVS1KuW6cWKE2pou+DaQMgOQ=;
        b=LDdj1oNpjUZCn0Za5UYfnjuQbY/Hxf5GSr8cGXGaUJPsfwJOKk6p0hz4smtS1od2HrZMqp
        ZC1BH0bTd84EPhJ237yK1ANe7k1U2jGEVC9so+VnADFmBncwLgQeRxCGVmnwmgiiCYtZMP
        wcmcXgAPgupGkHT87hDL/ITusVu+8ss=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCC0E13DF4;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0Ad1KyjinGEfdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 12:44:24 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs: consolidate unlink_free_space/__unlink_free_space functions
Date:   Tue, 23 Nov 2021 14:44:20 +0200
Message-Id: <20211123124422.5830-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123124422.5830-1-nborisov@suse.com>
References: <20211123124422.5830-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only difference between the two is whether btrfs_free_space::bytes
is adjusted. Instead of having 2 separate functions control this
behavior via an additional parameter and make them one function instead.
No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 41 +++++++++++++++----------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8388fa71ce1e..6bc35080afa6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -37,7 +37,7 @@ struct btrfs_trim_range {
 static int link_free_space(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info);
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
-			      struct btrfs_free_space *info);
+			      struct btrfs_free_space *info, bool update_stat);
 static int search_bitmap(struct btrfs_free_space_ctl *ctl,
 			 struct btrfs_free_space *bitmap_info, u64 *offset,
 			 u64 *bytes, bool for_alloc);
@@ -872,7 +872,7 @@ static int copy_free_space_cache(struct btrfs_block_group *block_group,
 	while (!ret && (n = rb_first(&ctl->free_space_offset)) != NULL) {
 		info = rb_entry(n, struct btrfs_free_space, offset_index);
 		if (!info->bitmap) {
-			unlink_free_space(ctl, info);
+			unlink_free_space(ctl, info, true);
 			ret = btrfs_add_free_space(block_group, info->offset,
 						   info->bytes);
 			kmem_cache_free(btrfs_free_space_cachep, info);
@@ -1699,9 +1699,9 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 	return entry;
 }
 
-static inline void
-__unlink_free_space(struct btrfs_free_space_ctl *ctl,
-		    struct btrfs_free_space *info)
+static inline void unlink_free_space(struct btrfs_free_space_ctl *ctl,
+				     struct btrfs_free_space *info,
+				     bool update_stat)
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	ctl->free_extents--;
@@ -1710,13 +1710,10 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		ctl->discardable_extents[BTRFS_STAT_CURR]--;
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= info->bytes;
 	}
-}
 
-static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
-			      struct btrfs_free_space *info)
-{
-	__unlink_free_space(ctl, info);
-	ctl->free_space -= info->bytes;
+	if (update_stat)
+		ctl->free_space -= info->bytes;
+
 }
 
 static int link_free_space(struct btrfs_free_space_ctl *ctl,
@@ -1964,7 +1961,7 @@ static void free_bitmap(struct btrfs_free_space_ctl *ctl,
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bitmap_info->bytes;
 
 	}
-	unlink_free_space(ctl, bitmap_info);
+	unlink_free_space(ctl, bitmap_info, true);
 	kmem_cache_free(btrfs_free_space_bitmap_cachep, bitmap_info->bitmap);
 	kmem_cache_free(btrfs_free_space_cachep, bitmap_info);
 	ctl->total_bitmaps--;
@@ -2301,10 +2298,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	/* See try_merge_free_space() comment. */
 	if (right_info && !right_info->bitmap &&
 	    (!is_trimmed || btrfs_free_space_trimmed(right_info))) {
-		if (update_stat)
-			unlink_free_space(ctl, right_info);
-		else
-			__unlink_free_space(ctl, right_info);
+		unlink_free_space(ctl, right_info, update_stat);
 		info->bytes += right_info->bytes;
 		kmem_cache_free(btrfs_free_space_cachep, right_info);
 		merged = true;
@@ -2314,10 +2308,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	if (left_info && !left_info->bitmap &&
 	    left_info->offset + left_info->bytes == offset &&
 	    (!is_trimmed || btrfs_free_space_trimmed(left_info))) {
-		if (update_stat)
-			unlink_free_space(ctl, left_info);
-		else
-			__unlink_free_space(ctl, left_info);
+		unlink_free_space(ctl, left_info, update_stat);
 		info->offset = left_info->offset;
 		info->bytes += left_info->bytes;
 		kmem_cache_free(btrfs_free_space_cachep, left_info);
@@ -2681,7 +2672,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 
 	re_search = false;
 	if (!info->bitmap) {
-		unlink_free_space(ctl, info);
+		unlink_free_space(ctl, info, true);
 		if (offset == info->offset) {
 			u64 to_free = min(bytes, info->bytes);
 
@@ -2864,7 +2855,7 @@ static void __btrfs_remove_free_space_cache_locked(
 	while ((node = rb_last(&ctl->free_space_offset)) != NULL) {
 		info = rb_entry(node, struct btrfs_free_space, offset_index);
 		if (!info->bitmap) {
-			unlink_free_space(ctl, info);
+			unlink_free_space(ctl, info, true);
 			kmem_cache_free(btrfs_free_space_cachep, info);
 		} else {
 			free_bitmap(ctl, info);
@@ -2969,7 +2960,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		if (!entry->bytes)
 			free_bitmap(ctl, entry);
 	} else {
-		unlink_free_space(ctl, entry);
+		unlink_free_space(ctl, entry, true);
 		align_gap_len = offset - entry->offset;
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
@@ -3600,7 +3591,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 				mutex_unlock(&ctl->cache_writeout_mutex);
 				goto next;
 			}
-			unlink_free_space(ctl, entry);
+			unlink_free_space(ctl, entry, true);
 			/*
 			 * Let bytes = BTRFS_MAX_DISCARD_SIZE + X.
 			 * If X < BTRFS_ASYNC_DISCARD_MIN_FILTER, we won't trim
@@ -3626,7 +3617,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 				goto next;
 			}
 
-			unlink_free_space(ctl, entry);
+			unlink_free_space(ctl, entry, true);
 			kmem_cache_free(btrfs_free_space_cachep, entry);
 		}
 
-- 
2.17.1

