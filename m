Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81455791C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 06:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiGSEUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 00:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiGSEUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 00:20:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033DC6475
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 21:20:14 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J2tLQX000922
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 21:20:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VdGRbT3hlA2KvsAFWbBCmwbTClxyj2o+swdk0nMdjG8=;
 b=M+CaWChDS1TmD1+GrRO5JjsDERzaqkrnY4oBx5RqNup4lZLtxere8ifQDm345nwoSiSC
 YrMb020sHfdNySfhhFbo4S/C6Ecxu/e1LQRKdG8tifdMfeHCej4ehbt4g82LQXcPQR54
 R41qrAdNE1mEFM5duq2uUR7EeKLoZUkjiCc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hcs5krr0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 21:20:14 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 21:20:12 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id E800E24A95A3; Mon, 18 Jul 2022 21:20:10 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 5/5] btrfs: Add a lockdep model for the ordered extents wait event
Date:   Mon, 18 Jul 2022 21:10:00 -0700
Message-ID: <20220719040954.3964407-6-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719040954.3964407-1-iangelak@fb.com>
References: <20220719040954.3964407-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GjYSnxC1Wk5PDzFvIqhJs2kXaJBTfCfH
X-Proofpoint-ORIG-GUID: GjYSnxC1Wk5PDzFvIqhJs2kXaJBTfCfH
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

This wait event is very similar to the pending_ordered wait event in the
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

Also to prevent false positives related to free space inodes and normal
inodes, the lockdep map class for the inode->mapping->invalidate_lock is
reinitialized in load_free_space_cache() in fs/btrfs/free-space-cache.c

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h            |  1 +
 fs/btrfs/disk-io.c          |  4 ++++
 fs/btrfs/free-space-cache.c | 11 +++++++++++
 fs/btrfs/inode.c            | 13 +++++++++++++
 fs/btrfs/ordered-data.c     | 18 ++++++++++++++++++
 5 files changed, 47 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 661d19ac41d1..941987ed4c43 100644
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
index e9956cbf653f..8f7a07362efb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3053,6 +3053,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	static struct lock_class_key btrfs_trans_sup_committed_key;
 	static struct lock_class_key btrfs_trans_completed_key;
 	static struct lock_class_key btrfs_trans_pending_ordered_key;
+	static struct lock_class_key btrfs_ordered_extent_key;
=20
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
@@ -3104,6 +3105,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	lockdep_init_map(&fs_info->btrfs_state_change_map[3],
 					 "btrfs_trans_completed",
 					 &btrfs_trans_completed_key, 0);
+	lockdep_init_map(&fs_info->btrfs_ordered_extent_map,
+					 "btrfs_ordered_extent",
+					 &btrfs_ordered_extent_key, 0);
=20
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 996da650ecdc..1e41a01a782b 100644
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
+	 * space inodes to prevent false positives related to the ordered exten=
ts
+	 * lockdep map.
+	 */
+	mapping =3D &inode->i_data;
+	lockdep_set_class(&mapping->invalidate_lock, &btrfs_free_space_inode_ke=
y);
+
 	ret =3D __load_free_space_cache(fs_info->tree_root, inode, &tmp_ctl,
 				      path, block_group->start);
 	btrfs_free_path(path);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f20740812e5b..36f973ffbd26 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3223,6 +3223,8 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_ex=
tent *ordered_extent)
 		clear_bits |=3D EXTENT_DELALLOC_NEW;
=20
 	freespace_inode =3D btrfs_is_free_space_inode(inode);
+	if (!freespace_inode)
+		btrfs_lockdep_acquire(fs_info, btrfs_ordered_extent);
=20
 	if (test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags)) {
 		ret =3D -EIO;
@@ -8952,6 +8954,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_inode *inode =3D BTRFS_I(vfs_inode);
 	struct btrfs_root *root =3D inode->root;
+	bool freespace_inode;
=20
 	WARN_ON(!hlist_empty(&vfs_inode->i_dentry));
 	WARN_ON(vfs_inode->i_data.nrpages);
@@ -8973,6 +8976,12 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
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
@@ -8981,6 +8990,10 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
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

