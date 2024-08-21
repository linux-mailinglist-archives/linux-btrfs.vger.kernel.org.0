Return-Path: <linux-btrfs+bounces-7381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AF95A6A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B93B1C227A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2117967F;
	Wed, 21 Aug 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSJf1SSR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6461779BC
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275906; cv=none; b=WsxVx75WCZyZU1JmcSplBiG7RrAsWBRmT5IOINvhLHT8zCdnVhEl5jXIdehrmPobqhwex3jyRX0a/sTefQVPXFQu9GSMGhCOyETFbIfHMaegWFVJsiMxVNGGiZsGMm6Nijqe1sQrXpURyQRBRMcEVzb/qVN1lyl5H1dbRBIFvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275906; c=relaxed/simple;
	bh=vxBR6QIfJbh/leW8jbxhA4KDG8JVGWy0z/U/GgLBwxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyWrk/4xuvSgqLeqV0dwbg9Ey0c+omEK5ExOvPCaUtB5/Q+AdE+phvif0dcK3AWW0zalbqK5B/4TGWuLhfZ0AECjnsUiCsOoMCyrbRg1B1Wv3iYJg7vQNZvfz6Wxu94Q8NAIAeDekydv0Lvsa+vk+T/WFWFpQQkwSN/u2EQv6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSJf1SSR; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3db51133978so74041b6e.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275903; x=1724880703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwsxvcXtNSjbcDXC6FM2Q363FoMveVPpYXWlFbmwRFU=;
        b=XSJf1SSRSf1aDDlnOeoX1KqxC7ujzEhDTO5leCbAOVhFcSzoZ6v0fbNh0ECqmEg1kJ
         /k/2IidV+JIDJj8g4NFp3dJXf/20ptyvkDk5sG+SrWaoPeQHE30yX7BQDTn1pP4mLZqE
         RQfN7fNyDW44bSlEy2xE+63EjZu5tBpVLCO8x5+uqSrfQpumagmT3Mmy+Zyf14aW+WX9
         e9j5FrbGV3Aua6YRw23ZZ0ae6ML4riO/E8+aWmZ6iU77aX9OsUxu+bNR3ScQrq0o3F8N
         zLHUHQuBrehZK19gjKQnaXhsS4iRgrUdEsaaKosN24PmSqEsIizELw279E1Gx9lGHpRu
         7Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275903; x=1724880703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwsxvcXtNSjbcDXC6FM2Q363FoMveVPpYXWlFbmwRFU=;
        b=RvXvpNf2PuTTgjfsAbp6HcPjYMvEtPVgWebvEki8AZye+7N37GJf+fKzaJ0MAtqY17
         u9nH0ZiAcULu3wOrkI0b2Z6c7wIGvHaaI2+XkywSA/haJGfkJ90KRYvW15Ol+tucpdes
         PWGXDyR9YI4d8Wk96/mOm9p913K6e3phPeQYGUV8ZZ30QOMxEnOb02yexHL7kwA6MpSu
         dJM/zi2Q2v2K3N4WllgYtghZhgbB7Q0mNSDwMMfkXdLKY/rTDkLu1loCz/Vsu3kGOzbU
         kmFVPyI7IJ7VDQuCbPtnBP1qw4naFJL9JckrJojMYpHmy9paX1HnAXWJOmcR23bvVGS+
         Qc/g==
X-Gm-Message-State: AOJu0YyrN/keC7cg/v5IByIm+GxuRKqgKc3bJohoKT9gjdMSKCVOOmng
	+K2031jCzbhIBNgnFTCO4lrkppPDHmg8hHQOy9QGvh/liMy9fz+BwdhUqfth
X-Google-Smtp-Source: AGHT+IGDBUyM+r0pCbUVXkZha1LOlvhY9wk7yMf7r9wX+XiSa47OgKQXf4zBEeO50/19k2aPCTYa6w==
X-Received: by 2002:a05:6808:2002:b0:3db:209e:7222 with SMTP id 5614622812f47-3de194fc111mr3860527b6e.15.1724275903342;
        Wed, 21 Aug 2024 14:31:43 -0700 (PDT)
Received: from localhost (fwdproxy-eag-009.fbsv.net. [2a03:2880:3ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2256e4a9sm37715b6e.29.2024.08.21.14.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:31:43 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 2/2] btrfs: move cleanup code to read_locked_inode
Date: Wed, 21 Aug 2024 14:31:03 -0700
Message-ID: <3df8e1b14fe6254b3f238cb6284464431be7fb82.1724267937.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724267937.git.loemra.dev@gmail.com>
References: <cover.1724267937.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all the clean up code from btrfs_iget_path to
btrfs_read_locked_inode. I had to move btrfs_add_inode_to_root as it
needs to be called by btrfs_read_locked_inode, but made no changes
to it.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 109 +++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 74d23d0cd1eb9..23733cb590633 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3786,6 +3786,36 @@ static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
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
  * read an inode from the btree into the in-memory inode
  */
@@ -3806,7 +3836,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 
 	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = btrfs_fill_inode(inode, &rdev);
 	if (!ret)
@@ -3815,8 +3845,15 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	btrfs_get_inode_key(BTRFS_I(inode), &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
-	if (ret)
-		return ret;
+	/*
+	 * ret > 0 can come from btrfs_search_slot called by
+	 * btrfs_read_locked_inode(), this means the inode item was not found.
+	 */
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto error;
+
 
 	leaf = path->nodes[0];
 
@@ -3976,7 +4013,16 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	}
 
 	btrfs_sync_inode_flags_to_i_flags(inode);
+
+	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	if (ret < 0)
+		goto error;
+
+	unlock_new_inode(inode);
 	return 0;
+error:
+	iget_failed(inode);
+	return ret;
 }
 
 /*
@@ -5488,36 +5534,6 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
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
-
-	return 0;
-}
-
 static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
@@ -5599,11 +5615,8 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 
 	if (!path) {
 		path = btrfs_alloc_path();
-		if (!path) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
+		if (!path)
+			return ERR_PTR(-ENOMEM);
 	}
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5611,25 +5624,9 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (path != in_path)
 		btrfs_free_path(path);
 
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
-
-	unlock_new_inode(inode);
-
+	if (ret)
+		return ERR_PTR(ret);
 	return inode;
-error:
-	iget_failed(inode);
-	return ERR_PTR(ret);
 }
 
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
-- 
2.43.5


