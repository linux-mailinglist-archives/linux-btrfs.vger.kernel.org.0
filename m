Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3A2DC430
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgLPQ2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgLPQ2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:34 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C480C0619D4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:30 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 186so23039904qkj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LGBWNIae8x0J9BTYl7NZFiSo+OeiK7hMCei4zljFakQ=;
        b=vJ1Q/+AH1FkZU/iBgIylOyB7LGseiqU5wIiIpvWd/YynMmFzErY/GZY463GoSUdFg4
         cYqVbpsXgBacmDbgvfkwTNWfPF8SgYWma/dqrnL1/T2+5IIqWwQzd5qqHgwQQNGjlVy7
         b9DqhlygMgahz9JJCe8ouzo2pnkrKdv1+YMRfJDB/jvKp0TBGMmm4Bh8wvw3fh64ksQY
         a4vSIDy37fGAuQvrFdT57/1NCKlQ4sr9mzsxtVlVWJ8vSc/3nlH8Ej+eQUe3FyzSjF8T
         JrPfI36txUR3Ci/wvlznewjclmU2rVmo0BTuEli0UHGBScSZNNDYnwgSJ5XDM58DJ5OA
         YyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGBWNIae8x0J9BTYl7NZFiSo+OeiK7hMCei4zljFakQ=;
        b=rVhnBmtKUtw3tOWZEKQz7fsIj1/xCfhM4plUwDWvc/f9nIB/zeE4U1vFQV8ix+dXZF
         FFefjtdq8pPHkBlIYw16TEPKU8MJ4sBMzeVn97PO3rBJNqG3vL1aDWayPaO8c4R1Nori
         0lynhazkUDJHF2boUn46jnEZFklbPwlCcMqBI2RM6Q7G2GAltFaJ0iLL1B0sQrxHWUbP
         Un6R1A5Bk6bZFOzza3SNV5q6nR8s5DxkIqCLU9o+ll6Q52dCVYDS5sf+g3z7kEymIE8F
         ew/e0LtoxKohCb7W4MmGtZFeuLdn1zL7zygceU1cZbAu1R+dg+ksdXh9s6j2GdGukYOq
         +xuw==
X-Gm-Message-State: AOAM530IWxaTAOvIF2jBtjm82oszBlf+vs8FGANz+zRY7gsMqlxpOcTW
        BiKqT2pOXd83xatknU0CoQwtbWGIMfTcYNV6
X-Google-Smtp-Source: ABdhPJwZpA2CIzpIYH8NIKdDYJPTC3avK2G48b68tb/L6x0/TFHdo/NHlJDdCgTB0qEzOeVsKbwsCg==
X-Received: by 2002:a37:7bc1:: with SMTP id w184mr46143537qkc.190.1608136049317;
        Wed, 16 Dec 2020 08:27:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm1284064qtm.66.2020.12.16.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 19/38] btrfs: do proper error handling in create_reloc_root
Date:   Wed, 16 Dec 2020 11:26:35 -0500
Message-Id: <a8285838998634e397f52d933ebc8c9de313d0a3.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do memory allocations here, read blocks from disk, all sorts of
operations that could easily fail at any given point.  Instead of
panicing the box, simply return the error back up the chain, all callers
at this point have proper error handling.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 126655b199df..d5740acaaddf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -735,10 +735,12 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	struct btrfs_root_item *root_item;
 	struct btrfs_key root_key;
-	int ret;
+	int ret = 0;
+	bool must_abort = false;
 
 	root_item = kmalloc(sizeof(*root_item), GFP_NOFS);
-	BUG_ON(!root_item);
+	if (!root_item)
+		return ERR_PTR(-ENOMEM);
 
 	root_key.objectid = BTRFS_TREE_RELOC_OBJECTID;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
@@ -750,7 +752,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 		/* called by btrfs_init_reloc_root */
 		ret = btrfs_copy_root(trans, root, root->commit_root, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
-		BUG_ON(ret);
+		if (ret)
+			goto fail;
+
 		/*
 		 * Set the last_snapshot field to the generation of the commit
 		 * root - like this ctree.c:btrfs_block_can_be_shared() behaves
@@ -771,9 +775,16 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 		 */
 		ret = btrfs_copy_root(trans, root, root->node, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
-		BUG_ON(ret);
+		if (ret)
+			goto fail;
 	}
 
+	/*
+	 * We have changed references at this point, we must abort the
+	 * transaction if anything fails.
+	 */
+	must_abort = true;
+
 	memcpy(root_item, &root->root_item, sizeof(*root_item));
 	btrfs_set_root_bytenr(root_item, eb->start);
 	btrfs_set_root_level(root_item, btrfs_header_level(eb));
@@ -791,14 +802,25 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_root(trans, fs_info->tree_root,
 				&root_key, root_item);
-	BUG_ON(ret);
+	if (ret)
+		goto fail;
+
 	kfree(root_item);
 
 	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
-	BUG_ON(IS_ERR(reloc_root));
+	if (IS_ERR(reloc_root)) {
+		ret = PTR_ERR(reloc_root);
+		goto abort;
+	}
 	set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
+fail:
+	kfree(root_item);
+abort:
+	if (must_abort)
+		btrfs_abort_transaction(trans, ret);
+	return ERR_PTR(ret);
 }
 
 /*
-- 
2.26.2

