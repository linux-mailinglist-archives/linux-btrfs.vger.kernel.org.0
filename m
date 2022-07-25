Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE45580732
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiGYWSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiGYWSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:18:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88F252B1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:18:04 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26PL2Pgh030227
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:18:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7CLCRRMW+xamwjHUvhRh7HKjumkNRoCa01fQuohFF3U=;
 b=JSz6vA8P6mRfYx6KvEj84oBEchKq4+9ZEg0dO37bAQ+k/38CLYD+hldoYSTux+H9+r/K
 Z3VAkN64lTx8lPcGXCDhOZMlVQJBQ+kEZI/99BO6vUYFrPaDL+rl/paJPy1HBjml01ip
 eq3nB+BzPY+nRnFb5Y/PyhodX1Jst0txCbA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hj2r0rf1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:18:03 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 15:18:02 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 4AAC9292810C; Mon, 25 Jul 2022 15:17:51 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 6/7] btrfs: Change the lockdep class of struct inode's invalidate_lock
Date:   Mon, 25 Jul 2022 15:11:57 -0700
Message-ID: <20220725221150.3959022-7-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725221150.3959022-1-iangelak@fb.com>
References: <20220725221150.3959022-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: H5QEyvXyICIbpP9FkIvRyk9pYqVzwWUp
X-Proofpoint-GUID: H5QEyvXyICIbpP9FkIvRyk9pYqVzwWUp
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

Reinitialize the class of the lockdep map for struct inode's
mapping->invalidate_lock in load_free_space_cache() function in
fs/btrfs/free-space-cache.c This will prevent lockdep from producing fals=
e
positives related to execution paths that make use of free space inodes a=
nd
paths that make use of normal inodes.

Specifically, with this change lockdep will create separate lock
dependencies that include the invalidate_lock, in the case that free spac=
e
inodes are used and in the case that normal inodes are used.

The lockdep class for this lock was first initialized in
inode_init_always() in fs/inode.c.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/free-space-cache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 996da650ecdc..e6ffe519e5c4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -914,6 +914,8 @@ static int copy_free_space_cache(struct btrfs_block_g=
roup *block_group,
 	return ret;
 }
=20
+static struct lock_class_key btrfs_free_space_inode_key;
+
 int load_free_space_cache(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
@@ -983,6 +985,14 @@ int load_free_space_cache(struct btrfs_block_group *=
block_group)
 	}
 	spin_unlock(&block_group->lock);
=20
+	/*
+	 * Reinitialize the class of struct inode's mapping->invalidate_lock fo=
r
+	 * free space inodes to prevent false positives related to locks for no=
rmal
+	 * inodes.
+	 */
+	lockdep_set_class(&(&inode->i_data)->invalidate_lock,
+			  &btrfs_free_space_inode_key);
+
 	ret =3D __load_free_space_cache(fs_info->tree_root, inode, &tmp_ctl,
 				      path, block_group->start);
 	btrfs_free_path(path);
--=20
2.30.2

