Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6F56C206
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 01:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiGHUKH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGHUKH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 16:10:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC04E1BEB3
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 13:10:05 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268IrFAO013582
        for <linux-btrfs@vger.kernel.org>; Fri, 8 Jul 2022 13:10:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pXxlr7IOsO397x8RDyJP83kpb9IC6CdeiTECdkmk274=;
 b=R3oKw2832Zj4yPjjkubt5Gqbk1uElAh83/rZ64tMWSvI+MZAWm1FFRQDJgq9WPu2TOY0
 HbXUIElYlckfyfF/hj67hpMis9Q3q2Dtgjvxy+h2cBuG5vMV1iG0s3Q1FCGRaTAhdoyZ
 pNfy6T9sR7Ix3BUp6luLI9mUR6u9xP0F4dY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h6f69vf1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 13:10:05 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 8 Jul 2022 13:10:04 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 1B0EF1D70BE9; Fri,  8 Jul 2022 13:10:01 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait event
Date:   Fri, 8 Jul 2022 13:08:30 -0700
Message-ID: <20220708200829.3682503-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708200829.3682503-1-iangelak@fb.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lqNe6D1Y7tMuJ7Ju4_Cg1YYTlYJ7UQ0F
X-Proofpoint-GUID: lqNe6D1Y7tMuJ7Ju4_Cg1YYTlYJ7UQ0F
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

Annotate the num_writers wait event in fs/btrfs/transaction.c with lockde=
p
in order to catch deadlocks involving this wait event.

Use a read/write lockdep map for the annotation. A thread starting/joinin=
g
the transaction acquires the map as a reader when it increments
cur_trans->num_writers and it acquires the map as a writer before it
blocks on the wait event.


Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h       | 14 ++++++++++++++
 fs/btrfs/disk-io.c     |  6 ++++++
 fs/btrfs/transaction.c | 39 +++++++++++++++++++++++++++++++++++----
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aab..160c22391cb5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1091,6 +1091,8 @@ struct btrfs_fs_info {
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
=20
+	struct lockdep_map btrfs_trans_num_writers_map;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
@@ -1172,6 +1174,18 @@ enum {
 	BTRFS_ROOT_UNFINISHED_DROP,
 };
=20
+#define btrfs_might_wait_for_event(b, lock) \
+	do { \
+		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
+		rwsem_release(&b->lock##_map, _THIS_IP_); \
+	} while (0)
+
+#define btrfs_lockdep_acquire(b, lock) \
+	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
+
+#define btrfs_lockdep_release(b, lock) \
+	rwsem_release(&b->lock##_map, _THIS_IP_)
+
 static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_i=
nfo)
 {
 	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 76835394a61b..4061886024de 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3029,6 +3029,8 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
=20
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
+	static struct lock_class_key btrfs_trans_num_writers_key;
+
 	xa_init_flags(&fs_info->fs_roots, GFP_ATOMIC);
 	xa_init_flags(&fs_info->extent_buffers, GFP_ATOMIC);
 	INIT_LIST_HEAD(&fs_info->trans_list);
@@ -3057,6 +3059,10 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_i=
nfo)
 	mutex_init(&fs_info->zoned_data_reloc_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
=20
+	lockdep_init_map(&fs_info->btrfs_trans_num_writers_map,
+					 "btrfs_trans_num_writers",
+					 &btrfs_trans_num_writers_key, 0);
+
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0a50d5746f6f..7ef24e1f1446 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -313,6 +313,7 @@ static noinline int join_transaction(struct btrfs_fs_=
info *fs_info,
 		atomic_inc(&cur_trans->num_writers);
 		extwriter_counter_inc(cur_trans, type);
 		spin_unlock(&fs_info->trans_lock);
+		btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
 		return 0;
 	}
 	spin_unlock(&fs_info->trans_lock);
@@ -334,16 +335,20 @@ static noinline int join_transaction(struct btrfs_f=
s_info *fs_info,
 	if (!cur_trans)
 		return -ENOMEM;
=20
+	btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
+
 	spin_lock(&fs_info->trans_lock);
 	if (fs_info->running_transaction) {
 		/*
 		 * someone started a transaction after we unlocked.  Make sure
 		 * to redo the checks above
 		 */
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		kfree(cur_trans);
 		goto loop;
 	} else if (BTRFS_FS_ERROR(fs_info)) {
 		spin_unlock(&fs_info->trans_lock);
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		kfree(cur_trans);
 		return -EROFS;
 	}
@@ -1020,6 +1025,9 @@ static int __btrfs_end_transaction(struct btrfs_tra=
ns_handle *trans,
 	extwriter_counter_dec(cur_trans, trans->type);
=20
 	cond_wake_up(&cur_trans->writer_wait);
+
+	btrfs_lockdep_release(info, btrfs_trans_num_writers);
+
 	btrfs_put_transaction(cur_trans);
=20
 	if (current->journal_info =3D=3D trans)
@@ -1980,6 +1988,12 @@ static void cleanup_transaction(struct btrfs_trans=
_handle *trans, int err)
 	if (cur_trans =3D=3D fs_info->running_transaction) {
 		cur_trans->state =3D TRANS_STATE_COMMIT_DOING;
 		spin_unlock(&fs_info->trans_lock);
+
+		/*
+		 * The thread has already released the lockdep map as reader already i=
n
+		 * btrfs_commit_transaction().
+		 */
+		btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);
 		wait_event(cur_trans->writer_wait,
 			   atomic_read(&cur_trans->num_writers) =3D=3D 1);
=20
@@ -2207,8 +2221,10 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 			ret =3D READ_ONCE(prev_trans->aborted);
=20
 			btrfs_put_transaction(prev_trans);
-			if (ret)
+			if (ret) {
+				btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 				goto cleanup_transaction;
+			}
 		} else {
 			spin_unlock(&fs_info->trans_lock);
 		}
@@ -2222,6 +2238,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 		 */
 		if (BTRFS_FS_ERROR(fs_info)) {
 			ret =3D -EROFS;
+			btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 			goto cleanup_transaction;
 		}
 	}
@@ -2235,20 +2252,26 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)
 	extwriter_counter_dec(cur_trans, trans->type);
=20
 	ret =3D btrfs_start_delalloc_flush(fs_info);
-	if (ret)
+	if (ret) {
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		goto cleanup_transaction;
+	}
=20
 	ret =3D btrfs_run_delayed_items(trans);
-	if (ret)
+	if (ret) {
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		goto cleanup_transaction;
+	}
=20
 	wait_event(cur_trans->writer_wait,
 		   extwriter_counter_read(cur_trans) =3D=3D 0);
=20
 	/* some pending stuffs might be added after the previous flush. */
 	ret =3D btrfs_run_delayed_items(trans);
-	if (ret)
+	if (ret) {
+		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		goto cleanup_transaction;
+	}
=20
 	btrfs_wait_delalloc_flush(fs_info);
=20
@@ -2270,6 +2293,14 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 	add_pending_snapshot(trans);
 	cur_trans->state =3D TRANS_STATE_COMMIT_DOING;
 	spin_unlock(&fs_info->trans_lock);
+
+	/*
+	 * The thread has started/joined the transaction thus it holds the lock=
dep
+	 * map as a reader. It has to release it before acquiring the lockdep m=
ap
+	 * as a writer.
+	 */
+	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
+	btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);
 	wait_event(cur_trans->writer_wait,
 		   atomic_read(&cur_trans->num_writers) =3D=3D 1);
=20
--=20
2.30.2

