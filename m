Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7156C40F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 01:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbiGHULW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiGHULV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 16:11:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A65237FF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 13:11:20 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268IrHbn019034
        for <linux-btrfs@vger.kernel.org>; Fri, 8 Jul 2022 13:11:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GR4jWXtd/wBzHYlcJUrzU4CCDoxRScQKtOZxZRcfqPM=;
 b=hg5eWRLAoSNQPEXD3zpCCdhhKylsbaQCUHjrL7kqeFCgEoD32NypJZMfg2X/USSZNSfi
 8UoO+b8hynoXPC1SRzxB0mnk5TXVjc2Wevv4cEgb/waQAjyaIXRfLXcgADyJ4BrEZQuz
 y20ECzS1wLwfJeR44oNLSsDHhGttzJg5vI4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h5y1djvjk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 13:11:20 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 8 Jul 2022 13:11:19 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 162A61D70ED4; Fri,  8 Jul 2022 13:11:16 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 2/2] btrfs: Add a lockdep model for the num_extwriters wait event
Date:   Fri, 8 Jul 2022 13:08:32 -0700
Message-ID: <20220708200829.3682503-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708200829.3682503-1-iangelak@fb.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hKjSqNva7SHrOnSUdc0nlvFYjdw4RJSV
X-Proofpoint-ORIG-GUID: hKjSqNva7SHrOnSUdc0nlvFYjdw4RJSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_17,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similarly to the num_writers wait event in fs/btrfs/transaction.c add a
lockdep annotation for the num_extwriters wait event.

Use a read/write lockdep map for the annotation. A thread starting/joinin=
g
the transaction acquires the map as a reader when it increments
cur_trans->num_writers and it acquires the map as a writer before it
blocks on the wait event.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     |  4 ++++
 fs/btrfs/transaction.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 160c22391cb5..0d94786a2c43 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1092,6 +1092,7 @@ struct btrfs_fs_info {
 	struct btrfs_commit_stats commit_stats;
=20
 	struct lockdep_map btrfs_trans_num_writers_map;
+	struct lockdep_map btrfs_trans_num_extwriters_map;
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4061886024de..cd47fb170b05 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3030,6 +3030,7 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
 	static struct lock_class_key btrfs_trans_num_writers_key;
+	static struct lock_class_key btrfs_trans_num_extwriters_key;
=20
 	xa_init_flags(&fs_info->fs_roots, GFP_ATOMIC);
 	xa_init_flags(&fs_info->extent_buffers, GFP_ATOMIC);
@@ -3062,6 +3063,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	lockdep_init_map(&fs_info->btrfs_trans_num_writers_map,
 					 "btrfs_trans_num_writers",
 					 &btrfs_trans_num_writers_key, 0);
+	lockdep_init_map(&fs_info->btrfs_trans_num_extwriters_map,
+					 "btrfs_trans_num_extwriters",
+					 &btrfs_trans_num_extwriters_key, 0);
=20
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7ef24e1f1446..972ef959f58f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -314,6 +314,7 @@ static noinline int join_transaction(struct btrfs_fs_=
info *fs_info,
 		extwriter_counter_inc(cur_trans, type);
 		spin_unlock(&fs_info->trans_lock);
 		btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
+		btrfs_lockdep_acquire(fs_info, btrfs_trans_num_extwriters);
 		return 0;
 	}
 	spin_unlock(&fs_info->trans_lock);
@@ -336,6 +337,7 @@ static noinline int join_transaction(struct btrfs_fs_=
info *fs_info,
 		return -ENOMEM;
=20
 	btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
+	btrfs_lockdep_acquire(fs_info, btrfs_trans_num_extwriters);
=20
 	spin_lock(&fs_info->trans_lock);
 	if (fs_info->running_transaction) {
@@ -343,11 +345,13 @@ static noinline int join_transaction(struct btrfs_f=
s_info *fs_info,
 		 * someone started a transaction after we unlocked.  Make sure
 		 * to redo the checks above
 		 */
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		kfree(cur_trans);
 		goto loop;
 	} else if (BTRFS_FS_ERROR(fs_info)) {
 		spin_unlock(&fs_info->trans_lock);
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		kfree(cur_trans);
 		return -EROFS;
@@ -1026,6 +1030,7 @@ static int __btrfs_end_transaction(struct btrfs_tra=
ns_handle *trans,
=20
 	cond_wake_up(&cur_trans->writer_wait);
=20
+	btrfs_lockdep_release(info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_release(info, btrfs_trans_num_writers);
=20
 	btrfs_put_transaction(cur_trans);
@@ -2222,6 +2227,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 			btrfs_put_transaction(prev_trans);
 			if (ret) {
+				btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 				btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 				goto cleanup_transaction;
 			}
@@ -2238,6 +2244,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 		 */
 		if (BTRFS_FS_ERROR(fs_info)) {
 			ret =3D -EROFS;
+			btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 			btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 			goto cleanup_transaction;
 		}
@@ -2253,16 +2260,25 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)
=20
 	ret =3D btrfs_start_delalloc_flush(fs_info);
 	if (ret) {
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		goto cleanup_transaction;
 	}
=20
 	ret =3D btrfs_run_delayed_items(trans);
 	if (ret) {
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		goto cleanup_transaction;
 	}
=20
+	/*
+	 * The thread has started/joined the transaction thus it holds the lock=
dep
+	 * map as a reader. It has to release it before acquiring the lockdep m=
ap
+	 * as a writer.
+	 */
+	btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
+	btrfs_might_wait_for_event(fs_info, btrfs_trans_num_extwriters);
 	wait_event(cur_trans->writer_wait,
 		   extwriter_counter_read(cur_trans) =3D=3D 0);
=20
--=20
2.30.2

