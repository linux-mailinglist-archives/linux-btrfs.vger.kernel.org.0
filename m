Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B74C0495
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiBVW07 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBVW06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:26:58 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B6B23
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:32 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a1so3503085qvl.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5ncJGUm3CmUqE60m4mWQV2B5JlQzXDzME+OHPly9r7M=;
        b=SCFDxA8YQkDPErnmk11heDk5i6S6AkNfiMX3bu/dG5xHF7b+gLW2Fog8S+0Nk13d1C
         ZKB/XD6F3F7snxo9XOa3xEh/46tmfm1W+I5+qLfaSgJuSFcyuO4FTyDQ8foy8xzg+/lc
         ZUUjo2zhkwf92z77BsxD9lZut85d56JQNzcnAQTld1rUBmV/SXMb2wuEEoqZzIVkOG6p
         fTmNFvyOuq3QpBNkBSLzxTy5pmbTLOn/yZdEHktYWVGC2Kjy5v1MHO6xXQt6UEzlkBG3
         LviHUs6lh8NP+uql12iDqV5jjrLeMQyp3R0x5ALQlg1jT0Xe5o2I7JyQ8js6Y5YEgcCz
         3wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ncJGUm3CmUqE60m4mWQV2B5JlQzXDzME+OHPly9r7M=;
        b=p+qAWIyfK4ftMo6rv6aGL0lV9ZjPGvS4lYBX8VGfDJ5tBCdsoHvGxH6qWdOX6ydyxo
         XqnON01poXcXKiRmEm1WzjlQKrO8YC0swkr2Z1yOVxcRlRWYxUIatawjOSt+g90mCUbC
         R3cpemPS+vduiBrq/KXDy6rC7W464IsWKnJbp+BQCeka+7ulDGS1T4onS72NTIVKSZK1
         E7eLfDhn/qE5JOvB/AMoOMrbJhPYhBHOsu/4puVw4FORDJRKYSBhzkfRwRVzuB+HjUbs
         Q9TFBIlVRvbjRbojcxrk6ldnWlXktC+VDFBWrpIQIeEWpZtf35mxmW8zXGcwOi3k/9/W
         2TmQ==
X-Gm-Message-State: AOAM532fhzLqel0A/aOEbQqoqaPUHkOO+N+sf8y/3nIeKcPUpZ9bOtUE
        /YPdwAFR1YSrfyvUi0R1qiIa/Z42+x7aG6Vn
X-Google-Smtp-Source: ABdhPJyWOpmGk7dlNFZenmj/htWW3GVGonXjLVRb0Nzcm4LGk/Eeg0E/XwIr1j0fUXlrlSkGBR6laQ==
X-Received: by 2002:ad4:53c5:0:b0:42d:7bb4:a8e8 with SMTP id k5-20020ad453c5000000b0042d7bb4a8e8mr20860599qvv.8.1645568791044;
        Tue, 22 Feb 2022 14:26:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x12sm752419qtw.9.2022.02.22.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/13] btrfs-progs: reduce usage of __BTRFS_LEAF_DATA_SIZE
Date:   Tue, 22 Feb 2022 17:26:15 -0500
Message-Id: <dc71da10bbb0a0cfd5cb3da856e69014e362dfa0.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

This helper only takes the nodesize, but in the future it'll take a bool
to indicate if we're extent tree v2.  The remaining users are all where
we only have extent_buffer, but we should always have a valid
eb->fs_info in these cases, so add BUG_ON()'s for the !eb->fs_info case
and then convert these callers to use BTRFS_LEAF_DATA_SIZE which takes
the fs_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c      | 5 +++--
 kernel-shared/ctree.h      | 5 +++--
 kernel-shared/print-tree.c | 2 +-
 mkfs/common.c              | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 950923d0..10b22b2c 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1949,8 +1949,9 @@ int btrfs_leaf_free_space(struct extent_buffer *leaf)
 	u32 leaf_data_size;
 	int ret;
 
-	BUG_ON(leaf->fs_info && leaf->fs_info->nodesize != leaf->len);
-	leaf_data_size = __BTRFS_LEAF_DATA_SIZE(leaf->len);
+	BUG_ON(!leaf->fs_info);
+	BUG_ON(leaf->fs_info->nodesize != leaf->len);
+	leaf_data_size = BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
 	ret = leaf_data_size - leaf_space_used(leaf, 0 ,nritems);
 	if (ret < 0) {
 		printk("leaf free space ret %d, leaf data size %u, used %d nritems %d\n",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 31169f33..d9677bce 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1328,8 +1328,9 @@ static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
 
 static inline u32 BTRFS_NODEPTRS_PER_EXTENT_BUFFER(const struct extent_buffer *eb)
 {
-	BUG_ON(eb->fs_info && eb->fs_info->nodesize != eb->len);
-	return __BTRFS_LEAF_DATA_SIZE(eb->len) / sizeof(struct btrfs_key_ptr);
+	BUG_ON(!eb->fs_info);
+	BUG_ON(eb->fs_info->nodesize != eb->len);
+	return BTRFS_LEAF_DATA_SIZE(eb->fs_info) / sizeof(struct btrfs_key_ptr);
 }
 
 #define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index bd75ae51..7308599f 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1288,7 +1288,7 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 {
 	struct btrfs_item *item;
 	struct btrfs_disk_key disk_key;
-	u32 leaf_data_size = __BTRFS_LEAF_DATA_SIZE(eb->len);
+	u32 leaf_data_size = BTRFS_LEAF_DATA_SIZE(eb->fs_info);
 	u32 i;
 	u32 nr;
 	const bool print_csum_items = (mode & BTRFS_PRINT_TREE_CSUM_ITEMS);
diff --git a/mkfs/common.c b/mkfs/common.c
index aee4b9fb..f3e689cb 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -326,7 +326,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
 	nritems = 0;
-	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	itemoff = cfg->leaf_data_size;
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
 
-- 
2.26.3

