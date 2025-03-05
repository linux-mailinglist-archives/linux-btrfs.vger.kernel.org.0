Return-Path: <linux-btrfs+bounces-12034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B2A509A0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292277AA1A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E229254852;
	Wed,  5 Mar 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk0U0+Zf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA8251798
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198675; cv=none; b=c2EOnLc6c1S8QCITjS6rnQMCtuqg++UreBApVtBvZK9weVQJPSin5oMhYF/E0lGqNdo1PBe9xQGJCnKSCAjvf4zXMBXRP8lQQXO0xxDOoDJL7WyOvsXDN7xa8Kj1BaXtoqa+pVSIh50EbCS698lcmY+BHS1Vt7ugDVwWWShL2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198675; c=relaxed/simple;
	bh=GnwABZja+u7FKNqckJXjm8zIcmtAQUN5PrFZUsArmo4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2Zaf36Ge/2a84NcM08oOx8/JTX7BaNtb+GL4aRTJyG+wr3/Mo76csHnS1ekOkK6b4vAO4eTFjDCt7BzW7LiywkMgqMszsVd+/wwWp5lXGeFAVlet2NsXs/5BzfSDHxLfynKNM8tFvI9VBZxJJZjeoYaBE02YKGUwBavXrG4q4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk0U0+Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA77C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198675;
	bh=GnwABZja+u7FKNqckJXjm8zIcmtAQUN5PrFZUsArmo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gk0U0+ZfyHckx59lLG825GyNZV3nYsZh3UTpb3C7S+veUcsk6I0OIipARyI2JBhvE
	 EYwK37rAcsO/yYrroCqmjc3KGnIywhxRjFJwplt9Kvubic6Mi5ePNDBNl1dIWpu5g3
	 JP0/hHUGw8/AkKWK5foPZcxnjywCbVOIyzNZNCub9WR1+lrE3/0o+LESj8/rtHLY++
	 S0I/+J+yLctFZjeS9OvgGDLVm2f/QTtSoWG8TpgUApkvj1t0XOMLPV2l4ZyFSoEvWJ
	 dSFrms93/MHe11BTXhsb252LADVOhg+izr0GsV9KLbhyyPKTlq+DLKCocFzQlSPVf9
	 GCjAMo6mIjy1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: fix non-empty delayed iputs list on unmount due to endio workers
Date: Wed,  5 Mar 2025 18:17:47 +0000
Message-Id: <e1cf2949e4b03fba268f923947543bbf4a7b6752.1741198394.git.fdmanana@suse.com>
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
 fs/btrfs/disk-io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d96ea974ef73..b6194ae97361 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4340,6 +4340,15 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * We can also have ordered extents getting their last reference dropped
+	 * from the endio_workers workqueue because for data bios we keep a
+	 * reference on an ordered extent which gets dropped when running
+	 * btrfs_bio_end_io() in that workqueue, and that final drop results in
+	 * adding a delayed iput for the inode.
+	 */
+	flush_workqueue(fs_info->endio_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
-- 
2.45.2


