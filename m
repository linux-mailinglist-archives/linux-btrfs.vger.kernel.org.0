Return-Path: <linux-btrfs+bounces-15507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B76B0665B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817F11AA1BD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597EC1FECB0;
	Tue, 15 Jul 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VN4E+C2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OalrDx5U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E92BE7B4
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605813; cv=none; b=BI2WT4cBaTq6jsYZu7vc66nRl7KsfhiHQMBronci2u8A1AEynGSH3dn8jseAqd6+jZHuXUivet6Xe8i9dp7EfmOhGOyhIhZ8Cu+zPyOfCIveYbIjP1KFZmn/HD3QimX/Er/8sYrIJl8e1qzjtNzxMiZoMvUBZRFF2pZJHSkj8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605813; c=relaxed/simple;
	bh=UlcuYx8BXGiZte4PCj0wPbKEPhEKWBlZMUTDvfyQXCs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EdSWdcv9pNt54VWl1bQvRGyNQfc7q2PUNshbSQ9B5yqghiAO9wSIGmlSzi4wCvFI+zx1u/HuTAX9C8qbWwzISAzbm42/V9mCD97wjyVpt/ET+/POkSk3W3jNPDdf4pfjiFE0Jze84Pq9jhbvTuQosOlcba7YpK6L8bneuI/fqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VN4E+C2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OalrDx5U; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B96DC7A007B;
	Tue, 15 Jul 2025 14:56:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 14:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1752605809; x=1752692209; bh=lO5iFTgnoxFKDOJpYq84T
	kXyX6yXWyB0ZJFSP8nABUM=; b=VN4E+C2H4rrlbgu/OAbC5MNni4EUDeLhKSsBW
	Ca1gtlKDXQuZSFWsVsTkbEL5qm+pn1HgY749afs2gkiMLSYlm7shz8tsmfyyn5iC
	lwrYxjPxEkmVkbI9YCPtA+xkL+qbP0RjTN+uWBzmEvIfOvQe5r/J8S0irQNnQdHK
	r2N6gsllmgMVeojKDbMIGunEhSHhxNr6cUa5nlpmI6EvPmS7yYuzmZEypo61NzeJ
	nL4SXnalMQE/sCoN+yYOs1KBb8Awt8Qrwq4jDby4J7Ax8UamUME91AXgnzThzgqd
	RW0herXhty6uI05kdPkHoiTCwhU9IkrYET16fS+Rr7CWZac4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752605809; x=1752692209; bh=lO5iFTgnoxFKDOJpYq84TkXyX6yXWyB0ZJF
	SP8nABUM=; b=OalrDx5UFhNlcuuJBD/FzOrhpccVFonipNmNSFqO8GqhL+edMNz
	1+woe7hsRZ04hRzem7wsyXIt0zk4MC2DARQajhkrTrnuWZ2naF8LTmx7GX9k0JVp
	IpUyMXqPbMXPUpfLb6rmrHuPR+oBaT5wapOJNw/NEn25y0CaFN1xoSyhvKoa+kKc
	RXhF75f4uxBbRU/FTqCjw609/iFGlRxG3wzkI2+aoPGZ9rqspmvbMFPSmCqf6+f2
	fgU5c4bGr/AxxeAOkzV+ZbE15bj68aZViDZbx1Cq31O3nNIbvmILZfvPq0JAh1Zn
	jhSot4NLI5EsK25vkl6WWD7ws17sWZYUQbQ==
X-ME-Sender: <xms:caR2aG74tAbVf-LsyV40rgrSQ5-Hfux2AnSWcIWxVd2FyzPP4KQPlQ>
    <xme:caR2aAGR8Q8rDJsr62jkzJfapnpVmpYAxzj3j2HhVQnRSnIlGtc0fv5ShenETVtKy
    uI4IpHTgDUrydxLBBk>
X-ME-Received: <xmr:caR2aHTs54TKtVDpCXSTnvINK-Z20s0r-nvb35tz93oYX-mcJDwuYQB3vrjz-Poxa8-i5JZM_bilh_VHP3X7pBKczsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfeegkeehve
    ehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhi
    nhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvg
    hrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:caR2aBtj5nEo6aAFxIiZ3m2iRaLMONiEQ7LVd-09FfHIPpFcwkIVew>
    <xmx:caR2aOxfnuCQo45TyzXhzi264hJsVDF9g0E4IVsiMSLQZSnGMwri0Q>
    <xmx:caR2aD6Swd6v-w3BL-qfqqvKTnVB-zMc7iobrA9TrdDlOWin6dDPVg>
    <xmx:caR2aAXwyAj0_nyo-H4_KXeB8RoerOPzY7YJSO8xbjPAA0rH23EVsg>
    <xmx:caR2aHSr1465FWOOCRC8_fz7tBUs5tWG35QnvsEWjj3UhzIL-VX22EBF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 14:56:48 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Date: Tue, 15 Jul 2025 11:58:24 -0700
Message-ID: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The explanation of the feature is linked via the original patches.
But tl;dr: dynamic periodic reclaim for data is a way to get a lot of
extra protection from block group mis-allocation ENOSPC without
incurring a lot of reclaims in the happy, steady state case.

We have tested it extensively in production at Meta and are quite
satisfied with its behavior as opposed to an edge triggered
bg_reclaim_threshold set to 25. The latter did well in reducing our
ENOSPCs but at the cost of a LOT of reclaiming. And often excessive
seemingly unbounded reclaiming.

With dynamic periodic reclaim, if the system is below 10G unallocated
space, then the cleaner thread will identify the best block groups to
reclaim to get us back to 10G. It will get progressively more aggressive
as unallocated trends towards 0. It will perform no reclaims when
unallocated is above 10G.

With its by-design conservative approach to reclaiming and good track
record in datacenter testing, I think it is time to introduce automatic
data block group reclaim to btrfs. This does not conflict with the use
of the tools in btrfs_maintenance. One thing to look out for is that the
bg_reclaim_threshold setting is no longer writeable once the dynamic
threshold is enabled, and instead is a read-only file representing the
current snapshot of the dynamic threshold.

To disable either of these features, simply write a 0 to
/sys/fs/btrfs/<uuid>/allocation/data/(dynamic_reclaim|periodic_reclaim)

Link: https://lore.kernel.org/linux-btrfs/cover.1718665689.git.boris@bur.io/#t
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0481c693ac2e..8005483fbfe2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -306,6 +306,12 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 		if (ret)
 			return ret;
+	} else {
+		if ((flags & BTRFS_BLOCK_GROUP_DATA) &&
+		    !(flags & BTRFS_BLOCK_GROUP_METADATA)) {
+			space_info->dynamic_reclaim = 1;
+			space_info->periodic_reclaim = 1;
+		}
 	}
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
-- 
2.50.0


