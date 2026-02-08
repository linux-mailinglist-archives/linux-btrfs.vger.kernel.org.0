Return-Path: <linux-btrfs+bounces-21472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N9qBPMFiGl1hQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21472-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:41:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960F107C25
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6933B3011BDB
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03437286D4D;
	Sun,  8 Feb 2026 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMoSKtPb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E590266B67
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770522082; cv=none; b=j4Uiq1XmkDkQPqppieMceninmgJr3cq5RFwzcjNxP+TB1Ym9Ik/7EoDP68I2pkBVIOgLH/8W2resEG2djhSXHYKt7+ysIZN4Fq6a5fmQUtBtzVQh8SfNM6b6htHLoQ5e0zpS3UUgZvknjLdiQzHYIH3MUfrC4Ja/o9dPQwMyefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770522082; c=relaxed/simple;
	bh=g7octihKw+k/UOiXj4Mk471UbuChwWEgPpekbqYPMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gU0H4cLvnpLgAvPDfNCCtoEgWgw+rxikkOVljwu/VkoVamerXizJ1HRJUd/0XkXeaIR2o1DMA5LpQPtWLrXi/VHsBWK41RiVTuBea03qImPS4SnkGp7mCXyrj3JRLhpqsmJABr3KjTS/2pJMFjtqiEwvW9kxtKyYtPuaWNBuAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMoSKtPb; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-794e0d7208dso2762777b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 19:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770522081; x=1771126881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+Prn+6KhSAuhTsjodey/3xq7wKlljxuubUvPz2hEag=;
        b=UMoSKtPbI6lARfbLvTF4LlUoKRgVCdJCqkN3cELB7wRXGQc7NcBIXIvifdUw56uHVL
         mQeUmp1QvbqyUCWm3RWW5yKZRLtlZ9GfrD0Z60lPgKqH+3Lbiq9T+Cev/o7jShBQSu7/
         mUG85Pg+ORVxSBiaMjSymheo0QF1mNybeOJ1SixeSmjPszXoVCM+Fu6pLqNHj2Sbuaz+
         9xVOxAeF8w9DB8GJzEL8Db4YPUBL8df/PoYnFikX943nVgUK8+Cq49Gu8sb/RpA1K7ZP
         0oZ3rK/kWbWq1FW8/5AGW5pBSXUCtizuXPMKjUYOKQEPifzcYHaav53fIHM7xWB8swJe
         tD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770522081; x=1771126881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+Prn+6KhSAuhTsjodey/3xq7wKlljxuubUvPz2hEag=;
        b=nC6H3ljJKOEkCVKIdB9Jyomv6+xzQUA5cINXainhavZlcGvGqeWWg8VGDU/qg3yrxo
         mSrCWkg/f2btFchfKNDs/4iVuwyuv5qk+zohjRnQjyRAIMNd7wBpCiMptWfOb/BFNM67
         LxBABrkDwCUDq/Fma9NuSU0vbO2TRYth0XjdMliRqSigxBRFBTT2FfULOo0XDcMH3hV8
         s6Ql+tGMb8mIGN9mKN7vaFEkaqLJE0nZduXSv3LXQm8o0moDYVae5Boab7h8Pmp2AvDa
         1IAqK4z5dSLEmrtF0qzCiAT00Tp7kEoTkm/vKnx8ZDXshAIzc/ipuq1P6KY4SGI8xbci
         ECFw==
X-Gm-Message-State: AOJu0YzJQu6MWs5HppWYMsqZxmrvvBfhKnpegB38LkrGP6e7hyU3SZhQ
	H6fkj8sPvJsghsyCZff+XcRYA2VpyEDzxMjlI9yiZU9JYHsrpFbbDcedqeJmPsmB01A+eQ==
X-Gm-Gg: AZuq6aJsgI58pzAtH8CcFbHEfu5jGrmZ8e7I4FntEKgPmx4exdhOabT+rcz0Wm2cTHJ
	+nataNtRPf40ImS2WhdebAo6hHxE6t5U1WkICEAIXEDxgzrmyvkeVHj0o/VwCXX6lC7g794dXxe
	cytMgk8pFhTEZkHE58y2L1X8TGXJLNqeMOmw6rYPSe2wqimDunWMucR/yD/YOfVWmSXrVk3zeea
	/kCBOMDP/pXUISEsGXTJoigoUOQGyfzF5cPUhrugK3ISsLiJK1MVO9SiviB+JwF1Kr7FvlF3dn3
	+Mb/1Kuh/qbEi+Y46j8ULUIb0QyGBf7fZCWmmJ8mWkhTn7a6s/jeP0lotVKBOlBrq7UCOdZomJt
	VElabE49jtQYAC8AS3cZlHjd7gkP6++S/egk1ia2hgh9tSWNJngHgTPsVM7smXxit9/4FCewLuh
	1IR0FVX6ZCO2iebGvzgsnRPu/5Nc9R
X-Received: by 2002:a05:690c:7:b0:794:c0c7:43e8 with SMTP id 00721157ae682-7952aa6a015mr60532607b3.3.1770522081075;
        Sat, 07 Feb 2026 19:41:21 -0800 (PST)
Received: from SaltyKitkat ([163.176.176.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28ca8dsm60019067b3.53.2026.02.07.19.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 19:41:20 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 3/3] btrfs: simplify btrfs_search_slot_for_read() by removing return_any parameter
Date: Sun,  8 Feb 2026 11:40:46 +0800
Message-ID: <20260208034104.13787-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208032705.27040-3-sunk67188@gmail.com>
References: <20260208032705.27040-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21472-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5960F107C25
X-Rspamd-Action: no action

The return_any parameter in btrfs_search_slot_for_read() was intended to
allow falling back to the opposite direction when no item is found in
the requested direction. However, all existing callers pass return_any=0,
meaning this fallback logic is never used.

Remove the unused return_any parameter and the associated fallback code
paths. This simplifies the function interface and implementation
significantly:

- Change find_higher from int to bool for type safety
- Remove the "again" loop and recursive search logic
- Add ASSERT(p->lowest_level == 0) to document the precondition
- Update all callers to use the new signature

The behavior remains unchanged for all existing callers since they all
used return_any=false.

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
index b8040740f7ca..0d84e456a41c 100644
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
@@ -3690,7 +3690,7 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 				fs_info->qgroup_rescan_progress.objectid);
 	ret = btrfs_search_slot_for_read(extent_root,
 					 &fs_info->qgroup_rescan_progress,
-					 path, 1, 0);
+					 path, true);
 
 	btrfs_debug(fs_info,
 		    "current progress key " BTRFS_KEY_FMT ", search_slot ret %d",
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5b551f811bf6..59096abca5f0 100644
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
 	ret = 0;
@@ -7292,7 +7292,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	sctx->last_reloc_trans = fs_info->last_reloc_trans;
 	up_read(&fs_info->commit_root_sem);
 
-	ret = btrfs_search_slot_for_read(send_root, &key, path, 1, 0);
+	ret = btrfs_search_slot_for_read(send_root, &key, path, true);
 	if (ret < 0)
 		return ret;
 	if (ret)
-- 
2.52.0


