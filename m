Return-Path: <linux-btrfs+bounces-19645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B85CB4FA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45DDE3013552
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C32C21EA;
	Thu, 11 Dec 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeLe26LI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69372C158E
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437917; cv=none; b=AAUvIvgoljNKk910HqThagVoefnsHXnDm0jznL40ZP0tmBqDQ0WGUrqbiZsCGv6nPXXEAf6SWL2+Y0SbW42wUNjq4v7bjpvY6/Oarq+QJQMJDLppWLgE/BF3OwJ8ItKURnQgV3e/0BQn7RSV1l/KzC/QATtCQZyHRS8iCSBwE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437917; c=relaxed/simple;
	bh=Jzm/u+48bpj/SwHSE+D/qS2Krv5QJkOmiJm7hxCHE/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5lHCdqQOeT401agxc+Wx5JQQWg/rXBLRIE2w8DaW6AKQP3bz3VDPKqpI7vmycPd+dnUGQBFRAJL7lEwy8yNSiF9lbf7DfSORJAAlQOZsIQMYt4U/4jZqF9ACBm4MW3ylNjMs9UNFthr3mwuceD9+p1SQoGgz0cHK8d6p4lqFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeLe26LI; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so18303b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437915; x=1766042715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlARIGs80GJDx30smShBN0HEx8tV5NNSLOVArjbr/60=;
        b=DeLe26LI4SSBZ+tJqms+afpv6K1FIlcOs/TnVZc/k0s7AEhIa+aA3WhlyNioSbq4gI
         F1pV2eLeSmR5qdSfBKFbSXDAdFFBKZSJW2jTFWMo1S0U741HXGdV2RJmrBOqTtFlHxds
         2HEs51QbZNfZkz8LrmbXfoPp2L2dWBOi6BvVgi9nvm2WGlage0AR/SSuQNo9cqOPk7Km
         IT3A5/r08F8BNP8klZEwntWXC+WaiZz60X4om42qz3lmI6Ju1MSfhGSyhoNk9/BCPmIU
         yWJLwlHaQN3w3WmkDWtl4SQfIVNwYwJvKj0AiYtdaoMRO8N5SRLPnstTJJUtv4iRB5yN
         99uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437915; x=1766042715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlARIGs80GJDx30smShBN0HEx8tV5NNSLOVArjbr/60=;
        b=MJF9mze6PFEBtBzcAGMJAR7KpfEqzNVckpXaZ0TiX7uDUOJJiig3LJcNMdXMiQYvV3
         b2RxV3rUtqMLrKwlwOy87wWjYNcVaUXgM6ySEMUQhmR5KoUNJikfckbbbtaUPmOXwD0A
         W+bAzFctm7BWXuPABgUkRDMT/+x/jVvsKdOeHAwZWKDnMnd3XEVNlmAwtbopIa3Fk9HV
         OdJY53T06u+rXJSDhjiE62/gkTeXpcnLvT442+cSbI8WXvVJbMOgZIqtR3dGsody3khZ
         G6R0pUtjdip5/nhUQaYqu7clKdUsprGYRPIrEZrm2aBWHw85N2pCxg65zBRFY27wvv+N
         ZGXQ==
X-Gm-Message-State: AOJu0YyczQleVxSqLhTnePkVDY46Fj1o6e4leRISuLt+Q5jUM0BtzWgb
	RGEKwSgfMtcRPkwUIrQopB0VTcwJYJ1y02IFn+0ClsHGqFHbYv4m6q1kXn81Zhydd78WdA==
X-Gm-Gg: AY/fxX4P9MO+Mx0FoWkr77wA1ZbBB4JeUwV6kZ4Yxnlhj14IbjhsuPnz4oCtBnME3Ve
	0Ytt3hDQWnKR0meDyFBmtmYZQFQYI1b97lwGSkY16bY4wea4puU/DnTCeEn7yDNoGTLmzUnum0D
	JDGHCK6ZC/ULxz+a0G+e+G4biKrX0ztLZocEVsK+aKp5MDuJqzk25o3eYDNfhstwHI6EqVtS6ls
	180AW9Rs0W5I+cBOU+yguBPX9HyM5B5amQkwh9PxX6XHfv8MCfdd9XNecfMCfQ0XRoo0JRkzVkF
	YBCUG/wDc8sdnX7ufZR8UALdadHwnpA2xzUompnSQJ5ldQOpqz14iFPoobTmN2tu+B5d8C0/ph6
	M/+XQFvOc3IiQQePIc6jrDfIw1z9znqcRsKKu6mBkfhl6ZvIR+Rh7Eewb01SJaiE31vXiCF/kPW
	cWcyTWfewB3OhQ/snub5YK
X-Google-Smtp-Source: AGHT+IHArd4ux/YDjpatU4dQ5/XzjScO70CDQ+PM5c4jlk4idyrdSM/BSRVi0RJGkTcKgsDyI2aBWQ==
X-Received: by 2002:a05:6a00:12d4:b0:7ab:3883:36 with SMTP id d2e1a72fcca58-7f4f9130237mr1091526b3a.4.1765437915162;
        Wed, 10 Dec 2025 23:25:15 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4ab4984sm1526520b3a.33.2025.12.10.23.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:25:14 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 3/4] btrfs: cleanup btrfs_search_slot_for_read()
Date: Thu, 11 Dec 2025 15:22:18 +0800
Message-ID: <20251211072442.15920-5-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251211072442.15920-2-sunk67188@gmail.com>
References: <20251211072442.15920-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Now @return_any is not used by any caller, remove it and related logic.

- @for_read is used as boolean, so convert it from int to bool.

- This function is only meaningful when called with p->lowest_level == 0,
  add assertion for that.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c           | 48 +++++++-------------------------------
 fs/btrfs/ctree.h           |  3 +--
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/qgroup.c          | 10 ++++----
 fs/btrfs/send.c            | 12 +++++-----
 5 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a48b4befbee7..0a0157db0b0c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2450,22 +2450,15 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
  * instead the next or previous item should be returned.
  * When find_higher is true, the next higher item is returned, the next lower
  * otherwise.
- * When return_any and find_higher are both true, and no higher item is found,
- * return the next lower instead.
- * When return_any is true and find_higher is false, and no lower item is found,
- * return the next higher instead.
- * It returns 0 if any item is found, 1 if none is found (tree empty), and
- * < 0 on error
+ * It returns 0 if any item is found, 1 if none is found and < 0 on error
  */
 int btrfs_search_slot_for_read(struct btrfs_root *root,
 			       const struct btrfs_key *key,
-			       struct btrfs_path *p, int find_higher,
-			       int return_any)
+			       struct btrfs_path *p, bool find_higher)
 {
 	int ret;
-	struct extent_buffer *leaf;
 
-again:
+	ASSERT(p->lowest_level == 0);
 	ret = btrfs_search_slot(NULL, root, key, p, 0, 0);
 	if (ret <= 0)
 		return ret;
@@ -2476,47 +2469,22 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 	 * to the first free slot in the previous leaf, i.e. at an invalid
 	 * item.
 	 */
-	leaf = p->nodes[0];
-
 	if (find_higher) {
-		if (p->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, p);
-			if (ret <= 0)
-				return ret;
-			if (!return_any)
-				return 1;
-			/*
-			 * no higher item found, return the next
-			 * lower instead
-			 */
-			return_any = 0;
-			find_higher = 0;
-			btrfs_release_path(p);
-			goto again;
-		}
+		if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
+			return btrfs_next_leaf(root, p);
 	} else {
 		if (p->slots[0] == 0) {
 			ret = btrfs_prev_leaf(root, p);
 			if (ret < 0)
 				return ret;
 			if (!ret) {
-				leaf = p->nodes[0];
-				if (p->slots[0] == btrfs_header_nritems(leaf))
+				if (p->slots[0] == btrfs_header_nritems(p->nodes[0]))
 					p->slots[0]--;
 				return 0;
 			}
-			if (!return_any)
-				return 1;
-			/*
-			 * no lower item found, return the next
-			 * higher instead
-			 */
-			return_any = 0;
-			find_higher = 1;
-			btrfs_release_path(p);
-			goto again;
+			return 1;
 		} else {
-			--p->slots[0];
+			p->slots[0]--;
 		}
 	}
 	return 0;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 692370fc07b2..4b7b8ce7e211 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -595,8 +595,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 			  struct btrfs_path *p, u64 time_seq);
 int btrfs_search_slot_for_read(struct btrfs_root *root,
 			       const struct btrfs_key *key,
-			       struct btrfs_path *p, int find_higher,
-			       int return_any);
+			       struct btrfs_path *p, bool find_higher);
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 1ad2ad384b9e..88c46950f5d2 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1089,7 +1089,7 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	key.offset = 0;
 
 	extent_root = btrfs_extent_root(trans->fs_info, key.objectid);
-	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(extent_root, &key, path, true);
 	if (ret < 0)
 		goto out_locked;
 	/*
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d780980e6790..bd458ba537ba 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -415,7 +415,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	key.objectid = 0;
 	key.type = 0;
 	key.offset = 0;
-	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(quota_root, &key, path, true);
 	if (ret)
 		goto out;
 
@@ -530,7 +530,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_RELATION_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(quota_root, &key, path, true);
 	if (ret)
 		goto out;
 	while (1) {
@@ -1088,7 +1088,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	key.offset = 0;
 
 	btrfs_release_path(path);
-	ret = btrfs_search_slot_for_read(tree_root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(tree_root, &key, path, true);
 	if (ret > 0)
 		goto out_add_root;
 	if (unlikely(ret < 0)) {
@@ -1130,7 +1130,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 				goto out_free_path;
 			}
 			ret = btrfs_search_slot_for_read(tree_root, &found_key,
-							 path, 1, 0);
+							 path, true);
 			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out_free_path;
@@ -3692,7 +3692,7 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 				fs_info->qgroup_rescan_progress.objectid);
 	ret = btrfs_search_slot_for_read(extent_root,
 					 &fs_info->qgroup_rescan_progress,
-					 path, 1, 0);
+					 path, true);
 
 	btrfs_debug(fs_info,
 		    "current progress key " BTRFS_KEY_FMT ", search_slot ret %d",
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index eae596b80ec0..471e81a8e844 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1234,7 +1234,7 @@ static int get_inode_path(struct btrfs_root *root,
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot_for_read(root, &key, p, 1, 0);
+	ret = btrfs_search_slot_for_read(root, &key, p, true);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -1979,7 +1979,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot_for_read(root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(root, &key, path, true);
 	if (ret < 0)
 		return ret;
 	if (!ret)
@@ -2475,7 +2475,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	key.offset = 0;
 
 	ret = btrfs_search_slot_for_read(send_root->fs_info->tree_root,
-				&key, path, 1, 0);
+				&key, path, true);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -6195,7 +6195,7 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	key.objectid = ekey->objectid;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = ekey->offset;
-	ret = btrfs_search_slot_for_read(sctx->parent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot_for_read(sctx->parent_root, &key, path, false);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -6320,7 +6320,7 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	key.objectid = sctx->cur_ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = offset;
-	ret = btrfs_search_slot_for_read(root, &key, path, 0, 0);
+	ret = btrfs_search_slot_for_read(root, &key, path, false);
 	if (ret < 0)
 		return ret;
 	ASSERT(ret == 0);
@@ -7288,7 +7288,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	sctx->last_reloc_trans = fs_info->last_reloc_trans;
 	up_read(&fs_info->commit_root_sem);
 
-	ret = btrfs_search_slot_for_read(send_root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(send_root, &key, path, true);
 	if (ret < 0)
 		return ret;
 	if (ret)
-- 
2.51.2


