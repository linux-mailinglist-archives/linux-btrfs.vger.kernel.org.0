Return-Path: <linux-btrfs+bounces-4214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61278A3FA4
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C02B216E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDF58AB2;
	Sat, 13 Apr 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wY9+F7xS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675483FB1C
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052418; cv=none; b=X0A1yg/OuZ7Eq8tOAOTpTu7SIEsTTxlk87/e7LRn1RtFs7jFKIw4sI9TbL64IrpfRg2XL7B+ABx/CZeWXweXCAnqu8k11jHTNQitlTjz3iytGZYtKOmJETNsib5yart8KuFIthfJOQD1RlIOuyU6aKFfJaGw3NR0wIb462QONjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052418; c=relaxed/simple;
	bh=4p+p96OwrJ2DnU625JuqUOT2IDCLAcMP1ZMnFYjhPIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igyh+jtCvh8D/RNUmgKL9Z037L5Lfm2XIh22Q7ZS2Bs3qeVcm+IJ5RbktJNbvS56/TzrqlxXGqIpmqHCfhhBdXySZHWZd9b/5DPqPDvWY/OzHvi3svc+HiEykyBSFt//XxFN6X/VOCh2trPva1DYWRBsd8BlZNEA4V2rHmKiik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wY9+F7xS; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d62c1e82bso141405285a.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052415; x=1713657215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u44kHaaJGUhFV2geodQRccc/1EmODR5o/ni0lNUJ8LM=;
        b=wY9+F7xSzbwG6Q/53fun0/ImfWqlqKQ1VZYq9T2XZOFXBKUMM4HgdRtwXdvnnOcCdJ
         m7tUAvPoIpJVBAQbo5mUmnd8DiAthCnpSLyTGxo3t8mKBlA7PKT8MRiUHNIeejB6y4Lm
         HZ1nWALMKEVzde70as6ljVWUweeGbwyl/VU1sR7TR9S0SLMIEaPpGH77XPZ+Fr2oNgc8
         A2Lws49pZyrIwzlvPbXACukXggztxrdsC6pHhk4iXa5E4Jvg2hoZh0ayajuHgWF4RvTk
         mCXd4h6AJRSfQTH6FhDnGExYdAEqCGFv0L2Je+gmlcxL23xR/zI8nbz25qRjcW9maEU7
         AURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052415; x=1713657215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u44kHaaJGUhFV2geodQRccc/1EmODR5o/ni0lNUJ8LM=;
        b=JNPporvtNwqeH0z4xlNWBb9Smqw+ohR4FikhyvPTfnVz87VMxX/2YHrQE+fTYWELKm
         CuTPiEvsZEXO55Zs7L84Se7Ig71rghCNztRrf7owCeeeZn6D+u31fjEl7fphQw13yd+h
         pNUDwgnFbCuFpHALRdzw3UdmoTgzEX3wzdDDqa5z19KKWHwWgNWEJj4vvOL/YbCNOAS7
         nzCFF9sPp2u1xEFYUnBV2JoX+K1QohOAAfOsvdMVJVT47JlCJX5syeVnRRMhjsQ1vR84
         UJiWK4YDkJJxlSaZ0xs9Aj//W7226fzunPpmroa9gYQQv3lGoKotAI6eWix4i1JFp4bk
         a5mw==
X-Gm-Message-State: AOJu0Yy2dTn9roTpNEBFCSWiL2hakcwW03SBF5b0prYtpIuYUwpf5uqf
	s2FyOzJT+60cme7rbwT6UQ8OohvCgBrU6rY/GF1tYqnloa9cTw6kk9a9tjVkAnKGLNpcS0w7+2r
	+
X-Google-Smtp-Source: AGHT+IFnGtna8BvnnFGvHG9uG4+0IQZvmnhEcaDCIAM73VCRbCXHVCAdEmVQividC9FpZo3wUC7MHA==
X-Received: by 2002:a05:620a:c04:b0:78d:5f2c:9a19 with SMTP id l4-20020a05620a0c0400b0078d5f2c9a19mr6757570qki.40.1713052414978;
        Sat, 13 Apr 2024 16:53:34 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a110c00b0078d67886632sm4340777qkk.37.2024.04.13.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 01/19] btrfs: add a helper to get the delayed ref node from the data/tree ref
Date: Sat, 13 Apr 2024 19:53:11 -0400
Message-ID: <2b6d5c91e6d8d25c9a8d4d21d7ce46df6ddba7f8.1713052088.git.josef@toxicpanda.com>
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

We have several different ways we refer to references throughout the
code and it's not consistent and there's a bit of duplication.  In order
to clean this up I want to have one structure we use to define reference
information, and one structure we use for the delayed reference
information.  Start this process by adding a helper to get from the
btrfs_delayed_data_ref/btrfs_delayed_tree_ref to the
btrfs_delayed_ref_node so that it'll make moving these structures around
simpler.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 28 +++++++++++++++++++---------
 fs/btrfs/delayed-ref.h | 12 ++++++++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e44e62cf76bc..d920663a18fd 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -310,7 +310,9 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 static int comp_tree_refs(struct btrfs_delayed_tree_ref *ref1,
 			  struct btrfs_delayed_tree_ref *ref2)
 {
-	if (ref1->node.type == BTRFS_TREE_BLOCK_REF_KEY) {
+	struct btrfs_delayed_ref_node *node = btrfs_delayed_tree_ref_to_node(ref1);
+
+	if (node->type == BTRFS_TREE_BLOCK_REF_KEY) {
 		if (ref1->root < ref2->root)
 			return -1;
 		if (ref1->root > ref2->root)
@@ -330,7 +332,9 @@ static int comp_tree_refs(struct btrfs_delayed_tree_ref *ref1,
 static int comp_data_refs(struct btrfs_delayed_data_ref *ref1,
 			  struct btrfs_delayed_data_ref *ref2)
 {
-	if (ref1->node.type == BTRFS_EXTENT_DATA_REF_KEY) {
+	struct btrfs_delayed_ref_node *node = btrfs_delayed_data_ref_to_node(ref1);
+
+	if (node->type == BTRFS_EXTENT_DATA_REF_KEY) {
 		if (ref1->root < ref2->root)
 			return -1;
 		if (ref1->root > ref2->root)
@@ -1061,6 +1065,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_tree_ref *ref;
+	struct btrfs_delayed_ref_node *node;
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
@@ -1096,12 +1101,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	node = btrfs_delayed_tree_ref_to_node(ref);
+
 	if (parent)
 		ref_type = BTRFS_SHARED_BLOCK_REF_KEY;
 	else
 		ref_type = BTRFS_TREE_BLOCK_REF_KEY;
 
-	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
+	init_delayed_ref_common(fs_info, node, bytenr, num_bytes,
 				generic_ref->tree_ref.ref_root, action,
 				ref_type);
 	ref->root = generic_ref->tree_ref.ref_root;
@@ -1123,7 +1130,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	merged = insert_delayed_ref(trans, head_ref, &ref->node);
+	merged = insert_delayed_ref(trans, head_ref, node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -1132,7 +1139,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_update_delayed_refs_rsv(trans);
 
-	trace_add_delayed_tree_ref(fs_info, &ref->node, ref,
+	trace_add_delayed_tree_ref(fs_info, node, ref,
 				   action == BTRFS_ADD_DELAYED_EXTENT ?
 				   BTRFS_ADD_DELAYED_REF : action);
 	if (merged)
@@ -1153,6 +1160,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_data_ref *ref;
+	struct btrfs_delayed_ref_node *node;
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
@@ -1172,12 +1180,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	if (!ref)
 		return -ENOMEM;
 
+	node = btrfs_delayed_data_ref_to_node(ref);
+
 	if (parent)
 	        ref_type = BTRFS_SHARED_DATA_REF_KEY;
 	else
 	        ref_type = BTRFS_EXTENT_DATA_REF_KEY;
-	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
-				ref_root, action, ref_type);
+	init_delayed_ref_common(fs_info, node, bytenr, num_bytes, ref_root,
+				action, ref_type);
 	ref->root = ref_root;
 	ref->parent = parent;
 	ref->objectid = owner;
@@ -1214,7 +1224,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	merged = insert_delayed_ref(trans, head_ref, &ref->node);
+	merged = insert_delayed_ref(trans, head_ref, node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -1223,7 +1233,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_update_delayed_refs_rsv(trans);
 
-	trace_add_delayed_data_ref(trans->fs_info, &ref->node, ref,
+	trace_add_delayed_data_ref(trans->fs_info, node, ref,
 				   action == BTRFS_ADD_DELAYED_EXTENT ?
 				   BTRFS_ADD_DELAYED_REF : action);
 	if (merged)
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b291147cb8ab..b3a78bf7b072 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -413,4 +413,16 @@ btrfs_delayed_node_to_data_ref(struct btrfs_delayed_ref_node *node)
 	return container_of(node, struct btrfs_delayed_data_ref, node);
 }
 
+static inline struct btrfs_delayed_ref_node *
+btrfs_delayed_tree_ref_to_node(struct btrfs_delayed_tree_ref *ref)
+{
+	return &ref->node;
+}
+
+static inline struct btrfs_delayed_ref_node *
+btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
+{
+	return &ref->node;
+}
+
 #endif
-- 
2.43.0


