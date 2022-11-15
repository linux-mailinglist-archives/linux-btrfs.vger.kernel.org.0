Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44D629D88
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKOPcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiKOPbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:43 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAC2E9D9
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:39 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so8904878qtv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLjSF4Oa9uibD9smYy3HJFJ76Fv4iA+KV87w4vX2jSM=;
        b=JZnG4TlK+eNh85VAHa34XJ7bqixgm5O5H1EQLpDXDEw8LIo13r1X68zKGYuCA32EE8
         ysWTu41wUITS1pL+qc8s9WT8EEEXCwWAt/sDkAJYULZSe7zh3NsFLW+dQbhgJvoOQltM
         pAJlawQ1FOobwdj1KKaHIcAPVQdLvl4UdlMcaIILkEUbPF1sELsmwsN1uy2T5IjtsX+G
         Lku2/iciXr8a9RkBArcUlIenLc0EdUOtLYP3xQWsGA+B1/cgy+Zs+zzuIuUD5Q9MIRih
         zPj3cNzgqP+xAv2EW3wIR09UgLjosvLUvtCHjaXQrrTzPmA3oRmzONNJI3sKkvKNNgy/
         r2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLjSF4Oa9uibD9smYy3HJFJ76Fv4iA+KV87w4vX2jSM=;
        b=bd+orzCcYKJBhLsg7N0lMjx9lug5Tc+EUMxmQ03DUKF1MLx5m1ESh2NT7IYMM/1i/Y
         IMgNT87Lnf8LaD9C9a7jZlpb3B6CGgiQNDV2NFafCb36/JSSlsmBmiQdv8+XSvQOJMGz
         yRom753O7oRkr3SCt6w5a71HMRxFqj6RrcCEx79oouwj+gnwzMrebCi8OJsBVQEXDAac
         kgn736dSeXeimxaUCYuQlw8HmMi3E14Pa80ZViaTxtnoGbmNnUEk4J2ebkXVOBHP5Ser
         WhajWjFXsKDUSBGhMdFpDZeF8hG5ASJRPsY5w4HrbgYh+5v3k7SSS8KeM6u/B8sHNMtu
         /FKw==
X-Gm-Message-State: ANoB5pk+GjKyIIkRCVZyVlBbUVT3KXH16MIzYdZtK+BB3Zx4IQ7V8l+V
        JDwUvo4oANy++lw5ZRzghxwu3gkQ4vFo2A==
X-Google-Smtp-Source: AA0mqf474qLWS+PQi8kLEKheWqSeLK3bvGL6WPi+3xpq8y8nzliajMsujUNhkmOLedCG8AaQpfG5YQ==
X-Received: by 2002:ac8:4609:0:b0:3a5:6047:c75c with SMTP id p9-20020ac84609000000b003a56047c75cmr16902600qtn.434.1668526298486;
        Tue, 15 Nov 2022 07:31:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85685000000b003a4ec43f2b5sm7240844qta.72.2022.11.15.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/18] btrfs-progs: make btrfs_qgroup_level helper match the kernel
Date:   Tue, 15 Nov 2022 10:31:15 -0500
Message-Id: <d6bea28829f520b8eb45f4904e4b7ad04da21fd9.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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

