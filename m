Return-Path: <linux-btrfs+bounces-7174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650D950DF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 22:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E80AB290A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3FE1A707D;
	Tue, 13 Aug 2024 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEEwU9PS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6D1A7074
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580931; cv=none; b=UjwU3hrWSFYnryjiDCGV03s/7piETSHAqxVfcvRhtFqBcH1+vYf9up/mfL4YjLVucS8W4S2hxeVBEjkLkwzwgrlUhqJquSm+gqd2LBAjTdxSC4AujSoEpOfEfATzC23UKI4KHO8+JFn0dSsyNC0fkPvytG54pcIFrrvllmcVsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580931; c=relaxed/simple;
	bh=dmgRaTooyo//NmhhbiXA94XMYojnj/PKSEC5OhD9zgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT9H++b/kbGKCfPyah58quFdGs7jngzkW7ksKlI7+ziBhUuNt0njbYP3ufxdt13sfOdITd3IlZnYKjeScg1svD7ie6qSOrOVDTaCdXr7v64CgqOMb35AQe6Nl5a205OwVwgy6EZqSisE1z/d9RJyVeYBkjddF9rgLdftVsSFVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEEwU9PS; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so3668868eaf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723580928; x=1724185728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ld5U9/rlbDYG9/xZ+sk695otZVl74fB6CBsr1cJODgU=;
        b=JEEwU9PS6B8g9HWM/fWWB2rZZ1iuLfKJzVxNps87f4w/mNPhUCPnbzwIWFZcfxiLTk
         vUY0xpBWAKvssVG7azRDhYsbr4Uu2/BDh0zkN8+0YhTOPhymIYior85fc50DvK7omPAl
         7oYSZCIx4MlwI5Q7sRfLQ+y+BILWQfhTw+2TCNKx7EVWfy3a0VMOmOR6sHJLD1cri+vK
         3ehNnAHuKiCrKH1vdgC+4u0ElDl8upukqdsWCpGsOZe5YqUSt7tHs+Jjf8Nq5pR2ejBh
         SxyPn6tpZWSIzCvf6U3iuZgCqu5nptuv1/ceZP06SWkMHWsXYfCW4mraVG6ZNiBf6VUb
         C2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580928; x=1724185728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld5U9/rlbDYG9/xZ+sk695otZVl74fB6CBsr1cJODgU=;
        b=m40mYHqvvbe0GWb6dPAckSc/MlUtoHvQOxsmtGViNTguPstqFWVr0XXxsyIJXkdzFm
         6T+Fp0b61oCu1VvBpTLXOdiUT77MGZrHJAMKA67ICfVJPQp4ppJzL/u9TCj+9xG+63PM
         ZSiART+lf81+YuyZtwhXQvojAaO9gu5kl62SjqFCdCwmIa957l3eN4rUz96zHz3mcIzP
         Rq0xfB6Z6CfiXn4+XTRYI4L0GTmR2tfGUfwENMuLXkAoSf6opxMXLY9dH2i35/NVwjpP
         lhUHVNJ8FN8HsPUrKYkx4CdmknBgPqFTVZCPVIHyffjkBQNywfvk13n0VJgimoelpe9O
         Xc4A==
X-Gm-Message-State: AOJu0YyO++AzyZNM4UUj9USlvUiI41xocj6gfIhCICRQtxg5ODmq1EI3
	eI2at5L8Vzzlpg9o2U2LeOsAFTHw+uRRCERLVTKXpkqO8MrT48KcH0+lq0Km
X-Google-Smtp-Source: AGHT+IGVJ3D0fi66PrwnT/nx1+laq+BScd5Q0pPVw4g/A9zpT9mmJMxuIlmLMnq5+Jqc5V6VuZq69Q==
X-Received: by 2002:a05:6870:d152:b0:25e:247:3ae7 with SMTP id 586e51a60fabf-26fe5c07e5bmr1002198fac.34.1723580927728;
        Tue, 13 Aug 2024 13:28:47 -0700 (PDT)
Received: from localhost (fwdproxy-eag-006.fbsv.net. [2a03:2880:3ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c722ae10dsm2564435fac.36.2024.08.13.13.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:28:47 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: move clean up code from btrfs_iget_path to btrfs_read_locked_inode
Date: Tue, 13 Aug 2024 13:27:34 -0700
Message-ID: <338299690e2ca160731b198daa76ca80742f48d8.1723580508.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1723580508.git.loemra.dev@gmail.com>
References: <cover.1723580508.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all the clean up code from btrfs_iget_path to
btrfs_read_locked_inode. I had to move 
btrfs_add_inode_to_root as it needs to be called by
btrfs_read_locked_inode, but made no changes to it.

---
 fs/btrfs/inode.c | 100 ++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b89b4b1bd3da..01a7677fef5c 100644
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
@@ -3815,9 +3845,14 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	btrfs_get_inode_key(BTRFS_I(inode), &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
-	if (ret) {
-		return ret;
-	}
+	/*
+	 * ret > 0 can come from btrfs_search_slot called by
+	 * btrfs_lookup_inode(), this means the inode item was not found.
+	 */
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto error;
 
 	leaf = path->nodes[0];
 
@@ -3977,7 +4012,18 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	}
 
 	btrfs_sync_inode_flags_to_i_flags(inode);
+
+	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	if (ret < 0)
+		goto error;
+
+	unlock_new_inode(inode);
+
 	return 0;
+
+error:
+	iget_failed(inode);
+	return ret;
 }
 
 /*
@@ -5488,35 +5534,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	return err;
 }
 
-static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_inode *existing;
-	const u64 ino = btrfs_ino(inode);
-	int ret;
 
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
 
 static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 {
@@ -5597,25 +5615,11 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
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
 
-	unlock_new_inode(inode);
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


