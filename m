Return-Path: <linux-btrfs+bounces-18215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA33C024CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD11654328D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E9F29E0ED;
	Thu, 23 Oct 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwMZhUkq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777912737E6
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235232; cv=none; b=KMUZy00+NlaCvpiIZP4nYk2N3Yv5REcXRC4iBDlQhl5r7EgiF2pqm3uZfWOiF80QN7TaTlEST9KuLmvgs0YLQI73s+ePkNwSoB/RP1NIjQwN98r6zBYjJE9dc1cbNQnkADXkUwprUhTU+3gJRQ96iwSXM62nDIeWiMe021RDnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235232; c=relaxed/simple;
	bh=Y1myI7n//u6sNbGCAnIq3fUE+vrIEHe5ugibNyPvcg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkDf9V6CpGQWr6wYreY2SA1tspfJ+TPK/S3rDbLLm+/zNCYT9SI+LNFFfEYDC7xCCyFOk9M+sJr5pRqVhDg7/Ia63oSwRQcqGOYT28yYe6dyroJUTB+nmLBMC4nQ2Ws3zv1d9l6lZKiXDYdBcTLT+RZ6pvHPfsMBfgWUQ1CvO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwMZhUkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754DAC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235232;
	bh=Y1myI7n//u6sNbGCAnIq3fUE+vrIEHe5ugibNyPvcg0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gwMZhUkqn7Inw3JfIVuLGMOJx5GVvgh/qM2EHAdJFEDhze/waQ+GHsdyqL1hqL4um
	 Lq+zRt5aEdm9gjmvBmnvGuxukmBRzmLaMI7o/CIKEnNMiQkKJ1+g8s0bLkpuMMyCED
	 l2gDzUN4RjA2oz64B0CjuPsqfxxIROVviXXXFfKzeNu2dyZDSrm8hy9U1Elf8/lq64
	 27PYu63X11YKLDyteJyOeT8dzuXIpY9jwE+TQe1aFnMGALvle1VofjDJUNRoEex7vj
	 0B8ww6FyP5eUERKrenky7qhR/2agcqmi7AexEOOs+Jq2bb7WZNI1K8lXUffBuS1XtC
	 3F4esZcW02HGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 28/28] btrfs: tag as unlikely fs aborted checks in space flushing code
Date: Thu, 23 Oct 2025 17:00:01 +0100
Message-ID: <cbaa4c2a20267a3cef6d534b35e2b5d2321dec85.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's not expected to have the fs in an aborted state, so surround the
abortion checks with unlikely to make it clear it's unexpected and to
hint the compiler to generate better code.

Also at maybe_fail_all_tickets() untangle all repeated checks for the
abortion into a single if-then-else. This makes things more readable
and makes the compiler generate less code. On x86_64 with gcc 14.2.0-19
from Debian I got the following object size differentes.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  2021606	 179704	  25088	2226398	 21f8de	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  2021458	 179704	  25088	2226250	 21f84a	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cce53a452fd3..cc8015c8b1ff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1114,27 +1114,26 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 	       tickets_id == space_info->tickets_id) {
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
+		if (unlikely(abort_error)) {
+			remove_ticket(space_info, ticket, abort_error);
+		} else {
+			if (steal_from_global_rsv(space_info, ticket))
+				return true;
 
-		if (!abort_error && steal_from_global_rsv(space_info, ticket))
-			return true;
-
-		if (!abort_error && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_info(fs_info, "failing ticket with %llu bytes",
-				   ticket->bytes);
+			if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+				btrfs_info(fs_info, "failing ticket with %llu bytes",
+					   ticket->bytes);
 
-		if (abort_error)
-			remove_ticket(space_info, ticket, abort_error);
-		else
 			remove_ticket(space_info, ticket, -ENOSPC);
 
-		/*
-		 * We're just throwing tickets away, so more flushing may not
-		 * trip over btrfs_try_granting_tickets, so we need to call it
-		 * here to see if we can make progress with the next ticket in
-		 * the list.
-		 */
-		if (!abort_error)
+			/*
+			 * We're just throwing tickets away, so more flushing may
+			 * not trip over btrfs_try_granting_tickets, so we need
+			 * to call it here to see if we can make progress with
+			 * the next ticket in the list.
+			 */
 			btrfs_try_granting_tickets(space_info);
+		}
 	}
 	return (tickets_id != space_info->tickets_id);
 }
@@ -1410,7 +1409,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 		}
 
 		/* Something happened, fail everything and bail. */
-		if (BTRFS_FS_ERROR(fs_info))
+		if (unlikely(BTRFS_FS_ERROR(fs_info)))
 			goto aborted_fs;
 		last_tickets_id = space_info->tickets_id;
 		spin_unlock(&space_info->lock);
@@ -1444,7 +1443,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 			}
 
 			/* Something happened, fail everything and bail. */
-			if (BTRFS_FS_ERROR(fs_info))
+			if (unlikely(BTRFS_FS_ERROR(fs_info)))
 				goto aborted_fs;
 
 		}
@@ -1548,7 +1547,7 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 	 * just to have caller fail immediately instead of later when trying to
 	 * modify the fs, making it easier to debug -ENOSPC problems.
 	 */
-	if (BTRFS_FS_ERROR(fs_info))
+	if (unlikely(BTRFS_FS_ERROR(fs_info)))
 		remove_ticket(space_info, ticket, BTRFS_FS_ERROR(fs_info));
 	else if (!steal_from_global_rsv(space_info, ticket))
 		remove_ticket(space_info, ticket, -ENOSPC);
-- 
2.47.2


