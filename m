Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587558072E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiGYWRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiGYWRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:17:24 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6924F3D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:17:22 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PJWpQI011856
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:17:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KvCrOsllWy+K6WORgjvxTO2zupjxHIz1/bC9sBLqSE0=;
 b=AWz2+FOlNbxi85F6zfmVfxthTB5JiaVJUtww9R84JvdIVYoDsKv8qWASl2lIW9YhDIF7
 sI6XiB8Hiam4yp8GC/7GJc+h0UsENvA7LxZFPFPawCS1npFpWj+7bNBxEzK4SJGjOim7
 k8d8Cbtdhm+x2TT2iMdzWhE0gVBOix6K0EA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgetsvdw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:17:21 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 15:17:19 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 9C7B02928044; Mon, 25 Jul 2022 15:17:18 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 5/7] btrfs: Add a lockdep annotation for the pending_ordered wait event
Date:   Mon, 25 Jul 2022 15:11:54 -0700
Message-ID: <20220725221150.3959022-6-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725221150.3959022-1-iangelak@fb.com>
References: <20220725221150.3959022-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k3HA9R51C1Q-CSWdloFMYhTsFiqxVxAR
X-Proofpoint-GUID: k3HA9R51C1Q-CSWdloFMYhTsFiqxVxAR
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

In contrast to the num_writers and num_extwriters wait events, the
condition for the pending ordered wait event is signaled in a different
context from the wait event itself. The condition signaling occurs in
btrfs_remove_ordered_extent() in fs/btrfs/ordered-data.c while the wait
event is implemented in btrfs_commit_transaction() in
fs/btrfs/transaction.c

Thus the thread signaling the condition has to acquire the lockdep map as=
 a
reader at the start of btrfs_remove_ordered_extent() and release it after
it has signaled the condition. In this case some dependencies might be le=
ft
out due to the placement of the annotation, but it is better than no
annotation at all.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h        | 1 +
 fs/btrfs/disk-io.c      | 1 +
 fs/btrfs/ordered-data.c | 3 +++
 fs/btrfs/transaction.c  | 1 +
 4 files changed, 6 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1cd9578223e4..51d834543ae0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1098,6 +1098,7 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_num_writers_map;
 	struct lockdep_map btrfs_trans_num_extwriters_map;
 	struct lockdep_map btrfs_state_change_map[4];
+	struct lockdep_map btrfs_trans_pending_ordered_map;
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b2ceaa65eed1..07c0fd9af83f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3076,6 +3076,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
=20
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_writers);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
+	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
 				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1952ac85222c..2a4cb6db42d1 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -525,6 +525,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *=
btrfs_inode,
 	struct rb_node *node;
 	bool pending;
=20
+	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
 	/* This is paired with btrfs_add_ordered_extent. */
 	spin_lock(&btrfs_inode->lock);
 	btrfs_mod_outstanding_extents(btrfs_inode, -1);
@@ -580,6 +581,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *=
btrfs_inode,
 		}
 	}
=20
+	btrfs_lockdep_release(fs_info, btrfs_trans_pending_ordered);
+
 	spin_lock(&root->ordered_extent_lock);
 	list_del_init(&entry->root_extent_list);
 	root->nr_ordered_extents--;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f2ee407564da..33c14ff4a726 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2316,6 +2316,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
 	 * transaction. Otherwise if this transaction commits before the ordere=
d
 	 * extents complete we lose logged data after a power failure.
 	 */
+	btrfs_might_wait_for_event(fs_info, btrfs_trans_pending_ordered);
 	wait_event(cur_trans->pending_wait,
 		   atomic_read(&cur_trans->pending_ordered) =3D=3D 0);
=20
--=20
2.30.2

