Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1F36F2653
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjD2UUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2UUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:21 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA372D48
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:15 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fc6949475so16190377b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799615; x=1685391615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TCKTtVCWVNpQUsqkDAwp0VyD518nvd6nSe8DMgbRa0=;
        b=eV+XjpPZfhSfqZeMPKC0w7hMzbPQfDORIYo3JUC0fHeDUOabgSFR3/EW1BzNOaeVqM
         I4UjozVW1RgqWNnFH8Bi9f6pkZchWgGPAgVYXSSmqVJxyNIYXhJ5Mmu4dUgaVwI91dCg
         Fio7IJraZWScbO8Fw7iHUMAuXz5yuAhSIP15I6b8xhhlgT9xAychLnVAE6AzR4oUo0rz
         wxnRZMsB9O2m2fKy4Hv0MsGHLoxhpySNVBh1nUefZ0mNNry2n9Kpc6d/z7yNlRwgr1Ha
         E5DgZ3YigJEUifxIQXktVq6q4cHus34RAAjPnNKUcaTDJSLZdTmeHV/3nVAMVl9oVwPq
         ZXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799615; x=1685391615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TCKTtVCWVNpQUsqkDAwp0VyD518nvd6nSe8DMgbRa0=;
        b=DaHo02XsfrBQ7KrYwQJ3Y0hk8mzBF9qH9yT5a4g7u05sxBZiHxwSuyOwcgnrAByv2k
         FrtlIvK42fLf0r0Tk9Ev3LPbJUhxhMXMEFoDmh+VzRLnTnVJ27CYbrR8cyTm46I2sCSd
         z/eqDky2AV+CuY47VRFRngyUFmtHzD2f3/wBSUhYJ/0Vgm0WqY6xhG+w02b+yY7kUkIH
         C9t0YZOXMKr3EHKmNl0K4Cx6pTFDHeED/t+74aRxo/Tg+fN6cdJyPpj6NYWoXc9lbwVu
         aoLMaW+fAgRFNANZqhxv8ujJFw9rQAlLwLSctnI6TwuoFixO8mq48207sqwGXnenjYwh
         xe1Q==
X-Gm-Message-State: AC+VfDwqZy2Qx4HNhzRPs3/plMBczqDSHjXSshByCKLJCqPIZqE+MD5B
        b1vm+zNpQs8/y9a1A+UEaELW6Gp1ax4hsh9VSa9vNA==
X-Google-Smtp-Source: ACHHUZ4dkuUEnB86ieas55WKLEuzhNNT2Wam9H0dGMp8QgieGVb4Cbhi2qh8SKJw5SASYAVEukzM7w==
X-Received: by 2002:a0d:d946:0:b0:54f:9e41:df5a with SMTP id b67-20020a0dd946000000b0054f9e41df5amr8676214ywe.15.1682799614737;
        Sat, 29 Apr 2023 13:20:14 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n207-20020a0dcbd8000000b00555df877a4csm6221969ywd.102.2023.04.29.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/26] btrfs-progs: update btrfs_print_leaf to match the kernel definition
Date:   Sat, 29 Apr 2023 16:19:40 -0400
Message-Id: <58cd7cf8ddd1bb5616a7405e06a6ed96736cfe14.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

In the kernel we have btrfs_print_leaf(eb) instead of
btrfs_print_leaf(eb, mode).  In fact in all of the kernel-shared sources
we're just using the default mode.  Fix this to have a
__btrfs_print_leaf() which handles the mode for the user space utilities
that want the different behavior, and then change btrfs_print_leaf() to
just be the normal default style.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/inspect-dump-tree.c    |  2 +-
 kernel-shared/ctree.c       | 16 ++++++++--------
 kernel-shared/extent-tree.c |  8 ++++----
 kernel-shared/print-tree.c  |  4 ++--
 kernel-shared/print-tree.h  |  7 ++++++-
 5 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 7c524b04..5385208d 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -52,7 +52,7 @@ static void print_extents(struct extent_buffer *eb)
 		return;
 
 	if (btrfs_is_leaf(eb)) {
-		btrfs_print_leaf(eb, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(eb);
 		return;
 	}
 
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 94aa45a3..a23128ee 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2418,7 +2418,7 @@ split:
 
 	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	kfree(buf);
@@ -2510,7 +2510,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
 	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	return ret;
@@ -2534,7 +2534,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	data_end = leaf_data_end(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < data_size) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	slot = path->slots[0];
@@ -2542,7 +2542,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	BUG_ON(slot < 0);
 	if (slot >= nritems) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		printk("slot %d too large, nritems %u\n", slot, nritems);
 		BUG_ON(1);
 	}
@@ -2569,7 +2569,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	return ret;
@@ -2617,7 +2617,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	data_end = leaf_data_end(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < total_size) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		printk("not enough freespace need %u have %d\n",
 		       total_size, btrfs_leaf_free_space(leaf));
 		BUG();
@@ -2630,7 +2630,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
 		if (old_data < data_end) {
-			btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+			btrfs_print_leaf(leaf);
 			printk("slot %d old_data %u data_end %u\n",
 			       slot, old_data, data_end);
 			BUG_ON(1);
@@ -2676,7 +2676,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	}
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index bbce9587..fa83d152 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -937,7 +937,7 @@ again:
 		printf("Size is %u, needs to be %u, slot %d\n",
 		       (unsigned)item_size,
 		       (unsigned)sizeof(*ei), path->slots[0]);
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		return -EINVAL;
 	}
 
@@ -1428,7 +1428,7 @@ again:
 	}
 
 	if (ret != 0) {
-		btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(path->nodes[0]);
 		printk("failed to find block number %llu\n",
 			(unsigned long long)bytenr);
 		BUG();
@@ -2034,7 +2034,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 				printk(KERN_ERR "umm, got %d back from search"
 				       ", was looking for %llu\n", ret,
 				       (unsigned long long)bytenr);
-				btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
+				btrfs_print_leaf(path->nodes[0]);
 			}
 			BUG_ON(ret);
 			extent_slot = path->slots[0];
@@ -2048,7 +2048,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 		       (unsigned long long)owner_objectid,
 		       (unsigned long long)owner_offset);
 		printf("path->slots[0]: %d path->nodes[0]:\n", path->slots[0]);
-		btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(path->nodes[0]);
 		ret = -EIO;
 		goto fail;
 	}
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 594c524f..ff2a8097 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1294,7 +1294,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	fflush(stdout);
 }
 
-void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
+void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 {
 	struct btrfs_disk_key disk_key;
 	u32 leaf_data_size = BTRFS_LEAF_DATA_SIZE(eb->fs_info);
@@ -1607,7 +1607,7 @@ void btrfs_print_tree(struct extent_buffer *eb, unsigned int mode)
 
 	nr = btrfs_header_nritems(eb);
 	if (btrfs_is_leaf(eb)) {
-		btrfs_print_leaf(eb, mode);
+		__btrfs_print_leaf(eb, mode);
 		return;
 	}
 	/* We are crossing eb boundary, this node must be corrupted */
diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
index 80fb6ef7..c1e75d1e 100644
--- a/kernel-shared/print-tree.h
+++ b/kernel-shared/print-tree.h
@@ -34,7 +34,12 @@ enum {
 };
 
 void btrfs_print_tree(struct extent_buffer *eb, unsigned int mode);
-void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode);
+void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode);
+
+static inline void btrfs_print_leaf(struct extent_buffer *eb)
+{
+	__btrfs_print_leaf(eb, BTRFS_PRINT_TREE_DEFAULT);
+}
 
 void btrfs_print_key(struct btrfs_disk_key *disk_key);
 void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk);
-- 
2.40.0

