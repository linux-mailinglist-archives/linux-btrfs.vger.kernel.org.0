Return-Path: <linux-btrfs+bounces-14375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362EACAC8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8519189F595
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD520E330;
	Mon,  2 Jun 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA1VP/Wd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7A20C49E
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860408; cv=none; b=uTDeZTNBbu9IFIGLBhS8ullpVltfDJO9LHt70snsvUOTjtrjMTz8j9M1E+Qkzevtml1OcumTZ3NToL2ciCLM58SQ4+vAxmnHa/j+EUX8jP7FtAKKGbLc1bHvPrVsSMoLZ0yY5kf5LyhdFPL6X/zxC5EwPUYnhyiU+cicTL6i+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860408; c=relaxed/simple;
	bh=Rtk8m0CG6pRsAS/KyLAsDYR56l3Qbx/Pd/VYT5PBy40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr1RRHxy1EnMrb1MbqHeTfX0RShvM11v4o3mDm1pey5H+HzxB2L2AIc1tuRlKcpv1SPn0lLdHjIlVe3dBAROGtFDDp9rEHI6ZWeM9EdjXzd4o0lrm0SQwXcP3QgSm/0v688WV8cVoBpaBFXBaZwO4yHuDSSPfbDv5lb75v0PSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA1VP/Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF43AC4CEED
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860407;
	bh=Rtk8m0CG6pRsAS/KyLAsDYR56l3Qbx/Pd/VYT5PBy40=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nA1VP/WdjZFP9yd4kj0TXFyrtPDKr9ymv3H7ag4TIpB5Qu38YLs31JNT0/y+/Kkye
	 WHHBo3LZs82VgJ3kvEPtsIlwiEeXnukjXPYc2FAwqsW0sU20oJ4srpNVaYoUFCgybS
	 UXD1+bbfAGjAuRAfLutmkYzrsj6SiLRepu3gN+lC542JvVQ5B1fnIaFB2hXeRW4N4j
	 FbYHWexIv6BfplNk2zSDGme7uaYCOPlOsYyuYxeYLnhm9V2vSnxsnk0LpE4Eef0P7L
	 qynrLeoKIcAmC+2AEtY+jJffanCNqkbrnPPqcNpfDghs9iUFf4tlrd8VjpxTX5zPxS
	 K5qGB9Dsm+qig==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/14] btrfs: make btrfs_should_delete_dir_index() return a bool instead
Date: Mon,  2 Jun 2025 11:33:06 +0100
Message-ID: <9ae7b77042c2a59c93f5ed5e0e9ae99c94656bbb.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to return errors and we currently return 1 in case the
index should be deleted and 0 otherwise, so change the return type from
int to bool as this is a boolean function and it's more clear this way.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 7 +++----
 fs/btrfs/delayed-inode.h | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1e9bec6d24f7..050723ade942 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1734,17 +1734,16 @@ void btrfs_readdir_put_delayed_items(struct btrfs_inode *inode,
 	downgrade_write(&inode->vfs_inode.i_rwsem);
 }
 
-int btrfs_should_delete_dir_index(const struct list_head *del_list,
-				  u64 index)
+bool btrfs_should_delete_dir_index(const struct list_head *del_list, u64 index)
 {
 	struct btrfs_delayed_item *curr;
-	int ret = 0;
+	bool ret = false;
 
 	list_for_each_entry(curr, del_list, readdir_list) {
 		if (curr->index > index)
 			break;
 		if (curr->index == index) {
-			ret = 1;
+			ret = true;
 			break;
 		}
 	}
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index c4b4ba122beb..73d13fac8917 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -150,8 +150,7 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 void btrfs_readdir_put_delayed_items(struct btrfs_inode *inode,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
-int btrfs_should_delete_dir_index(const struct list_head *del_list,
-				  u64 index);
+bool btrfs_should_delete_dir_index(const struct list_head *del_list, u64 index);
 int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 				    const struct list_head *ins_list);
 
-- 
2.47.2


