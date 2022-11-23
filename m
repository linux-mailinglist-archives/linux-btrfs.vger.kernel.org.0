Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560FF636D44
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKWWiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKWWhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:52 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3EF27914
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:48 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s4so133886qtx.6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLjSF4Oa9uibD9smYy3HJFJ76Fv4iA+KV87w4vX2jSM=;
        b=R1DGwubIjmzn3GtXVilqfUKX+67l2YBXStCrES1UYtBnjhpgxM2gXeJldgeqmAxO4p
         YB1b3MQtcNmelNssxqNeOh6CxCX70FeqTyJS6j/LWb1tVCiFM/wKvmenq9i4SFykPK5g
         41qQB1h8EobUi/xvWWY9ncJyQp+z702pH+95WYQRQilgxVeormYrk/jSaxbE+f5DZ0MY
         MFE2ED/4n+IRqwK9OMRabjK0FdTdCswVXWOZ7P97gnx1rlTMPhs66vo/GyiyQfhQE4wA
         +o5mQ8quPNQdevjmUczeK5FHQ4WKKciZxR8QrETa96CzNQ5SzH7jCd5RJ3tw0Yb8XeQR
         UBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLjSF4Oa9uibD9smYy3HJFJ76Fv4iA+KV87w4vX2jSM=;
        b=V5Q4/4M5Ff+tX5RQTF15eEG9zDwzkq2bZb340DaBEbeV4fkG3W19DbCvqmQVeMCrek
         iUjZybBbvJPYSGKVI0s2SqtjB6xLFp4hBwRtDgZdOvInE9fIKatSs8WpBDgnPPMsiP/r
         4OOR3E33hnl1ddjl+nETijQyiSwu0o6pVNIvHD+t+eVKAeobMOacncZw4VPOAYJ/Q0DW
         H05kCiXn2270cjYl0dPLnhJ7s/huTbm7xxsw9k9SySOi11pOluA46HJzHaZF7+LgqOjN
         tO5FTk9amXBXIQnDECNhDepGcvHdrO9A2rA3QG679V0XBRL9GlIlMcAQfoLn7RBOKwN4
         LVeQ==
X-Gm-Message-State: ANoB5pl9yAGqje3FI+UCGzn/vjcl5ar1USjiqYSiwTyws7CFYLgekUhi
        De+VjiUcxgVsUcU7anh1pKHKYzkOfVNAJQ==
X-Google-Smtp-Source: AA0mqf6GbshQZtEmwL6kywuxBjj1uV3cbAtO3ZO9I07nkYA7OYoglhjkIs0KUF1ICkkcri2ToAihWw==
X-Received: by 2002:ac8:7415:0:b0:3a4:a229:b974 with SMTP id p21-20020ac87415000000b003a4a229b974mr10411389qtq.255.1669243068315;
        Wed, 23 Nov 2022 14:37:48 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a400400b006eeb3165565sm13182080qko.80.2022.11.23.14.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 07/29] btrfs-progs: make btrfs_qgroup_level helper match the kernel
Date:   Wed, 23 Nov 2022 17:37:15 -0500
Message-Id: <976e6937a7bf48d19ecc5788a28955fdab0366f5.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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
index 4ade901a..61eaab55 100644
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
index 2cf1b283..e08c72df 100644
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

