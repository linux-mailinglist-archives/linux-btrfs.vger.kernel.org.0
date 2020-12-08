Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215202D2F78
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgLHQZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgLHQZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:33 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32001C0617B0
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:18 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id l7so12282297qtp.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=MXkPsSHyX0p1LGx6a+DTXZLkTJmKNkShd68hA3XPI9Yq3j+EsUvAOzrfstUv3wYP8w
         RZHRdxZESIF4zq66mcMR/uANM3XbV40Bb7hGtKHWso+vPQ0b17zcqn8++I7IT0wPPYCP
         LAxAwTpiXP1DusLh9yZZ79+/Nt0/IPxyfOO3F+YD3htsIWBxIWh0B+d5QOuQViDOzpCG
         421CzSQgLHTFLeoh9hQdEcpQEBWR9uBKICbPN9xMzIUdvx6qQuDjUYAdLYJJ+DY2hvo0
         xoX4wwBSKAVyRKj0IiE9C3QT7fZhN5ejVl7uo4MAKIGV1AWHBA4L9XmvLvZ/C6N7wRT4
         paSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=rH4dyEP2dch/+K1WQDbqX4gsN5/nLwdx/1AGjG4C5N7qg2FmCnbsWhLMMq1oQCKVbl
         6XPETSCYssb/DG4LXpn7iTfvw29XyEYBwjcOe6PcrMFWq3pyqBJqVaUwgddRDfrQdYxw
         XxcmE2u+yD3TDHJXCeUyg18dlMpaQABuSqGQir3SWdZSjv6vZrZQOznb9bjrnFu7u+5J
         DQsdy/jlB9L0PSLVKKSkn+G1eSGLnXHaT/5xMu1ikyrjTOuVD9+XFduK3bJfG8C5TXsv
         9wycpFX4VAT7XyRQXQ5690/c5B04oEt2aECUQVOi7aagzh8cjyLfKfBg2nv4tn0XCHc1
         H+Vw==
X-Gm-Message-State: AOAM530JkNk2OThBwR1gr1BQJ5cliVi68LJtbXDgzCxxVWkPKQ+YZXtO
        IYpM+ANi82Vw30cjspA6fvgAW1DPdf77Tt4N
X-Google-Smtp-Source: ABdhPJw9RQuCg7CykLqU66E69g/UBJqVOdgTZRKAbwzzkYbxQp4FpNg0z7iFlnXNeDhmbf+uqWxliA==
X-Received: by 2002:a05:622a:303:: with SMTP id q3mr30323807qtw.24.1607444657029;
        Tue, 08 Dec 2020 08:24:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u7sm4573454qke.116.2020.12.08.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 07/52] btrfs: pass down the tree block level through ref-verify
Date:   Tue,  8 Dec 2020 11:23:14 -0500
Message-Id: <55f116a3d3f00ad045ed8cd4f5cd8f05ae80e113.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that sometimes I would have the wrong level printed out with
ref-verify while testing some error injection related problems.  This is
because we only get the level from the main extent item, but our
references could go off the current leaf into another, and at that point
we lose our level.  Fix this by keeping track of the last tree block
level that we found, the same way we keep track of our bytenr and
num_bytes, in case we happen to wander into another leaf while still
processing the references for a bytenr.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 4b9b6c52a83b..409b02566b25 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -495,14 +495,15 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 }
 
 static int process_leaf(struct btrfs_root *root,
-			struct btrfs_path *path, u64 *bytenr, u64 *num_bytes)
+			struct btrfs_path *path, u64 *bytenr, u64 *num_bytes,
+			int *tree_block_level)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	u32 count;
-	int i = 0, tree_block_level = 0, ret = 0;
+	int i = 0, ret = 0;
 	struct btrfs_key key;
 	int nritems = btrfs_header_nritems(leaf);
 
@@ -515,15 +516,15 @@ static int process_leaf(struct btrfs_root *root,
 		case BTRFS_METADATA_ITEM_KEY:
 			*bytenr = key.objectid;
 			ret = process_extent_item(fs_info, path, &key, i,
-						  &tree_block_level);
+						  tree_block_level);
 			break;
 		case BTRFS_TREE_BLOCK_REF_KEY:
 			ret = add_tree_block(fs_info, key.offset, 0,
-					     key.objectid, tree_block_level);
+					     key.objectid, *tree_block_level);
 			break;
 		case BTRFS_SHARED_BLOCK_REF_KEY:
 			ret = add_tree_block(fs_info, 0, key.offset,
-					     key.objectid, tree_block_level);
+					     key.objectid, *tree_block_level);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = btrfs_item_ptr(leaf, i,
@@ -549,7 +550,8 @@ static int process_leaf(struct btrfs_root *root,
 
 /* Walk down to the leaf from the given level */
 static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
-			  int level, u64 *bytenr, u64 *num_bytes)
+			  int level, u64 *bytenr, u64 *num_bytes,
+			  int *tree_block_level)
 {
 	struct extent_buffer *eb;
 	int ret = 0;
@@ -565,7 +567,8 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			path->slots[level-1] = 0;
 			path->locks[level-1] = BTRFS_READ_LOCK;
 		} else {
-			ret = process_leaf(root, path, bytenr, num_bytes);
+			ret = process_leaf(root, path, bytenr, num_bytes,
+					   tree_block_level);
 			if (ret)
 				break;
 		}
@@ -974,6 +977,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_path *path;
 	struct extent_buffer *eb;
+	int tree_block_level = 0;
 	u64 bytenr = 0, num_bytes = 0;
 	int ret, level;
 
@@ -998,7 +1002,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		 * different leaf from the original extent item.
 		 */
 		ret = walk_down_tree(fs_info->extent_root, path, level,
-				     &bytenr, &num_bytes);
+				     &bytenr, &num_bytes, &tree_block_level);
 		if (ret)
 			break;
 		ret = walk_up_tree(path, &level);
-- 
2.26.2

