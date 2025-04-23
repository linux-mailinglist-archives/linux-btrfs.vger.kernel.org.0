Return-Path: <linux-btrfs+bounces-13306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8AA98CB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E87E7A3E31
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7E27FD57;
	Wed, 23 Apr 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxHRu4aT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055127CCDF
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418017; cv=none; b=aLJ7kue1DLvm/MtHFcwl2sm9Q6boeJ85wCBl4VpcSqpk/MQOfBowK0vC08hMSEWEJUdfw9XznTj5GalV61KNy9n6ia07+ySASeu7DkPoR8K9qrzx0b53VUXmKCV7KUtnjG0Un7W2cXi7JDxeSIsTFLIGl0OkQmg5Ba9ZoF8DmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418017; c=relaxed/simple;
	bh=V0TnMq59gaj5weEkhiJAaArnbqVdYpbLdjhtKncX/Is=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fq+SMyuEFksQwy2tP2eLgch/ofMxMJSWWkA2UqH5IybD4E2E7PbyQhKzz+vOtNDB4qsU+AuYjJOwLefMF1S1XKXdv0/26Thu9cPvshKjY/D8z/QpPIL/wOeZd9CRCb4G3h5qqpskeWlGkXNzNftltWIz+a/2LzxMZysjNzHVlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxHRu4aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A2C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418017;
	bh=V0TnMq59gaj5weEkhiJAaArnbqVdYpbLdjhtKncX/Is=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RxHRu4aT+rTOkkJ+mLaxKZiEJ9VkHAt0I7RTml1xZ1vU50/AhagQe2awNzqa3onr8
	 KP3YTV3UG6ZDAxu43GvkXtJnH96CNB4WXvQWc3xCjE4fKKLjXb+Wlmh9ljgbQd1vRz
	 KUPKKfUmxQZYZN8UPMeb0LitgKafKB9Uys2K/lr4TY+tdeh9QPI1K94qm305ZVQ9iN
	 bdDkkAdS7jGPziG4mXHVW2GdpnApQB8kKXDN2RjsnbcREsaJTV+lY319qf/utTCzvN
	 dowv1IUuMsHWpEKzRGjyqdflvRIVfHflee0wM0cdEHpzixinP31tqLnG+B8akXoc1h
	 nDDQlkqv0xt/Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/22] btrfs: avoid repeated extent state processing when converting extent bits
Date: Wed, 23 Apr 2025 15:19:51 +0100
Message-Id: <8f48ef1746e841359a8966b6911b0a27095456ac.1745401628.git.fdmanana@suse.com>
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

When converting bits for an extent range, if we find an extent state with
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
index bb829c5703f2..a898a15a7854 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1430,14 +1430,8 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
 		if (!prealloc) {
 			ret = -ENOMEM;
@@ -1449,7 +1443,11 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 * extent.
 		 */
 		prealloc->start = start;
-		prealloc->end = this_end;
+		if (end < last_start)
+			prealloc->end = end;
+		else
+			prealloc->end = last_start - 1;
+
 		inserted_state = insert_state(tree, prealloc, bits, NULL);
 		if (IS_ERR(inserted_state)) {
 			ret = PTR_ERR(inserted_state);
@@ -1459,7 +1457,7 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
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


