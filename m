Return-Path: <linux-btrfs+bounces-9114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0209AD9F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 04:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51F7283123
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 02:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56113665B;
	Thu, 24 Oct 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="c9kPkx6r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA6339A0
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737131; cv=none; b=dLhDzssJWtMxUNxF87mXgIvmG8t0pKv2O8ERaHS/kLaudFbGSSyVFd8EXawisCBrCH0CsYQ3L/Ks2jZqB1LwPIzDQZFUx3g9JAQRnE1ta36fa2bg5/kAcPe5jCdK5h657A2Y17ZmaQcr3LX1MSYZFPAd2th1tOpGz0a8b7FgL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737131; c=relaxed/simple;
	bh=dHlybn9VUnHMzYYj3XLNv4YOARHbgp7CfxNeS4+TVhs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OD46wdnUkAinYNTwycGZihk/CIeOZkEqAHuK2KUZChWm4YBI0ndsgg/d8x67EgRzcqauTDhw7QAutqpG4sygBTc1i2jENb9dSSDcRfo6lPfR2KLH+vleyJsUkU/Zogcq+qshPk/oFfYghUhR0L5dywQYfDO26XjkuIbdB0R3Iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=c9kPkx6r; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1729737127; bh=dHlybn9VUnHMzYYj3XLNv4YOARHbgp7CfxNeS4+TVhs=;
	h=From:To:Cc:Subject:Date;
	b=c9kPkx6rt9s04/aFcXCrq+Z+lSMnbeOfOGl9MA8mgIL+17TCR8hhI71UWeXXXb7yd
	 /o7kd6M7kIUKFgO0ZTnKdhI71xZY/1O51sofLhnoXcPv48QkYMnfbPWLbPvuWJBUuQ
	 t2y0ftn1Qdzyf3mPRFES+A67HaWKtFloMy+xEcnE=
To: linux-btrfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: reduce extent tree lock contention when searching for inline backref
Date: Thu, 24 Oct 2024 10:31:42 +0800
Message-Id: <20241024023142.25127-1-robbieko@synology.com>
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

When inserting extent backref, in order to check whether refs other than
inline refs are used, we always use keep locks for tree search, which
will increase the lock contention of extent-tree.

We do not need the parent node every time to determine whether normal
refs are used.
It is only needed when the extent-item is the last item in a leaf.

Therefore, we change to first use keep_locks=0 for search.
If the extent-item happens to be the last item in the leaf, we then
change to keep_locks=1 for the second search to reduce lock contention.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent-tree.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..54d149a41506 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -795,7 +795,6 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	if (insert) {
 		extra_size = btrfs_extent_inline_ref_size(want);
 		path->search_for_extension = 1;
-		path->keep_locks = 1;
 	} else
 		extra_size = -1;
 
@@ -946,6 +945,25 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			ret = -EAGAIN;
 			goto out;
 		}
+
+		if (path->slots[0] + 1 < btrfs_header_nritems(path->nodes[0])) {
+			struct btrfs_key tmp_key;
+
+			btrfs_item_key_to_cpu(path->nodes[0], &tmp_key, path->slots[0] + 1);
+			if (tmp_key.objectid == bytenr &&
+				tmp_key.type < BTRFS_BLOCK_GROUP_ITEM_KEY) {
+				ret = -EAGAIN;
+				goto out;
+			}
+			goto enoent;
+		}
+
+		if (!path->keep_locks) {
+			btrfs_release_path(path);
+			path->keep_locks = 1;
+			goto again;
+		}
+
 		/*
 		 * To add new inline back ref, we have to make sure
 		 * there is no corresponding back ref item.
@@ -959,13 +977,15 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 	}
+enoent:
 	*ref_ret = (struct btrfs_extent_inline_ref *)ptr;
 out:
-	if (insert) {
+	if (path->keep_locks) {
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


