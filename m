Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8938546ED9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350393AbiFJUzN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350780AbiFJUzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 16:55:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD5427C3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:54:59 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25AHfqrY023278
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:54:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9EjzKJR7Zq6wzar5M/yZn1QOruV2bEtnR482U0vUkK0=;
 b=j+oXQSkXDYjCqLH+Btn5+QQB54k1alBOsetsJc/bxRMAvUVD0fPO2X+VgkjpxARmcnl1
 cEiyN6b4RN7G1jGrhvnIBSlkET9V3BiAegaBB9jydBtdbyP5xVC+uJxvgfdZSsUXIbMg
 NR9VlvvF9eSrtmlS2sL9fm0olZJEnRKsUdI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gmak517hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:54:58 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:54:56 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id E6DFDD3935E; Fri, 10 Jun 2022 13:54:49 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 1/2] btrfs: Add the capability of getting commit stats in BTRFS
Date:   Fri, 10 Jun 2022 13:54:07 -0700
Message-ID: <20220610205406.301397-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610205406.301397-1-iangelak@fb.com>
References: <20220610205406.301397-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PiFtuT1x6YB86E-fhsYWRQ9Szj1Vauwa
X-Proofpoint-ORIG-GUID: PiFtuT1x6YB86E-fhsYWRQ9Szj1Vauwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First we add  "struct btrfs_commit_stats" data structure under "fs_info"
to store the commit stats for BTRFS that will be exposed through sysfs

The stats exposed are: 1) The number of commits so far, 2) The duration o=
f
the last commit in ms, 3) The maximum commit duration seen so far in ms
and 4) The total duration for all commits so far in ms.

The update of the commit stats occurs after the commit thread has gone
through all the logic that checks if there is another thread committing
at the same time. This means that we only account for actual commit work
in the commit stats we report and not the time the thread spends waiting
until it is ready to do the commit work.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h       | 14 ++++++++++++++
 fs/btrfs/disk-io.c     |  6 ++++++
 fs/btrfs/transaction.c | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f7afdfd0bae7..d4cc38451c7b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -660,6 +660,18 @@ enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_SWAP_ACTIVATE,
 };
=20
+/* Storing data about btrfs commits. The data are accessible over sysfs =
*/
+struct btrfs_commit_stats {
+	/* Total number of commits */
+	u64 commit_counter;
+	/* The maximum commit duration so far*/
+	u64 max_commit_dur;
+	/* The last commit duration */
+	u64 last_commit_dur;
+	/* The total commit duration */
+	u64 total_commit_dur;
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -1082,6 +1094,8 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+
+	struct btrfs_commit_stats *commit_stats;
 };
=20
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68e..1c366ea01a9f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1668,6 +1668,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
+	kfree(fs_info->commit_stats);
 	free_global_roots(fs_info);
 	btrfs_put_root(fs_info->tree_root);
 	btrfs_put_root(fs_info->chunk_root);
@@ -3174,6 +3175,11 @@ static int init_mount_fs_info(struct btrfs_fs_info=
 *fs_info, struct super_block
 		return -ENOMEM;
 	btrfs_init_delayed_root(fs_info->delayed_root);
=20
+	fs_info->commit_stats =3D kzalloc(sizeof(struct btrfs_commit_stats),
+					GFP_KERNEL);
+	if (!fs_info->commit_stats)
+		return -ENOMEM;
+
 	if (sb_rdonly(sb))
 		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
=20
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 06c0a958d114..fb2a9bc9bae4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/uuid.h>
+#include <linux/timekeeping.h>
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
@@ -674,7 +675,7 @@ start_transaction(struct btrfs_root *root, unsigned i=
nt num_items,
 	 * and then we deadlock with somebody doing a freeze.
 	 *
 	 * If we are ATTACH, it means we just want to catch the current
-	 * transaction and commit it, so we needn't do sb_start_intwrite().=20
+	 * transaction and commit it, so we needn't do sb_start_intwrite().
 	 */
 	if (type & __TRANS_FREEZABLE)
 		sb_start_intwrite(fs_info->sb);
@@ -2084,12 +2085,30 @@ static void add_pending_snapshot(struct btrfs_tra=
ns_handle *trans)
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots)=
;
 }
=20
+static void update_commit_stats(struct btrfs_fs_info *fs_info,
+								ktime_t interval)
+{
+	/* Increase the successful commits counter */
+	fs_info->commit_stats->commit_counter +=3D 1;
+	/* Update the last commit duration */
+	fs_info->commit_stats->last_commit_dur =3D interval / 1000000;
+	/* Update the maximum commit duration */
+	fs_info->commit_stats->max_commit_dur =3D
+				fs_info->commit_stats->max_commit_dur >	interval / 1000000 ?
+				fs_info->commit_stats->max_commit_dur :	interval / 1000000;
+	/* Update the total commit duration */
+	fs_info->commit_stats->total_commit_dur +=3D interval / 1000000;
+}
+
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info =3D trans->fs_info;
 	struct btrfs_transaction *cur_trans =3D trans->transaction;
 	struct btrfs_transaction *prev_trans =3D NULL;
 	int ret;
+	ktime_t start_time;
+	ktime_t end_time;
+	ktime_t interval;
=20
 	ASSERT(refcount_read(&trans->use_count) =3D=3D 1);
=20
@@ -2214,6 +2233,12 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 		}
 	}
=20
+	/*
+	 * Get the time spent on the work done by the commit thread and not
+	 * the time spent on a previous commit
+	 */
+	start_time =3D ktime_get_ns();
+
 	extwriter_counter_dec(cur_trans, trans->type);
=20
 	ret =3D btrfs_start_delalloc_flush(fs_info);
@@ -2462,6 +2487,17 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
=20
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
=20
+	end_time =3D ktime_get_ns();
+	interval =3D end_time - start_time;
+
+	/*
+	 * Protect the commit stats updates from concurrent updates through
+	 * sysfs.
+	 */
+	spin_lock(&fs_info->trans_lock);
+	update_commit_stats(fs_info, interval);
+	spin_unlock(&fs_info->trans_lock);
+
 	return ret;
=20
 unlock_reloc:
--=20
2.30.2

