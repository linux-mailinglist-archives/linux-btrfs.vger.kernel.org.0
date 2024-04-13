Return-Path: <linux-btrfs+bounces-4222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A164F8A3FAC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF455B215B5
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755CD5A10F;
	Sat, 13 Apr 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NrZQAMBu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EC5A0E3
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052425; cv=none; b=BncBu/htWBfd98caeEC9Ujcph2HVVHXA6O2fRTK4ylqlloG91ncmmyw/UN+1UtAwk30xOpsLlipqlmYfk7XE7LhmCjkcXbQAgE8gxYAPngj3xTYLj2hCiNPwCNEWNdg1YbnS93RfKPzDiHCqxbYnAgkyM+krc/UbNXrLz+K515Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052425; c=relaxed/simple;
	bh=Sll4mir8PPjMk83mKbhXrm7vuyovjm2SKE3KzI2MiLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niPJAY4T1Qd5dFidysQSPC6G4bPpRwW3UIi0fb2RYT+l+znWOD8ol48EmwFpazu8lLFiR4WcmktogPAbDcdiyPW3g511HTQMyRqQgwffa1hmh2oycwxTY1vMl4/kjKvZWX0gKvUkDnTgFIDKwVtAOtX0d6t19YDdBz0I286Advk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NrZQAMBu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-696315c9da5so19392406d6.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052423; x=1713657223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4FsxyaAmeICSO+jO+OlKkSuJIBJEkIXIxk83EV5E2Y=;
        b=NrZQAMBuFIBlvUDEH9SmX1ckCpZo+gdu+O+EgTNskk/H4POET4iOuhkiHdah7vFtEq
         bODYH6kmkm4POOIbYeM0JSbzjiXluCoUhCkPijL9MTBEOFXeD3BGEM61WxrPPyOGFJ99
         kfg6bNHurFjKQdILYPAasKGaWZvGZTt65eqg5fFEd2cakgrEAUIRbyJ+hLDv1WUZloTO
         oiy3M7dm76xg5Z/dNUY1nE8MzjkGc9HKm0y8CFLhbtCrxTpZ4eapFCHvK9VRdQ24ngeR
         5R7Db4BI4yKM7zLPyYa3RnzXa68yIdOauzfw2YaKUYjN9edrGyEFHwWQG2QpXj1y1vrM
         aAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052423; x=1713657223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4FsxyaAmeICSO+jO+OlKkSuJIBJEkIXIxk83EV5E2Y=;
        b=i4zAzVbUtydiexl5rNo0/vA0h9YhiIIUJ7fh6y4LjS3KyZs4bSVf2/ZMsOqvNsS2DS
         QlxYKUvE7mgjbH/bM/MZb7yj9db4AEiet/x+baCDp+kpSr6g7xeEFufTbdBgEqWgDhCR
         Vj/ESL88sRise0cAu8u/zgjtopOOQCDxsXOxY28Fkfxvz4KpGwzt5AVOd9+bWcqb5WOh
         7o39kZR3hxV2Whu/jrG2rg/TSH0552ihVkixLrjw/PMmr1FhtR5dZS+cNre4a5FvuScP
         iRdVhY+tvsyqrwr+JhPavi8YvPoK7VCSgk52MD3/x+gnVvr7IiAtaS6YgzrucWwvuOxg
         TwPA==
X-Gm-Message-State: AOJu0YxLmXIuQljsM2LjBWeqMZWQJpU4jifpY0D4tWhKSvL+qzLWd26b
	+qjOsT2y5I2RUYifpinAsgqS4xquHABEhy+1M5VCu7hKVus2zk1SLQ9ThADsHk0MI1k2R+Ax9Yl
	V
X-Google-Smtp-Source: AGHT+IHmlbLT082StfirTre95wuRS1az42UmLoa7oTXpsHJsofj8oy6XgPc9Yy48zmza7/Vis20YNg==
X-Received: by 2002:ad4:4493:0:b0:69b:1f49:6f52 with SMTP id m19-20020ad44493000000b0069b1f496f52mr2391508qvt.51.1713052423196;
        Sat, 13 Apr 2024 16:53:43 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x9-20020a0ce789000000b0069b2064b988sm4244788qvn.131.2024.04.13.16.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 09/19] btrfs: unify the btrfs_add_delayed_*_ref helpers into one helper
Date: Sat, 13 Apr 2024 19:53:19 -0400
Message-ID: <5ed65a5c6829fb072e20a9e58897918ca4a21f3e.1713052088.git.josef@toxicpanda.com>
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

Now that these helpers are identical, create a helper function that
handles everything properly and strip the individual helpers down to use
just the common helper. This cleans up a significant amount of
duplicated code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 106 +++++++++++------------------------------
 1 file changed, 28 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index cc1510d7eee8..342f32ae08c9 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1054,14 +1054,10 @@ void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
 		generic_ref->skip_qgroup = false;
 }
 
-/*
- * add a delayed tree ref.  This does all of the accounting required
- * to make sure the delayed ref is eventually processed before this
- * transaction commits.
- */
-int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
-			       struct btrfs_ref *generic_ref,
-			       struct btrfs_delayed_extent_op *extent_op)
+static int __btrfs_add_delayed_ref(struct btrfs_trans_handle *trans,
+				   struct btrfs_ref *generic_ref,
+				   struct btrfs_delayed_extent_op *extent_op,
+				   u64 reserved)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_node *node;
@@ -1069,10 +1065,9 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
 	bool qrecord_inserted;
-	bool merged;
 	int action = generic_ref->action;
+	bool merged;
 
-	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
 	if (!node)
 		return -ENOMEM;
@@ -1087,14 +1082,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+			kmem_cache_free(btrfs_delayed_ref_head_cachep,
+					head_ref);
 			return -ENOMEM;
 		}
 	}
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
-
-	init_delayed_ref_head(head_ref, generic_ref, record, 0);
+	init_delayed_ref_head(head_ref, generic_ref, record, reserved);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1116,16 +1111,31 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_update_delayed_refs_rsv(trans);
 
-	trace_add_delayed_tree_ref(fs_info, node);
+	if (generic_ref->type == BTRFS_REF_DATA)
+		trace_add_delayed_data_ref(trans->fs_info, node);
+	else
+		trace_add_delayed_tree_ref(trans->fs_info, node);
 	if (merged)
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 	if (qrecord_inserted)
-		btrfs_qgroup_trace_extent_post(trans, record);
-
+		return btrfs_qgroup_trace_extent_post(trans, record);
 	return 0;
 }
 
+/*
+ * add a delayed tree ref.  This does all of the accounting required
+ * to make sure the delayed ref is eventually processed before this
+ * transaction commits.
+ */
+int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
+			       struct btrfs_ref *generic_ref,
+			       struct btrfs_delayed_extent_op *extent_op)
+{
+	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
+	return __btrfs_add_delayed_ref(trans, generic_ref, extent_op, 0);
+}
+
 /*
  * add a delayed data ref. it's similar to btrfs_add_delayed_tree_ref.
  */
@@ -1133,68 +1143,8 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_ref *generic_ref,
 			       u64 reserved)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_delayed_ref_node *node;
-	struct btrfs_delayed_ref_head *head_ref;
-	struct btrfs_delayed_ref_root *delayed_refs;
-	struct btrfs_qgroup_extent_record *record = NULL;
-	bool qrecord_inserted;
-	int action = generic_ref->action;
-	bool merged;
-
-	ASSERT(generic_ref->type == BTRFS_REF_DATA && action);
-	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
-	if (!node)
-		return -ENOMEM;
-
-	init_delayed_ref_common(fs_info, node, generic_ref);
-
-	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
-	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-		return -ENOMEM;
-	}
-
-	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
-		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record) {
-			kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep,
-					head_ref);
-			return -ENOMEM;
-		}
-	}
-
-	init_delayed_ref_head(head_ref, generic_ref, record, reserved);
-	head_ref->extent_op = NULL;
-
-	delayed_refs = &trans->transaction->delayed_refs;
-	spin_lock(&delayed_refs->lock);
-
-	/*
-	 * insert both the head node and the new ref without dropping
-	 * the spin lock
-	 */
-	head_ref = add_delayed_ref_head(trans, head_ref, record,
-					action, &qrecord_inserted);
-
-	merged = insert_delayed_ref(trans, head_ref, node);
-	spin_unlock(&delayed_refs->lock);
-
-	/*
-	 * Need to update the delayed_refs_rsv with any changes we may have
-	 * made.
-	 */
-	btrfs_update_delayed_refs_rsv(trans);
-
-	trace_add_delayed_data_ref(trans->fs_info, node);
-	if (merged)
-		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-
-
-	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(trans, record);
-	return 0;
+	ASSERT(generic_ref->type == BTRFS_REF_DATA && generic_ref->action);
+	return __btrfs_add_delayed_ref(trans, generic_ref, NULL, reserved);
 }
 
 int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
-- 
2.43.0


