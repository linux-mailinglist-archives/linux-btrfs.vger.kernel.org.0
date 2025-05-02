Return-Path: <linux-btrfs+bounces-13618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E64AA6FAA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E28A3A2F32
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E902244686;
	Fri,  2 May 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyTUBavy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938224467A
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181839; cv=none; b=knp1Yhct3EZc/Mlh0J8Fvx0skZWWBZj08uZYwbmhIqXqIlZ54duI+5n0i58u+PZ1u7hdp9aK+5NsEeTlCmNopMikym70XFOq51S4FnlJvEa439wQ9c2QESIVHPOATlaFvQmFSlpJkdXmtS5Sm7GNFM/e/zyow/4ddOQ+15Yqwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181839; c=relaxed/simple;
	bh=etgquxK5I0OcbstADF/AKyuniP+E5/YEV0oOlVAAvYc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUwV7KObt2ZKCweH7AEosKmL/XnEHEgv6Y1aszcwGH7+GaXHeFZm3U7WTcxk8PSncCoiRuvp+3dOOXOb/a0WgGTMmDswCO7Uc6wmH3XrMCxvhxFYrL+Ty4rSfYnJGoyid5ToCWI6sEePyc8Wkt3bRF/qkDwPC6vRRgi6s+qFb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyTUBavy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0060C4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181839;
	bh=etgquxK5I0OcbstADF/AKyuniP+E5/YEV0oOlVAAvYc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pyTUBavyvWfPQG+1diKQP9CDDBxnxO9334X5O5E9hHOqfzoiy2typlRElyhno9EFZ
	 slUds/4IDRKwDQJoS8VPhTvSicqMNTivjVYAqHBWi9ooQA4E5tI0vjLm4eHk590fTk
	 SeWt1ViRgZY86u/W7I1br5Iuv0GXNuzQNvvxK44iG9MYYQsy3PNi1qsA3roVqndP47
	 Icjtn87YBxQldiE7yW7sW3LNzwN7bk1vKV7y/HFZeCekD5ys4NJOaq7m+ipBJ0F75k
	 Fyz4NSSpP9XGWVTeLkfceyzOMp9zDI8meV4CKTH4T4wbdIWb2yIjX2H18uUKX9n1fe
	 TP2+GEbPT50tw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: simplify csum list release at btrfs_put_ordered_extent()
Date: Fri,  2 May 2025 11:30:27 +0100
Message-Id: <150815616088623df7425d43e1f27aa13c3989b1.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of extracting each element by grabbing the list's first member in
a local list_head variable, then extracting the csum with list_entry() and
iterating with a while loop checking for list emptyness, use the iteration
helper list_for_each_entry_safe(). This also removes the need to delete
elements from the list with list_del() since the ordered extent is freed
immediately after.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6151d32704d2..ae49f87b27e8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -607,23 +607,19 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
  */
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 {
-	struct list_head *cur;
-	struct btrfs_ordered_sum *sum;
-
 	trace_btrfs_ordered_extent_put(entry->inode, entry);
 
 	if (refcount_dec_and_test(&entry->refs)) {
+		struct btrfs_ordered_sum *sum;
+		struct btrfs_ordered_sum *tmp;
+
 		ASSERT(list_empty(&entry->root_extent_list));
 		ASSERT(list_empty(&entry->log_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
 		if (entry->inode)
 			btrfs_add_delayed_iput(entry->inode);
-		while (!list_empty(&entry->list)) {
-			cur = entry->list.next;
-			sum = list_entry(cur, struct btrfs_ordered_sum, list);
-			list_del(&sum->list);
+		list_for_each_entry_safe(sum, tmp, &entry->list, list)
 			kvfree(sum);
-		}
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
-- 
2.47.2


