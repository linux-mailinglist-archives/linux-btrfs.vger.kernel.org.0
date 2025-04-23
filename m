Return-Path: <linux-btrfs+bounces-13313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F4A98CC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF053A2DE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5705280A5B;
	Wed, 23 Apr 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdWALQnV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0D280A53
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418024; cv=none; b=i/DngQvhV3/fsawlKteS+1E/67WV3xEnUu+PzsoHSqMZgw3DHN+lh92nN1bRAjedLVvPiL9Ifpijt+xq4n7ulEWwCik5gUl7+TMiglZeOSPVXBMsAqu1KDzj+H6E8O0TTbTBui08Og8EdrGX56J1BCTQ9jUz9g+RQ+tfE53455k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418024; c=relaxed/simple;
	bh=qDDw0kvCmOrvAvg3gDvxzZLtmbbiXmIKbNbAKeDjZx0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmEmsGxR3HaTl3obZXFzd7RpqflGt8iLjtBT7s3vvbGllgoHulp7nZR0316PgfxwcojQRSBYyOET2bblpoeLGg4y02MLWU9UEX7ul+MbY9v6IJoeaCsLMpcTdnbAPz3elldvodcLi/u/n0Ue68QQQ2RdEEUVk8oQglzro4o24bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdWALQnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A05CC4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418023;
	bh=qDDw0kvCmOrvAvg3gDvxzZLtmbbiXmIKbNbAKeDjZx0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RdWALQnVfeINq+qrqWSzhrgQ0haJ7aPY6+vi8iUPiUBjfAsijb2f4tGR8Wz+KBUT7
	 GY23HycsfVOu9iiWqYmTmnD5vKNTEzUW/aqK/pCo1bvie70KTCzRXOiOM5NuvzcEOP
	 gblaf/2F/ydDENW391mEQJ69EDizmpjEVmKANdIT7lnBrbErtVcHLBrwqOEMFdeAMZ
	 gI1SU1PtdYL5fy1N+qjy0cmG/FHraGaryTaZl6AnCXZnY8P4WS2Fa1qdFrDPs29fdJ
	 y2f6jlUj5aYlg8EREDj1pnEqZUYeQbKbeovH6hsN3wlBEHMjJnI7eIjM1L/Wn5nk3s
	 myNHXF0iHbg1w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/22] btrfs: avoid repeated extent state processing when setting extent bits
Date: Wed, 23 Apr 2025 15:19:57 +0100
Message-Id: <cf2a1c49a0b09867cad61d9f651913317a4126df.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When setting bits for an extent range, if we find an extent state with
its start offset greater than current start offset, we insert a new extent
state to cover the gap, with its end offset computed and stored in the
@this_end local variable, and after the insertion we update the current
start offset to @this_end + 1. However if the insert_state() call resulted
in an extent state merge then the end offset of the merged extent may be
greater than @this_end and if that's the case, since we jump to the
'search_again' label, we'll do a full tree search that will leave us in
the same extent state - this is harmless but wastes time by doing a
pointless tree search and extent state processing.

So improve on this by updating the current start offset to the end offset
of the inserted state plus 1. This also removes the use of the @this_end
variable and directly set the value in the prealloc extent state to avoid
any confusion and misuse in the future.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 1f3bc12430aa..ea974bde11dd 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1196,14 +1196,8 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	 * extent we found.
 	 */
 	if (state->start > start) {
-		u64 this_end;
 		struct extent_state *inserted_state;
 
-		if (end < last_start)
-			this_end = end;
-		else
-			this_end = last_start - 1;
-
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc)
 			goto search_again;
@@ -1213,7 +1207,11 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 * extent.
 		 */
 		prealloc->start = start;
-		prealloc->end = this_end;
+		if (end < last_start)
+			prealloc->end = end;
+		else
+			prealloc->end = last_start - 1;
+
 		inserted_state = insert_state(tree, prealloc, bits, changeset);
 		if (IS_ERR(inserted_state)) {
 			ret = PTR_ERR(inserted_state);
@@ -1224,7 +1222,7 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		cache_state(inserted_state, cached_state);
 		if (inserted_state == prealloc)
 			prealloc = NULL;
-		start = this_end + 1;
+		start = inserted_state->end + 1;
 		goto search_again;
 	}
 	/*
-- 
2.47.2


