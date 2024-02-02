Return-Path: <linux-btrfs+bounces-2080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE19847D0C
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD211F23D93
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83C12D777;
	Fri,  2 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RzmZxP5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bf+ciNiB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465512C806
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915470; cv=none; b=lkqoAS+Ccvr6YJIx4MufLLVFvy+k/E7PZ6FqAMhe0KZqenFB7sbsk3iUNs5/tTam6TxEkCM8TwQ9fj1LuCT8J1SopvHekrZni/Xjet+BPklAy6l4JpU960jQ8CFZOoT11/gTlRx+nztcibxXl4LFo9aRaoQZOLQ9AhzpbtGvsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915470; c=relaxed/simple;
	bh=licd7DP9pCSmAue1+Q+46FOuUMqfMaLxflGRfp2EAAg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL5n7JaynrVgtqN7zmKeJRxeE7BvCMM3pbrJmq0CMq5x2dZsJb8IZNB8dBFru56HpSeUD1QncI3T57jXTwvs1ZD4x1xx0wvUgmjSS7tWILTt35cUGc6KrT4Ta81fU5c3/7z8ReEYejLb8tLlbqCdGvMPqIvo7vvkMD23O2hXLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RzmZxP5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bf+ciNiB; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 8C6803200A33;
	Fri,  2 Feb 2024 18:11:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 18:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706915467; x=
	1707001867; bh=IMKo+0BPrIi8IiIoBYvcebctVOv9mvT57y/QGI+hISo=; b=R
	zmZxP5pFALkFd89Ztfrf4CY47mNEaicB7n7RnIZ2T8A/N2xY++tjsMxowSTIXCxb
	hBVWn9gLyChp0HrMernw3KNY+yjw++ucwi4u74Y+UQpWL1fqWQm0egR5qiDJm/y3
	H6F66yiuPOpOj9DLwmo1mPxcsdrgdt/B5iGtiUdxAAnKMC9TVOCsGY78AJvTCJcz
	JgR/JCnfYY6+IhogyrgOur9van483E8m3r2ldY+2K8z+Y0kw1tgbHxn5NLx5J6Y4
	Chb2M2oAdil1ppo/BKeFRvuFagZvDMJZme71pxAJfulJijJBaE5L8dpWbMQ9L8bR
	umQY/MZghUhK7Hhj0uHKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706915467; x=1707001867; bh=IMKo+0BPrIi8I
	iIoBYvcebctVOv9mvT57y/QGI+hISo=; b=bf+ciNiBDfdQgBYGI3SuyUVEiZuuH
	Vy+u4K0kw73JH9oomih5R5SP034Uc3CA7CUcAPrBp0pQ7FZLlyp+R7xlA1p6clsT
	zC0ikCAXqHq+gkfY/2fsBv47f2FGkiCfQSjTJEyVZZaTBwE6YnIf4lYoMKVTIQy6
	4SdFw+UkK90nn6wqqTGSkUDkNPjgeUF9vnXnuSuZUqxsAqq3iue/KDFzK4a6z/3s
	teYmvXdeQlZVZi2A2S/vg4mqK4n1jt5uFIvz0Es/ywdDpRMxVPq0C/fcZUrWFPm4
	HHl+gVCgS/6I/5i4LELRXbhgiZbJlcCmRG15AvxLKjvmi5K4Ocb2z+w9Q==
X-ME-Sender: <xms:ina9ZUlSuPHgQzjWXcI5QDApLd4LtGq-vuCVOVt3QNNDTIKFFKOjug>
    <xme:ina9ZT27qvbsX8uIU12pkDcwT8BxyvQRGr__gLiEr14w6VYb0UiZnYCTBqufFn9SC
    _48msevOtwWILF4Vk4>
X-ME-Received: <xmr:ina9ZSrfhuQNCYynubAN2sc1kt4jsta3_9kLnBz2h2Vv1VAGyb6t13F-XpiwJikTHra_Q9Z9T3l6pxdTgqnFfABIEs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ina9ZQktiOV7YesDz4KznruVVVxnX8BbMdo503izj2NJJMZOkYWnGA>
    <xmx:ina9ZS0HAaKpkKe7Hn_agC-yuJrWIxpLKrA5-6BjFRdfVDZYGf0FMg>
    <xmx:ina9ZXsYRQuSh6Ehc7Wig0k73sjmR56lrjSo5xkU0_EH9JHWoE61IA>
    <xmx:i3a9ZX_3XLl8dC-IF-iYpk-6AZtAVgT5ZIvqujtEoFIWRaMAHy2yJw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:06 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/6] btrfs: report reclaim count in sysfs
Date: Fri,  2 Feb 2024 15:12:43 -0800
Message-ID: <c2ed218fbe9b4cd0c668389a178f3f80db43f95e.1706914865.git.boris@bur.io>
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

When evaluating various reclaim strategies/thresholds against each
other, it is useful to collect data about the amount of reclaim
happening. Expose it via sysfs per space_info.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 +++
 fs/btrfs/space-info.h  | 6 ++++++
 fs/btrfs/sysfs.c       | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a9be9ac99222..7f05fdcee199 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1858,6 +1858,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(bg->used * 100, bg->length),
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
+		spin_lock(&space_info->lock);
+		space_info->reclaim_count++;
+		spin_unlock(&space_info->lock);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret) {
 			btrfs_dec_block_group_ro(bg);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 92c595fed1b0..da3e68612d5c 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -156,6 +156,12 @@ struct btrfs_space_info {
 
 	struct kobject kobj;
 	struct kobject *block_group_kobjs[BTRFS_NR_RAID_TYPES];
+
+	/*
+	 * Monotonically increasing counter of relocated block groups.
+	 * Exposed in /sys/fs/<uuid>/allocation/<type>/reclaim_count
+	 */
+	u64 reclaim_count;
 };
 
 struct reserve_ticket {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..1b866b2a01ce 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -894,6 +894,7 @@ SPACE_INFO_ATTR(bytes_readonly);
 SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
+SPACE_INFO_ATTR(reclaim_count);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
 BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
 
@@ -949,6 +950,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
 	BTRFS_ATTR_PTR(space_info, size_classes),
+	BTRFS_ATTR_PTR(space_info, reclaim_count),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.43.0


