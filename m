Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B757C10B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiGTXnk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 19:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGTXnj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 19:43:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AB474CF
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:43:38 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KNbEiI003411
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:43:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gMFvsFjEsaZp7jFPopi8MWS4yCZAqaN7bsA4eI0zgj4=;
 b=MDx0avUK8j/X/EQwdCOz6MvHHcVf1QI90fgadUfEgdtmF1iXhHkVrEjAEo9sAUSDZJQq
 r3MiHeUhvnazQwYZ42UPdFBGGmLGkY3bRPKGwpvxdTlmcymmrWkoEctVGqK+fOxEEhll
 lqAJbeAvTUOOxgI1vPmRXCyEcyURsiJ7UXk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hdvds3p0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:43:38 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 16:43:36 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 870C325F0C4E; Wed, 20 Jul 2022 16:43:29 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 5/6] btrfs: Change the lockdep class of struct inode's invalidate_lock
Date:   Wed, 20 Jul 2022 16:38:23 -0700
Message-ID: <20220720233818.3107724-6-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720233818.3107724-1-iangelak@fb.com>
References: <20220720233818.3107724-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rNyNgVIybYtWkUKOuQHEhBWzT5XVTPIf
X-Proofpoint-ORIG-GUID: rNyNgVIybYtWkUKOuQHEhBWzT5XVTPIf
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

Reinitialize the class of the lockdep map for
inode->mapping->invalidate_lock in load_free_space_cache() function in
fs/btrfs/free-space-cache.c This will prevent lockdep from producing fals=
e
positives related to execution paths that make use of free space inodes a=
nd
paths that make use of normal inodes.

Specifically, with this change lockdep will create separate lock
dependencies that include the invalidate_lock, in the case that free spac=
e
inodes are used and in the case that normal inodes are used.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/free-space-cache.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 996da650ecdc..a2b2329ae558 100644
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
@@ -924,6 +926,7 @@ int load_free_space_cache(struct btrfs_block_group *b=
lock_group)
 	int ret =3D 0;
 	bool matched;
 	u64 used =3D block_group->used;
+	struct address_space *mapping;
=20
 	/*
 	 * Because we could potentially discard our loaded free space, we want
@@ -983,6 +986,14 @@ int load_free_space_cache(struct btrfs_block_group *=
block_group)
 	}
 	spin_unlock(&block_group->lock);
=20
+	/*
+	 * Reinitialize the class of the inode->mapping->invalidate_lock for fr=
ee
+	 * space inodes to prevent false positives related to locks for normal
+	 * inodes.
+	 */
+	mapping =3D &inode->i_data;
+	lockdep_set_class(&mapping->invalidate_lock, &btrfs_free_space_inode_ke=
y);
+
 	ret =3D __load_free_space_cache(fs_info->tree_root, inode, &tmp_ctl,
 				      path, block_group->start);
 	btrfs_free_path(path);
--=20
2.30.2

