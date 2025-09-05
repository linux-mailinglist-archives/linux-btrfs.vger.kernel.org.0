Return-Path: <linux-btrfs+bounces-16653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52236B45D92
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B0EB610C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D07309F19;
	Fri,  5 Sep 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0+8S4uL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663D2FB0AB
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088646; cv=none; b=Eo2CR71g+Y54jYObk2fcFR9y4Snsx/YzRi8cxN6zmIaFb6UqWtotQZ19CctlCsYaoqQwaPkTJOtXuDJ7gdqeWkh+DA5oyAq/uk9JPHiL8G3mHUPufQRHwokvzpKMtjgLBK3Z8OuIm8BBF1pCK2FLSqFCxbJFgcdMdOb6KQqIx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088646; c=relaxed/simple;
	bh=LK9Apy8r1lbNeId6cYnEYEcEdKz0SWncXf78dYQunQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3Zd1GWA6ZGcNppCfjPJB3+yQVqdrCvAQUPr1+eNdblHxKkha8+EHoaEkG5lsKzN7heGLd/jRMWH8fp3YORu8uWXcI58P42qT9LQ9oXcyxbBLto8IolkjIn/qXODNekeZ8pGO6EuMW3NuukQDj6AHQ4lgmZtrSSyNvwUzp7RtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0+8S4uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B1AC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088645;
	bh=LK9Apy8r1lbNeId6cYnEYEcEdKz0SWncXf78dYQunQY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i0+8S4uLCe2jzrtfepfVMpa2+KO7z9RYgYHour/XJncQ0/JKnL/m4Nk6lRAa10mdN
	 Rw6wpbSkNzHbXxK9+Nur9RV33bbjWGmp2Sp3XxSgZr6iRoBKt2Hw9CF33fbgwCv6Vx
	 2uKAP6aYAShLTXXVfSTHCyO0gl3MvEi93aFcs5GyzssJFtVtTWpJKq8SADXNdCvSI2
	 2DrwIf2AFWBQR0vB++m08vk8/QhwIZele7BuGeBSvj4eLRArh3XEjgB7IcDgHxgxR8
	 ObIJtU5Y9mXlGVeDPhbDhPVeeEqA2AZa7Jn1NFadw5dF6Dn+Gh4v2xZtSABFLFfqQh
	 cSN66Abt+zivQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/33] btrfs: always drop log root tree reference in btrfs_replay_log()
Date: Fri,  5 Sep 2025 17:09:57 +0100
Message-ID: <e93740b6b73fe149827e6706683424b8e3d160ef.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we have this odd behaviour:

1) At btrfs_replay_log() we drop the reference of the log root tree if
   the call to btrfs_recover_log_trees() failed;

2) But if the call to btrfs_recover_log_trees() did not fail, we don't
   drop the reference in btrfs_replay_log() - we expect that
   btrfs_recover_log_trees() does it in case it returns success.

Let's simplify this and make btrfs_replay_log() always drop the reference
on the log root tree, not only this simplifies code as it's what makes
sense since it's btrfs_replay_log() who grabbed the reference in the first
place.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c  | 2 +-
 fs/btrfs/tree-log.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7b06bbc40898..8dbb6a12ec24 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2088,10 +2088,10 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 
 	/* returns with log_tree_root freed on success */
 	ret = btrfs_recover_log_trees(log_tree_root);
+	btrfs_put_root(log_tree_root);
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Failed to recover log tree");
-		btrfs_put_root(log_tree_root);
 		return ret;
 	}
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ab2f6bab096b..4d34aee0cafa 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7586,7 +7586,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		return ret;
 
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
-	btrfs_put_root(log_root_tree);
 
 	return 0;
 error:
-- 
2.47.2


