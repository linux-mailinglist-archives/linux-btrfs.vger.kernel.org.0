Return-Path: <linux-btrfs+bounces-18401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84384C1BE4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 17:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B6675A09CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2033F38C;
	Wed, 29 Oct 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO8bxwKs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BB33B6F4
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752664; cv=none; b=kufvMJhe85RqYK5aNdxLloO9DErru7uGDSNJyiWy0Fbuxxm7TohsnlNWyv/Yl1mX4tpyxmIL29cQsSl9vhmn8npf42dbM+x+0vBVQY6Dg1VWg3s4S8DXf1NA4nCXhXInGJNeiUu88PX3pUPiwzCtKLe0RN29lDkXX6Cb10uTqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752664; c=relaxed/simple;
	bh=QzpR8MfEyqtD7RqM9hrpQVH1AvMy3CpRNNBy+VaSxa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IsUZzKv8wCNZlL6o8R9TmXFC4+u6JA96AGH3h/9qtXQleRBbH0wzOGHbCmwkmVePU7pJlIs5a0pSxLLo7J1Gi9+8f7TQGCE1Kj14N7vLRlkPRC1o34P6JH/G4TEErL+cYzIPGmVAcuu7tb/QOVsAK05J5BgPF9f6cBPacpIa6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO8bxwKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5379C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752664;
	bh=QzpR8MfEyqtD7RqM9hrpQVH1AvMy3CpRNNBy+VaSxa4=;
	h=From:To:Subject:Date:From;
	b=jO8bxwKs3+zPPmeFE5qp99boN4mPhQyMXp150uRgTSnIgqAEeglnRK5IXF7zA8eST
	 D9hCwMz5ZueAqAiq9jAyTpKNuVBu03wWd3xbFcvss1/vgPSnLBnnK8h0no8SPdb1eR
	 BUX2mHv0hojcadDzh2FNyrM/e4p8SvQTvF9KFlzLg2kf5NgaRtSTN7Es4Fz5syg0cf
	 d6vT8hYd6LZN1AJnGEERH29VBHU4ZqBt88JuGXbQa9SSCtKWWVziwRSLF3avHeTkqJ
	 elqJzW5TYEHr0jKlSaJeHurcdkny0R0m3ekoGHfwIu3W97uZ2r4yQ/uIAIc9Xt8MAn
	 FyCU3t736gD7A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not update last_log_commit when logging inode due to a new name
Date: Wed, 29 Oct 2025 15:44:20 +0000
Message-ID: <1f86f448a8a2b8f33a6d07644b0f6d70c9a911c4.1761752128.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When logging that a new name exists, we skip updating the inode's
last_log_commit field to prevent a later explicit fsync against the inode
from doing nothing (as updating last_log_commit makes btrfs_inode_in_log()
return true). We are detecting, at btrfs_log_inode(), that logging a new
name is happening by checking the logging mode is not LOG_INODE_EXISTS,
but that is not enough because we may log parent directories when logging
a new name of a file in LOG_INODE_ALL mode - we need to check that the
logging_new_name field of the log contex too.

An example scenario where this results in an explicit fsync against a
directory not persisting changes to the the directory is the following:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt

  $ touch /mnt/foo

  $ sync

  $ mkdir /mnt/dir

  # Write some data to our file and fsync it.
  $ xfs_io -c "pwrite -S 0xab 0 64K" -c "fsync" /mnt/foo

  # Add a new link to our file. Since the file was logged before, we
  # update it in the log tree by calling btrfs_log_new_name().
  $ ln /mnt/foo /mnt/dir/bar

  # fsync the root directory - we expect it to persist the dentry for
  # the new directory "dir".
  $ xfs_io -c "fsync" /mnt

  <power fail>

After mounting the fs the entry for directory "dir" does not exists,
despite the explicit fsync on the root directory.

Here's why this happens:

1) When we fsync the file we log the inode, so that it's present in the
   log tree;

2) When adding the new link we enter btrfs_log_new_name(), and since the
   inode is in the log tree we proceed to updating the inode in the log
   tree;

3) We first set the inode's last_unlink_trans to the current transaction
   (early in btrfs_log_new_name());

4) We then eventually enter btrfs_log_inode_parent(), and after logging
   the file's inode, we call btrfs_log_all_parents() because the inode's
   last_unlink_trans matches the current transaction's ID (updated in the
   previous step);

5) So btrfs_log_all_parents() logs the root directory by calling
   btrfs_log_inode() for the root's inode with a log mode of LOG_INODE_ALL
   so that new dentries are logged;

6) At btrfs_log_inode(), because the log mode is LOG_INODE_ALL, we
   update root inode's last_log_commit to the last transaction that
   changed the inode (->last_sub_trans field of the inode), which
   corresponds to the current transaction's ID;

7) Then later when user space explicitly calls fsync against the root
   directory, we enter btrfs_sync_file(), which calls skip_inode_logging()
   and that returns true, since its call to btrfs_inode_in_log() returns
   true and there are no ordered extents (it's a directory, never has
   ordered extents). This results in btrfs_sync_file() returning without
   syncing the log or committing the current transaction, so all the
   updates we did when logging the new name, including logging the root
   directory,  are not persisted.

So fix this by but updating the inode's last_log_commit if we are sure
we are not logging a new name (if ctx->logging_new_name is false).

A test case for fstests will follow soon.

Fixes: 130341be7ffa ("btrfs: always update the logged transaction when logging new names")
Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8dfd504b37ae..030d0fef97bd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7117,7 +7117,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 *    a power failure unless the log was synced as part of an fsync
 	 *    against any other unrelated inode.
 	 */
-	if (inode_only != LOG_INODE_EXISTS)
+	if (!ctx->logging_new_name && inode_only != LOG_INODE_EXISTS)
 		inode->last_log_commit = inode->last_sub_trans;
 	spin_unlock(&inode->lock);
 
-- 
2.47.2


