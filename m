Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD332CDD6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgLCSYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLCSYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:52 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3447C061A52
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:54 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ec16so1450857qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z53JWTRrA00gsfSkVqMYxS1g8LLxe9WIsLGcmEtddno=;
        b=jTK6a//PzmgyQjcIJd7KvmIuRgjVG3sqJ1lMxbQ5PAB9BqWAFqi69p4MFu3W4Cn+Xg
         BajSyta4zEqLQz1d513uMCfh2o+CokKNP6KEzcBtEXXmcxzu0q5xwfKqp9W0fQmdAAOf
         Hjiyyf9YDSNaWD/sTXzsTX4sAvvpwXx8kRGsFkfoUxcBg/m97fx3TcyL2Sv3Ny4j8CAl
         gWnCf6WhUuYynKbzxM745BEhIQRxO/HP1r7PHvgn9HFWseOh2dKwf/IZ+WNyJwQn3UaH
         PTYPpI7qfSxrrqMwixzZYyWDkJ5BEMKX0DqapITEswrDXDdZhiBEolby1i2pBtJk1sAc
         kvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z53JWTRrA00gsfSkVqMYxS1g8LLxe9WIsLGcmEtddno=;
        b=ncJvmS46lpzP+cXz/7+qK3Y0z4pmPzBK5fbbFVLG6U4D/0WmXOe9pWcUV88SRxyOg3
         89gL3Nx55UraNgEmYJ5hUpTjf6bdOQ4GAqah177hIMx+qm4QFIvuCLC0GBLmenL6Tww7
         AZ7zOI2uGoG0FIz22+1dep1BOIHY4nrtsRD+DQ0lCNHDkBkjmHuCGmdeRqDXB06C0KP7
         gRBqQZbM51EYTqbElmiGhgr5BBqVdQ1sZRFFh1pqGnBW6n3PtXrotr6SsqjYhBJtlRGf
         FhQDwwxGJ6njZMraQymOZm23YaJYQZha2k9q6PoxX2NnehJ9NCG22fyVl6pMD2Nt/rpN
         ymQA==
X-Gm-Message-State: AOAM530+YFI4AMIYDVAz6twSKvRlPE6pgkoM5IugNVn6WwQSwPkQS6IB
        8IMReG9EjYrhUXDpl3fHbjm9+DvpyqHmDwuE
X-Google-Smtp-Source: ABdhPJwp8dhG3+WNfRJhYayVNve906wRQKLg1IwlU08As2FY8ynZ0HDYi+fy71gPeATocZqC0c9zXA==
X-Received: by 2002:a0c:a9d0:: with SMTP id c16mr173387qvb.5.1607019833542;
        Thu, 03 Dec 2020 10:23:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e126sm2227217qkb.90.2020.12.03.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 30/53] btrfs: do proper error handling in create_reloc_root
Date:   Thu,  3 Dec 2020 13:22:36 -0500
Message-Id: <6e4ab12fa0b551a422e150876eb0ed9c121473f9.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do memory allocations here, read blocks from disk, all sorts of
operations that could easily fail at any given point.  Instead of
panicing the box, simply return the error back up the chain, all callers
at this point have proper error handling.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 265b34984701..627c1bcfdd33 100644
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

