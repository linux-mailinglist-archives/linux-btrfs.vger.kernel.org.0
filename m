Return-Path: <linux-btrfs+bounces-6324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34D92C09A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF738B2B455
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809E1B29B6;
	Tue,  9 Jul 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdRk+9Qc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34A1B121A;
	Tue,  9 Jul 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542077; cv=none; b=OyedBlsqZATNawMl0S9ddx0K/d5HDMH3KfPkdLryIRTMWLzQJxrvlT85OchvzM4tYGDI23qSInLZs67qICeOpd3X+CY3cJrAwk1RQNZC7jKw9+HYgJF3hegh8l4uoCV+QEYvsfldf9wCbcmqGFbYtwqo1CHtCFdYHdR8px/yE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542077; c=relaxed/simple;
	bh=dbMrAcBG7JW+DkQWGUDxYuxjszG8kYn8Bp6wxTlVDIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjMCP9acrG68ZuNSo/1TjZcU9HwgAb/RjQZJIvY077FGSgrChjjt1XvZH9GE9HI09OqyMd/lerC4CJlNhEEnCPnije4qzonkWiM3sqNKrpBe+z4ZdYmecIOSFfWzefG2Fky9k2IsP79g1U0PkITOJMLH2wEh3krG8EYWUj1u1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdRk+9Qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD35C32782;
	Tue,  9 Jul 2024 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542077;
	bh=dbMrAcBG7JW+DkQWGUDxYuxjszG8kYn8Bp6wxTlVDIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdRk+9Qc3XS3/S+u/kJmwS6fjhOA+QFFVwpURHCzyEuT/WKqB7lpBNNVCBiyarB1u
	 RO1aOuw6JhmjbxS+g9Om2GCyX9HaU7iqZ+Xq/E4Qps3ixOMxi5RPnfSShidvpoZwea
	 Hze3Tg2S8q2thGvN69sBuxc3K2eCSTRye/Yv1AnqpwxO/eZnqf+arzHuqOEpwQPO1O
	 d34H1NZtd1l3S62UNM3oOGRDR8I8BRLabyRGPvBeSy1FsYPPe13Wl97LXnYXcvkag4
	 lMtEqZQkHDS2YkVccjXNw0l35rv62dtNthsS6MLZn8nRXChnBtrAumXvMhEJeauUtl
	 lvj5hlb+jtHDg==
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
Subject: [PATCH AUTOSEL 6.9 32/40] btrfs: qgroup: fix quota root leak after quota disable failure
Date: Tue,  9 Jul 2024 12:19:12 -0400
Message-ID: <20240709162007.30160-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
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
index 1167899a16d05..0e9b21bf3aab7 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1351,7 +1351,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1449,9 +1449,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
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


