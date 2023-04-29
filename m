Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BBA6F264E
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjD2UU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjD2UUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B21FCA
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9965b0b5e9so800693276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799622; x=1685391622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBY++4kd5hHCLhE0awQpLGoynre+5dBjKiGxb7dAMTE=;
        b=qrZ37TvQ36841NcOYjX1CMYR7Ek83xKtDtJYEEC0gc0x0fwIj4n8Tieli7ze8+mYPQ
         eSIj20KDpr5lJXiRYyndcfJPlH23ZkFmsEdLDp8xI0Nd9Rhgx7RCyATQZUTYCIynz0ul
         L/jmKp1xzd4kSseu00Im5KaMzsxHJSwsmb5pxt5FEMXxqN5fI2jgefLTsXfpnJIJXlmM
         HsiehRQ37mwOq6fUuC77hww3hvwoFAkAYUfIZDocRIAYG1v6gg4TMZ5r5F6Qh8MnxVkJ
         bMdGVLLIyIRi+TrYTgVi2e2DZWsXpcbaBOiCNPLHRiBDH/XrfT/Zkf0oFaqZkcoo7z19
         XV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799622; x=1685391622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBY++4kd5hHCLhE0awQpLGoynre+5dBjKiGxb7dAMTE=;
        b=g5Cu0aT3eCHQyIr3F2kcoMpyb2n625gFErpupxcRVTjcaTcvpTj5POE7ZsTYeurz80
         Mm9q/xbFjivu6GOkoNJ31UzqtCDlocqz9SYfwIn/2NBQB50HgOyz+9s4exMWoaKR/Oj8
         t3A1g6oVotUWQ6xyhRsEsOOLLNJYZGRnGAS4VBMWNXQPkmLZYqlPIKvFj2V7ikkkgRHT
         EIZ0FtNSOHgHY+tlPwwmlsktKMAuU+kbrUnLEGUUHe5WQGK/BIgbLm7iICWTa7cKUepu
         0q/y6P99b8y1DBt9OMO4BUEcOU9tO8vV7unC82PYmLBtPdv0WZfyZJgn+AhR8rNy36Ws
         2DiA==
X-Gm-Message-State: AC+VfDyMnTFsOJcJhJy2+aPygg0FMNCdJ0egiiPFuuzya7wYmjT3JBCz
        sIC2una5JUCVTx49J9CdTID+oAsY+faOM7rMNb7czA==
X-Google-Smtp-Source: ACHHUZ63qQFMj9DhsH1DHELDWJnm07oJUA1bzl8QG6yVxy//HH7htWSwuFIQH2lH9Nx5ZYTpSKIGFg==
X-Received: by 2002:a81:4890:0:b0:54f:881e:75bb with SMTP id v138-20020a814890000000b0054f881e75bbmr7526670ywa.45.1682799621691;
        Sat, 29 Apr 2023 13:20:21 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p71-20020a0de64a000000b00552e1d1ac1esm6295640ywe.13.2023.04.29.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/26] btrfs-progs: move btrfs_set_item_key_unsafe to check/
Date:   Sat, 29 Apr 2023 16:19:46 -0400
Message-Id: <21fa88f1877d3c8c10434068c369f508acfcbe00.1682799405.git.josef@toxicpanda.com>
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
index 98cfe598..a97c3b90 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -35,6 +35,7 @@
 #include "common/messages.h"
 #include "common/string-utils.h"
 #include "cmds/commands.h"
+#include "check/repair.h"
 
 #define FIELD_BUF_LEN 80
 
diff --git a/check/repair.c b/check/repair.c
index c5afbaa1..d1407947 100644
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
index d4222600..010cd391 100644
--- a/check/repair.h
+++ b/check/repair.h
@@ -45,4 +45,9 @@ int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
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
index 9ade5fca..68c270ee 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1321,8 +1321,8 @@ again:
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
@@ -1368,29 +1368,7 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
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
@@ -2056,7 +2034,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		btrfs_mark_buffer_dirty(right);
 
 	btrfs_item_key(right, &disk_key, 0);
-	btrfs_fixup_low_keys(path, &disk_key, 1);
+	fixup_low_keys(path, &disk_key, 1);
 
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] < push_items) {
@@ -2286,7 +2264,7 @@ again:
 			path->nodes[0] = right;
 			path->slots[0] = 0;
 			if (path->slots[1] == 0)
-				btrfs_fixup_low_keys(path, &disk_key, 1);
+				fixup_low_keys(path, &disk_key, 1);
 		}
 		btrfs_mark_buffer_dirty(right);
 		return ret;
@@ -2491,7 +2469,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
 		btrfs_set_item_key(leaf, &disk_key, slot);
 		if (slot == 0)
-			btrfs_fixup_low_keys(path, &disk_key, 1);
+			fixup_low_keys(path, &disk_key, 1);
 	}
 
 	btrfs_set_item_size(leaf, slot, new_size);
@@ -2655,7 +2633,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	ret = 0;
 	if (slot == 0) {
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key);
-		btrfs_fixup_low_keys(path, &disk_key, 1);
+		fixup_low_keys(path, &disk_key, 1);
 	}
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
@@ -2728,7 +2706,7 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		struct btrfs_disk_key disk_key;
 
 		btrfs_node_key(parent, &disk_key, 0);
-		btrfs_fixup_low_keys(path, &disk_key, level + 1);
+		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
 	return ret;
@@ -2826,7 +2804,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			struct btrfs_disk_key disk_key;
 
 			btrfs_item_key(leaf, &disk_key, 0);
-			btrfs_fixup_low_keys(path, &disk_key, 1);
+			fixup_low_keys(path, &disk_key, 1);
 		}
 
 		/* delete the leaf if it is mostly empty */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3ff11dd0..d7b386db 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1051,14 +1051,9 @@ static inline int btrfs_next_item(struct btrfs_root *root,
 
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
 
 u16 btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
-- 
2.40.0

