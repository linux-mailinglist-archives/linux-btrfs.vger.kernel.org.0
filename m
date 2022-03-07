Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC64D0AE5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbiCGWSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343689AbiCGWSx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8308403E1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:17:57 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kd28so4782399qvb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NDUBLC3iQS6Xip8CtfMjq1KSAGbZYlpgBXPlfTX+9JY=;
        b=Snof6X2QeLleuGv0ysDH79ybLkM49uKPFud7lqQoZeksv60Rk2xk3+kOfJy6GQLWrL
         ntKE0GI5dh76ZuuSNR6ZopwNix681jARSu+3RPeE9HLZXkNZZ2BLVNSYEy9nWIbZ2cFb
         5GAZ2Go1zTRxj2YSfEu047AxFsp6hQUve8qg7O5LPyKdJUYzYgGvdbmO18gY3s+8prJT
         L2aGX6dRZyDnYSk0cLoSHOlyh7tCZz6votBKtVEFihFDuviQm5Ou3s3q/PVC954mXUVu
         ODudHC6IF/ZYFVH3DOXONUDERoYNvzFD8YsH+uJXAF0QN4RHHEy0FGsM/lgLhulEe98n
         oXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDUBLC3iQS6Xip8CtfMjq1KSAGbZYlpgBXPlfTX+9JY=;
        b=n3VXhsfp6CuIXTvxz0nAqXIVIKxeuqr6fT8yWMzB+abkmibInpmQgCch/soA2ttimO
         EnxaFwSUzo7cWcGh22Gbuxrao29k+8aWf3A9lMVjvLaUvcGdAn8mnQFjDlkXXNqYSSZb
         wNx8UHH3UGcUmZRn943l1bQ5uNlPn3sq68Me4ZgmRQn1mJUYtAiYGVb7uralswyCnlmM
         MrzojIZWo/6lGCs3i/z0mTQYkkR3alhT+yk9/IK7R4TCBEgxieC7KhUGXzY0tafFhvzB
         3vLKc1dn3Z9ALNym7n3kEEwTalykAWbAw5HRYABCvNFrDzpMNmf693qEJy36yRJTzCfu
         IIcw==
X-Gm-Message-State: AOAM530GP2RSIZMTihtPLt4VWOWqBvixf1E6Y3PZpGbE/14j1vvcCFZo
        VgFC0iU2DZt3rrosxVyRvLJcsoEeP3tcpr8E
X-Google-Smtp-Source: ABdhPJxPGqr7BPsdCZ+u3U1yMJE3nuFKPaQLCP/3Odkote168KuB7u432mlux2NVogPBXr655ZVAFg==
X-Received: by 2002:a05:6214:248b:b0:435:3fa1:5a82 with SMTP id gi11-20020a056214248b00b004353fa15a82mr9829981qvb.25.1646691476632;
        Mon, 07 Mar 2022 14:17:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e9-20020ac85989000000b002de2bfc8f94sm9179530qte.88.2022.03.07.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/15] btrfs-progs: mkfs: add a helper for temp buffer clearing
Date:   Mon,  7 Mar 2022 17:17:38 -0500
Message-Id: <617342ccb42833d8688f9b7631771950f6664459.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

We clear the temporary buffer every time we write a new block, and we
have this memset() code duplicated everywhere.  Change this to a helper
and use the appropriate helper to figure out where the items start.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 2e13da17..652484f6 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -42,14 +42,22 @@ static u64 reference_root_table[] = {
 	[MKFS_BLOCK_GROUP_TREE]	=	BTRFS_BLOCK_GROUP_TREE_OBJECTID,
 };
 
+static inline void clear_buffer_items(struct extent_buffer *buf,
+				      struct btrfs_mkfs_config *cfg)
+{
+	unsigned long offset = btrfs_item_nr_offset(buf, 0);
+
+	memset_extent_buffer(buf, 0, offset, cfg->nodesize - offset);
+}
+
 static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
 				  struct extent_buffer *buf, u64 objectid,
 				  u64 block)
 {
 	int ret;
 
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-	       cfg->nodesize - sizeof(struct btrfs_header));
+
+	clear_buffer_items(buf, cfg);
 	btrfs_set_header_bytenr(buf, block);
 	btrfs_set_header_owner(buf, objectid);
 	btrfs_set_header_nritems(buf, 0);
@@ -76,8 +84,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	int i;
 	u8 uuid[BTRFS_UUID_SIZE];
 
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
+	clear_buffer_items(buf, cfg);
 	memset(&root_item, 0, sizeof(root_item));
 	memset(&disk_key, 0, sizeof(disk_key));
 
@@ -153,8 +160,7 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	int nritems = 0;
 	int ret;
 
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-	       cfg->nodesize - sizeof(struct btrfs_header));
+	clear_buffer_items(buf, cfg);
 	itemoff -= sizeof(*info);
 
 	btrfs_set_disk_key_objectid(&disk_key, group_start);
@@ -215,8 +221,7 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 {
 	int ret;
 
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
+	clear_buffer_items(buf, cfg);
 	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used, 0,
 			       cfg->leaf_data_size -
 			       sizeof(struct btrfs_block_group_item));
@@ -250,8 +255,7 @@ static int fill_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 	first_free &= ~((u64)cfg->sectorsize - 1);
 
 	/* create the items for the extent tree */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
+	clear_buffer_items(buf, cfg);
 	itemoff = cfg->leaf_data_size;
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
@@ -486,8 +490,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	}
 
 	/* create the chunk tree */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
+	clear_buffer_items(buf, cfg);
 	nritems = 0;
 	item_size = sizeof(*dev_item);
 	itemoff = cfg->leaf_data_size - item_size;
@@ -575,8 +578,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	}
 
 	/* create the device tree */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
+	clear_buffer_items(buf, cfg);
 	nritems = 0;
 	itemoff = cfg->leaf_data_size - sizeof(struct btrfs_dev_extent);
 
-- 
2.26.3

