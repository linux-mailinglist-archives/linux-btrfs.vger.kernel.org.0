Return-Path: <linux-btrfs+bounces-12853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B9A7E8BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6411344031E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95567253F20;
	Mon,  7 Apr 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM69bTAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB16253B68
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047402; cv=none; b=N7cwuHQYxcjUQv+GoOACAyX8rHoeN5VtWV/aCIM56hysJs4TzYUhHmUOunCVmouWT2s30YOYFf3XHLEqFbXUlKqtrytx1PMM9CUfguRkbJCyRL0FTcAqG2E+tD5joPGf3ANDBl09tStkVKF9MgQJ1ZppTzAQd1d1Pq3xXjF/8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047402; c=relaxed/simple;
	bh=3JMZoOBYMfVpoNs/535yGXOQ6juq9nZqVDTIEg5sls4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=atFDqWzy3m6n4nIc4YKF+xEsZZTrcV9ze/Weg3M86peXeA5OKg5xPgbZZJDOhxOrGw45thIz7AUHN3cslZySier3UWdOR8+TalFFiJIz4mhijRvhexJB4GSh6Y1HkX8U6WvlA0ej5ck4LFa2R22hPK/Fyc6L2wk2B+WMfiGI+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM69bTAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E4EC4CEED
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047402;
	bh=3JMZoOBYMfVpoNs/535yGXOQ6juq9nZqVDTIEg5sls4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DM69bTArmY4fxIpZPWBhVoiIdt2w6L71apGdjV3ereiq95/6db0yGWzHueo4c+um9
	 kcaBdNJypChWRDigOQS3MNHhMdkfle3CtClYS1rLF61n+859sM3Peq40oj9zLE3s52
	 ABzfU0L3dWf8qQf1rHvAsX/TNKuj4NFBJBou5MUJ8AcaNZD9vDXT+bwHygGFdae6GP
	 cfACTHgjKZD/GXnTEKiUm/PgXhjAGS71PYF+fbixGAyEDNTkct2w29tOFNo2LUOI9H
	 AEkrvaRdKdY0ybN7Ah/QLlZr/2DToouZkiHSXWg2lVcw2KT2jp80oLhUml+CMCB2mk
	 CFdTLxKMiZD0Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs: remove double underscore prefix from __set_extent_bit()
Date: Mon,  7 Apr 2025 18:36:22 +0100
Message-Id: <9f15dd5fd72a1dba4ac8f385ded72212887ae067.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Now that set_extent_bit() was renamed to btrfs_set_extent_bit(), there's
no need to have a __set_extent_bit() function, we can just remove the
double underscore prefix, which we try to avoid according to the coding
style conventions.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 503bb387e7a2..11f2e195ef8d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1022,11 +1022,11 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
  *
  * [start, end] is inclusive This takes the tree lock.
  */
-static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			    u32 bits, u64 *failed_start,
-			    struct extent_state **failed_state,
-			    struct extent_state **cached_state,
-			    struct extent_changeset *changeset)
+static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			  u32 bits, u64 *failed_start,
+			  struct extent_state **failed_state,
+			  struct extent_state **cached_state,
+			  struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -1258,8 +1258,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			 u32 bits, struct extent_state **cached_state)
 {
-	return __set_extent_bit(tree, start, end, bits, NULL, NULL,
-				cached_state, NULL);
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, cached_state, NULL);
 }
 
 /*
@@ -1815,7 +1814,7 @@ int btrfs_set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end
 	 */
 	ASSERT(!(bits & EXTENT_LOCK_BITS));
 
-	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL, changeset);
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, NULL, changeset);
 }
 
 int btrfs_clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1836,8 +1835,8 @@ bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	int err;
 	u64 failed_start;
 
-	err = __set_extent_bit(tree, start, end, bits, &failed_start,
-			       NULL, cached, NULL);
+	err = set_extent_bit(tree, start, end, bits, &failed_start, NULL,
+			     cached, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			btrfs_clear_extent_bit(tree, start, failed_start - 1,
@@ -1858,17 +1857,16 @@ int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32
 	int err;
 	u64 failed_start;
 
-	err = __set_extent_bit(tree, start, end, bits, &failed_start,
-			       &failed_state, cached_state, NULL);
+	err = set_extent_bit(tree, start, end, bits, &failed_start,
+			     &failed_state, cached_state, NULL);
 	while (err == -EEXIST) {
 		if (failed_start != start)
 			btrfs_clear_extent_bit(tree, start, failed_start - 1,
 					       bits, cached_state);
 
 		wait_extent_bit(tree, failed_start, end, bits, &failed_state);
-		err = __set_extent_bit(tree, start, end, bits,
-				       &failed_start, &failed_state,
-				       cached_state, NULL);
+		err = set_extent_bit(tree, start, end, bits, &failed_start,
+				     &failed_state, cached_state, NULL);
 	}
 	return err;
 }
-- 
2.45.2


