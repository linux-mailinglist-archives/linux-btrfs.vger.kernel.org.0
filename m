Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACB476273
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhLOUAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhLOUAM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:12 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4BC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o17so23083284qtk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3fhNjTULsHYsTF6spoRGmk5ha2fFnaTT6mkAilTt5yw=;
        b=h9fvNF6L9BQsGd8RzBsUfGAydMF4RGIUg8e6b+zqLdfv7rsIkiJkwnO5sMK6EByFiH
         LQAoOylOcOP8R5ATSFqfwiO5dmlDyqVUlcW/fA9Lop9DP4rRKHUTcOYvd/Fk91Tx/HZ9
         sBFU0qGK3B2bsuzlq2s3CpIo6fDZ2EUxSAP+ITl9U4T1WAa8MxtniDaNcc7SDyFgNC8g
         IWDSQgyxyz5hTGbtZZuMCR/QyWqXDTdTTNmT0Hn0cTqxQOyzQ9zPHZR9GPcbMHCTusjd
         IYmU+jeEl3erDJLyuvBZiR2adWnIa21ip6fmNTHe3Z3JmI3CT290AM3sH5kOTUGtdjiW
         OWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fhNjTULsHYsTF6spoRGmk5ha2fFnaTT6mkAilTt5yw=;
        b=Yp/I/h5lz6yDSQLB2R1Kw3Vb1evCgnX13hIB+W8sN+eeELqlEjYTcITBFPSWMtYyfu
         Mhwra8YldBns/H4rDpY7gMXMXMDXMJhhDbIfj1I/9EMY02Kqa94PiVsdqDQVwvu4iX+l
         dM5Wc/taBKUNBfxqQmvyJqm/ioWD7gxoz2yAX9e4pchfXbr9EOXNAUHIYH9hlryAkuz9
         D3JTzwHgctY1QNFvZUWXwv9NtqGOF+psyh+RgQ1OmHpVoVpM57jTamHx6Y1j9Esvs/+f
         YQOG7LiIPonrM07I6vsH7QzRT/7ZIgOV+bVcFLC1MzRHmwmlHFGstcMbPVC9sos+IFSs
         4uIA==
X-Gm-Message-State: AOAM532HT9FjZFDRLCPglzCLOZmW05gF5/2sWItNoUzdNKescs7r+m0h
        pChJ4Wo+KgYp+BdMw4mzSkvhrtUIAFgp0A==
X-Google-Smtp-Source: ABdhPJyrbwJriVYvX5irz8s/ArA8AJRCfybbwbXlAtNhPF5ofPXGHwafxWwmW5oiz3tkUdTVbHI3fQ==
X-Received: by 2002:a05:622a:1191:: with SMTP id m17mr13760244qtk.595.1639598410726;
        Wed, 15 Dec 2021 12:00:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n22sm2206604qtk.38.2021.12.15.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 13/22] btrfs-progs: check: add helper to reinit the root based on a key
Date:   Wed, 15 Dec 2021 14:59:39 -0500
Message-Id: <39bae0aad1d2e447a0f98306fadba92a4412991b.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
index 3eea186f..cf3c6af2 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9116,29 +9116,34 @@ static int do_check_chunks_and_extents(void)
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
@@ -9148,25 +9153,48 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
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

