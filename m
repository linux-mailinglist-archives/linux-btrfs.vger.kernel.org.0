Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612474AB72
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfFRUJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38644 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so9425676qkk.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=uuib9cJi/ZI1+KtPT+et5ST/BwjozUaTsP8MT24tu4c=;
        b=1bpAZoIuQxBRbR6+W1yd/sSrRd/w4actp4H1IIkEDMvbyieSLJuRTJML6rnOzeG3Ri
         DduWrn0OCuAYeGI+FdZKNZmBbA/riRnBwtlyENp3iYLpwLQ6xgNI8FYtkR0So6oi/w0i
         3+5qEt69lRoNNbOrPbHG2FjaojGVcr/wuifQu1AolGEb0pIgMWObfs22g3SLmmUxpEn0
         A1X/JI1b7pYjcNEsO0FILKqFQaNIvNW8/NWGqgNGK1/kBbuDavvqQbB/08v4ZpBO39p5
         1U8c2ItRCXhzWoNT2mX6luEY/kVx03Rr3npv5XoR2A9+aaltFu440UqgMrEJzrTq096m
         5qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=uuib9cJi/ZI1+KtPT+et5ST/BwjozUaTsP8MT24tu4c=;
        b=jRPsHBv90giris3JoMehloMS3VzsBQJKdDOIrJUdmneYTJE4MZPHa2LgDuW+xdj4Ar
         jw5xsqgcDEGASVUvuleKoFMX2HAL0SOqc7jwKjRzsZirq3B9o0mq9OZ2HPoeJdzlrxhl
         ggw5q4YkuMQyUMkKRg0VLFHhzl/YGhdc5062GO6GFXBbNj+aTd624YIBdrBU14nt/DK1
         1YjPUAUDH9Mvp0ki70xLyhvJ3Oo3Spy781och96oZXgI9U+3c6gi2NIK8APdwKUzWeKm
         ZMIJDfDJsWKnqzJpiPwBO8AvBYINOMKiaF4YYLd9uJ3YLcF7kDs9LwwfgVCvYCQFmo8Z
         Bj8g==
X-Gm-Message-State: APjAAAWC1y7z41M4FGCGe270moZCz4DlsxSWiq/Ph88In4ZYsZzz86T7
        wEBUbbBpX50ikYkIUUm6U2mrbX7zSzka5g==
X-Google-Smtp-Source: APXvYqw8fqnGmv5ItSjnrqBOcDCOC9oQ4FBB8YwSavbhN0LS9lqXk8e1X3bF2GEHonFOEjsMpxnX0Q==
X-Received: by 2002:a37:9bc1:: with SMTP id d184mr4324476qke.226.1560888578745;
        Tue, 18 Jun 2019 13:09:38 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i17sm9655104qta.6.2019.06.18.13.09.37
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: move and export can_overcommit
Date:   Tue, 18 Jun 2019 16:09:20 -0400
Message-Id: <20190618200926.3352-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the first piece of moving the space reservation code to
space-info.c

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 83 +++++---------------------------------------------
 fs/btrfs/space-info.c  | 68 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  4 +++
 3 files changed, 80 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a30d265fee5e..6eebfa5df53c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4147,11 +4147,6 @@ static void force_metadata_allocation(struct btrfs_fs_info *info)
 	rcu_read_unlock();
 }
 
-static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
-{
-	return (global->size << 1);
-}
-
 static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
 			      struct btrfs_space_info *sinfo, int force)
 {
@@ -4378,69 +4373,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-static int can_overcommit(struct btrfs_fs_info *fs_info,
-			  struct btrfs_space_info *space_info, u64 bytes,
-			  enum btrfs_reserve_flush_enum flush,
-			  bool system_chunk)
-{
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	u64 profile;
-	u64 space_size;
-	u64 avail;
-	u64 used;
-	int factor;
-
-	/* Don't overcommit when in mixed mode. */
-	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
-		return 0;
-
-	if (system_chunk)
-		profile = btrfs_system_alloc_profile(fs_info);
-	else
-		profile = btrfs_metadata_alloc_profile(fs_info);
-
-	used = btrfs_space_info_used(space_info, false);
-
-	/*
-	 * We only want to allow over committing if we have lots of actual space
-	 * free, but if we don't have enough space to handle the global reserve
-	 * space then we could end up having a real enospc problem when trying
-	 * to allocate a chunk or some other such important allocation.
-	 */
-	spin_lock(&global_rsv->lock);
-	space_size = calc_global_rsv_need_space(global_rsv);
-	spin_unlock(&global_rsv->lock);
-	if (used + space_size >= space_info->total_bytes)
-		return 0;
-
-	used += space_info->bytes_may_use;
-
-	avail = atomic64_read(&fs_info->free_chunk_space);
-
-	/*
-	 * If we have dup, raid1 or raid10 then only half of the free
-	 * space is actually usable.  For raid56, the space info used
-	 * doesn't include the parity drive, so we don't have to
-	 * change the math
-	 */
-	factor = btrfs_bg_type_to_factor(profile);
-	avail = div_u64(avail, factor);
-
-	/*
-	 * If we aren't flushing all things, let us overcommit up to
-	 * 1/2th of the space. If we can flush, don't let us overcommit
-	 * too much, let it overcommit up to 1/8 of the space.
-	 */
-	if (flush == BTRFS_RESERVE_FLUSH_ALL)
-		avail >>= 3;
-	else
-		avail >>= 1;
-
-	if (used + bytes < space_info->total_bytes + avail)
-		return 1;
-	return 0;
-}
-
 static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
 					 unsigned long nr_pages, int nr_items)
 {
@@ -4768,14 +4700,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 		return to_reclaim;
 
 	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (can_overcommit(fs_info, space_info, to_reclaim,
-			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
+				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
 
-	if (can_overcommit(fs_info, space_info, SZ_1M,
-			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
+				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
 		expected = div_factor_fine(space_info->total_bytes, 95);
 	else
 		expected = div_factor_fine(space_info->total_bytes, 90);
@@ -5021,8 +4953,8 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
 		ret = 0;
-	} else if (can_overcommit(fs_info, space_info, orig_bytes, flush,
-				  system_chunk)) {
+	} else if (btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush,
+					system_chunk)) {
 		update_bytes_may_use(fs_info, space_info, orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
@@ -5334,7 +5266,8 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		 * adding the ticket space would be a double count.
 		 */
 		if (check_overcommit &&
-		    !can_overcommit(fs_info, space_info, 0, flush, false))
+		    !btrfs_can_overcommit(fs_info, space_info, 0, flush,
+					  false))
 			break;
 		if (num_bytes >= ticket->bytes) {
 			list_del_init(&ticket->list);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 348b57055d77..2cb9f3b6ffc9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -175,3 +175,71 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 	rcu_read_unlock();
 	return NULL;
 }
+
+static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
+{
+	return (global->size << 1);
+}
+
+int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
+			 struct btrfs_space_info *space_info, u64 bytes,
+			 enum btrfs_reserve_flush_enum flush,
+			 bool system_chunk)
+{
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	u64 profile;
+	u64 space_size;
+	u64 avail;
+	u64 used;
+	int factor;
+
+	/* Don't overcommit when in mixed mode. */
+	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
+		return 0;
+
+	if (system_chunk)
+		profile = btrfs_system_alloc_profile(fs_info);
+	else
+		profile = btrfs_metadata_alloc_profile(fs_info);
+
+	used = btrfs_space_info_used(space_info, false);
+
+	/*
+	 * We only want to allow over committing if we have lots of actual space
+	 * free, but if we don't have enough space to handle the global reserve
+	 * space then we could end up having a real enospc problem when trying
+	 * to allocate a chunk or some other such important allocation.
+	 */
+	spin_lock(&global_rsv->lock);
+	space_size = calc_global_rsv_need_space(global_rsv);
+	spin_unlock(&global_rsv->lock);
+	if (used + space_size >= space_info->total_bytes)
+		return 0;
+
+	used += space_info->bytes_may_use;
+
+	avail = atomic64_read(&fs_info->free_chunk_space);
+
+	/*
+	 * If we have dup, raid1 or raid10 then only half of the free
+	 * space is actually usable.  For raid56, the space info used
+	 * doesn't include the parity drive, so we don't have to
+	 * change the math
+	 */
+	factor = btrfs_bg_type_to_factor(profile);
+	avail = div_u64(avail, factor);
+
+	/*
+	 * If we aren't flushing all things, let us overcommit up to
+	 * 1/2th of the space. If we can flush, don't let us overcommit
+	 * too much, let it overcommit up to 1/8 of the space.
+	 */
+	if (flush == BTRFS_RESERVE_FLUSH_ALL)
+		avail >>= 3;
+	else
+		avail >>= 1;
+
+	if (used + bytes < space_info->total_bytes + avail)
+		return 1;
+	return 0;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a5a228b59806..c1f48f548cb6 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -94,5 +94,9 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
+int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
+			 struct btrfs_space_info *space_info, u64 bytes,
+			 enum btrfs_reserve_flush_enum flush,
+			 bool system_chunk);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.14.3

