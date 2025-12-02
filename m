Return-Path: <linux-btrfs+bounces-19472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB5C9D113
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97BF94E3DE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F02F83DC;
	Tue,  2 Dec 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7J7TZ/C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED852F691A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710506; cv=none; b=o446oKQQbgJJveWhCjpZcRQO+1OcCSwPJKEvz2Rh5RHhMRjiuUjO8CLqD8f9jgmZE0r9mt2aifQpcC6EnXB8r61Qg4S2Uu7Ym3KAsE14e/GGLVfHRJ8osl+EaK8dIUxBQSMeujPyi3r/a7D6m3MsfYzzTs4DQO3sXjev1LojqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710506; c=relaxed/simple;
	bh=TM2t7/JewdCIbJpFFoRrZFBk93KHzjYWRBnqx9ug0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B34LsdJoMDswViDibddS+yUk1mdesjt6ovzJJEqsBFP1qvBpHF++ec6LSn/cydOowOx/eUE4JnO8Q2CitZ3SDsflk9emmldV67+wrdoMLeqJlRQtpYTAnJUwpuPpqoSHvpdZsdDBA5islP7eGKAyvrD50KzPc3cjvUWmNHdPtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7J7TZ/C; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-787c9f90eccso63135657b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764710504; x=1765315304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu80t9K5KQHRIGahRc1OZ1SXkOxy+qQwIHUTM/97yVQ=;
        b=T7J7TZ/CAT5KTyEa/TkSkyVhcpBliCp7/119Xcadm1hNIsUPhmE8Hb3ZamWwjUQaRd
         l30Uj47+HJuJM/0Kd6gVyWJtU5K3G05ZoTvQfbKeOal54z3HR7XZ8K0QI3fF7Vahcgyz
         7T6Ni25zQPuJn1Sd+eX8YpFf6VxhAIUBXRqmjxA3mqrr73Mxm+fDuvERESjw95MQgsXh
         yF8BhhfGpvyaoBDpVOs1olkTob8wQNxc2Jawm6O07/HN+CLVgCvAirOUwqGThFnGjbAj
         yKzEEoxDvtsR0EtDr1mDDBCGsw9EsUSr7VJUr0C9cCl2GfuNoS/zhYNBU+IuQ5DTxS0r
         yFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710504; x=1765315304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu80t9K5KQHRIGahRc1OZ1SXkOxy+qQwIHUTM/97yVQ=;
        b=REdLhjWn4XvjRJHX1hEx8qmf37Jx3nOu31dg3ohYI2L8uWmL896L8uM9Rb4paP1u05
         kGVdEOKIMJ59QpdXDEWq4rs35ataZjITlU4gcgUqocwzVHZus4hBjmD76jtszXEZOMO9
         2MubNeeTypllf74lxYAPGW0OIEHF5GkJxNT8Ax3PPFScB5B63yrAzWo5cUwwzD13GN0y
         NXmw9TGqLihitoUbxqpQjwzXfqx9IEyVOvkHo+iY+fDL2kNC/qRRvvXJSGe179mdxmOW
         vjXXPxcRvr5fz+l5Y7RJ4MrNHOe/Wj93+pbTvd3lgOCqWZuTxNnqpIOMlxspi1PaaW/X
         ER2w==
X-Gm-Message-State: AOJu0YzDndcqhXU1D/7fwGrwGAhzGRB0crWhk/EQa+Qt7ggf9Se851WM
	TzgkmXBwDfSYDEikYTXOoLDWDz+mA2nF6LOUb1Ow+IWt60JhQmkqRHEH4VLDwZBx
X-Gm-Gg: ASbGnctFYB4FgjBsIzQfUIc8xkZuZcrt6LE8HmWxAnOqFNLaUVXzRqJgC4LyL7sMvk4
	K7D7NsZIuZmH87bWwjbAzomCGpiwtKOgsxEW0oNsXmPnNv2rC9oQeFIR9QwqSTLOvAV8t2iMfLP
	R7UW826HeL54hEMxY9nIyz7zqMSGgiCjfKxOGpALHcbwbb4Tk2F5ujs5vDD9X4FpreVBiAr4aLY
	/CsZRHHYUcr7OJrSDftwruIVz9Zf5PpCuO4eGRD2pQ1SP2bCYb01/MFualaz3xxlKgKxC8FZZwt
	EWspc1pSZ8rDTo1/sjQLYI62pi9/urxLTA7v04Q1dTW3wp8i/h6V/27v4I/zw+74wNgsqHG77Bo
	TyxpQ0CXbaFjMsLpBLrlQ8lTtGfYl1U6To/3Dt2Cy71zHxoaQc/75XRdzt/Y1aNsExkEGgd+wld
	ULai1teze8kT4MLE9hQg==
X-Google-Smtp-Source: AGHT+IFlb0q1ZFf1E+uFpMyhmu4XTSQv9UC7do2wM2eQvhd68+3BBHQNfIVwNcAcntoH2dtuS7zwNA==
X-Received: by 2002:a05:690c:6d0d:b0:786:56ec:e3cf with SMTP id 00721157ae682-78ab6fb9cf9mr258721257b3.61.1764710503847;
        Tue, 02 Dec 2025 13:21:43 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050d98sm6663187d50.2.2025.12.02.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:21:43 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
Date: Tue,  2 Dec 2025 13:21:33 -0800
Message-ID: <678e357c7c7f87e6382ba6da048c2af1a3a2e02b.1764696103.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
refcount before acquiring the root->delayed_nodes lock.
Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
moves refcount_set inside the critical section which means
there is no longer a memory barrier between setting the refcount and
setting btrfs_inode->delayed_node = node.

This allows btrfs_get_or_create_delayed_node to set
btrfs_inode->delayed_node before setting the refcount.
A different thread is then able to read and increase the refcount
of btrfs_inode->delayed_node leading to a refcounting bug and
a use-after-free warning.

The fix is to move refcount_set back to where it was to take
advantage of the implicit memory barrier provided by lock
acquisition.

Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 364814642a91..81922556379d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		return ERR_PTR(-ENOMEM);
 	btrfs_init_delayed_node(node, root, ino);
 
+	/* Cached in the inode and can be accessed. */
+	refcount_set(&node->refs, 2);
+	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
+	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
+
 	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
 	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
-	if (ret == -ENOMEM) {
-		btrfs_delayed_node_ref_tracker_dir_exit(node);
-		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (ret == -ENOMEM)
+		goto cleanup;
+
 	xa_lock(&root->delayed_nodes);
 	ptr = xa_load(&root->delayed_nodes, ino);
 	if (ptr) {
 		/* Somebody inserted it, go back and read it. */
 		xa_unlock(&root->delayed_nodes);
-		btrfs_delayed_node_ref_tracker_dir_exit(node);
-		kmem_cache_free(delayed_node_cache, node);
-		node = NULL;
-		goto again;
+		goto cleanup;
 	}
 	ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
-
-	/* Cached in the inode and can be accessed. */
-	refcount_set(&node->refs, 2);
-	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
-	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
-
 	btrfs_inode->delayed_node = node;
 	xa_unlock(&root->delayed_nodes);
 
 	return node;
+cleanup:
+	btrfs_delayed_node_ref_tracker_free(node, tracker);
+	btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
+	btrfs_delayed_node_ref_tracker_dir_exit(node);
+	kmem_cache_free(delayed_node_cache, node);
+	if (ret)
+		return ERR_PTR(ret);
+	goto again;
 }
 
 /*
-- 
2.47.3


