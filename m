Return-Path: <linux-btrfs+bounces-18194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9CC02472
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867BC1AA2677
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F7F26ED42;
	Thu, 23 Oct 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI+VFQcY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D552777EA
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235212; cv=none; b=EvzceaUMs18INzglkWp8ovJa7wDiN4ixwzqfn9zomKLsqGt2uaECWeaw9dHo1+/1ldlfSK+iYwqhmK19RFUQcBApoOfIpZzWX8w+mEQMcOSUEDXpY0daNGD1PEQaACSi1Q8gF+lLGOrzYTpaQG3WAI1s11X/4pyF5Ogqts4DyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235212; c=relaxed/simple;
	bh=nGuu/39uzkcyq5yL1mNVJk0ScD6wwrrTfiyq4CRIBdQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxQfrmr26ozmOJR0si/edob8xaouVjO4CYCILnHR8dzrsPCWxq/4q2G++/kL5dAsB9MyIF/5vIGHAfNKe7+SmuaJFSYwZxX3ZaGrtTWNsKvLuiLz8J5ORVkCz+0U8/ofd8xLbGD9idpgNIf3NchI4kQOrFb9vWlpern1/Z/pvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI+VFQcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0204C4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235212;
	bh=nGuu/39uzkcyq5yL1mNVJk0ScD6wwrrTfiyq4CRIBdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZI+VFQcY+Dh1638kKJ4EqWUUZjvYRihYWCTVDQ63YEgIJodiQyJK2Re+t3Ght0ilc
	 MtRZioU4jBcLqHBnUPRiGwqo7MFStJbOm5o6pqZsCV/8kFuRg+ddUi7Ul1lZgyeoKA
	 femKAXvzZHD6bvlDgNBQMTGZ5V5a2ndATf3GvlISNgtLuNQczsjTJpzQY7YnqytKiH
	 ofU506sz0Q3ueblrj6XRczWYk6BUxhin91pHJ0IGFu33xaWzXsgxpxa8jXIwYHJOam
	 +hm+0NYvKyxlgBc2v/QpMg64e8BPa8WH9c1ksKAz4zdqWrMFN6kyQlz+kU1+vn2Vtf
	 kuW6l+1IFNINA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/28] btrfs: bail out earlier from need_preemptive_reclaim() if we have tickets
Date: Thu, 23 Oct 2025 16:59:40 +0100
Message-ID: <771cf13daa7c6e7ebc3ab17891c34004b5db7a1d.1761234581.git.fdmanana@suse.com>
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

Instead of doing some calculations and then return false if it turns out
we have queued tickets, check first if we have tickets and return false
immediately if we have tickets, without wasting time on doing those
computations.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 53677ecb8c15..bd206fc300e7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -937,10 +937,17 @@ static bool need_preemptive_reclaim(const struct btrfs_space_info *space_info)
 	u64 thresh;
 	u64 used;
 
-	thresh = mult_perc(space_info->total_bytes, 90);
-
 	lockdep_assert_held(&space_info->lock);
 
+	/*
+	 * We have tickets queued, bail so we don't compete with the async
+	 * flushers.
+	 */
+	if (space_info->reclaim_size)
+		return false;
+
+	thresh = mult_perc(space_info->total_bytes, 90);
+
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved +
 	     global_rsv_size) >= thresh)
@@ -960,13 +967,6 @@ static bool need_preemptive_reclaim(const struct btrfs_space_info *space_info)
 	if (used - global_rsv_size <= SZ_128M)
 		return false;
 
-	/*
-	 * We have tickets queued, bail so we don't compete with the async
-	 * flushers.
-	 */
-	if (space_info->reclaim_size)
-		return false;
-
 	/*
 	 * If we have over half of the free space occupied by reservations or
 	 * pinned then we want to start flushing.
-- 
2.47.2


