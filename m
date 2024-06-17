Return-Path: <linux-btrfs+bounces-5772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E390BFAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F147DB2232B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AEB19AA71;
	Mon, 17 Jun 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="uXS6e/Tg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkIU/09a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17750199386
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665915; cv=none; b=R9oTPGemjnZ0bf9+3bGIBBBA/q0fkU2EfMCauRQeXFgjMISpDzdi8zBvQOkDpiCGpYjo/kuOzTla/5kYzKinIT8Ok0bWx15/C9iOfFzekvPMbuiZ55oUQ3ftBQIDSKEerJOfyUvBDAf6Cja+aaYPnZMiGiyueRv9OYLKw568Ssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665915; c=relaxed/simple;
	bh=qExTGby6CosLPl7qPrN2Orkxy2bM8icBzUZXg6rHZT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9M/d0vxlWZs7rGDPuoOn7Vz+ulO/omRWyB7O4DD6Pc07ZbfPl0I5JHlTEsIBO+pJryC5nyMFZg+WIFMiXYxgrfkn79o1RNoXIziw4Jue66Lh3q0bbRuiQAFGleqZohnEC7MyITztdBQnYaLMgEK70QGAXw1QAR1ZO4klHSyvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=uXS6e/Tg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GkIU/09a; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 35C691800109;
	Mon, 17 Jun 2024 19:11:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 19:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1718665912; x=
	1718752312; bh=i/a9YxOLy7wdQLBkKQ+/YGmQFtHN3uziYDpWaMMJ+js=; b=u
	XS6e/TgmmYxoYa/koZDmcNAVGVJdzB6y5IVjlQx56rlzks+/JlaWqXTldtgvMUaZ
	ONc+Ea81FE959/4pckSP0Oj+JJvRE7sk+YSoO9hWG1u3FXluggNFNOL3VPxQWDgn
	cgzb/nW5jKSU+zefEs1BhOrWul9CzdXcMleG7qE1feOYgh7bvB906amC5rCzOgSI
	op1k5rMDkwr1E2sK2jLUhnHqBMyOxcCp65pAkt6KDaCKTCrr5lczAujotOUMVMNW
	2Za03NQjSPDGMLk5nrOozvnOvutz5DP8M5Wk1p5pG58PUvNkxNfbvPTyTaWxNd5P
	6ucYNG6KdU+fojQptjysQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718665912; x=1718752312; bh=i/a9YxOLy7wdQ
	LBkKQ+/YGmQFtHN3uziYDpWaMMJ+js=; b=GkIU/09aUR6SSrKP9PJc1xFzbdgs+
	vFHqHOxeNO3LUtOEPhLxQrIV1ytCRTRpRbfXu9iYD9ClLKV3e6tcMWbMaVnEQMCx
	jGgq8T2yZnWocO5ZK19GNp4MnSEgOAp7uqmtZbbdjhJw3k3NH2XrCU751fvr/J6W
	WCmrzj+SEbhFKfqKC6B5J7oDEfBZhgLB/fjNcvNI0ZhKTJwHgO6PpYWkqssiy460
	JMllbkVjYDl8X5MYMhz5wU2/ERkbrkRSPWUb+NKOb+No/hE7BranSBSeoyGZDuk7
	J9q5x/f36vr1Ls9btsiwfjy+rTaR+o3QROrXiu4gAlPUxDOQqRI0YhOfw==
X-ME-Sender: <xms:uMJwZk0o6qwTMVvpQK85U1FVSWiitxOPczqJ-GvtsqCwZCoNqECycQ>
    <xme:uMJwZvFy2jRjka9fSSx5nAw-AnAydA0deRxYoPadq0YbJge7Z6_NncL6_7jLJb-0W
    OpkWCQZ0vSNZoycoww>
X-ME-Received: <xmr:uMJwZs7O0681ri6zBi_rf-h2xCxR0aQbGuIoTFAGv49GZhhIKAkLpc1NR6E0jhlD0ktWGD55ynn7X1mnhXQsV8pVK8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:uMJwZt2Nx7c0ldbw4VF_k5L-bKIM79aXakI8WWJ-75SBK9PSy7fgZg>
    <xmx:uMJwZnG5azOElo-U7vX-tPx8VnK9CEiN-t5pP6r6OewqTXGxi7jMwg>
    <xmx:uMJwZm8XjCBw_W2J4AzgnIJjzGf3GZxfeUDbpFKX6kkJATyFBDBeaA>
    <xmx:uMJwZslFpQfap5yGMliU22NI8pzN86jtB7cKWi9gtWeK3UI5t7nGWQ>
    <xmx:uMJwZsQjMEIhe7zeKgXIk03ntcw0SLAw5A-G0uInT0TrCpzAOjkUkvNE>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:52 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 4/6] btrfs: periodic block_group reclaim
Date: Mon, 17 Jun 2024 16:11:16 -0700
Message-ID: <fb89c55c5c8942d7f4e741b4aa6f95003e395c75.1718665689.git.boris@bur.io>
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

We currently employ a edge-triggered block group reclaim strategy which
marks block groups for reclaim as they free down past a threshold.

With a dynamic threshold, this is worse than doing it in a
level-triggered fashion periodically. That is because the reclaim
itself happens periodically, so the threshold at that point in time is
what really matters, not the threshold at freeing time. If we mark the
reclaim in a big pass, then sort by usage and do reclaim, we also
benefit from a negative feedback loop preventing unnecessary reclaims as
we crunch through the "best" candidates.

Since this is quite a different model, it requires some additional
support. The edge triggered reclaim has a good heuristic for not
reclaiming fresh block groups, so we need to replace that with a typical
GC sweep mark which skips block groups that have seen an allocation
since the last sweep.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c |  2 ++
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/space-info.c  | 51 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  7 ++++++
 fs/btrfs/sysfs.c       | 34 ++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c3313697475f..6bcf24f2ac79 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1974,6 +1974,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
 {
+	btrfs_reclaim_sweep(fs_info);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (!list_empty(&fs_info->reclaim_bgs))
 		queue_work(system_unbound_wq, &fs_info->reclaim_bgs_work);
@@ -3672,6 +3673,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		old_val += num_bytes;
 		cache->used = old_val;
 		cache->reserved -= num_bytes;
+		cache->reclaim_mark = 0;
 		space_info->bytes_reserved -= num_bytes;
 		space_info->bytes_used += num_bytes;
 		space_info->disk_used += num_bytes * factor;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 85e2d4cd12dc..8656b38f1fa5 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -263,6 +263,7 @@ struct btrfs_block_group {
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
 	enum btrfs_block_group_size_class size_class;
+	u64 reclaim_mark;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0d13282dac05..ff92ad26ffa2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1953,3 +1953,54 @@ int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
 		return calc_dynamic_reclaim_threshold(space_info);
 	return READ_ONCE(space_info->bg_reclaim_threshold);
 }
+
+static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
+			    struct btrfs_space_info *space_info, int raid)
+{
+	struct btrfs_block_group *bg;
+	int thresh_pct;
+
+	spin_lock(&space_info->lock);
+	thresh_pct = btrfs_calc_reclaim_threshold(space_info);
+	spin_unlock(&space_info->lock);
+
+	down_read(&space_info->groups_sem);
+	list_for_each_entry(bg, &space_info->block_groups[raid], list) {
+		u64 thresh;
+		bool reclaim = false;
+
+		btrfs_get_block_group(bg);
+		spin_lock(&bg->lock);
+		thresh = mult_perc(bg->length, thresh_pct);
+		if (bg->used < thresh && bg->reclaim_mark)
+			reclaim = true;
+		bg->reclaim_mark++;
+		spin_unlock(&bg->lock);
+		if (reclaim)
+			btrfs_mark_bg_to_reclaim(bg);
+		btrfs_put_block_group(bg);
+	}
+	up_read(&space_info->groups_sem);
+	return 0;
+}
+
+int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+	int raid;
+	struct btrfs_space_info *space_info;
+
+	list_for_each_entry(space_info, &fs_info->space_info, list) {
+		if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			continue;
+		if (!READ_ONCE(space_info->periodic_reclaim))
+			continue;
+		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
+			ret = do_reclaim_sweep(fs_info, space_info, raid);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 2cac771321c7..ae4a1f7d5856 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -190,6 +190,12 @@ struct btrfs_space_info {
 	 * fixed bg_reclaim_threshold.
 	 */
 	bool dynamic_reclaim;
+
+	/*
+	 * Periodically check all block groups against the reclaim
+	 * threshold in the cleaner thread.
+	 */
+	bool periodic_reclaim;
 };
 
 struct reserve_ticket {
@@ -273,5 +279,6 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
+int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 360d6093476f..c58cea0da597 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -973,6 +973,39 @@ BTRFS_ATTR_RW(space_info, dynamic_reclaim,
 	      btrfs_sinfo_dynamic_reclaim_show,
 	      btrfs_sinfo_dynamic_reclaim_store);
 
+static ssize_t btrfs_sinfo_periodic_reclaim_show(struct kobject *kobj,
+						struct kobj_attribute *a,
+						char *buf)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+
+	return sysfs_emit(buf, "%d\n", READ_ONCE(space_info->periodic_reclaim));
+}
+
+static ssize_t btrfs_sinfo_periodic_reclaim_store(struct kobject *kobj,
+						 struct kobj_attribute *a,
+						 const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	int periodic_reclaim;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &periodic_reclaim);
+	if (ret)
+		return ret;
+
+	if (periodic_reclaim < 0)
+		return -EINVAL;
+
+	WRITE_ONCE(space_info->periodic_reclaim, periodic_reclaim != 0);
+
+	return len;
+}
+
+BTRFS_ATTR_RW(space_info, periodic_reclaim,
+	      btrfs_sinfo_periodic_reclaim_show,
+	      btrfs_sinfo_periodic_reclaim_store);
+
 /*
  * Allocation information about block group types.
  *
@@ -996,6 +1029,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, reclaim_count),
 	BTRFS_ATTR_PTR(space_info, reclaim_bytes),
 	BTRFS_ATTR_PTR(space_info, reclaim_errors),
+	BTRFS_ATTR_PTR(space_info, periodic_reclaim),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.45.2


