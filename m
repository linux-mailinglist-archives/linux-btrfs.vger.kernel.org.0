Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27AF57C0FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiGTXkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 19:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGTXkC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 19:40:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D46E898
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:40:01 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26KNbF5r003922
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:40:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1VQT9jDujGeIaVZ5/2WMERjdnx4kziVYux2S4qoKM/o=;
 b=XMbDKk/pqKI03qfMuLR5Dt3eeT2xx9dC5mUbOlujC9xn6cx8w6rjC6gRc79raG5ecZzY
 n+iOn5kQ7L753bpVeOs+9L90dcmg+f4xs7S5LMkwBo8vWAbfmhKlY2jgjjNaDPF837rF
 J7LgTtACBTVI7LaLO3RSpQeDAsvbsjUANng= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hdv8fbn9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:40:00 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 16:40:00 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 931FD25F0781; Wed, 20 Jul 2022 16:39:57 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 1/6] btrfs: Add a lockdep model for the num_writers wait event
Date:   Wed, 20 Jul 2022 16:38:15 -0700
Message-ID: <20220720233818.3107724-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720233818.3107724-1-iangelak@fb.com>
References: <20220720233818.3107724-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: x0SR7CHbq8Y_IEhLMG4DMBJxojLccKcd
X-Proofpoint-ORIG-GUID: x0SR7CHbq8Y_IEhLMG4DMBJxojLccKcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/ctree.h       | 47 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/transaction.c | 37 ++++++++++++++++++++++++++++-----
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 202496172059..d4d69c0e001e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1095,6 +1095,8 @@ struct btrfs_fs_info {
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
=20
+	struct lockdep_map btrfs_trans_num_writers_map;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
@@ -1175,6 +1177,51 @@ enum {
 	BTRFS_ROOT_UNFINISHED_DROP,
 };
=20
+/*
+ * Lockdep annotation for wait events.
+ *
+ * @b: The struct where the lockdep map is defined
+ * @lock: The lockdep map corresponding to a wait event
+ *
+ * This macro is used to annotate a wait event. In this case a thread ac=
quires
+ * the lockdep map as writer (exclusive lock) because it has to block un=
til all
+ * the threads that hold the lock as readers signal the condition for th=
e wait
+ * event and release their locks.
+ */
+#define btrfs_might_wait_for_event(b, lock)					\
+	do {									\
+		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_);			\
+		rwsem_release(&b->lock##_map, _THIS_IP_);			\
+	} while (0)
+
+/*
+ * Protection for the resource/condition of a wait event.
+ *
+ * @b: The struct where the lockdep map is defined
+ * @lock: The lockdep map corresponding to a wait event
+ *
+ * Many threads can modify the condition for the wait event at the same =
time
+ * and signal the threads that block on the wait event. The threads that
+ * modify the condition and do the signaling acquire the lock as readers
+ * (shared lock).
+ */
+#define btrfs_lockdep_acquire(b, lock)						\
+	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
+
+/*
+ * Used after signaling the condition for a wait event to release the
+ * lockdep map held by a reader thread.
+ */
+#define btrfs_lockdep_release(b, lock)						\
+	rwsem_release(&b->lock##_map, _THIS_IP_)
+
+/* Initialization of the lockdep map */
+#define btrfs_lockdep_init_map(b, lock)                                 =
       \
+	do {									\
+		static struct lock_class_key lock##_key;			\
+		lockdep_init_map(&b->lock##_map, #lock, &lock##_key, 0);	\
+	} while (0)
+
 static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_i=
nfo)
 {
 	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3fac429cf8a4..38831c730d61 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3074,6 +3074,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	mutex_init(&fs_info->zoned_data_reloc_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
=20
+	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_writers);
+
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0bec10740ad3..d8287ec890bc 100644
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
@@ -1022,6 +1027,9 @@ static int __btrfs_end_transaction(struct btrfs_tra=
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
@@ -1994,6 +2002,12 @@ static void cleanup_transaction(struct btrfs_trans=
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
@@ -2222,7 +2236,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 			btrfs_put_transaction(prev_trans);
 			if (ret)
-				goto cleanup_transaction;
+				goto lockdep_release;
 		} else {
 			spin_unlock(&fs_info->trans_lock);
 		}
@@ -2236,7 +2250,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 		 */
 		if (BTRFS_FS_ERROR(fs_info)) {
 			ret =3D -EROFS;
-			goto cleanup_transaction;
+			goto lockdep_release;
 		}
 	}
=20
@@ -2250,19 +2264,21 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)
=20
 	ret =3D btrfs_start_delalloc_flush(fs_info);
 	if (ret)
-		goto cleanup_transaction;
+		goto lockdep_release;
=20
 	ret =3D btrfs_run_delayed_items(trans);
 	if (ret)
-		goto cleanup_transaction;
+		goto lockdep_release;
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
@@ -2284,6 +2300,14 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
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
@@ -2515,6 +2539,9 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	cleanup_transaction(trans, ret);
=20
 	return ret;
+lockdep_release:
+	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
+	goto cleanup_transaction;
 }
=20
 /*
--=20
2.30.2

