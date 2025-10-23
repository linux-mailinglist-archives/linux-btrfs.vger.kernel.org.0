Return-Path: <linux-btrfs+bounces-18213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E304CC024C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA84F491C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FB829C328;
	Thu, 23 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaHuW+8c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361F2737E0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235230; cv=none; b=eosAEIxWg8HEBM6UZ8fgTSDFrA7fTe/x9sK/VCHDmfUzuCexTWWVQyaPRocYzV+BUR3gVkfAnodkKcpZSKxJk17bowdkUMZZLepPdaPang9IXX4MCfeaATtQaH5Z/LMRxUbiiFsfysJBppdFyal9LIacFyxp75P64yhQaTIYDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235230; c=relaxed/simple;
	bh=nodYopArzZVT6zoY8r7dhJtU5Y/7Ngh0Fk6lqPbL7OI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duh4p1QeHwAL7nSLETM1t8rA2U8nDmycUQwi5FiGHQrVA/EMm4xl7bwfKFSWkBQIAUuOIwRAzb3o2tQITil3HXGryHlqylfFB0WxYzS1A0sTHS9k2RYnbRFeyLHjp4xdfOA0PhOQqDyV7mcS8BGVOGIlfwifvE5N9y+7duBu+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaHuW+8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A4CC4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235230;
	bh=nodYopArzZVT6zoY8r7dhJtU5Y/7Ngh0Fk6lqPbL7OI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AaHuW+8cK4NlnRcNvw4JBKAM8mzS+LBWyBvQQHgNbpk2A64SF8gpos6rRpJIlX7OP
	 TiWhxQqfN9hd8f8WUeBAEQZQQrfvfszamY6A7mYer4Z6uGUNYTPCKoYSWs6V0qRuZ8
	 uDgC1/26vm6AazjKWnhEPRada9FCjKC+Wb6YLKeiN1lEyr/Q+r+vO1dskr5/qORRyR
	 6pSMdWw3wdXH245tWHPoznSOZBBRxFiv2LsoqWW89IsK+ekoKVBdgT65tbROOOtauP
	 JznFGl9P6MxXjnZTfI8yQF7A3C2ZsLXOpaA5Nuj4JUJDoObSJ7d36LOwV8a6sw93C6
	 6hnj0Kfkv+ASA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 26/28] btrfs: move ticket wakeup and finalization to remove_ticket()
Date: Thu, 23 Oct 2025 16:59:59 +0100
Message-ID: <97f625d11171c54f9cabe74434947eb0166c3707.1761234581.git.fdmanana@suse.com>
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

Instead of repeating the wakeup and setup of the ->bytes or ->error field,
move those steps to remove_ticket() to avoid duplication. This is also
needed for the next patch in the series, so that we avoid duplicating more
logic.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index be58f702cc61..86cd87c5884a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -515,13 +515,20 @@ bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
 }
 
 static void remove_ticket(struct btrfs_space_info *space_info,
-			  struct reserve_ticket *ticket)
+			  struct reserve_ticket *ticket, int error)
 {
 	if (!list_empty(&ticket->list)) {
 		list_del_init(&ticket->list);
 		ASSERT(space_info->reclaim_size >= ticket->bytes);
 		space_info->reclaim_size -= ticket->bytes;
 	}
+
+	if (error)
+		ticket->error = error;
+	else
+		ticket->bytes = 0;
+
+	wake_up(&ticket->wait);
 }
 
 /*
@@ -549,10 +556,8 @@ void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 		if (used_after <= space_info->total_bytes ||
 		    can_overcommit(space_info, used, ticket->bytes, flush)) {
 			btrfs_space_info_update_bytes_may_use(space_info, ticket->bytes);
-			remove_ticket(space_info, ticket);
-			ticket->bytes = 0;
+			remove_ticket(space_info, ticket, 0);
 			space_info->tickets_id++;
-			wake_up(&ticket->wait);
 			used = used_after;
 		} else {
 			break;
@@ -1066,9 +1071,7 @@ static bool steal_from_global_rsv(struct btrfs_space_info *space_info,
 		global_rsv->full = false;
 	spin_unlock(&global_rsv->lock);
 
-	remove_ticket(space_info, ticket);
-	ticket->bytes = 0;
-	wake_up(&ticket->wait);
+	remove_ticket(space_info, ticket, 0);
 	space_info->tickets_id++;
 
 	return true;
@@ -1115,12 +1118,10 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 			btrfs_info(fs_info, "failing ticket with %llu bytes",
 				   ticket->bytes);
 
-		remove_ticket(space_info, ticket);
 		if (abort_error)
-			ticket->error = abort_error;
+			remove_ticket(space_info, ticket, abort_error);
 		else
-			ticket->error = -ENOSPC;
-		wake_up(&ticket->wait);
+			remove_ticket(space_info, ticket, -ENOSPC);
 
 		/*
 		 * We're just throwing tickets away, so more flushing may not
@@ -1536,13 +1537,10 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 	 * just to have caller fail immediately instead of later when trying to
 	 * modify the fs, making it easier to debug -ENOSPC problems.
 	 */
-	if (BTRFS_FS_ERROR(fs_info)) {
-		ticket->error = BTRFS_FS_ERROR(fs_info);
-		remove_ticket(space_info, ticket);
-	} else if (!steal_from_global_rsv(space_info, ticket)) {
-		ticket->error = -ENOSPC;
-		remove_ticket(space_info, ticket);
-	}
+	if (BTRFS_FS_ERROR(fs_info))
+		remove_ticket(space_info, ticket, BTRFS_FS_ERROR(fs_info));
+	else if (!steal_from_global_rsv(space_info, ticket))
+		remove_ticket(space_info, ticket, -ENOSPC);
 
 	/*
 	 * We must run try_granting_tickets here because we could be a large
@@ -1574,8 +1572,7 @@ static void priority_reclaim_data_space(struct btrfs_space_info *space_info,
 		}
 	}
 
-	ticket->error = -ENOSPC;
-	remove_ticket(space_info, ticket);
+	remove_ticket(space_info, ticket, -ENOSPC);
 	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
@@ -1599,8 +1596,7 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
 			 * despite getting an error, resulting in a space leak
 			 * (bytes_may_use counter of our space_info).
 			 */
-			remove_ticket(space_info, ticket);
-			ticket->error = -EINTR;
+			remove_ticket(space_info, ticket, -EINTR);
 			break;
 		}
 		spin_unlock(&space_info->lock);
-- 
2.47.2


