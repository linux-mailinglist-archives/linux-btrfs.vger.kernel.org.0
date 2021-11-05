Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F474469E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhKEUnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhKEUnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6373C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bi29so9876350qkb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cjyp+iyJMKE7dQvZXu1Jjrqc82IKIZ7caisFHeyE2BM=;
        b=W9MxFDN99w2FLMOzEsOcxgYFsvqCz0gabhIEOa/EJDHvy2CTAOonwHcfudSo4j2DOz
         DvJGndSBYgyEqtZp2xxKeBebSdKPqgxquNTEDaczLZ2R7vlKahSERD0/+gdQvaerNQT6
         lyyRcXiv07brBtPQGLovVyw7UIHY0gTcuIvnsSvILT3nTyjRaX/ei8H00rqmgnvbmFP4
         UNIU43FBoqN/wdDD03An4JCryNl5AMFYhRRdwp+b0M3CFhVqUgUYlovvLrKfZ5GGJKNZ
         1dDxOMO3Rqpv6S15L+QL3Mg7ohvLP4lOb3TNj5bz94tTxoUme1bQGIe/Ga2hNkGP14yA
         puzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjyp+iyJMKE7dQvZXu1Jjrqc82IKIZ7caisFHeyE2BM=;
        b=0udNIgmgPkvVWskI2DItOFAPP5FwiH9M+T6SRnHLJnf2JCuizrVAJ0OIws8GQK2A+I
         Ms0g7qkQG6gtTnt3vI/KMDMTxoWPX/uMjlqyk5BUvOdVR02g7UWHYM5d/OGeiZ9/yJK1
         4LwxAwVViJ9A32b4Hpbqbo4lNAJC/BDfxdQ2K33BU0z3y6qCqCjT5IXs/yf33Y1Y02an
         ODtuWOQfs6zlW51+NxDQkq+PkzEx+CPiD4neWYcaT+ksz2iABIli6cL0qGn6UGNCSf2q
         dRaTHz3O4HqQGTHqUpLaVjgTleXCqm/6XBfEjwlpnf/1US3CvCHH7JmMIoDOJ/zk6dAl
         VK3w==
X-Gm-Message-State: AOAM533JiXV6CDg9H+hXJHV8wqa/NOT67joNqpSPKw90dlj/BBh7i5f4
        mEu9JBp2zBA7mRhMLh1S/63x097ViQsJoQ==
X-Google-Smtp-Source: ABdhPJwFaVd6RxBXY3pikPiYGESmpK9PGX6utm9D5fs7QFqvItWnPw2Ii+No/tvSMy7EZJJAQryd9Q==
X-Received: by 2002:a37:a847:: with SMTP id r68mr4820955qke.293.1636144872668;
        Fri, 05 Nov 2021 13:41:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c64sm10552qkg.25.2021.11.05.13.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/22] btrfs-progs: add a btrfs_delete_and_free_root helper
Date:   Fri,  5 Nov 2021 16:40:43 -0400
Message-Id: <669d869249be8b9e3d7fa186ff7905a71d63eb80.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index af29a7ae..c35bdff4 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2349,6 +2349,31 @@ int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
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
index e2c2f3d9..fa4d41f3 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -217,6 +217,8 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
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

