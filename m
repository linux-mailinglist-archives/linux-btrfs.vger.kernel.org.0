Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7A553E32
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 23:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354794AbiFUVya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354456AbiFUVya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 17:54:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC91BE9E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:54:29 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LHIG5S022595
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Nctnz61pY1lH4HBikshMy0J47mxfIRAH101GD1tiFxA=;
 b=E3/zomBdW8hmJIYo6RreNkRLEf7JVcUtvrfsgMisuFX/x8xyEk5+EZo2wt4sx5hW0b08
 ljMfJGvjpAcoc7fdXobvcIzFVRWTjBUYbfEaBwjhrmkI1ETEGMiJMMfFF5JJFmF5eKyk
 Y1P7kvx7eMxmdeiqMj4Ur38QnKImwRJNTw0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gueeh3u4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:54:29 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 14:54:28 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 3D129137C2A8; Tue, 21 Jun 2022 14:54:26 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 1/2] btrfs: Add the capability of getting commit stats in BTRFS
Date:   Tue, 21 Jun 2022 14:52:46 -0700
Message-ID: <20220621215245.3603198-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621215245.3603198-1-iangelak@fb.com>
References: <20220621215245.3603198-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zPf_vvU55YZyxpRURQlGHo_XdO971X2S
X-Proofpoint-ORIG-GUID: zPf_vvU55YZyxpRURQlGHo_XdO971X2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_09,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First we add  "struct btrfs_commit_stats" data structure under "fs_info"
in fs/btrfs/ctree.h to store the commit stats for BTRFS that will be
exposed through sysfs.

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
 fs/btrfs/transaction.c | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1347c92234a5..2bd4a53c0046 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -667,6 +667,18 @@ enum btrfs_exclusive_operation {
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
@@ -1076,6 +1088,8 @@ struct btrfs_fs_info {
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
=20
+	struct btrfs_commit_stats commit_stats;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 06c0a958d114..5b9451b3b005 100644
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
@@ -2084,12 +2085,23 @@ static void add_pending_snapshot(struct btrfs_tra=
ns_handle *trans)
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots)=
;
 }
=20
+static void update_commit_stats(struct btrfs_fs_info *fs_info, ktime_t i=
nterval)
+{
+	fs_info->commit_stats.commit_counter++;
+	fs_info->commit_stats.last_commit_dur =3D interval;
+	fs_info->commit_stats.max_commit_dur =3D max_t(u64,
+				fs_info->commit_stats.max_commit_dur, interval);
+	fs_info->commit_stats.total_commit_dur +=3D interval;
+}
+
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info =3D trans->fs_info;
 	struct btrfs_transaction *cur_trans =3D trans->transaction;
 	struct btrfs_transaction *prev_trans =3D NULL;
 	int ret;
+	ktime_t start_time;
+	ktime_t interval;
=20
 	ASSERT(refcount_read(&trans->use_count) =3D=3D 1);
=20
@@ -2214,6 +2226,12 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 		}
 	}
=20
+	/*
+	 * Get the time spent on the work done by the commit thread and not
+	 * the time spent waiting on a previous commit
+	 */
+	start_time =3D ktime_get_ns();
+
 	extwriter_counter_dec(cur_trans, trans->type);
=20
 	ret =3D btrfs_start_delalloc_flush(fs_info);
@@ -2455,6 +2473,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	trace_btrfs_transaction_commit(fs_info);
=20
+	interval =3D ktime_get_ns() - start_time;
+
 	btrfs_scrub_continue(fs_info);
=20
 	if (current->journal_info =3D=3D trans)
@@ -2462,6 +2482,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
=20
+	update_commit_stats(fs_info, interval);
+
 	return ret;
=20
 unlock_reloc:
--=20
2.30.2

