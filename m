Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7A6E839A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDSVYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDSVYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:45 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1F900F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:20 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id oj8so995452qvb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939459; x=1684531459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHULyHjm8jrmit9J0XZ0vy3FmOaKwBpbxRNheiOXiHA=;
        b=m1NIYYAwHGHXbi/jopeW6MKNTUowrvor5TNpqKGo54WD7twLwwmAwl9JAeoNhYEX0A
         4s1ujqNIn9okSsTsyWrdrFrF6LXQv5h+u0krE0pJiEQiuObmMPpnlSRERUhzkA0222zX
         zA9iiPtLWUnJOOsKYMHzGQ5esyvNACNGMOh0rsJL0Yx8YOMUrz7RsyB7HLyDB3cw2Hq9
         G40G0zKsEJFQUVnkXW0tvO7Vtx7el2G2ra43iRhbMdFscEd69L+Dq3rrGAsDvr+L5Hjh
         Z6yqnJeR0988MbGPP6NJ1mu0FgrMc3sD2v8SLLLDa9kpnlguDymCgXC8taQ03sHXZH91
         1TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939459; x=1684531459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHULyHjm8jrmit9J0XZ0vy3FmOaKwBpbxRNheiOXiHA=;
        b=kh+94T2KscRd/VFrBrqy5ZviLM55iX58lvVpS5lOF00pqayZH65BEFugnT7EDNPosd
         Ccgdyb/tbmOIJdWAfDGbp4FVa4lNLrfQq0bzxDsl2IxKRZG9L9svRkn9ggWlnBPJt1sC
         wU8Hw6LW/b713QAZB1hzkUKGB8oYpUYEu52zGpk9JAsCAhcCr604Hq1PEAlCUeyWsfwz
         UWdqOn0AuI84ylsY9H/FRb04iXkp4oM8AYZBXkNBolY+JIHaYq+JPZ8WfSBDhfH7bOJ6
         lMWpvESf1z5nm95EN+arEbHPTNNDnI+ON093OlqhwoOAB3tmyW4LA8/QvlZgLEnn+ue5
         8UHA==
X-Gm-Message-State: AAQBX9dJia+L1MT2BQgSysC77TqX1PCNT+kv7KhTx5AQTAQGsqcKjBrH
        opmjPJmekPTgwlDqV3m2TMp0qziobegstp+eyt1jOg==
X-Google-Smtp-Source: AKy350b/Pr1GeFDuDapt/J6DzZK1oU2IX5NeMC0FAhnu67Z+j+w4ntCzhu50yzpTPn0Nvx5VTHxERw==
X-Received: by 2002:a05:6214:da7:b0:5ee:e4f8:c7e5 with SMTP id h7-20020a0562140da700b005eee4f8c7e5mr32896052qvh.41.1681939458783;
        Wed, 19 Apr 2023 14:24:18 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b10-20020a056214002a00b005f160622f3esm1141500qvr.85.2023.04.19.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/18] btrfs-progs: pass root_id for btrfs_free_tree_block
Date:   Wed, 19 Apr 2023 17:23:55 -0400
Message-Id: <1f77ce90dbec9e4e26590b6ea83ff5e6f6df404a.1681939316.git.josef@toxicpanda.com>
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

In the kernel we pass in the root_id for btrfs_free_tree_block instead
of the root itself.  Update the btrfs-progs version of the helper to
match what we do in the kernel.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/rescue.c               | 3 ++-
 kernel-shared/ctree.h       | 6 ++----
 kernel-shared/disk-io.c     | 2 +-
 kernel-shared/extent-tree.c | 9 +++------
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index b84166ea..5551374d 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -343,7 +343,8 @@ static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
 	ret = btrfs_clear_buffer_dirty(uuid_root->node);
 	if (ret < 0)
 		goto out;
-	ret = btrfs_free_tree_block(trans, uuid_root, uuid_root->node, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(uuid_root),
+				    uuid_root->node, 0, 1);
 	if (ret < 0)
 		goto out;
 	free_extent_buffer(uuid_root->node);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 2f41b58d..c892d707 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -870,10 +870,8 @@ int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int record_parent);
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int record_parent);
-int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root,
-			  struct extent_buffer *buf,
-			  u64 parent, int last_ref);
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans, u64 root_id,
+			  struct extent_buffer *buf, u64 parent, int last_ref);
 int btrfs_free_extent(struct btrfs_trans_handle *trans,
 		      u64 bytenr, u64 num_bytes, u64 parent,
 		      u64 root_objectid, u64 owner, u64 offset);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 7bbcc381..9d93f331 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2301,7 +2301,7 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_clear_buffer_dirty(root->node);
 	if (ret)
 		return ret;
-	ret = btrfs_free_tree_block(trans, root, root->node, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), root->node, 0, 1);
 	if (ret)
 		return ret;
 	if (is_global_root(root))
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8d4483cd..5c33fd53 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2140,13 +2140,10 @@ fail:
 	return ret;
 }
 
-int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root,
-			  struct extent_buffer *buf,
-			  u64 parent, int last_ref)
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans, u64 root_id,
+			  struct extent_buffer *buf, u64 parent, int last_ref)
 {
-	return btrfs_free_extent(trans, buf->start, buf->len, parent,
-				 root->root_key.objectid,
+	return btrfs_free_extent(trans, buf->start, buf->len, parent, root_id,
 				 btrfs_header_level(buf), 0);
 }
 
-- 
2.40.0

