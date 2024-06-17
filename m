Return-Path: <linux-btrfs+bounces-5774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0856290BFAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2AB1C22AAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B819AD80;
	Mon, 17 Jun 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DIuDPh5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5YgUgDK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21919AD65
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665920; cv=none; b=W4ZTaWgqd65LWlmqPa69B8iBea1KiwWukN3ZhdFQmvcOD4vSbcaq7OTcN3cLROaGV0iRiQaQTn3oB3woFxWmClB4X/KJ28bz4VxBYBLEc5ipSGgW6IY3tgFPYZUhGFw/WgU8Uf5HSnTV4f+qr13Vk44oHVRTra0o5HvfCjFxlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665920; c=relaxed/simple;
	bh=hzhoGO92xl8LPbFjODE5N7gGSveoLFVMK34FF/OXWV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl9rvsKcjZ91TbABzkE1oQxJX+pt6ZxfP6DqLRtUzH4E2k0QAZBKSQ6tJu7bRqK5C1pQxN7Vub49ofF593zeNnCBCHg30fQaPgG1bo7utOCMfgHgxqVudU8DXcaIoEWwmxtWmZ/2wNyPbbM1QFQDRhmqT/05hBtvWjRMOrdW+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DIuDPh5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5YgUgDK; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3A9661800070;
	Mon, 17 Jun 2024 19:11:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 19:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1718665917; x=
	1718752317; bh=PsTNSV15U4LIhwToEqb9sR3MJ90lJ2kczFDkVNsdOqE=; b=D
	IuDPh5WTDSrfGV4pNEMEm+hFSjrcql5AitXC93IBy3Hjs7+Hx5tTDCMMmtt5LYo0
	SdP9hPTbFgG7pMz1Pnt7nthecAxBkHFgKfNwO/26u63aKOTUWVkSfUidlJWFsXoZ
	FrdAfrsEJAXwCkwGHglhExDlWedcVvHB3el/nOnRCkrwUabCChmgSNKb22Z3gWBZ
	dgd6Az1zlrkteNzMJKsphPqjJs1iuvKbC8lyikrNM9Jvs80pLZ0QfaEQ/8B8Qw6J
	RTqxZNDNo7exvG9tkfpCgeZ0XbUUEwEugZ8GkwOpRZN1KcjGhWywOdD2URe1eSk5
	qHjCBjdsPyefApVGOrotg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718665917; x=1718752317; bh=PsTNSV15U4LIh
	wToEqb9sR3MJ90lJ2kczFDkVNsdOqE=; b=p5YgUgDKwFyGNeiXAs+iloc456zmg
	IVUTpEJDAWYvdCRt0Tru4rRqfRVhuViXD2w715ly4DuXkjHKiyqRK5XhWTFHNPhH
	IHuV07OKBnrJvJSpVd3UGwOaC9qg5STtvEWzPnYjyxcW+0p796emzofXYeu6+YDV
	cvjsqskyTgpanC7qE1+ol//CYciBtV6RpMrrfFniclgPcPMdZKaep4OLTgy244SY
	W8mjzpXU4aiwverp+M8/TYKXIUXO81AP7wxX62UEO2c0uoN42ggS5/VVIGA24gEs
	FqF4abttv9UmnLXHkJq5kThhKsASJkVEKcrXqvf9tFsTuurPC//bDKGOA==
X-ME-Sender: <xms:vcJwZr-51mBdBH2gVmj69BVmn4WrbYQZK8NqGM-M7gpkiUQBMskb1Q>
    <xme:vcJwZnvMWEw5__C4tmDa0OdFZUFMrg1906y6DainwC0Sic9eO9Y254fqA4G-GCApA
    pOQ5TYlGuRSddZ03Kg>
X-ME-Received: <xmr:vcJwZpDqSWyZ5v8LqoO5cSmvidYnd00sJVgZ6kdeH4r7SRX1bA4G28hS7pbrR8HEFjsbsSQDj-c0DLt9Mk094pMUspI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:vcJwZner2eWQyWubfLQb_F6rTggFp3DjZKspeRRqkOq-kCq-7HFdpg>
    <xmx:vcJwZgOwsu0v4ayOdzL7ggTHrRpto2nof9HfslvsVGDpqu1S5fREdw>
    <xmx:vcJwZpk_4hxih0bBBmpaZT9h3FCVCFr2-LBoC3AL-Ce_hc-OMeEKFg>
    <xmx:vcJwZqsbIlOsZXgBZLAfXHof4etmcLPjYYzQMxrL02x-UJcATIkLAA>
    <xmx:vcJwZpaalKlKG1-fVzg_tRtQLdmjkqM5UbFnsOD3kYfx2MW0wzLXe0fU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:57 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 6/6] btrfs: urgent periodic reclaim pass
Date: Mon, 17 Jun 2024 16:11:18 -0700
Message-ID: <6bf9d464d1a1b73853cc4fa82e233ff5e007a14a.1718665689.git.boris@bur.io>
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

Periodic reclaim attempts to avoid block_groups seeing active use with a
sweep mark that gets cleared on allocation and set on a sweep. In urgent
conditions where we have very little unallocated space (less than one
chunk used by the threshold calculation for the unallocated target), we
want to be able to override this mechanism.

Introduce a second pass that only happens if we fail to find a reclaim
candidate and reclaim is urgent. In that case, do a second pass where
all block groups are eligible.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e7a2aa751f8f..95e65d5163ab 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1956,17 +1956,35 @@ int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
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
+	u64 data_chunk_size = calc_effective_data_chunk_size(fs_info);
+
+	return unalloc < data_chunk_size;
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
@@ -1974,14 +1992,29 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
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
2.45.2


