Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7523C2DC3E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgLPQT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLPQT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:19:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DBC06138C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:57 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id w79so22996097qkb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=w0OqLn4kyCxhg6CDbLAhxLdQack0XRC6nvapQXrdqygRARXxBjT2WW9+PVsrU+IlSM
         XS0N35j0nnyowxFZeKtMABYQpOHJ+5ELp0o2I8QnbDzx9v7rNb35qVrd4J6bGozs/QR3
         KniROl/hS+OsIIvFrjL6ziT2N6N5eqQggMbp9kSSJBmeaZtBU1MRw6CCY7+8V89xgoBZ
         kx0FTQIAxdOtEv1cv89eAZr7ldAigYIcXGxVaap4ImYJXzYhBLQxO04MA/PV35IPxJB/
         YACb/MzrzuD1PUEHD1o69oQf2JMT7CSGqRCZACXtKg4O8inKr/Q66+HDY3HhZeHdz1Qq
         40tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=QNJiwT+cWZyIbkDlZO/ueXWUtyIIyv/LqVVwliP0Wacohm7eOAfrtBkC09iPN1UVEJ
         5vrbWchTLQGB4xI8ZNqw3IpiUyUs72zZnxLOl54byToauPxS7ESN2y1ttJXdXsYoZ/jh
         3BFnjptzjsnK4wo07Jww88dUoRya1x3oixbxsc3J/8rAbmmdlrnzmkDoUJlNFOdoxMBG
         XVb9CRXQ1UTo4SlqhW8/UA/JpAAaaJRGhwuAs0iIuMk0dNohdst6uL6a05wLPG55YMSG
         Lxhnt9THqbmoYpqL5yBvXJHzmeY4hz6xNIRu9KgzkRikk02d2Ik2teIuaxjqKxt1puGp
         rf3Q==
X-Gm-Message-State: AOAM533+zAxknCUifizDLJU2qxXGDsSXbXTFaTl7XPolm6kw2qum+BK5
        6DaFQIhtafVj6U5mwuyRSo069sLwL9wJ519D
X-Google-Smtp-Source: ABdhPJzg2Td4vqvfietBeodTHf+9OOAwzMFwJdYFkZhilhArsZSGoWlSmwCm9BGqxOXOU9HIQODDzw==
X-Received: by 2002:a37:5847:: with SMTP id m68mr46523904qkb.497.1608135536466;
        Wed, 16 Dec 2020 08:18:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r1sm1165006qta.32.2020.12.16.08.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:18:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: pass down the tree block level through ref-verify
Date:   Wed, 16 Dec 2020 11:18:46 -0500
Message-Id: <107b6ae87974e8a6acdbe737f80ad995f8228a52.1608135381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135381.git.josef@toxicpanda.com>
References: <cover.1608135381.git.josef@toxicpanda.com>
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

