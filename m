Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3212D12D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgLGN7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLGN7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:42 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA285C0613D4
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:43 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l7so9360597qtp.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z53JWTRrA00gsfSkVqMYxS1g8LLxe9WIsLGcmEtddno=;
        b=e1RIwIJpqZYsWFMOw6WBza2f7UC04L04mTAVwRQ1M14pY8VSt8+IL0tNAvGXxJJ7PB
         MnQGwUZNOaQNAFl7J6B7JR4DmrXdKANGl+hmYQlLpZpBMpPHarcePqyGp5v89A1BO2bf
         PSz8mkMmdWr+e5fdjnhh5zmcNcDU2nLzWXfW+/1PxQJ9QNRLibab8qugOKMW95gchgQ2
         +6hVlc6ORZe/W92RrGjDEEUgbJCUzuHpFYy1CAAbsxrIvASdirO4xMJoYWpw1aTcjeQp
         7DYP3IBXX8rEoSlSknqiINh2ha+zFs1a6FfLvSDfM95QYLsnalewJ6IBpo8vB+ml/yEF
         7d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z53JWTRrA00gsfSkVqMYxS1g8LLxe9WIsLGcmEtddno=;
        b=dga2j13JsSwFrix/bhEiFQJ5rjR8JkGUCCxTVGD7zPb2Q7e2oA90YZydEdPYIb0rCr
         T959RPF0y5wFRFKAiQn0zvaBcYlKzLOBT+mBdhTMOTVOBEy14wYniX0pIdq4iPew58gN
         V/Vk8UxVzvljzVEBxW0YA4X+idMgkWLrh/Zoe/w+66obfl3M13tuxe2mhOPEXmu+6H/J
         KRp9qX3Uaha5AMBCNVUzcVfHPR03pp5Zbfh6NC6BXaBM3kb1L4aJmLVVkvV7YKFQgv2o
         pKdbuEHmaQiYuQiGmsFnRCHKVShHIsW+eJuTpupFkWOt0TLMTEmcK+zvIqhqr8SWPczN
         gsFg==
X-Gm-Message-State: AOAM531TAocpaB10ktwxAsgVzNLpllM8syt122+2ATYsIr3vWeDq/IxM
        qJiahnWQkebBATm8oQcIdmwVyfMwaoXlohRW
X-Google-Smtp-Source: ABdhPJww6vRFVwhjdv7p0+s7zsEYpb/NcCvQsoNfmcGbKYids6KS3p6d4JaUlMjKLNTXGXIibKvPvg==
X-Received: by 2002:ac8:6984:: with SMTP id o4mr5196502qtq.46.1607349522845;
        Mon, 07 Dec 2020 05:58:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l5sm1066308qkc.93.2020.12.07.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 29/52] btrfs: do proper error handling in create_reloc_root
Date:   Mon,  7 Dec 2020 08:57:21 -0500
Message-Id: <a6936beb642d673aa1a7848dcc9ddc6f6322fbf7.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

