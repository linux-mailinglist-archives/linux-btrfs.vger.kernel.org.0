Return-Path: <linux-btrfs+bounces-12035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A5A509CB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6CD1897953
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764C248871;
	Wed,  5 Mar 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2JScHwr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694225485B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198676; cv=none; b=op/i+hkkYhPW/OR1zceODhNh3jqSWCeaZDf6QDkLL1NW5lOKtPYDb27F0KOijfBof8kC3Awzd+QPGC705Tc35cuzo9xOlT0w3hGAD8AUVDCojuariCSY1t8Q6qjfZ2aq3xh6Su6rsT2oER06F0PV4FUVx4/zPkR3VY3iKdx6bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198676; c=relaxed/simple;
	bh=XmChc0syTGzI4PfyPGOYDisNWqzuEgQxc3+1lnLelag=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKAJJAQMDNcAzJTjXIRh7hzhIUOwiWoOh47DKtKn1CX0iTp/0mDe9OzmSBTF3UdvOEs2hBKDJIh6mPghBZCNFw4VarBumnqKSPHfBJN/nnRrJMxzN8p6lDyqxiivo/6G54YsK/xtr4e6RZ538EhZx/x1YFhz6k3TH/YNY4SGqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2JScHwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9877AC4CEE0
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198676;
	bh=XmChc0syTGzI4PfyPGOYDisNWqzuEgQxc3+1lnLelag=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B2JScHwrhYYVfMvVP7qC9JOJoZvuXyZ8QTV6EJAV2pffb+S1c3FvICy2bvVjiSFnN
	 j9zNipIy4SM9ThkYlufV3c2J3ocMTyvX3+/+UARRqoD+WmYp4IY1i/ArVAOpR26n6y
	 QGPokbM5U37iV0ss0ezYaN+LG0jmriCkcgtEfYbIuGuYjWtSoUiRZ4jUDZR5WpqKaM
	 Yp7UiJcCYKwWf2Hv8jR0Ut0cA3uuNBZVAtxeUChpoBYfEf8l/SD/efq7ZgFTews+a0
	 SWOpOFpkz/zIvI6l8xsN4o7fIN0LViA1tEhvcx7MgDQYYSfLUrYxaFrTs8ndgMXS8f
	 zExn5CtHTJJDA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
Date: Wed,  5 Mar 2025 18:17:48 +0000
Message-Id: <617abbacfa82b497460a8c2b3319fbca010037b4.1741198394.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741198394.git.fdmanana@suse.com>
References: <cover.1741198394.git.fdmanana@suse.com>
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
 fs/btrfs/disk-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b6194ae97361..cae5113b91da 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4349,6 +4349,18 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
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
+	flush_workqueue(fs_info->compressed_write_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
-- 
2.45.2


