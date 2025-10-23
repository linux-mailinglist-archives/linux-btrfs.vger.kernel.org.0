Return-Path: <linux-btrfs+bounces-18188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C1C02465
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6474919A5DFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045FC26ED49;
	Thu, 23 Oct 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1xurk6d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625926E71C
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235207; cv=none; b=riqwTadmX6RM5glE6Uc1K4yx8kfviz6ng8ioyJZHR+yMBimr2/Y+QDwowI0qE9+tjlWLJ7/aUCTpZHcIs3hNxvHYtQX/sYP658iD9Zrf2+HYQqCfp3OrvCnSqs4Io7hQM31tsVb/8Jpn01T9rShcCXrRQm2uC4uS6rrk9pE+LgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235207; c=relaxed/simple;
	bh=KRW3lM0eH9Vi0GBwQY8IQijSgGMGe3p/ckRZFkTZS2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3eHdJkzGxYRH+EprQtWiH/Q+7aPpcuDl8maKPBkNPEBkbLUJ27ybsFfAPxmKcTGwdwXPtdugzaefkQYzsc73Wcu/UL6SWUFpGr62LXnQBJFPdzFsjVkdZSYJTq1VO5OHJS1dQgt4D2GiWegrreEvHgx8gZDu+AmdcoiuOE8bHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1xurk6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C8EC4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235206;
	bh=KRW3lM0eH9Vi0GBwQY8IQijSgGMGe3p/ckRZFkTZS2E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p1xurk6dCmJ09C33d1Bf52suSDPTON84JhFWWOgKqLHkYgGgXICVAbn6VsTQ8gtNa
	 aAEURrctL2Wajr4OPnMHpuQvqcpYaiX9t86wHj6DSlykoK292mZk4TI8T9g9aeLH60
	 0FlErpvpFxWvLLfvbrJez+2os2J4LD/Uy3q/vOoAxGPibhW8BQ7NMXl5k6wT2DS7J8
	 QGLC1cSUVvJll0SFleifMrNwkcix9dc/0gfJizOhIH5NXPblviipiihUcv6L7gjmZv
	 P6prhZ7qh662QmpAgyDW7IHBs6VSQxp43CzN7aFMt/X4HXu/NtAexEmE5bXWm0BUTU
	 jDfWclGHA0zSg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/28] btrfs: return real error when failing tickets in maybe_fail_all_tickets()
Date: Thu, 23 Oct 2025 16:59:34 +0100
Message-ID: <76a600e5b39c0ed6c52b7c916379c1507d2443dc.1761234581.git.fdmanana@suse.com>
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

In case we had a transaction abort we set a ticket's error to -EIO, but we
have the real error that caused the transaction to be aborted returned by
the macro BTRFS_FS_ERROR(). So use that real error instead of -EIO.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 69237f5d6078..8b1cf7f6c223 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1082,7 +1082,7 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
-	const bool aborted = BTRFS_FS_ERROR(fs_info);
+	const int abort_error = BTRFS_FS_ERROR(fs_info);
 
 	trace_btrfs_fail_all_tickets(fs_info, space_info);
 
@@ -1096,16 +1096,16 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
-		if (!aborted && steal_from_global_rsv(space_info, ticket))
+		if (!abort_error && steal_from_global_rsv(space_info, ticket))
 			return true;
 
-		if (!aborted && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+		if (!abort_error && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
 			btrfs_info(fs_info, "failing ticket with %llu bytes",
 				   ticket->bytes);
 
 		remove_ticket(space_info, ticket);
-		if (aborted)
-			ticket->error = -EIO;
+		if (abort_error)
+			ticket->error = abort_error;
 		else
 			ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
@@ -1116,7 +1116,7 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 		 * here to see if we can make progress with the next ticket in
 		 * the list.
 		 */
-		if (!aborted)
+		if (!abort_error)
 			btrfs_try_granting_tickets(space_info);
 	}
 	return (tickets_id != space_info->tickets_id);
-- 
2.47.2


