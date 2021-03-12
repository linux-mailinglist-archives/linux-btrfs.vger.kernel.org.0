Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA033984B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhCLU0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhCLU0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:06 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F6C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:06 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id f124so25703222qkj.5
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h51HKjvSwZwcjHKwCE1dICIdhxsev+5lZmsHrATpgj0=;
        b=QyO+Mg9QbsHwfBjSx4s42wO3Bw+d0wTt6fIAZtcwgDNdr67/pHYAzfyPseF3Pi8qTi
         rbKNWGUYMBgAid4Ebhszl4WH8paRm6/GLnkoLgCDYN/P/JLZRorpxj7cI1H8xJ83j8Br
         qEP9RlgTGmGx8UfbT37nIUXDn90K+ZQUQpzepMRkNThJ333BF+Ro7bbyPOW6wZXhrKQz
         rpY6pRp34t7uSyBGGMbv6slD/WFHBLWfxEkAjJIYRku09DNWalTBJd2ytszZE5XA0t15
         x8TebWuAsHZF0g/00xFPxGCHPcxdwl0ONS9sY875uFJY/pgxSYrM5cgMhIPK4X/fcil+
         9Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h51HKjvSwZwcjHKwCE1dICIdhxsev+5lZmsHrATpgj0=;
        b=le73GjcAqqwUFSQehIOAcmUYdCkGeHr+UjN7VSPfsYerSGHji9nKN/TnQ3q4HuIjFX
         2vX5dkrS07ig3+PuLxjgVs+sOnveSkuMitNPxMfPEqfkwoHe4DQntQeY5GvrKqTzEzqo
         ddZ8dg4U/Rhua0rFtABZNNdGCTX7a7XwXy9/fGCVBWYQ32AwIop+HGdJwAVdgM7MsuWy
         wr/g7taEy+cCOU4CoHoS88rJZrbt/R6GBDSYOG+0B6VBNYd3Y+Vygm8c0hfHs6xkLUEG
         6mkF+TBR/n1+mqqGZ/5tWOKFZNs2hxhRF6pMbcDkR5i/qPqyJCpKrUlOyq3UaPlBL1fn
         WCeg==
X-Gm-Message-State: AOAM531g+q1UfLz1RW+2NucswYv2c1ocsfpAZXIhsZgwoTaoSeKvp2EG
        COH9LVGGrJtJG/ifjrLMf61U/KKCbAqvA56l
X-Google-Smtp-Source: ABdhPJyGclaC2weupM3pEFFjwWPliw8XIZqz5cXTWJedIjjI0zhdARFm6SiqJi90A0Sn9ggNIrkMoA==
X-Received: by 2002:a05:620a:914:: with SMTP id v20mr14652042qkv.140.1615580765590;
        Fri, 12 Mar 2021 12:26:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w197sm5093952qkb.89.2021.03.12.12.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 19/39] btrfs: do proper error handling in create_reloc_root
Date:   Fri, 12 Mar 2021 15:25:14 -0500
Message-Id: <2b29546ebb077bccec07015e05bdce675d66d1b7.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 9a028376f475..df26d6055cc6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -733,10 +733,12 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -748,7 +750,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -769,9 +773,16 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -789,14 +800,25 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 
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

