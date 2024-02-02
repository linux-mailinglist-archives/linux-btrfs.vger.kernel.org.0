Return-Path: <linux-btrfs+bounces-2082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6758A847D0E
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA8A2879BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1D12F375;
	Fri,  2 Feb 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KitVcQjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ze3L/Oo5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2112F368
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915476; cv=none; b=tRWZueyMBVRoCjLOpmTI3T/BFYx5/QHlEjlCGkJpvrIyzg3T2+183U3U0qHC2X5UO0onnqB8ybTOC8XdM0yZGW2hPdEkEdLfvOyNjMKRckDZND+LxOylIWogladRI3lyEoGqedVdy6UeMYx2SJs0jxD1Q786+RWj9jqDy0cvfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915476; c=relaxed/simple;
	bh=vKh1MNmopN06WeiwR2tErH2Q4e6bAcob4FXAm4AV/d0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkTw57llXemf3cFu1TfvkqAzTc+yX5Z3lRORHjbAenUvjZJgie6s6ykwYGw7wpiHFU3HwqTBb6UQza6VZN368ODlFya4q3ZTniKbkFfqI4/BNLq0uGVY2JqSwj5X3ItWmBRMJpi9j40mX5H/uhcPtauHe+dlY4GnJW0xrpzZkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KitVcQjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ze3L/Oo5; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 2281F3200A4C;
	Fri,  2 Feb 2024 18:11:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 18:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706915472; x=
	1707001872; bh=WUuebHPYVgNc/dEkt1GaEDZbMhsX8ZQSKsSpAgasREI=; b=K
	itVcQjXx97aTVV+8cCkaeH11C676gco1dSMK/3zA3qeFB+aYSo/aZivEwdkF3ycl
	FwcCcHgFIa0bGFtC/0KHOH9Xz4IOsXSPauA+/jAeXA3i7LU4r52bGuttnZuork9U
	6cmwrWJ4CDUion/ZX7yLwN9A1paSYSkGUFeuUqOMGxtCwUhyyx3TAruGI++Jq3dw
	5cveQ47NUFUVCvjS98lMSeyakfGOMGSuHZwG44ryqPOg1OOCLsUhnNtjpNnK5/NE
	e+khBSOQKP/GBZJZQ9fx383OoRVcX7W2m0eovqTv2HbcTQFd3DbbgYm/m6ucMsF0
	1tF2Hc937uPQm1YWskUOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706915472; x=1707001872; bh=WUuebHPYVgNc/
	dEkt1GaEDZbMhsX8ZQSKsSpAgasREI=; b=Ze3L/Oo5mlQoPvwlNhigQRUOht/qf
	nMVqIHuSOTdSnvi6ONe0aXQha1YxZNNohLQUEUlFsvYzHMwBPciBPdz3WlJQzoCo
	sKv2ehC/Xw99YgI80sqMtVQ1nxHfMBbPyNcXqIj0Cdvc2la0NJDyWH/KToP/8k0x
	xRl90oqa8a6GuDBKafWgHENjwP0WkfERZfZoh+4FWiCetgzdL5ZP+qQe9Ab8DkPg
	OOAtgOjyQGOB/JcqKMlGCyvc9CHlNOnkqceYghRfTUk0UbrcRzfTEfH5nCPivBl2
	8RRkkcC7jnel6EzKFHrfJS27iRDc6M9IfqnRK/nkPwVEKl61I7YxWBLgw==
X-ME-Sender: <xms:kHa9ZZQKQDeuACLN2fE6yWdxSA2B8glYhOksRDuPmutng8ubjMBjyA>
    <xme:kHa9ZSyVK3CoyZj2sriu9eJohagsSo1XRpVR55LSPYXl1Iar7XkN2MyexqikzS93y
    ykg7_PTeXaAfI2ADQ0>
X-ME-Received: <xmr:kHa9Ze1jhI7cqHlq8CGnX-C6Yw2hjwJq5k4FwxG3Msjr7WSJ6JNlh92zj1sYcM4uL2CJUp8cq5XigVAYcYYMZzrdvmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:kHa9ZRDmhIkNw7yDS1TlaScl9IAvveG_AF-6Fxic3uQd5iEpgn7idQ>
    <xmx:kHa9ZSgZTCcPqazERsiEThvEjOihmJaOhQmlplxqJgPb9GOkzTrC8w>
    <xmx:kHa9ZVpCx3vbDFDKCETDD9-UevgHAxPJcmAzR_s4jvoS_ZvQkQvOlg>
    <xmx:kHa9ZaIxr2WpO7_GRrZNuQx3cFMqWD08o4osRXybmTyiocR4IuRokw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:12 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/6] btrfs: dynamic block_group reclaim threshold
Date: Fri,  2 Feb 2024 15:12:45 -0800
Message-ID: <45e9faf9636b0ccc4dbaf66f4c2a20c3466bb32d.1706914865.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706914865.git.boris@bur.io>
References: <cover.1706914865.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can currently recover allocated block_groups by:
- explicitly starting balance operations
- "auto reclaim" via bg_reclaim_threshold

The latter works by checking against a fixed threshold on frees. If we
pass from above the threshold to below, relocation triggers and the
block group will get reclaimed by the cleaner thread (assuming it is
still eligible)

Picking a threshold is challenging. Too high, and you end up trying to
reclaim very full block_groups which is quite costly, and you don't do
reclaim on block_groups that don't get quite THAT full, but could still
be quite fragmented and stranding a lot of space. Too low, and you
similarly miss out on reclaim even if you badly need it to avoid running
out of unallocated space, if you have heavily fragmented block groups
living above the threshold.

No matter the threshold, it suffers from a workload that happens to
bounce around that threshold, which can introduce arbitrary amounts of
reclaim waste.

To improve this situation, introduce a dynamic threshold. The basic idea
behind this threshold is that it should be high when there is lots of
unused space, and little unallocated space, relative to fs size. OTOH,
when either unused is low or unallocated is high, reclaim is not that
important, so we can set a quite low threshold.

The formula to acheive this is:
(unused / allocated) * (unused / unallocated)
which is also clamped to 90% as fuller than that is very challenging to
reclaim flat out, and means the file system is legitimately quite full.

I tested this by running it on three interesting workloads:
1. bounce allocations around X% full.
2. fill up all the way and introduce full fragmentation.
3. write in a fragmented way until the filesystem is just about full.

1. and 2. attack the weaknesses of a fixed threshold; fixed either works
perfectly or fully falls apart, depending on the threshold. Dynamic
always handles these cases well.

3. attacks dynamic by checking whether it is too zealous to reclaim in
conditions with low unallocated and low unused. It tends to claw back
1GiB of unallocated fairly aggressively, but not much more. Early
versions of dynamic threshold struggled on this test.

Additional work could be done to intelligently ratchet up the urgency of
reclaim in very low unallocated conditions. Existing mechanisms are
already useless in that case anyway.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 18 +++++-----
 fs/btrfs/space-info.c  | 74 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  8 +++++
 fs/btrfs/sysfs.c       | 43 +++++++++++++++++++++++-
 4 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7f05fdcee199..6244c76f3584 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1702,24 +1702,21 @@ static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
 
 static bool should_reclaim_block_group(struct btrfs_block_group *bg, u64 bytes_freed)
 {
-	const struct btrfs_space_info *space_info = bg->space_info;
-	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
+	const int thresh_pct = btrfs_calc_reclaim_threshold(bg->space_info);
+	u64 thresh_bytes = mult_perc(bg->length, thresh_pct);
 	const u64 new_val = bg->used;
 	const u64 old_val = new_val + bytes_freed;
-	u64 thresh;
 
-	if (reclaim_thresh == 0)
+	if (thresh_bytes == 0)
 		return false;
 
-	thresh = mult_perc(bg->length, reclaim_thresh);
-
 	/*
 	 * If we were below the threshold before don't reclaim, we are likely a
 	 * brand new block group and we don't want to relocate new block groups.
 	 */
-	if (old_val < thresh)
+	if (old_val < thresh_bytes)
 		return false;
-	if (new_val >= thresh)
+	if (new_val >= thresh_bytes)
 		return false;
 	return true;
 }
@@ -1779,6 +1776,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		/* Don't race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 
+		spin_lock(&space_info->lock);
 		spin_lock(&bg->lock);
 		if (bg->reserved || bg->pinned || bg->ro) {
 			/*
@@ -1788,6 +1786,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			 * this block group.
 			 */
 			spin_unlock(&bg->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
@@ -1806,6 +1805,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
 				btrfs_mark_bg_unused(bg);
 			spin_unlock(&bg->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 
@@ -1822,10 +1822,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		 */
 		if (!should_reclaim_block_group(bg, bg->length)) {
 			spin_unlock(&bg->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
 		spin_unlock(&bg->lock);
+		spin_unlock(&space_info->lock);
 
 		/*
 		 * Get out fast, in case we're read-only or unmounting the
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f4a1e6341ca6..86a87501af08 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/minmax.h>
 #include "misc.h"
 #include "ctree.h"
 #include "space-info.h"
@@ -191,6 +192,8 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
  */
 #define BTRFS_DEFAULT_ZONED_RECLAIM_THRESH			(75)
 
+#define BTRFS_DYNAMIC_RECLAIM_THRESH_MAX			(90)
+
 /*
  * Calculate chunk size depending on volume type (regular or zoned).
  */
@@ -1870,3 +1873,74 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 
 	return free_bytes;
 }
+
+static u64 calc_pct_ratio(u64 x, u64 y)
+{
+	int err;
+
+	if (!y)
+		return 0;
+again:
+	err = check_mul_overflow(100, x, &x);
+	if (err)
+		goto lose_precision;
+	return div64_u64(x, y);
+lose_precision:
+	x >>= 10;
+	y >>= 10;
+	if (!y)
+		y = 1;
+	goto again;
+}
+
+/*
+ * The dynamic threshold formula is:
+ * (unused / allocated) * (unused / unallocated) or equivalently
+ * unused^2 / (allocated * unallocated)
+ *
+ * The fundamental goal of automatic reclaim is to protect the filesystem's
+ * unallocated space and thus minimize the probability of the filesystem going
+ * read only when a metadata allocation failure causes a transaction abort.
+ *
+ * However, relocations happen into the space_info's unused space, therefore
+ * automatic reclaim must also back off as that space runs low. There is no
+ * value in doing trivial "relocations" of re-writing the same block group
+ * into a fresh one.
+ *
+ * unused / allocated sets a baseline, very conservative threshold which
+ * properly goes to 0 as unused goes to a small portion of the allocated space.
+ *
+ * On its own, this would likely do very little reclaim, so include
+ * unused / unallocated (which can be greatly in excess of 100%) to bias heavily
+ * towards reclaim when unallocated goes low or unused goes high.
+ */
+
+static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	u64 unalloc = atomic64_read(&fs_info->free_chunk_space);
+	u64 alloc = space_info->total_bytes;
+	u64 used = btrfs_space_info_used(space_info, false);
+	u64 unused = alloc - used;
+	/* unused <= alloc; clamped to 100 */
+	int unused_pct = calc_pct_ratio(unused, alloc);
+	u64 unused_unalloc_ratio = calc_pct_ratio(unused, unalloc);
+	int err;
+	u64 thresh;
+
+	err = check_mul_overflow(unused_pct, unused_unalloc_ratio, &thresh);
+	if (err)
+		return BTRFS_DYNAMIC_RECLAIM_THRESH_MAX;
+	/* Both quantities are percentages; remove the squared factor of 100. */
+	thresh = div64_u64(thresh, 100);
+	return clamp_val(thresh, 0, BTRFS_DYNAMIC_RECLAIM_THRESH_MAX);
+}
+
+int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
+{
+	lockdep_assert_held(&space_info->lock);
+
+	if (READ_ONCE(space_info->dynamic_reclaim))
+		return calc_dynamic_reclaim_threshold(space_info);
+	return READ_ONCE(space_info->bg_reclaim_threshold);
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 1cc4ef8dca38..2f4c00525a08 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -163,6 +163,12 @@ struct btrfs_space_info {
 	 * Exposed in /sys/fs/<uuid>/allocation/<type>/reclaim_count
 	 */
 	u64 reclaim_count;
+
+	/*
+	 * If true, use the dynamic relocation threshold, instead of the
+	 * fixed bg_reclaim_threshold.
+	 */
+	bool dynamic_reclaim;
 };
 
 struct reserve_ticket {
@@ -245,4 +251,6 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
+int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
+
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 1b866b2a01ce..0683a23e5254 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -903,8 +903,12 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
 						     char *buf)
 {
 	struct btrfs_space_info *space_info = to_space_info(kobj);
+	ssize_t ret;
 
-	return sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
+	spin_lock(&space_info->lock);
+	ret = sysfs_emit(buf, "%d\n", btrfs_calc_reclaim_threshold(space_info));
+	spin_unlock(&space_info->lock);
+	return ret;
 }
 
 static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
@@ -915,6 +919,9 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	int thresh;
 	int ret;
 
+	if (READ_ONCE(space_info->dynamic_reclaim))
+		return -EINVAL;
+
 	ret = kstrtoint(buf, 10, &thresh);
 	if (ret)
 		return ret;
@@ -931,6 +938,39 @@ BTRFS_ATTR_RW(space_info, bg_reclaim_threshold,
 	      btrfs_sinfo_bg_reclaim_threshold_show,
 	      btrfs_sinfo_bg_reclaim_threshold_store);
 
+static ssize_t btrfs_sinfo_dynamic_reclaim_show(struct kobject *kobj,
+						struct kobj_attribute *a,
+						char *buf)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+
+	return sysfs_emit(buf, "%d\n", READ_ONCE(space_info->dynamic_reclaim));
+}
+
+static ssize_t btrfs_sinfo_dynamic_reclaim_store(struct kobject *kobj,
+						 struct kobj_attribute *a,
+						 const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	int dynamic_reclaim;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &dynamic_reclaim);
+	if (ret)
+		return ret;
+
+	if (dynamic_reclaim < 0)
+		return -EINVAL;
+
+	WRITE_ONCE(space_info->dynamic_reclaim, dynamic_reclaim != 0);
+
+	return len;
+}
+
+BTRFS_ATTR_RW(space_info, dynamic_reclaim,
+	      btrfs_sinfo_dynamic_reclaim_show,
+	      btrfs_sinfo_dynamic_reclaim_store);
+
 /*
  * Allocation information about block group types.
  *
@@ -948,6 +988,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
+	BTRFS_ATTR_PTR(space_info, dynamic_reclaim),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
 	BTRFS_ATTR_PTR(space_info, size_classes),
 	BTRFS_ATTR_PTR(space_info, reclaim_count),
-- 
2.43.0


