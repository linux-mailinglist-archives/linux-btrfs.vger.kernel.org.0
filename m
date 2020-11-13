Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FE2B2044
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKMQYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgKMQYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A423C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so9309420qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=seayDYayWZruwlxUNekZRyTHJGTyUHBpcTOYmzLYgGI=;
        b=K0fys/hWSr+iSlIhFa0DuJdi/HZ+TXbluvn3ecJ0mD3f73EPym7miOU6fhnlUOSF1/
         ba0XWGCexs1tTOMUOhvUI8YmXTC/VtOeivebm5WzAjQ0xBwiBPtgGF0sY3ahe5twETj8
         nrf6Qvf+kp4Y1iOwjNgqNJxC1uc/1+MhLYP9zUEF21FF3F06w2tltIzUt9Lc5mfSkWb4
         nA1c7J+giAnBF6/ihTwi57oi9tWvgt25WW6Go6MwiXZVsowCh0qwkh9d86cM5x0DNs+Z
         jWbJTTQHuX+57tzhDtqg7pNzzujIx8bzXJJ58aorZHkhR/HzfYsfyaWwxIGOvB6QdRwR
         /oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seayDYayWZruwlxUNekZRyTHJGTyUHBpcTOYmzLYgGI=;
        b=nTaYRA8lOTGKQkTU061tyvQlRQsCXBrf7Nh9vaYP4aoSf/zuWd2RQogRGKB9ZswrUG
         aMVqcx5GsCYhaU7nbQtH8OBSIjr1KOKRN2gcVZqZwsuoZ7GJpG1aw/o9ebnJV0vrDYa7
         AuEAIvQey5eCrca5Ky5YsYgSl8FRz8ol8wLnda0+eIzKsadYLwS/wcqz2VOAgy4FjDEG
         6XPxi0ftwDXTXSA05Bu90HdgPckZZLHi8OHazYvByrIQDocLT4IM6OUgzALDa8FhYAZC
         0GpZpFysZX4Ima7EgXfKkFtezLUhn///CaCZYfqOm/6Atlx/50AZ1WK6yE1Ui2KW239/
         ooCQ==
X-Gm-Message-State: AOAM5327pPMFcG2zaIvj2drKzHMzr3zSTCr9g/8SMJYxW4hEG4apEzih
        rAo3zrIpBvLmbTA+DfVt8hTjIMbyXgvyxA==
X-Google-Smtp-Source: ABdhPJyGemfeyNFqMyx4DkM/5uf9OQ8EPL84LmRZ4YgIM+6NR7qzOiEOHegWFYqMaO0BUmwQx7EKPA==
X-Received: by 2002:ae9:ef82:: with SMTP id d124mr2651236qkg.480.1605284655922;
        Fri, 13 Nov 2020 08:24:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h11sm7007329qtr.13.2020.11.13.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 22/42] btrfs: do proper error handling in create_reloc_root
Date:   Fri, 13 Nov 2020 11:23:12 -0500
Message-Id: <3fc6ab803c8dcd2a387a8b566815004b18e5cc89.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index 4afba27419f0..2ae1a3816ce5 100644
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

