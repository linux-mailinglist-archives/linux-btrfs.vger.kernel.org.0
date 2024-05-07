Return-Path: <linux-btrfs+bounces-4817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B379D8BEB4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D771C238E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648116DECF;
	Tue,  7 May 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JGKSy0Ag"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890716DED8
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105565; cv=none; b=GQZz52Q6OhradGwKnviQ3TuJEYj9mmlJy5nX+e8MCcfhg1R5AQKXsmzl99RvJbviE21uhhVR6AYJsqyQQmLo6vt3eZO/pq1zIycyiIttzb6wgUq7pXsZHurM6pLfqH/UPq1d2lqIiGAOP6tG9IEZqcuBbU6vtNYrRjF1yFn+WDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105565; c=relaxed/simple;
	bh=7EuX/D5uY4USCm1vWn5ThNThW2glY8Ma4FjrXf5m/ew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp265W8odFCTSxVeWskupqk50ZKBeXoiIeN01kjjcHZDqm6kajM/zcfHmr+/O+PoF8wcsHAbmG1RDsXzdqK06w7lmwUynF9kBA1catwmLs9o7Mpg2uJGPNsoTgNMyNyXrnBLKNSM+1q6l+DPic7n+88l18j4khQWO1HXEFpZyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JGKSy0Ag; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bed5ce32fso38350817b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105563; x=1715710363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqY3Rx2KAwCn3LtafZ3TUHafD732X+6yJCbuJ0dSJZA=;
        b=JGKSy0AgpjOqOt6892w4S8CbX7H4PX6WoYApkCVhe0gyOCndiBITLLMvKgvAbg5MvZ
         Ym3NNS+Tp/xKmBSreae3mlTO4oieF4Fkid76PQifo4KLfAuSzmnhPS1P955YVGvgO7HA
         BwW2xFNHFOJy5M8ESDhxGwEZM20RMgpK78aUWYSMVPtoihHefT8172xGG3BTOiliKmPm
         nzHitV67Wnogh0Y+2p8iQJ2rLZ757fHcMSeR+70Cq11M9Nar0MMpXLOBg9Bd0/abP6W1
         53D4TDG8uqwHhy+gx5scH+sztfqngyk7oOjGfOklFaCuDlKHm3Hq5NAw+5t9OGR4QXho
         xx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105563; x=1715710363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqY3Rx2KAwCn3LtafZ3TUHafD732X+6yJCbuJ0dSJZA=;
        b=JSOvds166lo1rC5FF/qhAFZIyNDChOF/aaOZPxz3FLN+akN/Jxb1wa42o+qq0mzSa6
         NQB7YM3P4htwEUjbGV1l0XWQKqn680ixHR5XuDQoMHuAmjI7FA+4JUz/tWgp9XwFlvMx
         SzMRc8Q3oYdhU8HnjolVuGf1mEsZqr8vf3zJYas0StwjO590aCQcZmqLz0uIb0Npx/nR
         sJQyS83rEgV5RoQKIJksZFtpyElGryEzUBmPZjIpuWegW8+9sgJ1NNMqX9BxgiQT59bz
         eJZQsaFvJ7r2uZM/zvRPxaTQAvQq1G4CCto/5n59POEaT8UTtqtnBDihz1CIwalixLk/
         Md/g==
X-Gm-Message-State: AOJu0Yx9duFRg5fYh57FXWOZ/R8Y0J+sdJ2rUx1hnkML/7AFDBCS9dZV
	sUjdLiGG790NcD7khESsUUThsviC60MvZpI9g2wKsbsJfDfqsE6kT2chFwbFDifNh6GPqy4claW
	2
X-Google-Smtp-Source: AGHT+IGb3zGPDKKkwjf4IAW9nehckE0kMMaD8+TcsEeJ5r45ne8vtskt1SP1RngyFFtW2onAYgNDUQ==
X-Received: by 2002:a05:690c:4a0e:b0:61d:fd3e:abe5 with SMTP id 00721157ae682-62085c3ec60mr6219387b3.52.1715105562754;
        Tue, 07 May 2024 11:12:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l80-20020a0de253000000b0061beabc76afsm2834199ywe.9.2024.05.07.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 15/15] btrfs: add documentation around snapshot delete
Date: Tue,  7 May 2024 14:12:16 -0400
Message-ID: <346b44dda597538cafc442672b13607a8711cbc3.1715105406.git.josef@toxicpanda.com>
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

Snapshot delete has some complicated looking code that is weirdly subtle
at times.  I've cleaned it up the best I can without re-writing it, but
there are still a lot of details that are non-obvious.  Add a bunch of
comments to the main parts of the code to help future developers better
understand the mechanics of snapshot deletion.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 743f78322fed..6a9d216c660a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5223,7 +5223,20 @@ struct walk_control {
 	int lookup_info;
 };
 
+/*
+ * This is our normal stage.  We are traversing blocks the current snapshot owns
+ * and we are dropping any of our references to any children we are able to, and
+ * then freeing the block once we've processed all of the children.
+ */
 #define DROP_REFERENCE	1
+
+/*
+ * We enter this stage when we have to walk into a child block (meaning we can't
+ * simply drop our reference to it from our current parent node) and there are
+ * more than one reference on it.  If we are the owner of any of the children
+ * blocks from the current parent node then we have to do the FULL_BACKREF dance
+ * on them in order to drop our normal ref and add the shared ref.
+ */
 #define UPDATE_BACKREF	2
 
 /*
@@ -5860,6 +5873,27 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	return -EUCLEAN;
 }
 
+/*
+ * walk_down_tree consists of two steps.
+ *
+ * walk_down_proc().  Look up the reference count and reference of our current
+ * wc->level.  At this point path->nodes[wc->level] should be populated and
+ * uptodate, and in most cases should already be locked.  If we are in
+ * DROP_REFERENCE and our refcount is > 1 then we've entered a shared node and
+ * we can walk back up the tree.  If we are UPDATE_BACKREF we have to set
+ * FULL_BACKREF on this node if it's not already set, and then do the
+ * FULL_BACKREF conversion dance, which is to drop the root reference and add
+ * the shared reference to all of this nodes children.
+ *
+ * do_walk_down().  This is where we actually start iterating on the children of
+ * our current path->nodes[wc->level].  For DROP_REFERENCE that means dropping
+ * our reference to the children that return false from visit_node_for_delete(),
+ * which has various conditions where we know we can just drop our reference
+ * without visiting the node.  For UPDATE_BACKREF we will skip any children that
+ * visit_node_for_delete() returns false for, only walking down when necessary.
+ * The bulk of the work for UPDATE_BACKREF occurs in the walk_up_tree() part of
+ * snapshot deletion.
+ */
 static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct btrfs_path *path,
@@ -5892,6 +5926,24 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 	return (ret == 1) ? 0 : ret;
 }
 
+/*
+ * walk_up_tree is responsible for making sure we visit every slot on our
+ * current node, and if we're at the end of that node then we call
+ * walk_up_proc() on our current node which will do one of a few things based on
+ * our stage.
+ *
+ * UPDATE_BACKREF.  If we wc->level is currently less than our wc->shared_level
+ * then we need to walk back up the tree, and then going back down into the
+ * other slots via walk_down_tree to update any other children from our original
+ * wc->shared_level.  Once we're at or above our wc->shared_level we can switch
+ * back to DROP_REFERENCE, lookup the current nodes refs and flags, and carry
+ * on.
+ *
+ * DROP_REFERENCE. If our refs == 1 then we're going to free this tree block.
+ * If we're level 0 then we need to btrfs_dec_ref() on all of the data extents
+ * in our current leaf.  After that we call btrfs_free_tree_block() on the
+ * current node and walk up to the next node to walk down the next slot.
+ */
 static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root,
 				 struct btrfs_path *path,
-- 
2.43.0


