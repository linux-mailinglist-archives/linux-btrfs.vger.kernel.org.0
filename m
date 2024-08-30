Return-Path: <linux-btrfs+bounces-7699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBD966A68
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 22:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69D0284920
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFFE1BF7F2;
	Fri, 30 Aug 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcoR6xLq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3421BF317
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049533; cv=none; b=O4zGYcmT1tU8CqpEn07pDyiVoKRv4yOlk1cNet0fQi4Hz4W+A9InAFrk0+tAp8iflp0DUn+oKFxzrPkqnOzdMloc5QIfnGP4jY1Pq1ixwG1f7SMyeNGa7hbaQd9H11QeSMJoiOgmpEIRPspeYolDvNqVYGU+JWeFYioW8zzjM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049533; c=relaxed/simple;
	bh=3t+KyyzdtcfR1wwpyHcunpXA6IkhZ0QQjCSdICphS1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb77BDKLBOlUd4WkzXAF03kk3GHP1orDZbQaC1oolQfie5qg4SE1Cpq/viyLlxqurdUCAtCteRvqSqjwVTw6BLP2B7Dh0UL4CNTtNqWTkp9pyk2TPdIkZM9TFJnobdrBKMU+az0znGIsP5rkbi30o5f3FLsq9+H4f4oSEZvB4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcoR6xLq; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7093c94435bso846193a34.0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049531; x=1725654331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+T6vOjr6Ft1G0QZ4RXDnhdGk/36KaNdS+jaSptuVrgM=;
        b=IcoR6xLqFHEajO5NNZoe9r/g2mJ3N5YPKpMSW1ruWm0YeVv25aZpMtQh4awmpmZ2yV
         kDxg0HsRYFz5alPCQN1g4ytzscmLsDeaqSBlpQ4uSIbGxDN6bfqPvmistFe1l/Rx2bL/
         5umDem0c3MB+oQYPOHghUdkne0SrpOHMJwOIJkECoKV+gUcs4G88KtloohJjD6w/vW5x
         4XOJhUj7C01CDgNPb+PExmcQChPD00aEWjrQ2fszJP3WHGCTPMI1Om4oRYDKbyQxC8/U
         2IgIK1MyoxbDgazqWpxOqnwKbtpCFuogiI6+EblFrrsfdg00U0nvfuhEDEt5FClCIowI
         qmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049531; x=1725654331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+T6vOjr6Ft1G0QZ4RXDnhdGk/36KaNdS+jaSptuVrgM=;
        b=nEJu+EdObgNDarrrxmBfPN5bG2Uru8xM+NFUqQJnC9/QMx30cifGl9JnqMcL2IiHMw
         jWkahObno0apUqETH3pi0gtqZX1vOOKDnNfdvsNj2oJXUqjEsEZ7WIInRkQX4KTIevi2
         EGGUyc32AVWThrB9xBGCxubrlLfF+xZqHS4BAt0JKWZCAdtQE+SgR7wJfk1XzlVfjNRp
         6Ci+BUEUFq0dxVM5tZGhhcawQDs3rMs2I9Yo4zML5LUkeDCCrXUIzWLabiVoNhtmpQVB
         g6UBo7Hsf+2SeBGHuE5NjiVNDwRzymssX5eDTohxrw111Gldy9/FtkemS9GxO0RKUMyn
         tKFg==
X-Gm-Message-State: AOJu0YxaSZZxI74jAZd0WR/4CvSDq3dzMWcVntpaV2xFsJH5ZoysBPty
	7PY3R9ZeWd7ikKydylyMSPKJbfphS0xKmYwmgvnJIMBC6Z2CNWnCzGGcbffO
X-Google-Smtp-Source: AGHT+IHmVGT4mZCICAdQDH7UhOU0dNbXcub0fEzpuLpmGyA6/hsc8wJxoVWcv5ebW1eDJtlXfiTusw==
X-Received: by 2002:a05:6830:44a9:b0:70d:f595:2cc7 with SMTP id 46e09a7af769-70f5c363e73mr7655092a34.14.1725049530687;
        Fri, 30 Aug 2024 13:25:30 -0700 (PDT)
Received: from localhost (fwdproxy-eag-001.fbsv.net. [2a03:2880:3ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671c29adsm616985a34.65.2024.08.30.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:25:30 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 1/2] btrfs: push cleanup into read_locked_inode
Date: Fri, 30 Aug 2024 13:24:54 -0700
Message-ID: <874b2ef5a8decb15f52ba97442706ea68c3f13f3.1724970046.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724970046.git.loemra.dev@gmail.com>
References: <cover.1724970046.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move btrfs_add_inode_to_root so it can be called from
btrfs_read_locked_inode, no changes were made to the function.

Move cleanup code from btrfs_iget_path to btrfs_read_locked_inode.
This improves readability and improves a leaky abstraction. Previously
btrfs_iget_path had to handle a positive error case as a result of a
call to btrfs_search_slot, but it makes more sense to handle this closer
to the source of the call.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/inode.c | 99 +++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e96b63d7e8fd..df0fe5e79ea2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3786,8 +3786,39 @@ static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
 	return 0;
 }
 
+static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_inode *existing;
+	const u64 ino = btrfs_ino(inode);
+	int ret;
+
+	if (inode_unhashed(&inode->vfs_inode))
+		return 0;
+
+	if (prealloc) {
+		ret = xa_reserve(&root->inodes, ino, GFP_NOFS);
+		if (ret)
+			return ret;
+	}
+
+	existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
+
+	if (xa_is_err(existing)) {
+		ret = xa_err(existing);
+		ASSERT(ret != -EINVAL);
+		ASSERT(ret != -ENOMEM);
+		return ret;
+	} else if (existing) {
+		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+	}
+
+	return 0;
+}
+
 /*
- * read an inode from the btree into the in-memory inode
+ * read a locked inode from the btree into the in-memory inode
+ * on failure clean up the inode
  */
 static int btrfs_read_locked_inode(struct inode *inode,
 				   struct btrfs_path *in_path)
@@ -3807,7 +3838,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 
 	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = btrfs_fill_inode(inode, &rdev);
 	if (!ret)
@@ -3816,7 +3847,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	if (!path) {
 		path = btrfs_alloc_path();
 		if (!path)
-			return -ENOMEM;
+			goto error;
 	}
 
 	btrfs_get_inode_key(BTRFS_I(inode), &location);
@@ -3825,7 +3856,13 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	if (ret) {
 		if (path != in_path)
 			btrfs_free_path(path);
-		return ret;
+		/*
+		 * ret > 0 can come from btrfs_search_slot called by
+		 * btrfs_lookup_inode(), this means the inode was not found.
+		 */
+		if (ret > 0)
+			ret = -ENOENT;
+		goto error;
 	}
 
 	leaf = path->nodes[0];
@@ -3988,7 +4025,15 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	}
 
 	btrfs_sync_inode_flags_to_i_flags(inode);
+
+	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	if (ret)
+		goto error;
+
 	return 0;
+error:
+	iget_failed(inode);
+	return ret;
 }
 
 /*
@@ -5500,35 +5545,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	return err;
 }
 
-static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_inode *existing;
-	const u64 ino = btrfs_ino(inode);
-	int ret;
-
-	if (inode_unhashed(&inode->vfs_inode))
-		return 0;
-
-	if (prealloc) {
-		ret = xa_reserve(&root->inodes, ino, GFP_NOFS);
-		if (ret)
-			return ret;
-	}
-
-	existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
-
-	if (xa_is_err(existing)) {
-		ret = xa_err(existing);
-		ASSERT(ret != -EINVAL);
-		ASSERT(ret != -ENOMEM);
-		return ret;
-	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
-	}
 
-	return 0;
-}
 
 static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 {
@@ -5609,25 +5626,11 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
-	/*
-	 * ret > 0 can come from btrfs_search_slot called by
-	 * btrfs_read_locked_inode(), this means the inode item was not found.
-	 */
-	if (ret > 0)
-		ret = -ENOENT;
-	if (ret < 0)
-		goto error;
-
-	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
-	if (ret < 0)
-		goto error;
+	if (ret)
+		return ERR_PTR(ret);
 
 	unlock_new_inode(inode);
-
 	return inode;
-error:
-	iget_failed(inode);
-	return ERR_PTR(ret);
 }
 
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
-- 
2.43.5


