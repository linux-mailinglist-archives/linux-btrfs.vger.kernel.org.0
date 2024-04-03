Return-Path: <linux-btrfs+bounces-3890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A689791C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3593B27868
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83BA1553BA;
	Wed,  3 Apr 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cGZO9Zth";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OboABfaQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FE155315
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173041; cv=none; b=drgILTQpIlDJXVhaRegdV7ooZ4opi6UZC9ouXL2VjFGQpOTcA85kz0Hz+Kly12a/MFWlRvFvDu8udW9OSrIKyqzRyZntYm2/c1Qtew6W555nJD3T8fCYoknija5fmfUOxxVIhw3OXdAiqbPLXphSBlU6o84MtVO4royTkegi5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173041; c=relaxed/simple;
	bh=4Ey6836iivGRU1Gb5Nfuzl7x9MsB6tsX5ciSJxjm4TA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sud7WljNCcJvioMl4IfUUVlSCNfbvooDtlbuPrh8VTlPoFFaQ0O9DPOyZYuzqHsoW5PJiiB3Ur3AOR8LC4FMYRa0s61wUqBPY7+gj4fW8wMQxuYiB4xpPHLP0dHB+KcYvFCk9lhjtjXUYqujUWR/6y7/5fQAtGvNQXk8zvaxPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cGZO9Zth; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OboABfaQ; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 46EEB3200A57;
	Wed,  3 Apr 2024 15:37:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 15:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712173037; x=
	1712259437; bh=cgbkBsw6NnaVznfNtwSdyiCYE5lRXssIJ5uAkkzktmo=; b=c
	GZO9ZthxxyctMjFkp8/Q/RsyjS7Esy0goFI0TP/KUVVBA/mrsdzRy3gLY+7eK0S8
	nnZ/3nrOqLecSLE5Ihn4sLLUQUIh017hHbzpftS1UID/8wEXjVGCOsZP8Pr2AAOT
	V3y31H5z2hH4/bBHoWaSMaHMYd5gQLz3T4z3iyMqYG9j3L82lqt9GuFIYEozK2nd
	h4K6wCljO9pcJ5u/D8kRpCPBk7v9XoDKAP4DMBpfXqs5iDGEukAkyd0s69zJtMhp
	fu+bKbYS8jOLZRSHC1CR+RHRYoB7huhxh3VohrMl8P4m7IA5zj9e576B5jKXtMAi
	Od6Is+O/NS9CSUmZHjDkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712173037; x=1712259437; bh=cgbkBsw6NnaVz
	nfNtwSdyiCYE5lRXssIJ5uAkkzktmo=; b=OboABfaQ+TDVFLgPpYa8jrRoCz3lM
	LXe9k5r9dGZm/s2Di8swNqTZebyy8Bxw0CstMl/GqXCTdi54FHwJeMF+R7iZYdZ+
	OjKyKEP7eKYA8WCeEO4Rt6gyJG9yvI5yxlzcdMGIXGZcKFDwEovxn0YeMzfvopqi
	cIzItIbHslM/b25Y1H2923hKxRswVp0IKJKQJ1HI1xvIwiP1SwByOE4wHZzfeHV+
	0sFLQhXUd+2plTmB4FgAwK8l4vsFR+eq19iUwfndSMJLeCdSaIYYXmFl+VV8G2HU
	j+omlT/Lmaby43CuyKmMZWljFofmmYFi0yslgyzMtcvg4h6zDDtG0Vidw==
X-ME-Sender: <xms:7a8NZhiviZX-mEycxqbDNQH4Y3V33oFhNLUFsbKKcNvcU8_1XuJ8Tg>
    <xme:7a8NZmA5BeHjdQ9TXbddsrNUs_IkNwNhhdhK5jNQJ7fdcHdQBSYCjpuVETZs09Lg_
    rQj8r8P2KR1kDjLRKc>
X-ME-Received: <xmr:7a8NZhEGppwJs3RXoGp7-sYNbx2ITdD-C9RSoIsrxh3M-UGJdsdnmLX264qKJ2WSLqQDB0QGAo64z9mSeesxabzHzXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:7a8NZmRHs3bsMpobs2Q6QBOXxP47K07i0Pk8b2vIDTnpomWp_y9PhA>
    <xmx:7a8NZuwB7WBMUO06gbyGwbREBGp_3MB84OkhLuvPVBY_rcJPiCSrlg>
    <xmx:7a8NZs51GiMKbp0iFIHj5qVsz84N8qwHBkpPYpwKm7cZg1wPiP5nHA>
    <xmx:7a8NZjzOoGjsi9G-eU4_7uDjZVsLkC-jmBn2doMg4xjvVkNOhZ60hw>
    <xmx:7a8NZp_gpUoziCpoFk9t7KMu2jWYv8LJZCI5POD-9AIfoOiacDGfMhcwFSVt>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:37:17 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/6] btrfs: periodic block_group reclaim
Date: Wed,  3 Apr 2024 12:38:50 -0700
Message-ID: <b1cddf813a3bdb632abe93c241ba9472d44ce937.1712168477.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168477.git.boris@bur.io>
References: <cover.1712168477.git.boris@bur.io>
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
index d6f8364ac598..2a42edc3476b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1960,6 +1960,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
 {
+	btrfs_reclaim_sweep(fs_info);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (!list_empty(&fs_info->reclaim_bgs))
 		queue_work(system_unbound_wq, &fs_info->reclaim_bgs_work);
@@ -3658,6 +3659,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index 90e472a49784..422fb7d4b4e1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1962,3 +1962,54 @@ int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
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
index 6879c68a0e63..6f1f530d9c3b 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -184,6 +184,12 @@ struct btrfs_space_info {
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
@@ -267,5 +273,6 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
+int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4bce08ea08ab..7c2e31e40435 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -972,6 +972,39 @@ BTRFS_ATTR_RW(space_info, dynamic_reclaim,
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
@@ -994,6 +1027,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, size_classes),
 	BTRFS_ATTR_PTR(space_info, reclaim_count),
 	BTRFS_ATTR_PTR(space_info, reclaim_bytes),
+	BTRFS_ATTR_PTR(space_info, periodic_reclaim),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.44.0


