Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2F6F2663
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjD2UUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjD2UU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11B2701
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fc1824f0bso16725877b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799627; x=1685391627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6tSDbopNqV00viv7j7TC+sCDwehceS4885UdmKt8xY=;
        b=3Zw4tn+VfShSf7l/1aG/Yh60aEEGJNMaBBXe+9/45IwJKPVzA7YBktJapjTwogi5Lr
         3I6Mwa12CQWVwE9pOq41QuLN8TcOiHbnOqqBT5J+caxowom636thjEjDjmSP3WGx93Yw
         TD+sEtIHa7qNACfUS56zffFXMqBQITaK5epfJoV0LqpoAAUd/iUv+v3JJCwveuhnSmEO
         PIGTRF2OHyM2C4XRPVYzPZve5At013718+1xwr7OUJThobB0W0FN9E6hsECdVKKqTo+r
         f8VfR0ZxpiV0wBJNqR5iv/kqsjJTnsOVdNvmWAZZVmJ77TfPwqK+yO0UTcsC2oskZgyJ
         2Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799627; x=1685391627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6tSDbopNqV00viv7j7TC+sCDwehceS4885UdmKt8xY=;
        b=CTxQlPOfZqfc3jfW1yj4j974buryvK1GA5fs3odCY/NjTMVLCi/LRNMNRslSbQMrff
         sBKd5WqVSpHPR3cxQoGfmf4P8H8CJRMjWouIpHCgnY3bq8cCrm1zBn6EyGeu6E4iB0fh
         2bibgo7Hxcs5pfft73gmzkoOrsP5anRBTxMZ/SqgwQnAZaQFiAR4AKA3gO2rw07A+spV
         EZ5qypLc1JNNRA1eyU94Ur1D8I3yJ17tqWMgXf5Pr8D7p076s2nfHg3D43SzEutLF7i6
         KarSCIfH9EhxZA7MHsN6mKUSvsMNuYi0R274FDMHs6o7oiJV0O8ICi/sRs1hhG+SeFWp
         y/fA==
X-Gm-Message-State: AC+VfDzihi7nhemklmKNJbdvuiAKk6yHsw7YSIrZbyBaPdXpYUguXaD8
        BxROySJXLCMSQT4fFDeVbJuM4AbsH46tB4H/s9NwPA==
X-Google-Smtp-Source: ACHHUZ6VRDDOEOyYVFrgX30V7+kLDuDtG3qCJEXgVRmbexk7AN2uGEZEC1lJMSbIMYK2hpPTC1DliA==
X-Received: by 2002:a0d:e84f:0:b0:54f:b9bc:bd31 with SMTP id r76-20020a0de84f000000b0054fb9bcbd31mr8337867ywe.29.1682799627247;
        Sat, 29 Apr 2023 13:20:27 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u205-20020a8147d6000000b00557027bf788sm1681868ywa.74.2023.04.29.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/26] btrfs-progs: move btrfs_uuid_tree_add into mkfs/main.c
Date:   Sat, 29 Apr 2023 16:19:51 -0400
Message-Id: <b57485a52326eb336df44cc0ac05b0bc503ec274.1682799405.git.josef@toxicpanda.com>
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
index 327ff40c..9cb58908 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2918,136 +2918,3 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
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
index ce1c3d25..40b8854c 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1130,8 +1130,6 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
 					   u64 *subvol_id);
 
 /* uuid-tree.c, interface for unmounte filesystem */
-int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
-			u64 subvol_id_cpu);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			   u64 subid);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 88fea33b..a008f139 100644
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
2.40.0

