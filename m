Return-Path: <linux-btrfs+bounces-9087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249E9ABEF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 08:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14CF1C214C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E914A615;
	Wed, 23 Oct 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="ZP8gb9O2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428C14A0B5
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665509; cv=none; b=W9oFfIhBvOIKpjhc3d011yn32G0arVWpUs9cpkJBikzFiAinVUR9vIMpgwyy4Vg8Ql44G+TEAlfULvR+hmKYckTTT/0Niw5MBrAyBY34vBXJx5KE72Pf/87lOgFMyl4MQwj+6TgoRZtQR5MlMeoaYfQXIpMxqrnxpr5zG0Hc9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665509; c=relaxed/simple;
	bh=LhGLyjvHg+we26d80+bPfj84iLqnPd5eWm6ONbpnIBY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=T2m9kaxBAM4FsQ01lUZfC81SY8xE7qLM5EggKoGl5KuFHBVwl6CDYRppn4bcrWcKk33BGpHhIrwdscBQT1zWnivYBXC4fZtGSexTHQ6N4l07PNtAcfdKIJak1cQV5sVaPcysMMAeCODxcx76kD7LH5xemI5UAtWmuwxRsk6Lc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=ZP8gb9O2; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1729665500; bh=LhGLyjvHg+we26d80+bPfj84iLqnPd5eWm6ONbpnIBY=;
	h=From:To:Cc:Subject:Date;
	b=ZP8gb9O2QV/V16OJn3wkIPH1tAilmby9teFEj5cad38pR17ODi45R34VmOoMe4DAv
	 kNm3AifYb1v1lDskhClFmRBfdbADa1qU0uDTK60zJ8uPmvQlMhRfoLb0z0V/iF4iYv
	 8rqvq8I0L0yT00Z3gpH0EkrJEBodAYUpOhnWdiUc=
To: linux-btrfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: reduce lock contention with not always use keep locks when insert extent backref
Date: Wed, 23 Oct 2024 14:38:18 +0800
Message-Id: <20241023063818.11438-1-robbieko@synology.com>
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

When inserting extent backref, in order to check whether
refs other than inline refs are used, we always use keep
locks for tree search, which will increase the lock
contention of extent-tree.

We do not need the parent node every time to determine
whether normal refs are used.
It is only needed when the extent-item is the last item in leaf.

Therefore, we change to first use keep_locks=0 for search.
If the extent-item happens to be the last item in leaf,
we then change to keep_locks=1 for the second search to
slow down lock contention.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent-tree.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..7d5033b20a40 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -786,6 +786,8 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	int ret;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 	int needed;
+	bool keep_locks = false;
+	struct btrfs_key tmp_key;
 
 	key.objectid = bytenr;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
@@ -795,7 +797,6 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	if (insert) {
 		extra_size = btrfs_extent_inline_ref_size(want);
 		path->search_for_extension = 1;
-		path->keep_locks = 1;
 	} else
 		extra_size = -1;
 
@@ -946,6 +947,24 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			ret = -EAGAIN;
 			goto out;
 		}
+
+		if (path->slots[0] + 1 < btrfs_header_nritems(path->nodes[0])) {
+			btrfs_item_key_to_cpu(path->nodes[0], &tmp_key, path->slots[0] + 1);
+			if (tmp_key.objectid == bytenr &&
+				tmp_key.type < BTRFS_BLOCK_GROUP_ITEM_KEY) {
+				ret = -EAGAIN;
+				goto out;
+			}
+			goto enoent;
+		}
+
+		if (!keep_locks) {
+			btrfs_release_path(path);
+			path->keep_locks = 1;
+			keep_locks = true;
+			goto again;
+		}
+
 		/*
 		 * To add new inline back ref, we have to make sure
 		 * there is no corresponding back ref item.
@@ -959,13 +978,15 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 	}
+enoent:
 	*ref_ret = (struct btrfs_extent_inline_ref *)ptr;
 out:
-	if (insert) {
+	if (keep_locks) {
 		path->keep_locks = 0;
-		path->search_for_extension = 0;
 		btrfs_unlock_up_safe(path, 1);
 	}
+	if (insert)
+		path->search_for_extension = 0;
 	return ret;
 }
 
-- 
2.17.1


