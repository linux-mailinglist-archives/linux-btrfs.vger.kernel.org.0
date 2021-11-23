Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE245A305
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbhKWMre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 07:47:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbhKWMrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 07:47:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABC1C21940;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637671464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=KSisGl+n8TdgdFWY6pK3JiWj92CnI/aVKUaT1TPgulk=;
        b=m3WjTYBMxARrgbZhsA42YsIwVbzO0g9r6CbT7m0SY2gxnqudRqBaVvk0rBJdYlFfWJSePe
        /ayk5E4avAm2FoDFShgzDG8yVNZi0Vo/7Xkv+4os6eCfLA2+q0KyQGbsrrtL0r8itpzxjJ
        phe9Jnv01elqWqhXf3DymYnUXmm2y7w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E33813DF4;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aAxbHCjinGEfdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 12:44:24 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/4] btrfs: consolidate bitmap_clear_bits/__bitmap_clear_bits
Date:   Tue, 23 Nov 2021 14:44:19 +0200
Message-Id: <20211123124422.5830-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123124422.5830-1-nborisov@suse.com>
References: <20211123124422.5830-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only difference is the former adjusts btrfs_free_space::bytes
member. Consolidate the two function into 1 and add a bool parameter
which controls whether the adjustment is made or not. No functional
changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c5ee980e7a5e..8388fa71ce1e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -45,7 +45,7 @@ static void free_bitmap(struct btrfs_free_space_ctl *ctl,
 			struct btrfs_free_space *bitmap_info);
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 			      struct btrfs_free_space *info, u64 offset,
-			      u64 bytes);
+			      u64 bytes, bool update_stats);
 
 static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 					       struct btrfs_path *path,
@@ -886,7 +886,7 @@ static int copy_free_space_cache(struct btrfs_block_group *block_group,
 							   bytes);
 				if (ret)
 					break;
-				bitmap_clear_bits(ctl, info, offset, bytes);
+				bitmap_clear_bits(ctl, info, offset, bytes, true);
 				offset = info->offset;
 				bytes = ctl->unit;
 			}
@@ -1740,9 +1740,9 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	return ret;
 }
 
-static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
-				       struct btrfs_free_space *info,
-				       u64 offset, u64 bytes)
+static inline void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
+				     struct btrfs_free_space *info,
+				     u64 offset, u64 bytes, bool update_stat)
 {
 	unsigned long start, count, end;
 	int extent_delta = -1;
@@ -1769,14 +1769,9 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
 	}
-}
 
-static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
-			      struct btrfs_free_space *info, u64 offset,
-			      u64 bytes)
-{
-	__bitmap_clear_bits(ctl, info, offset, bytes);
-	ctl->free_space -= bytes;
+	if (update_stat)
+		ctl->free_space -= bytes;
 }
 
 static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
@@ -2007,7 +2002,7 @@ static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
 	/* Cannot clear past the end of the bitmap */
 	search_bytes = min(search_bytes, end - search_start + 1);
 
-	bitmap_clear_bits(ctl, bitmap_info, search_start, search_bytes);
+	bitmap_clear_bits(ctl, bitmap_info, search_start, search_bytes, true);
 	*offset += search_bytes;
 	*bytes -= search_bytes;
 
@@ -2358,10 +2353,7 @@ static bool steal_from_bitmap_to_end(struct btrfs_free_space_ctl *ctl,
 	if (!btrfs_free_space_trimmed(bitmap))
 		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
-	if (update_stat)
-		bitmap_clear_bits(ctl, bitmap, end, bytes);
-	else
-		__bitmap_clear_bits(ctl, bitmap, end, bytes);
+	bitmap_clear_bits(ctl, bitmap, end, bytes, update_stat);
 
 	if (!bitmap->bytes)
 		free_bitmap(ctl, bitmap);
@@ -2415,10 +2407,7 @@ static bool steal_from_bitmap_to_front(struct btrfs_free_space_ctl *ctl,
 	if (!btrfs_free_space_trimmed(bitmap))
 		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
-	if (update_stat)
-		bitmap_clear_bits(ctl, bitmap, info->offset, bytes);
-	else
-		__bitmap_clear_bits(ctl, bitmap, info->offset, bytes);
+	bitmap_clear_bits(ctl, bitmap, info->offset, bytes, update_stat);
 
 	if (!bitmap->bytes)
 		free_bitmap(ctl, bitmap);
@@ -2972,7 +2961,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 
 	ret = offset;
 	if (entry->bitmap) {
-		bitmap_clear_bits(ctl, entry, offset, bytes);
+		bitmap_clear_bits(ctl, entry, offset, bytes, true);
 
 		if (!btrfs_free_space_trimmed(entry))
 			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
@@ -3074,7 +3063,7 @@ static u64 btrfs_alloc_from_bitmap(struct btrfs_block_group *block_group,
 	}
 
 	ret = search_start;
-	__bitmap_clear_bits(ctl, entry, ret, bytes);
+	bitmap_clear_bits(ctl, entry, ret, bytes, false);
 
 	return ret;
 }
@@ -3824,7 +3813,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		    bytes > (max_discard_size + minlen))
 			bytes = max_discard_size;
 
-		bitmap_clear_bits(ctl, entry, start, bytes);
+		bitmap_clear_bits(ctl, entry, start, bytes, true);
 		if (entry->bytes == 0)
 			free_bitmap(ctl, entry);
 
-- 
2.17.1

