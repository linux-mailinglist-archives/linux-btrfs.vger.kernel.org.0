Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520924D0A9B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbiCGWMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245483AbiCGWMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:16 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B798B6EA
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:21 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a14so1682451qtx.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8/s17pySnTOY7r8ZSoMoCAdNx+0AcuV6N3k/U6v7Xws=;
        b=KrepXvgGhHmz6v58uQW55WSE9ANIGOH3Py+g7VQLzDyTRtMjFlCHcMV28ME1cyIXL9
         TRaNEYFRRDVGmLekSkbblEWKNtdsNx9LdQcki+7Ll+RNy9YkTa0Rbs4ia4IJzvM9p7kl
         QYymbOrHZP4RBKbwiuY4hcFR2iIUadDv9qeCc+1qoBd/x1u4xw9WrBX5UnOp+G6UU8XV
         IeMcHNBYY2SdgEFbawA59MiewooKKDXuZVg4JX78S/WyfT7XO5BtVwOkjdwMLv+9pTTf
         N2FV920ms8YzoyER5SWG0VtKdXV3yYoUXr5WtyPCUd9qu8MXEtmZBdn6QzvmKMBQX0U5
         bJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/s17pySnTOY7r8ZSoMoCAdNx+0AcuV6N3k/U6v7Xws=;
        b=QKB4aUZTAr7EvtisV0HPp+BrXZ76d/9duH2NFJI+0ObN6Yw+YE/nBQoF7G5qaiq13H
         77ndshce/Am7uWT4FAQu6xEUV8vgB1RzIEtlo+F3iyjHTi5NDHNW26Mcm5xSfZMrVUvd
         6EJuhWY+oR0J+vAYt7nB6c4jslNevjKPer25lvgx47GVNcB7/TSXBPVBJeDg5/2qGVs3
         OM+vDkT8FLaP21nETlX0kmNxh9dWsya26KOLRWRwyfWjfLuPPjCMof/AjRTu7FVMLTpW
         od2GjyF/OdppmKkGvRMzA19za4kHzXcart/XrkHRqFKmAZ2mwRgGmYgcnyLrjRn7feOJ
         qXcA==
X-Gm-Message-State: AOAM530GAuFE0Ug58WpUXRo6JvM9n1xgNNbNNOb9Ib9jhJalm1TSlV0i
        +Vf5mQS/pn/Ur4n2hRV5JngmTlVgIlxJjml4
X-Google-Smtp-Source: ABdhPJzGMv6vJBBQUpjCHD9Ne5fyji3WqP1fLO7TrIo1rVRy38g7yPAmxpLxFallFPqZ8WvDAvwN2w==
X-Received: by 2002:a05:622a:8:b0:2d7:ae4a:8434 with SMTP id x8-20020a05622a000800b002d7ae4a8434mr11275130qtw.212.1646691080239;
        Mon, 07 Mar 2022 14:11:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18-20020ac85892000000b002de3a8bf768sm9839539qta.52.2022.03.07.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 10/19] btrfs-progs: check: add helper to reinit the root based on a key
Date:   Mon,  7 Mar 2022 17:10:55 -0500
Message-Id: <833a85474a6228f9d653fab4c3f6dc85a3e5b24c.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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
index 9d090fdc..5b700350 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9129,29 +9129,34 @@ static int do_check_chunks_and_extents(void)
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
@@ -9161,25 +9166,48 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
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

