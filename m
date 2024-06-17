Return-Path: <linux-btrfs+bounces-5771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79890BFA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8451C22AFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3919A291;
	Mon, 17 Jun 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YJiErCF/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FiGuTxL6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF4199EBA
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665913; cv=none; b=WjgKIdtnoyPf4X7AwGJtzftIFQOsMobAWm9vr6t/TTMrY0xa5Zy/cREtpwPpuvovHP1Z9pV/Hp7lx+7SMslKogN8wT5wTtVGxrHYsgVU/44LghCZ1flwLxHp4j0VDr/82+/1kwLMMmRsMSS6ZlVFUYE8hbCYyT4lZrSNfc0ewqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665913; c=relaxed/simple;
	bh=W7MKq/xQm4Bzx5ULYPydOlQPh9Bi53t0fgMzgB/a+lU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNGq7Ty7/pSkz38/CNblGwJe3+uVF95PRwRvEuo2oqWh/bMQYFNJ4qL2chDg2j1w9eRsvSHTmPMRZ0Y9XQZPFlR5Uh4JESjYV1DuT4qmeW6nhYio15/uo/H7qRhJ77bkzYSmO2loUgB8e8b5GAWsOO4xk0z7vQnD/+aTJjR8fO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YJiErCF/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FiGuTxL6; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id B589F18000E8;
	Mon, 17 Jun 2024 19:11:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 19:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1718665910; x=
	1718752310; bh=L4yRSO0MjM8iyRWeAKeFZnD7a5GPIHL91lsj1xqIPeA=; b=Y
	JiErCF/KmoGxhpnl25aWcpE+K+s/ynv9BAjBx1kRTlapmdFMjm0Omp6nS2S5OPgh
	E2FvkMtCdU9AkXgXb/fdIRvedA1Lu4rIsbQVHhPFjB6erFCetmpRFy1aikV3K8fO
	E/uaY2AznBRlG4qHjGGmzvTpdx3NFmzDyz6YJ9Be7tKurSjwDHasIjTcQZcq4GNK
	H6DOVUWPQVO2W4b/xz1wATvI10eeLbKjj+EyFp/LgzcyVX+qy1ayi7WXAg+LXvIj
	+WHRm7LipygdlHrqOcMmUovWj8iNRQ20xXrsVIEBJA/KwpUrW+8GzYQEqiXxyDO9
	zMp0TE0gq8GgYYbQiL4mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718665910; x=1718752310; bh=L4yRSO0MjM8iy
	RWeAKeFZnD7a5GPIHL91lsj1xqIPeA=; b=FiGuTxL6kft5jcfKR7f0aFx+yKAxz
	1q2zQpXAHsZJYLf8qJBqz4xWzFIkbdsZLxF9uSI2CAk0+8hdtgkli/spDougLkSm
	hWTl1jZnS13qZv7oc5s+WyTIX9oCujchw0uFURNSNwOR/2yg7sd2atRaSunlQ4vm
	YARBpe+a8cG9k7+Odi2A62Gijqew49jlp7eH29cRfnC5ajIfOi/SZUhaQ3Dr9fDz
	Vwm0JiMFgpkn3U2DD1sJDnePHRKXN3gA+YgtZy87mDm4d4fpHsHt/X8wOljkNrA5
	K2u7H2kc78iW7ck01vQ8xC6DVRaqkVDavRinaUqT7alccCGgNu1yfDS3A==
X-ME-Sender: <xms:tsJwZpes2MEjjKhDSWr2OIXRbJqXZqG1a8F2X15bSxnQh8Ci_vcuyg>
    <xme:tsJwZnNCe4kBTG0aHEBHJnXwWLwt9euQyEUMDZ62BIvt9ONx8yOOmgkaTMhRveKPi
    dSjoPGdhkgIIEFzo00>
X-ME-Received: <xmr:tsJwZij1kjqMax3rxpIJpBob_xMoRiSP35okeuFgCSTuYm83uU4J7R9hcvqgpDZY-nV_7sarMnv6L3Bvz8Bgzf4x0iM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:tsJwZi--l-4opfrcsM30XiqD2HEcyl9_5AsOzPU5Jnbc8NZ01ybpAw>
    <xmx:tsJwZlv4ET2z17zxWOP3zpZS7RGz6DdjTQ3FaDkym1FIr8VutJo7Fw>
    <xmx:tsJwZhEdk4ThgGF3tUnnFi3ntYlyI4TxcYsKiKma86tuEfbg3MnEHg>
    <xmx:tsJwZsM3Cptm9I2zqzojh55umBmK8Dw6HuzdhfZbWITY800GMontAQ>
    <xmx:tsJwZu6Vgy9gzIyj4VeDrlorv_n3ijyjm2KUVeXCyNmxaTym8wslmUq7>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:49 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/6] btrfs: dynamic block_group reclaim threshold
Date: Mon, 17 Jun 2024 16:11:15 -0700
Message-ID: <13ee8fb749036b3aafb331417199625c5bd12b25.1718665689.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718665689.git.boris@bur.io>
References: <cover.1718665689.git.boris@bur.io>
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
behind this threshold is that it should be very lax when there is plenty
of unallocated space, and increasingly aggressive as we approach zero
unallocated space. To that end, it sets a target for unallocated space
(10 chunks) and then linearly increases the threshold as the amount of
space short of the target we are increases. The formula is:
(target - unalloc) / target

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
 fs/btrfs/block-group.c |  18 ++++---
 fs/btrfs/space-info.c  | 115 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/space-info.h  |   8 +++
 fs/btrfs/sysfs.c       |  43 ++++++++++++++-
 4 files changed, 164 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 824fd229d129..c3313697475f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1764,24 +1764,21 @@ static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
 
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
@@ -1843,6 +1840,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		/* Don't race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 
+		spin_lock(&space_info->lock);
 		spin_lock(&bg->lock);
 		if (bg->reserved || bg->pinned || bg->ro) {
 			/*
@@ -1852,6 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			 * this block group.
 			 */
 			spin_unlock(&bg->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
@@ -1870,6 +1869,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
 				btrfs_mark_bg_unused(bg);
 			spin_unlock(&bg->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 
@@ -1886,10 +1886,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
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
index 7384286c5058..0d13282dac05 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/minmax.h>
 #include "misc.h"
 #include "ctree.h"
 #include "space-info.h"
@@ -190,6 +191,8 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
  */
 #define BTRFS_DEFAULT_ZONED_RECLAIM_THRESH			(75)
 
+#define BTRFS_UNALLOC_BLOCK_GROUP_TARGET			(10ULL)
+
 /*
  * Calculate chunk size depending on volume type (regular or zoned).
  */
@@ -341,11 +344,27 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 	return NULL;
 }
 
+static u64 calc_effective_data_chunk_size(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *data_sinfo;
+	u64 data_chunk_size;
+	/*
+	 * Calculate the data_chunk_size, space_info->chunk_size is the
+	 * "optimal" chunk size based on the fs size.  However when we actually
+	 * allocate the chunk we will strip this down further, making it no more
+	 * than 10% of the disk or 1G, whichever is smaller.
+	 */
+	data_sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA);
+	data_chunk_size = min(data_sinfo->chunk_size,
+			      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
+	return min_t(u64, data_chunk_size, SZ_1G);
+
+}
+
 static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
 {
-	struct btrfs_space_info *data_sinfo;
 	u64 profile;
 	u64 avail;
 	u64 data_chunk_size;
@@ -369,16 +388,7 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 	if (avail == 0)
 		return 0;
 
-	/*
-	 * Calculate the data_chunk_size, space_info->chunk_size is the
-	 * "optimal" chunk size based on the fs size.  However when we actually
-	 * allocate the chunk we will strip this down further, making it no more
-	 * than 10% of the disk or 1G, whichever is smaller.
-	 */
-	data_sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA);
-	data_chunk_size = min(data_sinfo->chunk_size,
-			      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
-	data_chunk_size = min_t(u64, data_chunk_size, SZ_1G);
+	data_chunk_size = calc_effective_data_chunk_size(fs_info);
 
 	/*
 	 * Since data allocations immediately use block groups as part of the
@@ -1860,3 +1870,86 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 
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
+ * A reasonable buffer for unallocated space is 10 data block_groups.
+ * If we claw this back repeatedly, we can still achieve efficient
+ * utilization when near full, and not do too much reclaim while
+ * always maintaining a solid buffer for workloads that quickly
+ * allocate and pressure the unallocated space.
+ */
+static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
+{
+	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * calc_effective_data_chunk_size(fs_info);
+}
+
+/*
+ * The fundamental goal of automatic reclaim is to protect the filesystem's
+ * unallocated space and thus minimize the probability of the filesystem going
+ * read only when a metadata allocation failure causes a transaction abort.
+ *
+ * However, relocations happen into the space_info's unused space, therefore
+ * automatic reclaim must also back off as that space runs low. There is no
+ * value in doing trivial "relocations" of re-writing the same block group
+ * into a fresh one.
+ *
+ * Furthermore, we want to avoid doing too much reclaim even if there are good
+ * candidates. This is because the allocator is pretty good at filling up the
+ * holes with writes. So we want to do just enough reclaim to try and stay
+ * safe from running out of unallocated space but not be wasteful about it.
+ *
+ * Therefore, the dynamic reclaim threshold is calculated as follows:
+ * - calculate a target unallocated amount of 5 block group sized chunks
+ * - ratchet up the intensity of reclaim depending on how far we are from
+ *   that target by using a formula of unalloc / target to set the threshold.
+ *
+ * Typically with 10 block groups as the target, the discrete values this comes
+ * out to are 0, 10, 20, ... , 80, 90, and 99.
+ */
+static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	u64 unalloc = atomic64_read(&fs_info->free_chunk_space);
+	u64 target = calc_unalloc_target(fs_info);
+	u64 alloc = space_info->total_bytes;
+	u64 used = btrfs_space_info_used(space_info, false);
+	u64 unused = alloc - used;
+	u64 want = target > unalloc ? target - unalloc : 0;
+	u64 data_chunk_size = calc_effective_data_chunk_size(fs_info);
+	/* Cast to int is OK because want <= target */
+	int ratio = calc_pct_ratio(want, target);
+
+	/* If we have no unused space, don't bother, it won't work anyway */
+	if (unused < data_chunk_size)
+		return 0;
+
+	return ratio;
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
index 25edfd453b27..2cac771321c7 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -184,6 +184,12 @@ struct btrfs_space_info {
 	 * Exposed in /sys/fs/<uuid>/allocation/<type>/reclaim_errors
 	 */
 	u64 reclaim_errors;
+
+	/*
+	 * If true, use the dynamic relocation threshold, instead of the
+	 * fixed bg_reclaim_threshold.
+	 */
+	bool dynamic_reclaim;
 };
 
 struct reserve_ticket {
@@ -266,4 +272,6 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
+int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
+
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 919c7ba45121..360d6093476f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -905,8 +905,12 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
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
@@ -917,6 +921,9 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	int thresh;
 	int ret;
 
+	if (READ_ONCE(space_info->dynamic_reclaim))
+		return -EINVAL;
+
 	ret = kstrtoint(buf, 10, &thresh);
 	if (ret)
 		return ret;
@@ -933,6 +940,39 @@ BTRFS_ATTR_RW(space_info, bg_reclaim_threshold,
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
@@ -950,6 +990,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
+	BTRFS_ATTR_PTR(space_info, dynamic_reclaim),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
 	BTRFS_ATTR_PTR(space_info, size_classes),
 	BTRFS_ATTR_PTR(space_info, reclaim_count),
-- 
2.45.2


