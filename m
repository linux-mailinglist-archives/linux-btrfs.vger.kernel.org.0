Return-Path: <linux-btrfs+bounces-584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84608803A10
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B429C1C20A4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF4F2E849;
	Mon,  4 Dec 2023 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx+IBHAG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B02E840
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81C7C433C8
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706847;
	bh=nPmWVoL/JrVVo9+eBbPStxPgI/z2CsKKNhamiyBPxl8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nx+IBHAGvu+UFAATUdk9UmAPY516uKc2jNUKdf5Zx0wf2+0cmrn+ZLO33UoVAIUq/
	 PFbntODLf2EY8mp/GTwsO394VRUza0HqZ97BnvP3MfCoL6dxysAKqq1Zll0HErmM2B
	 OgTe0q5dTxYRYK2at4lJuf2MrYhCvhSkFAx/bKkde2swK8f9Y8fMleaLG/LtHH+IJp
	 ozZNFB0oSecHmBkVdHV8K7esNmGW8qA2B/QcJe2/64U9AQBc6tKq+SMf7us88rQtUt
	 FYJAZ6vQqA0AZKZ9eqoJLEUsiGrxpUMSwJyxFT4tQhLmRcWgWcRGJjjV65Tr2/UCFB
	 5Zj9D8ZU1TeZw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: refactor mergable_maps() for more readability
Date: Mon,  4 Dec 2023 16:20:32 +0000
Message-Id: <1c16b24d11407f2a9eb9b4f64769b93cb87b2796.1701706418.git.fdmanana@suse.com>
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

At mergable_maps() Instead of having a single if statement with many
ORed and ANDed conditions, refacator it with mulple if statements that
check a single condition and return immediately once a requirement fails.
This makes it easier to read.

Also change the return type from int to bool, make the arguments const
and rename the function from mergable_maps() to mergeable_maps().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 72df548a4c86..650ab88ad7dc 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -211,19 +211,19 @@ static bool can_merge_extent_map(const struct extent_map *em)
 }
 
 /* Check to see if two extent_map structs are adjacent and safe to merge. */
-static int mergable_maps(struct extent_map *prev, struct extent_map *next)
+static bool mergeable_maps(const struct extent_map *prev, const struct extent_map *next)
 {
-	if (extent_map_end(prev) == next->start &&
-	    prev->flags == next->flags &&
-	    ((next->block_start == EXTENT_MAP_HOLE &&
-	      prev->block_start == EXTENT_MAP_HOLE) ||
-	     (next->block_start == EXTENT_MAP_INLINE &&
-	      prev->block_start == EXTENT_MAP_INLINE) ||
-	     (next->block_start < EXTENT_MAP_LAST_BYTE - 1 &&
-	      next->block_start == extent_map_block_end(prev)))) {
-		return 1;
-	}
-	return 0;
+	if (extent_map_end(prev) != next->start)
+		return false;
+
+	if (prev->flags != next->flags)
+		return false;
+
+	if (next->block_start < EXTENT_MAP_LAST_BYTE - 1)
+		return next->block_start == extent_map_block_end(prev);
+
+	/* HOLES and INLINE extents */
+	return next->block_start == prev->block_start;
 }
 
 static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
@@ -249,7 +249,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		rb = rb_prev(&em->rb_node);
 		if (rb)
 			merge = rb_entry(rb, struct extent_map, rb_node);
-		if (rb && can_merge_extent_map(merge) && mergable_maps(merge, em)) {
+		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
 			em->orig_start = merge->orig_start;
 			em->len += merge->len;
@@ -269,7 +269,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 	rb = rb_next(&em->rb_node);
 	if (rb)
 		merge = rb_entry(rb, struct extent_map, rb_node);
-	if (rb && can_merge_extent_map(merge) && mergable_maps(em, merge)) {
+	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
 		rb_erase_cached(&merge->rb_node, &tree->map);
-- 
2.40.1


