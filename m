Return-Path: <linux-btrfs+bounces-9639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A421B9C8DBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B131F23CE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96713CA8D;
	Thu, 14 Nov 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2jty4QUe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139272C859
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597627; cv=none; b=HfQnGDrBz+YBvaNT+vfVz4JS3yBp0yTbdt9uVNbqY8W/PWAfwjvHGrtUqh3tnshM8Tm1ptjHDlhBmIkSdVl4ARaBjAPrEXiS8mnc1l2f2XiOH60xDzZl20NsP/ajpoIaWhPpXM5ZoVc++d5q9So+MYgiAdRA1fh18jjxQ4cuLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597627; c=relaxed/simple;
	bh=PKqkcRrtN5+SBNjg417HmtoA+Booc6Y+0KFNf6jz810=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gg+jkTZLn7q+r0IQstixZFQjRYvzeN1Vjf8b/WZ0bcnqKITgIMWdt93Y4Cpiw/BuLRP1EYBYtbBqdj0pqN7km6nW64ZtISedO0UQokE8yX7D++SggbMu0QuggFoo1nO5RfmIZkD5z+NUKR7kUAhaw+CKgkS6TMui7KplS4KoiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2jty4QUe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e35e9e993f9so833368276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731597623; x=1732202423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljOAkzrfb8HZW9upDIPIKLOhtCWMYxWxeomztM3cF9w=;
        b=2jty4QUeHDbK7vl/9hpTDhjayNWVnsJEPjIjzgW6nkDh1EZUc/DvNDvvdro9G0c/2X
         goY9z314hOETVGC1qR9EjIBHQevcRqEFLh5gPaEieLdXn2mZDzhexSfYjIWuMmCiA8yC
         mPKcMuFaYE+4b1I5DmWi5rydJT+guqLiJpx+JpnFEbcMOqX86nmQlOK2W03mRkDkbSsR
         CsUUl9KvQmct0xnBFJ1UJnFTi3ns8yzrt21PWHE5PbuDB+U994KFfLwIc2YV7pX4dSv0
         yG0YgNtUP825F3ij2IAhxwJatqewBzusp8Ik+eiXz3ar5m/73NxlTvluFKeV8V8QW3ey
         eouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597623; x=1732202423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljOAkzrfb8HZW9upDIPIKLOhtCWMYxWxeomztM3cF9w=;
        b=NBLZehBeKsAX1P5oqVnXzbdloX86mXGPenqiYSSwsFJ9oBMrDqIC6xacrK7h6m++fU
         vShqeCiCL/F+wBdF/SznvZHklFmbu2pQbz0D0PvxsI3cxzS24hrM/tsBcF8vtQM/C2g1
         ChOm7hNjT6JP86hElY/tzu4lBb9fl8WAAiMm9GC6I2/gLW6Imnn08uFM+lyn6S6iGWVL
         xaWI5EuqQBOttFSnUh+GvSZKoyfo8RZ8BO3UPakmo3VSmufrPXI8OyvWxyUOIYgxyX/E
         r2jftTYHSCOXd7uP3E3GTk8BycWdj/5nLR0UK/9pObGnXhhR52UYS/Pc5Kj4t7bQxxMo
         6TJA==
X-Gm-Message-State: AOJu0Yyp7lus/lDogYvw6FRPqOQM337PTFVnvftuY798+gymgPIf0Gye
	WaVPIVHolilGBzBbEEkDEfyng3X19Xl8gO7e32LNHQ9dxB3Mu/sQjWDG1gZnZZqa2fxT8xaHmTG
	3
X-Google-Smtp-Source: AGHT+IHzlmE+1lmVUzS8TNorB31J4WYUo7TKHsZvetZHdeEPb3850ztbhsWsQPnUbZZ4q3THZICeFw==
X-Received: by 2002:a05:690c:dcc:b0:6e3:3275:8e5e with SMTP id 00721157ae682-6ee43627386mr24725137b3.33.1731597623576;
        Thu, 14 Nov 2024 07:20:23 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44073347sm2793067b3.59.2024.11.14.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:20:23 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix improper generation check in snapshot delete
Date: Thu, 14 Nov 2024 10:20:17 -0500
Message-ID: <f3f2a9cdd08162a0acf0a02a7ea23cc0977d2dad.1731597571.git.josef@toxicpanda.com>
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
v1->v2:
- Took Filipe's advice and moved the helper to ctree.h with the other root
  helpers.

 fs/btrfs/ctree.h       | 20 ++++++++++++++++++++
 fs/btrfs/extent-tree.c |  6 +++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 317a3712270f..1f4f5df4345d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -370,6 +370,26 @@ static inline void btrfs_set_root_last_trans(struct btrfs_root *root, u64 transi
 	WRITE_ONCE(root->last_trans, transid);
 }
 
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
+static inline u64 btrfs_root_origin_generation(const struct btrfs_root *root)
+{
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
+		return btrfs_root_last_snapshot(&root->root_item);
+	return root->root_key.offset;
+}
+
 /*
  * Structure that conveys information about an extent that is going to replace
  * all the extents in a file range.
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
-- 
2.43.0


