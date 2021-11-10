Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D151644CA20
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhKJUK7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJUK7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:10:59 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51755C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:11 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l8so3281372qtk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uad19Y5HR77Xq7mPsdksQTJA9Pjkie4My8NhRBGk92w=;
        b=Fohxt7zIDT6QuJ8C9V9a70Hge46X7Ix8Pa7etADauEohLLEzAxLcNx1MnNpO0t3aps
         ZP5BFyEh24VHkHFuS/Lb6wfoEqmYCUC3WUq9Kr6MIc5lnAM0Ap/bOiYegQCAPIMtdJsG
         spek5S3oFSVXZYHm64e3giY3qMWo0cyT++G9Tk2edQ9u30p+osMdTTbxuMJ6g7HPxXhl
         RLd9I7YSdZaO7omO7nWM8OnqiMmgcBgUKWaQAFvT/8q+ODXfAjvEiwToJJjUtwfZpQl4
         wcS4uEh73FPsvpliZki/MDTo5wQQWODkvXR0ywD+uqRwCyCOUV4DFPCRJMESAUy++Y7+
         y0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uad19Y5HR77Xq7mPsdksQTJA9Pjkie4My8NhRBGk92w=;
        b=rglytdeSPcDlBu/zz2nUYtBU/xEW2T2e3UYokXWobRQ8T30jHZCryGjld45u4RsamL
         FwFgHa/MXu/vclN6rrR+zJEE2RmHqL5NtuSrFoIYRNZX1NCwC8henfDqkgl9iuKDGL5L
         sZoJgdWI5Pz88OEG3jAti9V0G22Oex1wVjA/t+oykZ+1N6pdbIINZd7fQGnBPVLLbux1
         K+B7HtZRTxMs5rLsIa+eXWCg1sooC1mVL1Zwg0cOe0laEslFDCtrwZTyhz85xJS0Ccd0
         oqrJBghVqT6dznzvUTts/7/c1NGoMxHGOBh+sr6AH6jZjUxBAB4UbC0QJ0476Pj56Aih
         lgOQ==
X-Gm-Message-State: AOAM532JwpN2W3lIgOJB8Phuk4QqumodJSsyPDiodeJoNiJZMMqDcOHC
        XvKcJbc+LUT1cP6MnZIeQA/ypZS09sBZRA==
X-Google-Smtp-Source: ABdhPJyQ1Oq82pnu7KZCdAYrUcWdekT7NH5MWcCciSdJWsg+TzIM/5IPrvhWjnW/hco4+PMYnucH/Q==
X-Received: by 2002:a05:622a:1649:: with SMTP id y9mr1874699qtj.268.1636574889631;
        Wed, 10 Nov 2021 12:08:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h22sm387603qkk.14.2021.11.10.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 02/13] btrfs-progs: simplify btrfs_make_block_group
Date:   Wed, 10 Nov 2021 15:07:53 -0500
Message-Id: <dc9a4339d98293391ee67ba33ef138c5615baa31.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is doing the same work as insert_block_group_item, rework it to
call the helper instead.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 43 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8e0614e0..a918e5aa 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2791,33 +2791,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	return cache;
 }
 
-int btrfs_make_block_group(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *fs_info, u64 bytes_used,
-			   u64 type, u64 chunk_offset, u64 size)
-{
-	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_block_group *cache;
-	struct btrfs_block_group_item bgi;
-	struct btrfs_key key;
-
-	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
-				      size);
-	btrfs_set_stack_block_group_used(&bgi, cache->used);
-	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	key.objectid = cache->start;
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	key.offset = cache->length;
-	ret = btrfs_insert_item(trans, extent_root, &key, &bgi, sizeof(bgi));
-	BUG_ON(ret);
-
-	add_block_group_free_space(trans, cache);
-
-	return 0;
-}
-
 static int insert_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group)
 {
@@ -2838,6 +2811,22 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
+int btrfs_make_block_group(struct btrfs_trans_handle *trans,
+			   struct btrfs_fs_info *fs_info, u64 bytes_used,
+			   u64 type, u64 chunk_offset, u64 size)
+{
+	struct btrfs_block_group *cache;
+	int ret;
+
+	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
+				      size);
+	ret = insert_block_group_item(trans, cache);
+	if (ret)
+		return ret;
+	add_block_group_free_space(trans, cache);
+	return 0;
+}
+
 /*
  * This is for converter use only.
  *
-- 
2.26.3

