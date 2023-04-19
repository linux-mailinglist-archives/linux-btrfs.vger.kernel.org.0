Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A86E83A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjDSVZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjDSVZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A38689
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id bo1so1028196qvb.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939478; x=1684531478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4d9dlI9QBPf0vLp3BaoKPS5RQinDkIAsHMQ8+cBNrNE=;
        b=vsYjhgLoNg7bbkJStgQZTF0a6oxGnUDnTPsm4YHrLW7890qgwAHltTyHrYSEfVfHgz
         Y4cJDVAZL4StTLpuI2/Xqq7ofcelmMBBTBWHHtNOhhy+iMFzmH3OcktkmNZ7k0eSiB2j
         2NwHmdh5Zgre/y7bzDLbLAaEWRIOHVKUuLASauAkEGvIfWdW6lJFHl/7UCpm/d6vrgtR
         4+gnoGKjAKnCRe9caSfQKkZPqG6DRcMhY6x03qXBbGIKnM1RwQxqRZIzifYEInIY2EE3
         z27/iAYJ5PyG7Wfh4TzdxzeEm6Et0MtWzOv4u3vBfTWQjdu4dhDZuFrTAub3U8t4oBhZ
         b9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939478; x=1684531478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4d9dlI9QBPf0vLp3BaoKPS5RQinDkIAsHMQ8+cBNrNE=;
        b=fFsJS+AID0KUHS6m4+9LOjVFNny/Foll8kDTDdpQ76putRRPeByP1dZ9xzOmTQ+2q0
         2lmq52Y/cRUfUOoKYv+4f2f5vDYx0/iCzKcqByj3AXMbJRhf2OEohA3Ob5UnVWf8x/Zp
         WeXkkpc+mu2DKSAXsvk9kRpnhisYFjnXdGBzN1vW7USVm0nPCBV8GiCxn7dC0FnpMplL
         IM2dJoWvTRJBZlDG/ZJoCLTnimfx4XXorgsZKEBQnP5VCqW9WnKOxNLVbol2I4foBgNE
         wnw9EDqDY/her1sKrRz2ZIlQ3aRJG/ifHDQg9FSlqbu2JgeeVVXhiKt2tb10n3beVzZg
         UxKA==
X-Gm-Message-State: AAQBX9c7Bj6fq79dZCyYBOWhQUmAdMjBNlhuUFF5qdZ96WHkwNDfEHWm
        IR4/LbT/RnSvkC2kSVb4lMvuFz7FYwE2JMUizHapYg==
X-Google-Smtp-Source: AKy350ZfNdmlPfF8lU60CpZt+c1A8l8JYiCK+wbuTNEo+ziZ0401COPlwUc9Dz9NjEfqWL7IogrRiw==
X-Received: by 2002:a05:6214:b65:b0:5e8:f869:37fd with SMTP id ey5-20020a0562140b6500b005e8f86937fdmr8460469qvb.8.1681939476580;
        Wed, 19 Apr 2023 14:24:36 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id a29-20020a05620a439d00b0074de75f783fsm2940172qkp.26.2023.04.19.14.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/18] btrfs-progs: sync tree-checker.[ch]
Date:   Wed, 19 Apr 2023 17:24:09 -0400
Message-Id: <90a4fe241636c2170209bf94622c55bebfa9f533.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This syncs tree-checker.c from the kernel.  The main modification was to
add a open ctree flag to skip the deeper leaf checks, and plumbing this
through tree-checker.c.  We need this for things like fsck or
btrfs-image that need to work with slightly corrupted file systems, and
these checks simply make us unable to look at the corrupted blocks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                     |    1 +
 check/main.c                 |    4 +-
 check/mode-lowmem.c          |    1 +
 check/repair.c               |    1 +
 image/main.c                 |   14 +-
 include/kerncompat.h         |   10 +
 kernel-shared/ctree.c        |  180 +--
 kernel-shared/ctree.h        |   14 +-
 kernel-shared/disk-io.c      |    3 +
 kernel-shared/disk-io.h      |    6 +
 kernel-shared/tree-checker.c | 2064 ++++++++++++++++++++++++++++++++++
 kernel-shared/tree-checker.h |   72 ++
 kernel-shared/volumes.c      |   96 +-
 kernel-shared/volumes.h      |    2 -
 14 files changed, 2173 insertions(+), 295 deletions(-)
 create mode 100644 kernel-shared/tree-checker.c
 create mode 100644 kernel-shared/tree-checker.h

diff --git a/Makefile b/Makefile
index 8001f46a..6806d347 100644
--- a/Makefile
+++ b/Makefile
@@ -187,6 +187,7 @@ objects = \
 	kernel-shared/print-tree.o	\
 	kernel-shared/root-tree.o	\
 	kernel-shared/transaction.o	\
+	kernel-shared/tree-checker.o	\
 	kernel-shared/ulist.o	\
 	kernel-shared/uuid-tree.o	\
 	kernel-shared/volumes.o	\
diff --git a/check/main.c b/check/main.c
index f9055f7a..8714c213 100644
--- a/check/main.c
+++ b/check/main.c
@@ -64,6 +64,7 @@
 #include "check/clear-cache.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-lib/bitops.h"
+#include "kernel-shared/tree-checker.h"
 
 /* Global context variables */
 struct btrfs_fs_info *gfs_info;
@@ -9996,7 +9997,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int qgroups_repaired = 0;
 	int qgroup_verify_ret;
 	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE |
-			       OPEN_CTREE_ALLOW_TRANSID_MISMATCH;
+			       OPEN_CTREE_ALLOW_TRANSID_MISMATCH |
+			       OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
 	int force = 0;
 
 	while(1) {
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 7a57f99a..1614c065 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -38,6 +38,7 @@
 #include "check/repair.h"
 #include "check/mode-common.h"
 #include "check/mode-lowmem.h"
+#include "kernel-shared/tree-checker.h"
 
 static u64 last_allocated_chunk;
 static u64 total_used = 0;
diff --git a/check/repair.c b/check/repair.c
index b323ad3e..b73f9518 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/disk-io.h"
 #include "common/extent-cache.h"
 #include "check/repair.h"
+#include "kernel-shared/tree-checker.h"
 
 int opt_check_repair = 0;
 
diff --git a/image/main.c b/image/main.c
index 92b0dbfa..856e313f 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1025,7 +1025,8 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 	int ret;
 	int err = 0;
 
-	root = open_ctree(input, 0, OPEN_CTREE_ALLOW_TRANSID_MISMATCH);
+	root = open_ctree(input, 0, OPEN_CTREE_ALLOW_TRANSID_MISMATCH |
+			  OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS);
 	if (!root) {
 		error("open ctree failed");
 		return -EIO;
@@ -2798,7 +2799,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 
 		ocf.filename = target;
 		ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
-			    OPEN_CTREE_PARTIAL;
+			    OPEN_CTREE_PARTIAL | OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
 		info = open_ctree_fs_info(&ocf);
 		if (!info) {
 			error("open ctree failed");
@@ -2864,7 +2865,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 					  OPEN_CTREE_PARTIAL |
 					  OPEN_CTREE_WRITES |
 					  OPEN_CTREE_NO_DEVICES |
-					  OPEN_CTREE_ALLOW_TRANSID_MISMATCH);
+					  OPEN_CTREE_ALLOW_TRANSID_MISMATCH |
+					  OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS);
 		if (!root) {
 			error("open ctree failed in %s", target);
 			ret = -EIO;
@@ -2883,7 +2885,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 
 		if (!info) {
 			root = open_ctree_fd(fileno(out), target, 0,
-					     OPEN_CTREE_ALLOW_TRANSID_MISMATCH);
+					     OPEN_CTREE_ALLOW_TRANSID_MISMATCH |
+					     OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS);
 			if (!root) {
 				error("open ctree failed in %s", target);
 				ret = -EIO;
@@ -3226,7 +3229,8 @@ int BOX_MAIN(image)(int argc, char *argv[])
 		int i;
 
 		ocf.filename = target;
-		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_RESTORE;
+		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_RESTORE |
+			OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
 		info = open_ctree_fs_info(&ocf);
 		if (!info) {
 			error("open ctree failed at %s", target);
diff --git a/include/kerncompat.h b/include/kerncompat.h
index 28e9f443..7472ff75 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -86,6 +86,7 @@
 #define _RET_IP_ 0
 #define TASK_UNINTERRUPTIBLE 0
 #define SLAB_MEM_SPREAD 0
+#define ALLOW_ERROR_INJECTION(a, b)
 
 #ifndef ULONG_MAX
 #define ULONG_MAX       (~0UL)
@@ -418,6 +419,15 @@ do {					\
 	__ret_warn_on;					\
 })
 
+#define WARN(c, msg...) ({				\
+	int __ret_warn_on = !!(c);			\
+	if (__ret_warn_on)				\
+		printf(msg);				\
+	__ret_warn_on;					\
+})
+
+#define IS_ENABLED(c) 0
+
 #define container_of(ptr, type, member) ({                      \
         const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
 	        (type *)( (char *)__mptr - offsetof(type,member) );})
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 66f44879..d5a1f90b 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -28,6 +28,7 @@
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/volumes.h"
 #include "check/repair.h"
+#include "tree-checker.h"
 
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
@@ -602,185 +603,6 @@ static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 	return btrfs_item_offset(leaf, nr - 1);
 }
 
-static void generic_err(const struct extent_buffer *buf, int slot,
-			const char *fmt, ...)
-{
-	va_list args;
-
-	fprintf(stderr, "corrupt %s: root=%lld block=%llu slot=%d, ",
-		btrfs_header_level(buf) == 0 ? "leaf": "node",
-		btrfs_header_owner(buf), btrfs_header_bytenr(buf), slot);
-	va_start(args, fmt);
-	vfprintf(stderr, fmt, args);
-	va_end(args);
-	fprintf(stderr, "\n");
-}
-
-enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
-{
-	struct btrfs_fs_info *fs_info = node->fs_info;
-	unsigned long nr = btrfs_header_nritems(node);
-	struct btrfs_key key, next_key;
-	int slot;
-	int level = btrfs_header_level(node);
-	u64 bytenr;
-	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
-
-	if (level <= 0 || level >= BTRFS_MAX_LEVEL) {
-		generic_err(node, 0,
-			"invalid level for node, have %d expect [1, %d]",
-			level, BTRFS_MAX_LEVEL - 1);
-		ret = BTRFS_TREE_BLOCK_INVALID_LEVEL;
-		goto fail;
-	}
-	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info)) {
-		generic_err(node, 0,
-"corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%u]",
-			   btrfs_header_owner(node), node->start,
-			   nr == 0 ? "small" : "large", nr,
-			   BTRFS_NODEPTRS_PER_BLOCK(fs_info));
-		ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
-		goto fail;
-	}
-
-	for (slot = 0; slot < nr - 1; slot++) {
-		bytenr = btrfs_node_blockptr(node, slot);
-		btrfs_node_key_to_cpu(node, &key, slot);
-		btrfs_node_key_to_cpu(node, &next_key, slot + 1);
-
-		if (!bytenr) {
-			generic_err(node, slot,
-				"invalid NULL node pointer");
-			ret = BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
-			goto fail;
-		}
-		if (!IS_ALIGNED(bytenr, fs_info->sectorsize)) {
-			generic_err(node, slot,
-			"unaligned pointer, have %llu should be aligned to %u",
-				bytenr, fs_info->sectorsize);
-			ret = BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
-			goto fail;
-		}
-
-		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
-			generic_err(node, slot,
-	"bad key order, current (%llu %u %llu) next (%llu %u %llu)",
-				key.objectid, key.type, key.offset,
-				next_key.objectid, next_key.type,
-				next_key.offset);
-			ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
-			goto fail;
-		}
-	}
-	ret = BTRFS_TREE_BLOCK_CLEAN;
-fail:
-	return ret;
-}
-
-enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
-{
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	/* No valid key type is 0, so all key should be larger than this key */
-	struct btrfs_key prev_key = {0, 0, 0};
-	struct btrfs_key key;
-	u32 nritems = btrfs_header_nritems(leaf);
-	int slot;
-	int ret;
-
-	if (btrfs_header_level(leaf) != 0) {
-		generic_err(leaf, 0,
-			"invalid level for leaf, have %d expect 0",
-			btrfs_header_level(leaf));
-		ret = BTRFS_TREE_BLOCK_INVALID_LEVEL;
-		goto fail;
-	}
-
-	if (nritems == 0)
-		return 0;
-
-	/*
-	 * Check the following things to make sure this is a good leaf, and
-	 * leaf users won't need to bother with similar sanity checks:
-	 *
-	 * 1) key ordering
-	 * 2) item offset and size
-	 *    No overlap, no hole, all inside the leaf.
-	 * 3) item content
-	 *    If possible, do comprehensive sanity check.
-	 *    NOTE: All checks must only rely on the item data itself.
-	 */
-	for (slot = 0; slot < nritems; slot++) {
-		u32 item_end_expected;
-		u64 item_data_end;
-
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-
-		/* Make sure the keys are in the right order */
-		if (btrfs_comp_cpu_keys(&prev_key, &key) >= 0) {
-			generic_err(leaf, slot,
-	"bad key order, prev (%llu %u %llu) current (%llu %u %llu)",
-				prev_key.objectid, prev_key.type,
-				prev_key.offset, key.objectid, key.type,
-				key.offset);
-			ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
-			goto fail;
-		}
-
-		item_data_end = (u64)btrfs_item_offset(leaf, slot) +
-				btrfs_item_size(leaf, slot);
-		/*
-		 * Make sure the offset and ends are right, remember that the
-		 * item data starts at the end of the leaf and grows towards the
-		 * front.
-		 */
-		if (slot == 0)
-			item_end_expected = BTRFS_LEAF_DATA_SIZE(fs_info);
-		else
-			item_end_expected = btrfs_item_offset(leaf,
-								 slot - 1);
-		if (item_data_end != item_end_expected) {
-			generic_err(leaf, slot,
-				"unexpected item end, have %llu expect %u",
-				item_data_end, item_end_expected);
-			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
-			goto fail;
-		}
-
-		/*
-		 * Check to make sure that we don't point outside of the leaf,
-		 * just in case all the items are consistent to each other, but
-		 * all point outside of the leaf.
-		 */
-		if (item_data_end > BTRFS_LEAF_DATA_SIZE(fs_info)) {
-			generic_err(leaf, slot,
-			"slot end outside of leaf, have %llu expect range [0, %u]",
-				item_data_end, BTRFS_LEAF_DATA_SIZE(fs_info));
-			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
-			goto fail;
-		}
-
-		/* Also check if the item pointer overlaps with btrfs item. */
-		if (btrfs_item_ptr_offset(leaf, slot) <
-		    btrfs_item_nr_offset(leaf, slot) + sizeof(struct btrfs_item)) {
-			generic_err(leaf, slot,
-		"slot overlaps with its data, item end %lu data start %lu",
-				btrfs_item_nr_offset(leaf, slot) +
-				sizeof(struct btrfs_item),
-				btrfs_item_ptr_offset(leaf, slot));
-			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
-			goto fail;
-		}
-
-		prev_key.objectid = key.objectid;
-		prev_key.type = key.type;
-		prev_key.offset = key.offset;
-	}
-
-	ret = BTRFS_TREE_BLOCK_CLEAN;
-fail:
-	return ret;
-}
-
 static int noinline check_block(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, int level)
 {
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 237f530d..5eba9c14 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -185,17 +185,6 @@ struct btrfs_path {
 					sizeof(struct btrfs_item))
 #define BTRFS_MAX_EXTENT_SIZE		128UL * 1024 * 1024
 
-enum btrfs_tree_block_status {
-	BTRFS_TREE_BLOCK_CLEAN,
-	BTRFS_TREE_BLOCK_INVALID_NRITEMS,
-	BTRFS_TREE_BLOCK_INVALID_PARENT_KEY,
-	BTRFS_TREE_BLOCK_BAD_KEY_ORDER,
-	BTRFS_TREE_BLOCK_INVALID_LEVEL,
-	BTRFS_TREE_BLOCK_INVALID_FREE_SPACE,
-	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
-	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
-};
-
 /*
  * We don't want to overwrite 1M at the beginning of device, even though
  * there is our 1st superblock at 64k. Some possible reasons:
@@ -373,6 +362,7 @@ struct btrfs_fs_info {
 	unsigned int finalize_on_close:1;
 	unsigned int hide_names:1;
 	unsigned int allow_transid_mismatch:1;
+	unsigned int skip_leaf_item_checks:1;
 
 	int transaction_aborted;
 	int force_csum_type;
@@ -958,8 +948,6 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
-enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *buf);
-enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *buf);
 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
 				   struct extent_buffer *parent, int slot);
 int btrfs_previous_item(struct btrfs_root *root,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4950c685..536b7119 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -37,6 +37,7 @@
 #include "common/device-scan.h"
 #include "common/device-utils.h"
 #include "crypto/hash.h"
+#include "tree-checker.h"
 
 /* specified errno for check_tree_block */
 #define BTRFS_BAD_BYTENR		(-1)
@@ -1503,6 +1504,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 		fs_info->hide_names = 1;
 	if (flags & OPEN_CTREE_ALLOW_TRANSID_MISMATCH)
 		fs_info->allow_transid_mismatch = 1;
+	if (flags & OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS)
+		fs_info->skip_leaf_item_checks = 1;
 
 	if ((flags & OPEN_CTREE_RECOVER_SUPER)
 	     && (flags & OPEN_CTREE_TEMPORARY_SUPER)) {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 4c63a4a8..6baa4a80 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -98,6 +98,12 @@ enum btrfs_open_ctree_flags {
 	 * stored in the csum tree during conversion.
 	 */
 	OPEN_CTREE_SKIP_CSUM_CHECK	= (1U << 16),
+
+	/*
+	 * Allow certain commands like check/restore to ignore more structure
+	 * specific checks and only do the superficial checks.
+	 */
+	OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS	= (1U << 17),
 };
 
 /*
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
new file mode 100644
index 00000000..4f38942a
--- /dev/null
+++ b/kernel-shared/tree-checker.c
@@ -0,0 +1,2064 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Qu Wenruo 2017.  All rights reserved.
+ */
+
+/*
+ * The module is used to catch unexpected/corrupted tree block data.
+ * Such behavior can be caused either by a fuzzed image or bugs.
+ *
+ * The objective is to do leaf/node validation checks when tree block is read
+ * from disk, and check *every* possible member, so other code won't
+ * need to checking them again.
+ *
+ * Due to the potential and unwanted damage, every checker needs to be
+ * carefully reviewed otherwise so it does not prevent mount of valid images.
+ */
+
+#include "kerncompat.h"
+#include "kernel-lib/overflow.h"
+#include "kernel-lib/bitops.h"
+#include "common/internal.h"
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/limits.h>
+#include "messages.h"
+#include "ctree.h"
+#include "tree-checker.h"
+#include "disk-io.h"
+#include "compression.h"
+#include "volumes.h"
+#include "misc.h"
+#include "accessors.h"
+#include "file-item.h"
+
+/*
+ * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in two
+ * separate u32s. These two functions convert between the two representations.
+ *
+ * MODIFIED:
+ *  - Declared these here since this is the only place they're used currently.
+ */
+static inline u64 btrfs_inode_combine_flags(u32 flags, u32 ro_flags)
+{
+	return (flags | ((u64)ro_flags << 32));
+}
+
+static inline void btrfs_inode_split_flags(u64 inode_item_flags,
+					   u32 *flags, u32 *ro_flags)
+{
+	*flags = (u32)inode_item_flags;
+	*ro_flags = (u32)(inode_item_flags >> 32);
+}
+
+/*
+ * Error message should follow the following format:
+ * corrupt <type>: <identifier>, <reason>[, <bad_value>]
+ *
+ * @type:	leaf or node
+ * @identifier:	the necessary info to locate the leaf/node.
+ * 		It's recommended to decode key.objecitd/offset if it's
+ * 		meaningful.
+ * @reason:	describe the error
+ * @bad_value:	optional, it's recommended to output bad value and its
+ *		expected value (range).
+ *
+ * Since comma is used to separate the components, only space is allowed
+ * inside each component.
+ */
+
+/*
+ * Append generic "corrupt leaf/node root=%llu block=%llu slot=%d: " to @fmt.
+ * Allows callers to customize the output.
+ */
+__printf(3, 4)
+__cold
+static void generic_err(const struct extent_buffer *eb, int slot,
+			const char *fmt, ...)
+{
+	const struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+		"corrupt %s: root=%llu block=%llu slot=%d, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot, &vaf);
+	va_end(args);
+}
+
+/*
+ * Customized reporter for extent data item, since its key objectid and
+ * offset has its own meaning.
+ */
+__printf(3, 4)
+__cold
+static void file_extent_err(const struct extent_buffer *eb, int slot,
+			    const char *fmt, ...)
+{
+	const struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+	"corrupt %s: root=%llu block=%llu slot=%d ino=%llu file_offset=%llu, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+		key.objectid, key.offset, &vaf);
+	va_end(args);
+}
+
+/*
+ * Return 0 if the btrfs_file_extent_##name is aligned to @alignment
+ * Else return 1
+ */
+#define CHECK_FE_ALIGNED(leaf, slot, fi, name, alignment)		      \
+({									      \
+	if (unlikely(!IS_ALIGNED(btrfs_file_extent_##name((leaf), (fi)),      \
+				 (alignment))))				      \
+		file_extent_err((leaf), (slot),				      \
+	"invalid %s for file extent, have %llu, should be aligned to %u",     \
+			(#name), btrfs_file_extent_##name((leaf), (fi)),      \
+			(alignment));					      \
+	(!IS_ALIGNED(btrfs_file_extent_##name((leaf), (fi)), (alignment)));   \
+})
+
+static u64 file_extent_end(struct extent_buffer *leaf,
+			   struct btrfs_key *key,
+			   struct btrfs_file_extent_item *extent)
+{
+	u64 end;
+	u64 len;
+
+	if (btrfs_file_extent_type(leaf, extent) == BTRFS_FILE_EXTENT_INLINE) {
+		len = btrfs_file_extent_ram_bytes(leaf, extent);
+		end = ALIGN(key->offset + len, leaf->fs_info->sectorsize);
+	} else {
+		len = btrfs_file_extent_num_bytes(leaf, extent);
+		end = key->offset + len;
+	}
+	return end;
+}
+
+/*
+ * Customized report for dir_item, the only new important information is
+ * key->objectid, which represents inode number
+ */
+__printf(3, 4)
+__cold
+static void dir_item_err(const struct extent_buffer *eb, int slot,
+			 const char *fmt, ...)
+{
+	const struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+		"corrupt %s: root=%llu block=%llu slot=%d ino=%llu, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+		key.objectid, &vaf);
+	va_end(args);
+}
+
+/*
+ * This functions checks prev_key->objectid, to ensure current key and prev_key
+ * share the same objectid as inode number.
+ *
+ * This is to detect missing INODE_ITEM in subvolume trees.
+ *
+ * Return true if everything is OK or we don't need to check.
+ * Return false if anything is wrong.
+ */
+static bool check_prev_ino(struct extent_buffer *leaf,
+			   struct btrfs_key *key, int slot,
+			   struct btrfs_key *prev_key)
+{
+	/* No prev key, skip check */
+	if (slot == 0)
+		return true;
+
+	/* Only these key->types needs to be checked */
+	ASSERT(key->type == BTRFS_XATTR_ITEM_KEY ||
+	       key->type == BTRFS_INODE_REF_KEY ||
+	       key->type == BTRFS_DIR_INDEX_KEY ||
+	       key->type == BTRFS_DIR_ITEM_KEY ||
+	       key->type == BTRFS_EXTENT_DATA_KEY);
+
+	/*
+	 * Only subvolume trees along with their reloc trees need this check.
+	 * Things like log tree doesn't follow this ino requirement.
+	 */
+	if (!is_fstree(btrfs_header_owner(leaf)))
+		return true;
+
+	if (key->objectid == prev_key->objectid)
+		return true;
+
+	/* Error found */
+	dir_item_err(leaf, slot,
+		"invalid previous key objectid, have %llu expect %llu",
+		prev_key->objectid, key->objectid);
+	return false;
+}
+static int check_extent_data_item(struct extent_buffer *leaf,
+				  struct btrfs_key *key, int slot,
+				  struct btrfs_key *prev_key)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_file_extent_item *fi;
+	u32 sectorsize = fs_info->sectorsize;
+	u32 item_size = btrfs_item_size(leaf, slot);
+	u64 extent_end;
+
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+		file_extent_err(leaf, slot,
+"unaligned file_offset for file extent, have %llu should be aligned to %u",
+			key->offset, sectorsize);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * Previous key must have the same key->objectid (ino).
+	 * It can be XATTR_ITEM, INODE_ITEM or just another EXTENT_DATA.
+	 * But if objectids mismatch, it means we have a missing
+	 * INODE_ITEM.
+	 */
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
+		return -EUCLEAN;
+
+	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+
+	/*
+	 * Make sure the item contains at least inline header, so the file
+	 * extent type is not some garbage.
+	 */
+	if (unlikely(item_size < BTRFS_FILE_EXTENT_INLINE_DATA_START)) {
+		file_extent_err(leaf, slot,
+				"invalid item size, have %u expect [%zu, %u)",
+				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START,
+				SZ_4K);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_file_extent_type(leaf, fi) >=
+		     BTRFS_NR_FILE_EXTENT_TYPES)) {
+		file_extent_err(leaf, slot,
+		"invalid type for file extent, have %u expect range [0, %u]",
+			btrfs_file_extent_type(leaf, fi),
+			BTRFS_NR_FILE_EXTENT_TYPES - 1);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * Support for new compression/encryption must introduce incompat flag,
+	 * and must be caught in open_ctree().
+	 */
+	if (unlikely(btrfs_file_extent_compression(leaf, fi) >=
+		     BTRFS_NR_COMPRESS_TYPES)) {
+		file_extent_err(leaf, slot,
+	"invalid compression for file extent, have %u expect range [0, %u]",
+			btrfs_file_extent_compression(leaf, fi),
+			BTRFS_NR_COMPRESS_TYPES - 1);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+		file_extent_err(leaf, slot,
+			"invalid encryption for file extent, have %u expect 0",
+			btrfs_file_extent_encryption(leaf, fi));
+		return -EUCLEAN;
+	}
+	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
+		/* Inline extent must have 0 as key offset */
+		if (unlikely(key->offset)) {
+			file_extent_err(leaf, slot,
+		"invalid file_offset for inline file extent, have %llu expect 0",
+				key->offset);
+			return -EUCLEAN;
+		}
+
+		/* Compressed inline extent has no on-disk size, skip it */
+		if (btrfs_file_extent_compression(leaf, fi) !=
+		    BTRFS_COMPRESS_NONE)
+			return 0;
+
+		/* Uncompressed inline extent size must match item size */
+		if (unlikely(item_size != BTRFS_FILE_EXTENT_INLINE_DATA_START +
+					  btrfs_file_extent_ram_bytes(leaf, fi))) {
+			file_extent_err(leaf, slot,
+	"invalid ram_bytes for uncompressed inline extent, have %u expect %llu",
+				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START +
+				btrfs_file_extent_ram_bytes(leaf, fi));
+			return -EUCLEAN;
+		}
+		return 0;
+	}
+
+	/* Regular or preallocated extent has fixed item size */
+	if (unlikely(item_size != sizeof(*fi))) {
+		file_extent_err(leaf, slot,
+	"invalid item size for reg/prealloc file extent, have %u expect %zu",
+			item_size, sizeof(*fi));
+		return -EUCLEAN;
+	}
+	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize)))
+		return -EUCLEAN;
+
+	/* Catch extent end overflow */
+	if (unlikely(check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
+					key->offset, &extent_end))) {
+		file_extent_err(leaf, slot,
+	"extent end overflow, have file offset %llu extent num bytes %llu",
+				key->offset,
+				btrfs_file_extent_num_bytes(leaf, fi));
+		return -EUCLEAN;
+	}
+
+	/*
+	 * Check that no two consecutive file extent items, in the same leaf,
+	 * present ranges that overlap each other.
+	 */
+	if (slot > 0 &&
+	    prev_key->objectid == key->objectid &&
+	    prev_key->type == BTRFS_EXTENT_DATA_KEY) {
+		struct btrfs_file_extent_item *prev_fi;
+		u64 prev_end;
+
+		prev_fi = btrfs_item_ptr(leaf, slot - 1,
+					 struct btrfs_file_extent_item);
+		prev_end = file_extent_end(leaf, prev_key, prev_fi);
+		if (unlikely(prev_end > key->offset)) {
+			file_extent_err(leaf, slot - 1,
+"file extent end range (%llu) goes beyond start offset (%llu) of the next file extent",
+					prev_end, key->offset);
+			return -EUCLEAN;
+		}
+	}
+
+	return 0;
+}
+
+static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
+			   int slot, struct btrfs_key *prev_key)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	u32 sectorsize = fs_info->sectorsize;
+	const u32 csumsize = fs_info->csum_size;
+
+	if (unlikely(key->objectid != BTRFS_EXTENT_CSUM_OBJECTID)) {
+		generic_err(leaf, slot,
+		"invalid key objectid for csum item, have %llu expect %llu",
+			key->objectid, BTRFS_EXTENT_CSUM_OBJECTID);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+		generic_err(leaf, slot,
+	"unaligned key offset for csum item, have %llu should be aligned to %u",
+			key->offset, sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_item_size(leaf, slot), csumsize))) {
+		generic_err(leaf, slot,
+	"unaligned item size for csum item, have %u should be aligned to %u",
+			btrfs_item_size(leaf, slot), csumsize);
+		return -EUCLEAN;
+	}
+	if (slot > 0 && prev_key->type == BTRFS_EXTENT_CSUM_KEY) {
+		u64 prev_csum_end;
+		u32 prev_item_size;
+
+		prev_item_size = btrfs_item_size(leaf, slot - 1);
+		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
+		prev_csum_end += prev_key->offset;
+		if (unlikely(prev_csum_end > key->offset)) {
+			generic_err(leaf, slot - 1,
+"csum end range (%llu) goes beyond the start range (%llu) of the next csum item",
+				    prev_csum_end, key->offset);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
+/* Inode item error output has the same format as dir_item_err() */
+#define inode_item_err(eb, slot, fmt, ...)			\
+	dir_item_err(eb, slot, fmt, __VA_ARGS__)
+
+static int check_inode_key(struct extent_buffer *leaf, struct btrfs_key *key,
+			   int slot)
+{
+	struct btrfs_key item_key;
+	bool is_inode_item;
+
+	btrfs_item_key_to_cpu(leaf, &item_key, slot);
+	is_inode_item = (item_key.type == BTRFS_INODE_ITEM_KEY);
+
+	/* For XATTR_ITEM, location key should be all 0 */
+	if (item_key.type == BTRFS_XATTR_ITEM_KEY) {
+		if (unlikely(key->objectid != 0 || key->type != 0 ||
+			     key->offset != 0))
+			return -EUCLEAN;
+		return 0;
+	}
+
+	if (unlikely((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
+		      key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
+		     key->objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
+		     key->objectid != BTRFS_FREE_INO_OBJECTID)) {
+		if (is_inode_item) {
+			generic_err(leaf, slot,
+	"invalid key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
+				key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
+				BTRFS_FIRST_FREE_OBJECTID,
+				BTRFS_LAST_FREE_OBJECTID,
+				BTRFS_FREE_INO_OBJECTID);
+		} else {
+			dir_item_err(leaf, slot,
+"invalid location key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
+				key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
+				BTRFS_FIRST_FREE_OBJECTID,
+				BTRFS_LAST_FREE_OBJECTID,
+				BTRFS_FREE_INO_OBJECTID);
+		}
+		return -EUCLEAN;
+	}
+	if (unlikely(key->offset != 0)) {
+		if (is_inode_item)
+			inode_item_err(leaf, slot,
+				       "invalid key offset: has %llu expect 0",
+				       key->offset);
+		else
+			dir_item_err(leaf, slot,
+				"invalid location key offset:has %llu expect 0",
+				key->offset);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
+			  int slot)
+{
+	struct btrfs_key item_key;
+	bool is_root_item;
+
+	btrfs_item_key_to_cpu(leaf, &item_key, slot);
+	is_root_item = (item_key.type == BTRFS_ROOT_ITEM_KEY);
+
+	/* No such tree id */
+	if (unlikely(key->objectid == 0)) {
+		if (is_root_item)
+			generic_err(leaf, slot, "invalid root id 0");
+		else
+			dir_item_err(leaf, slot,
+				     "invalid location key root id 0");
+		return -EUCLEAN;
+	}
+
+	/* DIR_ITEM/INDEX/INODE_REF is not allowed to point to non-fs trees */
+	if (unlikely(!is_fstree(key->objectid) && !is_root_item)) {
+		dir_item_err(leaf, slot,
+		"invalid location key objectid, have %llu expect [%llu, %llu]",
+				key->objectid, BTRFS_FIRST_FREE_OBJECTID,
+				BTRFS_LAST_FREE_OBJECTID);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * ROOT_ITEM with non-zero offset means this is a snapshot, created at
+	 * @offset transid.
+	 * Furthermore, for location key in DIR_ITEM, its offset is always -1.
+	 *
+	 * So here we only check offset for reloc tree whose key->offset must
+	 * be a valid tree.
+	 */
+	if (unlikely(key->objectid == BTRFS_TREE_RELOC_OBJECTID &&
+		     key->offset == 0)) {
+		generic_err(leaf, slot, "invalid root id 0 for reloc tree");
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+static int check_dir_item(struct extent_buffer *leaf,
+			  struct btrfs_key *key, struct btrfs_key *prev_key,
+			  int slot)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_dir_item *di;
+	u32 item_size = btrfs_item_size(leaf, slot);
+	u32 cur = 0;
+
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
+		return -EUCLEAN;
+
+	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
+	while (cur < item_size) {
+		struct btrfs_key location_key;
+		u32 name_len;
+		u32 data_len;
+		u32 max_name_len;
+		u32 total_size;
+		u32 name_hash;
+		u8 dir_type;
+		int ret;
+
+		/* header itself should not cross item boundary */
+		if (unlikely(cur + sizeof(*di) > item_size)) {
+			dir_item_err(leaf, slot,
+		"dir item header crosses item boundary, have %zu boundary %u",
+				cur + sizeof(*di), item_size);
+			return -EUCLEAN;
+		}
+
+		/* Location key check */
+		btrfs_dir_item_key_to_cpu(leaf, di, &location_key);
+		if (location_key.type == BTRFS_ROOT_ITEM_KEY) {
+			ret = check_root_key(leaf, &location_key, slot);
+			if (unlikely(ret < 0))
+				return ret;
+		} else if (location_key.type == BTRFS_INODE_ITEM_KEY ||
+			   location_key.type == 0) {
+			ret = check_inode_key(leaf, &location_key, slot);
+			if (unlikely(ret < 0))
+				return ret;
+		} else {
+			dir_item_err(leaf, slot,
+			"invalid location key type, have %u, expect %u or %u",
+				     location_key.type, BTRFS_ROOT_ITEM_KEY,
+				     BTRFS_INODE_ITEM_KEY);
+			return -EUCLEAN;
+		}
+
+		/* dir type check */
+		dir_type = btrfs_dir_ftype(leaf, di);
+		if (unlikely(dir_type >= BTRFS_FT_MAX)) {
+			dir_item_err(leaf, slot,
+			"invalid dir item type, have %u expect [0, %u)",
+				dir_type, BTRFS_FT_MAX);
+			return -EUCLEAN;
+		}
+
+		if (unlikely(key->type == BTRFS_XATTR_ITEM_KEY &&
+			     dir_type != BTRFS_FT_XATTR)) {
+			dir_item_err(leaf, slot,
+		"invalid dir item type for XATTR key, have %u expect %u",
+				dir_type, BTRFS_FT_XATTR);
+			return -EUCLEAN;
+		}
+		if (unlikely(dir_type == BTRFS_FT_XATTR &&
+			     key->type != BTRFS_XATTR_ITEM_KEY)) {
+			dir_item_err(leaf, slot,
+			"xattr dir type found for non-XATTR key");
+			return -EUCLEAN;
+		}
+		if (dir_type == BTRFS_FT_XATTR)
+			max_name_len = XATTR_NAME_MAX;
+		else
+			max_name_len = BTRFS_NAME_LEN;
+
+		/* Name/data length check */
+		name_len = btrfs_dir_name_len(leaf, di);
+		data_len = btrfs_dir_data_len(leaf, di);
+		if (unlikely(name_len > max_name_len)) {
+			dir_item_err(leaf, slot,
+			"dir item name len too long, have %u max %u",
+				name_len, max_name_len);
+			return -EUCLEAN;
+		}
+		if (unlikely(name_len + data_len > BTRFS_MAX_XATTR_SIZE(fs_info))) {
+			dir_item_err(leaf, slot,
+			"dir item name and data len too long, have %u max %u",
+				name_len + data_len,
+				BTRFS_MAX_XATTR_SIZE(fs_info));
+			return -EUCLEAN;
+		}
+
+		if (unlikely(data_len && dir_type != BTRFS_FT_XATTR)) {
+			dir_item_err(leaf, slot,
+			"dir item with invalid data len, have %u expect 0",
+				data_len);
+			return -EUCLEAN;
+		}
+
+		total_size = sizeof(*di) + name_len + data_len;
+
+		/* header and name/data should not cross item boundary */
+		if (unlikely(cur + total_size > item_size)) {
+			dir_item_err(leaf, slot,
+		"dir item data crosses item boundary, have %u boundary %u",
+				cur + total_size, item_size);
+			return -EUCLEAN;
+		}
+
+		/*
+		 * Special check for XATTR/DIR_ITEM, as key->offset is name
+		 * hash, should match its name
+		 */
+		if (key->type == BTRFS_DIR_ITEM_KEY ||
+		    key->type == BTRFS_XATTR_ITEM_KEY) {
+			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+
+			read_extent_buffer(leaf, namebuf,
+					(unsigned long)(di + 1), name_len);
+			name_hash = btrfs_name_hash(namebuf, name_len);
+			if (unlikely(key->offset != name_hash)) {
+				dir_item_err(leaf, slot,
+		"name hash mismatch with key, have 0x%016x expect 0x%016llx",
+					name_hash, key->offset);
+				return -EUCLEAN;
+			}
+		}
+		cur += total_size;
+		di = (struct btrfs_dir_item *)((void *)di + total_size);
+	}
+	return 0;
+}
+
+__printf(3, 4)
+__cold
+static void block_group_err(const struct extent_buffer *eb, int slot,
+			    const char *fmt, ...)
+{
+	const struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+	"corrupt %s: root=%llu block=%llu slot=%d bg_start=%llu bg_len=%llu, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+		key.objectid, key.offset, &vaf);
+	va_end(args);
+}
+
+static int check_block_group_item(struct extent_buffer *leaf,
+				  struct btrfs_key *key, int slot)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_block_group_item bgi;
+	u32 item_size = btrfs_item_size(leaf, slot);
+	u64 chunk_objectid;
+	u64 flags;
+	u64 type;
+
+	/*
+	 * Here we don't really care about alignment since extent allocator can
+	 * handle it.  We care more about the size.
+	 */
+	if (unlikely(key->offset == 0)) {
+		block_group_err(leaf, slot,
+				"invalid block group size 0");
+		return -EUCLEAN;
+	}
+
+	if (unlikely(item_size != sizeof(bgi))) {
+		block_group_err(leaf, slot,
+			"invalid item size, have %u expect %zu",
+				item_size, sizeof(bgi));
+		return -EUCLEAN;
+	}
+
+	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(bgi));
+	chunk_objectid = btrfs_stack_block_group_chunk_objectid(&bgi);
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		/*
+		 * We don't init the nr_global_roots until we load the global
+		 * roots, so this could be 0 at mount time.  If it's 0 we'll
+		 * just assume we're fine, and later we'll check against our
+		 * actual value.
+		 */
+		if (unlikely(fs_info->nr_global_roots &&
+			     chunk_objectid >= fs_info->nr_global_roots)) {
+			block_group_err(leaf, slot,
+	"invalid block group global root id, have %llu, needs to be <= %llu",
+					chunk_objectid,
+					fs_info->nr_global_roots);
+			return -EUCLEAN;
+		}
+	} else if (unlikely(chunk_objectid != BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
+		block_group_err(leaf, slot,
+		"invalid block group chunk objectid, have %llu expect %llu",
+				btrfs_stack_block_group_chunk_objectid(&bgi),
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+
+	if (unlikely(btrfs_stack_block_group_used(&bgi) > key->offset)) {
+		block_group_err(leaf, slot,
+			"invalid block group used, have %llu expect [0, %llu)",
+				btrfs_stack_block_group_used(&bgi), key->offset);
+		return -EUCLEAN;
+	}
+
+	flags = btrfs_stack_block_group_flags(&bgi);
+	if (unlikely(hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) > 1)) {
+		block_group_err(leaf, slot,
+"invalid profile flags, have 0x%llx (%lu bits set) expect no more than 1 bit set",
+			flags & BTRFS_BLOCK_GROUP_PROFILE_MASK,
+			hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK));
+		return -EUCLEAN;
+	}
+
+	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
+	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
+		     type != BTRFS_BLOCK_GROUP_METADATA &&
+		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
+		     type != (BTRFS_BLOCK_GROUP_METADATA |
+			      BTRFS_BLOCK_GROUP_DATA))) {
+		block_group_err(leaf, slot,
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
+			type, hweight64(type),
+			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
+			BTRFS_BLOCK_GROUP_SYSTEM,
+			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+__printf(4, 5)
+__cold
+static void chunk_err(const struct extent_buffer *leaf,
+		      const struct btrfs_chunk *chunk, u64 logical,
+		      const char *fmt, ...)
+{
+	const struct btrfs_fs_info *fs_info = leaf->fs_info;
+	bool is_sb;
+	struct va_format vaf;
+	va_list args;
+	int i;
+	int slot = -1;
+
+	/* Only superblock eb is able to have such small offset */
+	is_sb = (leaf->start == BTRFS_SUPER_INFO_OFFSET);
+
+	if (!is_sb) {
+		/*
+		 * Get the slot number by iterating through all slots, this
+		 * would provide better readability.
+		 */
+		for (i = 0; i < btrfs_header_nritems(leaf); i++) {
+			if (btrfs_item_ptr_offset(leaf, i) ==
+					(unsigned long)chunk) {
+				slot = i;
+				break;
+			}
+		}
+	}
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (is_sb)
+		btrfs_crit(fs_info,
+		"corrupt superblock syschunk array: chunk_start=%llu, %pV",
+			   logical, &vaf);
+	else
+		btrfs_crit(fs_info,
+	"corrupt leaf: root=%llu block=%llu slot=%d chunk_start=%llu, %pV",
+			   BTRFS_CHUNK_TREE_OBJECTID, leaf->start, slot,
+			   logical, &vaf);
+	va_end(args);
+}
+
+/*
+ * The common chunk check which could also work on super block sys chunk array.
+ *
+ * Return -EUCLEAN if anything is corrupted.
+ * Return 0 if everything is OK.
+ */
+int btrfs_check_chunk_valid(struct extent_buffer *leaf,
+			    struct btrfs_chunk *chunk, u64 logical)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	u64 length;
+	u64 chunk_end;
+	u64 stripe_len;
+	u16 num_stripes;
+	u16 sub_stripes;
+	u64 type;
+	u64 features;
+	bool mixed = false;
+	int raid_index;
+	int nparity;
+	int ncopies;
+
+	length = btrfs_chunk_length(leaf, chunk);
+	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
+	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
+	type = btrfs_chunk_type(leaf, chunk);
+	raid_index = btrfs_bg_flags_to_raid_index(type);
+	ncopies = btrfs_raid_array[raid_index].ncopies;
+	nparity = btrfs_raid_array[raid_index].nparity;
+
+	if (unlikely(!num_stripes)) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk num_stripes, have %u", num_stripes);
+		return -EUCLEAN;
+	}
+	if (unlikely(num_stripes < ncopies)) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk num_stripes < ncopies, have %u < %d",
+			  num_stripes, ncopies);
+		return -EUCLEAN;
+	}
+	if (unlikely(nparity && num_stripes == nparity)) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk num_stripes == nparity, have %u == %d",
+			  num_stripes, nparity);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(logical, fs_info->sectorsize))) {
+		chunk_err(leaf, chunk, logical,
+		"invalid chunk logical, have %llu should aligned to %u",
+			  logical, fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->sectorsize)) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk sectorsize, have %u expect %u",
+			  btrfs_chunk_sector_size(leaf, chunk),
+			  fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!length || !IS_ALIGNED(length, fs_info->sectorsize))) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk length, have %llu", length);
+		return -EUCLEAN;
+	}
+	if (unlikely(check_add_overflow(logical, length, &chunk_end))) {
+		chunk_err(leaf, chunk, logical,
+"invalid chunk logical start and length, have logical start %llu length %llu",
+			  logical, length);
+		return -EUCLEAN;
+	}
+	if (unlikely(!is_power_of_2(stripe_len) || stripe_len != BTRFS_STRIPE_LEN)) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk stripe length: %llu",
+			  stripe_len);
+		return -EUCLEAN;
+	}
+	/*
+	 * We artificially limit the chunk size, so that the number of stripes
+	 * inside a chunk can be fit into a U32.  The current limit (256G) is
+	 * way too large for real world usage anyway, and it's also much larger
+	 * than our existing limit (10G).
+	 *
+	 * Thus it should be a good way to catch obvious bitflips.
+	 */
+	if (unlikely(length >= ((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT))) {
+		chunk_err(leaf, chunk, logical,
+			  "chunk length too large: have %llu limit %llu",
+			  length, (u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT);
+		return -EUCLEAN;
+	}
+	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
+			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
+		chunk_err(leaf, chunk, logical,
+			  "unrecognized chunk type: 0x%llx",
+			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
+			    BTRFS_BLOCK_GROUP_PROFILE_MASK) &
+			  btrfs_chunk_type(leaf, chunk));
+		return -EUCLEAN;
+	}
+
+	if (unlikely(!has_single_bit_set(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
+		     (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0)) {
+		chunk_err(leaf, chunk, logical,
+		"invalid chunk profile flag: 0x%llx, expect 0 or 1 bit set",
+			  type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		return -EUCLEAN;
+	}
+	if (unlikely((type & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)) {
+		chunk_err(leaf, chunk, logical,
+	"missing chunk type flag, have 0x%llx one bit must be set in 0x%llx",
+			  type, BTRFS_BLOCK_GROUP_TYPE_MASK);
+		return -EUCLEAN;
+	}
+
+	if (unlikely((type & BTRFS_BLOCK_GROUP_SYSTEM) &&
+		     (type & (BTRFS_BLOCK_GROUP_METADATA |
+			      BTRFS_BLOCK_GROUP_DATA)))) {
+		chunk_err(leaf, chunk, logical,
+			  "system chunk with data or metadata type: 0x%llx",
+			  type);
+		return -EUCLEAN;
+	}
+
+	features = btrfs_super_incompat_flags(fs_info->super_copy);
+	if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS)
+		mixed = true;
+
+	if (!mixed) {
+		if (unlikely((type & BTRFS_BLOCK_GROUP_METADATA) &&
+			     (type & BTRFS_BLOCK_GROUP_DATA))) {
+			chunk_err(leaf, chunk, logical,
+			"mixed chunk type in non-mixed mode: 0x%llx", type);
+			return -EUCLEAN;
+		}
+	}
+
+	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
+		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1C3 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1C4 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
+		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
+		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_DUP &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
+		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
+		chunk_err(leaf, chunk, logical,
+			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
+			num_stripes, sub_stripes,
+			type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		return -EUCLEAN;
+	}
+
+	return 0;
+}
+
+/*
+ * Enhanced version of chunk item checker.
+ *
+ * The common btrfs_check_chunk_valid() doesn't check item size since it needs
+ * to work on super block sys_chunk_array which doesn't have full item ptr.
+ */
+static int check_leaf_chunk_item(struct extent_buffer *leaf,
+				 struct btrfs_chunk *chunk,
+				 struct btrfs_key *key, int slot)
+{
+	int num_stripes;
+
+	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
+		chunk_err(leaf, chunk, key->offset,
+			"invalid chunk item size: have %u expect [%zu, %u)",
+			btrfs_item_size(leaf, slot),
+			sizeof(struct btrfs_chunk),
+			BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
+		return -EUCLEAN;
+	}
+
+	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+	/* Let btrfs_check_chunk_valid() handle this error type */
+	if (num_stripes == 0)
+		goto out;
+
+	if (unlikely(btrfs_chunk_item_size(num_stripes) !=
+		     btrfs_item_size(leaf, slot))) {
+		chunk_err(leaf, chunk, key->offset,
+			"invalid chunk item size: have %u expect %lu",
+			btrfs_item_size(leaf, slot),
+			btrfs_chunk_item_size(num_stripes));
+		return -EUCLEAN;
+	}
+out:
+	return btrfs_check_chunk_valid(leaf, chunk, key->offset);
+}
+
+__printf(3, 4)
+__cold
+static void dev_item_err(const struct extent_buffer *eb, int slot,
+			 const char *fmt, ...)
+{
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(eb->fs_info,
+	"corrupt %s: root=%llu block=%llu slot=%d devid=%llu %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+		key.objectid, &vaf);
+	va_end(args);
+}
+
+static int check_dev_item(struct extent_buffer *leaf,
+			  struct btrfs_key *key, int slot)
+{
+	struct btrfs_dev_item *ditem;
+	const u32 item_size = btrfs_item_size(leaf, slot);
+
+	if (unlikely(key->objectid != BTRFS_DEV_ITEMS_OBJECTID)) {
+		dev_item_err(leaf, slot,
+			     "invalid objectid: has=%llu expect=%llu",
+			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
+		return -EUCLEAN;
+	}
+
+	if (unlikely(item_size != sizeof(*ditem))) {
+		dev_item_err(leaf, slot, "invalid item size: has %u expect %zu",
+			     item_size, sizeof(*ditem));
+		return -EUCLEAN;
+	}
+
+	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
+	if (unlikely(btrfs_device_id(leaf, ditem) != key->offset)) {
+		dev_item_err(leaf, slot,
+			     "devid mismatch: key has=%llu item has=%llu",
+			     key->offset, btrfs_device_id(leaf, ditem));
+		return -EUCLEAN;
+	}
+
+	/*
+	 * For device total_bytes, we don't have reliable way to check it, as
+	 * it can be 0 for device removal. Device size check can only be done
+	 * by dev extents check.
+	 */
+	if (unlikely(btrfs_device_bytes_used(leaf, ditem) >
+		     btrfs_device_total_bytes(leaf, ditem))) {
+		dev_item_err(leaf, slot,
+			     "invalid bytes used: have %llu expect [0, %llu]",
+			     btrfs_device_bytes_used(leaf, ditem),
+			     btrfs_device_total_bytes(leaf, ditem));
+		return -EUCLEAN;
+	}
+	/*
+	 * Remaining members like io_align/type/gen/dev_group aren't really
+	 * utilized.  Skip them to make later usage of them easier.
+	 */
+	return 0;
+}
+
+static int check_inode_item(struct extent_buffer *leaf,
+			    struct btrfs_key *key, int slot)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_inode_item *iitem;
+	u64 super_gen = btrfs_super_generation(fs_info->super_copy);
+	u32 valid_mask = (S_IFMT | S_ISUID | S_ISGID | S_ISVTX | 0777);
+	const u32 item_size = btrfs_item_size(leaf, slot);
+	u32 mode;
+	int ret;
+	u32 flags;
+	u32 ro_flags;
+
+	ret = check_inode_key(leaf, key, slot);
+	if (unlikely(ret < 0))
+		return ret;
+
+	if (unlikely(item_size != sizeof(*iitem))) {
+		generic_err(leaf, slot, "invalid item size: has %u expect %zu",
+			    item_size, sizeof(*iitem));
+		return -EUCLEAN;
+	}
+
+	iitem = btrfs_item_ptr(leaf, slot, struct btrfs_inode_item);
+
+	/* Here we use super block generation + 1 to handle log tree */
+	if (unlikely(btrfs_inode_generation(leaf, iitem) > super_gen + 1)) {
+		inode_item_err(leaf, slot,
+			"invalid inode generation: has %llu expect (0, %llu]",
+			       btrfs_inode_generation(leaf, iitem),
+			       super_gen + 1);
+		return -EUCLEAN;
+	}
+	/* Note for ROOT_TREE_DIR_ITEM, mkfs could set its transid 0 */
+	if (unlikely(btrfs_inode_transid(leaf, iitem) > super_gen + 1)) {
+		inode_item_err(leaf, slot,
+			"invalid inode transid: has %llu expect [0, %llu]",
+			       btrfs_inode_transid(leaf, iitem), super_gen + 1);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * For size and nbytes it's better not to be too strict, as for dir
+	 * item its size/nbytes can easily get wrong, but doesn't affect
+	 * anything in the fs. So here we skip the check.
+	 */
+	mode = btrfs_inode_mode(leaf, iitem);
+	if (unlikely(mode & ~valid_mask)) {
+		inode_item_err(leaf, slot,
+			       "unknown mode bit detected: 0x%x",
+			       mode & ~valid_mask);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * S_IFMT is not bit mapped so we can't completely rely on
+	 * is_power_of_2/has_single_bit_set, but it can save us from checking
+	 * FIFO/CHR/DIR/REG.  Only needs to check BLK, LNK and SOCKS
+	 */
+	if (!has_single_bit_set(mode & S_IFMT)) {
+		if (unlikely(!S_ISLNK(mode) && !S_ISBLK(mode) && !S_ISSOCK(mode))) {
+			inode_item_err(leaf, slot,
+			"invalid mode: has 0%o expect valid S_IF* bit(s)",
+				       mode & S_IFMT);
+			return -EUCLEAN;
+		}
+	}
+	if (unlikely(S_ISDIR(mode) && btrfs_inode_nlink(leaf, iitem) > 1)) {
+		inode_item_err(leaf, slot,
+		       "invalid nlink: has %u expect no more than 1 for dir",
+			btrfs_inode_nlink(leaf, iitem));
+		return -EUCLEAN;
+	}
+	btrfs_inode_split_flags(btrfs_inode_flags(leaf, iitem), &flags, &ro_flags);
+	if (unlikely(flags & ~BTRFS_INODE_FLAG_MASK)) {
+		inode_item_err(leaf, slot,
+			       "unknown incompat flags detected: 0x%x", flags);
+		return -EUCLEAN;
+	}
+	if (unlikely(!sb_rdonly(fs_info->sb) &&
+		     (ro_flags & ~BTRFS_INODE_RO_FLAG_MASK))) {
+		inode_item_err(leaf, slot,
+			"unknown ro-compat flags detected on writeable mount: 0x%x",
+			ro_flags);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
+			   int slot)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_root_item ri = { 0 };
+	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
+				     BTRFS_ROOT_SUBVOL_DEAD;
+	int ret;
+
+	ret = check_root_key(leaf, key, slot);
+	if (unlikely(ret < 0))
+		return ret;
+
+	if (unlikely(btrfs_item_size(leaf, slot) != sizeof(ri) &&
+		     btrfs_item_size(leaf, slot) !=
+		     btrfs_legacy_root_item_size())) {
+		generic_err(leaf, slot,
+			    "invalid root item size, have %u expect %zu or %u",
+			    btrfs_item_size(leaf, slot), sizeof(ri),
+			    btrfs_legacy_root_item_size());
+		return -EUCLEAN;
+	}
+
+	/*
+	 * For legacy root item, the members starting at generation_v2 will be
+	 * all filled with 0.
+	 * And since we allow geneartion_v2 as 0, it will still pass the check.
+	 */
+	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
+			   btrfs_item_size(leaf, slot));
+
+	/* Generation related */
+	if (unlikely(btrfs_root_generation(&ri) >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
+		generic_err(leaf, slot,
+			"invalid root generation, have %llu expect (0, %llu]",
+			    btrfs_root_generation(&ri),
+			    btrfs_super_generation(fs_info->super_copy) + 1);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_root_generation_v2(&ri) >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
+		generic_err(leaf, slot,
+		"invalid root v2 generation, have %llu expect (0, %llu]",
+			    btrfs_root_generation_v2(&ri),
+			    btrfs_super_generation(fs_info->super_copy) + 1);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_root_last_snapshot(&ri) >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
+		generic_err(leaf, slot,
+		"invalid root last_snapshot, have %llu expect (0, %llu]",
+			    btrfs_root_last_snapshot(&ri),
+			    btrfs_super_generation(fs_info->super_copy) + 1);
+		return -EUCLEAN;
+	}
+
+	/* Alignment and level check */
+	if (unlikely(!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize))) {
+		generic_err(leaf, slot,
+		"invalid root bytenr, have %llu expect to be aligned to %u",
+			    btrfs_root_bytenr(&ri), fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_root_level(&ri) >= BTRFS_MAX_LEVEL)) {
+		generic_err(leaf, slot,
+			    "invalid root level, have %u expect [0, %u]",
+			    btrfs_root_level(&ri), BTRFS_MAX_LEVEL - 1);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_root_drop_level(&ri) >= BTRFS_MAX_LEVEL)) {
+		generic_err(leaf, slot,
+			    "invalid root level, have %u expect [0, %u]",
+			    btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
+		return -EUCLEAN;
+	}
+
+	/* Flags check */
+	if (unlikely(btrfs_root_flags(&ri) & ~valid_root_flags)) {
+		generic_err(leaf, slot,
+			    "invalid root flags, have 0x%llx expect mask 0x%llx",
+			    btrfs_root_flags(&ri), valid_root_flags);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+__printf(3,4)
+__cold
+static void extent_err(const struct extent_buffer *eb, int slot,
+		       const char *fmt, ...)
+{
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+	u64 bytenr;
+	u64 len;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	bytenr = key.objectid;
+	if (key.type == BTRFS_METADATA_ITEM_KEY ||
+	    key.type == BTRFS_TREE_BLOCK_REF_KEY ||
+	    key.type == BTRFS_SHARED_BLOCK_REF_KEY)
+		len = eb->fs_info->nodesize;
+	else
+		len = key.offset;
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(eb->fs_info,
+	"corrupt %s: block=%llu slot=%d extent bytenr=%llu len=%llu %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		eb->start, slot, bytenr, len, &vaf);
+	va_end(args);
+}
+
+static int check_extent_item(struct extent_buffer *leaf,
+			     struct btrfs_key *key, int slot,
+			     struct btrfs_key *prev_key)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_extent_item *ei;
+	bool is_tree_block = false;
+	unsigned long ptr;	/* Current pointer inside inline refs */
+	unsigned long end;	/* Extent item end */
+	const u32 item_size = btrfs_item_size(leaf, slot);
+	u64 flags;
+	u64 generation;
+	u64 total_refs;		/* Total refs in btrfs_extent_item */
+	u64 inline_refs = 0;	/* found total inline refs */
+
+	if (unlikely(key->type == BTRFS_METADATA_ITEM_KEY &&
+		     !btrfs_fs_incompat(fs_info, SKINNY_METADATA))) {
+		generic_err(leaf, slot,
+"invalid key type, METADATA_ITEM type invalid when SKINNY_METADATA feature disabled");
+		return -EUCLEAN;
+	}
+	/* key->objectid is the bytenr for both key types */
+	if (unlikely(!IS_ALIGNED(key->objectid, fs_info->sectorsize))) {
+		generic_err(leaf, slot,
+		"invalid key objectid, have %llu expect to be aligned to %u",
+			   key->objectid, fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+
+	/* key->offset is tree level for METADATA_ITEM_KEY */
+	if (unlikely(key->type == BTRFS_METADATA_ITEM_KEY &&
+		     key->offset >= BTRFS_MAX_LEVEL)) {
+		extent_err(leaf, slot,
+			   "invalid tree level, have %llu expect [0, %u]",
+			   key->offset, BTRFS_MAX_LEVEL - 1);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * EXTENT/METADATA_ITEM consists of:
+	 * 1) One btrfs_extent_item
+	 *    Records the total refs, type and generation of the extent.
+	 *
+	 * 2) One btrfs_tree_block_info (for EXTENT_ITEM and tree backref only)
+	 *    Records the first key and level of the tree block.
+	 *
+	 * 2) Zero or more btrfs_extent_inline_ref(s)
+	 *    Each inline ref has one btrfs_extent_inline_ref shows:
+	 *    2.1) The ref type, one of the 4
+	 *         TREE_BLOCK_REF	Tree block only
+	 *         SHARED_BLOCK_REF	Tree block only
+	 *         EXTENT_DATA_REF	Data only
+	 *         SHARED_DATA_REF	Data only
+	 *    2.2) Ref type specific data
+	 *         Either using btrfs_extent_inline_ref::offset, or specific
+	 *         data structure.
+	 */
+	if (unlikely(item_size < sizeof(*ei))) {
+		extent_err(leaf, slot,
+			   "invalid item size, have %u expect [%zu, %u)",
+			   item_size, sizeof(*ei),
+			   BTRFS_LEAF_DATA_SIZE(fs_info));
+		return -EUCLEAN;
+	}
+	end = item_size + btrfs_item_ptr_offset(leaf, slot);
+
+	/* Checks against extent_item */
+	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+	flags = btrfs_extent_flags(leaf, ei);
+	total_refs = btrfs_extent_refs(leaf, ei);
+	generation = btrfs_extent_generation(leaf, ei);
+	if (unlikely(generation >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
+		extent_err(leaf, slot,
+			   "invalid generation, have %llu expect (0, %llu]",
+			   generation,
+			   btrfs_super_generation(fs_info->super_copy) + 1);
+		return -EUCLEAN;
+	}
+	if (unlikely(!has_single_bit_set(flags & (BTRFS_EXTENT_FLAG_DATA |
+						  BTRFS_EXTENT_FLAG_TREE_BLOCK)))) {
+		extent_err(leaf, slot,
+		"invalid extent flag, have 0x%llx expect 1 bit set in 0x%llx",
+			flags, BTRFS_EXTENT_FLAG_DATA |
+			BTRFS_EXTENT_FLAG_TREE_BLOCK);
+		return -EUCLEAN;
+	}
+	is_tree_block = !!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK);
+	if (is_tree_block) {
+		if (unlikely(key->type == BTRFS_EXTENT_ITEM_KEY &&
+			     key->offset != fs_info->nodesize)) {
+			extent_err(leaf, slot,
+				   "invalid extent length, have %llu expect %u",
+				   key->offset, fs_info->nodesize);
+			return -EUCLEAN;
+		}
+	} else {
+		if (unlikely(key->type != BTRFS_EXTENT_ITEM_KEY)) {
+			extent_err(leaf, slot,
+			"invalid key type, have %u expect %u for data backref",
+				   key->type, BTRFS_EXTENT_ITEM_KEY);
+			return -EUCLEAN;
+		}
+		if (unlikely(!IS_ALIGNED(key->offset, fs_info->sectorsize))) {
+			extent_err(leaf, slot,
+			"invalid extent length, have %llu expect aligned to %u",
+				   key->offset, fs_info->sectorsize);
+			return -EUCLEAN;
+		}
+		if (unlikely(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
+	}
+	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
+
+	/* Check the special case of btrfs_tree_block_info */
+	if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
+		struct btrfs_tree_block_info *info;
+
+		info = (struct btrfs_tree_block_info *)ptr;
+		if (unlikely(btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL)) {
+			extent_err(leaf, slot,
+			"invalid tree block info level, have %u expect [0, %u]",
+				   btrfs_tree_block_level(leaf, info),
+				   BTRFS_MAX_LEVEL - 1);
+			return -EUCLEAN;
+		}
+		ptr = (unsigned long)(struct btrfs_tree_block_info *)(info + 1);
+	}
+
+	/* Check inline refs */
+	while (ptr < end) {
+		struct btrfs_extent_inline_ref *iref;
+		struct btrfs_extent_data_ref *dref;
+		struct btrfs_shared_data_ref *sref;
+		u64 dref_offset;
+		u64 inline_offset;
+		u8 inline_type;
+
+		if (unlikely(ptr + sizeof(*iref) > end)) {
+			extent_err(leaf, slot,
+"inline ref item overflows extent item, ptr %lu iref size %zu end %lu",
+				   ptr, sizeof(*iref), end);
+			return -EUCLEAN;
+		}
+		iref = (struct btrfs_extent_inline_ref *)ptr;
+		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
+		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
+		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
+			extent_err(leaf, slot,
+"inline ref item overflows extent item, ptr %lu iref size %u end %lu",
+				   ptr, inline_type, end);
+			return -EUCLEAN;
+		}
+
+		switch (inline_type) {
+		/* inline_offset is subvolid of the owner, no need to check */
+		case BTRFS_TREE_BLOCK_REF_KEY:
+			inline_refs++;
+			break;
+		/* Contains parent bytenr */
+		case BTRFS_SHARED_BLOCK_REF_KEY:
+			if (unlikely(!IS_ALIGNED(inline_offset,
+						 fs_info->sectorsize))) {
+				extent_err(leaf, slot,
+		"invalid tree parent bytenr, have %llu expect aligned to %u",
+					   inline_offset, fs_info->sectorsize);
+				return -EUCLEAN;
+			}
+			inline_refs++;
+			break;
+		/*
+		 * Contains owner subvolid, owner key objectid, adjusted offset.
+		 * The only obvious corruption can happen in that offset.
+		 */
+		case BTRFS_EXTENT_DATA_REF_KEY:
+			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
+			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
+			if (unlikely(!IS_ALIGNED(dref_offset,
+						 fs_info->sectorsize))) {
+				extent_err(leaf, slot,
+		"invalid data ref offset, have %llu expect aligned to %u",
+					   dref_offset, fs_info->sectorsize);
+				return -EUCLEAN;
+			}
+			inline_refs += btrfs_extent_data_ref_count(leaf, dref);
+			break;
+		/* Contains parent bytenr and ref count */
+		case BTRFS_SHARED_DATA_REF_KEY:
+			sref = (struct btrfs_shared_data_ref *)(iref + 1);
+			if (unlikely(!IS_ALIGNED(inline_offset,
+						 fs_info->sectorsize))) {
+				extent_err(leaf, slot,
+		"invalid data parent bytenr, have %llu expect aligned to %u",
+					   inline_offset, fs_info->sectorsize);
+				return -EUCLEAN;
+			}
+			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
+			break;
+		default:
+			extent_err(leaf, slot, "unknown inline ref type: %u",
+				   inline_type);
+			return -EUCLEAN;
+		}
+		ptr += btrfs_extent_inline_ref_size(inline_type);
+	}
+	/* No padding is allowed */
+	if (unlikely(ptr != end)) {
+		extent_err(leaf, slot,
+			   "invalid extent item size, padding bytes found");
+		return -EUCLEAN;
+	}
+
+	/* Finally, check the inline refs against total refs */
+	if (unlikely(inline_refs > total_refs)) {
+		extent_err(leaf, slot,
+			"invalid extent refs, have %llu expect >= inline %llu",
+			   total_refs, inline_refs);
+		return -EUCLEAN;
+	}
+
+	if ((prev_key->type == BTRFS_EXTENT_ITEM_KEY) ||
+	    (prev_key->type == BTRFS_METADATA_ITEM_KEY)) {
+		u64 prev_end = prev_key->objectid;
+
+		if (prev_key->type == BTRFS_METADATA_ITEM_KEY)
+			prev_end += fs_info->nodesize;
+		else
+			prev_end += prev_key->offset;
+
+		if (unlikely(prev_end > key->objectid)) {
+			extent_err(leaf, slot,
+	"previous extent [%llu %u %llu] overlaps current extent [%llu %u %llu]",
+				   prev_key->objectid, prev_key->type,
+				   prev_key->offset, key->objectid, key->type,
+				   key->offset);
+			return -EUCLEAN;
+		}
+	}
+
+	return 0;
+}
+
+static int check_simple_keyed_refs(struct extent_buffer *leaf,
+				   struct btrfs_key *key, int slot)
+{
+	u32 expect_item_size = 0;
+
+	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
+		expect_item_size = sizeof(struct btrfs_shared_data_ref);
+
+	if (unlikely(btrfs_item_size(leaf, slot) != expect_item_size)) {
+		generic_err(leaf, slot,
+		"invalid item size, have %u expect %u for key type %u",
+			    btrfs_item_size(leaf, slot),
+			    expect_item_size, key->type);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+		generic_err(leaf, slot,
+"invalid key objectid for shared block ref, have %llu expect aligned to %u",
+			    key->objectid, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(key->type != BTRFS_TREE_BLOCK_REF_KEY &&
+		     !IS_ALIGNED(key->offset, leaf->fs_info->sectorsize))) {
+		extent_err(leaf, slot,
+		"invalid tree parent bytenr, have %llu expect aligned to %u",
+			   key->offset, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+static int check_extent_data_ref(struct extent_buffer *leaf,
+				 struct btrfs_key *key, int slot)
+{
+	struct btrfs_extent_data_ref *dref;
+	unsigned long ptr = btrfs_item_ptr_offset(leaf, slot);
+	const unsigned long end = ptr + btrfs_item_size(leaf, slot);
+
+	if (unlikely(btrfs_item_size(leaf, slot) % sizeof(*dref) != 0)) {
+		generic_err(leaf, slot,
+	"invalid item size, have %u expect aligned to %zu for key type %u",
+			    btrfs_item_size(leaf, slot),
+			    sizeof(*dref), key->type);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+		generic_err(leaf, slot,
+"invalid key objectid for shared block ref, have %llu expect aligned to %u",
+			    key->objectid, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	for (; ptr < end; ptr += sizeof(*dref)) {
+		u64 offset;
+
+		/*
+		 * We cannot check the extent_data_ref hash due to possible
+		 * overflow from the leaf due to hash collisions.
+		 */
+		dref = (struct btrfs_extent_data_ref *)ptr;
+		offset = btrfs_extent_data_ref_offset(leaf, dref);
+		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
+			extent_err(leaf, slot,
+	"invalid extent data backref offset, have %llu expect aligned to %u",
+				   offset, leaf->fs_info->sectorsize);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
+#define inode_ref_err(eb, slot, fmt, args...)			\
+	inode_item_err(eb, slot, fmt, ##args)
+static int check_inode_ref(struct extent_buffer *leaf,
+			   struct btrfs_key *key, struct btrfs_key *prev_key,
+			   int slot)
+{
+	struct btrfs_inode_ref *iref;
+	unsigned long ptr;
+	unsigned long end;
+
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
+		return -EUCLEAN;
+	/* namelen can't be 0, so item_size == sizeof() is also invalid */
+	if (unlikely(btrfs_item_size(leaf, slot) <= sizeof(*iref))) {
+		inode_ref_err(leaf, slot,
+			"invalid item size, have %u expect (%zu, %u)",
+			btrfs_item_size(leaf, slot),
+			sizeof(*iref), BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
+		return -EUCLEAN;
+	}
+
+	ptr = btrfs_item_ptr_offset(leaf, slot);
+	end = ptr + btrfs_item_size(leaf, slot);
+	while (ptr < end) {
+		u16 namelen;
+
+		if (unlikely(ptr + sizeof(iref) > end)) {
+			inode_ref_err(leaf, slot,
+			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
+				ptr, end, sizeof(iref));
+			return -EUCLEAN;
+		}
+
+		iref = (struct btrfs_inode_ref *)ptr;
+		namelen = btrfs_inode_ref_name_len(leaf, iref);
+		if (unlikely(ptr + sizeof(*iref) + namelen > end)) {
+			inode_ref_err(leaf, slot,
+				"inode ref overflow, ptr %lu end %lu namelen %u",
+				ptr, end, namelen);
+			return -EUCLEAN;
+		}
+
+		/*
+		 * NOTE: In theory we should record all found index numbers
+		 * to find any duplicated indexes, but that will be too time
+		 * consuming for inodes with too many hard links.
+		 */
+		ptr += sizeof(*iref) + namelen;
+	}
+	return 0;
+}
+
+/*
+ * Common point to switch the item-specific validation.
+ */
+static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
+						    struct btrfs_key *key,
+						    int slot,
+						    struct btrfs_key *prev_key)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_chunk *chunk;
+	int ret = 0;
+
+	if (fs_info->skip_leaf_item_checks)
+		return 0;
+
+	switch (key->type) {
+	case BTRFS_EXTENT_DATA_KEY:
+		ret = check_extent_data_item(leaf, key, slot, prev_key);
+		break;
+	case BTRFS_EXTENT_CSUM_KEY:
+		ret = check_csum_item(leaf, key, slot, prev_key);
+		break;
+	case BTRFS_DIR_ITEM_KEY:
+	case BTRFS_DIR_INDEX_KEY:
+	case BTRFS_XATTR_ITEM_KEY:
+		ret = check_dir_item(leaf, key, prev_key, slot);
+		break;
+	case BTRFS_INODE_REF_KEY:
+		ret = check_inode_ref(leaf, key, prev_key, slot);
+		break;
+	case BTRFS_BLOCK_GROUP_ITEM_KEY:
+		ret = check_block_group_item(leaf, key, slot);
+		break;
+	case BTRFS_CHUNK_ITEM_KEY:
+		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
+		ret = check_leaf_chunk_item(leaf, chunk, key, slot);
+		break;
+	case BTRFS_DEV_ITEM_KEY:
+		ret = check_dev_item(leaf, key, slot);
+		break;
+	case BTRFS_INODE_ITEM_KEY:
+		ret = check_inode_item(leaf, key, slot);
+		break;
+	case BTRFS_ROOT_ITEM_KEY:
+		ret = check_root_item(leaf, key, slot);
+		break;
+	case BTRFS_EXTENT_ITEM_KEY:
+	case BTRFS_METADATA_ITEM_KEY:
+		ret = check_extent_item(leaf, key, slot, prev_key);
+		break;
+	case BTRFS_TREE_BLOCK_REF_KEY:
+	case BTRFS_SHARED_DATA_REF_KEY:
+	case BTRFS_SHARED_BLOCK_REF_KEY:
+		ret = check_simple_keyed_refs(leaf, key, slot);
+		break;
+	case BTRFS_EXTENT_DATA_REF_KEY:
+		ret = check_extent_data_ref(leaf, key, slot);
+		break;
+	}
+
+	if (ret)
+		return BTRFS_TREE_BLOCK_INVALID_ITEM;
+	return BTRFS_TREE_BLOCK_CLEAN;
+}
+
+enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
+{
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	/* No valid key type is 0, so all key should be larger than this key */
+	struct btrfs_key prev_key = {0, 0, 0};
+	struct btrfs_key key;
+	u32 nritems = btrfs_header_nritems(leaf);
+	int slot;
+	bool check_item_data = btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN);
+
+	if (unlikely(btrfs_header_level(leaf) != 0)) {
+		generic_err(leaf, 0,
+			"invalid level for leaf, have %d expect 0",
+			btrfs_header_level(leaf));
+		return BTRFS_TREE_BLOCK_INVALID_LEVEL;
+	}
+
+	/*
+	 * MODIFIED:
+	 *  - We need to skip the below checks for the temporary fs state during
+	 *    mkfs or --init-extent-tree.
+	 */
+	if (nritems == 0 &&
+	    (btrfs_super_magic(fs_info->super_copy) == BTRFS_MAGIC_TEMPORARY ||
+	     fs_info->skip_leaf_item_checks))
+		return BTRFS_TREE_BLOCK_CLEAN;
+
+	/*
+	 * Extent buffers from a relocation tree have a owner field that
+	 * corresponds to the subvolume tree they are based on. So just from an
+	 * extent buffer alone we can not find out what is the id of the
+	 * corresponding subvolume tree, so we can not figure out if the extent
+	 * buffer corresponds to the root of the relocation tree or not. So
+	 * skip this check for relocation trees.
+	 */
+	if (nritems == 0 && !btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_RELOC)) {
+		u64 owner = btrfs_header_owner(leaf);
+
+		/* These trees must never be empty */
+		if (unlikely(owner == BTRFS_ROOT_TREE_OBJECTID ||
+			     owner == BTRFS_CHUNK_TREE_OBJECTID ||
+			     owner == BTRFS_DEV_TREE_OBJECTID ||
+			     owner == BTRFS_FS_TREE_OBJECTID ||
+			     owner == BTRFS_DATA_RELOC_TREE_OBJECTID)) {
+			generic_err(leaf, 0,
+			"invalid root, root %llu must never be empty",
+				    owner);
+			return BTRFS_TREE_BLOCK_INVALID_NRITEMS;
+		}
+
+		/* Unknown tree */
+		if (unlikely(owner == 0)) {
+			generic_err(leaf, 0,
+				"invalid owner, root 0 is not defined");
+			return BTRFS_TREE_BLOCK_INVALID_OWNER;
+		}
+
+		/* EXTENT_TREE_V2 can have empty extent trees. */
+		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+			return BTRFS_TREE_BLOCK_CLEAN;
+
+		if (unlikely(owner == BTRFS_EXTENT_TREE_OBJECTID)) {
+			generic_err(leaf, 0,
+			"invalid root, root %llu must never be empty",
+				    owner);
+			return BTRFS_TREE_BLOCK_INVALID_NRITEMS;
+		}
+
+		return BTRFS_TREE_BLOCK_CLEAN;
+	}
+
+	if (unlikely(nritems == 0))
+		return BTRFS_TREE_BLOCK_CLEAN;
+
+	/*
+	 * Check the following things to make sure this is a good leaf, and
+	 * leaf users won't need to bother with similar sanity checks:
+	 *
+	 * 1) key ordering
+	 * 2) item offset and size
+	 *    No overlap, no hole, all inside the leaf.
+	 * 3) item content
+	 *    If possible, do comprehensive sanity check.
+	 *    NOTE: All checks must only rely on the item data itself.
+	 */
+	for (slot = 0; slot < nritems; slot++) {
+		u32 item_end_expected;
+		u64 item_data_end;
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+
+		/* Make sure the keys are in the right order */
+		if (unlikely(btrfs_comp_cpu_keys(&prev_key, &key) >= 0)) {
+			generic_err(leaf, slot,
+	"bad key order, prev (%llu %u %llu) current (%llu %u %llu)",
+				prev_key.objectid, prev_key.type,
+				prev_key.offset, key.objectid, key.type,
+				key.offset);
+			return BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
+		}
+
+		item_data_end = (u64)btrfs_item_offset(leaf, slot) +
+				btrfs_item_size(leaf, slot);
+		/*
+		 * Make sure the offset and ends are right, remember that the
+		 * item data starts at the end of the leaf and grows towards the
+		 * front.
+		 */
+		if (slot == 0)
+			item_end_expected = BTRFS_LEAF_DATA_SIZE(fs_info);
+		else
+			item_end_expected = btrfs_item_offset(leaf,
+								 slot - 1);
+		if (unlikely(item_data_end != item_end_expected)) {
+			generic_err(leaf, slot,
+				"unexpected item end, have %llu expect %u",
+				item_data_end, item_end_expected);
+			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
+		}
+
+		/*
+		 * Check to make sure that we don't point outside of the leaf,
+		 * just in case all the items are consistent to each other, but
+		 * all point outside of the leaf.
+		 */
+		if (unlikely(item_data_end > BTRFS_LEAF_DATA_SIZE(fs_info))) {
+			generic_err(leaf, slot,
+			"slot end outside of leaf, have %llu expect range [0, %u]",
+				item_data_end, BTRFS_LEAF_DATA_SIZE(fs_info));
+			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
+		}
+
+		/* Also check if the item pointer overlaps with btrfs item. */
+		if (unlikely(btrfs_item_ptr_offset(leaf, slot) <
+			     btrfs_item_nr_offset(leaf, slot) + sizeof(struct btrfs_item))) {
+			generic_err(leaf, slot,
+		"slot overlaps with its data, item end %lu data start %lu",
+				btrfs_item_nr_offset(leaf, slot) +
+				sizeof(struct btrfs_item),
+				btrfs_item_ptr_offset(leaf, slot));
+			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
+		}
+
+		/*
+		 * We only want to do this if WRITTEN is set, otherwise the leaf
+		 * may be in some intermediate state and won't appear valid.
+		 */
+		if (check_item_data) {
+			enum btrfs_tree_block_status ret;
+
+			/*
+			 * Check if the item size and content meet other
+			 * criteria
+			 */
+			ret = check_leaf_item(leaf, &key, slot, &prev_key);
+			if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+				return ret;
+		}
+
+		prev_key.objectid = key.objectid;
+		prev_key.type = key.type;
+		prev_key.offset = key.offset;
+	}
+
+	return BTRFS_TREE_BLOCK_CLEAN;
+}
+
+int btrfs_check_leaf(struct extent_buffer *leaf)
+{
+	enum btrfs_tree_block_status ret;
+
+	ret = __btrfs_check_leaf(leaf);
+	if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+		return -EUCLEAN;
+	return 0;
+}
+ALLOW_ERROR_INJECTION(btrfs_check_leaf, ERRNO);
+
+enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
+{
+	struct btrfs_fs_info *fs_info = node->fs_info;
+	unsigned long nr = btrfs_header_nritems(node);
+	struct btrfs_key key, next_key;
+	int slot;
+	int level = btrfs_header_level(node);
+	u64 bytenr;
+
+	if (unlikely(level <= 0 || level >= BTRFS_MAX_LEVEL)) {
+		generic_err(node, 0,
+			"invalid level for node, have %d expect [1, %d]",
+			level, BTRFS_MAX_LEVEL - 1);
+		return BTRFS_TREE_BLOCK_INVALID_LEVEL;
+	}
+	if (unlikely(nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info))) {
+		btrfs_crit(fs_info,
+"corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%u]",
+			   btrfs_header_owner(node), node->start,
+			   nr == 0 ? "small" : "large", nr,
+			   BTRFS_NODEPTRS_PER_BLOCK(fs_info));
+		return BTRFS_TREE_BLOCK_INVALID_NRITEMS;
+	}
+
+	for (slot = 0; slot < nr - 1; slot++) {
+		bytenr = btrfs_node_blockptr(node, slot);
+		btrfs_node_key_to_cpu(node, &key, slot);
+		btrfs_node_key_to_cpu(node, &next_key, slot + 1);
+
+		if (unlikely(!bytenr)) {
+			generic_err(node, slot,
+				"invalid NULL node pointer");
+			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
+		}
+		if (unlikely(!IS_ALIGNED(bytenr, fs_info->sectorsize))) {
+			generic_err(node, slot,
+			"unaligned pointer, have %llu should be aligned to %u",
+				bytenr, fs_info->sectorsize);
+			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
+		}
+
+		if (unlikely(btrfs_comp_cpu_keys(&key, &next_key) >= 0)) {
+			generic_err(node, slot,
+	"bad key order, current (%llu %u %llu) next (%llu %u %llu)",
+				key.objectid, key.type, key.offset,
+				next_key.objectid, next_key.type,
+				next_key.offset);
+			return BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
+		}
+	}
+	return BTRFS_TREE_BLOCK_CLEAN;
+}
+
+int btrfs_check_node(struct extent_buffer *node)
+{
+	enum btrfs_tree_block_status ret;
+
+	ret = __btrfs_check_node(node);
+	if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+		return -EUCLEAN;
+	return 0;
+}
+ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
+
+int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
+{
+	const bool is_subvol = is_fstree(root_owner);
+	const u64 eb_owner = btrfs_header_owner(eb);
+
+	/*
+	 * Skip dummy fs, as selftests don't create unique ebs for each dummy
+	 * root.
+	 *
+	 * MODIFIED:
+	 *  - The ->fs_state member doesn't exist in btrfs-progs yet.
+	 *
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &eb->fs_info->fs_state))
+		return 0;
+	*/
+
+	/*
+	 * There are several call sites (backref walking, qgroup, and data
+	 * reloc) passing 0 as @root_owner, as they are not holding the
+	 * tree root.  In that case, we can not do a reliable ownership check,
+	 * so just exit.
+	 */
+	if (root_owner == 0)
+		return 0;
+	/*
+	 * These trees use key.offset as their owner, our callers don't have
+	 * the extra capacity to pass key.offset here.  So we just skip them.
+	 */
+	if (root_owner == BTRFS_TREE_LOG_OBJECTID ||
+	    root_owner == BTRFS_TREE_RELOC_OBJECTID)
+		return 0;
+
+	if (!is_subvol) {
+		/* For non-subvolume trees, the eb owner should match root owner */
+		if (unlikely(root_owner != eb_owner)) {
+			btrfs_crit(eb->fs_info,
+"corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect %llu",
+				btrfs_header_level(eb) == 0 ? "leaf" : "node",
+				root_owner, btrfs_header_bytenr(eb), eb_owner,
+				root_owner);
+			return -EUCLEAN;
+		}
+		return 0;
+	}
+
+	/*
+	 * For subvolume trees, owners can mismatch, but they should all belong
+	 * to subvolume trees.
+	 */
+	if (unlikely(is_subvol != is_fstree(eb_owner))) {
+		btrfs_crit(eb->fs_info,
+"corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect [%llu, %llu]",
+			btrfs_header_level(eb) == 0 ? "leaf" : "node",
+			root_owner, btrfs_header_bytenr(eb), eb_owner,
+			BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
+int btrfs_verify_level_key(struct extent_buffer *eb, int level,
+			   struct btrfs_key *first_key, u64 parent_transid)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	int found_level;
+	struct btrfs_key found_key;
+	int ret;
+
+	found_level = btrfs_header_level(eb);
+	if (found_level != level) {
+		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
+		     KERN_ERR "BTRFS: tree level check failed\n");
+		btrfs_err(fs_info,
+"tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
+			  eb->start, level, found_level);
+		return -EIO;
+	}
+
+	if (!first_key)
+		return 0;
+
+	/*
+	 * For live tree block (new tree blocks in current transaction),
+	 * we need proper lock context to avoid race, which is impossible here.
+	 * So we only checks tree blocks which is read from disk, whose
+	 * generation <= fs_info->last_trans_committed.
+	 */
+	if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
+		return 0;
+
+	/* We have @first_key, so this @eb must have at least one item */
+	if (btrfs_header_nritems(eb) == 0) {
+		btrfs_err(fs_info,
+		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
+			  eb->start);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		return -EUCLEAN;
+	}
+
+	if (found_level)
+		btrfs_node_key_to_cpu(eb, &found_key, 0);
+	else
+		btrfs_item_key_to_cpu(eb, &found_key, 0);
+	ret = btrfs_comp_cpu_keys(first_key, &found_key);
+
+	if (ret) {
+		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
+		     KERN_ERR "BTRFS: tree first key check failed\n");
+		btrfs_err(fs_info,
+"tree first key mismatch detected, bytenr=%llu parent_transid=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
+			  eb->start, parent_transid, first_key->objectid,
+			  first_key->type, first_key->offset,
+			  found_key.objectid, found_key.type,
+			  found_key.offset);
+	}
+	return ret;
+}
diff --git a/kernel-shared/tree-checker.h b/kernel-shared/tree-checker.h
new file mode 100644
index 00000000..9c4ba01a
--- /dev/null
+++ b/kernel-shared/tree-checker.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Qu Wenruo 2017.  All rights reserved.
+ */
+
+#ifndef BTRFS_TREE_CHECKER_H
+#define BTRFS_TREE_CHECKER_H
+
+#include "uapi/btrfs_tree.h"
+
+struct extent_buffer;
+struct btrfs_chunk;
+
+/* All the extra info needed to verify the parentness of a tree block. */
+struct btrfs_tree_parent_check {
+	/*
+	 * The owner check against the tree block.
+	 *
+	 * Can be 0 to skip the owner check.
+	 */
+	u64 owner_root;
+
+	/*
+	 * Expected transid, can be 0 to skip the check, but such skip
+	 * should only be utlized for backref walk related code.
+	 */
+	u64 transid;
+
+	/*
+	 * The expected first key.
+	 *
+	 * This check can be skipped if @has_first_key is false, such skip
+	 * can happen for case where we don't have the parent node key,
+	 * e.g. reading the tree root, doing backref walk.
+	 */
+	struct btrfs_key first_key;
+	bool has_first_key;
+
+	/* The expected level. Should always be set. */
+	u8 level;
+};
+
+enum btrfs_tree_block_status {
+	BTRFS_TREE_BLOCK_CLEAN,
+	BTRFS_TREE_BLOCK_INVALID_NRITEMS,
+	BTRFS_TREE_BLOCK_INVALID_PARENT_KEY,
+	BTRFS_TREE_BLOCK_BAD_KEY_ORDER,
+	BTRFS_TREE_BLOCK_INVALID_LEVEL,
+	BTRFS_TREE_BLOCK_INVALID_FREE_SPACE,
+	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
+	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
+	BTRFS_TREE_BLOCK_INVALID_ITEM,
+	BTRFS_TREE_BLOCK_INVALID_OWNER,
+};
+
+/*
+ * Exported simply for btrfs-progs which wants to have the
+ * btrfs_tree_block_status return codes.
+ */
+enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf);
+enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node);
+
+int btrfs_check_leaf(struct extent_buffer *leaf);
+int btrfs_check_node(struct extent_buffer *node);
+
+int btrfs_check_chunk_valid(struct extent_buffer *leaf,
+			    struct btrfs_chunk *chunk, u64 logical);
+int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner);
+int btrfs_verify_level_key(struct extent_buffer *eb, int level,
+			   struct btrfs_key *first_key, u64 parent_transid);
+
+#endif
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 14fcefee..fff49a06 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -32,6 +32,7 @@
 #include "common/utils.h"
 #include "common/device-utils.h"
 #include "kernel-lib/raid56.h"
+#include "tree-checker.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -2086,101 +2087,6 @@ static struct btrfs_device *fill_missing_device(u64 devid)
 	return device;
 }
 
-/*
- * slot == -1: SYSTEM chunk
- * return -EIO on error, otherwise return 0
- */
-int btrfs_check_chunk_valid(struct extent_buffer *leaf,
-			    struct btrfs_chunk *chunk, u64 logical)
-{
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	u64 length;
-	u64 stripe_len;
-	u16 num_stripes;
-	u16 sub_stripes;
-	u64 type;
-	u32 sectorsize = fs_info->sectorsize;
-	int min_devs;
-	int table_sub_stripes;
-
-	length = btrfs_chunk_length(leaf, chunk);
-	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
-	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
-	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
-	type = btrfs_chunk_type(leaf, chunk);
-
-	if (num_stripes == 0) {
-		error("invalid num_stripes, have %u expect non-zero",
-			num_stripes);
-		return -EUCLEAN;
-	}
-
-	/*
-	 * These valid checks may be insufficient to cover every corner cases.
-	 */
-	if (!IS_ALIGNED(logical, sectorsize)) {
-		error("invalid chunk logical %llu",  logical);
-		return -EIO;
-	}
-	if (btrfs_chunk_sector_size(leaf, chunk) != sectorsize) {
-		error("invalid chunk sectorsize %llu",
-		      (unsigned long long)btrfs_chunk_sector_size(leaf, chunk));
-		return -EIO;
-	}
-	if (!length || !IS_ALIGNED(length, sectorsize)) {
-		error("invalid chunk length %llu",  length);
-		return -EIO;
-	}
-	if (stripe_len != BTRFS_STRIPE_LEN) {
-		error("invalid chunk stripe length: %llu", stripe_len);
-		return -EIO;
-	}
-	if (type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-		     BTRFS_BLOCK_GROUP_PROFILE_MASK)) {
-		error("unrecognized chunk type: %llu",
-		      ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-			BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
-		return -EIO;
-	}
-	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-		error("missing chunk type flag: %llu", type);
-		return -EIO;
-	}
-	if (!(is_power_of_2(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) ||
-	      (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0)) {
-		error("conflicting chunk type detected: %llu", type);
-		return -EIO;
-	}
-	if ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
-	    !is_power_of_2(type & BTRFS_BLOCK_GROUP_PROFILE_MASK)) {
-		error("conflicting chunk profile detected: %llu", type);
-		return -EIO;
-	}
-
-	/*
-	 * Device number check against profile
-	 */
-	min_devs = btrfs_bg_type_to_devs_min(type);
-	table_sub_stripes = btrfs_bg_type_to_sub_stripes(type);
-	if ((type & BTRFS_BLOCK_GROUP_RAID10 && (sub_stripes != table_sub_stripes ||
-		  !IS_ALIGNED(num_stripes, sub_stripes))) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes < min_devs) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID1C3 && num_stripes < min_devs) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID1C4 && num_stripes < min_devs) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < min_devs) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < min_devs) ||
-	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes > 2) ||
-	    ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
-	     num_stripes != 1)) {
-		error("Invalid num_stripes:sub_stripes %u:%u for profile %llu",
-		      num_stripes, sub_stripes,
-		      type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 /*
  * Slot is used to verify the chunk item is valid
  *
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 84fd6617..ab5ac402 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -294,8 +294,6 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 			     struct extent_buffer *eb,
 			     struct btrfs_multi_bio *multi,
 			     u64 stripe_len, u64 *raid_map);
-int btrfs_check_chunk_valid(struct extent_buffer *leaf,
-			    struct btrfs_chunk *chunk, u64 logical);
 u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 			struct extent_buffer *leaf,
 			struct btrfs_chunk *chunk);
-- 
2.40.0

