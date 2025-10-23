Return-Path: <linux-btrfs+bounces-18191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55759C0246E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DFE1AA24A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30526E71F;
	Thu, 23 Oct 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRXfgtkJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8A26FDB3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235209; cv=none; b=uuRacWW2H12ocCrkRgmyG++dj2PdWUhO9tCZBhZoEXODAH3r7A7959aUmCA1JOx4ieT8ICOMtHOb5Szk0CbSQZfaTA0XkLxrYhtcs24HO9JjhMUraBgWm9YcrnlPHoXGJU6gtC00IsxGlzU2jzyxo9NDwFZN50cahNdj7PiRjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235209; c=relaxed/simple;
	bh=z+l+R1CR4IAK0lq7g8JZpux2r3c7VhCxBXO0qmGcD3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvwZGgmr3dKr6jfUyf+ixEp7SGek1aR38GYYnpRNkZzuwE6ZNSnaxPjlOd0J7ubT+jRYc/nyq0d8vH2ZPB4TtoP5ojRPwaMrokmMsNRGDYXHvyoxFZzJKw/l8OIuTlNho63mKMXs9ZDSsOTILlVPv4w9+EVVg6lolQnHVWsQysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRXfgtkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED85C4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235209;
	bh=z+l+R1CR4IAK0lq7g8JZpux2r3c7VhCxBXO0qmGcD3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HRXfgtkJoLATSnln1hWg8fNDhfbs5cR6cF+U3YfbVseUpmSE3CnrMne8YDwbEUEpr
	 tIgugdJ/FfLpKVrTx8ZKhn8Ct/9tRwzGuNgVTEQV3SuBY7s44A0S4fYq7Bf/ldgttl
	 EELRJm99owmN6KNjPC7b+H2e0UHLEXuPlbDix5txOiaR+Uyhtt+MAfpabh/KSYD45b
	 CXh5zbQk7cRm7ZdwLhRfe5neS46+I6jJb3A1bSgFko5SQONoB5yCG1kHjn/O+VZ52v
	 PnTioMZipj7PWJ7mKE3H6jtqdsmFK2RwE6iuQUjSqpSRiopm5FrOwr+uqBdRRa5YEM
	 HWYsZC9uG6LBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/28] btrfs: avoid used space computation when trying to grant tickets
Date: Thu, 23 Oct 2025 16:59:37 +0100
Message-ID: <07b1409674a71d7a51d85dc16108d8b007731493.1761234581.git.fdmanana@suse.com>
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

In btrfs_try_granting_tickets(), we call btrfs_can_overcommit() and that
calls btrfs_space_info_used(). But we already keep track, in the 'used'
local variable, of the used space in the space_info, so we are just
repeating the same computation and doing an extra function call while we
are holding the space_info's spinlock, which is heavily used by the space
reservation and flushing code.

So add a local variant of btrfs_can_overcommit() that takes in the used
space as an argument and therefore does not call btrfs_space_info_used(),
and use it in btrfs_try_granting_tickets().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0fdf60f05228..f5ff51680f41 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -490,10 +490,29 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
 	return avail;
 }
 
+static inline bool check_can_overcommit(const struct btrfs_space_info *space_info,
+					u64 space_info_used_bytes, u64 bytes,
+					enum btrfs_reserve_flush_enum flush)
+{
+	const u64 avail = calc_available_free_space(space_info, flush);
+
+	return (space_info_used_bytes + bytes < space_info->total_bytes + avail);
+}
+
+static inline bool can_overcommit(const struct btrfs_space_info *space_info,
+				  u64 space_info_used_bytes, u64 bytes,
+				  enum btrfs_reserve_flush_enum flush)
+{
+	/* Don't overcommit when in mixed mode. */
+	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
+		return false;
+
+	return check_can_overcommit(space_info, space_info_used_bytes, bytes, flush);
+}
+
 bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
 			  enum btrfs_reserve_flush_enum flush)
 {
-	u64 avail;
 	u64 used;
 
 	/* Don't overcommit when in mixed mode */
@@ -501,9 +520,8 @@ bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
 		return false;
 
 	used = btrfs_space_info_used(space_info, true);
-	avail = calc_available_free_space(space_info, flush);
 
-	return (used + bytes < space_info->total_bytes + avail);
+	return check_can_overcommit(space_info, used, bytes, flush);
 }
 
 static void remove_ticket(struct btrfs_space_info *space_info,
@@ -539,7 +557,7 @@ void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 
 		/* Check and see if our ticket can be satisfied now. */
 		if (used_after <= space_info->total_bytes ||
-		    btrfs_can_overcommit(space_info, ticket->bytes, flush)) {
+		    can_overcommit(space_info, used, ticket->bytes, flush)) {
 			btrfs_space_info_update_bytes_may_use(space_info, ticket->bytes);
 			remove_ticket(space_info, ticket);
 			ticket->bytes = 0;
-- 
2.47.2


