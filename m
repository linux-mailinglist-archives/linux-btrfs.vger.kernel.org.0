Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1D6263A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiKKVae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiKKVa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:28 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8A1146A
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:26 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id z1so3748874qkl.9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueASbopPFfXAz3NJ89OVKptQExuQ/f1SUrA5i0OS5fQ=;
        b=4IMJ+ahJztnuysxTkx6LunCiysJc1eFk/pV0+op77cQ9rg7NIA4MyZwfZFm4xjkK55
         66wX8O8lBgzMx/NK8CzzSca3gOUihezhmXGM7fVm+vp2RVaf/vwpug7aWsbOiIyiytyS
         3BUw5wA8nOhnEu+fE2do8yddVtoEZftlKt3cI2EJfducd7P9rurPWzpul09an4S5//kD
         1vVPN/93ljyQC1uRmON8iAvJi2JOjO+orqRsrJs4aWipVRr/87PWSx5883ka8yd23e6Y
         uhv8cwmyk482tx0Y2ZIRuXQmfTqxaEhcTM4wK0cveLmSbt3tKfTBVXNBhqBDlf7hEREB
         XIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueASbopPFfXAz3NJ89OVKptQExuQ/f1SUrA5i0OS5fQ=;
        b=nqd7lK8UZz0d1uDOSZxR3PhxJnq+ly1uZCpmG3L2wYE7bsw4QspDfiER0RGdvfu7BB
         3mszfFSnJmou1lw6f23IBPqBjsm6BlhV3X52tFpIqfvE8U5mJQhTYOHAA8+4h0adCAKd
         kL6beFatD+N0H8ZADWHSwJDvBt39oFY5N1R8PhdvcC0exBdIGBecoun8FSi2OpPqErFc
         HEGjFSdcQ906D5kR8HHinSE3sqZ9uY2geyDHAn6Vui1XuWp8f7OKcUYBD7VjZTyRIG+M
         P/6swXwHJqaxRdkmQc5Q6Mspm68xsTtr0T5yLuyUheT6XMjiJMe0QRxHANUtdf4C82Kj
         ZSiQ==
X-Gm-Message-State: ANoB5pkJVfjuanmJKiykTKtDj79V24yI9w9OpF2Z0mrn0jrXKY/Yx4MB
        9b77Kgu6gXxhvgtMLlP4xGz//vzU2qPC+w==
X-Google-Smtp-Source: AA0mqf4RjAyd+ENUl0jNlUJ6BLtD4g4lAniMbMmbwYJd9ZUlvAfjOyEdcIiAKOKg795Wjk9BhS3CPQ==
X-Received: by 2002:a05:620a:8c1:b0:6fa:26fe:ddeb with SMTP id z1-20020a05620a08c100b006fa26feddebmr2849744qkz.493.1668202225629;
        Fri, 11 Nov 2022 13:30:25 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm2130674qkj.8.2022.11.11.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/14] btrfs-progs: make btrfs_qgroup_level helper match the kernel
Date:   Fri, 11 Nov 2022 16:30:07 -0500
Message-Id: <e3af9ba94c7959d229437e6567547b4463050ccf.1668201935.git.josef@toxicpanda.com>
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

We return __u16 in the kernel, as this is actually the size of
btrfs_qgroup_level.  Adjust the existing helpers and update all the
callers to deal with the new size appropriately.  This will make syncing
the kernel code cleaner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c      |  6 +++---
 cmds/qgroup.c              | 16 ++++++++--------
 kernel-shared/ctree.h      |  2 +-
 kernel-shared/print-tree.c |  4 ++--
 libbtrfs/ctree.h           |  2 +-
 libbtrfsutil/btrfs_tree.h  |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 906fabcb..d79f947f 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1290,7 +1290,7 @@ static int report_qgroup_difference(struct qgroup_count *count, int verbose)
 	is_different = excl_diff || ref_diff;
 
 	if (verbose || (is_different && qgroup_printable(count))) {
-		printf("Counts for qgroup id: %llu/%llu %s\n",
+		printf("Counts for qgroup id: %u/%llu %s\n",
 		       btrfs_qgroup_level(count->qgroupid),
 		       btrfs_qgroup_subvid(count->qgroupid),
 		       is_different ? "are different" : "");
@@ -1564,7 +1564,7 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	struct btrfs_key key;
 
 	if (!silent)
-		printf("Repair qgroup %llu/%llu\n",
+		printf("Repair qgroup %u/%llu\n",
 			btrfs_qgroup_level(count->qgroupid),
 			btrfs_qgroup_subvid(count->qgroupid));
 
@@ -1578,7 +1578,7 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	key.offset = count->qgroupid;
 	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
 	if (ret) {
-		error("could not find disk item for qgroup %llu/%llu",
+		error("could not find disk item for qgroup %u/%llu",
 		      btrfs_qgroup_level(count->qgroupid),
 		      btrfs_qgroup_subvid(count->qgroupid));
 		if (ret > 0)
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 1d794427..c6c15da5 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -233,7 +233,7 @@ static int print_parent_column(struct btrfs_qgroup *qgroup)
 	int len = 0;
 
 	list_for_each_entry(list, &qgroup->qgroups, next_qgroup) {
-		len += printf("%llu/%llu",
+		len += printf("%u/%llu",
 			      btrfs_qgroup_level(list->qgroup->qgroupid),
 			      btrfs_qgroup_subvid(list->qgroup->qgroupid));
 		if (!list_is_last(&list->next_qgroup, &qgroup->qgroups))
@@ -251,7 +251,7 @@ static int print_child_column(struct btrfs_qgroup *qgroup)
 	int len = 0;
 
 	list_for_each_entry(list, &qgroup->members, next_member) {
-		len += printf("%llu/%llu",
+		len += printf("%u/%llu",
 			      btrfs_qgroup_level(list->member->qgroupid),
 			      btrfs_qgroup_subvid(list->member->qgroupid));
 		if (!list_is_last(&list->next_member, &qgroup->members))
@@ -288,7 +288,7 @@ static void print_qgroup_column(struct btrfs_qgroup *qgroup,
 	switch (column) {
 
 	case BTRFS_QGROUP_QGROUPID:
-		len = printf("%llu/%llu",
+		len = printf("%u/%llu",
 			     btrfs_qgroup_level(qgroup->qgroupid),
 			     btrfs_qgroup_subvid(qgroup->qgroupid));
 		print_qgroup_column_add_blank(BTRFS_QGROUP_QGROUPID, len);
@@ -732,7 +732,7 @@ static int update_qgroup_relation(struct qgroup_lookup *qgroup_lookup,
 
 	child = qgroup_tree_search(qgroup_lookup, child_id);
 	if (!child) {
-		error("cannot find the qgroup %llu/%llu",
+		error("cannot find the qgroup %u/%llu",
 		      btrfs_qgroup_level(child_id),
 		      btrfs_qgroup_subvid(child_id));
 		return -ENOENT;
@@ -740,7 +740,7 @@ static int update_qgroup_relation(struct qgroup_lookup *qgroup_lookup,
 
 	parent = qgroup_tree_search(qgroup_lookup, parent_id);
 	if (!parent) {
-		error("cannot find the qgroup %llu/%llu",
+		error("cannot find the qgroup %u/%llu",
 		      btrfs_qgroup_level(parent_id),
 		      btrfs_qgroup_subvid(parent_id));
 		return -ENOENT;
@@ -1001,7 +1001,7 @@ static void __update_columns_max_len(struct btrfs_qgroup *bq,
 	switch (column) {
 
 	case BTRFS_QGROUP_QGROUPID:
-		sprintf(tmp, "%llu/%llu",
+		sprintf(tmp, "%u/%llu",
 			btrfs_qgroup_level(bq->qgroupid),
 			btrfs_qgroup_subvid(bq->qgroupid));
 		len = strlen(tmp);
@@ -1033,7 +1033,7 @@ static void __update_columns_max_len(struct btrfs_qgroup *bq,
 	case BTRFS_QGROUP_PARENT:
 		len = 0;
 		list_for_each_entry(list, &bq->qgroups, next_qgroup) {
-			len += sprintf(tmp, "%llu/%llu",
+			len += sprintf(tmp, "%u/%llu",
 				btrfs_qgroup_level(list->qgroup->qgroupid),
 				btrfs_qgroup_subvid(list->qgroup->qgroupid));
 			if (!list_is_last(&list->next_qgroup, &bq->qgroups))
@@ -1045,7 +1045,7 @@ static void __update_columns_max_len(struct btrfs_qgroup *bq,
 	case BTRFS_QGROUP_CHILD:
 		len = 0;
 		list_for_each_entry(list, &bq->members, next_member) {
-			len += sprintf(tmp, "%llu/%llu",
+			len += sprintf(tmp, "%u/%llu",
 				btrfs_qgroup_level(list->member->qgroupid),
 				btrfs_qgroup_subvid(list->member->qgroupid));
 			if (!list_is_last(&list->next_member, &bq->members))
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index dfa8ab7e..68e5a08f 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1071,7 +1071,7 @@ enum btrfs_raid_types {
 
 #define BTRFS_QGROUP_LEVEL_SHIFT		48
 
-static inline u64 btrfs_qgroup_level(u64 qgroupid)
+static inline __u16 btrfs_qgroup_level(u64 qgroupid)
 {
 	return qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT;
 }
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 3b6e334a..8ad68b2a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -706,7 +706,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 		fprintf(stream, "%llu", (unsigned long long)objectid);
 		return;
 	case BTRFS_QGROUP_RELATION_KEY:
-		fprintf(stream, "%llu/%llu", btrfs_qgroup_level(objectid),
+		fprintf(stream, "%u/%llu", btrfs_qgroup_level(objectid),
 		       btrfs_qgroup_subvid(objectid));
 		return;
 	case BTRFS_UUID_KEY_SUBVOL:
@@ -815,7 +815,7 @@ void btrfs_print_key(struct btrfs_disk_key *disk_key)
 	case BTRFS_QGROUP_RELATION_KEY:
 	case BTRFS_QGROUP_INFO_KEY:
 	case BTRFS_QGROUP_LIMIT_KEY:
-		printf(" %llu/%llu)", btrfs_qgroup_level(offset),
+		printf(" %u/%llu)", btrfs_qgroup_level(offset),
 		       btrfs_qgroup_subvid(offset));
 		break;
 	case BTRFS_UUID_KEY_SUBVOL:
diff --git a/libbtrfs/ctree.h b/libbtrfs/ctree.h
index 69903f67..ed774ffa 100644
--- a/libbtrfs/ctree.h
+++ b/libbtrfs/ctree.h
@@ -1104,7 +1104,7 @@ enum btrfs_raid_types {
 
 #define BTRFS_QGROUP_LEVEL_SHIFT		48
 
-static inline u64 btrfs_qgroup_level(u64 qgroupid)
+static inline __u16 btrfs_qgroup_level(u64 qgroupid)
 {
 	return qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT;
 }
diff --git a/libbtrfsutil/btrfs_tree.h b/libbtrfsutil/btrfs_tree.h
index 1df9efd6..5e1609e0 100644
--- a/libbtrfsutil/btrfs_tree.h
+++ b/libbtrfsutil/btrfs_tree.h
@@ -908,7 +908,7 @@ struct btrfs_free_space_info {
 #define BTRFS_FREE_SPACE_USING_BITMAPS (1ULL << 0)
 
 #define BTRFS_QGROUP_LEVEL_SHIFT		48
-static __inline__ __u64 btrfs_qgroup_level(__u64 qgroupid)
+static __inline__ __u16 btrfs_qgroup_level(__u64 qgroupid)
 {
 	return qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT;
 }
-- 
2.26.3

