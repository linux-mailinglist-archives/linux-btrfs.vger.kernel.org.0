Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3F58072D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiGYWRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGYWRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:17:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5697924BC0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:17:10 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PJWelA009490
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=C2REDjlnRNrzo4YPoQkreAqWj3Q/xVJ5X2N5szQFMOo=;
 b=cX9ojkhBS30lwbbHRmGeJlNaesr5oLPikYcujUUPQSxkxZxZrSkFVe7McGagGLwsKC8T
 BY8xBT3gpyIDsVLcEDuubVN7EPRNwWWEFHWVVT6qGWqp1gd2kBdjGOrgUvxXfFsrwQ2C
 x9qyR78d3e82tkh4fNcoBNrExm1Aejyp9As= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hhxbwjjwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:17:10 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 15:17:08 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 2F57B2927F98; Mon, 25 Jul 2022 15:16:57 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 4/7] btrfs: Add lockdep annotations for the transaction states wait events
Date:   Mon, 25 Jul 2022 15:11:52 -0700
Message-ID: <20220725221150.3959022-5-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725221150.3959022-1-iangelak@fb.com>
References: <20220725221150.3959022-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: H0LsLHxyaGBFfKsNu-Qrh-eqiwy3VbRT
X-Proofpoint-ORIG-GUID: H0LsLHxyaGBFfKsNu-Qrh-eqiwy3VbRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add lockdep annotations for the transaction states that have wait
events; 1) TRANS_STATE_COMMIT_START, 2) TRANS_STATE_UNBLOCKED, 3)
TRANS_STATE_SUPER_COMMITTED, and 4) TRANS_STATE_COMPLETED in
fs/btrfs/transaction.c.

The new macros introduced here to annotate the transaction states wait
events have the same effect as the generic lockdep annotation macros.

With the exception of the lockdep annotation for TRANS_STATE_COMMIT_START
the transaction thread has to acquire the lockdep maps for the transactio=
n
states as reader after the lockdep map for num_writers is released so tha=
t
lockdep does not complain.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h       | 32 ++++++++++++++++++++++++
 fs/btrfs/disk-io.c     |  8 ++++++
 fs/btrfs/transaction.c | 55 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 883e6e725b8f..1cd9578223e4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1097,6 +1097,7 @@ struct btrfs_fs_info {
=20
 	struct lockdep_map btrfs_trans_num_writers_map;
 	struct lockdep_map btrfs_trans_num_extwriters_map;
+	struct lockdep_map btrfs_state_change_map[4];
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
@@ -1178,6 +1179,13 @@ enum {
 	BTRFS_ROOT_UNFINISHED_DROP,
 };
=20
+enum btrfs_lockdep_trans_states {
+	BTRFS_LOCKDEP_TRANS_COMMIT_START,
+	BTRFS_LOCKDEP_TRANS_UNBLOCKED,
+	BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED,
+	BTRFS_LOCKDEP_TRANS_COMPLETED,
+};
+
 /*
  * Lockdep annotation for wait events.
  *
@@ -1216,6 +1224,22 @@ enum {
 #define btrfs_lockdep_release(b, lock)						\
 	rwsem_release(&b->lock##_map, _THIS_IP_)
=20
+/*
+ * Macros for the transaction states wait events, similar to the generic=
 wait
+ * event macros.
+ */
+#define btrfs_might_wait_for_state(b, i)					\
+	do {									\
+		rwsem_acquire(&b->btrfs_state_change_map[i], 0, 0, _THIS_IP_);	\
+		rwsem_release(&b->btrfs_state_change_map[i], _THIS_IP_);	\
+	} while (0)
+
+#define btrfs_trans_state_lockdep_acquire(b, i)				\
+	rwsem_acquire_read(&b->btrfs_state_change_map[i], 0, 0, _THIS_IP_)
+
+#define btrfs_trans_state_lockdep_release(b, i)				\
+	rwsem_release(&b->btrfs_state_change_map[i], _THIS_IP_)
+
 /* Initialization of the lockdep map */
 #define btrfs_lockdep_init_map(b, lock)                                 =
       \
 	do {									\
@@ -1223,6 +1247,14 @@ enum {
 		lockdep_init_map(&b->lock##_map, #lock, &lock##_key, 0);	\
 	} while (0)
=20
+/* Initialization of the transaction states lockdep maps. */
+#define btrfs_state_lockdep_init_map(b, lock, state)				\
+	do {									\
+		static struct lock_class_key lock##_key;			\
+		lockdep_init_map(&b->btrfs_state_change_map[state], #lock,	\
+				 &lock##_key, 0);				\
+	} while (0)
+
 static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_i=
nfo)
 {
 	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 43330a92e7ae..b2ceaa65eed1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3076,6 +3076,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_i=
nfo)
=20
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_writers);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
+	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
+				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
+				     BTRFS_LOCKDEP_TRANS_UNBLOCKED);
+	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_super_committed,
+				     BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
+	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_completed,
+				     BTRFS_LOCKDEP_TRANS_COMPLETED);
=20
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c9751a05c029..f2ee407564da 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -550,6 +550,7 @@ static void wait_current_trans(struct btrfs_fs_info *=
fs_info)
 		refcount_inc(&cur_trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
=20
+		btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 		wait_event(fs_info->transaction_wait,
 			   cur_trans->state >=3D TRANS_STATE_UNBLOCKED ||
 			   TRANS_ABORTED(cur_trans));
@@ -868,6 +869,16 @@ static noinline void wait_for_commit(struct btrfs_tr=
ansaction *commit,
 	u64 transid =3D commit->transid;
 	bool put =3D false;
=20
+	/*
+	 * At the moment this function is called with min_state either being
+	 * TRANS_STATE_COMPLETED or TRANS_STATE_SUPER_COMMITTED
+	 */
+	if (min_state =3D=3D TRANS_STATE_COMPLETED)
+		btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
+	else
+		btrfs_might_wait_for_state(fs_info,
+					   BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
+
 	while (1) {
 		wait_event(commit->commit_wait, commit->state >=3D min_state);
 		if (put)
@@ -1980,6 +1991,7 @@ void btrfs_commit_transaction_async(struct btrfs_tr=
ans_handle *trans)
 	 * Wait for the current transaction commit to start and block
 	 * subsequent transaction joins
 	 */
+	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
 	wait_event(fs_info->transaction_blocked_wait,
 		   cur_trans->state >=3D TRANS_STATE_COMMIT_START ||
 		   TRANS_ABORTED(cur_trans));
@@ -2137,14 +2149,16 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)
 	ktime_t interval;
=20
 	ASSERT(refcount_read(&trans->use_count) =3D=3D 1);
+	btrfs_trans_state_lockdep_acquire(fs_info,
+					  BTRFS_LOCKDEP_TRANS_COMMIT_START);
=20
 	/* Stop the commit early if ->aborted is set */
 	if (TRANS_ABORTED(cur_trans)) {
 		ret =3D cur_trans->aborted;
-		btrfs_end_transaction(trans);
-		return ret;
+		goto lockdep_trans_commit_start_release;
 	}
=20
+
 	btrfs_trans_release_metadata(trans);
 	trans->block_rsv =3D NULL;
=20
@@ -2160,8 +2174,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 		 */
 		ret =3D btrfs_run_delayed_refs(trans, 0);
 		if (ret) {
-			btrfs_end_transaction(trans);
-			return ret;
+			goto lockdep_trans_commit_start_release;
 		}
 	}
=20
@@ -2192,8 +2205,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 		if (run_it) {
 			ret =3D btrfs_start_dirty_block_groups(trans);
 			if (ret) {
-				btrfs_end_transaction(trans);
-				return ret;
+				goto lockdep_trans_commit_start_release;
 			}
 		}
 	}
@@ -2209,6 +2221,9 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 		if (trans->in_fsync)
 			want_state =3D TRANS_STATE_SUPER_COMMITTED;
+
+		btrfs_trans_state_lockdep_release(fs_info,
+						  BTRFS_LOCKDEP_TRANS_COMMIT_START);
 		ret =3D btrfs_end_transaction(trans);
 		wait_for_commit(cur_trans, want_state);
=20
@@ -2222,6 +2237,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	cur_trans->state =3D TRANS_STATE_COMMIT_START;
 	wake_up(&fs_info->transaction_blocked_wait);
+	btrfs_trans_state_lockdep_release(fs_info,
+					  BTRFS_LOCKDEP_TRANS_COMMIT_START);
=20
 	if (cur_trans->list.prev !=3D &fs_info->trans_list) {
 		enum btrfs_trans_state want_state =3D TRANS_STATE_COMPLETED;
@@ -2323,6 +2340,17 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 	wait_event(cur_trans->writer_wait,
 		   atomic_read(&cur_trans->num_writers) =3D=3D 1);
=20
+	/*
+	 * Make lockdep happy by acquiring the state locks after
+	 * btrfs_trans_num_writers is released. If we acquired the state locks
+	 * before releasing the btrfs_trans_num_writers lock then lockdep would
+	 * complain because we did not follow the reverse order unlocking rule.
+	 */
+	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETE=
D);
+	btrfs_trans_state_lockdep_acquire(fs_info,
+					  BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
+	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKE=
D);
+
 	/*
 	 * We've started the commit, clear the flag in case we were triggered t=
o
 	 * do an async commit but somebody else started before the transaction
@@ -2332,6 +2360,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	if (TRANS_ABORTED(cur_trans)) {
 		ret =3D cur_trans->aborted;
+		btrfs_trans_state_lockdep_release(fs_info,
+						  BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 		goto scrub_continue;
 	}
 	/*
@@ -2466,6 +2496,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	mutex_unlock(&fs_info->reloc_mutex);
=20
 	wake_up(&fs_info->transaction_wait);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKE=
D);
=20
 	ret =3D btrfs_write_and_wait_transaction(trans);
 	if (ret) {
@@ -2497,6 +2528,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	 */
 	cur_trans->state =3D TRANS_STATE_SUPER_COMMITTED;
 	wake_up(&cur_trans->commit_wait);
+	btrfs_trans_state_lockdep_release(fs_info,
+					  BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
=20
 	btrfs_finish_extent_commit(trans);
=20
@@ -2510,6 +2543,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	 */
 	cur_trans->state =3D TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETE=
D);
=20
 	spin_lock(&fs_info->trans_lock);
 	list_del_init(&cur_trans->list);
@@ -2538,7 +2572,11 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
=20
 unlock_reloc:
 	mutex_unlock(&fs_info->reloc_mutex);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKE=
D);
 scrub_continue:
+	btrfs_trans_state_lockdep_release(fs_info,
+					  BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETE=
D);
 	btrfs_scrub_continue(fs_info);
 cleanup_transaction:
 	btrfs_trans_release_metadata(trans);
@@ -2555,6 +2593,11 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 	btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 	goto cleanup_transaction;
+lockdep_trans_commit_start_release:
+	btrfs_trans_state_lockdep_release(fs_info,
+					  BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_end_transaction(trans);
+	return ret;
 }
=20
 /*
--=20
2.30.2

