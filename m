Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542192CC71A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbgLBTxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388416AbgLBTxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:02 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99EC08E860
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:07 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b9so1535381qtr.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kUo76fLcAsALSQirbMUNUbbQZPoQ0cgMX4qI4IVPrQg=;
        b=gDhK4AlaM2vUrGnNyf8Is831BKGqTqbOsx2XBmqtotk+FG2+7UJnGFrtK8HjFEoJbQ
         bLfwieEdAHKkgf1DYDcdC+RxdiHDxmzjklQ/fFYHRmIs+l4gFT473j3ASmifOZWm9vfK
         gUhnlYW2VXS4cEMrYFQDfH88aido4uW91u5LMrUxp7uSvKaAFnfL9IQ3ByYb+j55vPP5
         FkUOuFMaBSxQCbG/bmbdyS4SOo15XGXFdvdlwAFZ1WNViFyAsGAX8G/hcb1Abvan29Rj
         80h/ke8IRmJE2uR3hTBIl5CGV8MlR8/l6zgyAGOMy1cIxXeV5lU5gFQxzd47B4xQ7ET6
         mBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUo76fLcAsALSQirbMUNUbbQZPoQ0cgMX4qI4IVPrQg=;
        b=b7xPQ36AKFCpMuI2YTmsgvXPSc8fvoTfCxD7j5uIFGO+RWCRO01ydTYXdkdlGJ7kek
         6enKMAaYKZn+aF1gghyMoHnfNZSPzVJLR5NajGbWsbrXeduzRaWYJ33OxkMkeV5Vl9Yn
         OE5FmmguI5tAO5NyBXQMFW1IBiQJy7+bFGUMKA4JJHxglWzIoT410ZzgbSzvdloMeo8C
         3isP98JtRTPa6EaRENFPLxAoG/rsxxChQXUOrMkAYEaFPwq05Lnb9E79y/PgNC/jPd/O
         PyAl//uUwK+t80Rrte/fSv6f3BnSnVXv8YcGlcXINfYlIs+kuldETmUCzqmVRFYkEmsv
         +wmQ==
X-Gm-Message-State: AOAM531ZC6ChXXCw6/hIlArejrlj2kAzLg3XR5eErg47hidnr5upo4ud
        +d+nxNUmfClOZC2UWOykyPu9nHng6c7pig==
X-Google-Smtp-Source: ABdhPJyMqAMmP7nGfeQuplQ4tFC5UAQZXTLmjrbzETQklfXJiW4eTtdMOLOrpX+BtnqbO3PSGzrHkQ==
X-Received: by 2002:ac8:590f:: with SMTP id 15mr4346637qty.249.1606938726690;
        Wed, 02 Dec 2020 11:52:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm2640983qtr.68.2020.12.02.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 29/54] btrfs: do proper error handling in create_reloc_root
Date:   Wed,  2 Dec 2020 14:50:47 -0500
Message-Id: <045a0b4cb56d0d79728ad98749a022cdf664ad5a.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index 6d3a80d54b32..cebf8e9d7d96 100644
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

