Return-Path: <linux-btrfs+bounces-4445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD08AB4F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2168B1F222D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9529F13C9C4;
	Fri, 19 Apr 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Qm4vhDrr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0B13BAFC
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550645; cv=none; b=gOtS7PDEJI4L9f/KVycMPnYP+1yhLSrcgyBbt5qxO/S1lFG/SFXSLKgiMKACkEG/+rfdWMDXHjtBUVTo/gc6DfOSYZslk7XiOrT7/bpszpgVr8QHTc0VA50QypZkZglWuOj0kV7ODa2WvEZkQsC3lGi2rMRiFu9kUHl7RucxRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550645; c=relaxed/simple;
	bh=om3tnd99vdxF8SGn42D4/BQpacDCWEnsxy0DZIXXwNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMoKFSDjil56wABvlabA20JShLbvczRqDnDCnpNrGNxs0xpjeOLrS21PRHueNfnhCtLKrYBeAFrogd5Jokmby8Q1bYWTHVVhuPDHyN2SAs7YNRn++CXxqKNNnLcwpgmLOn188QYtdFZCyYbqff9Sjy7A0yvU94m8dDK3KdscrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Qm4vhDrr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f056f928eso145950285a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550643; x=1714155443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YESm67M8BmJKsD3F1nymsp03dFHrE/Pl/wfnxNOqlTA=;
        b=Qm4vhDrrePwZSHkvtqd/WdyI/0cx8cstbmH8qI8ANGnrnr5qKcPu47WEUvprRcvDA8
         VBQu3NIu0/di0h9Pu+BR0gE4ucB9Qlxm+h1VDRsUACUwKdiWQQXoybVOIW4XVFiOQCLG
         D5/gH23X6OdwhW9IAUNGhQ9nnrisPibfJhhh3+c149Y9EBavDa9LyrtrHvDokgX/Gtxg
         kL9qboWKQ1vdzt+E0+8FjHCqsBUSYo5L2ma6xAaGWS61bFQa3bWKSiN8Q8zwKxuYzfPQ
         Ps9U6vKYvKbdFGAOvn+4zvb5DRD7bTzZ+o5JkSLBhb0TvFh4/lghCiMlkrM13LLqGsoL
         J/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550643; x=1714155443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YESm67M8BmJKsD3F1nymsp03dFHrE/Pl/wfnxNOqlTA=;
        b=rgRKK+Rm5SZLWtFdvfDwh0VAX4/ocFXcZp1z4e8ulNFUnAZoRsTOLV334vbi3vfwgl
         TemwCCARxFz3VCSvQ/y+0AfO8i2QvDaXsm3sz7QYtJgX2RBsbLH+77e4TyDlvwrPDl2+
         o6QHjCcdOK3EYrTj8K/VQrs27YINpX4WfU9q00Qxi+pkBLWM9jAoATQaIILpvHVbvAOk
         DYOS0bsTxhl8RXBmI4fhJImolLHdvokmqVKYws1RxoeStGyx9X3P2hXgKqS/zkGJcWMr
         h1eduSLtOydEUOtQC/xSWNoA0ffZlJxJdlp5ZrX9EZTrRaedDwSV+8HjAC7OLcX1M9M/
         tHbg==
X-Gm-Message-State: AOJu0YxFlBGT+P/GeaVI0D7KzehGclGwrGIRd5mb+i74T4Jd2wcJHeAo
	Gbw5mWtWinnqbWtDyuZdfDOimXl1Ue4ZKSE6lLHDIldtkfBURU2WKlM0wKuhGrrO/Pui2N2lWz1
	k
X-Google-Smtp-Source: AGHT+IFOZISiYk1mlHIbCJKCDbaSIHkbCo79HuXXOJBE8dBXFG0vftlHCn0rcdwqLj/mGDYg2mD9JQ==
X-Received: by 2002:a05:620a:ecf:b0:78d:5b09:2a3 with SMTP id x15-20020a05620a0ecf00b0078d5b0902a3mr2936289qkm.46.1713550643046;
        Fri, 19 Apr 2024 11:17:23 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id de19-20020a05620a371300b0078ec3f23519sm1809510qkb.8.2024.04.19.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 07/15] btrfs: unify logic to decide if we need to walk down into a node
Date: Fri, 19 Apr 2024 14:17:02 -0400
Message-ID: <a408dfef6629f098b3b2641cd92d9f6a31e56a6b.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
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
index afe0694c675b..0f3c1ce27d17 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5227,6 +5227,81 @@ struct walk_control {
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
@@ -5238,7 +5313,6 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 	u64 refs;
 	u64 flags;
 	u32 nritems;
-	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int ret;
 	int slot;
@@ -5280,26 +5354,9 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
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
@@ -5476,7 +5533,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 bytenr;
 	u64 generation;
 	u64 owner_root = 0;
-	struct btrfs_key key;
 	struct extent_buffer *next;
 	int level = wc->level;
 	int ret = 0;
@@ -5517,29 +5573,20 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
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


