Return-Path: <linux-btrfs+bounces-13674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E48AAA0D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8983B091A
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31AA296174;
	Mon,  5 May 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp/+awGQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DB296145;
	Mon,  5 May 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483523; cv=none; b=cpk+rb287qMJWgbU+pHXJXUy4LhSXAsvVI1mavOAQy93oMZMQu09uSCMgcdz5ygdF0aBxybhoTheCwOy4t3cxbJLGfu2XeIw0Y4YuBBw01poXvJu1O6cK3nn0gjjtveNrsTCfUkHbRC3JkquVGDJ/ZgaLHYk2pxOALzQSlPD4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483523; c=relaxed/simple;
	bh=jkm0fkCE5NqFa14r0502dILz0nUgbm8jnIxuHTMrtO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAA/ITFndGKvDEGszi+ijaPzhXxq7cTCyOR0iwP3d2Eu5VFVXDVsFW2cX80SPKpq4qwt75XI2puVIW6OSmpcZ2nPU+k1OSg8+ld3XDmOsU1XmUwJzHkpYssKs6m0J+KCZ2oP5BTrVK/5HWJpqrzUEq+I5fjXE7H8TTlRymQ4Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp/+awGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5C9C4CEED;
	Mon,  5 May 2025 22:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483522;
	bh=jkm0fkCE5NqFa14r0502dILz0nUgbm8jnIxuHTMrtO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bp/+awGQdGuwQllVsEMuMKki6NIvptugBHYgZGJD7muRcySzScPJesCK82/8undo9
	 Wm7cglzdtRIZNHjmd1UYdZfQFLz3YsC73cj1WbvhE2rNf6HZIiJ+CXi2QINyBXRFKk
	 I8ViVL4w+ic4XwY0LmUq01AoEpPuieS1TsO9UhxNl2pg80bR4wqVF/HiZtmx3W8W7I
	 PerECPd0ctwtsbR4OahvvcEszMrwF5kH8fldgo1yQVt9Md/76L1mNgboMm9+OIH0v9
	 8WQDOybNBdPQqJbCmGRf6oIFb2RaU9YyC5IIRR8jpcNWx+nL5anLgkMEvnM5v7Jlfe
	 Xq3BEGcfxWihg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 096/642] btrfs: fix non-empty delayed iputs list on unmount due to async workers
Date: Mon,  5 May 2025 18:05:12 -0400
Message-Id: <20250505221419.2672473-96-sashal@kernel.org>
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

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit cda76788f8b0f7de3171100e3164ec1ce702292e ]

At close_ctree() after we have ran delayed iputs either explicitly through
calling btrfs_run_delayed_iputs() or later during the call to
btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
delayed iputs list is empty.

We have (another) race where this assertion might fail because we have
queued an async write into the fs_info->workers workqueue. Here's how it
happens:

1) We are submitting a data bio for an inode that is not the data
   relocation inode, so we call btrfs_wq_submit_bio();

2) btrfs_wq_submit_bio() submits a work for the fs_info->workers queue
   that will run run_one_async_done();

3) We enter close_ctree(), flush several work queues except
   fs_info->workers, explicitly run delayed iputs with a call to
   btrfs_run_delayed_iputs() and then again shortly after by calling
   btrfs_commit_super() or btrfs_error_commit_super(), which also run
   delayed iputs;

4) run_one_async_done() is executed in the work queue, and because there
   was an IO error (bio->bi_status is not 0) it calls btrfs_bio_end_io(),
   which drops the final reference on the associated ordered extent by
   calling btrfs_put_ordered_extent() - and that adds a delayed iput for
   the inode;

5) At close_ctree() we find that after stopping the cleaner and
   transaction kthreads the delayed iputs list is not empty, failing the
   following assertion:

      ASSERT(list_empty(&fs_info->delayed_iputs));

Fix this by flushing the fs_info->workers workqueue before running delayed
iputs at close_ctree().

David reported this when running generic/648, which exercises IO error
paths by using the DM error table.

Reported-by: David Sterba <dsterba@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e4eda8b0f9381..cc8d736937012 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4356,6 +4356,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * We can have ordered extents getting their last reference dropped from
+	 * the fs_info->workers queue because for async writes for data bios we
+	 * queue a work for that queue, at btrfs_wq_submit_bio(), that runs
+	 * run_one_async_done() which calls btrfs_bio_end_io() in case the bio
+	 * has an error, and that later function can do the final
+	 * btrfs_put_ordered_extent() on the ordered extent attached to the bio,
+	 * which adds a delayed iput for the inode. So we must flush the queue
+	 * so that we don't have delayed iputs after committing the current
+	 * transaction below and stopping the cleaner and transaction kthreads.
+	 */
+	btrfs_flush_workqueue(fs_info->workers);
+
 	/*
 	 * When finishing a compressed write bio we schedule a work queue item
 	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
-- 
2.39.5


