Return-Path: <linux-btrfs+bounces-2083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB0847D0F
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383E5B29699
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1512C80D;
	Fri,  2 Feb 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qp7UN+k1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7sEuNN4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10A12C7FB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915478; cv=none; b=DSAeDk+dUgi5PhqizvNcVa7ZS8XIuI2diuuzYpP31A7l9HtzkXhUSPm8bz5TUz+taPZRrhIjj5GsDmBM/pDk5VPQWPGf/HvzJ1SZqWYavQX7IekJv8gMDdPyhq3JcJM9IFXoUR9efNTX/4OD5tBsrMtdQgsA8pJzJki6+1kWsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915478; c=relaxed/simple;
	bh=MwPCUsDSyNQsPVWxVFrJD0rPXmwUZ+OcsXt+WTsECpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to62sHw/vDTqSj4noxRBfXt84AAjBEAnir59hZ5j8z4+Jk/2Z13GQa2GPh3do0VgrfMXlLvHrXvY6f5RwG+xw48zxkou6eDH1T/JCGY1x5rXzIwelgZVnkUdmsKg3ga0jpvagArgOA5k2MH5KxCtIlhslvYxJZtLidijN6/Kf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qp7UN+k1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7sEuNN4; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id E60BB3200A28;
	Fri,  2 Feb 2024 18:11:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 18:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706915475; x=
	1707001875; bh=h9O7dxLO/acKwh8Dnm/WI1eMQYqwQZvPi7iExUHv/1E=; b=q
	p7UN+k1TsEnHHG/DpN34wDoLtIQpgoWcGq57coVBtsKWGS+rP7YfztroOjtWmlEv
	49gjDrZ2rvFQ7ka1cUPpHxtfdkEac6MXwokte/kYfRTkucWLHtV0B+CJ8djEUvzn
	WZIJ2vzJH3eMVSoKHI/6Vxqg5M6GyqWk2bJn/vqwFZJleTvWICSYH5xWMz+vvUIv
	PDkdTwbAOvLzVBKaHA5u3r11ebnqX5voAxIrqcF3wkA0xauY9rlzR8WBxTKirvlP
	eO4wAkJerzLCP1XXA7fMvTJ6l9oejtBJ08DUiUrFfw8+3URuhIO2bgvqT1/nfjPt
	lBRM0c+yP9kjEesLEA54A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706915475; x=1707001875; bh=h9O7dxLO/acKw
	h8Dnm/WI1eMQYqwQZvPi7iExUHv/1E=; b=X7sEuNN4pU7xIuYZIe/OmYQbtsztH
	Y3XmXAdL0JR+LzLlqK2b6yUZqFssmPQjaXLAJ3H8YvCEIQAwImpPhcIbpp7f9svg
	ZQKj0t1kYbTQDq+WUWFONzhncZOH8kVBXjuWvsZ7H1CzfGBLlcEbw21B/kPsgdbH
	7pTFd8wC/0WC8eFEK1uDPHZ3Shjzjy/FZjb72hUmJqJBMShz3bJ+UkKsGukGMmwn
	yNGzwt7OGIeDB0AH94I5bF61030uI9FCaJ3/hpwQ1LggDtf643m1baOg8O+D/Vk9
	pIKsD5HPGsOrSvMLklMXHoYnPVnX5gNSLXW4dus7Q8D5OkiBrm2CLcXbw==
X-ME-Sender: <xms:k3a9ZedRIedg_xkFD4s2oxcMjxUkmx31PZbM-hcpx895ImDqdzHNGQ>
    <xme:k3a9ZYOFr3PlkAv84UhjKE6QteIPFSw7m8n6O6xM0MBsiTuvLAQdksVpmk5QVG1UX
    7OzIzwgJ3A56Lb5ZKI>
X-ME-Received: <xmr:k3a9Zfji05mqtvUnocdQDNQ5t4BDvNCnzHdVyVj6aGtmDO4vIPc-EcaT4XQfGk98igoDu8FdKmRbPTnYdSa3u5TVt0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:k3a9Zb_fpW71w35c_VDW6Jwol0P4TaABvg9JKv6GgJsObID8wRx4Og>
    <xmx:k3a9Zaui_UUPpY-wCr7Z9XqY8m0hm2y8P_4OLPhOPWU1Yn04lkgxXA>
    <xmx:k3a9ZSGBrm2_yTmN8X9oEaz6kz38RnoGSDSctLIdTM5iNho4BN04uw>
    <xmx:k3a9ZQ1nbWyTmeoqA23KY9ASHLppHd7FUjQWjFzONGNpRYwdBQVv8Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:14 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/6] btrfs: periodic block_group reclaim
Date: Fri,  2 Feb 2024 15:12:46 -0800
Message-ID: <1173e535ec7b46bda33ed2dc4219027502763902.1706914865.git.boris@bur.io>
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
index 6244c76f3584..1a752a8a1bea 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1898,6 +1898,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
 {
+	btrfs_reclaim_sweep(fs_info);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (!list_empty(&fs_info->reclaim_bgs))
 		queue_work(system_unbound_wq, &fs_info->reclaim_bgs_work);
@@ -3565,6 +3566,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		old_val += num_bytes;
 		cache->used = old_val;
 		cache->reserved -= num_bytes;
+		cache->reclaim_mark = 0;
 		space_info->bytes_reserved -= num_bytes;
 		space_info->bytes_used += num_bytes;
 		space_info->disk_used += num_bytes * factor;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c4a1f01cc1c2..24b576b7a88c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -250,6 +250,7 @@ struct btrfs_block_group {
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
 	enum btrfs_block_group_size_class size_class;
+	u64 reclaim_mark;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 86a87501af08..fc4e307669ef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1944,3 +1944,54 @@ int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
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
index 2f4c00525a08..2917bc4247db 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -169,6 +169,12 @@ struct btrfs_space_info {
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
@@ -252,5 +258,6 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
+int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 0683a23e5254..98bd8efaa2dc 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -971,6 +971,39 @@ BTRFS_ATTR_RW(space_info, dynamic_reclaim,
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
@@ -992,6 +1025,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, chunk_size),
 	BTRFS_ATTR_PTR(space_info, size_classes),
 	BTRFS_ATTR_PTR(space_info, reclaim_count),
+	BTRFS_ATTR_PTR(space_info, periodic_reclaim),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.43.0


