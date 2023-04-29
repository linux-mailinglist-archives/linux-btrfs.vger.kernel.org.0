Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5736F2630
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjD2UHp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjD2UHj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C53132
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so14214025276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798856; x=1685390856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PevR7miQK5UnzH5jlnRw4m1LP/X4BZ8smpVG6zFEeVI=;
        b=397rNiTH/OlCTQH4NijHcxAUML52NxhGavrihUfslpgPYJ/EeXZrDmb1VHIf+egzgg
         VTcYuZNVFWiwv6+VCzMW9Fe1avlLCTWIO9lysqm86ly6vTB3eaNlDqwToHIzL0IO+zga
         UHxSWKqg595MougFRgIEofxtEKnfh0SiqWz0gtbRH45x0y7Hi1/NyzZhEz1vNduO8D7X
         78pw9oiT1L4lbsGhggA6UkknsbOgd9VRMCiEOpOIDiVrYqqjZihRfORcJVeLTo1GKzlB
         Sho/l/AsewPnC4KzEu6TKXYTWwoHx9FXlgIDZAtJeUYkwM4+NDNBFfZzoo/brMD6nqij
         F70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798856; x=1685390856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PevR7miQK5UnzH5jlnRw4m1LP/X4BZ8smpVG6zFEeVI=;
        b=U2zxpg33wPe3eki8rbq/hdtRXpU0UWO5tW1NlU9Lqi9C7J0FQop+7OOvAQKSP2YLJP
         P0AtffEIjFdtepTMy52Aat9C9uAvRJkz5W5UJ775Hx2M/H6j3368+JvkKdXczV3IdWUd
         GYBGnBtAvyst0NDpn6dCRubIT1RK6yy81eGSnmkWMACNGRXz46wBQ/WluMfZu1hSxKKj
         7Q046D+S4Ukv12JT0eqRu14aRcQAeq2ldRZ34oTN5fZABC+TqeNAWezCY2f8Tb8ljUXA
         uPLql2Ym62emwDc1vXvMWGXUHTw04J6jHB1USwRffDAStmBBLsuSZJ0vpkx05vPolbUT
         mcvA==
X-Gm-Message-State: AC+VfDwOhxL36nMsOKmKvwfSH/NeBLhCJCyJJdKJZwnyXhXv1fpnSZGD
        Y4xqsW9Fr6Iuh7r8LhbRe86+tIt6KeIR3GQshuea+g==
X-Google-Smtp-Source: ACHHUZ5cXdYAs0cPIvzYhs4oOIaUUfQGK8gc63eDg7eX6GBMfg6lxWIKGIF5oOuka+iU7od9C0x7Mg==
X-Received: by 2002:a25:e64c:0:b0:b9a:6507:978 with SMTP id d73-20020a25e64c000000b00b9a65070978mr9206111ybh.12.1682798856469;
        Sat, 29 Apr 2023 13:07:36 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 190-20020a250ac7000000b00b7767ca749esm5874139ybk.59.2023.04.29.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/12] btrfs: extend btrfs_leaf_check to return btrfs_tree_block_status
Date:   Sat, 29 Apr 2023 16:07:15 -0400
Message-Id: <a528c8c37d20b53a0608185ecb83f870026a9917.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

Instead of blanket returning -EUCLEAN for all the failures in
btrfs_check_leaf, use btrfs_tree_block_status and return the appropriate
status for each failure.  Rename the helper to __btrfs_check_leaf and
then make a wrapper of btrfs_check_leaf that will return -EUCLEAN to
non-clean error codes.  This will allow us to have the
__btrfs_check_leaf variant in btrfs-progs while keeping the behavior in
the kernel consistent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 36 +++++++++++++++++++++++-------------
 fs/btrfs/tree-checker.h |  7 +++++++
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index bfc1f65726f6..2c330e9d123a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1678,7 +1678,7 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
 	return BTRFS_TREE_BLOCK_CLEAN;
 }
 
-int btrfs_check_leaf(struct extent_buffer *leaf)
+enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	/* No valid key type is 0, so all key should be larger than this key */
@@ -1692,7 +1692,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 		generic_err(leaf, 0,
 			"invalid level for leaf, have %d expect 0",
 			btrfs_header_level(leaf));
-		return -EUCLEAN;
+		return BTRFS_TREE_BLOCK_INVALID_LEVEL;
 	}
 
 	/*
@@ -1715,32 +1715,32 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 			generic_err(leaf, 0,
 			"invalid root, root %llu must never be empty",
 				    owner);
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_INVALID_NRITEMS;
 		}
 
 		/* Unknown tree */
 		if (unlikely(owner == 0)) {
 			generic_err(leaf, 0,
 				"invalid owner, root 0 is not defined");
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_INVALID_OWNER;
 		}
 
 		/* EXTENT_TREE_V2 can have empty extent trees. */
 		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
-			return 0;
+			return BTRFS_TREE_BLOCK_CLEAN;
 
 		if (unlikely(owner == BTRFS_EXTENT_TREE_OBJECTID)) {
 			generic_err(leaf, 0,
 			"invalid root, root %llu must never be empty",
 				    owner);
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_INVALID_NRITEMS;
 		}
 
-		return 0;
+		return BTRFS_TREE_BLOCK_CLEAN;
 	}
 
 	if (unlikely(nritems == 0))
-		return 0;
+		return BTRFS_TREE_BLOCK_CLEAN;
 
 	/*
 	 * Check the following things to make sure this is a good leaf, and
@@ -1766,7 +1766,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 				prev_key.objectid, prev_key.type,
 				prev_key.offset, key.objectid, key.type,
 				key.offset);
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 		}
 
 		item_data_end = (u64)btrfs_item_offset(leaf, slot) +
@@ -1785,7 +1785,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 			generic_err(leaf, slot,
 				"unexpected item end, have %llu expect %u",
 				item_data_end, item_end_expected);
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 		}
 
 		/*
@@ -1797,7 +1797,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 			generic_err(leaf, slot,
 			"slot end outside of leaf, have %llu expect range [0, %u]",
 				item_data_end, BTRFS_LEAF_DATA_SIZE(fs_info));
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 		}
 
 		/* Also check if the item pointer overlaps with btrfs item. */
@@ -1808,7 +1808,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 				btrfs_item_nr_offset(leaf, slot) +
 				sizeof(struct btrfs_item),
 				btrfs_item_ptr_offset(leaf, slot));
-			return -EUCLEAN;
+			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 		}
 
 		/*
@@ -1824,7 +1824,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 			 */
 			ret = check_leaf_item(leaf, &key, slot, &prev_key);
 			if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
-				return -EUCLEAN;
+				return ret;
 		}
 
 		prev_key.objectid = key.objectid;
@@ -1832,6 +1832,16 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 		prev_key.offset = key.offset;
 	}
 
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
 	return 0;
 }
 ALLOW_ERROR_INJECTION(btrfs_check_leaf, ERRNO);
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 5e06d9ad2862..3b8de6d36141 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -50,8 +50,15 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
 	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
 	BTRFS_TREE_BLOCK_INVALID_ITEM,
+	BTRFS_TREE_BLOCK_INVALID_OWNER,
 };
 
+/*
+ * Exported simply for btrfs-progs which wants to have the
+ * btrfs_tree_block_status return codes.
+ */
+enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf);
+
 int btrfs_check_leaf(struct extent_buffer *leaf);
 int btrfs_check_node(struct extent_buffer *node);
 
-- 
2.40.0

