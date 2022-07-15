Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8AB5767AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiGOTph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTpg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:36 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C461723
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:35 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d17so4466751qvs.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YLJBPiDD0sm+JqyyIUXqhNP8dYxwcTnIBOCWLc2uFmA=;
        b=JKqBi3EVB5n7eLSSMavLEYKMq8aXvt5FZbwArs9wPfFbuEYHwfa52iGZBjD0x4xS6Q
         6I/+JU/ydcFSSIQXSQ/AZZVZT3kRv69wuIKWBFqo3/o8uSzK15QiWRor6dpy+fKBnTDe
         Vmkvxm7T2nKFy+gh0Dm5SIaoQBS8AxXdaRSlw4OsDJ5QmeIR1BHyKZY4BqOTYQUdc48b
         h9qrMdC+OShfycayiaTunYLOz2pOTLfLfiVeN3ylx+nhBqqpZxqAmbVcROAVr6NOGlDf
         fA64AalZ+GhUQwQsZabwnGNIbvZ+UnMYRPmHnuN9vS/8KCo8ofeQNTmjOTsTApRHuHMP
         uUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLJBPiDD0sm+JqyyIUXqhNP8dYxwcTnIBOCWLc2uFmA=;
        b=jNCd8ab9HAN28USu2UJKvRElojglKEZuj3k2iBMWRUbkNkJuI0fZWP0Uy/VRx9VJSe
         wKEzDSmpPsi8KAsiacqI/u8q6IzqMicnZRjjloqEcVR2WmAfqpa9k/w+6PZp9m6qrxrR
         zS+PMadcXajUKTIZoSKf2NWqK8ks8e7WfRr5b6D93D1Up42DKMZwYNBOE7wb3TKiI1hL
         +RMPjjn8ij/dc88sOU9twkecZIz6RqZUe306pjiihlGo/kGQiZzOuBoaWrkGVf3zcawX
         GEvvXlKgM8r5RHdh8GnQRmoad3vD2ukmLNO5ReCf04fNJHRdXuY9CzEZ5nlgdHyeFZ+7
         Ubhg==
X-Gm-Message-State: AJIora/vf3DwVL48nQGBWyrlk5mJ8ZFoes4yeUQ82X11utRKZejRgMuK
        Dy3SW3e8BqIq6qhLOIF8o7QirG3Zmox8iQ==
X-Google-Smtp-Source: AGRyM1shzEQtDZX0xzYhF2HdfV0lBO3OLpzK6AXhV8tygn3EOkcRwR9ovkqgNwQbGLTtRUbhZ+iqTw==
X-Received: by 2002:a05:6214:2345:b0:473:a82c:34eb with SMTP id hu5-20020a056214234500b00473a82c34ebmr7329736qvb.9.1657914333857;
        Fri, 15 Jul 2022 12:45:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az43-20020a05620a172b00b006a6a7b4e7besm4456352qkb.109.2022.07.15.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/9] btrfs: simplify btrfs_update_space_info
Date:   Fri, 15 Jul 2022 15:45:22 -0400
Message-Id: <f6d53b8cea165cc7f8f7244da3b334ab5e8d0397.1657914198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
References: <cover.1657914198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function has grown a bunch of new arguments, and it just boils down
to passing in all the block group fields as arguments.  Simplify this by
passing in the block group itself and updating the space_info fields
based on the block group fields directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 13 ++++---------
 fs/btrfs/space-info.c  | 29 ++++++++++++++---------------
 fs/btrfs/space-info.h  |  7 +++----
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1e61d967d8be..36bacf215c22 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2110,10 +2110,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super,
-				cache->zone_unusable, cache->zone_is_active,
-				&space_info);
+	btrfs_add_bg_to_space_info(info, cache, &space_info);
 
 	cache->space_info = space_info;
 
@@ -2182,8 +2179,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 
-		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
-					0, 0, false, &space_info);
+		btrfs_add_bg_to_space_info(fs_info, bg, &space_info);
 		bg->space_info = space_info;
 		link_block_group(bg);
 
@@ -2539,6 +2535,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		u64 new_bytes_used = size - bytes_used;
 
 		bytes_used += new_bytes_used >> 1;
+		cache->used = bytes_used;
 		fragment_free_space(cache);
 	}
 #endif
@@ -2562,9 +2559,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, cache->zone_unusable,
-				cache->zone_is_active, &cache->space_info);
+	btrfs_add_bg_to_space_info(fs_info, cache, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d0cbeb7ae81c..a9433d19d827 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -293,28 +293,27 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly, u64 bytes_zone_unusable,
-			     bool active, struct btrfs_space_info **space_info)
+void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
+				struct btrfs_block_group *block_group,
+				struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
 	int factor;
 
-	factor = btrfs_bg_type_to_factor(flags);
+	factor = btrfs_bg_type_to_factor(block_group->flags);
 
-	found = btrfs_find_space_info(info, flags);
+	found = btrfs_find_space_info(info, block_group->flags);
 	ASSERT(found);
 	spin_lock(&found->lock);
-	found->total_bytes += total_bytes;
-	if (active)
-		found->active_total_bytes += total_bytes;
-	found->disk_total += total_bytes * factor;
-	found->bytes_used += bytes_used;
-	found->disk_used += bytes_used * factor;
-	found->bytes_readonly += bytes_readonly;
-	found->bytes_zone_unusable += bytes_zone_unusable;
-	if (total_bytes > 0)
+	found->total_bytes += block_group->length;
+	if (block_group->zone_is_active)
+		found->active_total_bytes += block_group->length;
+	found->disk_total += block_group->length * factor;
+	found->bytes_used += block_group->used;
+	found->disk_used += block_group->used * factor;
+	found->bytes_readonly += block_group->bytes_super;
+	found->bytes_zone_unusable += block_group->zone_unusable;
+	if (block_group->length > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 12fd6147f92d..101e83828ee5 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -123,10 +123,9 @@ DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
-void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly, u64 bytes_zone_unusable,
-			     bool active, struct btrfs_space_info **space_info);
+void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
+				struct btrfs_block_group *block_group,
+				struct btrfs_space_info **space_info);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
-- 
2.26.3

