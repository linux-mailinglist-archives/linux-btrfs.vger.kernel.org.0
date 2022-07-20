Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC257C106
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiGTXm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 19:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiGTXm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 19:42:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB9E65586
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:42:57 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26KNbFi2003939
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SStmPjr8A6+dvHoxVwu8LHxnZiBZJHkmzW+YIbd9kCU=;
 b=WFz6KKxdd3qi6rqGiU9f1TloR2b8eepgWaxuhJrF6kQVkCCEhlZwDFzl58ihRoWoJkza
 e1X3/zNVaHx/YsUyLAaWnrs1pNGeU6F2ajEZmxuKS+EPt+jG/vcuQgZxQ5B1Naxoe3yZ
 iGmP9TTjfECApY0GyEcYBPly5eAS0GlXhos= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hdv8fbnpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:42:56 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 16:42:55 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id E607D25F0B2A; Wed, 20 Jul 2022 16:42:49 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 4/6] btrfs: Add a lockdep model for the pending_ordered wait event
Date:   Wed, 20 Jul 2022 16:38:21 -0700
Message-ID: <20220720233818.3107724-5-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720233818.3107724-1-iangelak@fb.com>
References: <20220720233818.3107724-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DY0rAI8dNyBQH27WRzU78WqW3S2Yy4on
X-Proofpoint-ORIG-GUID: DY0rAI8dNyBQH27WRzU78WqW3S2Yy4on
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

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h        | 1 +
 fs/btrfs/disk-io.c      | 1 +
 fs/btrfs/ordered-data.c | 3 +++
 fs/btrfs/transaction.c  | 1 +
 4 files changed, 6 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8f86e8d5e810..d83950ac10ab 100644
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

