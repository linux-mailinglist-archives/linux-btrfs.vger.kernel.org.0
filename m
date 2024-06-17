Return-Path: <linux-btrfs+bounces-5769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFF90BFA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C161C2165F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848E199EA5;
	Mon, 17 Jun 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XoZqZl7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtdkABK3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31341991BD
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665908; cv=none; b=dzvIHpMj5KaoAWDWSucfWwwOhZ03/YOW74iw+E9q3R+0yRiMVPy1gaarVUH1FRpyaX1voNnMboyjhlxREZj+OuGDgK0VZunMG7/UkY5CWCKXxYu3ecyA6RUCbz9CafEK9NujmjQ8Dp3sU5IB1tgGQKTceJW0nDNwhnH7YsHxaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665908; c=relaxed/simple;
	bh=V5pq6RsQMqshkMZO+7vRqbKwCHfssSYCfykW2brzq7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwZV9wmYMBgT45ZxZ/7tPBCRVMog9hUbB9qF/7RFNvV90two7HA/0nmEanVEBkkerk2gjUbc4pSbVCYacOZ2q7ajKrvNn+H5l+4QnVaofvoqkpYitoj9Rzu50JMNy1WGr6/8eNGKZzNN70P/F5dGKFLegjp1QG8SD4Jcc9npmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XoZqZl7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtdkABK3; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id ED0491800070;
	Mon, 17 Jun 2024 19:11:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 19:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1718665905; x=
	1718752305; bh=drP16WlchPKqzld7F0BNrNzZYtWwaBpBu/Xv9OA06ME=; b=X
	oZqZl7SZTWaFGqQduvmiMXamYWkZseP+8BfBs0PuZ28HUr/UTtp2K3p8ZIql1CK+
	aJg9YRMt+RGOg2GIu9X3qOgG93/Wg86bK8riqyBkYo8FzmQwzSTFRPUNzfYyMwxB
	CKGebjg67C0xBm6NYaAscTXb12DimQwxh2sCQcQtPhbBA65AIZFXeGeew5Sgim5k
	jxSRqrqU86FjWO9zcPaZUaOggRd+mlt/HzZILSTBi1IsRkmI9zZgSqboif7vLpOv
	7WTEImDYyJ/mBAd6JqSt1hxJqPlEBWGBtPHwWEedsRcZmu8riLmVvkpSNBJgO0ro
	0Wa5fNnb96BpVtueJGMSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718665905; x=1718752305; bh=drP16WlchPKqz
	ld7F0BNrNzZYtWwaBpBu/Xv9OA06ME=; b=ZtdkABK3PlUGwkSK9cnySmAj/AoMP
	VrMuTev921YosLrfp78skjXrycNdcB9USgKM1prrpxqteLIceTXjd4Sbm2sJLois
	dpQ6arYaLf8C6i8I2X1vWUnyHynPF3BFUJ6BhCF4cFkaG7siow+HkBFDK6h4n6o+
	BRwjMKXe8KWtI6SqGa/V7ac7uHqti7RF3DZA31xtIL9vYC74XLmRK8s1QG6PjTMB
	pbjUdxVdxqM8+aFkB956epZwe/j39o2Jl+4qQ931+sJYavlRbki8qUZzsnQbZ4g7
	MkSW13ODdr8PPsA/ZzfmujxiDN+W28Ufnw/2gxNkx6CWMdS1NKcSGCJ6g==
X-ME-Sender: <xms:scJwZgYpFlGpz8tkUqc2vqJDljW9lKAQvx-q7ADnVlvEJfO4NSw3gQ>
    <xme:scJwZrb3yLySqV-M0ZIL4h-PneRP5aq1AAb4i7kbP9E6rSCuH6C9myc-Zf3ZsMvUO
    GXDrfvZcgGDr08R3M4>
X-ME-Received: <xmr:scJwZq9URxcQvbSvQGsGCbwXQETmzT9uX5oTENuNgeKgUE7dg9WGFWKphOQ1V-LZYQOxLpzk_Kt_0Ck7HkmI4Bjsm-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:scJwZqq0qxcLk0uG0MW9HDivooHrABOLpSqwFjDSjm-BnS2Sve3BMw>
    <xmx:scJwZrpsaI2-k6Hzhq9PhkwIl-N88sBK570j7FzJQ2C6BqXydtmyqg>
    <xmx:scJwZoQDhA_xax6Mql3-kr4TmtL9xVJob-8lplWmrOKaiOj-Cjfuzw>
    <xmx:scJwZrqoq16RkbLH2C3vaPi198i6qgI86a-N-7nLXHnKk7rea9-7Jw>
    <xmx:scJwZi2Xqg8H_fwG5xoVkMfexbGRte76u1jATavAAb1kjHDJDziiBHbX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:45 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/6] btrfs: report reclaim stats in sysfs
Date: Mon, 17 Jun 2024 16:11:13 -0700
Message-ID: <65bfe2e6aae82f4d58f6592dcdbb827e20982a3f.1718665689.git.boris@bur.io>
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

When evaluating various reclaim strategies/thresholds against each
other, it is useful to collect data about the amount of reclaim
happening. Expose a count, error count, and byte count via sysfs
per space_info.

Note that this is only for automatic reclaim, not manually invoked
balances or other codepaths that use "relocate_block_group"

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 10 ++++++++++
 fs/btrfs/space-info.h  | 18 ++++++++++++++++++
 fs/btrfs/sysfs.c       |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9f1d328b603e..824fd229d129 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1829,6 +1829,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
+		u64 reclaimed;
 		int ret = 0;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
@@ -1921,12 +1922,21 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(bg->used * 100, bg->length),
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
+		reclaimed = bg->used;
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret) {
 			btrfs_dec_block_group_ro(bg);
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
+			reclaimed = 0;
+			spin_lock(&space_info->lock);
+			space_info->reclaim_errors++;
+			spin_unlock(&space_info->lock);
 		}
+		spin_lock(&space_info->lock);
+		space_info->reclaim_count++;
+		space_info->reclaim_bytes += reclaimed;
+		spin_unlock(&space_info->lock);
 
 next:
 		if (ret) {
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a733458fd13b..98ea35ae60fe 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -165,6 +165,24 @@ struct btrfs_space_info {
 
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
+
+	/*
+	 * Monotonically increasing counter of reclaim errors
+	 * Exposed in /sys/fs/<uuid>/allocation/<type>/reclaim_errors
+	 */
+	u64 reclaim_errors;
 };
 
 struct reserve_ticket {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index af545b6b1190..919c7ba45121 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -894,6 +894,9 @@ SPACE_INFO_ATTR(bytes_readonly);
 SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
+SPACE_INFO_ATTR(reclaim_count);
+SPACE_INFO_ATTR(reclaim_bytes);
+SPACE_INFO_ATTR(reclaim_errors);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
 BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
 
@@ -949,6 +952,9 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
 	BTRFS_ATTR_PTR(space_info, size_classes),
+	BTRFS_ATTR_PTR(space_info, reclaim_count),
+	BTRFS_ATTR_PTR(space_info, reclaim_bytes),
+	BTRFS_ATTR_PTR(space_info, reclaim_errors),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.45.2


