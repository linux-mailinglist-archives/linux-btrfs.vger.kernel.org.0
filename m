Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9E785AB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHWOdf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjHWOde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98161E54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:32 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d748d8cf074so5219880276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801211; x=1693406011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9Pfbvfgkav1oa6o5OV8ZVbBs6vOfj2IAo+JgEBWrYo=;
        b=WVFLFVJUphehpv+QoMp8DC6d/nbmosYoDnkPXd9+DGsy6IU64qZZdmxYWxUGGYN9g7
         D0eyFhVJqCvVhTLuR+kitnOQdndbnDsMn3o/bifG4qDVGwA2rBlq2+FJXN7GPadfK80F
         VMa2CYKWAAALl6a3ThmrXnwRL3Sonce8Gap8EF8p20Pl3vg1GkgG5obPiImPQoVXHjqu
         +PZ5ADZRn0oi8OXn/ATwwyxGo7dWjaECmk1pck3okCDIq/mKM0Xb7hFjBABWblAHhwmk
         JIcejWpnp6JL01pCTa0zxzBO7FS76ZJ70xmPiVfFnZDyfwWy1fgBDOSxueRy38EXrpWF
         BfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801211; x=1693406011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9Pfbvfgkav1oa6o5OV8ZVbBs6vOfj2IAo+JgEBWrYo=;
        b=GCZO+9qVz66nKxcB+8b/48hwAbigZqmqn8DV8raytZ1wNuHoDobBHkiJjcGcOmPtGd
         TOLjtvOt5F8U//anhuIisUgW+fho0GviZVz8J53wtopLGPY2isZPfTHizJLsgxWfLLGB
         d09xzDJkk+AlPLurKk841ej1csdchTu1h5Bk20n/XbiRQGfr9sgu0MxE4xny+O+Ts8D1
         w0hW1ak/cjDU0W0spBSFtn5+Jv0qsY7oWOf/s0+RtLPwJF+C7xUcTpyhUZQl944JcA+G
         rCAZylGKmJWT1QTvmCoOmOBHinY1ONqFjeG1ZezcAG3LGsETRk5YMmmPnd4ykX343/fr
         Lw2g==
X-Gm-Message-State: AOJu0Yy9ouTIFoOyOSf3Hyx95CtJka5IGsYb1c4EVhbx1Zay4X699rbV
        b7OH7wx04jRz3FXj7w7jBkGKJ94bIR/iEfXVAH0=
X-Google-Smtp-Source: AGHT+IGgyhSlprP72Cvi3D9IcNW3Ty0gnYeZSQ2YEmL3oY1+G81HJrnh7nIUtILzq/ZH5K33Hn3m9g==
X-Received: by 2002:a25:d4c5:0:b0:d62:b8f4:a03f with SMTP id m188-20020a25d4c5000000b00d62b8f4a03fmr13563521ybf.24.1692801211467;
        Wed, 23 Aug 2023 07:33:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v71-20020a252f4a000000b00d1732567560sm2845437ybv.5.2023.08.23.07.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/38] btrfs-progs: move btrfs_uuid_tree_add into mkfs/main.c
Date:   Wed, 23 Aug 2023 10:32:45 -0400
Message-ID: <f5a2df3717f8a87b01cae711be25f2dc836339f4.1692800904.git.josef@toxicpanda.com>
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

This function is only used in mkfs, and doesn't exist in the kernel in
ctree.c.  Additionally we have a uuid lookup function to see if the uuid
exists in the tree, which for mkfs it won't because we just created the
tree.  Move btrfs_uuid_tree_add into mkfs, and remove the lookup
function as it's not needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 133 ------------------------------------------
 kernel-shared/ctree.h |   2 -
 mkfs/main.c           |  59 +++++++++++++++++++
 3 files changed, 59 insertions(+), 135 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 1e45f756..ae6c03f9 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -3077,136 +3077,3 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 	}
 	return 1;
 }
-
-/*
- * Search uuid tree - unmounted
- *
- * return -ENOENT for !found, < 0 for errors, or 0 if an item was found
- */
-static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, u8 *uuid,
-				  u8 type, u64 subid)
-{
-	int ret;
-	struct btrfs_path *path = NULL;
-	struct extent_buffer *eb;
-	int slot;
-	u32 item_size;
-	unsigned long offset;
-	struct btrfs_key key;
-
-	if (!uuid_root) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	btrfs_uuid_to_key(uuid, &key);
-	key.type = type;
-	ret = btrfs_search_slot(NULL, uuid_root, &key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	eb = path->nodes[0];
-	slot = path->slots[0];
-	item_size = btrfs_item_size(eb, slot);
-	offset = btrfs_item_ptr_offset(eb, slot);
-	ret = -ENOENT;
-
-	if (!IS_ALIGNED(item_size, sizeof(u64))) {
-		warning("uuid item with invalid size %lu!",
-			(unsigned long)item_size);
-		goto out;
-	}
-	while (item_size) {
-		__le64 data;
-
-		read_extent_buffer(eb, &data, offset, sizeof(data));
-		if (le64_to_cpu(data) == subid) {
-			ret = 0;
-			break;
-		}
-		offset += sizeof(data);
-		item_size -= sizeof(data);
-	}
-
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
-int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
-			u64 subvol_id_cpu)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *uuid_root = fs_info->uuid_root;
-	int ret;
-	struct btrfs_path *path = NULL;
-	struct btrfs_key key;
-	struct extent_buffer *eb;
-	int slot;
-	unsigned long offset;
-	__le64 subvol_id_le;
-
-	if (!uuid_root) {
-		warning("%s: uuid root is not initialized", __func__);
-		return -EINVAL;
-	}
-
-	ret = btrfs_uuid_tree_lookup(uuid_root, uuid, type, subvol_id_cpu);
-	if (ret != -ENOENT)
-		return ret;
-
-	key.type = type;
-	btrfs_uuid_to_key(uuid, &key);
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key,
-				      sizeof(subvol_id_le));
-	if (ret < 0 && ret != -EEXIST) {
-		warning(
-		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
-			(unsigned long long)key.objectid,
-			(unsigned long long)key.offset, type, ret);
-		goto out;
-	}
-
-	if (ret >= 0) {
-		/* Add an item for the type for the first time */
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		offset = btrfs_item_ptr_offset(eb, slot);
-	} else {
-		/*
-		 * ret == -EEXIST case, An item with that type already exists.
-		 * Extend the item and store the new subvol_id at the end.
-		 */
-		btrfs_extend_item(path, sizeof(subvol_id_le));
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		offset = btrfs_item_ptr_offset(eb, slot);
-		offset += btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
-	}
-
-	ret = 0;
-	subvol_id_le = cpu_to_le64(subvol_id_cpu);
-	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
-	btrfs_mark_buffer_dirty(eb);
-
-out:
-	btrfs_free_path(path);
-	return ret;
-}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 26cdae92..ec81a46c 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1133,8 +1133,6 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
 					   u64 *subvol_id);
 
 /* uuid-tree.c, interface for unmounte filesystem */
-int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
-			u64 subvol_id_cpu);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			   u64 subid);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 5d98ab69..9f824727 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -769,6 +769,65 @@ out:
 	return ret;
 }
 
+static int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid,
+			       u8 type, u64 subvol_id_cpu)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *uuid_root = fs_info->uuid_root;
+	int ret;
+	struct btrfs_path *path = NULL;
+	struct btrfs_key key;
+	struct extent_buffer *eb;
+	int slot;
+	unsigned long offset;
+	__le64 subvol_id_le;
+
+	key.type = type;
+	btrfs_uuid_to_key(uuid, &key);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key,
+				      sizeof(subvol_id_le));
+	if (ret < 0 && ret != -EEXIST) {
+		warning(
+		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
+			(unsigned long long)key.objectid,
+			(unsigned long long)key.offset, type, ret);
+		goto out;
+	}
+
+	if (ret >= 0) {
+		/* Add an item for the type for the first time */
+		eb = path->nodes[0];
+		slot = path->slots[0];
+		offset = btrfs_item_ptr_offset(eb, slot);
+	} else {
+		/*
+		 * ret == -EEXIST case, An item with that type already exists.
+		 * Extend the item and store the new subvol_id at the end.
+		 */
+		btrfs_extend_item(path, sizeof(subvol_id_le));
+		eb = path->nodes[0];
+		slot = path->slots[0];
+		offset = btrfs_item_ptr_offset(eb, slot);
+		offset += btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
+	}
+
+	ret = 0;
+	subvol_id_le = cpu_to_le64(subvol_id_cpu);
+	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
+	btrfs_mark_buffer_dirty(eb);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int create_uuid_tree(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-- 
2.41.0

