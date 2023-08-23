Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4323E785A9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjHWOda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjHWOd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:27 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B68210C6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:20 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58419517920so60579157b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801199; x=1693405999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lm1RrsRXMw9AwyqJMVi67ASxVO/3qsz3sTdIMV/NCwI=;
        b=FZKWmSoG53VO7+VhcEcfSG5hV9YAP/kf289XlHTe0zG82IJX7UYA0HaHcX8FnYqFeq
         PI8uWmyYYC3MWL/CzvbIINqazOUSXnvcxEwHWBWiJEcjMPayosufPWDlPqPn539beK9E
         s8aieAq1v/CkOgLfISD+WPj1rLwEQNHQQ3OBRgsEARUBV2pyRrIpHquHFr3t1tiN2sWG
         vp2gnQcvIWZQ7M1l4xiMWS1UQE53dN/jw/NRAO6SLoPXM8sI6br0cEQ84LfYLyJqw5Uh
         /DYwP14yZLm4AzbrornBWGj0RsZX9Y2f1wl3By5zts0bx3udMO4wjklTFXYTNStA5NDZ
         dOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801199; x=1693405999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm1RrsRXMw9AwyqJMVi67ASxVO/3qsz3sTdIMV/NCwI=;
        b=D2djC8wu60RmsFqcc0DXDdZLLuNnQDTFghnBPYgTB2Mcgn9RI2mVeL34IL/JRlQNtt
         la2bz0QMHTeprhhfgLldAGymNjvuWTp+u5i7oYW7Ei4ZtBc3rpGipgISZshTUF2QPkzH
         xCdhUUMP3JMde/4bKgp9evYbN4t6N0Qgixl5+nYQPbvI/NkqHqayhB5w/7HxN71LjnW3
         mAtg+JmtkN7xAY5YrrfmKC8+6/H6bgE1pzXdIqRAnNRDMRPG2GFmNc4kwtTFtOlelyqc
         qeOUX/Z5d1HTRXkazzrpUK2Sjc7GoQSVpVaBLm0orwKJE57rWsJge0pZbyWl2U9eYzKe
         JMSA==
X-Gm-Message-State: AOJu0YwiLxvigMI9yt1RveTZMZKRvhfN7+2pKURreF08W2UQIlnKgAh8
        gYlnKB6JeXBjS2eaBu+jXvsWGE2ZBGAqRXOQ1RM=
X-Google-Smtp-Source: AGHT+IGu16VdpScP9/pGU/Ebx783SRuZY3feMoTLh5V4eh7JJbWHLllWa+qyIsAucPJOBsvUubjU5A==
X-Received: by 2002:a0d:dd52:0:b0:589:a9fd:a with SMTP id g79-20020a0ddd52000000b00589a9fd000amr12975548ywe.10.1692801199387;
        Wed, 23 Aug 2023 07:33:19 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x186-20020a0deec3000000b00586108dd8f5sm3355120ywe.18.2023.08.23.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/38] btrfs-progs: update btrfs_print_leaf to match the kernel definition
Date:   Wed, 23 Aug 2023 10:32:35 -0400
Message-ID: <c012b03497b833c683cece4f98cfc43ccd4afbe2.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
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
index 501b90a1..9726bef5 100644
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
index f94d3ef1..2f96d701 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2566,7 +2566,7 @@ split:
 
 	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	kfree(buf);
@@ -2658,7 +2658,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
 	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	return ret;
@@ -2682,7 +2682,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	data_end = leaf_data_end(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < data_size) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	slot = path->slots[0];
@@ -2690,7 +2690,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	BUG_ON(slot < 0);
 	if (slot >= nritems) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		printk("slot %d too large, nritems %u\n", slot, nritems);
 		BUG_ON(1);
 	}
@@ -2717,7 +2717,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 	return ret;
@@ -2765,7 +2765,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	data_end = leaf_data_end(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < total_size) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		printk("not enough freespace need %u have %d\n",
 		       total_size, btrfs_leaf_free_space(leaf));
 		BUG();
@@ -2778,7 +2778,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
 		if (old_data < data_end) {
-			btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+			btrfs_print_leaf(leaf);
 			printk("slot %d old_data %u data_end %u\n",
 			       slot, old_data, data_end);
 			BUG_ON(1);
@@ -2824,7 +2824,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	}
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		BUG();
 	}
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8c7dab3f..f23c28af 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -936,7 +936,7 @@ again:
 		printf("Size is %u, needs to be %u, slot %d\n",
 		       (unsigned)item_size,
 		       (unsigned)sizeof(*ei), path->slots[0]);
-		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(leaf);
 		return -EINVAL;
 	}
 
@@ -1427,7 +1427,7 @@ again:
 	}
 
 	if (ret != 0) {
-		btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(path->nodes[0]);
 		printk("failed to find block number %llu\n",
 			(unsigned long long)bytenr);
 		BUG();
@@ -2033,7 +2033,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 				printk(KERN_ERR "umm, got %d back from search"
 				       ", was looking for %llu\n", ret,
 				       (unsigned long long)bytenr);
-				btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
+				btrfs_print_leaf(path->nodes[0]);
 			}
 			BUG_ON(ret);
 			extent_slot = path->slots[0];
@@ -2047,7 +2047,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 		       (unsigned long long)owner_objectid,
 		       (unsigned long long)owner_offset);
 		printf("path->slots[0]: %d path->nodes[0]:\n", path->slots[0]);
-		btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_leaf(path->nodes[0]);
 		ret = -EIO;
 		goto fail;
 	}
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 38524971..b7ca8b7e 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1301,7 +1301,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	fflush(stdout);
 }
 
-void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
+void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 {
 	struct btrfs_disk_key disk_key;
 	u32 leaf_data_size = BTRFS_LEAF_DATA_SIZE(eb->fs_info);
@@ -1614,7 +1614,7 @@ void btrfs_print_tree(struct extent_buffer *eb, unsigned int mode)
 
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
2.41.0

