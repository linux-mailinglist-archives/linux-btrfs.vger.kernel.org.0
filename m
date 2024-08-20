Return-Path: <linux-btrfs+bounces-7345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96E958F14
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 22:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25714B22D43
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125D1C4621;
	Tue, 20 Aug 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwJjR7MM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B31B86F8
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184833; cv=none; b=AwfCi0KyMy7WrLQgmMnByPQZnZrlro+OvhetEsgjDRsL6IAvVSF71Uk8/VhytA4EZMYOeIl6DQw7sNZ67XlLHGU10huQ7XvKGtg4EydhnlHU4U4r4dNMtLIXHZzpBhUIZNziE29JFYCu1aAZLbLMpPIehqs9pL9w8Bf8b7KdsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184833; c=relaxed/simple;
	bh=1PahAhzy2dX2r1F92KipdARSLiqB9OL7fdHR98OMBHo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf5QiGBuIoZ8L3g67EjB4rv560vCjjrd4wGmSnhxK8vH2sNdYP7XnGxvgitdmPHdYp8bLojTXyWz2XWU5UI/r+kDVdck2XPFtRkN4SO6mEZBsGALUQHnopDi2us+3Dxh/puh0C5G1eSr2ShpQvQaHEIn/pw7mz4m+/Aalw12ZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwJjR7MM; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-70968db52d0so6173239a34.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724184830; x=1724789630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSLMbz4l62KUhngn3MJd2AxIBdF6UC9GIso9Qkc0bhw=;
        b=cwJjR7MM8sMwjNaEbx4o/dT/gNjGWfMtUlZ2xjdWVF5D9eWLCJz7v2WNV/mQFbdTZq
         IP8My7qkDsmjvG2nJ8UnNWvVMNlfCzf+U7JhPCrYdjZzpX+bFqlUI9PG5GBGkAbQ7oDp
         SJsZ3YL305mRM1o+DSwLPFkqonCSZ2Au1S7zB1R0yz5CT91Iq/dg5sRumnHLSMw6ipru
         vgBJVznZe49pTdIefxCT3W8TmAizcRexSUYKYg6nDjjTs7arlgCU1N3PQb8lqOGNOHjR
         696gjXAsyrZfxmHlIERLboWWm8W8VqwcDYHl3kMeNn0oowqHWKigWaUEe1bWqn7c4mhR
         MO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724184830; x=1724789630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSLMbz4l62KUhngn3MJd2AxIBdF6UC9GIso9Qkc0bhw=;
        b=QiX1xL135GKrVZqqtPtXLv1X3tJTZ+K3NPmpsjb9a3PehzOxFPiW3c8XhF/L2dyAle
         nPq+RsZ0UsKcs5NLJblNjBI5P1uSUUcklQjwKw7JuziU9cD8qO9Qo5ldFw/iHw/kEUxs
         q6EV/niEumdghQnX2L5hUVoLO9hkaHdVWLiH+Elb3kT+aQ7A72JN8Ma3206IzuY8JYlt
         lH8XAOmnA2sJ8JDeGUHFZ/AVhcppGvW71octg4+INFPmxeykrwb5udMtsvCgUCBXuqNY
         tTNdTN0t+yy9/NOCRzmRU5uBTKUa2JbP5+yf0vopVvMO+5eUI+4RnBWT7U4ozFF+U2+i
         D6vA==
X-Gm-Message-State: AOJu0Yy+mMpd4Y3Clrq9lfOTbgJ0Y77NIFBoRp7836rQe7k/IXAaIsmE
	CL5VnU3nAcVqlQgWLAIO1MvBin8KxUUXbts0LSbK6oj5FpNx/EeBzPLFYiYE
X-Google-Smtp-Source: AGHT+IGM84FEaoBcDUwqBMpObjNgxIAVmuJLQ3fL6hyY33tILjslw7YTFrxjhrEDPEN5vNE4v4tNoQ==
X-Received: by 2002:a05:6830:61c8:b0:703:6578:8e2b with SMTP id 46e09a7af769-70df886b52dmr210239a34.23.1724184830258;
        Tue, 20 Aug 2024 13:13:50 -0700 (PDT)
Received: from localhost (fwdproxy-eag-116.fbsv.net. [2a03:2880:3ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66205dcsm2906096a34.63.2024.08.20.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:13:50 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: move clean up code from btrfs_iget_path to btrfs_read_locked_inode
Date: Tue, 20 Aug 2024 13:13:19 -0700
Message-ID: <de700f3115e6fd5fe73985b87bb431c3b7131aee.1724184314.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724184314.git.loemra.dev@gmail.com>
References: <cover.1724184314.git.loemra.dev@gmail.com>
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
---
 fs/btrfs/inode.c | 102 +++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f2959803f9d7..f4d20e590b70 100644
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
@@ -3817,8 +3847,15 @@ static int btrfs_read_locked_inode(struct inode *inode,
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
 
@@ -3978,7 +4015,16 @@ static int btrfs_read_locked_inode(struct inode *inode,
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
@@ -5490,36 +5536,6 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
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
@@ -5599,25 +5615,9 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
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


