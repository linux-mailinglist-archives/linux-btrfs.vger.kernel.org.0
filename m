Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A75EADFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIZRTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIZRSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 13:18:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85768AC3B2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 09:32:06 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QA7RmZ006498
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 09:32:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=LPu2KRvEFC8q5OCnxzTBQK7+y1wJoIPYo/R1s8RLiQw=;
 b=FF5eKlo0zXjS4QGMRMKdb+8LZEwR+dPKAWwdj/DKx3D0sT5ipK+YqrNaOn36ilUwZ7ex
 6I1HnJjyWhxOhHaXPqh9Iva25RdqacQJZ9AoHt9F1KSiKScEdzByvmMEMIbJovM1T2M5
 T5hsuC+7gNcTLFSBZPxb8mDRZtZ5pu6d8mM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsyn045xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 09:32:05 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 09:32:04 -0700
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 7099A2A55C1A; Mon, 26 Sep 2022 09:31:58 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <kernel-team@fb.com>, <linux-btrfs@vger.kernel.org>
CC:     <shr@fb.com>, <axboe@kernel.dk>, <josef@toxicpanda.com>,
        <dan.carpenter@oracle.com>, <dsterba@suse.cz>,
        <fdmanana@kernel.org>
Subject: [PATCH v1] btrfs: fix for refcount leak in btrfs_do_write_iter()
Date:   Mon, 26 Sep 2022 09:31:50 -0700
Message-ID: <20220926163150.1535808-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Fh_6K107DkqJPdtQ4ElPlqDYdx01olYm
X-Proofpoint-ORIG-GUID: Fh_6K107DkqJPdtQ4ElPlqDYdx01olYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The patch "btrfs: enable nowait async buffered writes" introduced a
potential leak in btrfs_do_write_iter() that the count for sync_writers
is increased, but not decreased.

This commit addresses this problem.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 16052903fa82..c5ea8e545641 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2106,14 +2106,13 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, s=
truct iov_iter *from,
 	 */
 	if (BTRFS_FS_ERROR(inode->root->fs_info))
 		return -EROFS;
+	if (encoded && (iocb->ki_flags & IOCB_NOWAIT))
+		return -EOPNOTSUPP;
=20
 	if (sync)
 		atomic_inc(&inode->sync_writers);
=20
 	if (encoded) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			return -EOPNOTSUPP;
-
 		num_written =3D btrfs_encoded_write(iocb, from, encoded);
 		num_sync =3D encoded->len;
 	} else if (iocb->ki_flags & IOCB_DIRECT) {

base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
--=20
2.30.2

