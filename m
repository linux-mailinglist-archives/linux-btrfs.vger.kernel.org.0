Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FC2B1003
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgKLVT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgKLVT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:56 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5124C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:56 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id d38so2232210qvc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NlQ0lylBFjFA02uv+GBL2nLzcL8BmQMHxsgu8VzyDh0=;
        b=iG7b6wOL/77wnhplWmxP09bB622vnsuIdVoskTxRIm/GmtSNqTbhGVmP6XMy97F5GK
         jm2NZiIm6izwcuYv+isU2xQb3BRbdJTxlJUQmH/pLf9kzOMh97+xpU/1L/GbZCFVsULN
         qoJhnzjgktn4XoS2IokSw1t5rqj2grEW9v0KcBWlm6mOFQNZgzSF1zQH6VkZh3STfY5r
         TIMDs1qh6FSbrY91Chlux+/pghsOZS2RCiSflHoDm0ghhJLje8QrfRZnCxhiOxazLaMP
         ruSeHnOUEkE+w5YlTCmOEcbaZuc+aRLsos4vCHlIgx9zS7YgWhjto80SzRiGcbU3lWZd
         6y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlQ0lylBFjFA02uv+GBL2nLzcL8BmQMHxsgu8VzyDh0=;
        b=G/MW2n0upltQn3qsNdg+L5acqBW4yTJPjZJ/9RSacyFVX0wVtAKU0Xz8xId3Y9F4md
         E84KAi6PMGLmuqHfsobCyfwZWRvsAuXut69hiAlt+WPNarZMVODMYYcwXyh/Rs+dDmW1
         F4d3I+f5JVFNDBO1h/wXDRkKuBMHeTGa/0s20Z/uooKqKiKC7K9TfarhmBy/LGnEMJz9
         1rPRmLjzMo3lNg1MGI0ECs/HzyKlMyoa5Wdv+hXZ0x/gPuVW5tsYvsKn7LwSBROMilSP
         wjz+iiUhLcBuxZVjxeDioT95C/7TmmUHviirbHQM/P2DhWP6+u7RNqXBsOiHV5B5r8+2
         6ekQ==
X-Gm-Message-State: AOAM5316uKUuYc08tkWbgF0z7mVtphzopUvdlocwLcxiDduKUQSli0EF
        Xk1id3tWb+BrHseO+uNthFVo7K3ZVbdLGw==
X-Google-Smtp-Source: ABdhPJw9xnbl0CXiIPegT4IBPPOJAYpD1gc6RL9JV3HptV2JXQan+AfnUdF3pwBgegSAPT2pGFz4JQ==
X-Received: by 2002:a0c:e1d1:: with SMTP id v17mr1764198qvl.29.1605215995477;
        Thu, 12 Nov 2020 13:19:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm5186743qta.14.2020.11.12.13.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/42] btrfs: do proper error handling in create_reloc_root
Date:   Thu, 12 Nov 2020 16:18:49 -0500
Message-Id: <5f679c6c689668f0424b15d38881f63453f719c2.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c0be6b1f22cb..d61dc2b1928c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -737,10 +737,11 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	struct btrfs_root_item *root_item;
 	struct btrfs_key root_key;
-	int ret;
+	int ret = 0;
 
 	root_item = kmalloc(sizeof(*root_item), GFP_NOFS);
-	BUG_ON(!root_item);
+	if (!root_item)
+		return ERR_PTR(-ENOMEM);
 
 	root_key.objectid = BTRFS_TREE_RELOC_OBJECTID;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
@@ -752,7 +753,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -773,7 +776,8 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 		 */
 		ret = btrfs_copy_root(trans, root, root->node, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
-		BUG_ON(ret);
+		if (ret)
+			goto fail;
 	}
 
 	memcpy(root_item, &root->root_item, sizeof(*root_item));
@@ -793,14 +797,20 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_root(trans, fs_info->tree_root,
 				&root_key, root_item);
-	BUG_ON(ret);
+	if (ret)
+		goto fail;
+
 	kfree(root_item);
 
 	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
-	BUG_ON(IS_ERR(reloc_root));
+	if (IS_ERR(reloc_root))
+		return reloc_root;
 	set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
+fail:
+	kfree(root_item);
+	return ERR_PTR(ret);
 }
 
 /*
-- 
2.26.2

