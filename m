Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02A465521
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352218AbhLASVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352248AbhLASU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:56 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B793C06174A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:33 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p4so31991539qkm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S8rLavpX0K8kRyVpzqSbFoyoKf5rceaTacSOQ9Yu2Ug=;
        b=gbIt8i1qZhllQy7k79UF6MwsjuBIgK4B44WYR+sZSYq+CSzRsHgiqp4aiZ9ZJ8yFgJ
         uwYxhYjzczcQgrhTxaTxOwlx6Xj3dwdRsahqQOBlLnCUVEsxhPFpu6QpBy8M6cX9tXXf
         xQ6d6DNGtGPg5cqAZr9RZMG5/m/GUilSYlzXfPvoMyDbtR8tGEDanJ1EHECAZ5T0e+PP
         dRuhTWmNoaY/ZOA5+vkam/qeYR9BSj7FpZo9zEGknuJJwDrEHb5k17ZEMz8rOg8csxns
         eVZrBBr8xj+eLdJ908P5GGmMcBL7lc77djD8hqPf0VkyVYUX8CeiOEdkfYXsK2SxRRhP
         P6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8rLavpX0K8kRyVpzqSbFoyoKf5rceaTacSOQ9Yu2Ug=;
        b=iOwAOzQwUlK8P/WR4isG3YDpvcfIaFpieoku1uWmKx4OJYZUakqLewxEqjGYbvTifm
         5tfaDG15cNz9guM1vDfhZItQqkToK3Asf9aNd1/BO7T0EZAFr8QDC4ywKX6Va6ep90I/
         43m5wZPTK56SLHZkszzZJ6Ju0dEtA7ssK/9k+a9hIxvVoD0Pebf/cMMl8oNwifsZe3Ja
         Q9RlaD8usPlRLG9mN1pnWuAEuHMinVRrZ+ndz4hivAyZ4pzV5I0pAYn1a0YCc4IyB//K
         +tL4UoE9JiyIVxsbBL4cNzQPRuXGl8WL9C5wYPLI6pQIj5tEuTm5/aWSX4H29ExJ2c7O
         0auA==
X-Gm-Message-State: AOAM530oblWeyVPjIqX+KyBZYlP/dYhZ5BXpvmV3TSNFpHfAUJ9l88qF
        DCNvAbK5JFJGYoVWwPg7TJsrmalZb3eF4w==
X-Google-Smtp-Source: ABdhPJyBfMX/TJ3F1rAGPHKBv3C5LrzEyErKIRxg1wqBoY1kCFKSdemAVB//3k4k45ti9wXaEeLtTA==
X-Received: by 2002:a05:620a:2486:: with SMTP id i6mr8056514qkn.522.1638382651880;
        Wed, 01 Dec 2021 10:17:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o10sm291173qtx.33.2021.12.01.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/22] btrfs-progs: check: add block group tree support
Date:   Wed,  1 Dec 2021 13:17:04 -0500
Message-Id: <ec485813c7edf8b7ed2673ec05ad9b52a6517f73.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This makes the appropriate changes to enable the block group tree
checking for both lowmem and normal check modes.  This is relatively
straightforward, simply need to use the helper to get the right root for
dealing with block groups.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c        | 21 ++++++++++++++++++++-
 check/mode-lowmem.c |  4 ++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index b3563ee1..6341dd43 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6242,10 +6242,17 @@ static int check_type_with_root(u64 rootid, u8 key_type)
 		break;
 	case BTRFS_EXTENT_ITEM_KEY:
 	case BTRFS_METADATA_ITEM_KEY:
-	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		if (rootid != BTRFS_EXTENT_TREE_OBJECTID)
 			goto err;
 		break;
+	case BTRFS_BLOCK_GROUP_ITEM_KEY:
+		if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
+			if (rootid != BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+				goto err;
+		} else if (rootid != BTRFS_EXTENT_TREE_OBJECTID) {
+			goto err;
+		}
+		break;
 	case BTRFS_ROOT_ITEM_KEY:
 		if (rootid != BTRFS_ROOT_TREE_OBJECTID)
 			goto err;
@@ -9466,6 +9473,18 @@ again:
 		return ret;
 	}
 
+	/*
+	 * If we are extent tree v2 then we can reint the block group root as
+	 * well.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
+		ret = btrfs_fsck_reinit_root(trans, gfs_info->block_group_root);
+		if (ret) {
+			fprintf(stderr, "block group initialization failed\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * Now we have all the in-memory block groups setup so we can make
 	 * allocations properly, and the metadata we care about is safe since we
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 263b56d1..7be12e6b 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5530,7 +5530,7 @@ int check_chunks_and_extents_lowmem(void)
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path, 0, 0);
 	if (ret) {
 		error("cannot find extent tree in tree_root");
 		goto out;
@@ -5565,7 +5565,7 @@ int check_chunks_and_extents_lowmem(void)
 		if (ret)
 			goto out;
 next:
-		ret = btrfs_next_item(root, &path);
+		ret = btrfs_next_item(gfs_info->tree_root, &path);
 		if (ret)
 			goto out;
 	}
-- 
2.26.3

