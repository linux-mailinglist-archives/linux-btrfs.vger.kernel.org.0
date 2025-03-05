Return-Path: <linux-btrfs+bounces-12029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6962A506AF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143493A7709
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02951250BE9;
	Wed,  5 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzgipmvm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CE2500CF
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196757; cv=none; b=oVLGpymUOaqj03qHu0T6ynGeOngGe2rapVdfv0ZkHsa9HxPiY0P3OZF8l28kLrPwtpDjlNbJqox3lceBPNm4H79DjFqqaHDDBrsJSXS2Dd3ZnSOHsauQmIn54++xMoUuH85yjsbY40px/+iDEJcvcXEyOTcO2VIPjed5gEOZChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196757; c=relaxed/simple;
	bh=aodlA1CuClmpgOwW88QPNv4Z4Lx/b5Qm+uq1Sc0PweQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOKAct3aN/zrlTbqelXZmXx1rsDQx99rW1cgM/HOFKOciif4TY+PYeJIAlGoiBzs4IQWUt+1RVkKtbaZQkY3QkY4YRz6iYM4MVSR177zFPobZ5wXqkVVZu18UmsJd1cm7GUXFFM0zyGe7Gy9otscN5fJtJFkVSsG4BqhSIJQrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzgipmvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2528AC4CEE0
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196756;
	bh=aodlA1CuClmpgOwW88QPNv4Z4Lx/b5Qm+uq1Sc0PweQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yzgipmvmyrfdw3LR62qsE1fT3Nz3rAHLrV7ksZ54ylVpf4ghz1IRSZzJVyKxPHNX9
	 6SXKYtl11scJfYsP7IkmjIGpCHfH9Qjy6tatWZh4Grr+1znabL3N4k66gChr45x9ba
	 SB1FehXtH+9jhZ928DvHRGtALofMbrpBx1JxXXZGE7hskqjkEMD10MD1oRxYW+vCbU
	 dmVDTSfu5rxxHdrOGfZz4cbWWHY1V6KCvjF/AbdRHD/KuXoXbL/MSGnssfQaWiN2IL
	 DDBc7XZlOzb5EwT9uKOJB2pHu4k0Vfy+U2M+uFCwV6INWOTVR5iIFWg96VbrmsqDSw
	 e6Mr7por4KvTA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix non-empty delayed iputs list on unmount due to endio workers
Date: Wed,  5 Mar 2025 17:45:47 +0000
Message-Id: <6421b94741d35f6ca2fa2e85afcf5a7eb39d38a5.1741196484.git.fdmanana@suse.com>
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

Sometimes this assertion may fail because delayed iputs may have been
added to the list after we last ran delayed iputs, and this happens due
to workers in the endio_workers workqueue still running. These workers can
do a final put on an ordered extent attached to a data bio, which results
in adding a delayed iput. This is done at btrfs_bio_end_io() and its
helper __btrfs_bio_end_io().

Fix this by flushing the endio_workers workqueue before running delayed
iputs at close_ctree().

David reported this when running generic/648.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: ec63b84d4611 ("btrfs: add an ordered_extent pointer to struct btrfs_bio")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d96ea974ef73..df8e075e69a3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4340,6 +4340,16 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * We can also have ordered extents getting their last reference dropped
+	 * from the endio_workers workqueue because for data bios we keep a
+	 * reference on an ordered extent which gets dropped when running
+	 * btrfs_bio_end_io() in that workqueue, and that final drop results in
+	 * adding a delayed iput for the inode.
+	 */
+	if (fs_info->endio_workers)
+		flush_workqueue(fs_info->endio_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
-- 
2.45.2


