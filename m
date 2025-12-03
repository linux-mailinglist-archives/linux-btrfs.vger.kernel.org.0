Return-Path: <linux-btrfs+bounces-19499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75197CA1CC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D708300BB84
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFD82E03F1;
	Wed,  3 Dec 2025 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h24ieQB2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2F2DCBE0
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800002; cv=none; b=NwakarDnndrM2CH1qMzK0Gj5hhiJk1iAsrdTrVepaXS7P7UnYGBTN513SEGHpL7nmiCr20pR4KxmB03UVhO2oiqwmTUIb3hYLKiuImpvGGnLhLl8JBMgRlTPWSLQScf9ma8g9lSsZw43U6h0ehyCQDQ3xRncbTfXijpTPXgQDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800002; c=relaxed/simple;
	bh=sRQv8zCAnwT5YednJoTNug6WaYTXlxSJT/RzMJorDqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jmfl2N3MlaT35880NgsJWpmgwUQvwaNvKKBJVMMmW71yvDfTz9FjEBNPcVk2/Xk/lfXxyxQ8vSsBrIv3jIJfQXXo6yYUYM8KiD3wfZT4pk+ypnliID9CXmW8lgZE+UF/MbPtRCUgQvdODIiTcFj+WkfbqGNcBylWr3UkRlqOS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h24ieQB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F4DC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764800002;
	bh=sRQv8zCAnwT5YednJoTNug6WaYTXlxSJT/RzMJorDqs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h24ieQB2BCWHAcvxVJogkObKOXJDgcC2Olv7tnw0YiTxtI6emXejE1Yh71aDrqLfM
	 +BBGqlJd8XKj1laHpOryzfKCoBQ/Hid9CPjhCpQy75fZvOdsvoJCYhMpRC0LsJlwf7
	 C1K0bc6lEnz63jTZbPEf1CObxCQ4WtVrEsvWFDc6qvRul1aJYPEN6MNelNw11dioe2
	 srwhkoossPVnx3+fFXAGNbyui/AfC5sP/PFK0uLhxs2Yr9TC3MCzBs4DyGy0emHFju
	 tyccir423mYz8W3fL+RKnxaSSRd8/Tk2yloVoHaXDkZXJV2Kav/oJoNqlqJUWaCEq6
	 EsJb/aOyjMCng==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: do not skip logging new dentries when logging a new name
Date: Wed,  3 Dec 2025 22:13:18 +0000
Message-ID: <818f6f16e33bfa2da9bd0101e49a47aad44a791a.1764799815.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>
References: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When we are logging a directory and the log context indicates that we
are logging a new name for some other file (that is or was inside that
directory), we skip logging the inodes for new dentries in the directory.

This is ok most of the time, but if after the rename or link operation
that triggered the logging of that directory, we have an explicit fsync
of that directory without the directory inode being evicted and reloaded,
we end up never logging the inodes for the new dentries that we found
during the new name logging, as the next directory fsync will only process
dentries that were added after the last time we logged the directory (we
are doing an incremental directory logging).

So make sure we always log new dentries for a directory even if we are
in a context of logging a new name.

We started skipping logging inodes for new dentries as of commit
c48792c6ee7a ("btrfs: do not log new dentries when logging that a new name
exists") and it was fine back then, because when logging a directory we
always iterated over all the directory entries (for leaves changed in the
current transaction) so a subsequent fsync would always log anything that
was previously skipped while logging a directory when logging a new name
(with btrfs_log_new_name()). But later support for incrementally logging
a directory was added in commit dc2872247ec0 ("btrfs: keep track of the
last logged keys when logging a directory"), to avoid checking all dir
items every time we log a directory, so the check to skip dentry logging
added in the first commit should have been removed when the incremental
support for logging a directory was added.

A test case for fstests will follow soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com/
Fixes: dc2872247ec0 ("btrfs: keep track of the last logged keys when logging a directory")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Update changelog to be more detailed about when skipping the logging
    of new dentries during new name logging became incorrect, and update
    the Fixes commit.

 fs/btrfs/tree-log.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 64c1155160a2..31edc93a383e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5865,14 +5865,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	struct btrfs_inode *curr_inode = start_inode;
 	int ret = 0;
 
-	/*
-	 * If we are logging a new name, as part of a link or rename operation,
-	 * don't bother logging new dentries, as we just want to log the names
-	 * of an inode and that any new parents exist.
-	 */
-	if (ctx->logging_new_name)
-		return 0;
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-- 
2.47.2


