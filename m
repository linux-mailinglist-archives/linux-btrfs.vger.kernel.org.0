Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014457C0FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiGTXkh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGTXkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 19:40:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F8193D7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:40:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26KNbEmS003861
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:40:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pasPdKQrf9ueNMTTXTaSsfD7PEdDCPwshkXwCBTGkXo=;
 b=pgWO5frBCCOMt5ppX7bueYHfq4myMdOZr2HQx7JINHtaZRdZd2Z6Mcg39dpfYvAorHOm
 cYlzszVp75/MkzU3Eqecac5Rs0Ba5Fd85AU0nEjVEwJdd6qmcvAQsR44Yz2iNhHSjt96
 7Gn3bQ3GTzm8PsdPh4RicogCS1iXjLidQPA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hdv8fbnbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:40:34 -0700
Received: from twshared33626.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 16:40:31 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 0300C25F0895; Wed, 20 Jul 2022 16:40:31 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 2/6] btrfs: Add a lockdep model for the num_extwriters wait event
Date:   Wed, 20 Jul 2022 16:38:17 -0700
Message-ID: <20220720233818.3107724-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720233818.3107724-1-iangelak@fb.com>
References: <20220720233818.3107724-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eoFNC4XOgByPU3f-sxi0H8x1MEnh4MLU
X-Proofpoint-ORIG-GUID: eoFNC4XOgByPU3f-sxi0H8x1MEnh4MLU
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
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/transaction.c | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d4d69c0e001e..5fcdd54994f9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1096,6 +1096,7 @@ struct btrfs_fs_info {
 	struct btrfs_commit_stats commit_stats;
=20
 	struct lockdep_map btrfs_trans_num_writers_map;
+	struct lockdep_map btrfs_trans_num_extwriters_map;
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 38831c730d61..43330a92e7ae 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3075,6 +3075,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	seqlock_init(&fs_info->profiles_lock);
=20
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_writers);
+	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
=20
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d8287ec890bc..c9751a05c029 100644
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
@@ -1028,6 +1032,7 @@ static int __btrfs_end_transaction(struct btrfs_tra=
ns_handle *trans,
=20
 	cond_wake_up(&cur_trans->writer_wait);
=20
+	btrfs_lockdep_release(info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_release(info, btrfs_trans_num_writers);
=20
 	btrfs_put_transaction(cur_trans);
@@ -2270,6 +2275,13 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
 	if (ret)
 		goto lockdep_release;
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
@@ -2540,6 +2552,7 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
=20
 	return ret;
 lockdep_release:
+	btrfs_lockdep_release(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 	goto cleanup_transaction;
 }
--=20
2.30.2

