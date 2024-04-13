Return-Path: <linux-btrfs+bounces-4228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E88A3FB2
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D7C1C21045
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E05B208;
	Sat, 13 Apr 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="u+QkV7r0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B35A4CB
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052431; cv=none; b=reg0URZFd56z+8wiSzs2CRPfsOSoGoY+P6XNoY7UC4469odvKd7NW/yBPQm43PvlOgZiYerXgmIsIMeVZgBucTePLCYdPYr6umZjmIVb6+YvKr7HNrypMxtDCch6oek6nll+zmk0bVHbP1hVnSlsNqdBXnergQubcZvwwAibI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052431; c=relaxed/simple;
	bh=euDn3r6CSbJvOFNXo7+EQ9T//UVAELlDRvsrajDMYIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnRl56CmCK+ljxlSwXUf2x2pdgAaFLruXJZXQUJej7V7ngbnOvvVEgOsR6goBkH8o6VXjsJ+pmFc1eaRnTVV4RQLOi/hMqdFetFavm5cV7r8GzlTaXmuGfmuHest93K5VNzVHrUK5NQEMSnk83kRi9qb5MthApFLYv/tYl2yrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=u+QkV7r0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-434d12e9662so9119741cf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052429; x=1713657229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrnbtPNnK35gENVrGRjWUH3rfWwS8Xjm4tbJmQqfgTc=;
        b=u+QkV7r0N7TNgLqWRbMa6vVs3qsisGtHOzGyWbMsRCcVLknZkn3019dWgPDZ6K+cqw
         ecHCuXd4DWVq0vQKeeLrq9AcuOk6sJiqUlLx2XLyZBYvVSzunWLAc6RclHtLO5FF5qrq
         tEOneCgvxvRqmrXMF/B5n4hYHjnTz46CbuLtImZWY+qkHVnOXi1wlJamEqY1UwXjntHU
         gLwGXQmvw33SHkmXHRwJKnq7C4fd5YWmZhUTKvLgdcRxevpQfUbYFA2b7rsrWVuU7SXg
         thZwx37PV7XuW6On9FQ20cQTlBitPdJ6ZzzfC5X0GxrNl6P/gW1yshhJQXyMJU2yXmSY
         CkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052429; x=1713657229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrnbtPNnK35gENVrGRjWUH3rfWwS8Xjm4tbJmQqfgTc=;
        b=oBLAtfETTP1I5zWZ+SOlyUBlEohEvXN+C9Uh2reCeHwNQv/fkDLi95QEphtRz4GeSx
         deovphYO/JKhbmXjaPZzlYGAT75NNjrVpgFlOL+4JbDHWXddjaTuru5GTjUygyf6SNgV
         E/H19ogNmYQ9J4nQeJbzhvHJtBmBCiN2s2xlqvQKlRxpIyFSTrJIDCs5DNOfhduIaakk
         UbHDCoWjtSqjcV10dAtMdqNj+KiCLzu7/WcCQLOIcOpT81/NRCMVY7v1ItaXLuPmLKGX
         NqI9oQY+HTblq68NXAR5+IFCJNlova0mDVlYgKJEJ25YQbhmTkm3v83TqZsemsR0s6Eo
         caFg==
X-Gm-Message-State: AOJu0Yz6OU7sc5kvRE4WDh6KT05yM9SIGmy2KM8+J1I/duvz6zETdqoL
	XCx0YSdAiQLHJVXAbchiz21NMSTXkADhCRqpFT87kpvb3d4MF320HCj7StabJ83vgc7qTYIyppH
	t
X-Google-Smtp-Source: AGHT+IEOUepduiJPT69lOqOhlkM6muF1qRr2q1NjFryEZVhMYQHuYdDSqLajbeQFSv1sBnodd72UTg==
X-Received: by 2002:a05:622a:164e:b0:436:1139:25b1 with SMTP id y14-20020a05622a164e00b00436113925b1mr8221137qtj.19.1713052429245;
        Sat, 13 Apr 2024 16:53:49 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h12-20020ac8744c000000b00434fd7d6d00sm4064880qtr.2.2024.04.13.16.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 15/19] btrfs: make the insert backref helpers take a btrfs_delayed_ref_node
Date: Sat, 13 Apr 2024 19:53:25 -0400
Message-ID: <c849bc3ba7c0871ff672eca80e4f096eec92fe98.1713052088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713052088.git.josef@toxicpanda.com>
References: <cover.1713052088.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to pass in all the elements for the backrefs as function
arguments, simply pass through the btrfs_delayed_ref_node and then
extract the values we need from that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 46 +++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 540dadcefb92..d85bc31f2e57 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -513,26 +513,26 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 
 static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 					   struct btrfs_path *path,
-					   u64 bytenr, u64 parent,
-					   u64 root_objectid, u64 owner,
-					   u64 offset, int refs_to_add)
+					   struct btrfs_delayed_ref_node *node,
+					   u64 bytenr)
 {
 	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
+	u64 owner = btrfs_delayed_ref_owner(node);
+	u64 offset = btrfs_delayed_ref_offset(node);
 	u32 size;
 	u32 num_refs;
 	int ret;
 
 	key.objectid = bytenr;
-	if (parent) {
+	if (node->parent) {
 		key.type = BTRFS_SHARED_DATA_REF_KEY;
-		key.offset = parent;
+		key.offset = node->parent;
 		size = sizeof(struct btrfs_shared_data_ref);
 	} else {
 		key.type = BTRFS_EXTENT_DATA_REF_KEY;
-		key.offset = hash_extent_data_ref(root_objectid,
-						  owner, offset);
+		key.offset = hash_extent_data_ref(node->ref_root, owner, offset);
 		size = sizeof(struct btrfs_extent_data_ref);
 	}
 
@@ -541,15 +541,15 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 		goto fail;
 
 	leaf = path->nodes[0];
-	if (parent) {
+	if (node->parent) {
 		struct btrfs_shared_data_ref *ref;
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_shared_data_ref);
 		if (ret == 0) {
-			btrfs_set_shared_data_ref_count(leaf, ref, refs_to_add);
+			btrfs_set_shared_data_ref_count(leaf, ref, node->ref_mod);
 		} else {
 			num_refs = btrfs_shared_data_ref_count(leaf, ref);
-			num_refs += refs_to_add;
+			num_refs += node->ref_mod;
 			btrfs_set_shared_data_ref_count(leaf, ref, num_refs);
 		}
 	} else {
@@ -557,7 +557,7 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 		while (ret == -EEXIST) {
 			ref = btrfs_item_ptr(leaf, path->slots[0],
 					     struct btrfs_extent_data_ref);
-			if (match_extent_data_ref(leaf, ref, root_objectid,
+			if (match_extent_data_ref(leaf, ref, node->ref_root,
 						  owner, offset))
 				break;
 			btrfs_release_path(path);
@@ -572,14 +572,13 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_extent_data_ref);
 		if (ret == 0) {
-			btrfs_set_extent_data_ref_root(leaf, ref,
-						       root_objectid);
+			btrfs_set_extent_data_ref_root(leaf, ref, node->ref_root);
 			btrfs_set_extent_data_ref_objectid(leaf, ref, owner);
 			btrfs_set_extent_data_ref_offset(leaf, ref, offset);
-			btrfs_set_extent_data_ref_count(leaf, ref, refs_to_add);
+			btrfs_set_extent_data_ref_count(leaf, ref, node->ref_mod);
 		} else {
 			num_refs = btrfs_extent_data_ref_count(leaf, ref);
-			num_refs += refs_to_add;
+			num_refs += node->ref_mod;
 			btrfs_set_extent_data_ref_count(leaf, ref, num_refs);
 		}
 	}
@@ -703,20 +702,20 @@ static noinline int lookup_tree_block_ref(struct btrfs_trans_handle *trans,
 
 static noinline int insert_tree_block_ref(struct btrfs_trans_handle *trans,
 					  struct btrfs_path *path,
-					  u64 bytenr, u64 parent,
-					  u64 root_objectid)
+					  struct btrfs_delayed_ref_node *node,
+					  u64 bytenr)
 {
 	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
 	struct btrfs_key key;
 	int ret;
 
 	key.objectid = bytenr;
-	if (parent) {
+	if (node->parent) {
 		key.type = BTRFS_SHARED_BLOCK_REF_KEY;
-		key.offset = parent;
+		key.offset = node->parent;
 	} else {
 		key.type = BTRFS_TREE_BLOCK_REF_KEY;
-		key.offset = root_objectid;
+		key.offset = node->ref_root;
 	}
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
@@ -1509,12 +1508,9 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 	/* now insert the actual backref */
 	if (owner < BTRFS_FIRST_FREE_OBJECTID)
-		ret = insert_tree_block_ref(trans, path, bytenr, node->parent,
-					    node->ref_root);
+		ret = insert_tree_block_ref(trans, path, node, bytenr);
 	else
-		ret = insert_extent_data_ref(trans, path, bytenr, node->parent,
-					     node->ref_root, owner, offset,
-					     refs_to_add);
+		ret = insert_extent_data_ref(trans, path, node, bytenr);
 
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
-- 
2.43.0


