Return-Path: <linux-btrfs+bounces-6326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279992C0CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B410C1C22022
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92418005A;
	Tue,  9 Jul 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6JUMVJW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB77180045;
	Tue,  9 Jul 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542281; cv=none; b=MZmheLV2N3aKUnb8ATsptWRq2bNA1h/TzUx8VZscsDTwJEx6dVqhWEqBXjtclQkFUANqx2HZaSRBtMaTWoiJMrS5ABjSsb1Ua1LU8SYmoQlw5Us1HnYmFKAnn5ZgJOWP2HkXlDlE7Tdg1w257JPNDL9zZeU84oZWoKExTd7JyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542281; c=relaxed/simple;
	bh=/pPDZdrL1fgbfg8JalZ4s9HSctgP7Uy078kZQgQ08/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8r6QegG22/86tADZMpJUfKwF5d1gTZNbdSw2Lg3bHe1TNJAtVYNkIOu3IPDmuIFcUrBhh8WyXJTa/Fuk4d6Dp27gVyl7qjJVmM14wwvTxG63QB4XTdEZMUADnKs6eZSdXNY3CiFAB6tOu5HLFrsurASHXB9FVkjq31NwmuD7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6JUMVJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C38C3277B;
	Tue,  9 Jul 2024 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542281;
	bh=/pPDZdrL1fgbfg8JalZ4s9HSctgP7Uy078kZQgQ08/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6JUMVJWPGxWCCIj5Ce+H67XXm0HsiWktupdM52mmZRZKW0RnKQPnnwDZEQXNqcek
	 p7SUHnd1reEQYp016QT+M/basF1bO5OKqhyCN2AUnuUiGSotVW+/I3GH379xGI9z/Q
	 lhodPTd6rFeU3gbuyIZcfeTGNUiWpsvB8BjR4UDAkJRTcm4ZCidqErLgBzktI8Gq/B
	 eFdO7NB5h3G412IeVV2Q3vkx3mUtShXftL03HNAVb1tuysPIW02j9/wffhlftAFL9J
	 e8zNl+e1LnlvVoZY8by4xKuu5GmQYrw0voV24nYcXJqOptTiRsyf7sR9CKIUPgjdkg
	 bYx7M0PiVTofA==
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
Subject: [PATCH AUTOSEL 6.1 20/27] btrfs: qgroup: fix quota root leak after quota disable failure
Date: Tue,  9 Jul 2024 12:23:34 -0400
Message-ID: <20240709162401.31946-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
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
index 80ca7b435b0d1..e482889667ec9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1222,7 +1222,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1317,9 +1317,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
 			      quota_root->node, 0, 1);
 
-	btrfs_put_root(quota_root);
 
 out:
+	btrfs_put_root(quota_root);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
 		btrfs_end_transaction(trans);
-- 
2.43.0


