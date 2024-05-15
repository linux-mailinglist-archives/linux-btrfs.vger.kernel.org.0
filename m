Return-Path: <linux-btrfs+bounces-5026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD38C6C74
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D231C22013
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6D159598;
	Wed, 15 May 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPlZTVi5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59378158DD1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799114; cv=none; b=uDx8Ah2/cFStSnzu2ajTaJM+0wpmmU+JA6tbPl9GbhbIMS77XWOrc/Qa5E9rLpxngj8x1EEot5zefUFn3FXJQESX/FhOyXu78E+FFCQs0uk0l41M0RWYVDu+JiXh7nCIKk9R9VyfR6v35bGYqP0D3tJXpgHqqCSFY30R1yXBrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799114; c=relaxed/simple;
	bh=fsFgnPbR+vRaXKYTSIrHCIQOAb9xKwJ6iNf4bYG+vf0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ok3unlxzeLXhwWAkgp24BZJCDPoQRDJnTCm3nlBgtpu8VxPgaq5fkRMmxDJOrmdKyOSUZ3W1QpiN1iJcvbDq6PnY6O/L+c/SZ/TEDdnFqHVGnW+QlqKcC0Hb+FS2qoClSa0Z3YSjM1Er/6Dj0s/GX0tgHjuWmu0+AIFmIKTSdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPlZTVi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B2C116B1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715799113;
	bh=fsFgnPbR+vRaXKYTSIrHCIQOAb9xKwJ6iNf4bYG+vf0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DPlZTVi5eN99MvYn7GAVOFSvz9cryueHPD6fG5IMQaxbkT+Lu3d4lhytoAlhdHVFk
	 6DCqmMX3Bgu6bc/C+jv9+zH+HPnPR9MwrjxSv98bqARAucZWkxj5abvGEdNgu/Rn4G
	 vgjATV7ZwJkt1CZ1sVpjMeOaGi0go9fWNlCe78vrgiPVXulytNI8DvnFU5vsLUt2p+
	 hEPw5lGwY2UfB7up/5vxnk32lrdb2g8hpAfiGgEZ6ofexZswKR0k0MFoFbtbgk9HIE
	 dShnb4yYECO4ufrOjgLi/+Tt35Io5lFLS3I+hsLF1vvXffj4W3Fui8+Vk23AtvCig9
	 e0flmk6x8eAOQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: immediately drop extent maps after failed COW write
Date: Wed, 15 May 2024 19:51:46 +0100
Message-Id: <c9d7a03ee9730e1d864cb6fbe2d511dd8899a953.1715798440.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715798440.git.fdmanana@suse.com>
References: <cover.1715798440.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If a write path in COW mode fails, either before submitting a bio for the
new extents or an actual IO error happens, we can end up allowing a fast
fsync to log file extent items that point to unwritten extents.

This is because the ordered extent completion for a failed write is
executed in a work queue. This means that once the write path unlocks the
inode, a fast fsync can come and log the extent maps created by the write
attempt before the work queue completes the ordered extent.

For example consider a direct IO write, in COW mode, that fails at
btrfs_dio_submit_io() because btrfs_extract_ordered_extent() returned an
error:

1) We call btrfs_finish_ordered_extent() with the 'uptodate' parameter
   set to false, meaning an error happened;

2) That results in marking the ordered extent with the BTRFS_ORDERED_IOERR
   flag;

3) btrfs_finish_ordered_extent() queues the completion of the ordered
   extent - so that btrfs_finish_one_ordered() will be executed later in
   a work queue. That function will drop extents maps in the range when
   it's executed, since the extent maps point to unwritten locations
   (signaled by the BTRFS_ORDERED_IOERR flag);

4) After calling btrfs_finish_ordered_extent() we keep going down the
   write path and unlock the inode;

5) After that a fast fsync starts and locks the inode;

6) Before the work queue executes btrfs_finish_one_ordered(), the fsync
   task sees the extent maps that point to the unwritten locations and
   logs file extent items based on them - it does not know they are
   unwritten, and the fast fsync path does not wait for ordered extents
   to complete in order to reduce latency.

So to fix this make btrfs_finish_ordered_extent() drop the extent maps
in the range if an error happened for a COW write.

Note that this issues of using extent maps that point to unwritten
locations can not happen for reads, because in read paths we start by
locking the extent range and wait for any ordered extents in the range
to complete before looking for extent maps.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 304d94f6d29b..3a3f21da6eb7 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -388,6 +388,33 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	ret = can_finish_ordered_extent(ordered, page, file_offset, len, uptodate);
 	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
+	/*
+	 * If this is a COW write it means we created new extent maps for the
+	 * range and they point to an unwritten location if we got an error
+	 * either before submitting a bio or during IO.
+	 *
+	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
+	 * are queuing its completion below. During completion, at
+	 * btrfs_finish_one_ordered(), we will drop the extent maps for the
+	 * unwritten extents.
+	 *
+	 * However because completion runs in a work queue we can end up
+	 * unlocking the inode before the ordered extent is completed.
+	 *
+	 * That means that a fast fsync can happen before the work queue
+	 * executes the completion of the ordered extent, and in that case
+	 * the fsync will use the extent maps that point to unwritten extents,
+	 * resulting in logging file extent items that point to unwritten
+	 * locations. Unlike read paths, a fast fsync doesn't wait for ordered
+	 * extent completion before proceeding (intentional to reduce latency).
+	 *
+	 * To be safe drop the new extent maps in the range (if are doing COW)
+	 * right here before we unlock the inode and allow a fsync to run.
+	 */
+	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
+		btrfs_drop_extent_map_range(inode, file_offset,
+					    file_offset + len - 1, false);
+
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
 	return ret;
-- 
2.43.0


