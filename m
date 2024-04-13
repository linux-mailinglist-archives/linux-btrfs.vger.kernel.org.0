Return-Path: <linux-btrfs+bounces-4220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11578A3FAA
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19391C20A58
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5A5A0EB;
	Sat, 13 Apr 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i+nqMPnq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20B59178
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052423; cv=none; b=tsekTr3tTa1YbjWsf9dFtaCRDS7hp6pxCqfy1O+jpNpLXU63OG8iNLUu9ypDCt27/tHTJ7GcBDkoq+m3s9k98VDM83dcLaQL1dN/AeBLvGej+m3WyrWi7HTZOE1sFDbdP3m8ftHe12ctNl/UxvMyvwi7uC0lUcDD0RuGTUZseUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052423; c=relaxed/simple;
	bh=uBancIRSSwQI/hh/jJJ01K1609rIXga/KI1+HNroFyM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFDvlO0/RRfQewAwaaU/yfwikoIeUrVeopeccqObko+woyxo8mm8N1oDq/+c271FPmPNL+98tbizrlijAnSKzCY0c16s8XaT08CCQs975usUjz+MYow0T1Dlc6nEXsRBnRmjmJQOpW3lkiq++27M1fJNqjgHPfKIex3GUML5yD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i+nqMPnq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4347bcc2b47so10580621cf.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052421; x=1713657221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Vw+WnRF1oRv31T3X2HyPFGT+/fizoHQfuaj7ziNRmI=;
        b=i+nqMPnqGD3xx70OSBvaT1wGOKsSNMMcti2cHmkHKEAoVZJ8w7tS/Q+5SyPx3Dc69x
         HFN54dNXYwtX5W1YJgbxnHRDPC1vkzTPzWt38TTQZdXHx5FNLeoey5H1S8mbleI88L3O
         qDDuBsZc4t85bJQyhf638AyiOG4hfznrxeZf7i1tUIh3EdVeqEsNn8gCau5z7rLPlrmR
         eQtw5Tw3yFaOH8a/KBOMrh91tesrjnwZIsiT0OkoKuGZYkiUxlopYL78/46Dpl0nqdpi
         0vwzb79bQ5DFgeE6Z43ij2/+IILS8dlYtKxrSIIoFB6LdTe0zq/jJVM/n4dD3/8/B8AW
         VA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052421; x=1713657221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vw+WnRF1oRv31T3X2HyPFGT+/fizoHQfuaj7ziNRmI=;
        b=WqzSEPR9JiMiH/VATMS+/DFnLPYvq75eOVpEL0N4PkiMHKuGmOd9jwo6QjZPfY9xIb
         zXB7A/Jls4zvrqgNFrO3v1jB+0GLgbYwq/zbyT/2o3u6XkB6UGwSj+cJ5kUe3u84BRIp
         b2BAWnR4TvAQvxrqGRAJf/ST5UU9GpFjh9SUkIXRoaCsxSp2fQrUiIUoNPiHNQdcB78u
         s05rVIncjQG4WSoONoklVJ5vd1xJ2+oE+IYahqK3aIqIwGq2sjetnJWkMvc9jPX6B8zp
         8+RxIwsHpsckRJFMkOG749jjPyo08mawpotNq55EJa6ZkqM3qqRVAexbRfNN44XOL38o
         yckA==
X-Gm-Message-State: AOJu0YxF7IAGJNlwOBG2TF0N2SkSCTgtbjTLcppRmOrhkBmU2OJ+UbDq
	vAZqjFrXNCDVGm+iA817QyInydKlqxnZIqGV0qMf/rebOECQi2x8Ooddy+V1xo/g0v84PZqsyBI
	E
X-Google-Smtp-Source: AGHT+IHRlQsIxwcpV8IxxtuDPqe2q4UmNAT8NXqDeCARq3Tby6BtUVRDr5DsNLs7wWt35viyb9Y6nQ==
X-Received: by 2002:a05:622a:92:b0:434:c5f7:effe with SMTP id o18-20020a05622a009200b00434c5f7effemr6333656qtw.68.1713052421246;
        Sat, 13 Apr 2024 16:53:41 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h11-20020ac8514b000000b00432bd953506sm4057634qtn.84.2024.04.13.16.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 07/19] btrfs: move ref specific initialization into init_delayed_ref_common
Date: Sat, 13 Apr 2024 19:53:17 -0400
Message-ID: <5b5efef95b6aeed43f99e156d8bbf55f5f9254c4.1713052088.git.josef@toxicpanda.com>
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

Now that the btrfs_delayed_ref_node contains a union of the data and
metadata specific information we can move the initialization into
init_delayed_ref_common and just use the btrfs_ref to initialize the
correct fields of the reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 5ff6c109e5bf..743cc52c30af 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1007,6 +1007,17 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	ref->type = btrfs_ref_type(generic_ref);
 	RB_CLEAR_NODE(&ref->ref_node);
 	INIT_LIST_HEAD(&ref->add_list);
+
+	if (generic_ref->type == BTRFS_REF_DATA) {
+		ref->data_ref.root = generic_ref->ref_root;
+		ref->data_ref.parent = generic_ref->parent;
+		ref->data_ref.objectid = generic_ref->data_ref.ino;
+		ref->data_ref.offset = generic_ref->data_ref.offset;
+	} else {
+		ref->tree_ref.root = generic_ref->ref_root;
+		ref->tree_ref.parent = generic_ref->parent;
+		ref->tree_ref.level = generic_ref->tree_ref.level;
+	}
 }
 
 void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
@@ -1061,8 +1072,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	bool qrecord_inserted;
 	bool merged;
 	int action = generic_ref->action;
-	int level = generic_ref->tree_ref.level;
-	u64 parent = generic_ref->parent;
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
@@ -1087,9 +1096,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	ref = btrfs_delayed_node_to_tree_ref(node);
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
-	ref->root = generic_ref->ref_root;
-	ref->parent = parent;
-	ref->level = level;
 
 	init_delayed_ref_head(head_ref, generic_ref, record, 0);
 	head_ref->extent_op = extent_op;
@@ -1141,10 +1147,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	bool qrecord_inserted;
 	int action = generic_ref->action;
 	bool merged;
-	u64 parent = generic_ref->parent;
-	u64 ref_root = generic_ref->ref_root;
-	u64 owner = generic_ref->data_ref.ino;
-	u64 offset = generic_ref->data_ref.offset;
 
 	ASSERT(generic_ref->type == BTRFS_REF_DATA && action);
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
@@ -1154,11 +1156,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	ref = btrfs_delayed_node_to_data_ref(node);
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
-	ref->root = ref_root;
-	ref->parent = parent;
-	ref->objectid = owner;
-	ref->offset = offset;
-
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
 	if (!head_ref) {
-- 
2.43.0


