Return-Path: <linux-btrfs+bounces-5299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D908CFDF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 12:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD8A1F23554
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94EB13AD11;
	Mon, 27 May 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChtZfqLL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80126DF60
	for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804822; cv=none; b=dzU2yAupg7E8vGVLrAJTxWPXGBW1FD3J8nyxUMLoOWIM2ZURJurf4PrFt2Lo/ydCIC1RtyHzYI1lPP5VvVfVsgO8axpA+3xd1CIHTYqPxc06bFO1KgOFZSeUwJViv1cXfvtjJDl2HGbdmfWvIoPK+sjh38V4xSR3D84sNXvH2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804822; c=relaxed/simple;
	bh=RDFpLY8NZvqSvtoS85Qy+RUwe0x0RUHHNCugUhfcR4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uiL7i7tMTkeLf7LkanAZ+YBLgVTM8Si3SLlUOGaw1KpYYs/tDnBznJZLpjyRIEPDsHMdMxRJqWkdIGY8pUflwMm4Hy3eA35SbdIn7ei+2g2+WfdjnORh+6CI9j7HSO5rSBLoH9K2Xl8tR+qvnNHnLoIH0+i9Wpsj1o/eSDJSgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChtZfqLL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b594deeso21218695ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716804820; x=1717409620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w65MpEET4WU+ez5lYKEWiut0ySsVSFNs9rwkNWR4Rs=;
        b=ChtZfqLLp4tfbylFXdE/LZbQDV4+uxFB78AM0dw3KzfFOG+Mrscmmy+HSr/G0qLYDQ
         eELQjhIwmXOvNmW3X3/sSt/oGr/5rKJ+RyI0JFvrX7ybO3JSMTCUnQR/Nw2BOrkSi/JA
         YWdOa+7cPNqALa0Khh1RvrBE31Wo0LsUa4+RNrBp1srKcYINxA2lYIYh8tXREu4fJeTp
         2dAcuQ5iypDke26IzD5Y94GX/joiNikJbEBjZSywFCIm9vkq6x39J5Zatu6PWW0IC5xz
         onrA9P8B1Az+Bh8o2+ocrCsqZriAULVchTGqQaBcD96hcxP8wg+sIo9jDYP8mSQ2g0gp
         Yyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804820; x=1717409620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w65MpEET4WU+ez5lYKEWiut0ySsVSFNs9rwkNWR4Rs=;
        b=Q2FmumQawhcag7KctGBC4Jwc/hSlK2Xb/o5Ih7RX07YNxwT7wP6os6kSYn8jEeb3sA
         81C9ynIHI1kgPxkGVDrB0VHRNhPvPxwTXm2/ZSRlxl/mQ7CtRmGI+ObjuNmjI/N/Xpsb
         NyszpHS0ABc+PfWPY//MP6do3MT8mDUdSLFZVGMK7XrTcsX2ySFJxoqiDcV/MYdJhxXJ
         5DiF/lF4eBl2GsL8XcC/PK6H8NGZNG61wWv2z+4dLOclGfJXvDPDePR+oRj+biqYUogZ
         IfwQMRqF1vgSzB0EaXfXGS8eF/sTLxbrnmylJRKQ8VBrLqUeDshrKfj3F/tsWMKx78xJ
         lR0A==
X-Gm-Message-State: AOJu0YwaR2rRulmt6Mx8AAObC0CEHu3bRLlJWNfEg3zqph/AFI212RSM
	aiXfrG1kW1jfT5B3N3wzRMIYdNDeYrVB9paZZ0WSD/UC79Kf4H+MgT2VChD4
X-Google-Smtp-Source: AGHT+IGhF9rO2afr7Q0cvQtSDSYeVSCn/OepoXO6rBL8uogyEpcmhFmUQ+E1tXo+rmx2aTc3+DHQag==
X-Received: by 2002:a17:902:ea0f:b0:1f4:6ef9:53a4 with SMTP id d9443c01a7336-1f46ef9590fmr52223865ad.22.1716804820166;
        Mon, 27 May 2024 03:13:40 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9dbdefsm58792815ad.297.2024.05.27.03.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:13:39 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] btrfs: qgroup: use kmem cache to alloc struct btrfs_qgroup_extent_record
Date: Mon, 27 May 2024 18:13:34 +0800
Message-Id: <20240527101334.207228-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a todo in qgroup code by utilizing kmem cache to accelerate
the allocation of struct btrfs_qgroup_extent_record.

This patch has passed the check -g qgroup tests using xfstests.

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/delayed-ref.c |  6 +++---
 fs/btrfs/qgroup.c      | 21 ++++++++++++++++++---
 fs/btrfs/qgroup.h      |  6 +++++-
 fs/btrfs/super.c       |  3 +++
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e44e62cf76bc..d2d6bda6ccf7 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -916,7 +916,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	if (qrecord) {
 		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
 					delayed_refs, qrecord))
-			kfree(qrecord);
+			kmem_cache_free(btrfs_qgroup_extent_record_cachep, qrecord);
 		else
 			qrecord_inserted = true;
 	}
@@ -1088,7 +1088,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	}
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
-		record = kzalloc(sizeof(*record), GFP_NOFS);
+		record = kmem_cache_zalloc(btrfs_qgroup_extent_record_cachep, GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
 			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
@@ -1191,7 +1191,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	}
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
-		record = kzalloc(sizeof(*record), GFP_NOFS);
+		record = kmem_cache_zalloc(btrfs_qgroup_extent_record_cachep, GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
 			kmem_cache_free(btrfs_delayed_ref_head_cachep,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 40e5f7f2fcb7..5f72909bfcf2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -30,6 +30,7 @@
 #include "root-tree.h"
 #include "tree-checker.h"
 
+struct kmem_cache *btrfs_qgroup_extent_record_cachep;
 enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
 {
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
@@ -2024,7 +2025,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 
 	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr == 0 || num_bytes == 0)
 		return 0;
-	record = kzalloc(sizeof(*record), GFP_NOFS);
+	record = kmem_cache_zalloc(btrfs_qgroup_extent_record_cachep, GFP_NOFS);
 	if (!record)
 		return -ENOMEM;
 
@@ -2985,7 +2986,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		ulist_free(new_roots);
 		new_roots = NULL;
 		rb_erase(node, &delayed_refs->dirty_extent_root);
-		kfree(record);
+		kmem_cache_free(btrfs_qgroup_extent_record_cachep, record);
 
 	}
 	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
@@ -4783,7 +4784,7 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 	root = &trans->delayed_refs.dirty_extent_root;
 	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
 		ulist_free(entry->old_roots);
-		kfree(entry);
+		kmem_cache_free(btrfs_qgroup_extent_record_cachep, entry);
 	}
 	*root = RB_ROOT;
 }
@@ -4845,3 +4846,17 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->qgroup_lock);
 	return ret;
 }
+
+void __cold btrfs_qgroup_exit(void)
+{
+	kmem_cache_destroy(btrfs_qgroup_extent_record_cachep);
+}
+
+int __init btrfs_qgroup_init(void)
+{
+	btrfs_qgroup_extent_record_cachep = KMEM_CACHE(btrfs_qgroup_extent_record, 0);
+	if (!btrfs_qgroup_extent_record_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
\ No newline at end of file
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 706640be0ec2..3975c32ac23e 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -123,7 +123,6 @@ struct btrfs_inode;
 
 /*
  * Record a dirty extent, and info qgroup to update quota on it
- * TODO: Use kmem cache to alloc it.
  */
 struct btrfs_qgroup_extent_record {
 	struct rb_node node;
@@ -312,6 +311,11 @@ enum btrfs_qgroup_mode {
 	BTRFS_QGROUP_MODE_SIMPLE
 };
 
+extern struct kmem_cache *btrfs_qgroup_extent_record_cachep;
+
+void __cold btrfs_qgroup_exit(void);
+int __init btrfs_qgroup_init(void);
+
 enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
 bool btrfs_qgroup_enabled(struct btrfs_fs_info *fs_info);
 bool btrfs_qgroup_full_accounting(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e44ccaf348f..0fe383ef816b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2506,6 +2506,9 @@ static const struct init_sequence mod_init_seq[] = {
 	}, {
 		.init_func = btrfs_delayed_ref_init,
 		.exit_func = btrfs_delayed_ref_exit,
+	}, {
+		.init_func = btrfs_qgroup_init,
+		.exit_func = btrfs_qgroup_exit,
 	}, {
 		.init_func = btrfs_prelim_ref_init,
 		.exit_func = btrfs_prelim_ref_exit,
-- 
2.39.2


