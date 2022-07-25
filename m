Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA594580729
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiGYWQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiGYWQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:16:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B14824970
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:16:07 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26PJWfYE011997
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:16:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/MkwDXrTlpMVmnZ8LAYDtLnDrEaegsxFEdflyktoht8=;
 b=CG6LRd8K/p+Hyr1icjoTYTpik+XVmd4M8i7BUGUB1JjRfSc+CixITIHGR2iRi5Kb17oj
 oOk7IhbjF1Mf+34uozjERnQs6IEN9KyTU5yq4yh1tsDgueW7/WsgXgAf/8hqv1feLi3x
 xGIuhGvyQ63IyosaQm9CjwoCE9ghEe3NVxo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hgjrcuqd9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:16:06 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 15:15:39 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id E62132927DCD; Mon, 25 Jul 2022 15:15:23 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 1/7] btrfs: Add macros for annotating wait events with lockdep
Date:   Mon, 25 Jul 2022 15:11:46 -0700
Message-ID: <20220725221150.3959022-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725221150.3959022-1-iangelak@fb.com>
References: <20220725221150.3959022-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sx_hv7wGZH1EGmWdEMHBZ5hXipYrbozU
X-Proofpoint-GUID: sx_hv7wGZH1EGmWdEMHBZ5hXipYrbozU
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

Introduce four macros that are used to annotate wait events in btrfs code
with lockdep; 1) the btrfs_lockdep_init_map, 2) the btrfs_lockdep_acquire=
,
3) the btrfs_lockdep_release, and 4) the btrfs_might_wait_for_event macro=
s.

The btrfs_lockdep_init_map macro is used to initialize a lockdep map.

The btrfs_lockdep_<acquire,release> macros are used by threads to take th=
e
lockdep map as readers (shared lock) and release it, respectively.

The btrfs_might_wait_for_event macro is used by threads to take the
lockdep map as writers (exclusive lock) and release it.

In general, the lockdep annotation for wait events works as follows:

The condition for a wait event can be modified and signaled at the same
time by multiple threads. These threads hold the lockdep map as readers
when they enter a context in which blocking would prevent signaling the
condition. Frequently, this occurs when a thread violates a condition
(lockdep map acquire), before restoring it and signaling it at a later
point (lockdep map release).

The threads that block on the wait event take the lockdep map as writers
(exclusive lock). These threads have to block until all the threads that
hold the lockdep map as readers signal the condition for the wait event a=
nd
release the lockdep map.

The lockdep annotation is used to warn about potential deadlock scenarios
that involve the threads that modify and signal the wait event condition
and threads that block on the wait event. A simple example is illustrated
below:

Without lockdep:

TA                                        TB
cond =3D false
                                          lock(A)
                                          wait_event(w, cond)
                                          unlock(A)
lock(A)
cond =3D true
signal(w)
unlock(A)

With lockdep:

TA                                        TB
rwsem_acquire_read(lockdep_map)
cond =3D false
                                          lock(A)
                                          rwsem_acquire(lockdep_map)
                                          rwsem_release(lockdep_map)
                                          wait_event(w, cond)
                                          unlock(A)
lock(A)
cond =3D true
signal(w)
unlock(A)
rwsem_release(lockdep_map)

In the second case, with the lockdep annotation, lockdep would warn about
an ABBA deadlock, while the first case would just deadlock at some point.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db85b9dc7ed..f2169d01c66e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1175,6 +1175,51 @@ enum {
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
--=20
2.30.2

