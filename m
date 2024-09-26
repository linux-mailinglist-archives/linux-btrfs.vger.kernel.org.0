Return-Path: <linux-btrfs+bounces-8242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B009E987050
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646ED286B41
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641811AC451;
	Thu, 26 Sep 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr8fk+aT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACE1AC432
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343207; cv=none; b=L+hVHAHgYZu9obXWUS5EIUDYlI2U0Z8BzYow1cmqky3QxOtKJ3xGyZadMZlgp6+oKrb6QAH/9DhlLM2UMjwjIxNEnXEj++Me9yz4tGQJl+ktvr7Jvu1mLnFO2ZHNqpktmDz4sHO/YAFHWFHNragDuJm16I2HlWy7KtA6RbIT5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343207; c=relaxed/simple;
	bh=kJyzxzcIXzlN04316pS3P8jjVJBgxAS+ro6+UtPVnxw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPvqn12259A6vKmd3Kzd1PT48rZaM7vkqK04V827phtW1xYYhV2jqVOC8FBwP8IuAuvN/l9EmVDXWUk2BoPwHo0Wo7Ksk48DsWXQ5NGAB7ZbN3SETz/czuHB4iJUAIWoIdHBcb5iiHAw4n4FtjQmrv1yuzfgMqk1JHCpf5zSC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr8fk+aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA8FC4CEC9
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343207;
	bh=kJyzxzcIXzlN04316pS3P8jjVJBgxAS+ro6+UtPVnxw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Nr8fk+aTCgmCoFMtc24wg9L2jG09iRiyrZ162VSURX/CtiPxA5iPqA1OEDfJXw5rT
	 17TTAb5UmSw3IAN5Rm0Q0ljNeFNR4y4wtq2j9HaKgvU9w4Gcm1Y1ZBP8UM/9JSAonB
	 sA+DJLmCvxOyQe3BV+Yw8n4gebVpBGiuZ1DIxSdn6SUfEeTWSGJlJ0gtkJw11dkxIv
	 96/IaxNC1a4Q5J1epHL1d+lRCAaLaqXftEKpfbmm4LEtvKg0V7IZfgqQeuo7qSOAuO
	 EfaHLl8wWosM0puqWoONj22+Ppo9okufXn8AnyJUAh5HxV/SeDgn4WUYP8Gpc0t6/z
	 2sIVdgPDDUU6g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/8] btrfs: use sector numbers as keys for the dirty extents xarray
Date: Thu, 26 Sep 2024 10:33:16 +0100
Message-Id: <8c86bd27dfe0be1750d9c44ade5d3c87cf17a1d8.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are using the logical address ("bytenr") of an extent as the key for
qgroup records in the dirty extents xarray. This is a problem because the
xarrays use "unsigned long" for keys/indices, meaning that on a 32 bits
platform any extent starting at or beyond 4G is truncated, which is a too
low limitation as virtually everyone is using storage with more than 4G of
space. This means a "bytenr" of 4G gets truncated to 0, and so does 8G and
16G for example, resulting in incorrect qgroup accounting.

Fix this by using sector numbers as keys instead, that is, using keys that
match the logical address right shifted by fs_info->sectorsize_bits, which
is what we do for the fs_info->buffer_radix that tracks extent buffers
(radix trees also use an "unsigned long" type for keys). This also makes
the index space more dense which helps optimize the xarray (as mentioned
at Documentation/core-api/xarray.rst).

Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extents in transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 13 ++++++++-----
 fs/btrfs/delayed-ref.h | 10 +++++++++-
 fs/btrfs/qgroup.c      | 21 ++++++++++++++++-----
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 32f719b9e661..f075ac11e51c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -849,6 +849,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		     struct btrfs_qgroup_extent_record *qrecord,
 		     int action, bool *qrecord_inserted_ret)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	bool qrecord_inserted = false;
@@ -859,11 +860,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	if (qrecord) {
 		int ret;
 
-		ret = btrfs_qgroup_trace_extent_nolock(trans->fs_info,
+		ret = btrfs_qgroup_trace_extent_nolock(fs_info,
 						       delayed_refs, qrecord);
 		if (ret) {
 			/* Clean up if insertion fails or item exists. */
-			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
+			xa_release(&delayed_refs->dirty_extents,
+				   qrecord->bytenr >> fs_info->sectorsize_bits);
 			/* Caller responsible for freeing qrecord on error. */
 			if (ret < 0)
 				return ERR_PTR(ret);
@@ -873,7 +875,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	trace_add_delayed_ref_head(trans->fs_info, head_ref, action);
+	trace_add_delayed_ref_head(fs_info, head_ref, action);
 
 	existing = htree_insert(&delayed_refs->href_root,
 				&head_ref->href_node);
@@ -895,7 +897,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		if (head_ref->is_data && head_ref->ref_mod < 0) {
 			delayed_refs->pending_csums += head_ref->num_bytes;
 			trans->delayed_ref_csum_deletions +=
-				btrfs_csum_bytes_to_leaves(trans->fs_info,
+				btrfs_csum_bytes_to_leaves(fs_info,
 							   head_ref->num_bytes);
 		}
 		delayed_refs->num_heads++;
@@ -1030,7 +1032,8 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 			goto free_head_ref;
 		}
 		if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents,
-			       generic_ref->bytenr, GFP_NOFS)) {
+			       generic_ref->bytenr >> fs_info->sectorsize_bits,
+			       GFP_NOFS)) {
 			ret = -ENOMEM;
 			goto free_record;
 		}
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 085f30968aba..352921e76c74 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -202,7 +202,15 @@ struct btrfs_delayed_ref_root {
 	/* head ref rbtree */
 	struct rb_root_cached href_root;
 
-	/* Track dirty extent records. */
+	/*
+	 * Track dirty extent records.
+	 * The keys correspond to the logical address of the extent ("bytenr")
+	 * right shifted by fs_info->sectorsize_bits. This is both to get a more
+	 * dense index space (optimizes xarray structure) and because indexes in
+	 * xarrays are of "unsigned long" type, meaning they are 32 bits wide on
+	 * 32 bits platforms, limiting the extent range to 4G which is too low
+	 * and makes it unusable (truncated index values) on 32 bits platforms.
+	 */
 	struct xarray dirty_extents;
 
 	/* this spin lock protects the rbtree and the entries inside */
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c297909f1506..152a43ae62c4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2005,16 +2005,26 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 				struct btrfs_qgroup_extent_record *record)
 {
 	struct btrfs_qgroup_extent_record *existing, *ret;
-	unsigned long bytenr = record->bytenr;
+	const unsigned long index = (record->bytenr >> fs_info->sectorsize_bits);
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 1;
 
+#if BITS_PER_LONG == 32
+	if (bytenr >= MAX_LFS_FILESIZE) {
+		btrfs_err_rl(fs_info,
+"qgroup record for extent at %llu is beyond 32bit page cache and xarray index limit",
+			     bytenr);
+		btrfs_err_32bit_limit(fs_info);
+		return -EOVERFLOW;
+	}
+#endif
+
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
 
 	xa_lock(&delayed_refs->dirty_extents);
-	existing = xa_load(&delayed_refs->dirty_extents, bytenr);
+	existing = xa_load(&delayed_refs->dirty_extents, index);
 	if (existing) {
 		if (record->data_rsv && !existing->data_rsv) {
 			existing->data_rsv = record->data_rsv;
@@ -2024,7 +2034,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 		return 1;
 	}
 
-	ret = __xa_store(&delayed_refs->dirty_extents, record->bytenr, record, GFP_ATOMIC);
+	ret = __xa_store(&delayed_refs->dirty_extents, index, record, GFP_ATOMIC);
 	xa_unlock(&delayed_refs->dirty_extents);
 	if (xa_is_err(ret)) {
 		qgroup_mark_inconsistent(fs_info);
@@ -2129,6 +2139,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup_extent_record *record;
 	struct btrfs_delayed_ref_root *delayed_refs;
+	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
 	int ret;
 
 	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr == 0 || num_bytes == 0)
@@ -2137,7 +2148,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!record)
 		return -ENOMEM;
 
-	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, bytenr, GFP_NOFS)) {
+	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, index, GFP_NOFS)) {
 		kfree(record);
 		return -ENOMEM;
 	}
@@ -2152,7 +2163,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	spin_unlock(&delayed_refs->lock);
 	if (ret) {
 		/* Clean up if insertion fails or item exists. */
-		xa_release(&delayed_refs->dirty_extents, record->bytenr);
+		xa_release(&delayed_refs->dirty_extents, index);
 		kfree(record);
 		return 0;
 	}
-- 
2.43.0


