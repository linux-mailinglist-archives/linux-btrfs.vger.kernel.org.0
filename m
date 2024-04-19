Return-Path: <linux-btrfs+bounces-4443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F78AB4F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1120D285FF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5376C13C9A2;
	Fri, 19 Apr 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GNa13sli"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A413C905
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550643; cv=none; b=UTHVqqVybrdA4QZh5WsuC5urUdw3mxvBdwDXBl+183NTSwCHuvRBuPNcbjp9JNRIfgp/cxVWvaLIHKW50x11DX4UQvHzdizH+65mNZeG5HJuCbCK9IGoJlkvi0f+eZgEvBqYyxQvPll3s/4n5A7Jkqx3X6YiY3fgba1bIHnUh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550643; c=relaxed/simple;
	bh=KzHmp05/Wo2kKg3UCSlB89t49owyeLF/elQAy9QqQF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlpocsIxIKK3voXIOU9whvRv0BQUlx8VyY5+nlZUIGioiCu0slUKs5CPC3rsUYdYuw089ZiFcd9h9GA1Jt/CJ+av/rs3DNZbaVF/yFnb3+AAYCNqXLxwiBDdnzao6fsQropg35ZIRaM2cq+UcsmF/2sBn2Go05YdSDXMwqHil1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GNa13sli; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78edc3ad5fdso195263385a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550641; x=1714155441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOM0zyVqt5YQcXWXCQH2v1El0afwyY8kNvtYtv+qgHM=;
        b=GNa13slidQkVh0BmCguEiNJJdbRXHmukib7HAWLXgEUVQxJXIGLjTjjahSiectvmCO
         roNytNZbrVY7OPtZVs3qnml9ingM894oV7PW57OiD0FGGV4KcAMtJovFGx1176S0ilYM
         ApJKjqrsF7IhsDIYe9MdCqiMKqDv/5AitHEe2aEaK4sSgNb6n8b84HX/pOQUFQ84cJLh
         yeQFhSewq5rGB6zAGpp0Ew67KtTB2jFHfoEWEd2UjNgdurS+HnzpvSk6kr/Z6ATTD3VK
         u7/CsrkRKGjt1l7rqOGxGk9FY8iu4Ddn9MN3ofpVu4mENc9G7ch17jfbEHGC81ru/YSl
         qm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550641; x=1714155441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOM0zyVqt5YQcXWXCQH2v1El0afwyY8kNvtYtv+qgHM=;
        b=r4FMHNZZ5riJJhKZrJ4xr9p+euGMQEbhfl4An3P9WNj/Uh4woIZi0JymcW1l+Vuw+1
         aTqd7Kiz3C2hdLn5GYCIC4oYzmUpymumrbVXQpRDlDetmrqdfXDNY6jqhTcES35ZXMqg
         t+JtQuW/6KHr0swctmwCFTc28LTmXsTchyXR8db5M5469rkewtcvhqQwFlLn2QBj7tWZ
         akPEBd/loT0MDg+rePYAXA0QDGRTp1MyqTSGODDiHDZSGYVQExt8RWcAOEh0oPGJaDvJ
         nzZbLc0XpYmi60XQG1l2wI1IMZNTQtF8mgAfQgSPHHDnh5cSg1EvrhZaxFGoqi4nYPwV
         O/Cg==
X-Gm-Message-State: AOJu0YwmkJLt2IImRhsa5ym53l3mvwt6/APSzkQwcY/jOJQXdwdukqJ5
	K5uELlMN3ZWHRaxJIf+V8E2cbP4VQp5gvvqjY7RiY4gO2lWXrKHbQys+7hMnxcdTc3BfQP/FyMQ
	i
X-Google-Smtp-Source: AGHT+IGE/WVXf1+ryXvQc1pxUSymbIo2sO+SsN9cGsC3g2ZnGGwJaCrfrqr0BcmvuKNEX0PyRUmdJA==
X-Received: by 2002:a05:620a:2407:b0:78e:bd2d:4ab8 with SMTP id d7-20020a05620a240700b0078ebd2d4ab8mr10713088qkn.30.1713550640851;
        Fri, 19 Apr 2024 11:17:20 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u24-20020a05620a023800b0078f12e42f0csm1417646qkm.20.2024.04.19.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 05/15] btrfs: move the eb uptodate code into it's own helper
Date: Fri, 19 Apr 2024 14:17:00 -0400
Message-ID: <569ec6a3d78ce12808f515ddc0924bea62733221.1713550368.git.josef@toxicpanda.com>
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

do_walk_down() already has a bunch of things going on, and there's a bit
of code related to reading in the next eb if we decide we need it.  Move
this code off into it's own helper to clean up do_walk_down() a little
bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 68 +++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0ebbad032c73..9132cfb7fee1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5409,6 +5409,51 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
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
@@ -5431,7 +5476,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 bytenr;
 	u64 generation;
 	u64 owner_root = 0;
-	struct btrfs_tree_parent_check check = { 0 };
 	struct btrfs_key key;
 	struct extent_buffer *next;
 	int level = wc->level;
@@ -5453,13 +5497,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
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
@@ -5507,18 +5544,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
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


