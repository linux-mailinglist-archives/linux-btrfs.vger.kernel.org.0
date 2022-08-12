Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF565909AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 02:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiHLAu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 20:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiHLAu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 20:50:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAB923DE
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:50:54 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLScJm032417
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uneK66wQj1+/+aTEUmPWzVm58EK2GBlb0Ft2+meq328=;
 b=oPUMJ8vE/gX9sSfKi2NR7O8EJCT+Jet8cqyB/7CjC1ZBInycujjrRsdBIH1F0meSC7JX
 h1B2Z6qgGFfl84gB7NpMgGDuVqe0jVDgNcOV3SBPx/qEoCXkGHHiBCVfqs7jM8L3HkVB
 vAt/i1C6L+n1xU+kLXcwigKWASydfBrvAkM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9qfh230-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:50:53 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 17:50:53 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 98F1C33AFC0B; Thu, 11 Aug 2022 17:48:00 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [RFC PATCH 2/2] btrfs: Lockdep annotations for the extent bits wait event
Date:   Thu, 11 Aug 2022 17:42:44 -0700
Message-ID: <20220812004241.1722846-3-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812004241.1722846-1-iangelak@fb.com>
References: <20220812004241.1722846-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: doeGbl-nps7qs5w72UlkrF6J0jyfGQeQ
X-Proofpoint-ORIG-GUID: doeGbl-nps7qs5w72UlkrF6J0jyfGQeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_14,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add lockdep annotations in five places that lock extent bits:
  1) find_lock_delalloc_range() in fs/btrfs/extent_io.c and its callers
  2) btrfs_lock_and_flush_ordered_range() in fs/btrfs/ordered-data.c and
  its callers
  3) extent_fiemap() in fs/btrfs/extent_io.c
  4) btrfs_fallocate() in fs/btrfs/file.c
  5) btrfs_finish_ordered_io() in fs/btrfs/inode.c

To annotate the extent bits wait event we make use of a two level lockdep
map (making use of the multilevel wait event lockdep annotation macros).
The first level is used for high level functions such as btrfs_fallocate(=
)
and the second level is used for low level functions, such as
find_lock_delalloc_range().

If we used only one level then lockdep would complain because there are
execution contexts where the extent bits annotation is acquired before th=
e
delalloc_mutex (i.e., in btrfs_fallocate()) and later delalloc_mutex is
acquired before the extent bits annotation (i.e.,
find_lock_delalloc_range()). Normally, if the range of bits locked were t=
he
same for both btrfs_fallocate() and find_lock_delalloc_range() we would
have a deadlock(). However, a call to btrfs_wait_ordered_range() from
btrfs_fallocate() guarantees that the range of extent bits is unlocked
before locking, thus the deadlock is averted.

By using a two level lockdep map we "break" the dependency between the hi=
gh
and low levels, thus lockdep does not complain.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h        |   1 +
 fs/btrfs/disk-io.c      |   1 +
 fs/btrfs/extent_io.c    | 114 +++++++++++++++++++++++++++++++++++++---
 fs/btrfs/file.c         |  10 ++--
 fs/btrfs/inode.c        |  22 ++++++--
 fs/btrfs/ordered-data.c |   4 +-
 6 files changed, 133 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 44837545eef8..85f947ce6e6b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1104,6 +1104,7 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_state_change_map[4];
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
+	struct lockdep_map btrfs_inode_extent_lock_map;
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6268dafeeb2d..afd971c31168 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2996,6 +2996,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
 	btrfs_lockdep_init_map(fs_info, btrfs_ordered_extent);
+	btrfs_lockdep_init_map(fs_info, btrfs_inode_extent_lock);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
 				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e8e936a8a1e..3d2ef3d78e7f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -891,6 +891,24 @@ int __clear_extent_bit(struct extent_io_tree *tree, =
u64 start, u64 end,
=20
 }
=20
+int __clear_extent_bit_lockdep(struct extent_io_tree *tree, u64 start, u=
64 end,
+			       u32 bits, int wake, int delete,
+			       struct extent_state **cached_state,
+			       gfp_t mask, struct extent_changeset *changeset)
+{
+	int ret;
+
+	ret =3D __clear_extent_bit(tree, start, end, bits, wake, delete, cached=
_state,
+				 mask, changeset);
+
+	if ((tree->owner !=3D IO_TREE_FREE_SPACE_INODE_IO) &&
+	    (tree->owner =3D=3D IO_TREE_INODE_IO))
+		btrfs_lockdep_release(tree->fs_info, btrfs_inode_extent_lock);
+
+	return ret;
+}
+
+
 static void wait_on_state(struct extent_io_tree *tree,
 			  struct extent_state *state)
 		__releases(tree->lock)
@@ -1470,6 +1488,14 @@ int clear_extent_bit(struct extent_io_tree *tree, =
u64 start, u64 end,
 				  cached, GFP_NOFS, NULL);
 }
=20
+int clear_extent_bit_lockdep(struct extent_io_tree *tree, u64 start, u64=
 end,
+			     u32 bits, int wake, int delete,
+			     struct extent_state **cached)
+{
+	return __clear_extent_bit_lockdep(tree, start, end, bits, wake, delete,
+					  cached, GFP_NOFS, NULL);
+}
+
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64=
 end,
 		u32 bits, struct extent_changeset *changeset)
 {
@@ -1504,6 +1530,43 @@ int lock_extent_bits(struct extent_io_tree *tree, =
u64 start, u64 end,
 			break;
 		WARN_ON(start > end);
 	}
+
+	return err;
+}
+
+int lock_extent_bits_lockdep(struct extent_io_tree *tree, u64 start, u64=
 end,
+			     struct extent_state **cached_state, bool nested)
+{
+	int err;
+#ifdef CONFIG_LOCKDEP
+	int subclass =3D 1;
+#endif
+
+	/* The wait event occurs within lock_extent_bits() */
+	if ((tree->owner !=3D IO_TREE_FREE_SPACE_INODE_IO) &&
+	    (tree->owner =3D=3D IO_TREE_INODE_IO)) {
+		if (nested)
+			btrfs_might_wait_for_event_nested(tree->fs_info,
+							  btrfs_inode_extent_lock,
+							  subclass);
+		else
+			btrfs_might_wait_for_event(tree->fs_info,
+						   btrfs_inode_extent_lock);
+	}
+
+	err =3D lock_extent_bits(tree, start, end, cached_state);
+
+	if ((tree->owner !=3D IO_TREE_FREE_SPACE_INODE_IO) &&
+	    (tree->owner =3D=3D IO_TREE_INODE_IO)) {
+		if (nested)
+			btrfs_lockdep_acquire_nested(tree->fs_info,
+						     btrfs_inode_extent_lock,
+						     subclass);
+		else
+			btrfs_lockdep_acquire(tree->fs_info,
+					      btrfs_inode_extent_lock);
+	}
+
 	return err;
 }
=20
@@ -2094,14 +2157,15 @@ noinline_for_stack bool find_lock_delalloc_range(=
struct inode *inode,
 	}
=20
 	/* step three, lock the state bits for the whole range */
-	lock_extent_bits(tree, delalloc_start, delalloc_end, &cached_state);
+	lock_extent_bits_lockdep(tree, delalloc_start, delalloc_end, &cached_st=
ate,
+				 true);
=20
 	/* then test to make sure it is all still delalloc */
 	ret =3D test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, 1, cached_state);
 	if (!ret) {
-		unlock_extent_cached(tree, delalloc_start, delalloc_end,
-				     &cached_state);
+		unlock_extent_cached_lockdep(tree, delalloc_start, delalloc_end,
+					     &cached_state);
 		__unlock_for_delalloc(inode, locked_page,
 			      delalloc_start, delalloc_end);
 		cond_resched();
@@ -3774,6 +3838,20 @@ int btrfs_read_folio(struct file *file, struct fol=
io *folio)
 	 * bio to do the cleanup.
 	 */
 	submit_one_bio(&bio_ctrl);
+
+	/*
+	 * Release the lockdep map here because
+	 * btrfs_lock_and_flush_ordered_range() will exit with the lockdep map
+	 * acquired as a reader. Actually bio worker would unlock the extent bi=
ts
+	 * and thus the lockdep map when it ran asynchronously, if extent bits =
were
+	 * annotated in a generic way. However, lockdep expects that the
+	 * acquisition and release of the lockdep map occur in the same context=
,
+	 * thus we have to unlock the lockdep map here.
+	 */
+	if ((inode->io_tree.owner !=3D IO_TREE_FREE_SPACE_INODE_IO) &&
+	    (inode->io_tree.owner =3D=3D IO_TREE_INODE_IO))
+		btrfs_lockdep_release(inode->io_tree.fs_info,
+				      btrfs_inode_extent_lock);
 	return ret;
 }
=20
@@ -3793,6 +3871,18 @@ static inline void contiguous_readpages(struct pag=
e *pages[], int nr_pages,
 				  REQ_RAHEAD, prev_em_start);
 		put_page(pages[index]);
 	}
+
+	/*
+	 * Release the lockdep map here because
+	 * btrfs_lock_and_flush_ordered_range() will exit with the lockdep map
+	 * acquired as a reader. We have to unlock here because
+	 * contiguous_readpages() will be called in while loop by
+	 * extent_readahead(), thus lockdep would complain about double locking=
.
+	 */
+	if ((inode->io_tree.owner !=3D IO_TREE_FREE_SPACE_INODE_IO) &&
+	    (inode->io_tree.owner =3D=3D IO_TREE_INODE_IO))
+		btrfs_lockdep_release(inode->io_tree.fs_info,
+				      btrfs_inode_extent_lock);
 }
=20
 /*
@@ -3829,6 +3919,16 @@ static noinline_for_stack int writepage_delalloc(s=
truct btrfs_inode *inode,
 		}
 		ret =3D btrfs_run_delalloc_range(inode, page, delalloc_start,
 				delalloc_end, &page_started, &nr_written, wbc);
+
+		/*
+		 * Release the lockdep map here, because btrfs_run_delalloc_range()
+		 * will exit with the lockdep map acquired.
+		 */
+		if ((inode->io_tree.owner !=3D IO_TREE_FREE_SPACE_INODE_IO) &&
+		    (inode->io_tree.owner =3D=3D IO_TREE_INODE_IO))
+			btrfs_lockdep_release(inode->io_tree.fs_info,
+					      btrfs_inode_extent_lock);
+
 		if (ret) {
 			btrfs_page_set_error(inode->root->fs_info, page,
 					     page_offset(page), PAGE_SIZE);
@@ -5584,8 +5684,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
 		last_for_get_extent =3D isize;
 	}
=20
-	lock_extent_bits(&inode->io_tree, start, start + len - 1,
-			 &cached_state);
+	lock_extent_bits_lockdep(&inode->io_tree, start, start + len - 1,
+				 &cached_state, false);
=20
 	em =3D get_extent_skip_holes(inode, start, last_for_get_extent);
 	if (!em)
@@ -5697,8 +5797,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
 		ret =3D emit_last_fiemap_cache(fieinfo, &cache);
 	free_extent_map(em);
 out:
-	unlock_extent_cached(&inode->io_tree, start, start + len - 1,
-			     &cached_state);
+	unlock_extent_cached_lockdep(&inode->io_tree, start, start + len - 1,
+				     &cached_state);
=20
 out_free_ulist:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c9649b7b2f18..df51a0cc3d98 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1510,7 +1510,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inod=
e, loff_t pos,
 		*write_bytes =3D min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
 	}
-	unlock_extent(&inode->io_tree, lockstart, lockend);
+	unlock_extent_lockdep(&inode->io_tree, lockstart, lockend);
=20
 	return ret;
 }
@@ -3517,8 +3517,8 @@ static long btrfs_fallocate(struct file *file, int =
mode,
 	}
=20
 	locked_end =3D alloc_end - 1;
-	lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
-			 &cached_state);
+	lock_extent_bits_lockdep(&BTRFS_I(inode)->io_tree, alloc_start, locked_=
end,
+				 &cached_state, false);
=20
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), alloc_start, locked_end)=
;
=20
@@ -3607,8 +3607,8 @@ static long btrfs_fallocate(struct file *file, int =
mode,
 	 */
 	ret =3D btrfs_fallocate_update_isize(inode, actual_end, mode);
 out_unlock:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
-			     &cached_state);
+	unlock_extent_cached_lockdep(&BTRFS_I(inode)->io_tree, alloc_start,
+				     locked_end, &cached_state);
 out:
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	extent_changeset_free(data_reserved);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cdb173331c7..0974df5bcdd5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3214,6 +3214,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_ex=
tent *ordered_extent)
 	bool freespace_inode;
 	bool truncated =3D false;
 	bool clear_reserved_extent =3D true;
+	bool have_locked =3D false;
 	unsigned int clear_bits =3D EXTENT_DEFRAG;
=20
 	start =3D ordered_extent->file_offset;
@@ -3272,7 +3273,12 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_e=
xtent *ordered_extent)
 	}
=20
 	clear_bits |=3D EXTENT_LOCKED;
-	lock_extent_bits(io_tree, start, end, &cached_state);
+	lock_extent_bits_lockdep(io_tree, start, end, &cached_state, true);
+	/*
+	 * We need this helper boolean because we can jump to out tag without
+	 * having acquired the lockdep map first and unlock it
+	 */
+	have_locked =3D true;
=20
 	if (freespace_inode)
 		trans =3D btrfs_join_transaction_spacecache(root);
@@ -3338,9 +3344,14 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_e=
xtent *ordered_extent)
 	}
 	ret =3D 0;
 out:
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits,
-			 (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
-			 &cached_state);
+	if (have_locked)
+		clear_extent_bit_lockdep(&inode->io_tree, start, end, clear_bits,
+					 (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
+					 &cached_state);
+	else
+		clear_extent_bit(&inode->io_tree, start, end, clear_bits,
+				(clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
+				&cached_state);
=20
 	if (trans)
 		btrfs_end_transaction(trans);
@@ -5139,7 +5150,8 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
 			break;
 	}
 	free_extent_map(em);
-	unlock_extent_cached(io_tree, hole_start, block_end - 1, &cached_state)=
;
+	unlock_extent_cached_lockdep(io_tree, hole_start, block_end - 1,
+				     &cached_state);
 	return err;
 }
=20
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index eb24a6d20ff8..c6d377aa4abb 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1043,7 +1043,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrf=
s_inode *inode, u64 start,
 		cachedp =3D cached_state;
=20
 	while (1) {
-		lock_extent_bits(&inode->io_tree, start, end, cachedp);
+		lock_extent_bits_lockdep(&inode->io_tree, start, end, cachedp, true);
 		ordered =3D btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
@@ -1056,7 +1056,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrf=
s_inode *inode, u64 start,
 				refcount_dec(&cache->refs);
 			break;
 		}
-		unlock_extent_cached(&inode->io_tree, start, end, cachedp);
+		unlock_extent_cached_lockdep(&inode->io_tree, start, end, cachedp);
 		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 	}
--=20
2.30.2

