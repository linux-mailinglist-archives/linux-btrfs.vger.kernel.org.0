Return-Path: <linux-btrfs+bounces-3892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D389791D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 21:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBD8B25B5D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A015572D;
	Wed,  3 Apr 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KFmTx1SE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="np8VFtPQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90951524DC
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173047; cv=none; b=F8trnNie0MlgFPHReaHcdV+A+Cw7yb4KaIHf/l64EEz6uc8xwx3cU/IyIz2/yCi+2ZYTU8fUgUzoh6lOYE4zCNjAL6ZnJ3gTytiTPwBxQKoNYRfsHiLBY3NLd607qFb216NTXs21vRdYSFy75aSi6HRiazNvkiqqe5PHL2PPvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173047; c=relaxed/simple;
	bh=xCAB1dz0G60fkwKoGzRwNA+R6E2Zwl69rvjxYvHOEO0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZCR0Y5yM8FxZDf02jORASoYLnUFLyaIa12B0SvxgBgpWTOIL+yDn+PaGTbx9p210uA5GXqemPzZsnZCnLD7mdhPw7lw2inxTkXXLQCoLKb1HmPb+zZi8d3M2Xkh+B2Zt2npkn9ZGxnvwowrY+mZUcgnHpCd94HlfF74wqONC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KFmTx1SE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=np8VFtPQ; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id A32103200A4D;
	Wed,  3 Apr 2024 15:37:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 15:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712173043; x=
	1712259443; bh=v5X+W5b6ba3edalkMnml9tOiy5Ds+VhC4vp4iVhCoAA=; b=K
	FmTx1SE9q2SUT3J6Y06A7vuKcle4ajX1+DLtXLI8yUgh+9TAF0RVqR7sHZo0H+TU
	BviWqF4n8rixX1JH/FXmOf4WPLpz1K8eJWwYCexeQhh/CJk+vEd2TEVBSPSi/GZp
	MFpj6+CLWp7rGOrh46wuJQzZDOAKOlbiwWIcmJv/f/usMVpPt8s06+Qw446gBhj5
	vAdr4AmZzFPi9BwMauywEk/DDe6gXEiaTsYktRXmMs1V6fWaqzj84IINHsKTDoDp
	tkQ841RLBkkXYRvN9kQBOyzwWtAptVExfT2qCwuF+7aAznV2Fsrb4RxFDF2laWu5
	cbsqmmxWF2WwZ2E1VmVyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712173043; x=1712259443; bh=v5X+W5b6ba3ed
	alkMnml9tOiy5Ds+VhC4vp4iVhCoAA=; b=np8VFtPQFhQ+QnrXzocNpfH9pNHpV
	vfmVJaok8wZnk6+dkOSVURqgFBZKnxzbrHGw8+qmEx8RaAz7rQKL9HQzXYLSZIks
	9JLXZDLmu0x9zpG55HhmwMFJ+v5822LbbywuFQX6vx1opH/43HTqwPmYhplORXnf
	5cwF5+/eJ3gfyhW8Fl24RdnAxYkWHn9zuB+ZOznm8/uhllowBt8kbLVOWnk+iRi9
	a1/VNyMq+mtO1pNxv5agA0Q2x+J+5gFDO07r1cETAF37fpJNmIXkgRA28U8dg9a4
	w4rNCVRFgGu6M3xBuiyc6IcoOouDtEbghQJ5bhByM2Pi95SjmkYB9gYYA==
X-ME-Sender: <xms:8q8NZibbCcuCozakP0Pbkuaf-tnCG-hBP8gDkTtkDRI9p1hlO7OlSg>
    <xme:8q8NZlaPFJFsfH-HzvD5a9oUlp9ptscdedtM9hSjW-SEYhkCPJl0lgDeFsJW6FFz2
    Rathlgb7OeoU9wUcaA>
X-ME-Received: <xmr:8q8NZs-jMO29CPR23u0U-80eWoV_FtqohlhVAvdDizbCSKDkUA2A3L2Kf1ww1d-UFM48wIUp9Mlu_Tnar09GepPsrss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:8q8NZkolmXqkx7klKvu2LEEOV1SiR72-cnzHBBML6oH7iRIbaxyYGg>
    <xmx:8q8NZtogMZM3183tpVIhWlXF8cy2d4Rzqw9-XVAnhr7yXETOMF_IPg>
    <xmx:8q8NZiR1TaX5hVpcxr3uW90e94S_mdveW7xEn3sxb2rE4Ig8DbSnPw>
    <xmx:8q8NZtrJBqGbU_6U9iPwRWhOFTDEj_ivmpEOCzjGH01r5KTmcuwqcQ>
    <xmx:868NZk2vCV-vxRYkrjYnTvvTs4iiKpDkTm85hYB1Axi3bTiY7cC8o2XcGr7t>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:37:22 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 6/6] btrfs: urgent periodic reclaim pass
Date: Wed,  3 Apr 2024 12:38:52 -0700
Message-ID: <7d32872b06daf6f9d8b79acde2e762bd5840e94b.1712168477.git.boris@bur.io>
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
index 149623cbd2d4..fa42668d3fc3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1965,17 +1965,35 @@ int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
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
@@ -1983,14 +2001,29 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
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
2.44.0


