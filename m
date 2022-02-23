Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3609E4C1B6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiBWTHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 14:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbiBWTHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 14:07:22 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A931537
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:52 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v18so2185567qvh.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A38L4ZoDZZiHJDtnHKnoadH1Hzas5142dhODHlwp/Pc=;
        b=tu/3M1HR0kf9l2zrFZ7DCywHHyjqfrRGvoupF9RO4zGm6+ATz5ejA4fiS/ohk3nAdU
         rJOsyCVquMWESREUfYKWDQU6UNYN5+gfIFvlG86n3+zwk7YaDCm+D8H7sL4qWxuNMgwf
         B5n8BhTv81qrF5xA05PQ0fylt7oM6D35IVeanIboLzgCcawN4L0nUnqp8EUC6+JDJx53
         L6TvKtf1c0HnHu0lGRkOtGh1/65nm+bReqkpdBnVWf0VsGhonVgOZQSBY35GHTM/kuDK
         HYqw0bnGEF3Zg5FR5LtDAzS6APWIcOcGQwzhzQ7dQqWVMKy67H6HEcwIGgBnACbrSZzX
         WEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A38L4ZoDZZiHJDtnHKnoadH1Hzas5142dhODHlwp/Pc=;
        b=xkuT2lCy8undJxwkHu9tDNtV3c+FaFMxonxIBRGf05VkKWr4YxUFkKPIXFVEq5XB/7
         TTXKmKWncXuarwsnvyr0XU3JhjdaZZy4RzifhsvOJWxvLMRQxCGrpvtcqIhjDXXAA4NZ
         I6yiE9hvoRHw7A880fT+ManlnbAdRyshKQUYJS0M5ptuykFWfgRwzXTzhbcDT1vELq7p
         fWSd7hhXmzip6ufIylzz+CMjKw9O358I2xKeTEl8VuFV5JwECz6wXY4h8kAYuLMp/45V
         wyr8WfHdkGcPI/RAKI6BMd53cSd7dqnXgn69CBTArPUtf61jHjr4g+WBYnxkilZqBd1O
         674Q==
X-Gm-Message-State: AOAM531rVl8wcFB70cQAI4rWxqi/2IHeaajxfM9HhEdLBtwsk3zcnwc6
        ZjgpcXowl3VTUgFbqAaXQFACS+Gdeqj47/NI
X-Google-Smtp-Source: ABdhPJwnHs3RALSq74owkLxirFUj/4cy+9aFcskEucaj5kKPoOYyVwgEx1u952esEl02Aa6VZlubqg==
X-Received: by 2002:a0c:8151:0:b0:42c:2329:91a0 with SMTP id 75-20020a0c8151000000b0042c232991a0mr676657qvc.107.1645643211622;
        Wed, 23 Feb 2022 11:06:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o11sm287048qta.79.2022.02.23.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:06:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: add a alloc_reserved_extent helper
Date:   Wed, 23 Feb 2022 14:06:44 -0500
Message-Id: <e1fb82316352485ababc835acbc27563cf103506.1645643109.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645643109.git.josef@toxicpanda.com>
References: <cover.1645643109.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We duplicate this logic for both data and metadata, at this point we've
already done our type specific extent root operations, this is just
doing the accounting and removing the space from the free space tree.
Extract this common logic out into a helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 56 ++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7b8414fdae36..2738af449767 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4604,6 +4604,28 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
 	return ret;
 }
 
+static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
+				 u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	int ret;
+
+	ret = remove_from_free_space_tree(trans, bytenr, num_bytes);
+	if (ret)
+		return ret;
+
+	ret = btrfs_update_block_group(trans, bytenr, num_bytes, true);
+	if (ret) {
+		ASSERT(!ret);
+		btrfs_err(fs_info, "update block group failed for %llu %llu",
+			  bytenr, num_bytes);
+		return ret;
+	}
+
+	trace_btrfs_reserved_extent_alloc(fs_info, bytenr, num_bytes);
+	return 0;
+}
+
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
@@ -4664,18 +4686,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_free_path(path);
 
-	ret = remove_from_free_space_tree(trans, ins->objectid, ins->offset);
-	if (ret)
-		return ret;
-
-	ret = btrfs_update_block_group(trans, ins->objectid, ins->offset, true);
-	if (ret) { /* -ENOENT, logic error */
-		btrfs_err(fs_info, "update block group failed for %llu %llu",
-			ins->objectid, ins->offset);
-		BUG();
-	}
-	trace_btrfs_reserved_extent_alloc(fs_info, ins->objectid, ins->offset);
-	return ret;
+	return alloc_reserved_extent(trans, ins->objectid, ins->offset);
 }
 
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
@@ -4693,7 +4704,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_delayed_tree_ref *ref;
 	u32 size = sizeof(*extent_item) + sizeof(*iref);
-	u64 num_bytes;
 	u64 flags = extent_op->flags_to_set;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
@@ -4703,12 +4713,10 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (skinny_metadata) {
 		extent_key.offset = ref->level;
 		extent_key.type = BTRFS_METADATA_ITEM_KEY;
-		num_bytes = fs_info->nodesize;
 	} else {
 		extent_key.offset = node->num_bytes;
 		extent_key.type = BTRFS_EXTENT_ITEM_KEY;
 		size += sizeof(*block_info);
-		num_bytes = node->num_bytes;
 	}
 
 	path = btrfs_alloc_path();
@@ -4753,23 +4761,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	ret = remove_from_free_space_tree(trans, extent_key.objectid,
-					  num_bytes);
-	if (ret)
-		return ret;
-
-	ret = btrfs_update_block_group(trans, extent_key.objectid,
-				       fs_info->nodesize, true);
-	if (ret) { /* -ENOENT, logic error */
-		ASSERT(!ret);
-		btrfs_err(fs_info, "update block group failed for %llu %llu",
-			extent_key.objectid, extent_key.offset);
-		return ret;
-	}
-
-	trace_btrfs_reserved_extent_alloc(fs_info, extent_key.objectid,
-					  fs_info->nodesize);
-	return ret;
+	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
 int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
-- 
2.26.3

