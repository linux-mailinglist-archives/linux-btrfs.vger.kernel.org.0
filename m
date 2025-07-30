Return-Path: <linux-btrfs+bounces-15761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F197B166CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F303585DAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C215A8;
	Wed, 30 Jul 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQj3StdS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9B2E092E
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903244; cv=none; b=JHiStANdg8iYU3IrkzJfvIZqZwTLYLqEVg/hq/6ShGjw9EUw46H/2SVtrf7tpLny61Dc3ZT18021uogRSQf7JM5HRK59tnBXbIWQ0j0SGdlWQj5QHINg3RkMkUM7PpELHeC7q8HjI2C9Hu8Dwh83JdTf68wulMsJzYC6F4OqYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903244; c=relaxed/simple;
	bh=mGn7Coa8bktcj5jKbffLI/mX9Z1odWd8F6IIPv2sJto=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lCoe2o0YJdc/Dg/4lU7voyoE7iD0Zr70vTTWLrOyy4xIN0zGPZGH3AoTtFFagcbId0QOmr2FDuejZKxSjW/t/xZbjKvWQhQTzVfX8tHSRM/O2+8RQ98QQyra7mrsZgOQ3oRgHnjEUi8P6w1a80sYMJYWZGagpvQYGrGu1JqgWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQj3StdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76845C4CEE3
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753903244;
	bh=mGn7Coa8bktcj5jKbffLI/mX9Z1odWd8F6IIPv2sJto=;
	h=From:To:Subject:Date:From;
	b=NQj3StdS1Lbt/UF9rxKKDupCszEpQWLtz1KAUkqDgV5HRYrFivmTV5RY7n0rIqNum
	 UDm9jCnpH1snZNnmhl/9bMv4Q2cLBjncW4rES1uW9V+B221ICwZ0GDxpYO4YHfhCDL
	 nWPlp4RsdOfhWOiKRh/GxJd1TLJ8MOPknJsnvtPjIBR2o2vGJAPd7e1im8a+bZjun0
	 /FFx87rMfsUFs/KaeEu+5GOz7Ixp8qnxs6CcDoj5UPz+In318VsCxMjX4Dpb1zzZjm
	 Cy6JhmM4VE4lBmQ0HLrM6fVgW6xChI2eqE+oVT1b9+FX7pEAR6Ttl6EUGPEcfVC5QA
	 /ZZWpSB0/WZmA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix log tree replay failure due to file with 0 links and extents
Date: Wed, 30 Jul 2025 20:20:40 +0100
Message-ID: <5c89804b07e3681c3a9bc50bf1d63d9ce77d7020.1753902432.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we log a new inode (not persisted in a past transaction) that has 0
links and extents, then log another inode with an higher inode number, we
end up with failing to replay the log tree with -EINVAL. The steps for
this are:

1) create new file A
2) write some data to file A
3) open an fd on file A
4) unlink file A
5) fsync file A using the previously open fd
6) create file B (has higher inode number than file A)
7) fsync file B
8) power fail before current transaction commits

Now when attempting to mount the fs, the log replay will fail with
-ENOENT at replay_one_extent() when attempting to replay the first
extent of file A. The failure comes when trying to open the inode for
file A in the subvolume tree, since it doesn't exist.

Before commit 5f61b961599a ("btrfs: fix inode lookup error handling
during log replay"), the returned error was -EIO instead of -ENOENT,
since we converted any errors when attempting to read an inode during
log replay to -EIO.

The reason for this is that the log replay procedure fails to ignore
the current inode when we are at the stage LOG_WALK_REPLAY_ALL, our
current inode has 0 links and last inode we processed in the previous
stage has a non 0 link count. In other words, the issue is that at
replay_one_extent() we only update wc->ignore_cur_inode if the current
replay stage is LOG_WALK_REPLAY_INODES.

Fix this by updating wc->ignore_cur_inode whenever we find an inode item
regardless of the current replay stage. This is a simple solution and easy
to backport, but later we can do other alternatives like avoid logging
extents or inode items other than the inode item for inodes with a link
count of 0.

The problem with the wc->ignore_cur_inode logic has been around since
commit f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync
of a tmpfile") but it only became frequent to hit since the more recent
commit 5e85262e542d ("btrfs: fix fsync of files with no hard links not
persisting deletion"), because we stopped skipping inodes with a link
count of 0 when logging, while before the problem would only be triggered
if trying to replay a log tree created with an older kernel which has a
logged inode with 0 links.

A test case for fstests will be submitted soon.

Reported-by: Peter Jung <ptr1337@cachyos.org>
Link: https://lore.kernel.org/linux-btrfs/fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org/
Reported-by: burneddi <burneddi@protonmail.com>
Link: https://lore.kernel.org/linux-btrfs/lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com/#t
Reported-by: Russell Haley <yumpusamongus@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com/
Fixes: f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync of a tmpfile")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8c6d1eb84d0e..09ddb2ee4df4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2602,23 +2602,30 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
-		btrfs_item_key_to_cpu(eb, &key, i);
+		struct btrfs_inode_item *inode_item;
 
-		/* inode keys are done during the first stage */
-		if (key.type == BTRFS_INODE_ITEM_KEY &&
-		    wc->stage == LOG_WALK_REPLAY_INODES) {
-			struct btrfs_inode_item *inode_item;
-			u32 mode;
+		btrfs_item_key_to_cpu(eb, &key, i);
 
-			inode_item = btrfs_item_ptr(eb, i,
-					    struct btrfs_inode_item);
+		if (key.type == BTRFS_INODE_ITEM_KEY) {
+			inode_item = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
 			/*
-			 * If we have a tmpfile (O_TMPFILE) that got fsync'ed
-			 * and never got linked before the fsync, skip it, as
-			 * replaying it is pointless since it would be deleted
-			 * later. We skip logging tmpfiles, but it's always
-			 * possible we are replaying a log created with a kernel
-			 * that used to log tmpfiles.
+			 * An inode with no links is either:
+			 *
+			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
+			 *    got linked before the fsync, skip it, as replaying
+			 *    it is pointless since it would be deleted later.
+			 *    We skip logging tmpfiles, but it's always possible
+			 *    we are replaying a log created with a kernel that
+			 *    used to log tmpfiles;
+			 *
+			 * 2) A non-tmpfile which got its last link deleted
+			 *    while holding an open fd on it and later got
+			 *    fsynced through that fd. We always log the
+			 *    parent inodes when inode->last_unlink_trans is
+			 *    set to the current transaction, so ignore all the
+			 *    inode items for this inode. We will delete the
+			 *    inode when processing the parent directory with
+			 *    replay_dir_deletes().
 			 */
 			if (btrfs_inode_nlink(eb, inode_item) == 0) {
 				wc->ignore_cur_inode = true;
@@ -2626,6 +2633,13 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			} else {
 				wc->ignore_cur_inode = false;
 			}
+		}
+
+		/* Inode keys are done during the first stage. */
+		if (key.type == BTRFS_INODE_ITEM_KEY &&
+		    wc->stage == LOG_WALK_REPLAY_INODES) {
+			u32 mode;
+
 			ret = replay_xattr_deletes(trans, root, log, path, key.objectid);
 			if (ret)
 				break;
-- 
2.47.2


