Return-Path: <linux-btrfs+bounces-19595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F9CAED1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 04:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7035A30454E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 03:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920D30102C;
	Tue,  9 Dec 2025 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr8nWtMG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA52F1FCF
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251491; cv=none; b=n9tWNyxHQz5mQ3b3lx0DvdEnPeu3yzLz/Ttwleb/UIhOp2wPcukW34d5MZ0GIx917OYE04R7EdZY6JvKPaySZj1KRrscOk00fG5c50GLAsQiOoxjqxO2RdfeBY8CCDpKr2A28RiDauhZaEcsoJ5EpC/RxrDOrhMw7FsrRjCHrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251491; c=relaxed/simple;
	bh=cSVprISijlxkmqRW/QbBT59tCyC8FvTu4iIZPc+kzt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csbLMFStcQ1C6TNWrd/gFkvO+Zn4I8aNmfYQ2BgS8IcA1Mh+HMyJLCBgFOidilEdQ8I0jwCPgNqt0+AH5SnztJvVpIpsLOZecMndx0UkG/jlPRoWCwUSjdbaXeuBVRf0T/VJrj47iNbRKssuucVRRp45VE1S9jhl88SR+yG5UzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr8nWtMG; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7d481452588so388626b3a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765251488; x=1765856288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqmV3XWMEH3mpQvqsZdN9EmaWu+bNgP/55bMKRoCQQY=;
        b=gr8nWtMGGyrh5YN6r73KO0LdWkYgNwzx4JeGFjz5jl2x5Bu1YdJ93GiET6ZAX0yiWG
         QB16EsLpPQUAq6otrDsn/duLou4jwL9CoZf6NomqrNWrVVYguMN+X21SjhYAIUKCeZyz
         PF56ZGsNv6vXMq5+bAeo7NMzN6/M+bwtZPZijoTV9LAre/LbnQvOTD21khgoslvwO3XC
         wAEnv6XbM4cXk9VUQCaO8FSJjJH7M1OMfpUVy8GZe5OXzq61ywiRjtp0PH2Z1WyBmLQZ
         s1RseBssrmp5VmQjzZWynes5xtTjHLrxy72sooxes+mt2WX5P3zRqVU6+xhuM6ODEU7E
         CORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251488; x=1765856288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqmV3XWMEH3mpQvqsZdN9EmaWu+bNgP/55bMKRoCQQY=;
        b=QTYGbYvEQxeX862mGTs0IsMc7/mr8E3/6eEuZtnSIzZhAceHFTKuYEnfwIu41++tpQ
         auNBFLVYed3ctTd7isTMwBLqB7rfpk+YQXEdh9jtMKPWCzuwaABEJl9JwOpkKBxq4UMy
         MdK9ykkvRkGa7ObzsLNPx+bALwWnDhwpu0kS9OZ64GAcIBcv16OFk8K+QZKQC10PiaHC
         GFptFKXvtnyV+361f1rtfTvZ5+EDqufhHnBbJ6X/BU0XGdYT5FgCdwq/PZuBL1WXiDfF
         7DVcbJGurmkepxGGbf5XT3yxO4Z9ByO7SsqdoCZZnFXS9ZGa0yT6U1YDuPa/SODdDyjw
         JRvg==
X-Gm-Message-State: AOJu0Yzypxe2oxBD3WtVriU/6GAZ77bm8h4MiOBtb2dyfIU7j5Xu/gPL
	xZiyI9wk5djDLICvzjNrgJq/Nl9e2oP603GyLo0xZYuNeQXNkzFEqGeP033wXIHf08rXCw==
X-Gm-Gg: ASbGncu/wEEtwBNvNYHKxZyxMldvDyxuCB2WzKM8nHSAjg0UZgxMOwzrmy2D64C0jJg
	qW4IQYLcMZ+NTWiaYPUSapyGEpfiw9uIbG0tFIlOJ1685anqtY/Y3Hy2dk4m0/nL1aPboVdZAUV
	O6p2KUZ3qgYucVKtgT2+Ncna0qGnwYNiugG59DbVxyYuUCr5BxA2tvXSWlLIVco7v7U9kFBypNQ
	wU77BGeX873JmTYoynWIQgf0hdca63k2IDmDYiJYdlFZt2aYox74ILyLOONXdwfWIFHTSRHl7s7
	54ry6zZYGWPKg7KkG6jpbIDRV4e4R8l/S+1ao6L90t9jBVnF5D/yC8B14qIKZPizfArfS2gCzlz
	spEl1jfF4NIIMYifHKKS5s+w8iiWgWJSegPA76sJ6ehJzJJSucdpM/6cZ6Qd7uXQjc36hLq04op
	9fzQfOnQgWyYR/RS74/ar5
X-Google-Smtp-Source: AGHT+IGtnxNj83jw8fHf2AuovCrPTWYdgjbMCiPDDClZExmm7jt088zzwjPg3ZHtkFFAeTSR2VuVnw==
X-Received: by 2002:a05:6a00:3906:b0:7b9:a27:351d with SMTP id d2e1a72fcca58-7e8c0eaf150mr6813739b3a.2.1765251488454;
        Mon, 08 Dec 2025 19:38:08 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7edac47617dsm3923900b3a.42.2025.12.08.19.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:38:08 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 3/4] btrfs: cleanup btrfs_search_slot_for_read()
Date: Tue,  9 Dec 2025 11:27:20 +0800
Message-ID: <20251209033747.31010-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209033747.31010-1-sunk67188@gmail.com>
References: <20251209033747.31010-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now @return_any is not used by any caller, remove it and related logic.

@for_read is used as boolean, so convert it from int to bool.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c           | 47 ++++++--------------------------------
 fs/btrfs/ctree.h           |  3 +--
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/qgroup.c          | 10 ++++----
 fs/btrfs/send.c            | 12 +++++-----
 5 files changed, 20 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ee6e5c393873..bb886f9508e2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2439,22 +2439,14 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
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
 	ret = btrfs_search_slot(NULL, root, key, p, 0, 0);
 	if (ret <= 0)
 		return ret;
@@ -2465,47 +2457,22 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
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


