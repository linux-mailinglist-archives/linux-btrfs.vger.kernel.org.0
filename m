Return-Path: <linux-btrfs+bounces-12481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AEA6B997
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B8E3BD74A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94511F4199;
	Fri, 21 Mar 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQr7S9Yl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147C1F17EB
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555338; cv=none; b=POJ5fOfyMPaRmJMf8DwFD6Ms0+cf8rgus6Wv0J43Sm72hl+LBDp/I29Q321QDKbK22xsLgG1EdSPwM4x803Lq2m9XvqkJs9wvEfkGBk/oChWGL/WlEhi+dllGzykEk7ropE2qZu06eFAL/Fcqp439d00sgtXoPhPKchZ+kCtHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555338; c=relaxed/simple;
	bh=iF1SMSERzCD+2RFS4oebaqlmnCPHq1cRRNqdOKs6bag=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OJyR6V0fHontxbtAvs9qLAwi9Q/09I0aU1cP7XyAO9ECxOezLjEfM6dSNqPzJMzbGVE8osweCns4vYwQy5ImvpKdEmKf7vjQenGzv39U2rosrqRd2CWpjLjzaYcvWbDBgLMHeulCzMBsoL3W1EeP+YPDBhJXabmC0OdHxgLlO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQr7S9Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E25C4CEE3
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742555337;
	bh=iF1SMSERzCD+2RFS4oebaqlmnCPHq1cRRNqdOKs6bag=;
	h=From:To:Subject:Date:From;
	b=cQr7S9Yl6WD63BhU6iNuV16N0u86CYtiA7PR+/vt09gw5TR3HRr3z4d9oZLtJgldp
	 NvPm5km8NDIW4UHh9W3O7LkuYYoHKQo+WSBZvkA4IPyeEP0sfgxz+hbn9C/sZp3QQv
	 4rXSWY3HreMe8DZ4gZW2hUAnMfeM5/UUlm0wH2fQ9r4G0axBOOrqb/EC58qUB0oaKV
	 WIPGFZFpOyxkRlUnvdYzcx8d6VUSLfqyyHI0RSlysN6J9OEHjAc/GW1bhSoCj90fHm
	 MIBel2Ll8S+pG6tg/XRM1qpRgZmyFZdJ7dY9XIi8TDRFdamd9NuWdRk5JTFt+gZCrv
	 j4b/MymU4al5g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix fsync of files with no hard links not persisting deletion
Date: Fri, 21 Mar 2025 11:08:53 +0000
Message-Id: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fsync a file (or directory) that has no more hard links, because
while a process had a file descriptor open on it, the file's last hard
link was removed and then the process did an fsync against the file
descriptor, after a power failure or crash the file still exists after
replaying the log.

This behaviour is incorrect since once an inode has no more hard links
it's not accessible anymore and we insert an orphan item into its
subvolume's tree so that the deletion of all its items is not missed in
case of a power failure or crash.

So after log replay the file shouldn't exist anymore, which is also the
behaviour on ext4, xfs, f2fs and other filesystems.

Fix this by not ignoring inodes with zero hard links at
btrfs_log_inode_parent() and by comitting an inode's delayed inode when
we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHING or
BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags). This
last step is necessary because when removing the last hard link we don't
delete the corresponding ref (or extref) item, instead we record the
change in the inode's delayed inode with the BTRFS_DELAYED_NODE_DEL_IREF
flag, so that when the delayed inode is committed we delete the ref/extref
item from the inode's subvolume tree - otherwise the logging code will log
the last hard link and therefore upon log replay the inode is not deleted.

The base code for a fstests test case that reproduces this bug is the
following:

   . ./common/dmflakey

   _require_scratch
   _require_dm_target flakey
   _require_mknod

   _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
   _require_metadata_journaling $SCRATCH_DEV
   _init_flakey
   _mount_flakey

   touch $SCRATCH_MNT/foo

   # Commit the current transaction and persist the file.
   _scratch_sync

   # A fifo to communicate with a background xfs_io process that will
   # fsync the file after we deleted its hard link while it's open by
   # xfs_io.
   mkfifo $SCRATCH_MNT/fifo

   tail -f $SCRATCH_MNT/fifo | \
        $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
   XFS_IO_PID=$!

   # Give some time for the xfs_io process to open a file descriptor for
   # the file.
   sleep 1

   # Now while the file is open by the xfs_io process, delete its only
   # hard link.
   rm -f $SCRATCH_MNT/foo

   # Now that it has no more hard links, make the xfs_io process fsync it.
   echo "fsync" > $SCRATCH_MNT/fifo

   # Terminate the xfs_io process so that we can unmount.
   echo "quit" > $SCRATCH_MNT/fifo
   wait $XFS_IO_PID
   unset XFS_IO_PID

   # Simulate a power failure and then mount again the filesystem to
   # replay the journal/log.
   _flakey_drop_and_remount

   # We don't expect the file to exist anymore, since it was fsynced when
   # it had no more hard links.
   [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"

   _unmount_flakey

   # success, all done
   echo "Silence is golden"
   status=0
   exit

A test case for fstests will be submitted soon.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 90dc094cfa5e..f5af11565b87 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		btrfs_log_get_delayed_items(inode, &delayed_ins_list,
 					    &delayed_del_list);
 
+	/*
+	 * If we are fsyncing a file with 0 hard links, then commit the delayed
+	 * inode because the last inode ref (or extref) item may still be in the
+	 * subvolume tree and if we log it the file will still exist after a log
+	 * replay. So commit the delayed inode to delete that last ref and we
+	 * skip logging it.
+	 */
+	if (inode->vfs_inode.i_nlink == 0) {
+		ret = btrfs_commit_inode_delayed_inode(inode);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
 				      path, dst_path, logged_isize,
 				      inode_only, ctx,
@@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	if (btrfs_root_generation(&root->root_item) == trans->transid)
 		return BTRFS_LOG_FORCE_COMMIT;
 
-	/*
-	 * Skip already logged inodes or inodes corresponding to tmpfiles
-	 * (since logging them is pointless, a link count of 0 means they
-	 * will never be accessible).
-	 */
-	if ((btrfs_inode_in_log(inode, trans->transid) &&
-	     list_empty(&ctx->ordered_extents)) ||
-	    inode->vfs_inode.i_nlink == 0)
+	/* Skip already logged inodes and without new extents. */
+	if (btrfs_inode_in_log(inode, trans->transid) &&
+	    list_empty(&ctx->ordered_extents))
 		return BTRFS_NO_LOG_SYNC;
 
 	ret = start_log_trans(trans, root, ctx);
-- 
2.45.2


