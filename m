Return-Path: <linux-btrfs+bounces-13799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A097AAE7BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030FD4E3112
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910E628C852;
	Wed,  7 May 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFtsaENc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FC28C5C0
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638602; cv=none; b=sh8zjVtsoXEbFlQMHTCEZV2kU6Fe0avLCpJcV9bVR75xs/CGwiPx4eWGSny3h2EM3Utud4mvnTfnxKlMH6Fp+94BVZhn12niLgYAHOrvLO6uyI1UY5HkWV4cnH7xERHShZ0MAnz22dFg6Qc23mw77g7s/iZir0hnF85UoAenokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638602; c=relaxed/simple;
	bh=n1ILsjpEqrQ1DIJ2N952/MwJ4AMeRGVJ6+6Zhnyv2hM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7EHtGjDM8umhVzne+jfmucyzj5Z4fuhw+EBJXAySqpmr8OD9uQxQG12jWNfKS4vBBatByfocqEboHsk7AG3/d/RxYXUib3EvQNoPwiFix6PodFpOlZwdo72yTZAodCu4bCsIeY2pOJfR7mi7YAKus4kltkBvIybHLYrM8+qOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFtsaENc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B7C4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746638602;
	bh=n1ILsjpEqrQ1DIJ2N952/MwJ4AMeRGVJ6+6Zhnyv2hM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lFtsaENciuQtYO9hv3yKUw94Z5+0n9WkDIX6eDAwhlCRJe6p/iJEwYrSbIpuooYRE
	 zxqsFBH43u6EkVBdshT600lW70zCZiQxvaAbficy/L40Qq95b98KrGHtuUew98r+m9
	 Qsc2kWz7PwrfRxfLeo+eK4Jx04c7hwjpVCzjx3eQf1COdBaMacyRaUtspk8/ygtzxY
	 7qS5QqoYGLQjMyQNzWu2uJDcYSD5kBE8r7mHNfqPqEsk5UpSMkyODi7PYfFOt8OrDB
	 w+hdlgJayphhxBp4qMKvYivPwvz/p/QUqxrQSHGpnxRwomJOv+HcyJ1OzHFBKi3nIt
	 Uuusz8RX4HI9g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to allocate ordered extent
Date: Wed,  7 May 2025 18:23:13 +0100
Message-Id: <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746638347.git.fdmanana@suse.com>
References: <cover.1746638347.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to allocate an ordered extent for a COW write we end up leaking
a qgroup data reservation since we called btrfs_qgroup_release_data() but
we didn't call btrfs_qgroup_free_refroot() (which would happen when
running the respective data delayed ref created by ordered extent
completion or when finishing the ordered extent in case an error happened).

So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
ordered extent for a COW write.

Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ae49f87b27e8..e44d3dd17caf 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	struct btrfs_ordered_extent *entry;
 	int ret;
 	u64 qgroup_rsv = 0;
+	const bool is_nocow = (flags &
+	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
-	if (flags &
-	    ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
+	if (is_nocow) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
@@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 			return ERR_PTR(ret);
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
-	if (!entry)
+	if (!entry) {
+		if (!is_nocow)
+			btrfs_qgroup_free_refroot(inode->root->fs_info,
+						  btrfs_root_id(inode->root),
+						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
-- 
2.47.2


