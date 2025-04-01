Return-Path: <linux-btrfs+bounces-12726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92387A77EF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D398E3AFDCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C320C00F;
	Tue,  1 Apr 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMmYa7CY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6120AF9C
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521402; cv=none; b=CXriR/4kOusgc/zQiu22nQywx3HtYS/l2+6zpdvpMi2rpoTyg/UcJVhVL9qVzjJu6rs1sHsXk4G8FD1PvdXtoMPb7jnQv0GcPjsPpVqtGZ5ckRU1kkuVucwemwiSvVHFpLs197XTQSd1zpz7qsEJ/Wqm2H09ROD/yHS68AQtOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521402; c=relaxed/simple;
	bh=MFnql+bSP4O26kxVBWK3934LoboUHc7LIgldAXvi49k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwrmQci88NmHpLe8rxSP63Alz3zp/Eu5uTY7ALmYmxhvFJB1HWhZ7jthXF1eRdjfENkNa8n1UQLRSIg3TWX5ZT5GP63FqqZIlWYgYrH2pLcYUsdWKBNLCIEEwQJz4/onKsu6x5bWllWqpPknBfBUhQDmWVrj9eqQRNF0Dn7lRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMmYa7CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C298C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521401;
	bh=MFnql+bSP4O26kxVBWK3934LoboUHc7LIgldAXvi49k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LMmYa7CYxjrbZJ7ZgDBIt49/TA+mI8xn3R5CkLuBTPMNeJEbDuxSJ6tg+ZGSBjyeD
	 5VK4sdPRRcmUaIsP3K/MrhMnA7USr3Q24ExeBVBxQrtEPOxOUi/PsMf+Xg8NGH0Voy
	 vXz51s8G0w1OzCrBAMg9B0flHBG54K7wb3kz7rmq+Vd1YDIS0O3Mb9aRtl9AXvek+n
	 smwxB1ZyRS3zwPRDJxDk/SZDTVjJdqZzY9T9pzjijYI0yeyGleaaBL7r5UUHbvkIF/
	 bz0JfliEessi7EpVq64RfRFO9uf29SZZ7KCBSbKNKMBKO5SbBxwsK/KWa/fNUN1smK
	 +MiioHmuuFJvg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: simplify last record detection at test_range_bit_exists()
Date: Tue,  1 Apr 2025 16:29:54 +0100
Message-Id: <9ee50767c1bbb59d408c2df7d6e0a4e1635289cf.1743521098.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743521098.git.fdmanana@suse.com>
References: <cover.1743521098.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of keeping track of the minimum start offset of the next record
and detecting overflow everytime we update that offset to be the sum of
current record's end offset plus one, we can simply exit when the current
record ends at or beyond our end offset and forget about updating the
start offset on every iteration and testing for it at the top of the loop.
This makes both the source code and assembly code simpler, more efficient
and shorter (reducing the object text size).

Also remove the pointless initializion to NULL of the state variable, as
we don't use it before the first assignment to it. This may help avoid
some warnings with clang tools such as the one reported/fixed by commit
966de47ff0c9 ("btrfs: remove redundant initialization of variables in
log_new_ancestors").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 7ae24a533404..293cb354259d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1726,14 +1726,14 @@ u64 count_range_bits(struct extent_io_tree *tree,
  */
 bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit)
 {
-	struct extent_state *state = NULL;
+	struct extent_state *state;
 	bool bitset = false;
 
 	ASSERT(is_power_of_2(bit));
 
 	spin_lock(&tree->lock);
 	state = tree_search(tree, start);
-	while (state && start <= end) {
+	while (state) {
 		if (state->start > end)
 			break;
 
@@ -1742,9 +1742,7 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
 			break;
 		}
 
-		/* If state->end is (u64)-1, start will overflow to 0 */
-		start = state->end + 1;
-		if (start > end || start == 0)
+		if (state->end >= end)
 			break;
 		state = next_state(state);
 	}
-- 
2.45.2


