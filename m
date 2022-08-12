Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDC59099E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 02:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiHLAqH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLAqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 20:46:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F29F1A5
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:46:06 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLdsKK029553
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:46:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3EDlCiCP5EzRsl6jtXRqAv+mSw/Y9DtYzqRlsJxzJ04=;
 b=SAOW4EUXT82hJtFrh1dEOecS+exQaJNiKs4T2CiSlj8DLkgOJEwm+2RhFDOljsxSO0UN
 wjUdtCJPrg27Hx7v+gYHXlqKJWoEBavvNk4yf6jqQfItNHymRUiQqqoYi3Fxc+ysAn1H
 KliCiuWdt1S4Ixn5TCeLVebygfx+x89MoPI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9vr0w15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:46:06 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:46:05 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 5457433AF9AE; Thu, 11 Aug 2022 17:46:00 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [RFC PATCH 1/2] btrfs: Add lockdep wrappers around the extent bits locking and unlocking functions
Date:   Thu, 11 Aug 2022 17:42:42 -0700
Message-ID: <20220812004241.1722846-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812004241.1722846-1-iangelak@fb.com>
References: <20220812004241.1722846-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Gy6wtxcJgdfXAzrgVKgC_IItmEGoeVSF
X-Proofpoint-GUID: Gy6wtxcJgdfXAzrgVKgC_IItmEGoeVSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_14,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add wrappers and prototypes that apply lockdep annotations on the extent
bits wait event in fs/btrfs/extent-io-tree.h, mirroring the functions
that lock and unlock the extent bits.

Unfortunately, as it stands a generic annotation of the extent bits wait
event is not possible with lockdep since there are cases where the extent
bits are locked in one execution context (lockdep map acquire) and get
unlocked in another context (lockdep map release). However, lockdep expec=
ts
that the acquisition and release of the lockdep map occur in the same
execution context.

An example of such a case is btrfs_read_folio() in fs/btrfs/extent_io.c
which locks the extent bits by calling
btrfs_lock_and_flush_ordered_range(), however the extent bits are unlocke=
d
within a submitted bio executed by a worker thread asynchronously.

The lockdep wrappers are used to manually annotate places where extent bi=
ts
are locked.

Also introduce a new owner bit for the extent io tree related to the free
space inodes. This way it is simple to distinguish if we are in a context
where free space inodes are used (do not annotate) or normal inodes are
used (do annotate).

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/extent-io-tree.h    | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.c  |  1 +
 include/trace/events/btrfs.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index c3eb52dbe61c..a6dd80f0408c 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -56,6 +56,7 @@ enum {
 	IO_TREE_FS_EXCLUDED_EXTENTS,
 	IO_TREE_BTREE_INODE_IO,
 	IO_TREE_INODE_IO,
+	IO_TREE_FREE_SPACE_INODE_IO,
 	IO_TREE_INODE_IO_FAILURE,
 	IO_TREE_RELOC_BLOCKS,
 	IO_TREE_TRANS_DIRTY_PAGES,
@@ -107,11 +108,20 @@ void extent_io_tree_release(struct extent_io_tree *=
tree);
 int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 		     struct extent_state **cached);
=20
+int lock_extent_bits_lockdep(struct extent_io_tree *tree, u64 start, u64=
 end,
+			     struct extent_state **cached, bool nested);
+
 static inline int lock_extent(struct extent_io_tree *tree, u64 start, u6=
4 end)
 {
 	return lock_extent_bits(tree, start, end, NULL);
 }
=20
+static inline int lock_extent_lockdep(struct extent_io_tree *tree, u64 s=
tart,
+				      u64 end, bool nested)
+{
+	return lock_extent_bits_lockdep(tree, start, end, NULL, nested);
+}
+
 int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end);
=20
 int __init extent_io_init(void);
@@ -134,11 +144,26 @@ int __clear_extent_bit(struct extent_io_tree *tree,=
 u64 start, u64 end,
 		     struct extent_state **cached, gfp_t mask,
 		     struct extent_changeset *changeset);
=20
+int clear_extent_bit_lockdep(struct extent_io_tree *tree, u64 start, u64=
 end,
+			     u32 bits, int wake, int delete,
+			     struct extent_state **cached);
+int __clear_extent_bit_lockdep(struct extent_io_tree *tree, u64 start, u=
64 end,
+			     u32 bits, int wake, int delete,
+			     struct extent_state **cached, gfp_t mask,
+			     struct extent_changeset *changeset);
+
 static inline int unlock_extent(struct extent_io_tree *tree, u64 start, =
u64 end)
 {
 	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, NULL);
 }
=20
+static inline int unlock_extent_lockdep(struct extent_io_tree *tree, u64=
 start,
+					u64 end)
+{
+	return clear_extent_bit_lockdep(tree, start, end, EXTENT_LOCKED, 1, 0,
+					NULL);
+}
+
 static inline int unlock_extent_cached(struct extent_io_tree *tree, u64 =
start,
 		u64 end, struct extent_state **cached)
 {
@@ -146,6 +171,13 @@ static inline int unlock_extent_cached(struct extent=
_io_tree *tree, u64 start,
 				GFP_NOFS, NULL);
 }
=20
+static inline int unlock_extent_cached_lockdep(struct extent_io_tree *tr=
ee,
+		u64 start, u64 end, struct extent_state **cached)
+{
+	return __clear_extent_bit_lockdep(tree, start, end, EXTENT_LOCKED, 1, 0=
,
+				cached, GFP_NOFS, NULL);
+}
+
 static inline int unlock_extent_cached_atomic(struct extent_io_tree *tre=
e,
 		u64 start, u64 end, struct extent_state **cached)
 {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 81d9fe33672f..a93a8b91eda8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -130,6 +130,7 @@ struct inode *lookup_free_space_inode(struct btrfs_bl=
ock_group *block_group,
 		block_group->inode =3D igrab(inode);
 	spin_unlock(&block_group->lock);
=20
+	BTRFS_I(inode)->io_tree.owner =3D IO_TREE_FREE_SPACE_INODE_IO;
 	return inode;
 }
=20
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 73df80d462dc..f8c900914474 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -84,6 +84,7 @@ struct raid56_bio_trace_info;
 	EM( IO_TREE_FS_EXCLUDED_EXTENTS,  "EXCLUDED_EXTENTS")	    \
 	EM( IO_TREE_BTREE_INODE_IO,	  "BTREE_INODE_IO")	    \
 	EM( IO_TREE_INODE_IO,		  "INODE_IO")		    \
+	EM( IO_TREE_FREE_SPACE_INODE_IO,  "FREE_SPACE_INODE_IO")    \
 	EM( IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE")	    \
 	EM( IO_TREE_RELOC_BLOCKS,	  "RELOC_BLOCKS")	    \
 	EM( IO_TREE_TRANS_DIRTY_PAGES,	  "TRANS_DIRTY_PAGES")      \
--=20
2.30.2

