Return-Path: <linux-btrfs+bounces-8219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87E98575F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945481F21D88
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D5189911;
	Wed, 25 Sep 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRHgC37j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AC188A01
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261438; cv=none; b=acTy804r5pjD6FjHOJicPcNAlOwyoUzY+ZGkgJtco/3G9r0sGb7SxPZdusA8aQGq2p+JX/IJAzYlN4XbxhUwtJLtmHW2XvWmsYdAvvbL27Ah9qi3pk+lqWgayJAKC2Wt4CIxziVh5s7+v1BdaPHzWg3rPl6p5Pp98yS/+uWjuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261438; c=relaxed/simple;
	bh=rvWSUwEoWz/C7IqadlEhJnRkPXsQXf3Y+gu/k8AQSK4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X+qr3wHyP1UMwed6Iqs858CpnyfdXuRDShtLBNiIt5oKyTlZrzTsaIBapJvcvCLG07gaNeqJ9DSjEs2jCDJcvyRxYHP+cFEo56lvl9XtBMMGcS15k5YHoHmL/YZBxx+iRYZc35ijOUz+c5eY0O3yg+4csb53UZ8+zd6SLEvzRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRHgC37j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1472CC4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261437;
	bh=rvWSUwEoWz/C7IqadlEhJnRkPXsQXf3Y+gu/k8AQSK4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lRHgC37jY047rsU7hAMER5LAv8wGPn7DJs5IIj+tiP+B8+JublCLU3VoJeQLNXVcN
	 jErTYtKdxPuU4ZbA4Y1+C2g+9Vesj6KHdHRtmavJf0KlvRXwNytQ2Nvcq8Y3rEyQA0
	 yayRv0Xrr1eMoM6/fs3JgIeFg7jJyzXZYgSwwzBpevtUEo0DCUF1/OMqe4drnnRTC2
	 I6smbSd7ORlL/+gx0uvHVElY29M6rv+kbRTYxa+gipRCE2lhpX7VlA4QDEAAkny6LN
	 /qvnJpFa8quzqQyTojMos23GLfmzGErZ/GlvJEdfkPZUj9ax4kKth+rr/6bE3+8YQX
	 K4T3ull/m5eWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record
Date: Wed, 25 Sep 2024 11:50:26 +0100
Message-Id: <d5c8f8dfa7bd44a35f873955c3a8489b8683ad34.1727261112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
References: <cover.1727261112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Now that we track qgroup extent records in a xarray we don't need to have
a "bytenr" field in  struct btrfs_qgroup_extent_record, since we can get
it from the index of the record in the xarray.

So remove the field and grab the bytenr from either the index key or any
other place where it's available (delayed refs). This reduces the size of
struct btrfs_qgroup_extent_record from 40 bytes down to 32 bytes, meaning
that we now can store 128 instances of this structure instead of 102 per
4K page.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c       |  8 ++++----
 fs/btrfs/qgroup.c            | 27 +++++++++++++++------------
 fs/btrfs/qgroup.h            | 13 ++++++++++---
 include/trace/events/btrfs.h | 17 ++++++++++-------
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f075ac11e51c..388d4ed1938e 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -830,7 +830,6 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 			qrecord->data_rsv = reserved;
 			qrecord->data_rsv_refroot = generic_ref->ref_root;
 		}
-		qrecord->bytenr = generic_ref->bytenr;
 		qrecord->num_bytes = generic_ref->num_bytes;
 		qrecord->old_roots = NULL;
 	}
@@ -861,11 +860,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		int ret;
 
 		ret = btrfs_qgroup_trace_extent_nolock(fs_info,
-						       delayed_refs, qrecord);
+						       delayed_refs, qrecord,
+						       head_ref->bytenr);
 		if (ret) {
 			/* Clean up if insertion fails or item exists. */
 			xa_release(&delayed_refs->dirty_extents,
-				   qrecord->bytenr >> fs_info->sectorsize_bits);
+				   head_ref->bytenr >> fs_info->sectorsize_bits);
 			/* Caller responsible for freeing qrecord on error. */
 			if (ret < 0)
 				return ERR_PTR(ret);
@@ -1076,7 +1076,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(trans, record);
+		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
 	return 0;
 
 free_record:
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a76e4610fe80..4eaeea5f2241 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2001,17 +2001,18 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
  * Return <0 for insertion failure, caller can free @record safely.
  */
 int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
-				struct btrfs_delayed_ref_root *delayed_refs,
-				struct btrfs_qgroup_extent_record *record)
+				     struct btrfs_delayed_ref_root *delayed_refs,
+				     struct btrfs_qgroup_extent_record *record,
+				     u64 bytenr)
 {
 	struct btrfs_qgroup_extent_record *existing, *ret;
-	const unsigned long index = (record->bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 1;
 
 	lockdep_assert_held(&delayed_refs->lock);
-	trace_btrfs_qgroup_trace_extent(fs_info, record);
+	trace_btrfs_qgroup_trace_extent(fs_info, record, bytenr);
 
 	xa_lock(&delayed_refs->dirty_extents);
 	existing = xa_load(&delayed_refs->dirty_extents, index);
@@ -2056,7 +2057,8 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
  * transaction committing, but not now as qgroup accounting will be wrong again.
  */
 int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
-				   struct btrfs_qgroup_extent_record *qrecord)
+				   struct btrfs_qgroup_extent_record *qrecord,
+				   u64 bytenr)
 {
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	int ret;
@@ -2087,7 +2089,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	if (trans->fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		return 0;
 
-	ctx.bytenr = qrecord->bytenr;
+	ctx.bytenr = bytenr;
 	ctx.fs_info = trans->fs_info;
 
 	ret = btrfs_find_all_roots(&ctx, true);
@@ -2144,12 +2146,11 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	}
 
 	delayed_refs = &trans->transaction->delayed_refs;
-	record->bytenr = bytenr;
 	record->num_bytes = num_bytes;
 	record->old_roots = NULL;
 
 	spin_lock(&delayed_refs->lock);
-	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record);
+	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record, bytenr);
 	spin_unlock(&delayed_refs->lock);
 	if (ret) {
 		/* Clean up if insertion fails or item exists. */
@@ -2157,7 +2158,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 		kfree(record);
 		return 0;
 	}
-	return btrfs_qgroup_trace_extent_post(trans, record);
+	return btrfs_qgroup_trace_extent_post(trans, record, bytenr);
 }
 
 /*
@@ -3033,14 +3034,16 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	xa_for_each(&delayed_refs->dirty_extents, index, record) {
+		const u64 bytenr = (index << fs_info->sectorsize_bits);
+
 		num_dirty_extents++;
-		trace_btrfs_qgroup_account_extents(fs_info, record);
+		trace_btrfs_qgroup_account_extents(fs_info, record, bytenr);
 
 		if (!ret && !(fs_info->qgroup_flags &
 			      BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)) {
 			struct btrfs_backref_walk_ctx ctx = { 0 };
 
-			ctx.bytenr = record->bytenr;
+			ctx.bytenr = bytenr;
 			ctx.fs_info = fs_info;
 
 			/*
@@ -3082,7 +3085,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 				ulist_del(record->old_roots, qgroup_to_skip,
 					  0);
 			}
-			ret = btrfs_qgroup_account_extent(trans, record->bytenr,
+			ret = btrfs_qgroup_account_extent(trans, bytenr,
 							  record->num_bytes,
 							  record->old_roots,
 							  new_roots);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 98adf4ec7b01..836e9f59ec84 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -125,7 +125,12 @@ struct btrfs_inode;
  * Record a dirty extent, and info qgroup to update quota on it
  */
 struct btrfs_qgroup_extent_record {
-	u64 bytenr;
+	/*
+	 * The bytenr of the extent is given by its index in the dirty_extents
+	 * xarray of struct btrfs_delayed_ref_root left shifted by
+	 * fs_info->sectorsize_bits.
+	 */
+
 	u64 num_bytes;
 
 	/*
@@ -343,9 +348,11 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_trace_extent_nolock(
 		struct btrfs_fs_info *fs_info,
 		struct btrfs_delayed_ref_root *delayed_refs,
-		struct btrfs_qgroup_extent_record *record);
+		struct btrfs_qgroup_extent_record *record,
+		u64 bytenr);
 int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
-				   struct btrfs_qgroup_extent_record *qrecord);
+				   struct btrfs_qgroup_extent_record *qrecord,
+				   u64 bytenr);
 int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 			      u64 num_bytes);
 int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index af6b3827fb1d..8d2ff32fb3b0 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1706,9 +1706,10 @@ DEFINE_EVENT(btrfs__qgroup_rsv_data, btrfs_qgroup_release_data,
 
 DECLARE_EVENT_CLASS(btrfs_qgroup_extent,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_qgroup_extent_record *rec),
+		 const struct btrfs_qgroup_extent_record *rec,
+		 u64 bytenr),
 
-	TP_ARGS(fs_info, rec),
+	TP_ARGS(fs_info, rec, bytenr),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  bytenr		)
@@ -1716,7 +1717,7 @@ DECLARE_EVENT_CLASS(btrfs_qgroup_extent,
 	),
 
 	TP_fast_assign_btrfs(fs_info,
-		__entry->bytenr		= rec->bytenr;
+		__entry->bytenr		= bytenr;
 		__entry->num_bytes	= rec->num_bytes;
 	),
 
@@ -1727,17 +1728,19 @@ DECLARE_EVENT_CLASS(btrfs_qgroup_extent,
 DEFINE_EVENT(btrfs_qgroup_extent, btrfs_qgroup_account_extents,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_qgroup_extent_record *rec),
+		 const struct btrfs_qgroup_extent_record *rec,
+		 u64 bytenr),
 
-	TP_ARGS(fs_info, rec)
+	TP_ARGS(fs_info, rec, bytenr)
 );
 
 DEFINE_EVENT(btrfs_qgroup_extent, btrfs_qgroup_trace_extent,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct btrfs_qgroup_extent_record *rec),
+		 const struct btrfs_qgroup_extent_record *rec,
+		 u64 bytenr),
 
-	TP_ARGS(fs_info, rec)
+	TP_ARGS(fs_info, rec, bytenr)
 );
 
 TRACE_EVENT(qgroup_num_dirty_extents,
-- 
2.43.0


