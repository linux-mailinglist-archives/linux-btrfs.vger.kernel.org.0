Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB236F2655
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjD2UUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjD2UUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025EE79
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:17 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-552a6357d02so16103547b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799617; x=1685391617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wC886aHfGuvdaCyaZNXNQMxkeCfR8OL3zOMiZCs4JM=;
        b=cJxrFrFRt1U+58iqqFaIj/u7vmLPqGd4UX+LyIaaHVfgoyT7rGy0omn2VZ/Ad/E4P9
         W5TK2MRcSVb51NaefDKzQbfqHI5XOPpRHIBSi8kIsdI9etlwgyBioNu5Obi0v7SFlGFG
         hD9WwJW3O0+JwH90FNc0ujsvb6B2XJfRWczlCi0Je57iHAoe/illYKAOcVrueozwApgg
         VuVmD1P/q7F6hEqK1yS1Pu82KCo3kC0pfc1VmzNSIUUhADUkqTIQD2lJHd+SV8BbKzoi
         97/bq7AVZJ5SzYzdqm7CvZDaO52qmPxLV0mxMtDTokwkp+c4Dp0o9phgAXXqgH1NQ8WV
         JUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799617; x=1685391617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wC886aHfGuvdaCyaZNXNQMxkeCfR8OL3zOMiZCs4JM=;
        b=DnJLrsQihRHT624B8g5ppZcHoSG3yae5TSFiJGbIYEC61CaPoEZq2jYdfWVX9TdkdM
         cKQcv3qDvzbc8QIwPy4V5GoYOtPyjrDpQ9eIEPeNxZWsh40pJG2k9eY744mxVmge/4Pv
         /J2qLjFH8Xirt+hp5oWpI63lS6GS7Gsi3Bj6E9VD5NTp2DS56/WbFmR/RjgV3C2DnF5n
         DvTiQhfboOpAe/jQPzoipE8+7AWsNVAtzP/TTGsnuqLU8kQ0X4uk32yKvwQJ04HZBD+G
         3tlTKMr9363bw06f/REnM9nCoFcnEesakB947j1+TAGSjFfdfzvE709HWQuYygon9Qnl
         HRew==
X-Gm-Message-State: AC+VfDwUACExOzuEfh8D26+Rpna1MBjqHQ7ht9MILQJiEIoVFdNaP7cU
        ZPBFoSpoIzXNiNCx7ijlNgyJ2nK0n+mlHtuCitjgCA==
X-Google-Smtp-Source: ACHHUZ66N9a5OiQ6W/Sdo4r5ciynuNdnra3N2V9u1aexSJbMWglGIZ8GSCtNcGURSzfcJCfZHbCYKQ==
X-Received: by 2002:a81:494f:0:b0:556:300c:d653 with SMTP id w76-20020a81494f000000b00556300cd653mr7260690ywa.40.1682799616862;
        Sat, 29 Apr 2023 13:20:16 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h190-20020a0dc5c7000000b00545a08184f8sm6307901ywd.136.2023.04.29.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/26] btrfs-progs: update btrfs_extend_item to match the kernel definition
Date:   Sat, 29 Apr 2023 16:19:42 -0400
Message-Id: <1b63fa6b0e4b05bc514f122af669ec6e34198030.1682799405.git.josef@toxicpanda.com>
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

Similar to btrfs_truncate_item(), this is void in the kernel as the
failure case is simply BUG_ON().  Additionally there is no root
parameter as it's not used in the function at all.  Make these changes
and update the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c       | 8 ++------
 kernel-shared/ctree.h       | 3 +--
 kernel-shared/dir-item.c    | 4 ++--
 kernel-shared/extent-tree.c | 4 +---
 kernel-shared/file-item.c   | 3 +--
 kernel-shared/inode-item.c  | 5 ++---
 tune/change-csum.c          | 3 +--
 7 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index d78a3258..97164cb8 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2513,10 +2513,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	}
 }
 
-int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
-		      u32 data_size)
+void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 {
-	int ret = 0;
 	int slot;
 	struct extent_buffer *leaf;
 	u32 nritems;
@@ -2564,12 +2562,10 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_set_item_size(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(leaf);
 
-	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
-	return ret;
 }
 
 /*
@@ -3218,7 +3214,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		 * ret == -EEXIST case, An item with that type already exists.
 		 * Extend the item and store the new subvol_id at the end.
 		 */
-		btrfs_extend_item(uuid_root, path, sizeof(subvol_id_le));
+		btrfs_extend_item(path, sizeof(subvol_id_le));
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 18562f3b..b3e73e35 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -967,8 +967,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
 int btrfs_create_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *fs_info, u64 objectid);
-int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
-		u32 data_size);
+void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index ef49441c..def7ea81 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -40,8 +40,8 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 		di = btrfs_match_dir_item_name(root, path, name, name_len);
 		if (di)
 			return ERR_PTR(-EEXIST);
-		ret = btrfs_extend_item(root, path, data_size);
-		WARN_ON(ret > 0);
+		btrfs_extend_item(path, data_size);
+		ret = 0;
 	}
 	if (ret < 0)
 		return ERR_PTR(ret);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 718a4fc9..ba853110 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1040,7 +1040,6 @@ static int setup_inline_extent_backref(struct btrfs_root *root,
 	u64 refs;
 	int size;
 	int type;
-	int ret;
 
 	leaf = path->nodes[0];
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
@@ -1049,8 +1048,7 @@ static int setup_inline_extent_backref(struct btrfs_root *root,
 	type = extent_ref_type(parent, owner);
 	size = btrfs_extent_inline_ref_size(type);
 
-	ret = btrfs_extend_item(root, path, size);
-	BUG_ON(ret);
+	btrfs_extend_item(path, size);
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	refs = btrfs_extent_refs(leaf, ei);
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 6e0f7381..fd6756e9 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -293,8 +293,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 		diff = diff - btrfs_item_size(leaf, path->slots[0]);
 		if (diff != csum_size)
 			goto insert;
-		ret = btrfs_extend_item(root, path, diff);
-		BUG_ON(ret);
+		btrfs_extend_item(path, diff);
 		goto csum;
 	}
 
diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
index 891ae40a..d0705267 100644
--- a/kernel-shared/inode-item.c
+++ b/kernel-shared/inode-item.c
@@ -78,8 +78,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			goto out;
 
 		old_size = btrfs_item_size(path->nodes[0], path->slots[0]);
-		ret = btrfs_extend_item(root, path, ins_len);
-		BUG_ON(ret);
+		btrfs_extend_item(path, ins_len);
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
 		ref = (struct btrfs_inode_ref *)((unsigned long)ref + old_size);
@@ -352,7 +351,7 @@ int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 						   name, name_len, NULL))
 			goto out;
 
-		btrfs_extend_item(root, path, ins_len);
+		btrfs_extend_item(path, ins_len);
 		ret = 0;
 	}
 
diff --git a/tune/change-csum.c b/tune/change-csum.c
index a1131686..49624c6f 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -232,8 +232,7 @@ static int csum_file_block(struct btrfs_trans_handle *trans,
 		diff = diff - btrfs_item_size(leaf, path->slots[0]);
 		if (diff != csum_size)
 			goto insert;
-		ret = btrfs_extend_item(csum_root, path, diff);
-		BUG_ON(ret);
+		btrfs_extend_item(path, diff);
 		goto csum;
 	}
 
-- 
2.40.0

