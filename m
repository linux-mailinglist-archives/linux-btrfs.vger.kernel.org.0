Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013456E8335
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDSVOn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjDSVOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:14 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E98A46
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id js7so1038400qvb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938851; x=1684530851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+WPaH+BJdDVExYFVFvljS9QVfX7dpOxEOOc15sE7t4=;
        b=bXuoHvj2OI4ej26oQlqlT7KfPiuHYrCeccGbnRo2L6ew3vha7RUpITirGlxtcM9fnS
         xIwXxDf8mYBJyvzs1627pYvmTAw5ANFC/qvKarFpaK2R/BFbefJ/c4dkRcloWLfFNuNm
         efvEnSQMYAsrXjRfpAuedfuU/SfcG6BAekb3f6cLucyOur36OIBXv7WGYtFRjctZFMc3
         OIVvVCL99bTsYBD0VeL/jILkdG5AWnf375w7CQmjsZjBX4Ha+aLasDaD2BlH+HH4QV/2
         q1PIUToy7gKRszgClEMRz4p9sFFxqGrp4XUSU+ygIJhXi+t3Us6lXjRapDETKWoh/kWa
         sS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938851; x=1684530851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+WPaH+BJdDVExYFVFvljS9QVfX7dpOxEOOc15sE7t4=;
        b=GpSI33cL8+26ImL8uGJNWyZ62kRSYTVdF1toKutS5xKAxtTvXXs5gwgEduR790j7iU
         GXM66YK2SaFHiXJwAqqNnq0R2KseuyozGko45gG0z6WLRncbqOlIrPcjVaRFK5puB7BM
         MYv125DSV3L57QrxXQhJeXn2pwioM7EVHvQDe3EziFbyQg1MErvXy1bsNX/y3HioKaRQ
         XgfsOXai0DfxGK0pJll754rC60lhlTq3+Xr01OcIZRtoNQ6gN+z3ROvPBCyfIOrzMyoR
         RpV9e33o6dxoMrYsr3qNnQtE5AbNhGEryBH7OgTKVe/WpMJQIC5/ZE0JQc1Mil1MVCWE
         BNYA==
X-Gm-Message-State: AAQBX9f6fShxvYZOjepzUTraMz1h3TYgFG+Qkh4W9htyzvybT30o/+Wl
        TYDQiCZzhm3Vcs47dtAQLh4cFCVoY9hdo/LNvgQYZw==
X-Google-Smtp-Source: AKy350a1nI8TQlqODqy3sD82H1BQ5GQEElwKA6N9VZQRMmG34cZ1KJqTHYJWsK3FAWULZTa4PQoWsA==
X-Received: by 2002:a05:6214:76a:b0:5ab:e259:b2a9 with SMTP id f10-20020a056214076a00b005abe259b2a9mr3799238qvz.14.1681938850565;
        Wed, 19 Apr 2023 14:14:10 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cff0a000000b005e45f6cb74bsm4581921qvt.79.2023.04.19.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/11] btrfs-progs: rename the qgroup structs to match the kernel
Date:   Wed, 19 Apr 2023 17:13:50 -0400
Message-Id: <51b703790d273fe3104a5ae1920836b942310b1a.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the libbtrfs stuff has it's own local copy of ctree.h and
ioctl.h, let's rename these qgroup struct members to match the kernel
names, this way it'll make it easier to sync the kernel code into
btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c      | 16 ++++----
 cmds/qgroup.c              | 20 ++++------
 kernel-shared/ctree.h      | 80 +++++++++++++++++++-------------------
 kernel-shared/print-tree.c | 18 ++++-----
 4 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 3d7b9ddf..db49e3c9 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -870,12 +870,12 @@ static struct qgroup_count *alloc_count(struct btrfs_disk_key *key,
 		c->key = *key;
 
 		item = &c->diskinfo;
-		item->referenced = btrfs_qgroup_info_referenced(leaf, disk);
+		item->referenced = btrfs_qgroup_info_rfer(leaf, disk);
 		item->referenced_compressed =
-			btrfs_qgroup_info_referenced_compressed(leaf, disk);
-		item->exclusive = btrfs_qgroup_info_exclusive(leaf, disk);
+			btrfs_qgroup_info_rfer_cmpr(leaf, disk);
+		item->exclusive = btrfs_qgroup_info_excl(leaf, disk);
 		item->exclusive_compressed =
-			btrfs_qgroup_info_exclusive_compressed(leaf, disk);
+			btrfs_qgroup_info_excl_cmpr(leaf, disk);
 		INIT_LIST_HEAD(&c->groups);
 		INIT_LIST_HEAD(&c->members);
 		INIT_LIST_HEAD(&c->bad_list);
@@ -1594,14 +1594,14 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	btrfs_set_qgroup_info_generation(path.nodes[0], info_item,
 					 trans->transid);
 
-	btrfs_set_qgroup_info_referenced(path.nodes[0], info_item,
+	btrfs_set_qgroup_info_rfer(path.nodes[0], info_item,
 					 count->info.referenced);
-	btrfs_set_qgroup_info_referenced_compressed(path.nodes[0], info_item,
+	btrfs_set_qgroup_info_rfer_cmpr(path.nodes[0], info_item,
 					    count->info.referenced_compressed);
 
-	btrfs_set_qgroup_info_exclusive(path.nodes[0], info_item,
+	btrfs_set_qgroup_info_excl(path.nodes[0], info_item,
 					count->info.exclusive);
-	btrfs_set_qgroup_info_exclusive_compressed(path.nodes[0], info_item,
+	btrfs_set_qgroup_info_excl_cmpr(path.nodes[0], info_item,
 					   count->info.exclusive_compressed);
 
 	btrfs_mark_buffer_dirty(path.nodes[0]);
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 125362b8..ab4e9ecf 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -807,12 +807,11 @@ static int update_qgroup_info(int fd, struct qgroup_lookup *qgroup_lookup, u64 q
 		return PTR_ERR(bq);
 
 	bq->info.generation = btrfs_stack_qgroup_info_generation(info);
-	bq->info.referenced = btrfs_stack_qgroup_info_referenced(info);
+	bq->info.referenced = btrfs_stack_qgroup_info_rfer(info);
 	bq->info.referenced_compressed =
-			btrfs_stack_qgroup_info_referenced_compressed(info);
-	bq->info.exclusive = btrfs_stack_qgroup_info_exclusive(info);
-	bq->info.exclusive_compressed =
-			btrfs_stack_qgroup_info_exclusive_compressed(info);
+		btrfs_stack_qgroup_info_rfer_cmpr(info);
+	bq->info.exclusive = btrfs_stack_qgroup_info_excl(info);
+	bq->info.exclusive_compressed = btrfs_stack_qgroup_info_excl_cmpr(info);
 
 	return 0;
 }
@@ -828,13 +827,10 @@ static int update_qgroup_limit(int fd, struct qgroup_lookup *qgroup_lookup,
 		return PTR_ERR(bq);
 
 	bq->limit.flags = btrfs_stack_qgroup_limit_flags(limit);
-	bq->limit.max_referenced =
-			btrfs_stack_qgroup_limit_max_referenced(limit);
-	bq->limit.max_exclusive =
-			btrfs_stack_qgroup_limit_max_exclusive(limit);
-	bq->limit.rsv_referenced =
-			btrfs_stack_qgroup_limit_rsv_referenced(limit);
-	bq->limit.rsv_exclusive = btrfs_stack_qgroup_limit_rsv_exclusive(limit);
+	bq->limit.max_referenced = btrfs_stack_qgroup_limit_max_rfer(limit);
+	bq->limit.max_exclusive = btrfs_stack_qgroup_limit_max_excl(limit);
+	bq->limit.rsv_referenced = btrfs_stack_qgroup_limit_rsv_rfer(limit);
+	bq->limit.rsv_exclusive = btrfs_stack_qgroup_limit_rsv_excl(limit);
 
 	return 0;
 }
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 93e1850c..df7526d4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1103,10 +1103,10 @@ struct btrfs_free_space_info {
 
 struct btrfs_qgroup_info_item {
 	__le64 generation;
-	__le64 referenced;
-	__le64 referenced_compressed;
-	__le64 exclusive;
-	__le64 exclusive_compressed;
+	__le64 rfer;
+	__le64 rfer_cmpr;
+	__le64 excl;
+	__le64 excl_cmpr;
 } __attribute__ ((__packed__));
 
 /* flags definition for qgroup limits */
@@ -1119,10 +1119,10 @@ struct btrfs_qgroup_info_item {
 
 struct btrfs_qgroup_limit_item {
 	__le64 flags;
-	__le64 max_referenced;
-	__le64 max_exclusive;
-	__le64 rsv_referenced;
-	__le64 rsv_exclusive;
+	__le64 max_rfer;
+	__le64 max_excl;
+	__le64 rsv_rfer;
+	__le64 rsv_excl;
 } __attribute__ ((__packed__));
 
 struct btrfs_space_info {
@@ -2466,48 +2466,48 @@ BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_rescan,
 /* btrfs_qgroup_info_item */
 BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
 		   generation, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_referenced, struct btrfs_qgroup_info_item,
-		   referenced, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_referenced_compressed,
-		   struct btrfs_qgroup_info_item, referenced_compressed, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_exclusive, struct btrfs_qgroup_info_item,
-		   exclusive, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_exclusive_compressed,
-		   struct btrfs_qgroup_info_item, exclusive_compressed, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_rfer, struct btrfs_qgroup_info_item,
+		   rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_rfer_cmpr,
+		   struct btrfs_qgroup_info_item, rfer_cmpr, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_excl, struct btrfs_qgroup_info_item,
+		   excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_excl_cmpr,
+		   struct btrfs_qgroup_info_item, excl_cmpr, 64);
 
 BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_generation,
 			 struct btrfs_qgroup_info_item, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_referenced,
-			 struct btrfs_qgroup_info_item, referenced, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_referenced_compressed,
-		   struct btrfs_qgroup_info_item, referenced_compressed, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_exclusive,
-			 struct btrfs_qgroup_info_item, exclusive, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_exclusive_compressed,
-		   struct btrfs_qgroup_info_item, exclusive_compressed, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer,
+			 struct btrfs_qgroup_info_item, rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer_cmpr,
+		   struct btrfs_qgroup_info_item, rfer_cmpr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl,
+			 struct btrfs_qgroup_info_item, excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl_cmpr,
+		   struct btrfs_qgroup_info_item, excl_cmpr, 64);
 
 /* btrfs_qgroup_limit_item */
 BTRFS_SETGET_FUNCS(qgroup_limit_flags, struct btrfs_qgroup_limit_item,
 		   flags, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_max_referenced, struct btrfs_qgroup_limit_item,
-		   max_referenced, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_max_exclusive, struct btrfs_qgroup_limit_item,
-		   max_exclusive, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_rsv_referenced, struct btrfs_qgroup_limit_item,
-		   rsv_referenced, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_rsv_exclusive, struct btrfs_qgroup_limit_item,
-		   rsv_exclusive, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_rfer, struct btrfs_qgroup_limit_item,
+		   max_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_excl, struct btrfs_qgroup_limit_item,
+		   max_excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_rfer, struct btrfs_qgroup_limit_item,
+		   rsv_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_excl, struct btrfs_qgroup_limit_item,
+		   rsv_excl, 64);
 
 BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_flags,
 			 struct btrfs_qgroup_limit_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_referenced,
-			 struct btrfs_qgroup_limit_item, max_referenced, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_exclusive,
-			 struct btrfs_qgroup_limit_item, max_exclusive, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_referenced,
-			 struct btrfs_qgroup_limit_item, rsv_referenced, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_exclusive,
-			 struct btrfs_qgroup_limit_item, rsv_exclusive, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_rfer,
+			 struct btrfs_qgroup_limit_item, max_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_excl,
+			 struct btrfs_qgroup_limit_item, max_excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_rfer,
+			 struct btrfs_qgroup_limit_item, rsv_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_excl,
+			 struct btrfs_qgroup_limit_item, rsv_excl, 64);
 
 /* btrfs_balance_item */
 BTRFS_SETGET_FUNCS(balance_item_flags, struct btrfs_balance_item, flags, 64);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 3fb6a37c..37a1f74c 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1089,12 +1089,10 @@ static void print_qgroup_info(struct extent_buffer *eb, int slot)
 		"\t\treferenced %llu referenced_compressed %llu\n"
 		"\t\texclusive %llu exclusive_compressed %llu\n",
 		(unsigned long long)btrfs_qgroup_info_generation(eb, qg_info),
-		(unsigned long long)btrfs_qgroup_info_referenced(eb, qg_info),
-		(unsigned long long)btrfs_qgroup_info_referenced_compressed(eb,
-								       qg_info),
-		(unsigned long long)btrfs_qgroup_info_exclusive(eb, qg_info),
-		(unsigned long long)btrfs_qgroup_info_exclusive_compressed(eb,
-								      qg_info));
+		(unsigned long long)btrfs_qgroup_info_rfer(eb, qg_info),
+		(unsigned long long)btrfs_qgroup_info_rfer_cmpr(eb, qg_info),
+		(unsigned long long)btrfs_qgroup_info_excl(eb, qg_info),
+		(unsigned long long)btrfs_qgroup_info_excl_cmpr(eb, qg_info));
 }
 
 static void print_qgroup_limit(struct extent_buffer *eb, int slot)
@@ -1106,10 +1104,10 @@ static void print_qgroup_limit(struct extent_buffer *eb, int slot)
 		"\t\tmax_referenced %lld max_exclusive %lld\n"
 		"\t\trsv_referenced %lld rsv_exclusive %lld\n",
 		(unsigned long long)btrfs_qgroup_limit_flags(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_max_referenced(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_max_exclusive(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_rsv_referenced(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_rsv_exclusive(eb, qg_limit));
+		(long long)btrfs_qgroup_limit_max_rfer(eb, qg_limit),
+		(long long)btrfs_qgroup_limit_max_excl(eb, qg_limit),
+		(long long)btrfs_qgroup_limit_rsv_rfer(eb, qg_limit),
+		(long long)btrfs_qgroup_limit_rsv_excl(eb, qg_limit));
 }
 
 static void print_persistent_item(struct extent_buffer *eb, void *ptr,
-- 
2.39.1

