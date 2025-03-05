Return-Path: <linux-btrfs+bounces-12031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D848A506B1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E343A7DFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6ED250C0D;
	Wed,  5 Mar 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDYVQYa0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FF2512D9
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196758; cv=none; b=CoJA1/8flUjUZFSZgPTtHgNLc/3cdh//GQuB4XEhAWfaDVQenXeBZtmU+ZYqTtk1+LCzke2PVqHvG8F0k3gExucJ29ptiHLiTAUnnU3VWLNm1PUPnc45rhZ6e0VjBsiw1Pkbzv5OJjS4Va1OGVnr8n/21WSyd2FJSn9o59UvSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196758; c=relaxed/simple;
	bh=MgWOsgZqI5T8K169gZV9TDzeg88d/7NeM/BpQfmy4nw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rtBtpGL7G0AKLjvWe+Kn3ZyWFhCQk3Xk7YGt75qai1TQnvDxRdD+LY9c4zaukuBbrCUdhHr34eEprimFfOQgssI2lCPSkqv7w9U2sd8f0fUxBnSgpwMh0DviowUpC/qRkWDJ9QE0aWGTE/DgsNf83BaqmBDxDQBdXUng1HVGUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDYVQYa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD43C4CEED
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196758;
	bh=MgWOsgZqI5T8K169gZV9TDzeg88d/7NeM/BpQfmy4nw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YDYVQYa0fU8Pzl2786MpxXdfkMwiJBqgfEZ36DZSUY/ECAVFY5OqHn0ER+NyIvoHU
	 SA4RS9/DnseAYp7k+cYpvfMfTrO2l9kNIoXcqJZ3dUG8N2+Juc4bInMzKuUmR2BwT6
	 sPowIHw8EYnbmHSnw45AWEyYcd99eJ+6Pb1vdTWHBvEECPv4yyQBhlpLgryaBgo7ld
	 4HXcd0m+BZap5Wbx/wIVrZc4wrC149qLDaI+Ny59BEVKLqPArjsfrAToGt5VsSJ/HS
	 E30mDxVV3T25ejoYizBgkp1GKN1AmM/cL0Shsl/rAJ2PFdSQMWxn2bIo9aQozE/w0e
	 HmxIm+rqhGhBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: move __btrfs_bio_end_io() code into its single caller
Date: Wed,  5 Mar 2025 17:45:49 +0000
Message-Id: <427e1cc1519d2117c9cdedba51929e958340cdac.1741196484.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741196484.git.fdmanana@suse.com>
References: <cover.1741196484.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The __btrfs_bio_end_io() helper is trivial and has a single caller, so
there's no point in having a dedicated helper function. Further the double
underscore prefix in the name is discouraged. So get rid of it and move
its code into the caller (btrfs_bio_end_io()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/bio.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2f32ee215c3f..07bbb0da2812 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -105,18 +105,6 @@ static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
 	bio_put(&bbio->bio);
 }
 
-static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
-{
-	if (bbio_has_ordered_extent(bbio)) {
-		struct btrfs_ordered_extent *ordered = bbio->ordered;
-
-		bbio->end_io(bbio);
-		btrfs_put_ordered_extent(ordered);
-	} else {
-		bbio->end_io(bbio);
-	}
-}
-
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
 	bbio->bio.bi_status = status;
@@ -138,7 +126,15 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 		/* Load split bio's error which might be set above. */
 		if (status == BLK_STS_OK)
 			bbio->bio.bi_status = READ_ONCE(bbio->status);
-		__btrfs_bio_end_io(bbio);
+
+		if (bbio_has_ordered_extent(bbio)) {
+			struct btrfs_ordered_extent *ordered = bbio->ordered;
+
+			bbio->end_io(bbio);
+			btrfs_put_ordered_extent(ordered);
+		} else {
+			bbio->end_io(bbio);
+		}
 	}
 }
 
-- 
2.45.2


