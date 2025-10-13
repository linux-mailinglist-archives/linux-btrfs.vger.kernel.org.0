Return-Path: <linux-btrfs+bounces-17705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB5BD2E7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 169ED34B761
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68826FA56;
	Mon, 13 Oct 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFHG/xR9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4526F2B3
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357143; cv=none; b=W+JaCdTurklXE59GTsmozSdbf1MluEAnDIO8TJkVLB/F+zuFXPnSOrE3vT9gD2Vf3dbizPQ7RABbj8q5d098/wpwkOYupgLFqMJF/hVRFipmwnvF/ZkJ0K3CB/r6Ug562t4urzPVvsD6r48HB/s1vGIhGExdEipdi6WFAbbhGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357143; c=relaxed/simple;
	bh=COhWapP/RsXdLbUtH/O73WRbB58uSlioEuMLZWr16lM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dahVs3lqKf+lWFxLNTnwhr2fwz5gGgsHbZuqGPk+neRX4PUsQ7hoc/IbMM7qguoMcTdG5kwJeb+APbP6vOWtXNNDw4r28LQ03Gk2NixeMQRdctSB0YiwXTsyHYAuL9DMhO8S3lqYDAZ0zxkTO5HlJ5Bpp9tqyHmOLYPwbs/TcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFHG/xR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58B1C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357143;
	bh=COhWapP/RsXdLbUtH/O73WRbB58uSlioEuMLZWr16lM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hFHG/xR9ErqxmXytK6m1k6gJyX2O1UYExL6cpk/pOha4vQQWL9b1gKifdn4rLpczK
	 sW3zAi/W7NMLGZPvG6zXGcA3UnWQJ9Tz2zXSuIgvE5LYsXJvfYd7huBcXitK0Yg/7k
	 vSxfXI3Dt6QmBdQ/8mDw2GuTSHbIliciEd4MLKVts3EVUkfdIbkP1mPGp4F+DeRpc1
	 OPyQZL2AhFYk3l2qTIdTVPfZuMsKMWHnGGlk6lL9Ml6rfj2DdCl++Tvn3z0ptvd5M7
	 JbJGg3SQxkQcxiGmeNWbzt8DkiB3uKgKl4Gda5srM7fkOofV/wnxiZhTpisq6+KgWq
	 cRlOiPnf2IhIw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: avoid repeated computations in btrfs_mark_ordered_io_finished()
Date: Mon, 13 Oct 2025 13:05:32 +0100
Message-ID: <00cd878ee1a57343f7a2054041293c93761ee326.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
References: <cover.1760356778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We're computing a few values several times:

1) The current ordered extent's end offset inside the while loop, we have
   computed it and stored it in the 'entry_end' variable but then we
   compute it again later as the first argument to the min() macro;

2) The end file offset, open coded 3 times;

3) The current length (stored in variable 'len') computed 2 times, one
   inside an assertion and the other when assigning to the 'len' variable.

So use existing variables and add new ones to prevent repeating these
expressions and reduce the source code.

We were also subtracting one from the result of min() macro call and
then adding 1 back in the next line, making both operations pointless.
So just remove the decrement and increment by 1.

This also reduces very slightly the object code.

Before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1916576	 161679	  15592	2093847	 1ff317	fs/btrfs/btrfs.ko

After:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1916556	 161679	  15592	2093827	 1ff303	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 8a8aa6ed405b..dfda952dcf7b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -483,16 +483,15 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
 	u64 cur = file_offset;
+	const u64 end = file_offset + num_bytes;
 
-	trace_btrfs_writepage_end_io_hook(inode, file_offset,
-					  file_offset + num_bytes - 1,
-					  uptodate);
+	trace_btrfs_writepage_end_io_hook(inode, file_offset, end - 1, uptodate);
 
 	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
-	while (cur < file_offset + num_bytes) {
+	while (cur < end) {
 		u64 entry_end;
-		u64 end;
-		u32 len;
+		u64 this_end;
+		u64 len;
 
 		node = ordered_tree_search(inode, cur);
 		/* No ordered extents at all */
@@ -535,10 +534,9 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		 *	|
 		 *	cur
 		 */
-		end = min(entry->file_offset + entry->num_bytes,
-			  file_offset + num_bytes) - 1;
-		ASSERT(end + 1 - cur < U32_MAX);
-		len = end + 1 - cur;
+		this_end = min(entry_end, end);
+		len = this_end - cur;
+		ASSERT(len < U32_MAX);
 
 		if (can_finish_ordered_extent(entry, folio, cur, len, uptodate)) {
 			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
-- 
2.47.2


