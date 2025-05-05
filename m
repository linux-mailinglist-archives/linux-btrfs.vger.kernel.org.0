Return-Path: <linux-btrfs+bounces-13673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1DAAA0CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632A77A392F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189029616A;
	Mon,  5 May 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb9OlNoi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA852957D0;
	Mon,  5 May 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483522; cv=none; b=HZ7Llx8n1Ie5+bKTHRBvW4/FKZMb3ulQs7zlGqOXtZQHOE3DOOrNO7SoWEI3eMpKSKqKajubB3rX8PDndlzzXjd8NDSItyLBzQeofxwYvJ3wuR5lBv/yPUROREP1jQ2EMivRlxe0wgKwpoZLF4Y/LA3NAnYEgc9IVpqxfLcNxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483522; c=relaxed/simple;
	bh=bcttV98Pu2tZjMnx1Fq/nCV17DLCuBjZJo9wqlhSOQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUbhg8hpnuV0iIbfJug7G2F/TAsLVqC47Foun/DncvoJY6MLeKYa6oCM+DpiTvQIPORsOZg6gu/QhrLZtHjUJZAfyohoA7C2GNMBYrQuvdw/W7XERWbgd5a1IkkqZ0TLkAPOQzDYYvu+I1R3WWDjr2Z5k02k3gQa1qmeUSUbPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb9OlNoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE73C4CEE4;
	Mon,  5 May 2025 22:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483521;
	bh=bcttV98Pu2tZjMnx1Fq/nCV17DLCuBjZJo9wqlhSOQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bb9OlNoimXrRpSMrXAHL41FU+I5t5BGND49KUq1JVfGJRSCa1TgC2MVQtjn5K3ZhL
	 3VjsaT7SuYAOXWwVs06ZdIVdZBbq43sGaqUSUUqdb40oTCczjmbYv42YUZ17QJkZA/
	 C117gdp4oVHAf67WcWumsxGY1Q1yTOxalN1pSNZzNE3AE9xhVBIDeHhyT4YvFzTgwG
	 Ip2I/jIyHQk+ouBESlq0nTLQWS0hHxZguuysXxeWsrxyNxDpaHKa4sFXcTxitAqSw6
	 +fBTiJ3sCidpIldzITSRUjpE0YXt0N14QxItdtAitnCm4PLi9x8xlslcz30JxRBF3l
	 qZxx3DIxjXqAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 095/642] btrfs: run btrfs_error_commit_super() early
Date: Mon,  5 May 2025 18:05:11 -0400
Message-Id: <20250505221419.2672473-95-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit df94a342efb451deb0e32b495d1d6cd4bb3a1648 ]

[BUG]
Even after all the error fixes related the
"ASSERT(list_empty(&fs_info->delayed_iputs));" in close_ctree(), I can
still hit it reliably with my experimental 2K block size.

[CAUSE]
In my case, all the error is triggered after the fs is already in error
status.

I find the following call trace to be the cause of race:

           Main thread                       |     endio_write_workers
---------------------------------------------+---------------------------
close_ctree()                                |
|- btrfs_error_commit_super()                |
|  |- btrfs_cleanup_transaction()            |
|  |  |- btrfs_destroy_all_ordered_extents() |
|  |     |- btrfs_wait_ordered_roots()       |
|  |- btrfs_run_delayed_iputs()              |
|                                            | btrfs_finish_ordered_io()
|                                            | |- btrfs_put_ordered_extent()
|                                            |    |- btrfs_add_delayed_iput()
|- ASSERT(list_empty(delayed_iputs))         |
   !!! Triggered !!!

The root cause is that, btrfs_wait_ordered_roots() only wait for
ordered extents to finish their IOs, not to wait for them to finish and
removed.

[FIX]
Since btrfs_error_commit_super() will flush and wait for all ordered
extents, it should be executed early, before we start flushing the
workqueues.

And since btrfs_error_commit_super() now runs early, there is no need to
run btrfs_run_delayed_iputs() inside it, so just remove the
btrfs_run_delayed_iputs() call from btrfs_error_commit_super().

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ca821e5966bd3..e4eda8b0f9381 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4328,6 +4328,14 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* clear out the rbtree of defraggable inodes */
 	btrfs_cleanup_defrag_inodes(fs_info);
 
+	/*
+	 * Handle the error fs first, as it will flush and wait for all ordered
+	 * extents.  This will generate delayed iputs, thus we want to handle
+	 * it first.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info)))
+		btrfs_error_commit_super(fs_info);
+
 	/*
 	 * Wait for any fixup workers to complete.
 	 * If we don't wait for them here and they are still running by the time
@@ -4418,9 +4426,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (BTRFS_FS_ERROR(fs_info))
-		btrfs_error_commit_super(fs_info);
-
 	kthread_stop(fs_info->transaction_kthread);
 	kthread_stop(fs_info->cleaner_kthread);
 
@@ -4543,10 +4548,6 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 	/* cleanup FS via transaction */
 	btrfs_cleanup_transaction(fs_info);
 
-	mutex_lock(&fs_info->cleaner_mutex);
-	btrfs_run_delayed_iputs(fs_info);
-	mutex_unlock(&fs_info->cleaner_mutex);
-
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
 }
-- 
2.39.5


