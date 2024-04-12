Return-Path: <linux-btrfs+bounces-4194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E68A31C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9931C22E2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435BA1487DE;
	Fri, 12 Apr 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZiPyhP2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FE1487D0
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934209; cv=none; b=tbFgjIfSniMXMTPnMqoSBALN18GfTRddcNnWNIXd28ZnXOAYRY9KRTVZtzTrWlAzd6ezI6R804rtVFo+rfgdbJJ/ovSrEQbsUpUOl0TNNZCJjnhTIk+wUPT0lsRmqbeAczx/6wwkGGxu+5ac2ZRtEm1xeeD6nY6SQPao/YWN8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934209; c=relaxed/simple;
	bh=NkcKC0WVwbG9P2OPL4ZSfIr0uUaWT87BNCfCi+YRM8E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBuyHfRon+vbVYlL8VmxL75qyjyga5wp0cbyWOQq8pz+YKuKvAf2RbuaJXvW40fEQAucqznxGTl1o1bDwdhxhmm3ZaNWiiDy3IR9oizbhedZLqJ5t/sRwH6HKQY2xsbo9+GEwz16jC5rRwf4m/Cbw1JFf9PFHw35liKDf5V3cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZiPyhP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CD4C2BD11
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934209;
	bh=NkcKC0WVwbG9P2OPL4ZSfIr0uUaWT87BNCfCi+YRM8E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EZiPyhP2nm2ZsTM5Lmebf4hrZD3jeGj1IL8ioDa+QmaSBccoNJKJI63VaikLHJ+t/
	 J9G3W/zv09wl6hNPyelbswBmoM/o5YX8ZF/t6yzcLKACkEqAw9ly8aANNruuFnQD+C
	 prxYyES6WhbVAMZSxH3ZwxX6vSS7xcUGV+KaCPSs+ae++v3vKV5C4FJ3T9Z+dmsMZf
	 NyTqeedYxxo3AjfBExtzSBQl0HILH1fFOLlJgDzZDkejI8UIK7a9VIppEJ9KAv4BmC
	 uDFrC2tffEwTh5XhlOK6t1Uszz4ZjhJMDt7LJR8XqtdP9YegMDcrbRPnFQGlb9GN4y
	 Qao9ffC1Ccozg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: simplify error path for btrfs_lookup_csums_list()
Date: Fri, 12 Apr 2024 16:03:18 +0100
Message-Id: <d5576134584be460ba386627ee5853fcca5c2edd.1712933006.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712933003.git.fdmanana@suse.com>
References: <cover.1712933003.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the error path we have this while loop that keeps iterating over the
csums of the list and then delete them from the list and free them,
testing for an error (ret < 0) and list emptyness as the conditions of
the while loop.

Simplify this by using list_for_each_entry_safe() so there's no need to
delete elements from the list and need to test the error condition on
each iteration.

Also rename the 'fail' label to 'out' since the label is not exclusive
to a failure path, as we also end up there when the function succeeds,
and it's also a more common label name.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c2799325706f..231abcc87f63 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -487,7 +487,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto fail;
+		goto out;
 	if (ret > 0 && path->slots[0] > 0) {
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
@@ -522,7 +522,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto fail;
+				goto out;
 			if (ret > 0)
 				break;
 			leaf = path->nodes[0];
@@ -557,7 +557,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 				       GFP_NOFS);
 			if (!sums) {
 				ret = -ENOMEM;
-				goto fail;
+				goto out;
 			}
 
 			sums->logical = start;
@@ -576,11 +576,12 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 		path->slots[0]++;
 	}
 	ret = 0;
-fail:
-	while (ret < 0 && !list_empty(list)) {
-		sums = list_entry(list->next, struct btrfs_ordered_sum, list);
-		list_del(&sums->list);
-		kfree(sums);
+out:
+	if (ret < 0) {
+		struct btrfs_ordered_sum *tmp_sums;
+
+		list_for_each_entry_safe(sums, tmp_sums, list, list)
+			kfree(sums);
 	}
 
 	btrfs_free_path(path);
-- 
2.43.0


