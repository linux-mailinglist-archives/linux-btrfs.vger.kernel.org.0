Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7064D465524
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352247AbhLASVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352255AbhLASU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:58 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4B5C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id a11so31945615qkh.13
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v4FABLQaO1+JZ6SjwMvWfD+bmFkhD+Xzd02HcEUXRyY=;
        b=NSPvlskMaDMYlzvVSgIGymiTy41/Igz36QdADAhpfRRwrt/92sbF/Etjfl/wnw4WvE
         3L38heW3UC6zjbLCarXvEYmoVz9cFF2Hv1DMLSdvmFd2NIeDsfP2UdL7M15D2fEI1+2S
         H69B+kArApFNQ3EC5jZvzoWLogI1qIbKRUdbm7kuSaU0Y+ro+LdG7Wctn+bjtTAnBW9+
         GTDwwWeQNlYU2s/JMaLNNIWsizJD8pqvqxefkS0LJ8OPAm5qc9WNGg9mYzXqG/UEGli1
         ZheMGlm/WfUOIgLf5VMfvghF0M59DKP0JNU9dtgElm3Z2BjK4WGQdUKBVxxJcpaeg2Mb
         lKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4FABLQaO1+JZ6SjwMvWfD+bmFkhD+Xzd02HcEUXRyY=;
        b=j8hClyM+DdpBR43R9/SVoDh64ax4mxQAXmO42QooD5JE8UquVKhgiMTt4tIKhI17zx
         H4Tyfll2H0EKlLX+3kziO2m+1Oj7Quo6It10D/9kWkgSvCI7wsOWUdl0Wx4x4we7orW6
         S2Pc/lkn7GtvkK6VMzUEMkoQALlRPTlPlOa8X/3iBLxO/MCsBe5GA0vznBNQbmLMapqA
         PlRWJr6h54ia5QLVqli9BGdJS1mD5SQiCeuH7s/jQL09Z2crGsHMo0twdZ6pkRP+7F7m
         DQi5J2Dp9WZjgH0GMCGn1dhW4tMK1vzLxkpslC+7gcRE7A/9DhOJS3p4FU26rpqg3OGH
         2Shw==
X-Gm-Message-State: AOAM533zJJa1jNIal4y3dVxUfpA8kCkZrjYFF18dAAV3hd6ZeFaQOKTS
        3/9fI7gJVzZ6wOh1tNAisvz26Ve+/YD0vw==
X-Google-Smtp-Source: ABdhPJy4fOQxL0otgaut83jV4NLsMmWZcD+uXzSRIzsfBx8iimD0ERb8gjlF9zrV3iAVl+jHaX9r9Q==
X-Received: by 2002:a05:620a:2239:: with SMTP id n25mr7707399qkh.758.1638382655905;
        Wed, 01 Dec 2021 10:17:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y18sm323230qtx.19.2021.12.01.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/22] btrfs-progs: check: add helper to reinit the root based on a key
Date:   Wed,  1 Dec 2021 13:17:07 -0500
Message-Id: <2c51d6b12e40cd31a505db8bea5210d37c0ef067.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the case of per-bg roots we may be missing the root items.  To
re-initialize them we want to add the root item as well as allocate the
empty block.  To achieve this extract out the reinit root logic to a
helper that just takes the root key and then does the appropriate work
to allocate an empty root and update the root item.  Fix the normal
reinit root helper to use this new helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 88 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 30 deletions(-)

diff --git a/check/main.c b/check/main.c
index 4b7b52b5..97cd3249 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9103,29 +9103,34 @@ static int do_check_chunks_and_extents(void)
 	return ret;
 }
 
-static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root)
+static struct extent_buffer *btrfs_fsck_clear_root(
+					struct btrfs_trans_handle *trans,
+					struct btrfs_key *key)
 {
+	struct btrfs_root_item ri = {};
+	struct btrfs_path *path;
 	struct extent_buffer *c;
-	struct extent_buffer *old = root->node;
-	int level;
+	struct btrfs_disk_key disk_key = {};
 	int ret;
-	struct btrfs_disk_key disk_key = {0,0,0};
 
-	level = 0;
+	path = btrfs_alloc_path();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
 
-	c = btrfs_alloc_free_block(trans, root, gfs_info->nodesize,
-				   root->root_key.objectid,
-				   &disk_key, level, 0, 0);
-	if (IS_ERR(c))
-		return PTR_ERR(c);
+	c = btrfs_alloc_free_block(trans, gfs_info->tree_root,
+				   gfs_info->nodesize, key->objectid,
+				   &disk_key, 0, 0, 0);
+	if (IS_ERR(c)) {
+		btrfs_free_path(path);
+		return c;
+	}
 
 	memset_extent_buffer(c, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_level(c, level);
+	btrfs_set_header_level(c, 0);
 	btrfs_set_header_bytenr(c, c->start);
 	btrfs_set_header_generation(c, trans->transid);
 	btrfs_set_header_backref_rev(c, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(c, root->root_key.objectid);
+	btrfs_set_header_owner(c, key->objectid);
 
 	write_extent_buffer(c, gfs_info->fs_devices->metadata_uuid,
 			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
@@ -9135,25 +9140,48 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
 			    BTRFS_UUID_SIZE);
 
 	btrfs_mark_buffer_dirty(c);
+
 	/*
-	 * this case can happen in the following case:
-	 *
-	 * reinit reloc data root, this is because we skip pin
-	 * down reloc data tree before which means we can allocate
-	 * same block bytenr here.
+	 * The root item may not exist, try to insert an empty one so it exists,
+	 * otherwise simply update the existing one with the correct settings.
 	 */
-	if (old->start == c->start) {
-		btrfs_set_root_generation(&root->root_item,
-					  trans->transid);
-		root->root_item.level = btrfs_header_level(root->node);
-		ret = btrfs_update_root(trans, gfs_info->tree_root,
-					&root->root_key, &root->root_item);
-		if (ret) {
-			free_extent_buffer(c);
-			return ret;
-		}
-	}
-	free_extent_buffer(old);
+	ret = btrfs_insert_empty_item(trans, gfs_info->tree_root, path, key,
+				      sizeof(ri));
+	if (ret == -EEXIST) {
+		read_extent_buffer(path->nodes[0], &ri,
+				   btrfs_item_ptr_offset(path->nodes[0],
+							 path->slots[0]),
+				   sizeof(ri));
+	} else if (ret) {
+		btrfs_free_path(path);
+		free_extent_buffer(c);
+		return ERR_PTR(ret);
+	}
+	btrfs_set_root_bytenr(&ri, c->start);
+	btrfs_set_root_generation(&ri, trans->transid);
+	btrfs_set_root_refs(&ri, 1);
+	btrfs_set_root_used(&ri, c->len);
+	btrfs_set_root_generation_v2(&ri, trans->transid);
+
+	write_extent_buffer(path->nodes[0], &ri,
+			    btrfs_item_ptr_offset(path->nodes[0],
+						  path->slots[0]),
+			    sizeof(ri));
+	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_free_path(path);
+	return c;
+}
+
+static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
+				  struct btrfs_root *root)
+{
+	struct extent_buffer *c;
+
+	c = btrfs_fsck_clear_root(trans, &root->root_key);
+	if (IS_ERR(c))
+		return PTR_ERR(c);
+
+	free_extent_buffer(root->node);
 	root->node = c;
 	add_root_to_dirty_list(root);
 	return 0;
-- 
2.26.3

