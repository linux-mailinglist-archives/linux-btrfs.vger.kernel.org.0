Return-Path: <linux-btrfs+bounces-9602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED089C78EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD882820A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB60167D80;
	Wed, 13 Nov 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BUQgzFWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DD14AD17
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515520; cv=none; b=h6QXYtpU9G+EvLS2yXFP0Hp4dNmBpmdmyCf6xlZenrxhX5vYD+dFZVRnQ2ZV3GSl3RyWDLiGQQs58rKzn6iVNcwpmLeTOjr+e0fT3b+Q6z1LJQFW1EGG98m57x8JA9Ym1uqERT/02PKybvfg3XyvN3aq1FxJ2zb/miXs3c4clJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515520; c=relaxed/simple;
	bh=TBfAXrFOP7GpgkJ0pxG+hE8cQojSgWNLU3gHLzFxPDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q4tV7sT8gjlrJ8dRhjAMCmOQW/5zSonkO9hT1OM00WaZfw2A/6IegGlN0lsaOqSDlyF98CJyfGBGsvdP5g8hHyc1jFjaJFfCzbb/LjextWkkfF/OG9agXKxfFDNafP1UZaSqaNXM62/RQHShh5MtsQBdP3OE9C1kqueHrVfmhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BUQgzFWC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so48615286d6.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731515517; x=1732120317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPYT4l0rdQS2mPWeocj4qYH5REg37GUqkcwRITGTGuU=;
        b=BUQgzFWCmbKYYAEOpI9fpcLoFMyQq5wmsgnOeSiHaez3N75Co7Nqshbsqur0EP1qbb
         2pkEdPKgDIMZH9fFJVZ1+MG5CxbbI8Ji2xuE0SNpLvlandI60zJXKrPUi/D5ZxkjsFPo
         ozanoN3fYK47m26zJq6FYlJdE7MXhSgtPim9fNwLBsVKTi8TRkkSKUtoWv/4CGJn5JmR
         bvbPuB0OVm1T9TjeKpNX8iARR22CiXCHy2KT0nYjxx/IX80W3iOX4VioI3aW9eSRUqBR
         ZZdD4fVo52B1KwUVpNgkDbgn/KZ0nMli0Ht4nd31489U3VV5oBbtBNwMqBOnTexqkaDr
         jFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515517; x=1732120317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPYT4l0rdQS2mPWeocj4qYH5REg37GUqkcwRITGTGuU=;
        b=dPwziXFWYRPgQHwht3CkuRjMyyFu0EItRid53MVZDmG2KCeCi64d77loSGy50YMV2N
         GPuwv2gWfK9nq/HbGjw+Z1UkPbByt0bOXCPbFu3/K/mF7gkYRzEu1ooGFk64IvUB1svs
         9wz3c565Q00ek453cXm1B5CDx/Q58ZrvOq80WlJ90nOmLQL1VXxll8mRJa2mn2m4LMgd
         2v/OmdsYDGsU7VNUYt4vqGGg2shas2jtg4aphSHy6u0kriCJT8xU1Hq/8nZPm44Wlx96
         B3r3FnOkmAMwiFiXUL1ysb2k/CeHCzMziiygsOaG2URhjOJmMrkPJXjHakMZgyEUHVWW
         PSAw==
X-Gm-Message-State: AOJu0YyPu384et+yn6Woo4vkpbxPjRjMfaE0/Vzg/hGZQ/5hO7JZzCpU
	Mlx/lLv85XWlr2ZQU53W/rroJuY4YeE9HOt2paKWTiwMuEzFkAXYBb7YiXRcDtZ27U0TTD0TASi
	E
X-Google-Smtp-Source: AGHT+IEsSOkdj8rXDCZZae1uKIOatGjW9PCqvshdFNVlojMXAX3EnOpYDdDaXjvnaKRriaHuJYwLPg==
X-Received: by 2002:a05:6214:5885:b0:6ce:3ab7:adf3 with SMTP id 6a1803df08f44-6d39e1a98d7mr263942566d6.41.1731515517296;
        Wed, 13 Nov 2024 08:31:57 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961f4d2csm85558526d6.50.2024.11.13.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:31:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix improper generation check in snapshot delete
Date: Wed, 13 Nov 2024 11:31:52 -0500
Message-ID: <b1b8f27cad83060a4157af8f7514681a85956549.1731515508.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have been using the following check

if (generation <= root->root_key.offset)

to make decisions about whether or not to visit a node during snapshot
delete.  This is because for normal subvolumes this is set to 0, and for
snapshots it's set to the creation generation.  The idea being that if
the generation of the node is less than or equal to our creation
generation then we don't need to visit that node, because it doesn't
belong to us, we can simply drop our reference and move on.

However reloc roots don't have their generation stored in
root->root_key.offset, instead that is the objectid of their
corresponding fs root.  This means we can incorrectly not walk into
nodes that need to be dropped when deleting a reloc root.

There are a variety of consequences to making the wrong choice in two
distinct areas.

visit_node_for_delete()

1. False positive.  We think we are newer than the block when we really
   aren't.  We don't visit the node and drop our reference to the node
   and carry on.  This would result in leaked space.
2. False negative.  We do decide to walk down into a block that we
   should have just dropped our reference to.  However this means that
   the child node will have refs > 1, so we will switch to
   UPDATE_BACKREF, and then the subsequent walk_down_proc will notice
   that btrfs_header_owner(node) != root->root_key.objectid and it'll
   break out of the loop, and then walk_up_proc will drop our reference,
   so this appears to be ok.

do_walk_down()

1. False positive.  We are in UPDATE_BACKREF and incorrectly decide that
   we are done and don't need to update the backref for our lower nodes.
   This is another case that simply won't happen with relocation, as we
   only have to do UPDATE_BACKREF if the node below us was shared and
   didn't have FULL_BACKREF set, and since we don't own that node
   because we're a reloc root we actually won't end up in this case.
2. False negative.  Again this is tricky because as described above, we
   simply wouldn't be here from relocation, because we don't own any of
   the nodes because we never set btrfs_header_owner() to the reloc root
   objectid, and we always use FULL_BACKREF, we never actually need to
   set FULL_BACKREF on any children.

Having spent a lot of time stressing relocation/snapshot delete recently
I've not seen this pop in practice.  But this is objectively incorrect,
so fix this to get the correct starting generation based on the root
we're dropping to keep me from thinking there's a problem here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c |  6 +++---
 fs/btrfs/root-tree.c   | 20 ++++++++++++++++++++
 fs/btrfs/root-tree.h   |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 412e318e4a22..43a771f7bd7a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5285,7 +5285,7 @@ static bool visit_node_for_delete(struct btrfs_root *root, struct walk_control *
 	 * reference to it.
 	 */
 	generation = btrfs_node_ptr_generation(eb, slot);
-	if (!wc->update_ref || generation <= root->root_key.offset)
+	if (!wc->update_ref || generation <= btrfs_root_origin_generation(root))
 		return false;
 
 	/*
@@ -5340,7 +5340,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 			goto reada;
 
 		if (wc->stage == UPDATE_BACKREF &&
-		    generation <= root->root_key.offset)
+		    generation <= btrfs_root_origin_generation(root))
 			continue;
 
 		/* We don't lock the tree block, it's OK to be racy here */
@@ -5683,7 +5683,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	 * for the subtree
 	 */
 	if (wc->stage == UPDATE_BACKREF &&
-	    generation <= root->root_key.offset) {
+	    generation <= btrfs_root_origin_generation(root)) {
 		wc->lookup_info = 1;
 		return 1;
 	}
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 33962671a96c..017a155ffd5e 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -547,3 +547,23 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	}
 	return ret;
 }
+
+/*
+ * btrfs_root_start_generation - return the generation this root started with.
+ * @root - the root we're chcking
+ *
+ * Every normal root that is created with root->root_key.offset set to it's
+ * originating generation.  If it is a snapshot it is the generation when the
+ * snapshot was created.
+ *
+ * However for TREE_RELOC roots root_key.offset is the objectid of the owning
+ * tree root.  Thankfully we copy the root item of the owning tree root, which
+ * has it's last_snapshot set to what we would have root_key.offset set to, so
+ * return that if we are a TREE_RELOC root.
+ */
+u64 btrfs_root_origin_generation(struct btrfs_root *root)
+{
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
+		return btrfs_root_last_snapshot(&root->root_item);
+	return root->root_key.offset;
+}
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index 8f5739e732b9..030b74e821e4 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -38,5 +38,6 @@ void btrfs_set_root_node(struct btrfs_root_item *item,
 			 struct extent_buffer *node);
 void btrfs_check_and_init_root_item(struct btrfs_root_item *item);
 void btrfs_update_root_times(struct btrfs_trans_handle *trans, struct btrfs_root *root);
+u64 btrfs_root_origin_generation(struct btrfs_root *root);
 
 #endif
-- 
2.43.0


