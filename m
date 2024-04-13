Return-Path: <linux-btrfs+bounces-4221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A98A3FAB
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1061F21718
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46125A0FE;
	Sat, 13 Apr 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LEive58Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D259B69
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052424; cv=none; b=m0bJI8QikJTYeIday5xe2Vyu5UN+VX3vRHa+OXqH8W9qY1X18xJQb+kMb+ySWkNFgPMZHBpbCEJUva18QDCymv1PVzhxhAK+qxTRPbyHgFtGssduY5Qb7T8d6RaDkXyTp+NKAMP4Qa+EqDtv54Z5NGjrHHXd7VtqAJo8zMB7PEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052424; c=relaxed/simple;
	bh=nzKLf1MesbqMStX+RtqQmFdOs4/n9jNHHCvfJYZ6UE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIT8e4RQ3p3D/erlcI7bcn0xHsgPHS9fY5bG1QL+enlFr3uF1EZEAtSI5ue+U3YEphbfRsjT+WMOm2WUM3KpLIsL/ix4ikJUs7W8brADemrWjHF8HyDhyKVDhaYt9iO2qVS0gTUsAeRDtxQ19Kwsds/oz7ThNPMDbaKyO0tzkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LEive58Y; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4346520b081so10497281cf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052422; x=1713657222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UtfgTlEvviNwNb4dhkzs6ODNxvhBZ2EePDrr04AgoQ=;
        b=LEive58YEzSqg8qEilkoTM7tQ5IlfueKJkAZH4Y9f4Iev7Hw6fq/ZPNMlcurXohfs/
         WZZhcQWys68m3bXHfLg0e2425PQVENP0vAdrOJIGFJ6O3N1iNTseQEy1/drcsiwIzllF
         RCGWjMX/WuLCapJYaSnCuRHyAz3h5yvEd1e++H38NcIn8I7+EGeXWsrcesNMFhGFTqCt
         CqAjFDPmpaValgUEomcPLFnINEHS7ajyQm9vgNIkY1tw0LKqJqRClpmgWLemG0zqskt6
         R7I6mbKBmiow5nuIObzotLv8KVW1PwGRQRuI1IqHGbvLI6ogTDIjMX1lXfHqSIY3H93U
         F7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052422; x=1713657222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UtfgTlEvviNwNb4dhkzs6ODNxvhBZ2EePDrr04AgoQ=;
        b=iDq+Bgj5BtxlhHFi455WZuyXHCiSTwMcTEVEqClctlpKUG+p5rUwg+9SieXsGvGCuB
         +vfDW+0jihggrd8u7aKKuDAPK9GWIZ+twgvqLQlmZDQvUAVK4IGpuW2FajAH8rqqWTfH
         8mVHfSUOzVwqlb5tVybN8Qu+uEP9Gojs061hHc3FNWdhpkfUj/2/dRYoVaUlOXTKmBNx
         67+V1Y5O52DYjgTkMX+P7sunc7NgHf5uN1Koz4XUgpvX8/PdhIf+clf6nLt+RA4w9apu
         IZpHycg72wB/M+n9psgvGNL8vUK80/gCLnjJ1euIyfcDSVL4LZB3sx+xK/BMbXzzcE1y
         qxhA==
X-Gm-Message-State: AOJu0Yyp5MZreY3NNHikG4P9UmOQUCKVI8C09KO5OmikqkzZPBCfJPZP
	2wROZzK2eZ2mbXyoOy1m8wQczDjm3dzZF3IDN1v5NzP00uvf+xunrUM8XCTDtI1WoRlufdb67/0
	L
X-Google-Smtp-Source: AGHT+IGElWvfaNQKRdT19R8eHqH5EcN2+VR4CVjchlrwyULiHy5mljugdWZTTmCzmuTic0NiPUKOCw==
X-Received: by 2002:ac8:5a8d:0:b0:434:3acc:46d8 with SMTP id c13-20020ac85a8d000000b004343acc46d8mr6863806qtc.8.1713052422181;
        Sat, 13 Apr 2024 16:53:42 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84794000000b00434d7c4f9fasm4039806qtq.8.2024.04.13.16.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 08/19] btrfs: simplify delayed ref tracepoints
Date: Sat, 13 Apr 2024 19:53:18 -0400
Message-ID: <ecd41b71527519744c006919ded25a3d70d6b51d.1713052088.git.josef@toxicpanda.com>
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

Now that all of the delayed ref information is in the delayed ref node,
drastically simplify the delayed ref tracepoints by simply passing in
the btrfs_delayed_ref_node and populating the tracepoints with the
values from the structure itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c       | 14 ++--------
 fs/btrfs/extent-tree.c       |  4 +--
 include/trace/events/btrfs.h | 54 ++++++++++++++----------------------
 3 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 743cc52c30af..cc1510d7eee8 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1064,7 +1064,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_delayed_tree_ref *ref;
 	struct btrfs_delayed_ref_node *node;
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -1093,8 +1092,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ref = btrfs_delayed_node_to_tree_ref(node);
-
 	init_delayed_ref_common(fs_info, node, generic_ref);
 
 	init_delayed_ref_head(head_ref, generic_ref, record, 0);
@@ -1119,9 +1116,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_update_delayed_refs_rsv(trans);
 
-	trace_add_delayed_tree_ref(fs_info, node, ref,
-				   action == BTRFS_ADD_DELAYED_EXTENT ?
-				   BTRFS_ADD_DELAYED_REF : action);
+	trace_add_delayed_tree_ref(fs_info, node);
 	if (merged)
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
@@ -1139,7 +1134,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 			       u64 reserved)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_delayed_data_ref *ref;
 	struct btrfs_delayed_ref_node *node;
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -1153,8 +1147,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	if (!node)
 		return -ENOMEM;
 
-	ref = btrfs_delayed_node_to_data_ref(node);
-
 	init_delayed_ref_common(fs_info, node, generic_ref);
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
@@ -1195,9 +1187,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_update_delayed_refs_rsv(trans);
 
-	trace_add_delayed_data_ref(trans->fs_info, node, ref,
-				   action == BTRFS_ADD_DELAYED_EXTENT ?
-				   BTRFS_ADD_DELAYED_REF : action);
+	trace_add_delayed_data_ref(trans->fs_info, node);
 	if (merged)
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 275e3141dc1e..805e3e904368 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1574,7 +1574,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 flags = 0;
 
 	ref = btrfs_delayed_node_to_data_ref(node);
-	trace_run_delayed_data_ref(trans->fs_info, node, ref, node->action);
+	trace_run_delayed_data_ref(trans->fs_info, node);
 
 	if (node->type == BTRFS_SHARED_DATA_REF_KEY)
 		parent = ref->parent;
@@ -1737,7 +1737,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 ref_root = 0;
 
 	ref = btrfs_delayed_node_to_tree_ref(node);
-	trace_run_delayed_tree_ref(trans->fs_info, node, ref, node->action);
+	trace_run_delayed_tree_ref(trans->fs_info, node);
 
 	if (node->type == BTRFS_SHARED_BLOCK_REF_KEY)
 		parent = ref->parent;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 766cfd48386c..dae29f6d6b4c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -868,11 +868,9 @@ TRACE_EVENT(btrfs_add_block_group,
 DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_delayed_ref_node *ref,
-		 const struct btrfs_delayed_tree_ref *full_ref,
-		 int action),
+		 const struct btrfs_delayed_ref_node *ref),
 
-	TP_ARGS(fs_info, ref, full_ref, action),
+	TP_ARGS(fs_info, ref),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  bytenr		)
@@ -888,10 +886,10 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
 	TP_fast_assign_btrfs(fs_info,
 		__entry->bytenr		= ref->bytenr;
 		__entry->num_bytes	= ref->num_bytes;
-		__entry->action		= action;
-		__entry->parent		= full_ref->parent;
-		__entry->ref_root	= full_ref->root;
-		__entry->level		= full_ref->level;
+		__entry->action		= ref->action;
+		__entry->parent		= ref->tree_ref.parent;
+		__entry->ref_root	= ref->tree_ref.root;
+		__entry->level		= ref->tree_ref.level;
 		__entry->type		= ref->type;
 		__entry->seq		= ref->seq;
 	),
@@ -911,31 +909,25 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
 DEFINE_EVENT(btrfs_delayed_tree_ref,  add_delayed_tree_ref,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_delayed_ref_node *ref,
-		 const struct btrfs_delayed_tree_ref *full_ref,
-		 int action),
+		 const struct btrfs_delayed_ref_node *ref),
 
-	TP_ARGS(fs_info, ref, full_ref, action)
+	TP_ARGS(fs_info, ref)
 );
 
 DEFINE_EVENT(btrfs_delayed_tree_ref,  run_delayed_tree_ref,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_delayed_ref_node *ref,
-		 const struct btrfs_delayed_tree_ref *full_ref,
-		 int action),
+		 const struct btrfs_delayed_ref_node *ref),
 
-	TP_ARGS(fs_info, ref, full_ref, action)
+	TP_ARGS(fs_info, ref)
 );
 
 DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_delayed_ref_node *ref,
-		 const struct btrfs_delayed_data_ref *full_ref,
-		 int action),
+		 const struct btrfs_delayed_ref_node *ref),
 
-	TP_ARGS(fs_info, ref, full_ref, action),
+	TP_ARGS(fs_info, ref),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  bytenr		)
@@ -952,11 +944,11 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
 	TP_fast_assign_btrfs(fs_info,
 		__entry->bytenr		= ref->bytenr;
 		__entry->num_bytes	= ref->num_bytes;
-		__entry->action		= action;
-		__entry->parent		= full_ref->parent;
-		__entry->ref_root	= full_ref->root;
-		__entry->owner		= full_ref->objectid;
-		__entry->offset		= full_ref->offset;
+		__entry->action		= ref->action;
+		__entry->parent		= ref->data_ref.parent;
+		__entry->ref_root	= ref->data_ref.root;
+		__entry->owner		= ref->data_ref.objectid;
+		__entry->offset		= ref->data_ref.offset;
 		__entry->type		= ref->type;
 		__entry->seq		= ref->seq;
 	),
@@ -978,21 +970,17 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
 DEFINE_EVENT(btrfs_delayed_data_ref,  add_delayed_data_ref,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_delayed_ref_node *ref,
-		 const struct btrfs_delayed_data_ref *full_ref,
-		 int action),
+		 const struct btrfs_delayed_ref_node *ref),
 
-	TP_ARGS(fs_info, ref, full_ref, action)
+	TP_ARGS(fs_info, ref)
 );
 
 DEFINE_EVENT(btrfs_delayed_data_ref,  run_delayed_data_ref,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_delayed_ref_node *ref,
-		 const struct btrfs_delayed_data_ref *full_ref,
-		 int action),
+		 const struct btrfs_delayed_ref_node *ref),
 
-	TP_ARGS(fs_info, ref, full_ref, action)
+	TP_ARGS(fs_info, ref)
 );
 
 DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
-- 
2.43.0


