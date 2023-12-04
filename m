Return-Path: <linux-btrfs+bounces-582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C85C803A0D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07707281001
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D912E83A;
	Mon,  4 Dec 2023 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQR2hPV1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8032E82D
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBFFC433C9
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706845;
	bh=gVs97QCz2ZEWE2BUYbV2r65yjU6WK1u4/FrS7dodIjQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vQR2hPV1rhLDJ4HVCgfTmK9AWaflAvpbKnjkEZalEH0lP+KGwtWJ+y+nRBXTWtUiM
	 4Q55BK9qII8QIuDwjn+kyWjPpsx5U3pjHFfSoh2MdyK34zSjrW6vIq6S17HFhl8ypO
	 gwEINkxtAJAEPCNBEPwsKSc+QTSytUoFsbYH3FDuhm4bpO/6cwnmFyiNHQyOhL2CBr
	 GMoPLuPn6EQifoeKJj4Y/R090BXP+37wvITYfHMSRWDjLKZKoFswUKeAlTUPekRx2m
	 5EBMtb0thOrS/5DacFEGtRQuPvkJq9dJr8dMNyYNDTHw9wbhRCNP89taekvK+3bIXG
	 1qk3Y0xLjEQIw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: avoid useless rbtree iterations when attempting to merge extent map
Date: Mon,  4 Dec 2023 16:20:30 +0000
Message-Id: <2f2e0ad04c0e2a5a8d7a4118650556104934a4e8.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When trying to merge an extent map that was just inserted or unpinned, we
will try to merge it with any adjacent extent map that is suitable.

However we will only check if our extent map is mergeable after searching
for the previous and next extent maps in the rbtree, meaning that we are
doing unnecessary calls to rb_prev() and rb_next() in case our extent map
is not mergeable (it's compressed, in the list of modifed extents, being
logged or pinned), wasting CPU time chasing rbtree pointers and pulling
in unnecessary cache lines.

So change the logic to check first if an extent map is mergeable before
searching for the next and previous extent maps in the rbtree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 48230a1179b0..72df548a4c86 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -187,31 +187,32 @@ static inline u64 extent_map_block_end(const struct extent_map *em)
 	return em->block_start + em->block_len;
 }
 
-/* Check to see if two extent_map structs are adjacent and safe to merge. */
-static int mergable_maps(struct extent_map *prev, struct extent_map *next)
+static bool can_merge_extent_map(const struct extent_map *em)
 {
-	if (test_bit(EXTENT_FLAG_PINNED, &prev->flags))
-		return 0;
+	if (test_bit(EXTENT_FLAG_PINNED, &em->flags))
+		return false;
 
-	/*
-	 * don't merge compressed extents, we need to know their
-	 * actual size
-	 */
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &prev->flags))
-		return 0;
+	/* Don't merge compressed extents, we need to know their actual size. */
+	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
+		return false;
 
-	if (test_bit(EXTENT_FLAG_LOGGING, &prev->flags) ||
-	    test_bit(EXTENT_FLAG_LOGGING, &next->flags))
-		return 0;
+	if (test_bit(EXTENT_FLAG_LOGGING, &em->flags))
+		return false;
 
 	/*
 	 * We don't want to merge stuff that hasn't been written to the log yet
 	 * since it may not reflect exactly what is on disk, and that would be
 	 * bad.
 	 */
-	if (!list_empty(&prev->list) || !list_empty(&next->list))
-		return 0;
+	if (!list_empty(&em->list))
+		return false;
+
+	return true;
+}
 
+/* Check to see if two extent_map structs are adjacent and safe to merge. */
+static int mergable_maps(struct extent_map *prev, struct extent_map *next)
+{
 	if (extent_map_end(prev) == next->start &&
 	    prev->flags == next->flags &&
 	    ((next->block_start == EXTENT_MAP_HOLE &&
@@ -241,11 +242,14 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 	if (refcount_read(&em->refs) > 2)
 		return;
 
+	if (!can_merge_extent_map(em))
+		return;
+
 	if (em->start != 0) {
 		rb = rb_prev(&em->rb_node);
 		if (rb)
 			merge = rb_entry(rb, struct extent_map, rb_node);
-		if (rb && mergable_maps(merge, em)) {
+		if (rb && can_merge_extent_map(merge) && mergable_maps(merge, em)) {
 			em->start = merge->start;
 			em->orig_start = merge->orig_start;
 			em->len += merge->len;
@@ -265,7 +269,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 	rb = rb_next(&em->rb_node);
 	if (rb)
 		merge = rb_entry(rb, struct extent_map, rb_node);
-	if (rb && mergable_maps(em, merge)) {
+	if (rb && can_merge_extent_map(merge) && mergable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
 		rb_erase_cached(&merge->rb_node, &tree->map);
-- 
2.40.1


