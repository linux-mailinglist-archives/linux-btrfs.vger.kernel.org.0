Return-Path: <linux-btrfs+bounces-12030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C346A506AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9EB1891371
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C082512E1;
	Wed,  5 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWw7hWaA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37686250C0D
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196758; cv=none; b=ZvXBkM4HAnoD8am/jHvvijxkiDMJUDvmdKgfqpvCcvuxlqocCK+aFE+lDhs9FKbOifCLJFtgrxRn9JwJQI28fb64bn1l7/12qnWJdH9elpN6s7dtLeyxwgo38FQ95ShlgNYxA0gnYKeKilCsZM3QMSIAp/BV1BLrbVTq59eiW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196758; c=relaxed/simple;
	bh=2UyXHbsP9U4V63YhVQ8jwT7pZp3V8BmgdW6TRlynpCg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvXeuaCv7mpM53eEJjBLFGEGZeE7XoLXB+wNGG+am5/ihJZqqjXHsJvDtPuof1haRf5ZlZSp1IFQPvKnrI+LwD+pVLwI3Gvjwx7FxxuMGXw/EQCU4Kt8Om2jQj3ouJzWf2x3BhoLy1haNGPf7Xr1d6QvIWwVWSaP5yYj7+ekBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWw7hWaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28970C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196757;
	bh=2UyXHbsP9U4V63YhVQ8jwT7pZp3V8BmgdW6TRlynpCg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MWw7hWaAh19U9iEasW40snB2XemXlh97gjo6UuIAdd1CHeASlvk+5jWmKy3iz2BhV
	 FJRhgk1CECtI9y600wKC1beSe4O2u+UdfnysPTPD965PFD+gnWkM2tETGbSYKP3Vn+
	 ZxtQXIgiuVGA2/moVzFtp58Va0w+1mJLa6ylp5Ky6ycFEymrvnty5kbNiOhELFb8/e
	 cL3oyJI4Zt2DkIYsYUL3JxPMJu920fmBGH5kEdOAJHDM8IdKICQR9RAbD/qWGCiDHG
	 ggpu1ndXTjdlgfMvGplztccb65b4Zy40sdeucc7s7seYHaenEg2Ai0WgHzuRPiq6Hk
	 ECS4fF9FhFX+g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
Date: Wed,  5 Mar 2025 17:45:48 +0000
Message-Id: <3111c41408f2cb11096b9fe002a08fd09b8fb89c.1741196484.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741196484.git.fdmanana@suse.com>
References: <cover.1741196484.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At close_ctree() after we have ran delayed iputs either through explicitly
calling btrfs_run_delayed_iputs() or later during the call to
btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
delayed iputs list is empty.

When we have compressed writes this assertion may fail because delayed
iputs may have been added to the list after we last ran delayed iputs.
This happens like this:

1) We have a compressed write bio executing;

2) We enter close_ctree() and flush the fs_info->endio_write_workers
   queue which is the queue used for running ordered extent completion;

3) The compressed write bio finishes and enters
   btrfs_finish_compressed_write_work(), where it calls
   btrfs_finish_ordered_extent() which in turn calls
   btrfs_queue_ordered_fn(), which queues a work item in the
   fs_info->endio_write_workers queue that we have flushed before;

4) At close_ctree() we proceed, run all existing delayed iputs and
   call btrfs_commit_super() (which also runs delayed iputs), but before
   we run the following assertion below:

      ASSERT(list_empty(&fs_info->delayed_iputs))

   A delayed iput is added by the step below...

5) The ordered extent completion job queued in step 3 runs and results in
   creating a delayed iput when dropping the last reference of the ordered
   extent (a call to btrfs_put_ordered_extent() made from
   btrfs_finish_one_ordered());

6) At this point the delayed iputs list is not empty, so the assertion at
   close_ctree() fails.

Fix this by flushing the fs_info->compressed_write_workers queue at
close_ctree() before flushing the fs_info->endio_write_workers queue,
respecting the queue dependency as the later is responsible for the
execution of ordered extent completion.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index df8e075e69a3..95277c05fefa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4350,6 +4350,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	if (fs_info->endio_workers)
 		flush_workqueue(fs_info->endio_workers);
 
+	/*
+	 * When finishing a compressed write bio we schedule a work queue item
+	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
+	 * calls btrfs_finish_ordered_extent() which in turns does a call to
+	 * btrfs_queue_ordered_fn(), and that queues the ordered extent
+	 * completion either in the endio_write_workers work queue or in the
+	 * fs_info->endio_freespace_worker work queue. We flush those queues
+	 * below, so before we flush them we must flush this queue for the
+	 * workers of compressed writes.
+	 */
+	if (fs_info->compressed_write_workers)
+		flush_workqueue(fs_info->compressed_write_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
-- 
2.45.2


