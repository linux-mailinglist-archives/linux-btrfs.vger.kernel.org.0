Return-Path: <linux-btrfs+bounces-19702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC239CBA277
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA7D30A302B
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97B1DE4CA;
	Sat, 13 Dec 2025 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVWYX9d5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F83B8D68
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589191; cv=none; b=OQt7hN8a4XERslN0yh6V3Hr8IxWLCmJxTHU8l+gU73oHHyzvCHVN0zsLXyzHNcIoiLH7qcCS0sZWXCIuqDKjeMpUW3jqJNaSAF9VQek6YvQ+NAfgJ5K3iTM/PJo1H8LCctAOID1/XxqXfU4Fn9pfAoSudYZ3dUmQxb6fw8LPQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589191; c=relaxed/simple;
	bh=tnSg7pmr2ePr4Gs95IYNnT5IyOxlT7HBToNRVkkVbGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V717BsZav52f+QcIeSCxFSzyKFTW6Hx4W3+qrSXufn0fhhT8YDxJF676sle87hV8D+oqZWgzpVQT+hklfsfqa16+gYantcTxeks6rUV23uNV3NkbKSv3wh8Q3FH6/PIYvGO6e4pIHUrsurRBGVx1sL4L0CKyubAVKD/4cRddLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVWYX9d5; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-787da30c53dso18022007b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 17:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765589189; x=1766193989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4zKXpRCAm8Ny4b4ixfp8bVdrbOaBTFL0orLm2Jlq/w=;
        b=YVWYX9d5saPldl39xHU39ou0EqVTLT1zJaHMAqCOlCBQEVYGilQtITvJjjYf6lk0lS
         H6icBV786PlmnjnPYluo1t3lzkiuByGl3NUz5Q8SKVWuH3zxljhjbcWHXLUs4ucip6jy
         Rnb9dSDSg1SNcTekibjI4MFTHGFQZpYR3dwVuiP3FH2M31cHJr7+ZaRrMCgXwzFUAyp0
         qqK59EKi/srdEJg3FxlvRXU73WkOeM6yf1scMLUdgNtfEKCdp2zVATvuo8buwGAh+LUd
         VHux2loneICV5qffnqMzw6UZ4717kPc+zAwOkhU7nnvEfzOPhqiR6XKHxgDahabzK3h/
         L2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589189; x=1766193989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4zKXpRCAm8Ny4b4ixfp8bVdrbOaBTFL0orLm2Jlq/w=;
        b=PptrBnvovDR2hUUaxtgTrtdXhNPPPY4uityolnyQcX0tKR/JQyMj0AZhjUt3QhOjop
         LNlN1XniSF6emIVmawUZDGGhlYZyH/408+R58UmtWjxQwtmgcjEbNVidjk8zgCPs6Ez8
         X3yBjkKNETxjwyV94e/QkP/y4JARRgBEtScWbFCIdabTJYC7UbXB4gyoAVFBZO8sq5dX
         xmX84JThTV+ew6xp7ltGBEQ+wtDiP3+SuDIW3nv5hX8DOOHlhlY3KTVt5PdMA7kvN+P/
         XfnN65UgWorMzqpcLMVfdaSI/GAOH5rEbP33Y4cD+TxOMpqdMSDJkNkCisv+OY79ODJZ
         n5Bw==
X-Gm-Message-State: AOJu0YzeUsYye82QiQQKt+fBxj9RP7fd8oDBI+tmjQOFEiceFwoFvY7i
	y/asfV0igt4ox2BsmZ3t0FeXf8w8Q3h7eWMKvlDl+HNexMiUXqJMxnigXnxh/KUX
X-Gm-Gg: AY/fxX4tQVZsA71Gzjq6vVkZ352IfOQfST5Q7yXMvekqZ22Q3vvBnEXUfHaRds+KJ3g
	DtwouHgUp5iKro+BdJvC7twOo/1WaaPJ4rfcuBteVpovV8Zb+wRFoUacpI68ktJPjPHHIDlJ3Eb
	mEMpj1sHtogRGU5VXjODgGqUy1LblxQiTdvUpdYqpYNj2sLuyWYOL+lzvOExDqyn6jL6k332f5m
	vedbnfAQuD3MzfSiOBYvGb7f5zO5t32PYvOy3eBQXV6ohAMoaJ0shBF7V/JREm3DnEuOOffb9cX
	Vv/lS24NDlXTKnrekrVPnPRJ3TYd9D5SP1iX4gCQji0jJ1hWlsICIaaCuCs14EZ0JBYeqldd4rK
	WHZuolM6lnk5Fw8TkZnZLls0zTG95g63JnkPUipwbEp6eBrOIPMw62h5Q+KTE/dBcrZ4TkCaQzX
	H0Mf5S6ci36Q3xYY4O5Fc+ARlHAWda
X-Google-Smtp-Source: AGHT+IGYIoTQtWLfO9U10lvPJAYc65XN5UBTUUPMJPWUJ3CSwSfhKL8l2xJ4So2sFpK+iXoCwZeAnA==
X-Received: by 2002:a05:690c:680c:b0:78d:b1e9:8600 with SMTP id 00721157ae682-78e66d1e7d5mr35903677b3.22.1765589188786;
        Fri, 12 Dec 2025 17:26:28 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748ef7aasm2555697b3.18.2025.12.12.17.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 17:26:28 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: kernel test robot <oliver.sang@intel.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
Date: Fri, 12 Dec 2025 17:26:26 -0800
Message-ID: <7c89417ac3352ce3cb0a6373a1746155c1e2754d.1765588168.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, btrfs_get_or_create_delayed_node set the delayed_node's
refcount before acquiring the root->delayed_nodes lock.
Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
moved refcount_set inside the critical section, which means there is
no longer a memory barrier between setting the refcount and setting
btrfs_inode->delayed_node.

Without that barrier, the stores to node->refs and
btrfs_inode->delayed_node may become visible out of order. Another
thread can then read btrfs_inode->delayed_node and attempt to
increment a refcount that hasn't been set yet, leading to a
refcounting bug and a use-after-free warning.

The fix is to move refcount_set back to where it was to take
advantage of the implicit memory barrier provided by lock
acquisition.

Because the allocations now happen outside of the lock's critical
section, they can use GFP_NOFS instead of GFP_ATOMIC.

Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
Tested-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 364814642a91..8f8ce43d18b8 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		return ERR_PTR(-ENOMEM);
 	btrfs_init_delayed_node(node, root, ino);
 
+	/* Cached in the inode and can be accessed. */
+	refcount_set(&node->refs, 2);
+	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_NOFS);
+	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_NOFS);
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


