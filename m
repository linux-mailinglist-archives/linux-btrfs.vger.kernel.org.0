Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC336E83AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjDSVZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjDSVZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07984768E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bb13so606885qtb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939474; x=1684531474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iOyL9zyZdNt4jjPi6AnYMEM8+V8Tn0R0+0ZUeZ5hRg=;
        b=5NdfFgFOsyxjNdLue6MW3qveGWc63/0EF15k+1BUtarKl9LMlcYJOi2MGKJu87LZc8
         k5nG6Ug6UETTb6lKQ9tnq2SCOi6ms+X70PIuitEkkaAncCDo6PsID4RgFHxdotej97By
         yHDfC5HpBF+ZTm8LNnOd7/j76S7h5aEK0HlOFf0gOOQWVSfT3MD3M96UqQayHQAuTaAz
         ORAYYCRsnn6r59Rdc5mKWrcvbiSuYvQ5h/FgMn3upGliEbVVIQNPS4iyoGrkIEAj7/4Z
         5SrYuEl2/AvVbrOkVSQj5wrjhkvk4KGEu18BHG0mbac4f+tqDAnNOQC9sy3AW8pIpjy1
         pCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939474; x=1684531474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iOyL9zyZdNt4jjPi6AnYMEM8+V8Tn0R0+0ZUeZ5hRg=;
        b=P9f6C6DvLRAPaad0ga01msLqVW42iwJht8EDR30ZSNmbnt1Q2YTaGMx9S+Xx5+d4BG
         VMrWSrY7x0omWhZMd3TiXkigSKHyr1H/UJCiBVS1sruB8v0f/dCBHGTEuQK3bsTC31fv
         h+3H/zEb+n2H9a9C1DVDRVmiQEhzzs3byIh4VFry/Bl2UEfJMjR02qSHbF64JZV8o6X+
         +S+RvBp8Z8DoO6ZAfLjLqM94uoJWatzJmPCycCKsBsSf9zvPtHVRdpq8AgxSkbejR0+K
         2thq7WJebDvx8u6VDDDzbuylZhyZcAwC5BQQYihl++QJJlZIukYYhnc6EuAIHKMyVUpa
         csag==
X-Gm-Message-State: AAQBX9cgf32AfWmIcJzo7A1jLE7hV1qeWaMd9poz2b4H5MktIKNdK8D4
        YR04TSqWoDYfDm/+DR+ly9oGx8yo+hgRtFcKo9JRcw==
X-Google-Smtp-Source: AKy350a336j9Hj0hZNfSBdPjPJT/T+JDgmfTDJZdRDdo+okCIQMzqJ8PzRWOTvybVoB62xH+T1jkJw==
X-Received: by 2002:ac8:5984:0:b0:3ef:437e:c824 with SMTP id e4-20020ac85984000000b003ef437ec824mr6356693qte.52.1681939473961;
        Wed, 19 Apr 2023 14:24:33 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a20d400b0074d3233487dsm3255589qka.114.2023.04.19.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/18] btrfs-progs: rename btrfs_check_* to __btrfs_check_*
Date:   Wed, 19 Apr 2023 17:24:07 -0400
Message-Id: <303808c223f223704d0f06e8d9ff115a19a119c4.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

These helpers are called __btrfs_check_* in the kernel as they return
the special enum to indicate what part of the leaf/node failed.  Rename
the uses in btrfs-progs to match the kernel naming convention to make it
easier to sync that code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/repair.c          | 4 ++--
 kernel-shared/ctree.c   | 8 ++++----
 kernel-shared/ctree.h   | 4 ++--
 kernel-shared/disk-io.c | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/check/repair.c b/check/repair.c
index ec8b0196..b323ad3e 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -311,9 +311,9 @@ enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *
 	enum btrfs_tree_block_status status;
 
 	if (btrfs_is_leaf(eb))
-		status = btrfs_check_leaf(eb);
+		status = __btrfs_check_leaf(eb);
 	else
-		status = btrfs_check_node(eb);
+		status = __btrfs_check_node(eb);
 
 	if (status == BTRFS_TREE_BLOCK_CLEAN)
 		return status;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 3e1085a0..66f44879 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -616,7 +616,7 @@ static void generic_err(const struct extent_buffer *buf, int slot,
 	fprintf(stderr, "\n");
 }
 
-enum btrfs_tree_block_status btrfs_check_node(struct extent_buffer *node)
+enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 {
 	struct btrfs_fs_info *fs_info = node->fs_info;
 	unsigned long nr = btrfs_header_nritems(node);
@@ -677,7 +677,7 @@ fail:
 	return ret;
 }
 
-enum btrfs_tree_block_status btrfs_check_leaf(struct extent_buffer *leaf)
+enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	/* No valid key type is 0, so all key should be larger than this key */
@@ -789,9 +789,9 @@ static int noinline check_block(struct btrfs_fs_info *fs_info,
 	if (path->skip_check_block)
 		return 0;
 	if (level == 0)
-		ret = btrfs_check_leaf(path->nodes[0]);
+		ret = __btrfs_check_leaf(path->nodes[0]);
 	else
-		ret = btrfs_check_node(path->nodes[level]);
+		ret = __btrfs_check_node(path->nodes[level]);
 	if (ret == BTRFS_TREE_BLOCK_CLEAN)
 		return 0;
 	return -EIO;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 20c9edc6..237f530d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -958,8 +958,8 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
-enum btrfs_tree_block_status btrfs_check_node(struct extent_buffer *buf);
-enum btrfs_tree_block_status btrfs_check_leaf(struct extent_buffer *buf);
+enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *buf);
+enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *buf);
 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
 				   struct extent_buffer *parent, int slot);
 int btrfs_previous_item(struct btrfs_root *root,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6e810bd1..4950c685 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -370,9 +370,9 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb, u64 parent_transid,
 			 * btrfs ins dump-tree.
 			 */
 			if (btrfs_header_level(eb))
-				ret = btrfs_check_node(eb);
+				ret = __btrfs_check_node(eb);
 			else
-				ret = btrfs_check_leaf(eb);
+				ret = __btrfs_check_leaf(eb);
 			if (!ret || candidate_mirror == mirror_num) {
 				btrfs_set_buffer_uptodate(eb);
 				return 0;
-- 
2.40.0

