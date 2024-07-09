Return-Path: <linux-btrfs+bounces-6328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1EB92C13C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60F51F22753
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD971A906E;
	Tue,  9 Jul 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxEzZpD7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE631A6521;
	Tue,  9 Jul 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542397; cv=none; b=c6B/CI1qYOxwOaDUbnSEKZbT1t9PonCYOgirdSiTfcf5NyWNwxATNBU7aorTLI3kvhTmZXulXF/TW4aUf0ThvVxVzdSwuOBQZhbA06SOuuqfMzrHqIa251EJlqrMjDCySkmzDI1YIW2HRZu5bltYMlLRJ56svTDEErIkYA3GWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542397; c=relaxed/simple;
	bh=gggVwrnNJ6u/9nu4QRK+z3iXEDq2OkILWU4q9jIgydI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3hV7bO+8KCjO5PxEx6iFcd/n3ayJiMEpRbFS5BHa31xGJih9543Ry1vD97uFHpTTUo3ij3P5ceyTtMhIeJWP1gjvUyxC3HckIQ+Pj10K/scBRIgvsjOOMEuW8XsCTqlaSqxvhaCzDyyhzkVmj1RHKtq/PcloVtBaei3GXm7Kl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxEzZpD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13074C4AF07;
	Tue,  9 Jul 2024 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542397;
	bh=gggVwrnNJ6u/9nu4QRK+z3iXEDq2OkILWU4q9jIgydI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxEzZpD75n7N80A5kSu6LEf3HwqWnNXPDs5YCfXo9Ykd2hyK/dXsWN41D8CDIAejW
	 s4RAzQPwL3mXVh2yvVmFV3Oz3zhnvWeNZQCo7+v/sWpl+BVmR138Uk3t5IsIYsPF8a
	 N8MgCfOYfW742KHmxMDIPvErDv+HU3K1PyoYsze1WcLl4tJTc3fBexpXz+vyZBISxF
	 vBYqapQ8C1pHvQgNRSoaVJNl+4kslngGlwn7nHBnr6J1EqCXbBNQX1FbyKyOmY2tB3
	 X5u5NjIMDC+HeZTB372eommAdZM+JdgmATdyPqSi06+pWoDeSMZxSNhMKsf73Yu8b1
	 9UnXtdD3hdqww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/14] btrfs: qgroup: fix quota root leak after quota disable failure
Date: Tue,  9 Jul 2024 12:25:55 -0400
Message-ID: <20240709162612.32988-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a7e4c6a3031c74078dba7fa36239d0f4fe476c53 ]

If during the quota disable we fail when cleaning the quota tree or when
deleting the root from the root tree, we jump to the 'out' label without
ever dropping the reference on the quota root, resulting in a leak of the
root since fs_info->quota_root is no longer pointing to the root (we have
set it to NULL just before those steps).

Fix this by always doing a btrfs_put_root() call under the 'out' label.
This is a problem that exists since qgroups were first added in 2012 by
commit bed92eae26cc ("Btrfs: qgroup implementation and prototypes"), but
back then we missed a kfree on the quota root and free_extent_buffer()
calls on its root and commit root nodes, since back then roots were not
yet reference counted.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 50669ff9346c6..83d17f22335b1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1197,7 +1197,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1290,9 +1290,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_tree_unlock(quota_root->node);
 	btrfs_free_tree_block(trans, quota_root, quota_root->node, 0, 1);
 
-	btrfs_put_root(quota_root);
 
 out:
+	btrfs_put_root(quota_root);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
 		btrfs_end_transaction(trans);
-- 
2.43.0


