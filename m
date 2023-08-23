Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFA785AA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjHWOdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjHWOdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AEE5F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5925e580e87so8150247b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801205; x=1693406005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdjZjPhS25CFNhSP07KJQZLiGxYjA/BPasxjgyWmPcQ=;
        b=mddn1k8uEMnJfTTJ8N9gAaBKur8qIf9OjtwK5T9ie5OJFZIcI3N+Otq36vtbkql1T1
         4Q28/EjK4F0O++6G4eZPqmEVOFRM4LFfYm9dbh+UYujtXgmzY0xdBpZaMWXI22bHAcvp
         9gKbeDhpNCyzSYRuNZSy5wpj43zcAm+Z+w62YwgeCv0pPISkIvLKOCOL5Ao4uSVlbN6G
         wXJw8giha0AHfe8Vz3cRVrh66cp5YuMYirsbJaqx4Gz/ZVrPwND2p6PVVLAAyCAInX69
         wlaCFo8mYY/lIwjq3cWXIX+qBbFva2ifUFaujWqI+kujpe8szNgwSuQTcL8zytSSy9h6
         vVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801205; x=1693406005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdjZjPhS25CFNhSP07KJQZLiGxYjA/BPasxjgyWmPcQ=;
        b=FBmpczv27P3dNeYcR4gBY2uxNjgmoKpXKvQTCOCQpdMm1qHlukUTFsXAiNsb2WvNn7
         WVTJoful7tq7djUPTPKp3tCPEKryNaW3EMVlfOBySDCXtq8AmlwROAuGf8ztU0b9TI54
         lZutjmBJg514bZ7Hper0MdI3kcRhYi3DUcnfCib0I3uuGSrmj8ZZULq9szsIvOmEOSzF
         MSqc8GVdCsTZY5AIXYndOWSBlo4H3XWGBTjsBLrPRPUYhOnXNNRcrM3sYbnMHpRooJ6t
         ilbDlWI3gihrt6eU3TzzudSNuzzzE16LCUxrYDI6tlsSEpkxabl/hzPepaDuLL1+Mt0c
         a5Hw==
X-Gm-Message-State: AOJu0YyQW9WdJ6WGwauXIeCq1EqMQe7QHm5by2EhwL1KQr1MsCuYoi2E
        RaDft4Q+mAaxMWkVb46n4+xEr2VmSUxIUMWRmNU=
X-Google-Smtp-Source: AGHT+IHHwJAFNYW2KwG584vhMcg1dlXoEJPd5nWHQK0bT2oVo3krwNNsNOhgX8kVnygxrIXjNALswA==
X-Received: by 2002:a0d:cc4f:0:b0:589:9717:22c7 with SMTP id o76-20020a0dcc4f000000b00589971722c7mr13637616ywd.22.1692801205372;
        Wed, 23 Aug 2023 07:33:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r67-20020a0de846000000b00589e84acafasm3379307ywe.48.2023.08.23.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/38] btrfs-progs: move btrfs_set_item_key_unsafe to check/
Date:   Wed, 23 Aug 2023 10:32:40 -0400
Message-ID: <3c55d9a5d40e799d82bea269de589a41e44a6b56.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This helper exists for check and for btrfs-corrupt-block.  Move the
helper and the btrfs_fixup_low_keys helper into check/repair.[ch] so we
can keep the kernel-shared sources close to the upstream kernel.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c |  1 +
 check/repair.c        | 47 +++++++++++++++++++++++++++++++++++++++++++
 check/repair.h        |  5 +++++
 kernel-shared/ctree.c | 40 +++++++++---------------------------
 kernel-shared/ctree.h |  5 -----
 5 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 3c742cc8..3e741c08 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -35,6 +35,7 @@
 #include "common/messages.h"
 #include "common/string-utils.h"
 #include "cmds/commands.h"
+#include "check/repair.h"
 
 #define FIELD_BUF_LEN 80
 
diff --git a/check/repair.c b/check/repair.c
index eacf4506..d8900c41 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -33,6 +33,53 @@
 
 int opt_check_repair = 0;
 
+/*
+ * adjust the pointers going up the tree, starting at level
+ * making sure the right key of each node is points to 'key'.
+ * This is used after shifting pointers to the left, so it stops
+ * fixing up pointers when a given leaf/node is not in slot 0 of the
+ * higher levels
+ */
+void btrfs_fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
+			  int level)
+{
+	int i;
+	struct extent_buffer *t;
+
+	for (i = level; i < BTRFS_MAX_LEVEL; i++) {
+		int tslot = path->slots[i];
+		if (!path->nodes[i])
+			break;
+		t = path->nodes[i];
+		btrfs_set_node_key(t, key, tslot);
+		btrfs_mark_buffer_dirty(path->nodes[i]);
+		if (tslot != 0)
+			break;
+	}
+}
+
+/*
+ * update an item key without the safety checks.  This is meant to be called by
+ * fsck only.
+ */
+void btrfs_set_item_key_unsafe(struct btrfs_root *root,
+			       struct btrfs_path *path,
+			       struct btrfs_key *new_key)
+{
+	struct btrfs_disk_key disk_key;
+	struct extent_buffer *eb;
+	int slot;
+
+	eb = path->nodes[0];
+	slot = path->slots[0];
+
+	btrfs_cpu_key_to_disk(&disk_key, new_key);
+	btrfs_set_item_key(eb, &disk_key, slot);
+	btrfs_mark_buffer_dirty(eb);
+	if (slot == 0)
+		btrfs_fixup_low_keys(path, &disk_key, 1);
+}
+
 int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 				    struct btrfs_key *first_key,
 				    u64 start, u64 len, int level)
diff --git a/check/repair.h b/check/repair.h
index 3c44a498..81440a87 100644
--- a/check/repair.h
+++ b/check/repair.h
@@ -45,5 +45,10 @@ int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
 			   struct extent_io_tree *tree);
 enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *eb,
 							  struct btrfs_key *first_key);
+void btrfs_set_item_key_unsafe(struct btrfs_root *root,
+			       struct btrfs_path *path,
+			       struct btrfs_key *new_key);
+void btrfs_fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
+			  int level);
 
 #endif
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index bbbb2cc3..8eba7812 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1485,8 +1485,8 @@ again:
  * fixing up pointers when a given leaf/node is not in slot 0 of the
  * higher levels
  */
-void btrfs_fixup_low_keys( struct btrfs_path *path, struct btrfs_disk_key *key,
-		int level)
+static void fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
+			   int level)
 {
 	int i;
 	struct extent_buffer *t;
@@ -1532,29 +1532,7 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 	btrfs_set_item_key(eb, &disk_key, slot);
 	btrfs_mark_buffer_dirty(eb);
 	if (slot == 0)
-		btrfs_fixup_low_keys(path, &disk_key, 1);
-}
-
-/*
- * update an item key without the safety checks.  This is meant to be called by
- * fsck only.
- */
-void btrfs_set_item_key_unsafe(struct btrfs_root *root,
-			       struct btrfs_path *path,
-			       struct btrfs_key *new_key)
-{
-	struct btrfs_disk_key disk_key;
-	struct extent_buffer *eb;
-	int slot;
-
-	eb = path->nodes[0];
-	slot = path->slots[0];
-
-	btrfs_cpu_key_to_disk(&disk_key, new_key);
-	btrfs_set_item_key(eb, &disk_key, slot);
-	btrfs_mark_buffer_dirty(eb);
-	if (slot == 0)
-		btrfs_fixup_low_keys(path, &disk_key, 1);
+		fixup_low_keys(path, &disk_key, 1);
 }
 
 /*
@@ -2213,7 +2191,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		btrfs_mark_buffer_dirty(right);
 
 	btrfs_item_key(right, &disk_key, 0);
-	btrfs_fixup_low_keys(path, &disk_key, 1);
+	fixup_low_keys(path, &disk_key, 1);
 
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] < push_items) {
@@ -2439,7 +2417,7 @@ again:
 			path->nodes[0] = right;
 			path->slots[0] = 0;
 			if (path->slots[1] == 0)
-				btrfs_fixup_low_keys(path, &disk_key, 1);
+				fixup_low_keys(path, &disk_key, 1);
 		}
 		btrfs_mark_buffer_dirty(right);
 		return ret;
@@ -2644,7 +2622,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
 		btrfs_set_item_key(leaf, &disk_key, slot);
 		if (slot == 0)
-			btrfs_fixup_low_keys(path, &disk_key, 1);
+			fixup_low_keys(path, &disk_key, 1);
 	}
 
 	btrfs_set_item_size(leaf, slot, new_size);
@@ -2808,7 +2786,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	ret = 0;
 	if (slot == 0) {
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key);
-		btrfs_fixup_low_keys(path, &disk_key, 1);
+		fixup_low_keys(path, &disk_key, 1);
 	}
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
@@ -2881,7 +2859,7 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		struct btrfs_disk_key disk_key;
 
 		btrfs_node_key(parent, &disk_key, 0);
-		btrfs_fixup_low_keys(path, &disk_key, level + 1);
+		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
 	return ret;
@@ -2979,7 +2957,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			struct btrfs_disk_key disk_key;
 
 			btrfs_item_key(leaf, &disk_key, 0);
-			btrfs_fixup_low_keys(path, &disk_key, 1);
+			fixup_low_keys(path, &disk_key, 1);
 		}
 
 		/* delete the leaf if it is mostly empty */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 0d9b75bf..3e00d69b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1052,14 +1052,9 @@ static inline int btrfs_next_item(struct btrfs_root *root,
 
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
-void btrfs_fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
-		int level);
 void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
-void btrfs_set_item_key_unsafe(struct btrfs_root *root,
-			       struct btrfs_path *path,
-			       struct btrfs_key *new_key);
 
 int btrfs_super_csum_size(const struct btrfs_super_block *sb);
 const char *btrfs_super_csum_name(u16 csum_type);
-- 
2.41.0

