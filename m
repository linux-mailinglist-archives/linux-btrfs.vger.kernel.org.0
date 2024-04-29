Return-Path: <linux-btrfs+bounces-4610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E18B59F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5513E1C217CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968E74C07;
	Mon, 29 Apr 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sT0FU5Ag"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52A745E5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397406; cv=none; b=T0zUhTKf7FrEaMw5gAlQ2wtV8feaYiad3lTdSNSBwUjSXdgtOGXGtdN2eUWCPHcvpLL8QN0oMSYZRphiX3CmW2pgmgt1EJSP3p/aJyV1y+fisNtmGfkEriWFBRHpUbBuzTqvHtUEa2QiyEtVZtYpCwD50zhbNt2WFE5FivzSDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397406; c=relaxed/simple;
	bh=LQ8r/jHHzE6+gmHFXFiUfQEBkGuWHJ1pVhZ7DHF6m0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJdzTPWMYm6kwYPQCozTMUvGXbJ5RZYFrPwB/eMfRkNKutxcqT7jpauAAHUQ9F6iTgwaE7QT8CuUiNE1aiOGrYQs2KqlJbCEgkrTkxdrudDtPy1kyM0J7FdPwmKqLD46YN8QhIzeJdGyndQE47JOwn3ocR6+8nj86PFiEtq9Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sT0FU5Ag; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79100a90868so22680285a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397404; x=1715002204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bs0EQg6KDmseCGr1wk4s34jwgnqkOtSw5juHC8avOSY=;
        b=sT0FU5Ag77A8j6BTMi6vhk1QfnRrY4cak7heZ7jaqb23+icpb6HZOsFSumIiVcmzUl
         13dnmA/qqAzUvnKIRlRHSgGjhHg5okAa55Sr+KXVf7PwX2egYPxbWDiIzSRWz9uRZSI9
         tTzlXjsF/OwK0BCKAyFb2iP1QHVZ9kVErj68XFLVv1qxqroPDcEGou0+HX2E8iLTVxJI
         YBnykfHcT0l6LJRV3FdNJmVO44Fy1QQX+4I3aaKpFiILQGmbvm6c7TUdJVFa6oxxf/6T
         2+iAb4mYZs34QFxm3+jX9Hs46gvrWrCL8RV7eQb4breDDgLwcGxLqmkcPuFja55Oo0sl
         OefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397404; x=1715002204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs0EQg6KDmseCGr1wk4s34jwgnqkOtSw5juHC8avOSY=;
        b=T54SI645UVYu5h2sDrYwmyRwjA7US5YHc8b+AJluQdCNezz0Jjb/e0LsqrRNIhEqMW
         sfv9Q1605H6RhzlrSkDm6oOzUh1DGn+u3s1GmA7VHvnjJ23r9JjdKHIs/JnMFRmEDZEv
         rNAJkOmjDpz/8UVSkoJvJuNW5Gl64wpVQpymCRUDcMq7Iryh8VmUj2O7j+xRX+vIfflu
         PrsJzeo03d7lY2zCIoMjTpqqhwIm8jiPVgAiCmwllJHrDL9NycSnlpsXe5JyEwvngirC
         CjHbxryzAi/oaJua9LQ1boS3w5EunwhYpX9LTJx52O05rNS7bp7H8hkeJV68o8MhYjWy
         b/9w==
X-Gm-Message-State: AOJu0YzMzekaA9CYMSRESf8E7zMwv6xNWKTFPQNV7UNN150XSG6enV6D
	0/G0BDHC6R6Qc/Upmk/dM8AkR1qBNbh2zvx0EpHfiyoj8e9YHcxu5InTJZ+Vc4t/G7Cq1F6nZtB
	a
X-Google-Smtp-Source: AGHT+IFswRAbtRCiEBHIRwlQv6O96/oYPpAIVDRxbZnEWXQhtGNXWqofpga7DEP7oGFEwTEZ8nte0Q==
X-Received: by 2002:a05:620a:1aa6:b0:790:bddd:dd6d with SMTP id bl38-20020a05620a1aa600b00790bddddd6dmr10799479qkb.14.1714397404009;
        Mon, 29 Apr 2024 06:30:04 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c13-20020ae9e20d000000b0078efd245e09sm10452888qkc.79.2024.04.29.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 07/15] btrfs: unify logic to decide if we need to walk down into a node
Date: Mon, 29 Apr 2024 09:29:42 -0400
Message-ID: <7ada6f456498532fd701ce4ff42e05b60269947f.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
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


