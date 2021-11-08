Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE0449C67
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhKHT3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhKHT3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:37 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903FC061714
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:52 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bq14so16566762qkb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uad19Y5HR77Xq7mPsdksQTJA9Pjkie4My8NhRBGk92w=;
        b=inGZnlcql26rLAFWADEk4VYKTlqkvYe3Wwtg1UCHQEkXIu9CdI1zvzaz816v/jgc9P
         aLWs47EvTdIzNFHsVpasJLLBLKd2LR+F3EkzP0pjYCZkohkwSHyd6BnmtxVdVo9eYAVP
         1dMlObptZtfHMo09VKu+kmM/TvYgmx+A5Z/NTQGTuTp1VAZgfpU6cP4jE8tzocEjJatp
         KHxgEVk4sbhjsp3WUt7q+s7H3vutRnTzGn5h1HUTRXfu09p7bcrmTWZVwSVcp3erRdJQ
         W8CGVmA2bKkqWEMgrnlKdGxAYJyjC+/ilVTbNk+6cDf15/Z6acSnvc6vZQthFH37GYQW
         0hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uad19Y5HR77Xq7mPsdksQTJA9Pjkie4My8NhRBGk92w=;
        b=IUpR084PXw4mKNYjaPaMo+ESOz1gerKeYAyKjVjM63Y4uMd6nS7f3aaajk8FItSA3x
         5atACbgN1XHV9L8VkzxcnhCtMPOLLkKWjQzDyj9csisQVzzBkoE3droK6htxQk+fjDzE
         wc8aL5++c86Li0ky4RuOSsBVabwyMt0d07baUSeGD22wxWLc7tX6fPodzuhd7qR3ZnZX
         AkaWYiVE04rjsGM92mYRHFbDA6cg0GfVQzGF3uxUxQOGVD5VgwZ6Z9Uss1isy35OBL+l
         4GoG0vs0ptYYU6sKW+pb7XeoqhDW72yTEPvj6iRoBr0+jtshzErYlN5YY16849StdsNr
         V3RA==
X-Gm-Message-State: AOAM530a3A2opzeWwraCNW7YbW5DRCM3yuun33ZOQ6CXHaYYcaAuCTJ2
        l9FeVzsK+Q1PkVDmNI/6U/8XrRNp7eQrOw==
X-Google-Smtp-Source: ABdhPJxb9PLE77DgQKMx7D1PNFkcHIF4Wjux+YQT9KZsnu4B5wz1ejigkj24gCZbs6RlAIRIxBBk6A==
X-Received: by 2002:a05:620a:1908:: with SMTP id bj8mr1281955qkb.266.1636399611378;
        Mon, 08 Nov 2021 11:26:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q4sm11362070qtw.19.2021.11.08.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 01/20] btrfs-progs: simplify btrfs_make_block_group
Date:   Mon,  8 Nov 2021 14:26:29 -0500
Message-Id: <86e07f3a28c8c8e5bf2808d272563e2d4587998a.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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

