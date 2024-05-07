Return-Path: <linux-btrfs+bounces-4808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57B8BEB43
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045E92831FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374116D9A5;
	Tue,  7 May 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BunGXst0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262216D330
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105553; cv=none; b=JRVJ4/q0FiMVMql6QE3gxrkmAciExBZunPNZIs3Ft80WpDQ23Vgw5UUo3Yy17gXjQniNgN0pEUhT/OOWlbXwjY3lroMhSWhBOauSJPzZohX0uzgakd02Hfylsq7agACFEHXxmj7r1t6oKoGNLK2VNNuxy3pIgCBsvJQGUn+jP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105553; c=relaxed/simple;
	bh=i8RXtZ0smrzDy+1N96mqeYoGyp+Hs01PVjLVlvxxkGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzHCBqqZjTGngpawNYeNHRaHGxG/LxXI08RpZCTwSbaGwNv/Vo72qWhKGj/vu+toL+XMqyIJ9UZsR0GT72o4SwXJZRm4Lrqn9ePOZauw3gR8s5G7hbSRwLw3h+ovp2Rot4CaBuXMkEo5ZWy0UAoCil27l7mgWzrgXTEe4nf/S60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BunGXst0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61ab6faf179so36386107b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105550; x=1715710350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wGp5IYvkDHig0jwh1l9YZvi35B8FpyMMfq8GLRr3wE=;
        b=BunGXst0OQ9NYuCiXm103wrF7kVqMTnukb8BGxObblxZQA0Q4eQA6z8shjNT2fsT9I
         /wX9cXH8qlv4ptlSLNUpeGIpxt4BvWOk64lmnEta5n+H5AZuD7RjIogvjnxluxmX0vFM
         +vPbGB4xK+9N8uUa2QoB2IRCwb6h5EwpN1QuRAxITWZQfXJu+Fu8fio8Tp310GHvvZDw
         7lNX/rdFpbHJCQHmREaJnIcUbykNRBxtBLedPL7Ev0M4tpykrj8UhCd11P1TvaPSOQBC
         ZQrzCQ/Ai1wG2CpPUQuvzfA0duZW4AsR79YqeQHL2WRCRU1wnqIP1bllq7nIS2qbSMWr
         /fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105550; x=1715710350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wGp5IYvkDHig0jwh1l9YZvi35B8FpyMMfq8GLRr3wE=;
        b=C3anLIO/uBUAJ0GJicFCPs9+rbzZv3mZfFTjYMRMVyjyaCBDGpgsJVnzgH1M3ovu9k
         mh4AYN3fsgHfUQlvDXWSe24XXwcHVFox9aMsqwpyNRpBdlD2CIn7y4UrVfZJFAS3Pg8H
         mLgMbV/L27ZeVZKOhdm/Vy/F2hXyzWjBhYf02eDn0jC5+p4O8zh6SlWiCq7zWCFgX+dM
         jVeE1tjtT1+C6CD1jgYIwkvc4Ip/TPegKk3enAHmGUhy05dc4xaM6eM0KebdZknLuRI9
         u4MyCRKFZLFZUGAlnnY1ZHo61Zkt0XqQ2v3KRU/jnRX6zyrQABjfVN0Lo6TgDsBCKMyL
         CTaw==
X-Gm-Message-State: AOJu0YyHvkn2r0z6j1Y18rxeQI/Us3Ovaakpc4jc2tQv1tNRN4AfwaiD
	LAzHZQ17ytpEOv6y/0alAyMUoy34vsN9nkKa42cNF2xQoUV4DOl7ekaWTXDxygzTcG8OsJS/6qF
	W
X-Google-Smtp-Source: AGHT+IF0OZ6sNYn+1gKHUZPc9+6AvnAbEIt8t8umZRVXQfIonNHvobBWqp2P46YPIwTFDMIyzAtpCg==
X-Received: by 2002:a81:be10:0:b0:61a:ca09:dae3 with SMTP id 00721157ae682-62085da6e92mr5964707b3.26.1715105549610;
        Tue, 07 May 2024 11:12:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g23-20020a81ae57000000b0061bed5b2c38sm2856984ywk.0.2024.05.07.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 05/15] btrfs: move the eb uptodate code into it's own helper
Date: Tue,  7 May 2024 14:12:06 -0400
Message-ID: <cf980cc7a4fb06c9937f68d575a19c7b36837fd5.1715105406.git.josef@toxicpanda.com>
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


