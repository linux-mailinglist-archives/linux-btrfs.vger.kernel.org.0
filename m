Return-Path: <linux-btrfs+bounces-3887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AD897918
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 21:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC641C267FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160415539B;
	Wed,  3 Apr 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kdKRJ6Vu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQH0FjNZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71014885B
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173032; cv=none; b=RgK4/RAvCqWjotgvXXNx1spq7CGqHGdZHj3IdVAHLW0TOGsFm3Wfu0bR1vrybcFyd3Bf+ClViW4ezAn3o4yXT3JVuDWP9Ir3NkY4Ouq3a9rJQJBJ8FX/4u9jW7d9Eojm0hzfojwL723M3l5u45kGh3qyA+jbKg2HfqmbmhBGoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173032; c=relaxed/simple;
	bh=oD0RFZTfbfGcxlIBSBqIOWI4Y+l13QV4xGid1BrLTMc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVsK0KQ/BtZnKIcqJTLy5hwUwt9IM6/vsB2/vqxoOyTQ+Rw04InibbvA8IzC+GCYo6LvllYbVxXv5o984Kb0YjimPEe76P+xmjyg2wvgjd9TX9CEaCDaUFQkdK7M0dhD2sXjTl/llk9h1A2SBYXyp5EpFzfWcqpABlbH3lduzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kdKRJ6Vu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQH0FjNZ; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 664DC3200A59;
	Wed,  3 Apr 2024 15:37:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 15:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712173028; x=
	1712259428; bh=agyvQiwfEEzHG1IgP3HCGQnRFlRAILl6xaGkONpPqlM=; b=k
	dKRJ6VuBhEei14J6My+iIX9xpz0lvswuDyHVDuN3miDQSGZVVQpC1J93dr8yOLEy
	jDtiYMPAgWTFezRUm+VFiLL9bNEksa4BO4P2zPjSahdY6AqXCk8sqN1ocSMqel2H
	BowcPamm+Gzu1Z61C7wDsekaB8swSNAEOPH9h5xfQI9V8T802v27s87XoU2ln1iV
	mgJRmieg/vCBwapMpRkT90ONC35Lk/PhmJs0IMjHnddhTnuLKDLb9hyrhnmmbBAv
	p73NMJKIgvP8yW2lTgSRqcRBSQ24srJYe5ePT3fJK7HbpeAJQu8fkPo/JUG7I5gI
	EG36XXydZQxf1SWI9kuww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712173028; x=1712259428; bh=agyvQiwfEEzHG
	1IgP3HCGQnRFlRAILl6xaGkONpPqlM=; b=XQH0FjNZevWvQj3eTNlIU+kQzqNmh
	PhkZU1ZsbJJueZO1Er06p+TXrdAp0OpaWd56GSXWrBcbKe1gdjwOCrxDMHSIYQAG
	XvMuiPtn2mhSmnG9MaiXJ9OYe67rT1WFXyGNJa8a19+z8GNE/Yl5w5jXEjavrMuA
	GWuW1yVi9Qe1gDnPCoqpDBqm+8e+IgJs3ZBQQIqsoJyu4q/lKYK98okvr/m/EPPD
	q8EU3hDKmLME6E89qQQwyVfgkItZJuDr1sCeP0EkWSUhZVDWalZMVhzROolvdtX+
	oEhd/Pua22Hs7I/x6/m4FTwJJZG4yYl6DguI40erFlAYzxjnZMXLAws3g==
X-ME-Sender: <xms:5K8NZifO8y2IzerVF5neve4SMQR1APpSJl32KjLOzB3dkYJZBQ86Yw>
    <xme:5K8NZsPs78EYX08Np3ezRJEjdfmJjimZdwU_v-noREzxSXa5qHSzAeRLbuBP5lgQs
    ijSBgMVKczXBYpjMMU>
X-ME-Received: <xmr:5K8NZjhZA3eI2I68fN2W8ucjRdc8uP9EFDnQkpLuetb6dOTU1FmeXWZmrfOgFShdV2BToRBnsGABySEagJ3NMyrz8gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:5K8NZv-4GMMmLriTGFrXl1lmijsUwk0h3PpFuC6iVXF5CWpweF04qQ>
    <xmx:5K8NZuuiEzGXKs8eB5zlVXjXwvmHxYVhKljkM29q6GLDmXpzW0KrEA>
    <xmx:5K8NZmEcRgUig88nwGaG4UAiUtm5BsZ72qiJAKTSzqXPO_nrslpXUA>
    <xmx:5K8NZtPMYvaEmrJqnjJUpC4EwDMYCeI3RDssnpxUkfT1ZkZIO1JXUQ>
    <xmx:5K8NZn4CesMVMOviGJVtrZA1xdL48zZ8Qv2IqUDlC79w_0f6oO58drHr9z2S>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:37:08 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/6] btrfs: report reclaim stats in sysfs
Date: Wed,  3 Apr 2024 12:38:47 -0700
Message-ID: <b685cc587cee3fcd6e67f969a2f58063e80e38d1.1712168477.git.boris@bur.io>
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

When evaluating various reclaim strategies/thresholds against each
other, it is useful to collect data about the amount of reclaim
happening. Expose a count and byte count via sysfs per space_info.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 10 ++++++++++
 fs/btrfs/space-info.h  | 12 ++++++++++++
 fs/btrfs/sysfs.c       |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1e09aeea69c2..fd10e3b3f4f2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1821,6 +1821,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
+		u64 reclaimed;
 		int ret = 0;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
@@ -1913,11 +1914,20 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(bg->used * 100, bg->length),
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
+		reclaimed = bg->used;
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret) {
 			btrfs_dec_block_group_ro(bg);
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
+			spin_lock(&space_info->lock);
+			space_info->reclaim_count++;
+			spin_unlock(&space_info->lock);
+		} else {
+			spin_lock(&space_info->lock);
+			space_info->reclaim_count++;
+			space_info->reclaim_bytes += reclaimed;
+			spin_unlock(&space_info->lock);
 		}
 
 next:
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a733458fd13b..b42db020eba6 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -165,6 +165,18 @@ struct btrfs_space_info {
 
 	struct kobject kobj;
 	struct kobject *block_group_kobjs[BTRFS_NR_RAID_TYPES];
+
+	/*
+	 * Monotonically increasing counter of block group reclaim attempts
+	 * Exposed in /sys/fs/<uuid>/allocation/<type>/reclaim_count
+	 */
+	u64 reclaim_count;
+
+	/*
+	 * Monotonically increasing counter of reclaimed bytes
+	 * Exposed in /sys/fs/<uuid>/allocation/<type>/reclaim_bytes
+	 */
+	u64 reclaim_bytes;
 };
 
 struct reserve_ticket {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c6387a8ddb94..0f3675c0f64f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -894,6 +894,8 @@ SPACE_INFO_ATTR(bytes_readonly);
 SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
+SPACE_INFO_ATTR(reclaim_count);
+SPACE_INFO_ATTR(reclaim_bytes);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
 BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
 
@@ -949,6 +951,8 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
 	BTRFS_ATTR_PTR(space_info, size_classes),
+	BTRFS_ATTR_PTR(space_info, reclaim_count),
+	BTRFS_ATTR_PTR(space_info, reclaim_bytes),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.44.0


