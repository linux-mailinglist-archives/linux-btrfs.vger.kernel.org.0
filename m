Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79C580733
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiGYWSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiGYWSW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:18:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A84252A7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:18:21 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PJWooj020320
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:18:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=384HqbqX6zimTRnWCEMfli1uuWqWBCYS9MyT8G9aWUo=;
 b=QzDsngGgiLvik6Hccyp3Ie2oyLGkBX5utZo7P9BoNcJxF3qcxs68j+f6RfVmq4njJhr5
 l+GmjLH/bw7PDK2ns7f/DjTHVPAoMfm6KMfDGPSogcLIdEfW1WCTdIGI97pvfPDG6Dcj
 +oObob9eiILC7BbWgexH5mzwurOdMFdjybE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hge3qmh2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:18:21 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 15:18:20 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 8BAF62928174; Mon, 25 Jul 2022 15:18:14 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 7/7] btrfs: Add a lockdep annotation for the ordered extents wait event
Date:   Mon, 25 Jul 2022 15:11:59 -0700
Message-ID: <20220725221150.3959022-8-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725221150.3959022-1-iangelak@fb.com>
References: <20220725221150.3959022-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Q5vjPmOFOl78mhgE-OuB7p4kChnndlwy
X-Proofpoint-ORIG-GUID: Q5vjPmOFOl78mhgE-OuB7p4kChnndlwy
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

This wait event is very similar to the pending ordered wait event in the
sense that it occurs in a different context than the condition signaling
for the event. The signaling occurs in btrfs_remove_ordered_extent() whil=
e
the wait event is implemented in btrfs_start_ordered_extent() in
fs/btrfs/ordered-data.c

However, in this case a thread must not acquire the lockdep map for the
ordered extents wait event when the ordered extent is related to a free
space inode. That is because lockdep creates dependencies between locks
acquired both in execution paths related to normal inodes and paths relat=
ed
to free space inodes, thus leading to false positives.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h        |  1 +
 fs/btrfs/disk-io.c      |  1 +
 fs/btrfs/inode.c        | 13 +++++++++++++
 fs/btrfs/ordered-data.c | 18 ++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 51d834543ae0..1da86a54324b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1099,6 +1099,7 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_num_extwriters_map;
 	struct lockdep_map btrfs_state_change_map[4];
 	struct lockdep_map btrfs_trans_pending_ordered_map;
+	struct lockdep_map btrfs_ordered_extent_map;
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 07c0fd9af83f..9325cfa57a25 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3077,6 +3077,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_writers);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
+	btrfs_lockdep_init_map(fs_info, btrfs_ordered_extent);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
 				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ecc5fa3343fc..8fc1e3b6e00c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3226,6 +3226,8 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_ex=
tent *ordered_extent)
 		clear_bits |=3D EXTENT_DELALLOC_NEW;
=20
 	freespace_inode =3D btrfs_is_free_space_inode(inode);
+	if (!freespace_inode)
+		btrfs_lockdep_acquire(fs_info, btrfs_ordered_extent);
=20
 	if (test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags)) {
 		ret =3D -EIO;
@@ -8951,6 +8953,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_inode *inode =3D BTRFS_I(vfs_inode);
 	struct btrfs_root *root =3D inode->root;
+	bool freespace_inode;
=20
 	WARN_ON(!hlist_empty(&vfs_inode->i_dentry));
 	WARN_ON(vfs_inode->i_data.nrpages);
@@ -8972,6 +8975,12 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	if (!root)
 		return;
=20
+	/*
+	 * If this is a free space inode do not take the ordered extents lockde=
p
+	 * map.
+	 */
+	freespace_inode =3D btrfs_is_free_space_inode(inode);
+
 	while (1) {
 		ordered =3D btrfs_lookup_first_ordered_extent(inode, (u64)-1);
 		if (!ordered)
@@ -8980,6 +8989,10 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 			btrfs_err(root->fs_info,
 				  "found ordered extent %llu %llu on inode cleanup",
 				  ordered->file_offset, ordered->num_bytes);
+
+			if (!freespace_inode)
+				btrfs_lockdep_acquire(root->fs_info, btrfs_ordered_extent);
+
 			btrfs_remove_ordered_extent(inode, ordered);
 			btrfs_put_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2a4cb6db42d1..eb24a6d20ff8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -524,6 +524,13 @@ void btrfs_remove_ordered_extent(struct btrfs_inode =
*btrfs_inode,
 	struct btrfs_fs_info *fs_info =3D root->fs_info;
 	struct rb_node *node;
 	bool pending;
+	bool freespace_inode;
+
+	/*
+	 * If this is a free space inode the thread has not acquired the ordere=
d
+	 * extents lockdep map.
+	 */
+	freespace_inode =3D btrfs_is_free_space_inode(btrfs_inode);
=20
 	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
 	/* This is paired with btrfs_add_ordered_extent. */
@@ -597,6 +604,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *=
btrfs_inode,
 	}
 	spin_unlock(&root->ordered_extent_lock);
 	wake_up(&entry->wait);
+	if (!freespace_inode)
+		btrfs_lockdep_release(fs_info, btrfs_ordered_extent);
 }
=20
 static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
@@ -715,9 +724,16 @@ void btrfs_start_ordered_extent(struct btrfs_ordered=
_extent *entry, int wait)
 	u64 start =3D entry->file_offset;
 	u64 end =3D start + entry->num_bytes - 1;
 	struct btrfs_inode *inode =3D BTRFS_I(entry->inode);
+	bool freespace_inode;
=20
 	trace_btrfs_ordered_extent_start(inode, entry);
=20
+	/*
+	 * If this is a free space inode do not take the ordered extents lockde=
p
+	 * map.
+	 */
+	freespace_inode =3D btrfs_is_free_space_inode(inode);
+
 	/*
 	 * pages in the range can be dirty, clean or writeback.  We
 	 * start IO on any dirty ones so the wait doesn't stall waiting
@@ -726,6 +742,8 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_=
extent *entry, int wait)
 	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
 		filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
 	if (wait) {
+		if (!freespace_inode)
+			btrfs_might_wait_for_event(inode->root->fs_info, btrfs_ordered_extent=
);
 		wait_event(entry->wait, test_bit(BTRFS_ORDERED_COMPLETE,
 						 &entry->flags));
 	}
--=20
2.30.2

