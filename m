Return-Path: <linux-btrfs+bounces-11036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E982A19146
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 13:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087FB1881CB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBD212B27;
	Wed, 22 Jan 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CEsgMBwu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DB1741D2
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548713; cv=none; b=osujLSmzA3RHZ3Ubb83KRDioe1F6TE21pEG1uF/wZXHZ9NoUXI8qVTNiO5ySw6LvVopHlShpK3BSuYLX1MCtgv+sTuamHq6NpTdH55JTL9Sua4RFIlfFtPEaQyZKEwd76SMUe0BBUplsmUpU7+HmGquWDeXB6YzVawLSaATZWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548713; c=relaxed/simple;
	bh=lve1gMfmSe1o3//FsphE9GpV5vgRlXqavzltmywyZDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N3M993zvUtGblmYLT/P7GP4BMBRLxpSp0lqGo3Jnr8tP+BhwQmFjo3rjwreheLkv26Mv24DuiQPwBhIWCtyL46J6IbjuPodFCu3e6QHmKp0pfKQ88urnlL4F1Id/sJ8gYEf67nnHsKfRXLmo8lsEs9JCJ5rjZ6b9lIvNfC1CNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=CEsgMBwu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MAZYkA001091
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 04:25:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=cTDN4SQLte6nvmLtVKk5hyy
	7EGaX5YJzgRfT3nxAg18=; b=CEsgMBwuLUmcy6hkwQLy7y+SiIDXmjmkwvLdZEl
	8Qp+wsXp3jQ8nM3WSmxUHCuKx/acJtJW4QfBNNo9hxtMQYHLTMeyIKrMcYu1QTax
	umPsNYiPChUJojycQNGJdUDO59jjN+yfEMXdPacmgvmlE/diLj/u9f2k9Mg5YNbz
	2hi4=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44ay240fg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 04:25:09 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 22 Jan 2025 12:25:08 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 3AB6FABB9B3E; Wed, 22 Jan 2025 12:25:02 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: use atomic64_t for free_objectid
Date: Wed, 22 Jan 2025 12:21:28 +0000
Message-ID: <20250122122459.1148668-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BlRhlT20z3z1YXe_y1WngfGr_M_vDKeg
X-Proofpoint-ORIG-GUID: BlRhlT20z3z1YXe_y1WngfGr_M_vDKeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01

Currently btrfs_get_free_objectid() uses a mutex to protect
free_objectid; I'm guessing this was because of the inode cache that we
used to have. The inode cache is no more, so simplify things by
replacing it with an atomic.

There's no issues with ordering: free_objectid gets set to an initial
value, then calls to btrfs_get_free_objectid() return a monotonically
increasing value.

This change means that btrfs_get_free_objectid() will no longer
potentially sleep, which was a blocker for adding a non-blocking mode
for inode and subvol creation.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/ctree.h    |  4 +---
 fs/btrfs/disk-io.c  | 43 ++++++++++++++++++-------------------------
 fs/btrfs/qgroup.c   | 11 ++++++-----
 fs/btrfs/tree-log.c |  3 ---
 4 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1096a80a64e7..04175698525b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -179,8 +179,6 @@ struct btrfs_root {
 	struct btrfs_fs_info *fs_info;
 	struct extent_io_tree dirty_log_pages;
=20
-	struct mutex objectid_mutex;
-
 	spinlock_t accounting_lock;
 	struct btrfs_block_rsv *block_rsv;
=20
@@ -214,7 +212,7 @@ struct btrfs_root {
=20
 	u64 last_trans;
=20
-	u64 free_objectid;
+	atomic64_t free_objectid;
=20
 	struct btrfs_key defrag_progress;
 	struct btrfs_key defrag_max;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f09db62e61a1..0543d9c3f8c0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -659,7 +659,7 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
 	RB_CLEAR_NODE(&root->rb_node);
=20
 	btrfs_set_root_last_trans(root, 0);
-	root->free_objectid =3D 0;
+	atomic64_set(&root->free_objectid, 0);
 	root->nr_delalloc_inodes =3D 0;
 	root->nr_ordered_extents =3D 0;
 	xa_init(&root->inodes);
@@ -678,7 +678,6 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
 	spin_lock_init(&root->ordered_extent_lock);
 	spin_lock_init(&root->accounting_lock);
 	spin_lock_init(&root->qgroup_meta_rsv_lock);
-	mutex_init(&root->objectid_mutex);
 	mutex_init(&root->log_mutex);
 	mutex_init(&root->ordered_extent_mutex);
 	mutex_init(&root->delalloc_mutex);
@@ -1133,16 +1132,12 @@ static int btrfs_init_fs_root(struct btrfs_root *=
root, dev_t anon_dev)
 		}
 	}
=20
-	mutex_lock(&root->objectid_mutex);
 	ret =3D btrfs_init_root_free_objectid(root);
-	if (ret) {
-		mutex_unlock(&root->objectid_mutex);
+	if (ret)
 		goto fail;
-	}
=20
-	ASSERT(root->free_objectid <=3D BTRFS_LAST_FREE_OBJECTID);
-
-	mutex_unlock(&root->objectid_mutex);
+	ASSERT((u64)atomic64_read(&root->free_objectid) <=3D
+		BTRFS_LAST_FREE_OBJECTID);
=20
 	return 0;
 fail:
@@ -2730,8 +2725,9 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
 		}
=20
 		/*
-		 * No need to hold btrfs_root::objectid_mutex since the fs
-		 * hasn't been fully initialised and we are the only user
+		 * No need to worry about atomic ordering of btrfs_root::free_objectid
+		 * since the fs hasn't been fully initialised and we are the
+		 * only user
 		 */
 		ret =3D btrfs_init_root_free_objectid(tree_root);
 		if (ret < 0) {
@@ -2739,7 +2735,8 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
 			continue;
 		}
=20
-		ASSERT(tree_root->free_objectid <=3D BTRFS_LAST_FREE_OBJECTID);
+		ASSERT((u64)atomic64_read(&tree_root->free_objectid) <=3D
+			BTRFS_LAST_FREE_OBJECTID);
=20
 		ret =3D btrfs_read_roots(fs_info);
 		if (ret < 0) {
@@ -4931,10 +4928,11 @@ int btrfs_init_root_free_objectid(struct btrfs_ro=
ot *root)
 		slot =3D path->slots[0] - 1;
 		l =3D path->nodes[0];
 		btrfs_item_key_to_cpu(l, &found_key, slot);
-		root->free_objectid =3D max_t(u64, found_key.objectid + 1,
-					    BTRFS_FIRST_FREE_OBJECTID);
+		atomic64_set(&root->free_objectid,
+			     max_t(u64, found_key.objectid + 1,
+				   BTRFS_FIRST_FREE_OBJECTID));
 	} else {
-		root->free_objectid =3D BTRFS_FIRST_FREE_OBJECTID;
+		atomic64_set(&root->free_objectid, BTRFS_FIRST_FREE_OBJECTID);
 	}
 	ret =3D 0;
 error:
@@ -4944,20 +4942,15 @@ int btrfs_init_root_free_objectid(struct btrfs_ro=
ot *root)
=20
 int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 {
-	int ret;
-	mutex_lock(&root->objectid_mutex);
+	u64 val =3D atomic64_inc_return(&root->free_objectid) - 1;
=20
-	if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_OBJECTID)) {
+	if (unlikely(val >=3D BTRFS_LAST_FREE_OBJECTID)) {
 		btrfs_warn(root->fs_info,
 			   "the objectid of root %llu reaches its highest value",
 			   btrfs_root_id(root));
-		ret =3D -ENOSPC;
-		goto out;
+		return -ENOSPC;
 	}
=20
-	*objectid =3D root->free_objectid++;
-	ret =3D 0;
-out:
-	mutex_unlock(&root->objectid_mutex);
-	return ret;
+	*objectid =3D val;
+	return 0;
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index aaf16019d829..b41e06d5d2fb 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -472,18 +472,19 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *=
fs_info)
 			 *
 			 * Ensure that we skip any such subvol ids.
 			 *
-			 * We don't need to lock because this is only called
-			 * during mount before we start doing things like creating
-			 * subvolumes.
+			 * We don't need to worry about atomic ordering because
+			 * this is only called during mount before we start
+			 * doing things like creating subvolumes.
 			 */
 			if (is_fstree(qgroup->qgroupid) &&
-			    qgroup->qgroupid > tree_root->free_objectid)
+			    qgroup->qgroupid > (u64)atomic64_read(&tree_root->free_objectid))
 				/*
 				 * Don't need to check against BTRFS_LAST_FREE_OBJECTID,
 				 * as it will get checked on the next call to
 				 * btrfs_get_free_objectid.
 				 */
-				tree_root->free_objectid =3D qgroup->qgroupid + 1;
+				atomic64_set(&tree_root->free_objectid,
+					     qgroup->qgroupid + 1);
 		}
 		ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 		if (ret < 0)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 955d1677e865..9d19528fee17 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7325,9 +7325,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_=
root_tree)
 			 * We have just replayed everything, and the highest
 			 * objectid of fs roots probably has changed in case
 			 * some inode_item's got replayed.
-			 *
-			 * root->objectid_mutex is not acquired as log replay
-			 * could only happen during mount.
 			 */
 			ret =3D btrfs_init_root_free_objectid(root);
 			if (ret)
--=20
2.45.2


