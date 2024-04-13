Return-Path: <linux-btrfs+bounces-4218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F358A3FA8
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C006CB218E6
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98659B41;
	Sat, 13 Apr 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ykOg9zdS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAA58231
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052421; cv=none; b=TGhbX47RHKcRDsoVoEIGtkYRY9MT2pWOyKEU4hXbT1MDIYXzx2B4LOHqiip6H/meKUKeuwxd0hcoqFxTcBICNFYZ10rPPRBGiz0tsr6ZrxPG0TaMB6qDEktyO+KHhLozYODy8A5gPt1dXVG0Mm+6/ie69KfFrRjfYs8qNivdz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052421; c=relaxed/simple;
	bh=agD0zu8HVyKalAc6mdGIz2auJNy6BHEj0fwGZ6k/AeY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I57WGVo4gmAZDrngkb7braNwRAJZzgXCSNlQzOmchZKTDZqcbujSvsO13uiX180jor0lLQlaKUpQsYEyBL7PqnbGbP0z4lsd/hVw1LjEY4OFgT/xx9WQujzqWc3vSDX68FRr31G4xuzMON/p3Vr4GIFbvMMQ+aQlAdeXBpMKDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ykOg9zdS; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b44071a07so17838426d6.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052419; x=1713657219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiyTh16uGBN2CDw0SKDs0np82Sjk5tk0rVmQuxf57p0=;
        b=ykOg9zdSUedghDUZEHKEqt4C9vnUhWmvINWWoB9TNHHOjIJ1X7AZrMn1EmULnYt36I
         1bvZdEW2Pt4GXx//mlW+cuvf9iJArwLtfJyKDKHNku+Lwj2VK+Xh7hPuunYOREXhUiVq
         FGY2SzY3iB/xFz4EfQ58fp9rjrcu6925BHqNVPhjZYOp2UQcxw6qQaAO8utkc1Hj8Mgy
         q9njmopgi6nUHchNIkNrJrL631bKgmEl1004GzePsUDo6vz1upzpfOAtYV9u9efQG/8K
         T7q6MlkR8/CfeqR/x16WqNT54fxEflG8PfC8PMyn9xgIO65YAe6+MzpWFBBF3SqKJoqq
         +0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052419; x=1713657219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiyTh16uGBN2CDw0SKDs0np82Sjk5tk0rVmQuxf57p0=;
        b=K/Z1lRS8U8mUX+nMhOGbCUlbEB5wMOsBw3UgE6bc9zSCa431qX4VzXd21fmdilej03
         8wV9pb+wYN9r1NlaDjHJQ8Fx5PQS2RSpWXzrvSsAw27bVBPxDNEs8YClfY94ySfWy1ev
         76o/9rUMxyrh/F7oami2/ivmGNjYDo66uXAA3ClqV4oMflYY10tVpBb+qPwD2EqeoYhg
         DQO51WyXgfYOC+BpDHcAllt8ihRL3nfP5EzpgMpEIBvkA1eCr+MCYDJfoI19vuUYxXGA
         +ObAOKQCrVHnMfR4W5tT3p7If23zsI4Qq+d1tunWYNdSZfQf6XcRtMvl6PoebP0ScDU8
         yzlA==
X-Gm-Message-State: AOJu0Yxnxnrs8v58vfzFUoxkPw7N92U3VwvFKLd6rUdTarKzwFFilOTh
	0tFQffmo8bvIi1hSsOmp6Lc0+9i6XrUbPNNmdA1nIE7EKAdt5IevR1g3s16cJnyaYqnrDZYEfxa
	i
X-Google-Smtp-Source: AGHT+IG7ZgKpyGwUbdSBwzvEujJSl7U7gYjYNkKu1AE+rzwQXp6Z4V79vFJ6cX5BJXJJ0fmSK8iFuQ==
X-Received: by 2002:a05:622a:20f:b0:434:f629:fa6c with SMTP id b15-20020a05622a020f00b00434f629fa6cmr8493867qtx.14.1713052419190;
        Sat, 13 Apr 2024 16:53:39 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p26-20020ac8741a000000b0043123c8b6a6sm4068552qtq.4.2024.04.13.16.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 05/19] btrfs: pass btrfs_ref to init_delayed_ref_common
Date: Sat, 13 Apr 2024 19:53:15 -0400
Message-ID: <f31af8b1283c8dab1f07b0fb7a9617f97f991b7f.1713052088.git.josef@toxicpanda.com>
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

We're extracting all of these values from the btrfs_ref we passed in
already, just pass the btrfs_ref through to init_delayed_ref_common and
get the values directly from the struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 29 ++++++++---------------------
 fs/btrfs/delayed-ref.h | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index c6a1b6938654..f5e4a64283e4 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -985,24 +985,24 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
  */
 static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 				    struct btrfs_delayed_ref_node *ref,
-				    u64 bytenr, u64 num_bytes, u64 ref_root,
-				    int action, u8 ref_type)
+				    struct btrfs_ref *generic_ref)
 {
+	int action = generic_ref->action;
 	u64 seq = 0;
 
 	if (action == BTRFS_ADD_DELAYED_EXTENT)
 		action = BTRFS_ADD_DELAYED_REF;
 
-	if (is_fstree(ref_root))
+	if (is_fstree(generic_ref->ref_root))
 		seq = atomic64_read(&fs_info->tree_mod_seq);
 
 	refcount_set(&ref->refs, 1);
-	ref->bytenr = bytenr;
-	ref->num_bytes = num_bytes;
+	ref->bytenr = generic_ref->bytenr;
+	ref->num_bytes = generic_ref->len;
 	ref->ref_mod = 1;
 	ref->action = action;
 	ref->seq = seq;
-	ref->type = ref_type;
+	ref->type = btrfs_ref_type(generic_ref);
 	RB_CLEAR_NODE(&ref->ref_node);
 	INIT_LIST_HEAD(&ref->add_list);
 }
@@ -1064,7 +1064,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u8 ref_type;
 
 	is_system = (generic_ref->ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 
@@ -1090,13 +1089,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	ref = btrfs_delayed_node_to_tree_ref(node);
 
-	if (parent)
-		ref_type = BTRFS_SHARED_BLOCK_REF_KEY;
-	else
-		ref_type = BTRFS_TREE_BLOCK_REF_KEY;
-
-	init_delayed_ref_common(fs_info, node, bytenr, num_bytes,
-				generic_ref->ref_root, action, ref_type);
+	init_delayed_ref_common(fs_info, node, generic_ref);
 	ref->root = generic_ref->ref_root;
 	ref->parent = parent;
 	ref->level = level;
@@ -1159,7 +1152,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 ref_root = generic_ref->ref_root;
 	u64 owner = generic_ref->data_ref.ino;
 	u64 offset = generic_ref->data_ref.offset;
-	u8 ref_type;
 
 	ASSERT(generic_ref->type == BTRFS_REF_DATA && action);
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
@@ -1168,12 +1160,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 
 	ref = btrfs_delayed_node_to_data_ref(node);
 
-	if (parent)
-	        ref_type = BTRFS_SHARED_DATA_REF_KEY;
-	else
-	        ref_type = BTRFS_EXTENT_DATA_REF_KEY;
-	init_delayed_ref_common(fs_info, node, bytenr, num_bytes, ref_root,
-				action, ref_type);
+	init_delayed_ref_common(fs_info, node, generic_ref);
 	ref->root = ref_root;
 	ref->parent = parent;
 	ref->objectid = owner;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index bf2916906bb8..83fcb32715a4 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -421,4 +421,23 @@ btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
 	return container_of(ref, struct btrfs_delayed_ref_node, data_ref);
 }
 
+static inline u8 btrfs_ref_type(struct btrfs_ref *ref)
+{
+	ASSERT(ref->type != BTRFS_REF_NOT_SET);
+
+	if (ref->type == BTRFS_REF_DATA) {
+		if (ref->parent)
+			return BTRFS_SHARED_DATA_REF_KEY;
+		else
+			return BTRFS_EXTENT_DATA_REF_KEY;
+	} else {
+		if (ref->parent)
+			return BTRFS_SHARED_BLOCK_REF_KEY;
+		else
+			return BTRFS_TREE_BLOCK_REF_KEY;
+	}
+
+	return 0;
+}
+
 #endif
-- 
2.43.0


