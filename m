Return-Path: <linux-btrfs+bounces-11073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E98A1C8DF
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39741665E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF91A7AF7;
	Sun, 26 Jan 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtXXCrrv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76B1A4F3C;
	Sun, 26 Jan 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902969; cv=none; b=ZRW2CfK0iZvE81M58o2SIamhrw9pt06m3KbbBxP8tDEyYPakJvfsVVD8Mjpm4+ERF5Fr/En/Ga4riIMNpZ67HefsPwTn0j9AV6S0ytVXcmmqXIGxBTwltPIwkPjyg8uW4NiUmQFZ0dJJkjTYbpUVQeWeI8g54X++Ylj9MfbfaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902969; c=relaxed/simple;
	bh=gZDZfKAwbgBlgv1bCE2S0XOj8aJqF7Gwipn77lj9RNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqP5/bATyGkKHae7YTeJlMZHC1UMDCZW8gpu5vu0LAPPUiOBh6TNJYxQv6R4mCBXxI53jN2491G4H/ISV5q9k6gRVFJB7pVRaHRzWbPNPg86F6+Q4cLVribPyKFkVgtjSz3Z83KrWpLub0eullvReQ8UjGZuG1AtwqQApB5f0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtXXCrrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1655C4CEE2;
	Sun, 26 Jan 2025 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902968;
	bh=gZDZfKAwbgBlgv1bCE2S0XOj8aJqF7Gwipn77lj9RNU=;
	h=From:To:Cc:Subject:Date:From;
	b=KtXXCrrvCamxSDS58fGycJU6O6rTdaflxnpkrmIfmkzVR6aRdJMqEzycGE85suzk9
	 Oq3oKSRtD52+6Zv8WKdw5Tg2eaUP5X50NuJqPkWtJnoyBvCD4UdZUWNPLQsFb2UTJ4
	 TIMkXMFvMpEPfVuyT2w7XU48KkAIanL832AaKkWXarRKbpturHplz1R/EggnkqyxoV
	 tejshX6fzpmNNSdzcqQZrXwgQaW9F9BQsBArVKL0RT38J3szCTKGle7TKyfYbsJgtd
	 kBYDBXW/7oI2P7XNfgaBtemuFjWSeUtkdJuNC8ofUZLmrA27YvtGc8qlYjHpp27hLY
	 5Wt+hGiKIaADA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao-ran Zheng <zhenghaoran154@gmail.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/2] btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()
Date: Sun, 26 Jan 2025 09:49:25 -0500
Message-Id: <20250126144926.925617-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: Hao-ran Zheng <zhenghaoran154@gmail.com>

[ Upstream commit 5324c4e10e9c2ce307a037e904c0d9671d7137d9 ]

A data race occurs when the function `insert_ordered_extent_file_extent()`
and the function `btrfs_inode_safe_disk_i_size_write()` are executed
concurrently. The function `insert_ordered_extent_file_extent()` is not
locked when reading inode->disk_i_size, causing
`btrfs_inode_safe_disk_i_size_write()` to cause data competition when
writing inode->disk_i_size, thus affecting the value of `modify_tree`.

The specific call stack that appears during testing is as follows:

  ============DATA_RACE============
   btrfs_drop_extents+0x89a/0xa060 [btrfs]
   insert_reserved_file_extent+0xb54/0x2960 [btrfs]
   insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
   btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
   btrfs_finish_ordered_io+0x37/0x60 [btrfs]
   finish_ordered_fn+0x3e/0x50 [btrfs]
   btrfs_work_helper+0x9c9/0x27a0 [btrfs]
   process_scheduled_works+0x716/0xf10
   worker_thread+0xb6a/0x1190
   kthread+0x292/0x330
   ret_from_fork+0x4d/0x80
   ret_from_fork_asm+0x1a/0x30
  ============OTHER_INFO============
   btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
   btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
   btrfs_finish_ordered_io+0x37/0x60 [btrfs]
   finish_ordered_fn+0x3e/0x50 [btrfs]
   btrfs_work_helper+0x9c9/0x27a0 [btrfs]
   process_scheduled_works+0x716/0xf10
   worker_thread+0xb6a/0x1190
   kthread+0x292/0x330
   ret_from_fork+0x4d/0x80
   ret_from_fork_asm+0x1a/0x30
  =================================

The main purpose of the check of the inode's disk_i_size is to avoid
taking write locks on a btree path when we have a write at or beyond
EOF, since in these cases we don't expect to find extent items in the
root to drop. However if we end up taking write locks due to a data
race on disk_i_size, everything is still correct, we only add extra
lock contention on the tree in case there's concurrency from other tasks.
If the race causes us to not take write locks when we actually need them,
then everything is functionally correct as well, since if we find out we
have extent items to drop and we took read locks (modify_tree set to 0),
we release the path and retry again with write locks.

Since this data race does not affect the correctness of the function,
it is a harmless data race, use data_race() to check inode->disk_i_size.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 44160d4ad53e0..31b25cb2f5cc3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -731,7 +731,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (args->drop_cache)
 		btrfs_drop_extent_cache(inode, args->start, args->end - 1, 0);
 
-	if (args->start >= inode->disk_i_size && !args->replace_extent)
+	if (data_race(args->start >= inode->disk_i_size) && !args->replace_extent)
 		modify_tree = 0;
 
 	update_refs = (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID);
-- 
2.39.5


