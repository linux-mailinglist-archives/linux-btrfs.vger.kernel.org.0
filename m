Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55744CA63
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKJUSS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhKJUSI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:08 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F2C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:20 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id gu12so2633378qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qm6QdLoaHt3GIfEOPEVQJ1gYB6ReYMf83vFJ1g2HpPQ=;
        b=jHJOW5l+3RynYyBNMKrQrs7fW9ecyc5XzRXuLTaeeaNCeneOQkhO+B1VK8M9Q5Kw9p
         UT8yzgPvuvwBSN6pV5TcjnA7W3Cz4AGqbdtCYQSO3ZUQX6VIOQVggMXPiPYvbliV2b7J
         4p8/DGm5G7jJx6t2Hl/pmec2yQyAnO8kIU+L1T6eEN+2UB/sEIF3MQhDNZlTPF20FCnv
         C38/tYr63HZPMH6CTV7TYNW5IYLate74Ko0ev4NXcmcApjb7ZokNiQJBawLwMiXWylQH
         cUELPsf+wIGM/VsLN0MfsVPQ7zYOANnlCXeESmdrGAj857XOV3lOQdrIImTxWzVfoX2p
         ZC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qm6QdLoaHt3GIfEOPEVQJ1gYB6ReYMf83vFJ1g2HpPQ=;
        b=x+sDsALEvAqx26SVww9s5uC9F7HK49JPNjm8bKzpgkXoKKqtz4yAtAs8Qr/5SeDLuS
         7QJs2eUNKBC7orKjHOluDA6qwVg6eayaMXJsrfSXmB6h+iPcc5GhtTk049BsyLSG0fif
         kLKd+W/RvIshdhfnkaUSdBnNwNMiDzkIRfUhSsiuGJDsEvlYLvc8lDknrvx8onuxeV0H
         rKYpUqQRSqu0oLn4ew/1I+ZXHeW/3PANXqb+Erof85GmqkMDNk1YU8azJuY9OBG9jgXE
         l9t2cPegh+RaCI45nCjfBZH4n98HzPeF4ER8QAL7QWcYebVuPIGmotkSaboQuLSDnjYx
         lVdQ==
X-Gm-Message-State: AOAM532Gd6Lx3H8jML/PzSxs9UufssrRTpbAC0us27Vy1ggQJRYeVCiH
        ryya2C25JB4G1IH7wFP/imAgQHgP4/rekw==
X-Google-Smtp-Source: ABdhPJy+nHaoIL85UcwS/A61W534jvJMBMHeePzgDuKYBSW7FWIhvRg4g5sEG9+2Ri+yjcBMD2dcpg==
X-Received: by 2002:a0c:ecc7:: with SMTP id o7mr1550192qvq.46.1636575318951;
        Wed, 10 Nov 2021 12:15:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d3sm515658qte.4.2021.11.10.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 21/30] btrfs-progs: check: add helper to reinit the root based on a key
Date:   Wed, 10 Nov 2021 15:14:33 -0500
Message-Id: <eda23540e3c28d9cb5a13409fb898d85d6669ba2.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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
index 6252a890..d2d27694 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9090,29 +9090,34 @@ static int do_check_chunks_and_extents(void)
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
@@ -9122,25 +9127,48 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
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

