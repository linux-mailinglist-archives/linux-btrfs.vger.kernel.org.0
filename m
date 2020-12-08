Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5492D2F81
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgLHQZr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgLHQZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:47 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC84C0619D7
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so16404395qkc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpWi/X+1K+7odj8BZYJv8IiBknPW3ri/S4w43bwDSwg=;
        b=QHuTOrW/sQafGO8NLTJtqLwz+QgnN2Bq7psiLHnCz2npaMJ+NzxbcLzDK6zoDvZApi
         2bFrxyxylIPN0/QS+G9lYtntM8gjA3qLh08/hklum4C+Q5m5P+mX95dfFv5kixEhMrFp
         VU7INd4tpbLjTmwEWZENNnvWn9Wm95DWZY1v593b3lkX5vHOMZwd+M33flCeiNimVhiY
         xJBpvKUPkLoxy93mWh8ZiXnRgSYkKJ0BZ5qdV/dLDyEYu8LugsZHJUmM1MOE6WWTcUjZ
         mQ4JuA8ZhEifaJ3SOg3/BTCMTE5o3lKLJEq+aBhEGKKYf4jgEtez/B1UDV4qhgU6pQ4h
         amWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpWi/X+1K+7odj8BZYJv8IiBknPW3ri/S4w43bwDSwg=;
        b=Q0Sa5Qj9D4EMP0nt4ss+IhDN+/wbAiTCun9v5Xej5tzpVA+xMiGyCsrfB4stVU103/
         6J6fWNmqISiH1jKIji3S6Dh59lPv5AM/jlLBXDSFaPHtsQwNN1IiEwOQBB7/61mjz3HK
         J3XQU3z1kcyYphgpkjXL84b0CFhLjfdjwfzKDxiFXUvrtZH1kbtq1zob959ZK+lz4P3r
         +qWOiFHPSTz1BMhO//C1jVfQzSbLTg6GDaS8zh1XXRtEXk8ew1E37cH5EFiJHG5r4Yq2
         AxiHn4Puqk/3exXTPohCwbklEv1XQEDPto4aa65+oli8As7+Ix8td14tUV/K1VMfAcwL
         +dWA==
X-Gm-Message-State: AOAM531bK+YbdfooM6v7IkBQ0e+SZNY1LUu5oDMc4myM1ErJHh4BSC0W
        +w9yjPksSn5wjIQ3/COXGeFoySVxlGNYdIJB
X-Google-Smtp-Source: ABdhPJz529IMexSG4s9vXIEghfIP+BTyovyNw40ktVnwhhkgpyrvH/dt5h2wRtg1GNYzygX1DB8dcw==
X-Received: by 2002:a05:620a:4113:: with SMTP id j19mr31361359qko.301.1607444705460;
        Tue, 08 Dec 2020 08:25:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11sm13934292qkg.45.2020.12.08.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 29/52] btrfs: do proper error handling in create_reloc_root
Date:   Tue,  8 Dec 2020 11:23:36 -0500
Message-Id: <cf6f0ea7b933d405f30712c06dd864dbdd8d952e.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 692a24ec7d83..b7a8a5b44a16 100644
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

