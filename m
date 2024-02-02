Return-Path: <linux-btrfs+bounces-2084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919F847D10
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04CB289D37
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9A12F385;
	Fri,  2 Feb 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CkUoNkY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXsiiWlF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2B12F365
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915481; cv=none; b=QdeZ5FVjFLkPDv1GktOWT3AAHvw2Xmq5C+NElz4HBiIjMM4tZ46B33lZpgeJSX6uqR7I5DsdIHchOtkMJnNL6tCmDKAU9ACc+AvJ3Y/51Z/eZDmkMTOXcroGQcC5ZvclYJAFicMhO+WZD9cAnEPI4tN1F0oXdgCevyRnvMxVKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915481; c=relaxed/simple;
	bh=l9YURtbeIUuyNk5PEmNwlwr7hiVMyrTp3TPGK5Mpbs8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWOS5crgkMwTGPJDFyBMsqAebonHB8QCi0YFRyZGLPyg8ijT+IjwGmaEUpaqCKVd6lj+aetC1/mxpql7ma9WLzG/lprnZeTTWV0IKe4MLmIYBq4/DB8tCRgMZr/TMSSrcYFH5OB2ZwNVR76Mpa9b5/aV+HpzrvemmX9Nh2IHEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CkUoNkY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXsiiWlF; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A43193200A48;
	Fri,  2 Feb 2024 18:11:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 18:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706915478; x=
	1707001878; bh=5bdReofwLGtO+8cUIAEc6icgAkBeYI2dmaEEhoxLCeM=; b=C
	kUoNkY6H3hiKaHxdlbrroU6Y8olhIYN6/9i1c6Cqx7nMIkLeOd3ZMzVWh/P8V2S4
	IYKzdUotqTbTSo+9o/OCW2ViBilgdL0S0UZPqtVM4kzP0Rw+Mxl6QflppPlao6qh
	0r21EppP9JDdMqzt8WqeAWfa5xH596bFQAOOgxH2AROqQ6ZhAR0DQI7vxQITOyIW
	xXrv1J7HQuumCNNbIXltNG+4ONY53u0zn6m7AOpPmQ2Gsr40xt8vwFm9ppa8VFe9
	sTOp3Hs/CucxY2QcugfEDZ6MOJnP4HlUuYsDAZhx7iWbddnD1zNgUb/C1NUCL4bK
	yjHVHFwFANDaS2Wkixcag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706915478; x=1707001878; bh=5bdReofwLGtO+
	8cUIAEc6icgAkBeYI2dmaEEhoxLCeM=; b=mXsiiWlFYXrFOnRmw9v7VUGSxWCns
	nW0RyRC2bGMTHvXnDXfU91xYuPVd0W1s87MCPJ751TrR6zyxnViAl548orOso2D1
	YeIi5YtzLKNHcpIBMR54v2em7lArsL+b/7oe9KrSkf+l4iUQiV5Xep1N8TX960uY
	9nM1xdIunlX1jM+uL/rittYcgzBChZk6DD0C9DwdslpOqXGQXHdincKcnlpDSqm7
	oNaR5a2mTqRr9FxABXVXoQum4uANQWy3zElcJF3beI8LZmbq+x74K5VVRMnJt+VN
	ba37+/9OXMvB8vue2RyQBDIuSvbn+zLnEwmbHGLto6DVFxjGLCJZXCDgg==
X-ME-Sender: <xms:lXa9ZS8lBGAPi5-qkMwUsN4BdSLPkKnbhZsqIt1mgdvXBvHX0fYLjA>
    <xme:lXa9ZSsrduypdiFWJKBYmwI5AU2EDJld_Nayf-LePGkVfDRILsnM8itX73HueiedR
    XYoLH7iHoITQ22AbS8>
X-ME-Received: <xmr:lXa9ZYBbHeZAiDNtZMaIn4vF0KGKhdNfVGfuL0gv7wf11Qj8pRFggfcNcm3nARMFrudqNieEYo3OhDe4DyW8XJ_vL5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:lXa9ZadhmPmojTMUbuOqiTIj6EDTvs573SmC6A9gVf6VvIyuY43rag>
    <xmx:lXa9ZXNi1UGcuAfh8ktIoDORr1YWa0Abnu8YKaRyg4pJTImbynrPQQ>
    <xmx:lXa9ZUnZOLuI4NDuxUzWWYLIJrxihKSDED34CGeqDTWFxSsOtfmmwQ>
    <xmx:lna9ZZVoasfqNSIcja7dR3gj2cUhSUkdPA_Jsa_G2t0JA8Hqoi4RXA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:17 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/6] btrfs: urgent periodic reclaim pass
Date: Fri,  2 Feb 2024 15:12:47 -0800
Message-ID: <c0c76dae129839e1f8a708157f449de2d21a01b9.1706914865.git.boris@bur.io>
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

Periodic reclaim attempts to avoid block_groups seeing active use with a
sweep mark that gets cleared on allocation and set on a sweep. In urgent
conditions where we have very little unallocated space, we want to be
able to override this mechanism.

Introduce a second pass that only happens if we fail to find a reclaim
candidate and reclaim is urgent. In that case, do a second pass where
all block groups are eligible.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index fc4e307669ef..7ec775979637 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1945,17 +1945,35 @@ int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
 	return READ_ONCE(space_info->bg_reclaim_threshold);
 }
 
+/*
+ * Under "urgent" reclaim, we will reclaim even fresh block groups that have
+ * recently seen successful allocations, as we are desperate to reclaim
+ * whatever we can to avoid ENOSPC in a transaction leading to a readonly fs.
+ */
+static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	u64 unalloc = atomic64_read(&fs_info->free_chunk_space);
+	u64 chunk_size = min(READ_ONCE(space_info->chunk_size), SZ_1G);
+
+	return unalloc < chunk_size;
+}
+
 static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
 			    struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
+	bool try_again = true;
+	bool urgent;
 
 	spin_lock(&space_info->lock);
+	urgent = is_reclaim_urgent(space_info);
 	thresh_pct = btrfs_calc_reclaim_threshold(space_info);
 	spin_unlock(&space_info->lock);
 
 	down_read(&space_info->groups_sem);
+again:
 	list_for_each_entry(bg, &space_info->block_groups[raid], list) {
 		u64 thresh;
 		bool reclaim = false;
@@ -1963,14 +1981,29 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
 		btrfs_get_block_group(bg);
 		spin_lock(&bg->lock);
 		thresh = mult_perc(bg->length, thresh_pct);
-		if (bg->used < thresh && bg->reclaim_mark)
+		if (bg->used < thresh && bg->reclaim_mark) {
+			try_again = false;
 			reclaim = true;
+		}
 		bg->reclaim_mark++;
 		spin_unlock(&bg->lock);
 		if (reclaim)
 			btrfs_mark_bg_to_reclaim(bg);
 		btrfs_put_block_group(bg);
 	}
+
+	/*
+	 * In situations where we are very motivated to reclaim (low unalloc)
+	 * use two passes to make the reclaim mark check best effort.
+	 *
+	 * If we have any staler groups, we don't touch the fresher ones, but if we
+	 * really need a block group, do take a fresh one.
+	 */
+	if (try_again && urgent) {
+		try_again = false;
+		goto again;
+	}
+
 	up_read(&space_info->groups_sem);
 	return 0;
 }
-- 
2.43.0


