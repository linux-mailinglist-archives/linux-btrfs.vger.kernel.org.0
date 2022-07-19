Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2200D5791BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 06:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiGSEQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 00:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiGSEQm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 00:16:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F13AE6D
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 21:16:41 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26IKFm1A024990
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 21:16:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=65IS/sjc2SHZYogNDyf0HdEdP3QKXpUo+pPGv+kP64A=;
 b=UaOwkh/14vlPXdz/ptFM5qtBP6gSqLSSfUwjTB8YKRMWUTANOoSBxBwPupNkROy+NoIY
 Ylk+yvjEhNoIhxe2ZQhaKfHv8VtsjlO62/aKXBwDnMU5BlKksni0oAwu86DmCx3MW5vJ
 imx+IxXIrbIi87rFQPySKBd4qIkIqfVoDCw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hded7a592-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 21:16:40 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 21:16:39 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 3815E24A8FBB; Mon, 18 Jul 2022 21:16:34 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 3/5] btrfs: Add lockdep models for the transaction states wait events
Date:   Mon, 18 Jul 2022 21:09:56 -0700
Message-ID: <20220719040954.3964407-4-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719040954.3964407-1-iangelak@fb.com>
References: <20220719040954.3964407-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HIYZzC53iYkr71_Avyuku3Gal5_c_5sk
X-Proofpoint-ORIG-GUID: HIYZzC53iYkr71_Avyuku3Gal5_c_5sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a lockdep annotation for the transaction states that have wait
events; 1) TRANS_STATE_COMMIT_START, 2) TRANS_STATE_UNBLOCKED, 3)
TRANS_STATE_SUPER_COMMITTED, and 4) TRANS_STATE_COMPLETED in
fs/btrfs/transaction.c.

With the exception of the lockdep annotation for TRANS_STATE_COMMIT_START
the transaction thread has to acquire the lockdep maps for the transactio=
n
states as reader after the lockdep map for num_writers is released so tha=
t
lockdep does not complain.


Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h       | 20 +++++++++++++++
 fs/btrfs/disk-io.c     | 17 +++++++++++++
 fs/btrfs/transaction.c | 57 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 586756f831e5..e6c7cafcd296 100644
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
 #define btrfs_might_wait_for_event(b, lock) \
 	do { \
 		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
@@ -1190,6 +1198,18 @@ enum {
 #define btrfs_lockdep_release(b, lock) \
 	rwsem_release(&b->lock##_map, _THIS_IP_)
=20
+#define btrfs_might_wait_for_state(b, i) \
+	do { \
+		rwsem_acquire(&b->btrfs_state_change_map[i], 0, 0, _THIS_IP_); \
+		rwsem_release(&b->btrfs_state_change_map[i], _THIS_IP_); \
+	} while (0)
+
+#define btrfs_trans_state_lockdep_acquire(b, i) \
+	rwsem_acquire_read(&b->btrfs_state_change_map[i], 0, 0, _THIS_IP_)
+
+#define btrfs_trans_state_lockdep_release(b, i) \
+	rwsem_release(&b->btrfs_state_change_map[i], _THIS_IP_)
+
 static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_i=
nfo)
 {
 	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b1193584ba49..be5cf86fa992 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3048,6 +3048,10 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_i=
nfo)
 {
 	static struct lock_class_key btrfs_trans_num_writers_key;
 	static struct lock_class_key btrfs_trans_num_extwriters_key;
+	static struct lock_class_key btrfs_trans_commit_start_key;
+	static struct lock_class_key btrfs_trans_unblocked_key;
+	static struct lock_class_key btrfs_trans_sup_committed_key;
+	static struct lock_class_key btrfs_trans_completed_key;
=20
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
@@ -3084,6 +3088,19 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_i=
nfo)
 					 "btrfs_trans_num_extwriters",
 					 &btrfs_trans_num_extwriters_key, 0);
=20
+	lockdep_init_map(&fs_info->btrfs_state_change_map[0],
+					 "btrfs_trans_commit_start",
+					 &btrfs_trans_commit_start_key, 0);
+	lockdep_init_map(&fs_info->btrfs_state_change_map[1],
+					 "btrfs_trans_unblocked",
+					 &btrfs_trans_unblocked_key, 0);
+	lockdep_init_map(&fs_info->btrfs_state_change_map[2],
+					 "btrfs_trans_sup_commited",
+					 &btrfs_trans_sup_committed_key, 0);
+	lockdep_init_map(&fs_info->btrfs_state_change_map[3],
+					 "btrfs_trans_completed",
+					 &btrfs_trans_completed_key, 0);
+
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c9751a05c029..e4efaa27ec17 100644
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
@@ -949,6 +950,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_in=
fo, u64 transid)
 			goto out;  /* nothing committing|committed */
 	}
=20
+	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
 	btrfs_put_transaction(cur_trans);
 out:
@@ -1980,6 +1982,7 @@ void btrfs_commit_transaction_async(struct btrfs_tr=
ans_handle *trans)
 	 * Wait for the current transaction commit to start and block
 	 * subsequent transaction joins
 	 */
+	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
 	wait_event(fs_info->transaction_blocked_wait,
 		   cur_trans->state >=3D TRANS_STATE_COMMIT_START ||
 		   TRANS_ABORTED(cur_trans));
@@ -2137,14 +2140,16 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
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
@@ -2160,8 +2165,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
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
@@ -2192,8 +2196,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
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
@@ -2209,7 +2212,17 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
=20
 		if (trans->in_fsync)
 			want_state =3D TRANS_STATE_SUPER_COMMITTED;
+
+		btrfs_trans_state_lockdep_release(fs_info,
+						  BTRFS_LOCKDEP_TRANS_COMMIT_START);
 		ret =3D btrfs_end_transaction(trans);
+
+		if (want_state =3D=3D TRANS_STATE_COMPLETED)
+			btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
+		else
+			btrfs_might_wait_for_state(fs_info,
+						   BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
+
 		wait_for_commit(cur_trans, want_state);
=20
 		if (TRANS_ABORTED(cur_trans))
@@ -2222,6 +2235,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	cur_trans->state =3D TRANS_STATE_COMMIT_START;
 	wake_up(&fs_info->transaction_blocked_wait);
+	btrfs_trans_state_lockdep_release(fs_info,
+					  BTRFS_LOCKDEP_TRANS_COMMIT_START);
=20
 	if (cur_trans->list.prev !=3D &fs_info->trans_list) {
 		enum btrfs_trans_state want_state =3D TRANS_STATE_COMPLETED;
@@ -2235,6 +2250,12 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 			refcount_inc(&prev_trans->use_count);
 			spin_unlock(&fs_info->trans_lock);
=20
+			if (want_state =3D=3D TRANS_STATE_COMPLETED)
+				btrfs_might_wait_for_state(fs_info,
+							   BTRFS_LOCKDEP_TRANS_COMPLETED);
+			else
+				btrfs_might_wait_for_state(fs_info,
+							   BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
 			wait_for_commit(prev_trans, want_state);
=20
 			ret =3D READ_ONCE(prev_trans->aborted);
@@ -2323,6 +2344,15 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 	wait_event(cur_trans->writer_wait,
 		   atomic_read(&cur_trans->num_writers) =3D=3D 1);
=20
+	/*
+	 * Make lockdep happy by acquiring the state locks after
+	 * btrfs_trans_num_writers is released.
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
@@ -2332,6 +2362,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	if (TRANS_ABORTED(cur_trans)) {
 		ret =3D cur_trans->aborted;
+		btrfs_trans_state_lockdep_release(fs_info,
+						  BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 		goto scrub_continue;
 	}
 	/*
@@ -2466,6 +2498,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	mutex_unlock(&fs_info->reloc_mutex);
=20
 	wake_up(&fs_info->transaction_wait);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKE=
D);
=20
 	ret =3D btrfs_write_and_wait_transaction(trans);
 	if (ret) {
@@ -2497,6 +2530,8 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	 */
 	cur_trans->state =3D TRANS_STATE_SUPER_COMMITTED;
 	wake_up(&cur_trans->commit_wait);
+	btrfs_trans_state_lockdep_release(fs_info,
+					  BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
=20
 	btrfs_finish_extent_commit(trans);
=20
@@ -2510,6 +2545,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	 */
 	cur_trans->state =3D TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETE=
D);
=20
 	spin_lock(&fs_info->trans_lock);
 	list_del_init(&cur_trans->list);
@@ -2538,7 +2574,11 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
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
@@ -2555,6 +2595,11 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
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

