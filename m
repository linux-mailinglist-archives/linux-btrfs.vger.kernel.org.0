Return-Path: <linux-btrfs+bounces-12754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75835A79185
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63070170D6E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C76623C8CA;
	Wed,  2 Apr 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFgNBzoC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB823C8AD
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605658; cv=none; b=KWybp6+BiKfP/KGh+cikLH7v1b/x3HpKT+Fop1o3lk7vhuJeGLZVf+/FKYEn28vh6BT6OyiqE4mZtyAb1S57chTbRgnemFvGDy44VHcg/ATO90MIXlQD0YZK34jJLCDbcSBASA+XueaSvltcSA16MWPstE965Y51ZeY8N9wvjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605658; c=relaxed/simple;
	bh=D2uFBeAwqiEl/ocwtBlcwQeYyKQALWHpO51KWBko2mg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrfecaWaq616lg1pS0yqEvnkpTui8hSeeQ9iZ4Z7+uE7ksx1gYxhjVkjdItqcUPCI9/EpYg3Lhh5OO7bSht+mH/7c4oAfFQGDeSwMcFdRzAGy0kyOZHav/acIm1WdUe4Xb8Kx5b6jhMNVSUd4aOYdbSAAnQ/YDiHFd97QrE6GB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFgNBzoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4787C4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743605657;
	bh=D2uFBeAwqiEl/ocwtBlcwQeYyKQALWHpO51KWBko2mg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HFgNBzoCrfPN6Ney3GuplMzeZNcfG+SqwJux/AKhN1yNDe+T60pzeMmdW86js2RhS
	 2BTxxuFLQ+NGH748E9bGElS7qHNa5TYIgh03CRyhJy246mq+9R2wh2muhgrnVSBH7U
	 EHiuoF1nynf55/SACjz7ENef1DTp3qU3ZxzaWVlUCv0jENoTAKGnFvog6a+UM4oN9K
	 krC2Fc0zxDRK9pLcFw8YPwNXRTLJVU2Y0wt6SvzVPUu3O7MCjUBpZvKATSCNzEZMfJ
	 0pa+dznUUqmRc7IONlWCYI0g29bxaVB3JiQ9L7cn5ukeaFZmN5GAj7RnXbZzDlwFlw
	 53TZ2JsV9IXwA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix documentation for tree_search_for_insert()
Date: Wed,  2 Apr 2025 15:54:09 +0100
Message-Id: <37c8d8c041a01c8aa59673ffbd26bb0829f89ac8.1743604119.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743604119.git.fdmanana@suse.com>
References: <cover.1743604119.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are several things wrong with the documentation:

1) At the top it's only mentioned that we search for an entry containing
   the given offset, but when such entry does not exists we search for
   the first entry that starts and ends after that offset;

2) It mentions that @node_ret and @parent_ret aren't changed if the
   returned entry contains the given offset - that is true only if the
   returned entry starts exactly at @offset, otherwise those arguments
   are changed;

3) It mentions that if no entry containing offset is found then we return
   the first entry ending before the offset - that is not true, we return
   the first entry that starts and ends after that offset;

4) It also mentions that NULL is never returned. This is false as in case
   there's no entry containing offset or any entry that starts and ends
   after offset, NULL is returned.

So fix the documentation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 3c138e6c2397..355c24449776 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -233,21 +233,23 @@ static inline struct extent_state *prev_state(struct extent_state *state)
 }
 
 /*
- * Search @tree for an entry that contains @offset. Such entry would have
- * entry->start <= offset && entry->end >= offset.
+ * Search @tree for an entry that contains @offset or if none exists for the
+ * first entry that starts and ends after that offset.
  *
  * @tree:       the tree to search
- * @offset:     offset that should fall within an entry in @tree
+ * @offset:     search offset
  * @node_ret:   pointer where new node should be anchored (used when inserting an
  *	        entry in the tree)
  * @parent_ret: points to entry which would have been the parent of the entry,
  *               containing @offset
  *
- * Return a pointer to the entry that contains @offset byte address and don't change
- * @node_ret and @parent_ret.
+ * Return a pointer to the entry that contains @offset byte address.
  *
- * If no such entry exists, return pointer to entry that ends before @offset
- * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
+ * If no such entry exists, return the first entry that starts and ends after
+ * @offset if one exists, otherwise NULL.
+ *
+ * If the returned entry starts at @offset, then @node_ret and @parent_ret
+ * aren't changed.
  */
 static inline struct extent_state *tree_search_for_insert(struct extent_io_tree *tree,
 							  u64 offset,
@@ -276,7 +278,11 @@ static inline struct extent_state *tree_search_for_insert(struct extent_io_tree
 	if (parent_ret)
 		*parent_ret = prev;
 
-	/* Search neighbors until we find the first one past the end */
+	/*
+	 * Return either the current entry if it contains offset (it ends after
+	 * or at offset) or the first entry that starts and ends after offset if
+	 * one exists, or NULL.
+	 */
 	while (entry && offset > entry->end)
 		entry = next_state(entry);
 
-- 
2.45.2


