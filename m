Return-Path: <linux-btrfs+bounces-13690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706FFAAAA6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3014C00D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCE37A8A8;
	Mon,  5 May 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSgq1s03"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2636F8B9;
	Mon,  5 May 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485884; cv=none; b=JhJbQi4Cf53Rk4i4pF8jdtvhQ8eEXiBaCtzqf7bXWFVSqdtfkC6sbm5HEmSi6FEo1jquIzGc15tHarTlJPwRJMhbYM0u+UJLXqDRd1RZ4GQTq2kfAdHb+JokobyCCnTDA2D32Xzx73y13OELLFaPbvK+bKf0hiU/aZbk4Wxsiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485884; c=relaxed/simple;
	bh=5C+RutIEGwromjBGuGpBY6kRTqE9lJOlXHPnU0bID00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fT3oTUyxUkK2OrOyeZftkXELWfhYmLSfqBqOQboeZ40jDC3g/DR3iKmGh8sbK3zDoEWpqTOLAI93CL7HWpRCEUh8+sCCQt4Bl0acRHi8uDCrxwbWlXWS21AuuuszBln5qgGMaGW2E1LxisW7vxfa76bpi5f6C5hAv5uAXNUTLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSgq1s03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975FCC4CEE4;
	Mon,  5 May 2025 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485883;
	bh=5C+RutIEGwromjBGuGpBY6kRTqE9lJOlXHPnU0bID00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSgq1s03VW5fnSzwzhvuxH31kVlFHhHtTfWS2kSKHq6uFbHFipvtysUzeUKFyKeXM
	 kqHLM+KWEhUMUUfZ/Y8mBdjoH4oQwaVnfDqE2SUm0Kk3lCkj6RKF+xKRaQm0kMZQpz
	 uag1XmPZmRkizrh00AmRuKo6+8Mkg1K91DFV1Tb88ly1qD5xAOwZ3HxgOfXXYoRvK/
	 8mNkDJaUzF725EXgD8cBOHpFpk83UzgohSjYzlhd7KfHNXg8N/GtPACvCBT//jUuql
	 Ztv+vyxaqPXLuYTaWHiVGbMBi1JT+xFm3/bgvBdMyaS19uGOxF1qVW+iuRyiZntjIm
	 /J2qMM3EAo9sw==
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
Subject: [PATCH AUTOSEL 6.6 046/294] btrfs: run btrfs_error_commit_super() early
Date: Mon,  5 May 2025 18:52:26 -0400
Message-Id: <20250505225634.2688578-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 2387210231f23..1e1650012606e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4313,6 +4313,14 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
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
@@ -4402,9 +4410,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (BTRFS_FS_ERROR(fs_info))
-		btrfs_error_commit_super(fs_info);
-
 	kthread_stop(fs_info->transaction_kthread);
 	kthread_stop(fs_info->cleaner_kthread);
 
@@ -4541,10 +4546,6 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
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


