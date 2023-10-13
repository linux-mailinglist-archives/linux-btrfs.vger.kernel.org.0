Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4D7C8DAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjJMTS0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTSZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 15:18:25 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B3C2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 12:18:24 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7ad24b3aaso30374067b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697224703; x=1697829503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBWM1qlpSrZpsszAg/fWEPXwDgCm2PQ32NWuScvqex4=;
        b=WjQ9iGebwSCc4797cNKxvqZz4jd9IjsWwG12CdyeHfcmpgQNLZLJ346ESIU0MU7hQQ
         TpoLtZo/GctRMhPrOy14GG2s5rUDt0jy1F6B2Da9t4PVEJl4w9xcVgRGSluLYvQ/Ogo/
         582qIMljoDDZXam2WhfuP17kwH+0DHLwhdYgLvVl/63LWDFJve3bNdwEqQy5VHq90bKN
         c2Q7RRDken/eWGoXebu3q/QYul2cJfBy31MwnsNhvGYccTvm6i1wdP/2BCw0r2m9vm55
         omYl1PLzYGtg+jhlOE9qQBChLE1AFGY9H736LdgMA5CcFMeDQFkDhLL0fuO5/EXNDPhK
         ldMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224703; x=1697829503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBWM1qlpSrZpsszAg/fWEPXwDgCm2PQ32NWuScvqex4=;
        b=EO7rWAhBaB04J26x6vB0w69myIcYsoyJviHvVGRAI7AAGwgzDBj+3KyQgVyj/E5rks
         c5bl8LOGcSX+hV7Lx8nGvxENA30DYaK5jAkTj3mVC9elwSRQduAiADbYtsAYFXM4P+fS
         5iNdh7EjvJoeELVjnPLuNZBNKg7YIKIShZ8cXD49huB3W4uNSwKPyaEw/tgyQqtzTiO/
         mn8Dx0a70z9OTnGlamkbeqzJNt9X3kAf6a2Qx+h4utCjhKPxyamIl4K9SICp2Z1q5sYo
         AZqKMXEDZe/7D3tFnlb5jzylKkm8LlSWPlZqDcR8cE1+KA/3F6dtDaZBfo2EpLEFGf4V
         O+qA==
X-Gm-Message-State: AOJu0YxrN3udA4Jl0wmLhTcCndCNM+UuzXivPtwzDV1va+SaEVw6xf0C
        WhtIn2VkVvM/dX0NhcMDvVqnd02cEcxs9X0Hz2/9dw==
X-Google-Smtp-Source: AGHT+IEY4k16vh/HKY/25F7fiys54oLAGwB5bp4HnbmSi3PccVjIS4wWoEj+T9dF2wPNy8aVeG8KXA==
X-Received: by 2002:a0d:d3c5:0:b0:583:3c7e:7749 with SMTP id v188-20020a0dd3c5000000b005833c7e7749mr28901298ywd.41.1697224703069;
        Fri, 13 Oct 2023 12:18:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a200-20020a0dd8d1000000b005a247c18403sm889395ywe.37.2023.10.13.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:18:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: get correct owning_root when dropping snapshot
Date:   Fri, 13 Oct 2023 15:18:17 -0400
Message-ID: <2bd997ea59e43e8f7db0f8fd8c8f3d85d0ff0c06.1697224683.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dave reported a bug where we were aborting the transaction while trying
to cleanup the squota reservation for an extent.

This turned out to be because we're doing btrfs_header_owner(next) in
do_walk_down when we decide to free the block.  However in this code
block we haven't explicitly read next, so it could be stale.  We would
then get whatever garbage happened to be in the pages at this point.

Fix this by saving the owner_root when we do the
btrfs_lookup_extent_info().  We always do this in do_walk_down, it is
how we make the decision of whether or not to delete the block.  This is
cheap because we've already done the extent item lookup at this point,
so it's straightforward to just grab the owner root as well.

Then we can use this when deleting the metadata block without needing to
force a read of the extent buffer to find the owner.

This fixes the problem that Dave reported.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       |  2 +-
 fs/btrfs/extent-tree.c | 25 +++++++++++++++++--------
 fs/btrfs/extent-tree.h |  3 ++-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c0c5f2239820..14cefeaf9622 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -421,7 +421,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	if (btrfs_block_can_be_shared(root, buf)) {
 		ret = btrfs_lookup_extent_info(trans, fs_info, buf->start,
 					       btrfs_header_level(buf), 1,
-					       &refs, &flags);
+					       &refs, &flags, NULL);
 		if (ret)
 			return ret;
 		if (unlikely(refs == 0)) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c8e5b4715b49..0455935ff558 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -102,7 +102,8 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
  */
 int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
-			     u64 offset, int metadata, u64 *refs, u64 *flags)
+			     u64 offset, int metadata, u64 *refs, u64 *flags,
+			     u64 *owning_root)
 {
 	struct btrfs_root *extent_root;
 	struct btrfs_delayed_ref_head *head;
@@ -114,6 +115,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	u32 item_size;
 	u64 num_refs;
 	u64 extent_flags;
+	u64 owner = 0;
 	int ret;
 
 	/*
@@ -167,6 +169,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 					    struct btrfs_extent_item);
 			num_refs = btrfs_extent_refs(leaf, ei);
 			extent_flags = btrfs_extent_flags(leaf, ei);
+			owner = btrfs_get_extent_owner_root(fs_info, leaf,
+							    path->slots[0]);
 		} else {
 			ret = -EUCLEAN;
 			btrfs_err(fs_info,
@@ -226,6 +230,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		*refs = num_refs;
 	if (flags)
 		*flags = extent_flags;
+	if (owning_root)
+		*owning_root = owner;
 out_free:
 	btrfs_free_path(path);
 	return ret;
@@ -5234,7 +5240,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		/* We don't lock the tree block, it's OK to be racy here */
 		ret = btrfs_lookup_extent_info(trans, fs_info, bytenr,
 					       wc->level - 1, 1, &refs,
-					       &flags);
+					       &flags, NULL);
 		/* We don't care about errors in readahead. */
 		if (ret < 0)
 			continue;
@@ -5301,7 +5307,8 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
-					       &wc->flags[level]);
+					       &wc->flags[level],
+					       NULL);
 		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
@@ -5391,6 +5398,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 bytenr;
 	u64 generation;
 	u64 parent;
+	u64 owner_root = 0;
 	struct btrfs_tree_parent_check check = { 0 };
 	struct btrfs_key key;
 	struct btrfs_ref ref = { 0 };
@@ -5434,7 +5442,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1,
 				       &wc->refs[level - 1],
-				       &wc->flags[level - 1]);
+				       &wc->flags[level - 1],
+				       &owner_root);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -5567,8 +5576,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		find_next_key(path, level, &wc->drop_progress);
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       fs_info->nodesize, parent,
-				       btrfs_header_owner(next));
+				       fs_info->nodesize, parent, owner_root);
 		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
 				    0, false);
 		ret = btrfs_free_extent(trans, &ref);
@@ -5635,7 +5643,8 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						       eb->start, level, 1,
 						       &wc->refs[level],
-						       &wc->flags[level]);
+						       &wc->flags[level],
+						       NULL);
 			if (ret < 0) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
@@ -5880,7 +5889,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
 						level, 1, &wc->refs[level],
-						&wc->flags[level]);
+						&wc->flags[level], NULL);
 			if (ret < 0) {
 				err = ret;
 				goto out_end_trans;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 0716f65d9753..2e066035ccee 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -99,7 +99,8 @@ u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len);
 int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
-			     u64 offset, int metadata, u64 *refs, u64 *flags);
+			     u64 offset, int metadata, u64 *refs, u64 *flags,
+			     u64 *owner_root);
 int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
 		     int reserved);
 int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
-- 
2.41.0

