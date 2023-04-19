Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CB6E8338
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSVOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjDSVO1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7595BA1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ay32so51114qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938856; x=1684530856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1D0JTWr+48h833wqFxSK8OWDmOY8G0DtKAhOU43AEoc=;
        b=SySFXEHNWbRnt4wBjdlWD/dQyWUS6n0Y/G5SEDpGLq+LKp2sWBNhhlKaSqNr8FrF3g
         PidIif44mqqki5d6rBL3T4FCym372KywF1y4A7phPkXw0YPym4vZmjd8E851hPoOJIzf
         ueTvuU6CHdaI9xhwflKYvp7KkxZXyIXW4H2Pza/nG/M8yKtsyVJwCBbuwvJymKA/zBND
         l4zC3T8to3cE137raRrX5UajCaQnMqCY+FWjg9pQdoulKY1pPkuIyodY7h5XFW08t2Qv
         OC8TfS1lGHwe/wHuZXrl0Vrf6cfh5yTOFPUVa7kBS2LRo7t1WqTQDYqSU2GmbxClA0Tp
         Ku/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938856; x=1684530856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D0JTWr+48h833wqFxSK8OWDmOY8G0DtKAhOU43AEoc=;
        b=ZObtqnrpBnefQZcBamxm42UcgGBTYsOjdd50cO/LuxPxdbWTdzB5Ka6djFQh97n2KN
         x5M4XbEsH/mjah7cg4bA60mDtzWQNx5I4zsLUaEa8N/Kelei48s857OkOuHrl0AX5+Qu
         waBTo+Vs8/Ibn77qiwA1mrNXSZB4wuHciovl+GbfbfUT2oBrJGihSPipV5aST8sT1xdi
         WI60pIWZDTeY4Pq6o9rbUWFS17JhZWsqIibPZGh34v+3llLeD1+qn0ge5IbhKSjZRqiA
         VpDDrt41pNxV0/v+nNfZC04LWZDKSXHzibA67+AUfU/XnDVhxmpECcunN3hxbXCRetGx
         6ESQ==
X-Gm-Message-State: AAQBX9cDOijtUYDjEayycxmYrVCVIXR8j4OdTTIHQecieM4QNMaHPq35
        QOaSA1evi/3mP+Bdy5CyfnGfR4+ZA5j75pAcgmaDJw==
X-Google-Smtp-Source: AKy350bIVIULhYsUklqlxWuleL2+OZ7hHkp/ypgJqLg0KLsTKxCBn7Efhciwx1hgBi0cs7Cvg+MKew==
X-Received: by 2002:a05:622a:18a4:b0:3ef:3824:b8b0 with SMTP id v36-20020a05622a18a400b003ef3824b8b0mr6872248qtc.5.1681938855835;
        Wed, 19 Apr 2023 14:14:15 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id p129-20020a374287000000b007339c5114a9sm4944649qka.103.2023.04.19.14.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/11] btrfs-progs: remove parent_key arg from btrfs_check_* helpers
Date:   Wed, 19 Apr 2023 17:13:53 -0400
Message-Id: <c5adf830ca98fe359105d216dff330de53ae4c55.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
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

Now that this is unused by these helpers and only used by the repair
related code we can remove this argument from the main helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/repair.c          |  4 ++--
 kernel-shared/ctree.c   | 17 ++++-------------
 kernel-shared/ctree.h   |  6 ++----
 kernel-shared/disk-io.c |  4 ++--
 4 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/check/repair.c b/check/repair.c
index 71b2a277..8c1e2027 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -307,9 +307,9 @@ enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *
 	enum btrfs_tree_block_status status;
 
 	if (btrfs_is_leaf(eb))
-		status = btrfs_check_leaf(first_key, eb);
+		status = btrfs_check_leaf(eb);
 	else
-		status = btrfs_check_node(first_key, eb);
+		status = btrfs_check_node(eb);
 
 	if (status == BTRFS_TREE_BLOCK_CLEAN)
 		return status;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index c1c2059b..911ec51c 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -611,8 +611,7 @@ static void generic_err(const struct extent_buffer *buf, int slot,
 	fprintf(stderr, "\n");
 }
 
-enum btrfs_tree_block_status
-btrfs_check_node(struct btrfs_key *parent_key, struct extent_buffer *node)
+enum btrfs_tree_block_status btrfs_check_node(struct extent_buffer *node)
 {
 	struct btrfs_fs_info *fs_info = node->fs_info;
 	unsigned long nr = btrfs_header_nritems(node);
@@ -673,8 +672,7 @@ fail:
 	return ret;
 }
 
-enum btrfs_tree_block_status
-btrfs_check_leaf(struct btrfs_key *parent_key, struct extent_buffer *leaf)
+enum btrfs_tree_block_status btrfs_check_leaf(struct extent_buffer *leaf)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	/* No valid key type is 0, so all key should be larger than this key */
@@ -781,21 +779,14 @@ fail:
 static int noinline check_block(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, int level)
 {
-	struct btrfs_key key;
-	struct btrfs_key *parent_key_ptr = NULL;
 	enum btrfs_tree_block_status ret;
 
 	if (path->skip_check_block)
 		return 0;
-	if (path->nodes[level + 1]) {
-		btrfs_node_key_to_cpu(path->nodes[level + 1], &key,
-				     path->slots[level + 1]);
-		parent_key_ptr = &key;
-	}
 	if (level == 0)
-		ret = btrfs_check_leaf(parent_key_ptr, path->nodes[0]);
+		ret = btrfs_check_leaf(path->nodes[0]);
 	else
-		ret = btrfs_check_node(parent_key_ptr, path->nodes[level]);
+		ret = btrfs_check_node(path->nodes[level]);
 	if (ret == BTRFS_TREE_BLOCK_CLEAN)
 		return 0;
 	return -EIO;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 13264387..d81d7c02 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2704,10 +2704,8 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
-enum btrfs_tree_block_status
-btrfs_check_node(struct btrfs_key *parent_key, struct extent_buffer *buf);
-enum btrfs_tree_block_status
-btrfs_check_leaf(struct btrfs_key *parent_key, struct extent_buffer *buf);
+enum btrfs_tree_block_status btrfs_check_node(struct extent_buffer *buf);
+enum btrfs_tree_block_status btrfs_check_leaf(struct extent_buffer *buf);
 void reada_for_search(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 		      int level, int slot, u64 objectid);
 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index b5ad89c2..7d165720 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -389,9 +389,9 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 * btrfs ins dump-tree.
 			 */
 			if (btrfs_header_level(eb))
-				ret = btrfs_check_node(NULL, eb);
+				ret = btrfs_check_node(eb);
 			else
-				ret = btrfs_check_leaf(NULL, eb);
+				ret = btrfs_check_leaf(eb);
 			if (!ret || candidate_mirror == mirror_num) {
 				btrfs_set_buffer_uptodate(eb);
 				return eb;
-- 
2.39.1

