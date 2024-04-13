Return-Path: <linux-btrfs+bounces-4219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD658A3FA9
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3165A1F21796
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B859B77;
	Sat, 13 Apr 2024 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0FgOUGfP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD459147
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052422; cv=none; b=eiiBIEdboNH+NKsBz8QhlNq/+nVTGCxsuLGzFZuJIL+C64BVV1NjcE1yUKDqmDvrXep26E1zBQoTs+22eF3edG07/IO1/1YECNCLTPYrin9JwSTv59Mfj73WVod3qvKmYbPIEItJPNKizHhg3scloDusxFS8j+ZNkG4UzwINQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052422; c=relaxed/simple;
	bh=YjrD5PkeJ45rgZh1SN7fQTgcUzq/FFuxiqWayF3JZqQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMidFCpPLomAC87cCxOudyHD180a7botsN0apMvjC402XQYLesZP1gsXXY6cP69gW4zajPiwAcM/LGe4pQU6fYYFn6L5I0FHe5uie5+29/Y2Ma2eum59PstHQI5duCj6HvsscEe67QKDvsDbwYgcywiTV/oX4++PW4DFgPqCUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0FgOUGfP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78d555254b7so166496985a.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052420; x=1713657220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouxCsSpgl8wuGmXe0dZv4cQ22mK0vZG+KMUhRQhr1WM=;
        b=0FgOUGfPEMU7TDuhKDRkThmqxw7gL3vlnvroKgw2YJXyG/ElVcL/xthwEYZnWChnhu
         rhLCdIMt0kYJhY6tXPkWL5rXyCnVb7PojqMixyY4R7C8WGwRbpJ7+32TCYgkFTw68YFN
         +mIjHqeDJJxiivVnhwdS10Ap5rCnhci24Zyiv1ZR2ZSvXl2z0fbAYX0l0O43n8wRC8++
         3RLM9WixdQJi+k5i+4VtaaK6dL2rKrCNnF3/kZDM6Cg5wFEeUMCjBXDt8A6IQ24WgMyH
         QT5/fvmkg9ibE1dYySkoX7IsjRT5Pb8+GhYrct+h7wZKqhyKRRkm9DSqCmyPBBeza2Zu
         YFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052420; x=1713657220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouxCsSpgl8wuGmXe0dZv4cQ22mK0vZG+KMUhRQhr1WM=;
        b=csElUFACAr0dIgg1BV2h9T6OmGr43brwS0Ccc2fPTk6Rum1hriD3ct+Zi5NkK7BMOm
         VoV8QfEmEb9f+YVAsF1RpKVF6KjCVT+mSB2yLsvIi2KW7jBtpRDgVqtGW7D50+XAqoJS
         SkyWncGfbu+V0dwkW9rQgGBVpfpbdqxlJRS/xYpyC+lJR8sVAYaPoZLkvF2L8lRRswh8
         6XS7NrPJ25m68lgleWUzFtY3dyesVFMhBMQR9S68L+vZ+kVavZNp8/F7y3xFU12VMqH0
         N7bE+tVbuxeUViMVYdX+NEwOrHUB9AqXU+PiEpySCuwVsIVjS91pdzuCeNp4hRCEXxpy
         tWJg==
X-Gm-Message-State: AOJu0Yyyc0sTqJrl7v7fE893itLrNhwMI+iJa4PhTJGpKbFsrVaQEqlg
	BOgxWFgZ8VYq/SvUmMDE4EBEOR2AAY8gVz7L6ZWtDa3zNRWOwB+0JVwbEd736fDn8llvq86qru2
	7
X-Google-Smtp-Source: AGHT+IEZoPLhWKwiGcDytzVe2EonQB/T/cs8FwjJCYKr6FuGPXmpKy80b7a8vmJNxrbPmZa+Bezr9w==
X-Received: by 2002:a05:620a:2697:b0:78e:bd94:723e with SMTP id c23-20020a05620a269700b0078ebd94723emr16020375qkp.34.1713052420241;
        Sat, 13 Apr 2024 16:53:40 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b0078ede2e9125sm506103qkl.57.2024.04.13.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 06/19] btrfs: initialize btrfs_delayed_ref_head with btrfs_ref
Date: Sat, 13 Apr 2024 19:53:16 -0400
Message-ID: <d5794f417b276985e21c50cbfeb8a4230bf492d5.1713052088.git.josef@toxicpanda.com>
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

We are calling init_delayed_ref_head with all of the elements from
btrfs_ref, clean this up to simply pass in the btrfs_ref and initialize
the btrfs_delayed_ref_head with the values from the btrfs_ref directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 53 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f5e4a64283e4..5ff6c109e5bf 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -831,18 +831,20 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 }
 
 static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
+				  struct btrfs_ref *generic_ref,
 				  struct btrfs_qgroup_extent_record *qrecord,
-				  u64 bytenr, u64 num_bytes, u64 ref_root,
-				  u64 reserved, int action, bool is_data,
-				  bool is_system, u64 owning_root)
+				  u64 reserved)
 {
 	int count_mod = 1;
 	bool must_insert_reserved = false;
 
 	/* If reserved is provided, it must be a data extent. */
-	BUG_ON(!is_data && reserved);
+	BUG_ON(generic_ref->type != BTRFS_REF_DATA && reserved);
 
-	switch (action) {
+	switch (generic_ref->action) {
+	case BTRFS_ADD_DELAYED_REF:
+		/* count_mod is already set to 1. */
+		break;
 	case BTRFS_UPDATE_DELAYED_HEAD:
 		count_mod = 0;
 		break;
@@ -871,14 +873,14 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	}
 
 	refcount_set(&head_ref->refs, 1);
-	head_ref->bytenr = bytenr;
-	head_ref->num_bytes = num_bytes;
+	head_ref->bytenr = generic_ref->bytenr;
+	head_ref->num_bytes = generic_ref->len;
 	head_ref->ref_mod = count_mod;
 	head_ref->reserved_bytes = reserved;
 	head_ref->must_insert_reserved = must_insert_reserved;
-	head_ref->owning_root = owning_root;
-	head_ref->is_data = is_data;
-	head_ref->is_system = is_system;
+	head_ref->owning_root = generic_ref->owning_root;
+	head_ref->is_data = (generic_ref->type == BTRFS_REF_DATA);
+	head_ref->is_system = (generic_ref->ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 	head_ref->ref_tree = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&head_ref->ref_add_list);
 	RB_CLEAR_NODE(&head_ref->href_node);
@@ -888,12 +890,12 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	mutex_init(&head_ref->mutex);
 
 	if (qrecord) {
-		if (ref_root && reserved) {
+		if (generic_ref->ref_root && reserved) {
 			qrecord->data_rsv = reserved;
-			qrecord->data_rsv_refroot = ref_root;
+			qrecord->data_rsv_refroot = generic_ref->ref_root;
 		}
-		qrecord->bytenr = bytenr;
-		qrecord->num_bytes = num_bytes;
+		qrecord->bytenr = generic_ref->bytenr;
+		qrecord->num_bytes = generic_ref->len;
 		qrecord->old_roots = NULL;
 	}
 }
@@ -1057,16 +1059,11 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
 	bool qrecord_inserted;
-	bool is_system;
 	bool merged;
 	int action = generic_ref->action;
 	int level = generic_ref->tree_ref.level;
-	u64 bytenr = generic_ref->bytenr;
-	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
 
-	is_system = (generic_ref->ref_root == BTRFS_CHUNK_TREE_OBJECTID);
-
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
 	if (!node)
@@ -1094,9 +1091,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	ref->parent = parent;
 	ref->level = level;
 
-	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
-			      generic_ref->ref_root, 0, action,
-			      false, is_system, generic_ref->owning_root);
+	init_delayed_ref_head(head_ref, generic_ref, record, 0);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1146,8 +1141,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	bool qrecord_inserted;
 	int action = generic_ref->action;
 	bool merged;
-	u64 bytenr = generic_ref->bytenr;
-	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
 	u64 ref_root = generic_ref->ref_root;
 	u64 owner = generic_ref->data_ref.ino;
@@ -1183,8 +1176,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
-			      reserved, action, true, false, generic_ref->owning_root);
+	init_delayed_ref_head(head_ref, generic_ref, record, reserved);
 	head_ref->extent_op = NULL;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1224,13 +1216,18 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_ref generic_ref = {
+		.type = BTRFS_REF_METADATA,
+		.action = BTRFS_UPDATE_DELAYED_HEAD,
+		.bytenr = bytenr,
+		.len = num_bytes,
+	};
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
 	if (!head_ref)
 		return -ENOMEM;
 
-	init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
-			      BTRFS_UPDATE_DELAYED_HEAD, false, false, 0);
+	init_delayed_ref_head(head_ref, &generic_ref, NULL, 0);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
-- 
2.43.0


