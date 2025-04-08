Return-Path: <linux-btrfs+bounces-12885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C2A813BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5910D17DB25
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03323ED40;
	Tue,  8 Apr 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxj9CQUs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF823E35A
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133589; cv=none; b=k1EOKAn9XZItVppvFShdRg/DzsjXlkncBzZcTHb3lIsY1KaN23bqe/3Z5HVglBNfrD/j62/5meVOcyb9n/+o1zkJRWO/m2eie5jVORqYx6JxwX7qTJsedyLlKga96bkw7W1OJlm68fIi1Zeb/AEE7XZLUBh+WGuaRdJMw5HYdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133589; c=relaxed/simple;
	bh=1ldkuqZCJz/2sKFx5gGPLpRIkjOv+0L8k49F4cQHTfI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ervjDBWyYgSMGvnMRigIthfLKBz0iOWmKXpMWvOsiAmIbQHj/jghxya1qYkp81Rl2eTqdzRUoiffgqtd9QalbvNxV2Zj2myIZFrTV4/VblBFwFsLnRuCdmq4izrGbfYgY0WAaPeiXSSt5htofKzA6BhKNCnw6gEnSZIRUZj9E1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxj9CQUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0267BC4CEEA
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133588;
	bh=1ldkuqZCJz/2sKFx5gGPLpRIkjOv+0L8k49F4cQHTfI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vxj9CQUsB5O89SY3PMkzp0S21PX1svBYXMBXgSt3ZxT8qt3bslEODv7t5et10j9S5
	 qwtqlku7a9mkQThJBF2jlMEu4sC+2N106dGuoWK8RDsSTX9017q7lgc5ppY7KhQtXD
	 rm3RymJegJ1jQX/rjKjUe67s4i+bT78u3+XygFRduhm8PkH82E3kEdS9xAThCQ6snj
	 XvU/Oq2ump3bcJCnw8l7NDBjZ9PCDzVx2Jz4vrRV0tJXURuzmBQkM2JFBy4fUM4Slw
	 J/X7uGh2ZYBWk4vdjGwX8CftUq0GLUSyea0/FxB7aLvH7wyExZEkbeNd0viF0J+RoA
	 tiggts02zATWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: rename __tree_search() to remove double underscore prefix
Date: Tue,  8 Apr 2025 18:32:59 +0100
Message-Id: <8eacaddddc7f22b48e5cc4fe0c495d3292163f7d.1744130413.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744130413.git.fdmanana@suse.com>
References: <cover.1744130413.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to have a double underscore prefix as there's no variant
of the function without it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 974163ed0c27..02bfdb976e40 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -136,8 +136,8 @@ static int tree_insert(struct rb_root *root, struct extent_map *em)
  * Search through the tree for an extent_map with a given offset.  If it can't
  * be found, try to find some neighboring extents
  */
-static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
-				     struct rb_node **prev_or_next_ret)
+static struct rb_node *tree_search(struct rb_root *root, u64 offset,
+				   struct rb_node **prev_or_next_ret)
 {
 	struct rb_node *n = root->rb_node;
 	struct rb_node *prev = NULL;
@@ -516,7 +516,7 @@ static struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 	struct rb_node *prev_or_next = NULL;
 	u64 end = range_end(start, len);
 
-	rb_node = __tree_search(&tree->root, start, &prev_or_next);
+	rb_node = tree_search(&tree->root, start, &prev_or_next);
 	if (!rb_node) {
 		if (prev_or_next)
 			rb_node = prev_or_next;
-- 
2.45.2


