Return-Path: <linux-btrfs+bounces-4608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B08B5A25
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E375B26DA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA0745C0;
	Mon, 29 Apr 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yWqYiD+g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB7651B6
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397404; cv=none; b=JHnIMnCcw7vokSe84MaEGapYBVooRlqioe7P2tmx9Tj5uDJThepYu+7qfKpB9OiFye4svncR200caOnLdorajnaxEuh5OgVrdRGZIHfPXKjCJjWkxu2jsjTKPs2U32U1o+EtW+2n1+vFe/ljNss/Q8FZ5PIGSLY60sxOyzc2uhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397404; c=relaxed/simple;
	bh=i8RXtZ0smrzDy+1N96mqeYoGyp+Hs01PVjLVlvxxkGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNpnJwiIAs1asknEALbOA7EshzjcImHs6xImP1KZLM6fhbwkF2IILGqWBjSaj798hYddqpMfPyOA1dNG9TkZipWkJV1n0AvGrQ+9bwIAQjfi6pzgohQCpgm+A61GSNoXWfAxGMGlPUyecRkL9JGD0i/7/ZDSy4dgeUTU6HYHQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yWqYiD+g; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso1632163fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397401; x=1715002201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wGp5IYvkDHig0jwh1l9YZvi35B8FpyMMfq8GLRr3wE=;
        b=yWqYiD+gJWEiP6ZbE3oHI0l+kTVBLA/yIolAAK9B44kTmwg0osTE4PhZf6b1y/2PJQ
         uBbTMZN6QUfGo8xapj/2Nmh+yVeHhP2SwZu4eRWuUDD2doTPkzdkRZIwZ2c+OG6I90LU
         a9CCfpJaS/aP7Uivt1mbPi39twwAJUgy6pc7lUSBZ8hiHbzZUO6BIdJN8mhvQ2K+PZoz
         Mz7uB360zXrE6x8zHwpNLvFcbj/dZw+38Oa005wfoiuj80KD6dqiWdnciWAGPRDzDfJr
         TllpoeGjNhAq1cK/bcE3ZPQUDeZNLEruOBJ5oK8e4sqX4q9ifLHN34Hc1SUthKlrSsTM
         mGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397401; x=1715002201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wGp5IYvkDHig0jwh1l9YZvi35B8FpyMMfq8GLRr3wE=;
        b=d96/2D9t8WdEDxLhAURVINYm/iNbuJz8CWx/gKpiZNzwGXeOhyG09OLXVAi3Yl3y6T
         u+XCD8le0pNLs3CZfVHn3BfgixArdq8x4rlpIbWDHgBiajsicDwrsqtuonZJpWYbHQom
         kN9luxxXtOow0g4PNgdpn8LYEcbDm2yxQzEtJ62DVIN6+5HKbsiyZsCKV+3X8srmGvRJ
         jicxffK3iP928H/IqFTWPvECfsYPp9V4BkHDR1r6iMRCbKg9bOu0VpysdyoljQPuz4iW
         MmygXKPP3HhRl2B0Xmb6/jRdvREP4g8HYRb9F3g5m8bLXO4w2bpEB2LEf7Y5meYkqZFW
         n72g==
X-Gm-Message-State: AOJu0Ywtfb+x5dTugQVid6ibB0mjxo+R8bm9pmwoqcgIzo3faaZG+ME6
	DK2qiJD93spxBKmkt3rthCmHNt8mnlRCDkjI6r6ueByYTfjs449AZ6SFoHO1Xgc0dil+Du/E5xo
	r
X-Google-Smtp-Source: AGHT+IF9jVAgMJL3izWeMSFC2lL/QPD37imuL9ti8ouxoPRr+YqK2bHP7JFnHU0Dn097VxqEh3OdyQ==
X-Received: by 2002:a05:6871:7aa:b0:23a:980f:1fb8 with SMTP id o42-20020a05687107aa00b0023a980f1fb8mr11430000oap.53.1714397401628;
        Mon, 29 Apr 2024 06:30:01 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm10399381qkn.135.2024.04.29.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 05/15] btrfs: move the eb uptodate code into it's own helper
Date: Mon, 29 Apr 2024 09:29:40 -0400
Message-ID: <affde3ffc1350fa8b3239fb2ab0779c70c423727.1714397223.git.josef@toxicpanda.com>
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

do_walk_down() already has a bunch of things going on, and there's a bit
of code related to reading in the next eb if we decide we need it.  Move
this code off into it's own helper to clean up do_walk_down() a little
bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 68 +++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1d59764f58b4..8f5cf889e24d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5408,6 +5408,51 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 	return 1;
 }
 
+/*
+ * We may not have an uptodate block, so if we are going to walk down into this
+ * block we need to drop the lock, read it off of the disk, re-lock it and
+ * return to continue dropping the snapshot.
+ */
+static int check_next_block_uptodate(struct btrfs_trans_handle *trans,
+				     struct btrfs_root *root,
+				     struct btrfs_path *path,
+				     struct walk_control *wc,
+				     struct extent_buffer *next)
+{
+	struct btrfs_tree_parent_check check = { 0 };
+	u64 generation;
+	int level = wc->level;
+	int ret;
+
+	btrfs_assert_tree_write_locked(next);
+
+	generation = btrfs_node_ptr_generation(path->nodes[level],
+					       path->slots[level]);
+
+	if (btrfs_buffer_uptodate(next, generation, 0))
+		return 0;
+
+	check.level = level - 1;
+	check.transid = generation;
+	check.owner_root = btrfs_root_id(root);
+	check.has_first_key = true;
+	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
+			      path->slots[level]);
+
+	btrfs_tree_unlock(next);
+	if (level == 1)
+		reada_walk_down(trans, root, wc, path);
+	ret = btrfs_read_extent_buffer(next, &check);
+	if (ret) {
+		free_extent_buffer(next);
+		return ret;
+	}
+	btrfs_tree_lock(next);
+	wc->lookup_info = 1;
+	return 0;
+}
+
+
 /*
  * helper to process tree block pointer.
  *
@@ -5430,7 +5475,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 bytenr;
 	u64 generation;
 	u64 owner_root = 0;
-	struct btrfs_tree_parent_check check = { 0 };
 	struct btrfs_key key;
 	struct extent_buffer *next;
 	int level = wc->level;
@@ -5452,13 +5496,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	bytenr = btrfs_node_blockptr(path->nodes[level], path->slots[level]);
 
-	check.level = level - 1;
-	check.transid = generation;
-	check.owner_root = btrfs_root_id(root);
-	check.has_first_key = true;
-	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
-			      path->slots[level]);
-
 	next = btrfs_find_create_tree_block(fs_info, bytenr,
 					    btrfs_root_id(root), level - 1);
 	if (IS_ERR(next))
@@ -5506,18 +5543,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			goto skip;
 	}
 
-	if (!btrfs_buffer_uptodate(next, generation, 0)) {
-		btrfs_tree_unlock(next);
-		if (level == 1)
-			reada_walk_down(trans, root, wc, path);
-		ret = btrfs_read_extent_buffer(next, &check);
-		if (ret) {
-			free_extent_buffer(next);
-			return ret;
-		}
-		btrfs_tree_lock(next);
-		wc->lookup_info = 1;
-	}
+	ret = check_next_block_uptodate(trans, root, path, wc, next);
+	if (ret)
+		return ret;
 
 	level--;
 	ASSERT(level == btrfs_header_level(next));
-- 
2.43.0


