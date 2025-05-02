Return-Path: <linux-btrfs+bounces-13617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1215AA6FA7
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839D54A825B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D8244676;
	Fri,  2 May 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEsglvbi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56F22D4E9
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181838; cv=none; b=UxeLAxZKTwivv1eqpnX8/Z9nCEvXu7HRvSYJUuwhbA0tSbYqSHeQsrr2Ks+6kUUlZl+zqFVa2UtB5acMfE/5RPfArSxMyTHYoxgZf5osZXE4PoYghzlvounf+M0S9/WK2lQuAsHDW601lnlYo6kajEsf2NubrUcM8Q/Pje/a6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181838; c=relaxed/simple;
	bh=UeKRAu+kaMed4HehNMs1mIhaw9he1KpPwsuFfdqJQ6w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5gWMp2kbPVGKqwXbyZbtKJmiWz8Duuh/IbkoG3Z0Lcy93y1/UOsG8O/hsYtuPyyqCWSOp9BaRBj76kfFvUYHh4iZdZSZCFLjAATqV4DGX+eMLHpCc92jGq7cPC9y+joiPHIYxjpZUscq+aQ4gBWWLv6y21GHXl45oUOl3+7F9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEsglvbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB926C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181838;
	bh=UeKRAu+kaMed4HehNMs1mIhaw9he1KpPwsuFfdqJQ6w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qEsglvbiS5Xfu9l6I4PSnklVsp1N8754pU4BQ11ixgG281VQKxaioZLnU8pJWm4/U
	 X+s7D2xaNCzF1W/KjjljCvWa9T6VgL1EfMr695YX9G8+1p2Dr6xL+gJLfBJzxQxygr
	 tVAHnmqLVXvToukjpRaN/cOtACE9yO/gCqzI9+7IcNYroWjAuiTKWxKWKKRSnNauOP
	 KyEVvZcPugbaJKduHKjO2QLhVZ+BGE5ZElmt/4Bb3quaeIo+Uuu7MZ1BvRj5kIfVoF
	 ShuIQ2LRTVjNGrQsMDTPtDXjgDuyKgLPkquaKAw69mKlH7jW92uUcMS78wSKLEzu2T
	 maLvehfT8AF0g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: simplify extracting delayed node at btrfs_first_prepared_delayed_node()
Date: Fri,  2 May 2025 11:30:26 +0100
Message-Id: <58a5e2d8e91ea492134bf3f4cfeea1de389ac802.1746181528.git.fdmanana@suse.com>
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

Instead of grabbing the next pointer from the list and then doing a
list_entry() call, we can simply use list_first_entry(), removing the need
for list_head variable.

Also there's no need to check if the list is empty before attempting to
extract the first element, we can use list_first_entry_or_null(), removing
the need for a special if statement and the 'out' label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a1ac35bc789a..c7cc24a5dd5e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -294,18 +294,15 @@ static inline void btrfs_release_delayed_node(struct btrfs_delayed_node *node)
 static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
 					struct btrfs_delayed_root *delayed_root)
 {
-	struct list_head *p;
-	struct btrfs_delayed_node *node = NULL;
+	struct btrfs_delayed_node *node;
 
 	spin_lock(&delayed_root->lock);
-	if (list_empty(&delayed_root->prepare_list))
-		goto out;
-
-	p = delayed_root->prepare_list.next;
-	list_del_init(p);
-	node = list_entry(p, struct btrfs_delayed_node, p_list);
-	refcount_inc(&node->refs);
-out:
+	node = list_first_entry_or_null(&delayed_root->prepare_list,
+					struct btrfs_delayed_node, p_list);
+	if (node) {
+		list_del_init(&node->p_list);
+		refcount_inc(&node->refs);
+	}
 	spin_unlock(&delayed_root->lock);
 
 	return node;
-- 
2.47.2


