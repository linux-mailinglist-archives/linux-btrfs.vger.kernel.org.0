Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6640456AB85
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiGGTHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiGGTHj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 15:07:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349D759241
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 12:07:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E88CB21B9D;
        Thu,  7 Jul 2022 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657220856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUMPtusZ6/FmOLt6bjUt9mFYfmBrfZXddrEuPVfZ/S0=;
        b=X+Ci2Kxg+vFAO9oowGecqxXPahbjtRX3m1eAWk9lhlPvnhMi1KpB8P3sL4n4ghqaZCePgq
        Nxdvnb9kMpiMgs42mzCQRHEXVEBxIW/pg3cnNM0mIKpMWJ59FyqBSLs78NYfFZufopFI8x
        bmPRzxU2G+w1/kQA91hYueHYpzAPWjs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E03252C141;
        Thu,  7 Jul 2022 19:07:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92AB4DA83C; Thu,  7 Jul 2022 21:02:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/3] btrfs: switch btrfs_block_rsv::full to bool
Date:   Thu,  7 Jul 2022 21:02:51 +0200
Message-Id: <db712e74bcc822a6468ceeef85608dc73f7e79d3.1657220460.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657220460.git.dsterba@suse.com>
References: <cover.1657220460.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use simple bool type for the block reserve full status, there's short to
save space as there used to be int but there's no reason for that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-rsv.c   | 15 ++++++---------
 fs/btrfs/block-rsv.h   |  2 +-
 fs/btrfs/delayed-ref.c |  4 ++--
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index b3ee49b0b1e8..26c43a6ef5d2 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -118,7 +118,7 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	if (block_rsv->reserved >= block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
 		block_rsv->reserved = block_rsv->size;
-		block_rsv->full = 1;
+		block_rsv->full = true;
 	} else {
 		num_bytes = 0;
 	}
@@ -142,7 +142,7 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 				bytes_to_add = min(num_bytes, bytes_to_add);
 				dest->reserved += bytes_to_add;
 				if (dest->reserved >= dest->size)
-					dest->full = 1;
+					dest->full = true;
 				num_bytes -= bytes_to_add;
 			}
 			spin_unlock(&dest->lock);
@@ -304,7 +304,7 @@ int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes)
 	if (block_rsv->reserved >= num_bytes) {
 		block_rsv->reserved -= num_bytes;
 		if (block_rsv->reserved < block_rsv->size)
-			block_rsv->full = 0;
+			block_rsv->full = false;
 		ret = 0;
 	}
 	spin_unlock(&block_rsv->lock);
@@ -319,7 +319,7 @@ void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 	if (update_size)
 		block_rsv->size += num_bytes;
 	else if (block_rsv->reserved >= block_rsv->size)
-		block_rsv->full = 1;
+		block_rsv->full = true;
 	spin_unlock(&block_rsv->lock);
 }
 
@@ -341,7 +341,7 @@ int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 	}
 	global_rsv->reserved -= num_bytes;
 	if (global_rsv->reserved < global_rsv->size)
-		global_rsv->full = 0;
+		global_rsv->full = false;
 	spin_unlock(&global_rsv->lock);
 
 	btrfs_block_rsv_add_bytes(dest, num_bytes, true);
@@ -408,10 +408,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 		btrfs_try_granting_tickets(fs_info, sinfo);
 	}
 
-	if (block_rsv->reserved == block_rsv->size)
-		block_rsv->full = 1;
-	else
-		block_rsv->full = 0;
+	block_rsv->full = (block_rsv->reserved == block_rsv->size);
 
 	if (block_rsv->size >= sinfo->total_bytes)
 		sinfo->force_alloc = CHUNK_ALLOC_FORCE;
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 3b67ff08d434..99c491ef128e 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -25,7 +25,7 @@ struct btrfs_block_rsv {
 	u64 reserved;
 	struct btrfs_space_info *space_info;
 	spinlock_t lock;
-	unsigned short full;
+	bool full;
 	unsigned short type;
 	unsigned short failfast;
 
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 99f37fca2e96..36a3debe9493 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -132,7 +132,7 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 
 	spin_lock(&delayed_rsv->lock);
 	delayed_rsv->size += num_bytes;
-	delayed_rsv->full = 0;
+	delayed_rsv->full = false;
 	spin_unlock(&delayed_rsv->lock);
 	trans->delayed_ref_updates = 0;
 }
@@ -175,7 +175,7 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 	if (num_bytes)
 		delayed_refs_rsv->reserved += num_bytes;
 	if (delayed_refs_rsv->reserved >= delayed_refs_rsv->size)
-		delayed_refs_rsv->full = 1;
+		delayed_refs_rsv->full = true;
 	spin_unlock(&delayed_refs_rsv->lock);
 
 	if (num_bytes)
-- 
2.36.1

