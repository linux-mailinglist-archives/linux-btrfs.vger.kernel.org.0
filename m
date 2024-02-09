Return-Path: <linux-btrfs+bounces-2284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172C84FB68
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D790A28E09F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40C83CA2;
	Fri,  9 Feb 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyddvRgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD082888
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501658; cv=none; b=dlkT80dyKxse3lkSa7j2nfvWbi6hC/Gk/xRa+yV+EWdDCVc/3g3Q3vZ77Yyl+DYwv5dyugBTWI6UQpTzjHqlzzK0V9HpoXVkE6X3ezvm3rZCI6P6VkgKc9rTg+iA7oLl/psmu8l8MiTetmTfLjZYN+UI06miawL7OBs3Ul0Ub8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501658; c=relaxed/simple;
	bh=Dijv99AoZdPKICkG+DMMMRF+CReH7ytHud7o80N94CA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDONpYyQWd/8axWijbK1LzwkruVwL32ucZj9DHt2VfxXVGMFOJJAJ2KuXQbpQlJufN2A4bhrUZwOFO7J+Ihbmf+5vN485349tgn5BpnFwaI/oSEOjppM/yT6pIgV3MLRSUJhh6tZahUubYm6aliHbjgBjC1mPt21BnQnW0otaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyddvRgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF3C433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501658;
	bh=Dijv99AoZdPKICkG+DMMMRF+CReH7ytHud7o80N94CA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FyddvRgl4ziZlTCRHSMYcRSW/gE6EIJI9tzo1cIpGJYWTe1LILXku6Ov9UNBnwaV4
	 bOC7IDE4567PFSZg6RNWulQ2pjMVfgDLXrcJmUkypJ7w5xaFtkcvWnh4jvh27CR2Sd
	 2a+8OxhmGhsfQqruFKClMKkwWe0/D0cmFW6KCtvFRv9IJgw5BXGV8e3g6Cm+F6ihLn
	 pqm11/G0YS9KUnavB71vnhTVExfKV+x+KFF9qst/Cq4NGcKICn64+n4cugF6gzChJ3
	 yjBiEcLkJxaLPDCKhqltT/E8X+kMXJfQk1xz6zawMpTOoVNqhvRuvc6SlGE9KNvwCc
	 TXnBRhXcA3oVw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: assert root delalloc lock is held at __btrfs_del_delalloc_inode()
Date: Fri,  9 Feb 2024 18:00:45 +0000
Message-Id: <a3014d9834055837c00d4998b313aaa128e1b4eb.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This function requires the delalloc lock of the inode's root to be held,
so assert it's held.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ec8af7d0f166..3a19e30676e8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2411,6 +2411,8 @@ void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
+	lockdep_assert_held(&root->delalloc_lock);
+
 	if (!list_empty(&inode->delalloc_inodes)) {
 		list_del_init(&inode->delalloc_inodes);
 		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-- 
2.40.1


