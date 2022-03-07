Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFF4D0AA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiCGWMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiCGWMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:22 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55B8B6F9
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id iv12so11753739qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CTvZiOf58lLDr1jVJuY8D1JjvHi33eMMd3+c5hg8vfc=;
        b=L8desVwIInNW4tBtWAY9vgUYAXJIPYqAOjGPTHc169H/rP//kEleDw+gckfqetTEBf
         dSviS4xYrJzdYbtHzePgjjRQlJ/YtDhxJ91o8b0LNMZldQLhpCrj5juazDFQhPxICHwT
         cklBG8WfxMoMtxj242K0T6l3BuqPhDTrsMfUtLYDtvn/pvou+32JNpVopZeCZyy2hlZy
         U0h7L9Ua/4xj7J7BlhWKSC/B7arpLbHL/+1z8x+xLJjcPD/4IiheyI5Ir5fmMGuRT9/M
         UCqz3e2R4vt5vhINiykACc7G3oWe3R+PnjI+PTju6bwDTIMhwV18rNSZH4vNMsslFAPM
         q/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTvZiOf58lLDr1jVJuY8D1JjvHi33eMMd3+c5hg8vfc=;
        b=25KQvec7T/nQVaRtXUaASNJHifCaoRr/yS+Hd9crIZf0lpG+Xy+3GThdis1SV4DY/j
         z92syWQTO42O71M8AVqbC+b6RMGWzZ1XKefHxIdZbH/rWcWW6HaTlIdHP7Ut3vYV6PZq
         hKVUUGV/6IgfWe8GOAGoMSDhI909IpiqSTwMjL6AD3dH8f6OeogOos6M6BZBa59lIx1W
         X5WVOkT2GIH+YBLzAAXZ2O/hl4cW6mR7AGXHolrJFV3QrFo/8XV4DW4M+f9fvHToAivG
         PzLptWZU5KyDMsB654OGxMdHp7z+hbt5xscw6sBeG4X9K+QWvP7YNBuGiNRQC7wiyvsl
         gHjw==
X-Gm-Message-State: AOAM530jZ6c08LuXTd5ObBlCq0F5JkEM4VZoyhXEpVGqajEAgndPIgYY
        m82JFNvMFcKbFRC47CUbxgimmcDnL+liupa0
X-Google-Smtp-Source: ABdhPJw9fxRfd/p3HE9T+cTBPtiSFZGXJCbcuAyTkjNQnl7p4pEhlMNEzqorowYmm+PCWRq0RBth9A==
X-Received: by 2002:a0c:9085:0:b0:42c:3319:e513 with SMTP id p5-20020a0c9085000000b0042c3319e513mr10007322qvp.79.1646691085893;
        Mon, 07 Mar 2022 14:11:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0064915d9584fsm6818745qkd.8.2022.03.07.14.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 14/19] btrfs-progs: add a btrfs_delete_and_free_root helper
Date:   Mon,  7 Mar 2022 17:10:59 -0500
Message-Id: <b57d738f65a40998494c7eed9af50dedef58f874.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The free space tree code already does this, but we need it for cleaning
up per block group roots.  Abstract this code out into a helper so that
we can use it in multiple places in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c         | 25 +++++++++++++++++++++++++
 kernel-shared/disk-io.h         |  2 ++
 kernel-shared/free-space-tree.c | 24 +++---------------------
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 59c46946..f3ddf9e3 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2399,6 +2399,31 @@ int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
 	return set_extent_buffer_uptodate(eb);
 }
 
+int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	int ret;
+
+	ret = btrfs_del_root(trans, tree_root, &root->root_key);
+	if (ret)
+		return ret;
+
+	list_del(&root->dirty_list);
+	ret = clean_tree_block(root->node);
+	if (ret)
+		return ret;
+	ret = btrfs_free_tree_block(trans, root, root->node, 0, 1);
+	if (ret)
+		return ret;
+	rb_erase(&root->rb_node, &fs_info->global_roots_tree);
+	free_extent_buffer(root->node);
+	free_extent_buffer(root->commit_root);
+	kfree(root);
+	return 0;
+}
+
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     u64 objectid)
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 81d8670f..1e97b9ac 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -221,6 +221,8 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     u64 objectid);
+int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index a82865d3..0a13b1d6 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1257,27 +1257,9 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto abort;
 
-	ret = btrfs_del_root(trans, tree_root, &free_space_root->root_key);
-	if (ret)
-		goto abort;
-
-	list_del(&free_space_root->dirty_list);
-
-	ret = clean_tree_block(free_space_root->node);
-	if (ret)
-		goto abort;
-	ret = btrfs_free_tree_block(trans, free_space_root,
-				    free_space_root->node, 0, 1);
-	if (ret)
-		goto abort;
-
-	rb_erase(&free_space_root->rb_node, &fs_info->global_roots_tree);
-	free_extent_buffer(free_space_root->node);
-	free_extent_buffer(free_space_root->commit_root);
-	kfree(free_space_root);
-
-	ret = btrfs_commit_transaction(trans, tree_root);
-
+	ret = btrfs_delete_and_free_root(trans, free_space_root);
+	if (!ret)
+		ret = btrfs_commit_transaction(trans, tree_root);
 abort:
 	return ret;
 }
-- 
2.26.3

