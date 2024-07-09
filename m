Return-Path: <linux-btrfs+bounces-6327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAC792C103
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BFA2866D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3C190CAF;
	Tue,  9 Jul 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVVJuvRh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A410190CC8;
	Tue,  9 Jul 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542346; cv=none; b=pEQXznMV4RimVVhCwNPvYpmbf0SsOOMPfCq5ByJLV/ZnOY5vAX9b405y+islk5/64bdJpAnZ7sG7O1g3UCIAbNvuhTEG6iFTCcxNiopDWX4sC0IMMSRHZTDzh3t73ngH42J/3hlVHa0tYPj48xeBXHWHSzD9EzAO+VK58WWPmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542346; c=relaxed/simple;
	bh=dVR4wiWWfP/crERAXEJ8J5ukA3VTk1rly7IZiGApujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhxeMm6nxfA2gkD+UN5tvsA3mcm/tJ92ML6pDP3Wf7dUGDQOLRfWJsoRQgesYT4CXXOlE8Y8MZbcdcZMYBkl2YU5pKilnStH6h/Gtt4/IkxufbmgUviUshznM5VH/5PXxrAQ0NK8obHMEmzkq60ttafsnSmwRZbIuGbGSEVFLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVVJuvRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BE7C3277B;
	Tue,  9 Jul 2024 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542345;
	bh=dVR4wiWWfP/crERAXEJ8J5ukA3VTk1rly7IZiGApujE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVVJuvRhtGIVzt4S1Ty844ngi9BhEUYyO3lR1QUn0nXiTxuS9bNQj3DF10WUPbNXv
	 AjGzRBefI300sTTWjcC2yyWUQYVq+TFwmWhlyDBnFV2oea9FEtoDIkhs08VJNpA7zL
	 gp8zCOAXfH8k1zMHgR31ci91MEzx6yZ19hsONiXQjR/kHXxmo7Zi8MME0Jve6Y7yPR
	 BovO4CU3DLQ1ZtsByY1aBomnGfK9qPjanb1Kuk4OWu8fYGa8Rzu9x9DxtNPH9w4Hui
	 pJxT+0xd9UUBNii+Jmd6VsBMiM824O8TIOtwTvi4Qtx7FVm8pWUX8Yy06xOSZlv+If
	 1zsYMeVzQEy8Q==
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
Subject: [PATCH AUTOSEL 5.15 13/17] btrfs: qgroup: fix quota root leak after quota disable failure
Date: Tue,  9 Jul 2024 12:24:57 -0400
Message-ID: <20240709162517.32584-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index c50cabf69415f..1f5ab51e18dc4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1196,7 +1196,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1290,9 +1290,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
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


