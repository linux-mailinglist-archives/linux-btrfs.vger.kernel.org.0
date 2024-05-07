Return-Path: <linux-btrfs+bounces-4809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D48BEB45
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6F11C22093
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621CC16D9B5;
	Tue,  7 May 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dcmz7Mj3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65B16D4E6
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105554; cv=none; b=UTsWaE7daYBTUCpCnSieiM3UdtIbvP5041vdo0CODLCeE4icTV3Ryud3wUP/PELdUq4RrN41DLA4G39U4sknw5gYeGTf3EmQna95UA920uQJhjvDAhAOzwAi+nOJ/fXmAgHasFsF2toOxgK9R3KN5tx/V2+l5vwQQswL5JiC4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105554; c=relaxed/simple;
	bh=LQ8r/jHHzE6+gmHFXFiUfQEBkGuWHJ1pVhZ7DHF6m0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEn7PHYb+YKhOxfDqfGMIOg5ADL8j+S8JpjyoOcCHcS5i9vsr48UxmfeG4nfw5WCV0z8GzLjezHZrB4dLvur8HIF3wU7wasnePOjxFnc/c+Qx+kYeCe8TDTJEXlLlnPZOLCq9YxBSvdwqTKkyt1U4qL1A5H5G3JcPGZb2nWHS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dcmz7Mj3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61df496df01so26841847b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105552; x=1715710352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bs0EQg6KDmseCGr1wk4s34jwgnqkOtSw5juHC8avOSY=;
        b=dcmz7Mj3wBAtSxMTmarqwOkvvNld3TM74KGuSkI85MRNHLfqUpP95Hs8eNyvKYAElg
         zsMSfPxTqA0ISk/QqVb6NRra30nh3Dp+MBIN+aBSQmyrswGvGur+Sn5iBhjUWGpWmfzm
         fQefcpNZSZeWS//ilDd6SLsMpcF9Ita7Lf+SnYj4aPKpeUieND7qNh9IX+L3hAayppdQ
         LF+jVS7LcEvlfCtN+g+V1+eEs1jMux6IZeW5P3zrG1AXc/RG5xJH5Shb/gXHwQtbHTql
         OrSHj9n/uq9GgQHhLRAkFrDdZyat6zVT8I2ZxqS/xMo9ZVzWLKL94X21oQ6pb3rCcOEB
         8UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105552; x=1715710352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs0EQg6KDmseCGr1wk4s34jwgnqkOtSw5juHC8avOSY=;
        b=c0DwY+UXvCwRZLC0lCNDV+hza9+aDNGrxhpRtoDSN8QiKHxB51ksjGLChfvg5XfEBd
         MPZvvBJcGG+wWompJZS20MRwzhp/eZmx9yHRo7UKS8WqHVnVIbRUOo7y6MRNPuqP9X2v
         edCOghaO+S8+Sh1EJKD6/6J2YvDsoEfX/xENWboJvOvh0jJfxNM4/4i+V3nT7b7aZQ/j
         FfadBHAKET8Q9aTrfOTD59X7deDckh3XAaUxOgHFC3YSCJi62yDIQf3iklFr4Qo16G4+
         aU78lu4sb0ou08difA9q0geeJA4RLIecXzHk+vAmXgpsqOtZrP57xJN2PBtFtG/WdOEh
         6CMw==
X-Gm-Message-State: AOJu0YzZidncuWQsnTlUBZsn6YOoeha+/E2jmedOEo3xaNZI+uCFBN/P
	EIdPe/txuMBzL4f+Q3a7It612s4/pGShOND2i1W0+yqUCeHSYHEIES2FxyJV7Aj5QSe6ddhbOH0
	U
X-Google-Smtp-Source: AGHT+IGa/fUawzR90FoUsZai9MoPZUkHGhi6kPVRetVzZ1aahRq/yvTihA8wOuQA8Am4YDObkHeUnQ==
X-Received: by 2002:a0d:ce05:0:b0:61a:d372:8767 with SMTP id 00721157ae682-62085edeeb4mr4829117b3.51.1715105551869;
        Tue, 07 May 2024 11:12:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y83-20020a81a156000000b0061be65cc0dbsm2839965ywg.120.2024.05.07.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 07/15] btrfs: unify logic to decide if we need to walk down into a node
Date: Tue,  7 May 2024 14:12:08 -0400
Message-ID: <c4695d12ef488d2da8d73ed4d584d024dd6eb72f.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently duplicate the logic for walking into a node during snapshot
delete.  In one case it is during the actual delete, and in the other we
use it for deciding if we should reada the block or not.

Extract this code into it's own helper and comment fully what we're
doing, and then update the two users to use the new helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 135 +++++++++++++++++++++++++++--------------
 1 file changed, 91 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ae11a2bd417e..4c6647760aa5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5226,6 +5226,81 @@ struct walk_control {
 #define DROP_REFERENCE	1
 #define UPDATE_BACKREF	2
 
+/*
+ * Decide if we need to walk down into this node to adjust the references.
+ *
+ * @root	- the root we are currently deleting.
+ * @wc		- the walk control for this deletion.
+ * @eb		- the parent eb that we're currently visiting.
+ * @refs	- the number of refs for wc->level - 1.
+ * @flags	- the flags for wc->level - 1.
+ * @slot	- the slot in the eb that we're currently checking.
+ *
+ * This is meant to be called when we're evaluating if a node we point to at
+ * wc->level should be read and walked into, or if we can simply delete our
+ * reference to it.  We return true if we should walk into the node, false if we
+ * can skip it.
+ *
+ * We have assertions in here to make sure this is called correctly.  We assume
+ * that sanity checking on the blocks read to this point has been done, so any
+ * corrupted file systems must have been caught before calling this function.
+ */
+static bool visit_node_for_delete(struct btrfs_root *root,
+				  struct walk_control *wc,
+				  struct extent_buffer *eb,
+				  u64 refs, u64 flags, int slot)
+{
+	struct btrfs_key key;
+	u64 generation;
+	int level = wc->level;
+
+	ASSERT(level > 0);
+	ASSERT(wc->refs[level - 1] > 0);
+
+	/*
+	 * The update backref stage we only want to skip if we already have
+	 * FULL_BACKREF set, otherwise we need to read.
+	 */
+	if (wc->stage == UPDATE_BACKREF) {
+		if (level == 1 && flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)
+			return false;
+		return true;
+	}
+
+	/*
+	 * We're the last ref on this block, we must walk into it and process
+	 * any refs it's pointing at.
+	 */
+	if (wc->refs[level - 1] == 1)
+		return true;
+
+	/*
+	 * If we're already FULL_BACKREF then we know we can just drop our
+	 * current reference.
+	 */
+	if (level == 1 && flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)
+		return false;
+
+	/*
+	 * This block is older than our creation generation, we can drop our
+	 * reference to it.
+	 */
+	generation = btrfs_node_ptr_generation(eb, slot);
+	if (!wc->update_ref || generation <= root->root_key.offset)
+		return false;
+
+	/*
+	 * This block was processed from a previous snapshot deletion run, we
+	 * can skip it.
+	 */
+	btrfs_node_key_to_cpu(eb, &key, slot);
+	if (btrfs_comp_cpu_keys(&key, &wc->update_progress) < 0)
+		return false;
+
+	/* All other cases we need to wander into the node. */
+	return true;
+}
+
 static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
 				     struct walk_control *wc,
@@ -5237,7 +5312,6 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 	u64 refs;
 	u64 flags;
 	u32 nritems;
-	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int ret;
 	int slot;
@@ -5279,26 +5353,9 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 			continue;
 		BUG_ON(refs == 0);
 
-		if (wc->stage == DROP_REFERENCE) {
-			if (refs == 1)
-				goto reada;
-
-			if (wc->level == 1 &&
-			    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-				continue;
-			if (!wc->update_ref ||
-			    generation <= root->root_key.offset)
-				continue;
-			btrfs_node_key_to_cpu(eb, &key, slot);
-			ret = btrfs_comp_cpu_keys(&key,
-						  &wc->update_progress);
-			if (ret < 0)
-				continue;
-		} else {
-			if (wc->level == 1 &&
-			    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-				continue;
-		}
+		/* If we don't need to visit this node don't reada. */
+		if (!visit_node_for_delete(root, wc, eb, refs, flags, slot))
+			continue;
 reada:
 		btrfs_readahead_node_child(eb, slot);
 		nread++;
@@ -5475,7 +5532,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 bytenr;
 	u64 generation;
 	u64 owner_root = 0;
-	struct btrfs_key key;
 	struct extent_buffer *next;
 	int level = wc->level;
 	int ret = 0;
@@ -5516,29 +5572,20 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 	wc->lookup_info = 0;
 
-	if (wc->stage == DROP_REFERENCE) {
-		if (wc->refs[level - 1] > 1) {
-			if (level == 1 &&
-			    (wc->flags[0] & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-				goto skip;
+	/* If we don't have to walk into this node skip it. */
+	if (!visit_node_for_delete(root, wc, path->nodes[level],
+				   wc->refs[level - 1], wc->flags[level - 1],
+				   path->slots[level]))
+		goto skip;
 
-			if (!wc->update_ref ||
-			    generation <= root->root_key.offset)
-				goto skip;
-
-			btrfs_node_key_to_cpu(path->nodes[level], &key,
-					      path->slots[level]);
-			ret = btrfs_comp_cpu_keys(&key, &wc->update_progress);
-			if (ret < 0)
-				goto skip;
-
-			wc->stage = UPDATE_BACKREF;
-			wc->shared_level = level - 1;
-		}
-	} else {
-		if (level == 1 &&
-		    (wc->flags[0] & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-			goto skip;
+	/*
+	 * We have to walk down into this node, and if we're currently at the
+	 * DROP_REFERNCE stage and this block is shared then we need to switch
+	 * to the UPDATE_BACKREF stage in order to convert to FULL_BACKREF.
+	 */
+	if (wc->stage == DROP_REFERENCE && wc->refs[level - 1] > 1) {
+		wc->stage = UPDATE_BACKREF;
+		wc->shared_level = level - 1;
 	}
 
 	ret = check_next_block_uptodate(trans, root, path, wc, next);
-- 
2.43.0


