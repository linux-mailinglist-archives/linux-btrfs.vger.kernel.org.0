Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C71C6263A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiKKVab (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiKKVa1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:27 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4547EE03
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:25 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 8so3778880qka.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvFc9JZlQHo9qXYZ/+KKK8OiRQ7cb+f8e9rgl7wxqUc=;
        b=LmKXaZ/i1nxi8Jkzz9bMkbXaEdGMl+pmRUKUaTGgs1m7gEqrOB4pyAUy+YswpvsJxQ
         L84oefdtKjOh6mw80++vDTFzNc25315yb1GyzL1tAb+tEKYX/GcCr17KOdfyhgamS06u
         38jdXlr6xoxXoOQYSODOIweFTxfK3bp2UB3ZvwvPyqhIIErxEjQmKgFQUgwbSNQ67Uht
         lmvoLyRog1+1GgBr3wERsXNF0lbrZydW5HMhiU9gLrmTDz2u58NrThtc+HfExECjelcu
         hmfO6MpQU02P+0b4/EXiT809KH22MS9GcpiPi8juWFiCaiBDZevMlffUsRURJkGAo9DU
         IBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvFc9JZlQHo9qXYZ/+KKK8OiRQ7cb+f8e9rgl7wxqUc=;
        b=QBlQjETrS2SgkBTCvvFKAZv3kVM7OWcyK8lvM7m+W3ZuZLzrrxHBRcXn8qskV7TTVr
         ybdOQCDBRPFG/K/SuBSv45CDlkZ6vt1AylZIhOmm+ky5+JIR5fXnE1Dd08ZDdSaQi3sA
         VdHJbnsTfiKuwelfd9Z1xRYLpuwVx/pVxtSX1RmqAFiEBofDyRQl2QPQzGIkhuuYBni0
         yoV+7vG75r+epaFf+U/2+aVBbsTMK35zZWaKsQyh1GTKyf6jBmmw8t+Q6cRHshadSoib
         9Y8cf7f88SO88AgvWSg+Rp1efCWnUz5ym7UUXfgXZUGu/GUSXKWGpHgGNfdbFyRRxZVU
         zAFg==
X-Gm-Message-State: ANoB5pkLNKso02SAl/eAhBu8FTqbXQ5HPxDQUmoyDSYQ+HsfHoMmm5UV
        I00fDkHky4yahIgTDDq+fxfhpQZutbUP8g==
X-Google-Smtp-Source: AA0mqf6WzU5khbGSnbJiAPUG+y+fJW0IpHuwJHcGv/qUWPP3o1EMiJK8d7AxFngwr700ey/eoyOLaw==
X-Received: by 2002:a05:620a:7ec:b0:6f9:9b46:5318 with SMTP id k12-20020a05620a07ec00b006f99b465318mr2709326qkk.767.1668202224243;
        Fri, 11 Nov 2022 13:30:24 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006eed47a1a1esm2052080qkn.134.2022.11.11.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/14] btrfs-progs: rename qgroup items to match the kernel naming scheme
Date:   Fri, 11 Nov 2022 16:30:06 -0500
Message-Id: <0c71447fd97f5f24fa33fff021c04104f2c517ff.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to sync the kernel source into btrfs-progs, and in the
kernel we have all these qgroup fields named with short names instead of
the full name, so rename

referenced -> rfer
compressed -> cmpr
exclusive -> excl

to match the kernel and update all the users, this will make the sync
cleaner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c      | 60 ++++++++++++++++----------------
 cmds/qgroup.c              | 57 ++++++++++++++----------------
 cmds/qgroup.h              |  8 ++---
 cmds/subvolume.c           | 12 +++----
 ioctl.h                    |  8 ++---
 kernel-shared/ctree.h      | 71 +++++++++++++++++++-------------------
 kernel-shared/print-tree.c | 10 +++---
 7 files changed, 108 insertions(+), 118 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index ab93d7e0..906fabcb 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -49,10 +49,10 @@ struct qgroup_count;
 static struct qgroup_count *find_count(u64 qgroupid);
 
 struct qgroup_info {
-	u64 referenced;
-	u64 referenced_compressed;
-	u64 exclusive;
-	u64 exclusive_compressed;
+	u64 rfer;
+	u64 rfer_cmpr;
+	u64 excl;
+	u64 excl_cmpr;
 };
 
 struct qgroup_count {
@@ -481,12 +481,12 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 
 		nr_refs = group_get_cur_refcnt(count);
 		if (nr_refs) {
-			count->info.referenced += num_bytes;
-			count->info.referenced_compressed += num_bytes;
+			count->info.rfer += num_bytes;
+			count->info.rfer_cmpr += num_bytes;
 
 			if (nr_refs == nr_roots) {
-				count->info.exclusive += num_bytes;
-				count->info.exclusive_compressed += num_bytes;
+				count->info.excl += num_bytes;
+				count->info.excl_cmpr += num_bytes;
 			}
 		}
 #ifdef QGROUP_VERIFY_DEBUG
@@ -494,7 +494,7 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 		       " excl %llu, refs %llu, roots %llu\n", bytenr, num_bytes,
 		       btrfs_qgroup_level(count->qgroupid),
 		       btrfs_qgroup_subvid(count->qgroupid),
-		       count->info.referenced, count->info.exclusive, nr_refs,
+		       count->info.rfer, count->info.excl, nr_refs,
 		       nr_roots);
 #endif
 	}
@@ -870,12 +870,10 @@ static struct qgroup_count *alloc_count(struct btrfs_disk_key *key,
 		c->key = *key;
 
 		item = &c->diskinfo;
-		item->referenced = btrfs_qgroup_info_referenced(leaf, disk);
-		item->referenced_compressed =
-			btrfs_qgroup_info_referenced_compressed(leaf, disk);
-		item->exclusive = btrfs_qgroup_info_exclusive(leaf, disk);
-		item->exclusive_compressed =
-			btrfs_qgroup_info_exclusive_compressed(leaf, disk);
+		item->rfer = btrfs_qgroup_info_rfer(leaf, disk);
+		item->rfer_cmpr = btrfs_qgroup_info_rfer_cmpr(leaf, disk);
+		item->excl = btrfs_qgroup_info_excl(leaf, disk);
+		item->excl_cmpr = btrfs_qgroup_info_excl_cmpr(leaf, disk);
 		INIT_LIST_HEAD(&c->groups);
 		INIT_LIST_HEAD(&c->members);
 		INIT_LIST_HEAD(&c->bad_list);
@@ -1286,8 +1284,8 @@ static int report_qgroup_difference(struct qgroup_count *count, int verbose)
 	int is_different;
 	struct qgroup_info *info = &count->info;
 	struct qgroup_info *disk = &count->diskinfo;
-	long long excl_diff = info->exclusive - disk->exclusive;
-	long long ref_diff = info->referenced - disk->referenced;
+	long long excl_diff = info->excl - disk->excl;
+	long long ref_diff = info->rfer - disk->rfer;
 
 	is_different = excl_diff || ref_diff;
 
@@ -1297,16 +1295,16 @@ static int report_qgroup_difference(struct qgroup_count *count, int verbose)
 		       btrfs_qgroup_subvid(count->qgroupid),
 		       is_different ? "are different" : "");
 
-		print_fields(info->referenced, info->referenced_compressed,
+		print_fields(info->rfer, info->rfer_cmpr,
 			     "our:", "referenced");
-		print_fields(disk->referenced, disk->referenced_compressed,
+		print_fields(disk->rfer, disk->rfer_cmpr,
 			     "disk:", "referenced");
 		if (ref_diff)
 			print_fields_signed(ref_diff, ref_diff,
 					    "diff:", "referenced");
-		print_fields(info->exclusive, info->exclusive_compressed,
+		print_fields(info->excl, info->excl_cmpr,
 			     "our:", "exclusive");
-		print_fields(disk->exclusive, disk->exclusive_compressed,
+		print_fields(disk->excl, disk->excl_cmpr,
 			     "disk:", "exclusive");
 		if (excl_diff)
 			print_fields_signed(excl_diff, excl_diff,
@@ -1388,8 +1386,8 @@ static bool is_bad_qgroup(struct qgroup_count *count)
 {
 	struct qgroup_info *info = &count->info;
 	struct qgroup_info *disk = &count->diskinfo;
-	s64 excl_diff = info->exclusive - disk->exclusive;
-	s64 ref_diff = info->referenced - disk->referenced;
+	s64 excl_diff = info->excl - disk->excl;
+	s64 ref_diff = info->rfer - disk->rfer;
 
 	return (excl_diff || ref_diff);
 }
@@ -1594,15 +1592,15 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	btrfs_set_qgroup_info_generation(path.nodes[0], info_item,
 					 trans->transid);
 
-	btrfs_set_qgroup_info_referenced(path.nodes[0], info_item,
-					 count->info.referenced);
-	btrfs_set_qgroup_info_referenced_compressed(path.nodes[0], info_item,
-					    count->info.referenced_compressed);
+	btrfs_set_qgroup_info_rfer(path.nodes[0], info_item,
+					 count->info.rfer);
+	btrfs_set_qgroup_info_rfer_cmpr(path.nodes[0], info_item,
+					    count->info.rfer_cmpr);
 
-	btrfs_set_qgroup_info_exclusive(path.nodes[0], info_item,
-					count->info.exclusive);
-	btrfs_set_qgroup_info_exclusive_compressed(path.nodes[0], info_item,
-					   count->info.exclusive_compressed);
+	btrfs_set_qgroup_info_excl(path.nodes[0], info_item,
+					count->info.excl);
+	btrfs_set_qgroup_info_excl_cmpr(path.nodes[0], info_item,
+					   count->info.excl_cmpr);
 
 	btrfs_mark_buffer_dirty(path.nodes[0]);
 
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index f841c9d4..1d794427 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -294,10 +294,10 @@ static void print_qgroup_column(struct btrfs_qgroup *qgroup,
 		print_qgroup_column_add_blank(BTRFS_QGROUP_QGROUPID, len);
 		break;
 	case BTRFS_QGROUP_RFER:
-		len = print_u64(qgroup->info.referenced, unit_mode, max_len);
+		len = print_u64(qgroup->info.rfer, unit_mode, max_len);
 		break;
 	case BTRFS_QGROUP_EXCL:
-		len = print_u64(qgroup->info.exclusive, unit_mode, max_len);
+		len = print_u64(qgroup->info.excl, unit_mode, max_len);
 		break;
 	case BTRFS_QGROUP_PARENT:
 		len = print_parent_column(qgroup);
@@ -305,14 +305,14 @@ static void print_qgroup_column(struct btrfs_qgroup *qgroup,
 		break;
 	case BTRFS_QGROUP_MAX_RFER:
 		if (qgroup->limit.flags & BTRFS_QGROUP_LIMIT_MAX_RFER)
-			len = print_u64(qgroup->limit.max_referenced,
+			len = print_u64(qgroup->limit.max_rfer,
 					unit_mode, max_len);
 		else
 			len = printf("%*s", max_len, "none");
 		break;
 	case BTRFS_QGROUP_MAX_EXCL:
 		if (qgroup->limit.flags & BTRFS_QGROUP_LIMIT_MAX_EXCL)
-			len = print_u64(qgroup->limit.max_exclusive,
+			len = print_u64(qgroup->limit.max_excl,
 					unit_mode, max_len);
 		else
 			len = printf("%*s", max_len, "none");
@@ -412,9 +412,9 @@ static int comp_entry_with_rfer(struct btrfs_qgroup *entry1,
 {
 	int ret;
 
-	if (entry1->info.referenced > entry2->info.referenced)
+	if (entry1->info.rfer > entry2->info.rfer)
 		ret = 1;
-	else if (entry1->info.referenced < entry2->info.referenced)
+	else if (entry1->info.rfer < entry2->info.rfer)
 		ret = -1;
 	else
 		ret = 0;
@@ -428,9 +428,9 @@ static int comp_entry_with_excl(struct btrfs_qgroup *entry1,
 {
 	int ret;
 
-	if (entry1->info.exclusive > entry2->info.exclusive)
+	if (entry1->info.excl > entry2->info.excl)
 		ret = 1;
-	else if (entry1->info.exclusive < entry2->info.exclusive)
+	else if (entry1->info.excl < entry2->info.excl)
 		ret = -1;
 	else
 		ret = 0;
@@ -444,9 +444,9 @@ static int comp_entry_with_max_rfer(struct btrfs_qgroup *entry1,
 {
 	int ret;
 
-	if (entry1->limit.max_referenced > entry2->limit.max_referenced)
+	if (entry1->limit.max_rfer > entry2->limit.max_rfer)
 		ret = 1;
-	else if (entry1->limit.max_referenced < entry2->limit.max_referenced)
+	else if (entry1->limit.max_rfer < entry2->limit.max_rfer)
 		ret = -1;
 	else
 		ret = 0;
@@ -460,9 +460,9 @@ static int comp_entry_with_max_excl(struct btrfs_qgroup *entry1,
 {
 	int ret;
 
-	if (entry1->limit.max_exclusive > entry2->limit.max_exclusive)
+	if (entry1->limit.max_excl > entry2->limit.max_excl)
 		ret = 1;
-	else if (entry1->limit.max_exclusive < entry2->limit.max_exclusive)
+	else if (entry1->limit.max_excl < entry2->limit.max_excl)
 		ret = -1;
 	else
 		ret = 0;
@@ -696,12 +696,10 @@ static int update_qgroup_info(struct qgroup_lookup *qgroup_lookup, u64 qgroupid,
 		return PTR_ERR(bq);
 
 	bq->info.generation = btrfs_stack_qgroup_info_generation(info);
-	bq->info.referenced = btrfs_stack_qgroup_info_referenced(info);
-	bq->info.referenced_compressed =
-			btrfs_stack_qgroup_info_referenced_compressed(info);
-	bq->info.exclusive = btrfs_stack_qgroup_info_exclusive(info);
-	bq->info.exclusive_compressed =
-			btrfs_stack_qgroup_info_exclusive_compressed(info);
+	bq->info.rfer = btrfs_stack_qgroup_info_rfer(info);
+	bq->info.rfer_cmpr = btrfs_stack_qgroup_info_rfer_cmpr(info);
+	bq->info.excl = btrfs_stack_qgroup_info_excl(info);
+	bq->info.excl_cmpr = btrfs_stack_qgroup_info_excl_cmpr(info);
 
 	return 0;
 }
@@ -717,13 +715,10 @@ static int update_qgroup_limit(struct qgroup_lookup *qgroup_lookup,
 		return PTR_ERR(bq);
 
 	bq->limit.flags = btrfs_stack_qgroup_limit_flags(limit);
-	bq->limit.max_referenced =
-			btrfs_stack_qgroup_limit_max_referenced(limit);
-	bq->limit.max_exclusive =
-			btrfs_stack_qgroup_limit_max_exclusive(limit);
-	bq->limit.rsv_referenced =
-			btrfs_stack_qgroup_limit_rsv_referenced(limit);
-	bq->limit.rsv_exclusive = btrfs_stack_qgroup_limit_rsv_exclusive(limit);
+	bq->limit.max_rfer = btrfs_stack_qgroup_limit_max_rfer(limit);
+	bq->limit.max_excl = btrfs_stack_qgroup_limit_max_excl(limit);
+	bq->limit.rsv_rfer = btrfs_stack_qgroup_limit_rsv_rfer(limit);
+	bq->limit.rsv_excl = btrfs_stack_qgroup_limit_rsv_excl(limit);
 
 	return 0;
 }
@@ -1014,23 +1009,23 @@ static void __update_columns_max_len(struct btrfs_qgroup *bq,
 			btrfs_qgroup_columns[column].max_len = len;
 		break;
 	case BTRFS_QGROUP_RFER:
-		len = strlen(pretty_size_mode(bq->info.referenced, unit_mode));
+		len = strlen(pretty_size_mode(bq->info.rfer, unit_mode));
 		if (btrfs_qgroup_columns[column].max_len < len)
 			btrfs_qgroup_columns[column].max_len = len;
 		break;
 	case BTRFS_QGROUP_EXCL:
-		len = strlen(pretty_size_mode(bq->info.exclusive, unit_mode));
+		len = strlen(pretty_size_mode(bq->info.excl, unit_mode));
 		if (btrfs_qgroup_columns[column].max_len < len)
 			btrfs_qgroup_columns[column].max_len = len;
 		break;
 	case BTRFS_QGROUP_MAX_RFER:
-		len = strlen(pretty_size_mode(bq->limit.max_referenced,
+		len = strlen(pretty_size_mode(bq->limit.max_rfer,
 			     unit_mode));
 		if (btrfs_qgroup_columns[column].max_len < len)
 			btrfs_qgroup_columns[column].max_len = len;
 		break;
 	case BTRFS_QGROUP_MAX_EXCL:
-		len = strlen(pretty_size_mode(bq->limit.max_exclusive,
+		len = strlen(pretty_size_mode(bq->limit.max_excl,
 			     unit_mode));
 		if (btrfs_qgroup_columns[column].max_len < len)
 			btrfs_qgroup_columns[column].max_len = len;
@@ -1912,10 +1907,10 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 				  BTRFS_QGROUP_LIMIT_EXCL_CMPR;
 	if (exclusive) {
 		args.lim.flags |= BTRFS_QGROUP_LIMIT_MAX_EXCL;
-		args.lim.max_exclusive = size;
+		args.lim.max_excl = size;
 	} else {
 		args.lim.flags |= BTRFS_QGROUP_LIMIT_MAX_RFER;
-		args.lim.max_referenced = size;
+		args.lim.max_rfer = size;
 	}
 
 	if (argc - optind == 2) {
diff --git a/cmds/qgroup.h b/cmds/qgroup.h
index 69b8c11f..93e81e85 100644
--- a/cmds/qgroup.h
+++ b/cmds/qgroup.h
@@ -24,10 +24,10 @@
 
 struct btrfs_qgroup_info {
 	u64 generation;
-	u64 referenced;
-	u64 referenced_compressed;
-	u64 exclusive;
-	u64 exclusive_compressed;
+	u64 rfer;
+	u64 rfer_cmpr;
+	u64 excl;
+	u64 excl_cmpr;
 };
 
 struct btrfs_qgroup_stats {
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index adbac908..a90147e2 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1489,15 +1489,15 @@ static int cmd_subvol_show(const struct cmd_struct *cmd, int argc, char **argv)
 	fflush(stdout);
 
 	pr_verbose(LOG_DEFAULT, "\t  Limit referenced:\t%s\n",
-			stats.limit.max_referenced == 0 ? "-" :
-			pretty_size_mode(stats.limit.max_referenced, unit_mode));
+			stats.limit.max_rfer == 0 ? "-" :
+			pretty_size_mode(stats.limit.max_rfer, unit_mode));
 	pr_verbose(LOG_DEFAULT, "\t  Limit exclusive:\t%s\n",
-			stats.limit.max_exclusive == 0 ? "-" :
-			pretty_size_mode(stats.limit.max_exclusive, unit_mode));
+			stats.limit.max_excl == 0 ? "-" :
+			pretty_size_mode(stats.limit.max_excl, unit_mode));
 	pr_verbose(LOG_DEFAULT, "\t  Usage referenced:\t%s\n",
-			pretty_size_mode(stats.info.referenced, unit_mode));
+			pretty_size_mode(stats.info.rfer, unit_mode));
 	pr_verbose(LOG_DEFAULT, "\t  Usage exclusive:\t%s\n",
-			pretty_size_mode(stats.info.exclusive, unit_mode));
+			pretty_size_mode(stats.info.excl, unit_mode));
 
 out:
 	free(subvol_path);
diff --git a/ioctl.h b/ioctl.h
index 0615054b..21aaedde 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -71,10 +71,10 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 
 struct btrfs_qgroup_limit {
 	__u64	flags;
-	__u64	max_referenced;
-	__u64	max_exclusive;
-	__u64	rsv_referenced;
-	__u64	rsv_exclusive;
+	__u64	max_rfer;
+	__u64	max_excl;
+	__u64	rsv_rfer;
+	__u64	rsv_excl;
 };
 BUILD_ASSERT(sizeof(struct btrfs_qgroup_limit) == 40);
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7a9fd1cb..dfa8ab7e 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1108,10 +1108,10 @@ struct btrfs_free_space_info {
 
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
@@ -1124,10 +1124,10 @@ struct btrfs_qgroup_info_item {
 
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
@@ -2454,48 +2454,47 @@ BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_rescan,
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
+BTRFS_SETGET_FUNCS(qgroup_info_excl, struct btrfs_qgroup_info_item, excl, 64);
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
 BTRFS_SETGET_FUNCS(qgroup_limit_max_referenced, struct btrfs_qgroup_limit_item,
-		   max_referenced, 64);
+		   max_rfer, 64);
 BTRFS_SETGET_FUNCS(qgroup_limit_max_exclusive, struct btrfs_qgroup_limit_item,
-		   max_exclusive, 64);
+		   max_excl, 64);
 BTRFS_SETGET_FUNCS(qgroup_limit_rsv_referenced, struct btrfs_qgroup_limit_item,
-		   rsv_referenced, 64);
+		   rsv_rfer, 64);
 BTRFS_SETGET_FUNCS(qgroup_limit_rsv_exclusive, struct btrfs_qgroup_limit_item,
-		   rsv_exclusive, 64);
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
index 0e0404ab..3b6e334a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1088,12 +1088,10 @@ static void print_qgroup_info(struct extent_buffer *eb, int slot)
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
-- 
2.26.3

