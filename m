Return-Path: <linux-btrfs+bounces-10247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50489ECF51
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33C916989F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A219F13C;
	Wed, 11 Dec 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEKeuikY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAE1CB9EA
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929519; cv=none; b=QdUH9tyHlIA0Eu9mV+YXlVzOI657wggMFwoNrT7QU0Cs9tuiSLkhkHQHIdE8EP0ZtAqXKhM9AVXrgnWitPTok/jQ71ujdwCal8GODb90VTqrGmBMISfaplij2Y58XnLklwj0huvHV1T7DNh1No8VZMP47qQ/jMIJqPtOWE/IpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929519; c=relaxed/simple;
	bh=wlztWU2/5Sh2XLcOIFFf2g8YfNNaC4Gx+8q51GvVDo0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=demoWfzsOkUYzl/kJ6oXiEZ4HFBbByPfqAGCV27PgQbMEI0Eszrs1509vVG/KbFTPlt524/dnnWwLd6eylb2opKaMRTFXIRktGVDhOrC3NKRTZfA4xojdWPIKcHOS7oxGaxmJQR+tdZin8l/rSv1smh54k/yX8EkWkk5faFa6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEKeuikY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E4EC4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929518;
	bh=wlztWU2/5Sh2XLcOIFFf2g8YfNNaC4Gx+8q51GvVDo0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FEKeuikYwm7WjPPXCIDtEYj2fa5Uv0t3Q9/MFvEl1pHIeP7dvSch9kjS3OW9DKW6Q
	 HSN7fbvVs6tl+ZZjF75RcXgSVlfAClG2qyxwOmbhfUTk06hEjnwg1+pREjqLOapNn5
	 PQWtcj8o3if0VbQkEa10BA6b7uZaO8hwuj1w7tWDJs8bHq7eZnQomYS7ff0mzhq3C1
	 DShdiwB5HbtB+YwYpxeTcfsLEHvnlx6l+q8vhEgbmJTifoZ9x6YTx3wCi4aBlr/rks
	 VfzToYfc70mpVAbGCws0TTAsRtq0NJzz3TUF67dYCQ38iYX9+wJpoNGemIIZVPoUdE
	 47mGYScuA1Ffg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/11] btrfs: remove the snapshot check from check_committed_ref()
Date: Wed, 11 Dec 2024 15:05:03 +0000
Message-Id: <acf98d83138ad5674f5924bb653f6b9d64754dda.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At check_committed_ref() we have this check to see if the data extent was
created in a generation lower than or equals to the generation where the
last snapshot for the root was created, and if so we return immediately
with 1, since it's very likely the extent is shared, referenced by other
root.

The only call chain for check_committed_ref() is the following:

   can_nocow_file_extent()
      btrfs_cross_ref_exist()
         check_committed_ref()

And we already do that snapshot check at can_nocow_file_extent(), before
we call btrfs_cross_ref_exist(). This makes the check done at
check_committed_ref() redundant, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 46a3a4a4536b..e81f4615ccdf 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2358,14 +2358,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	if (item_size != expected_size)
 		goto out;
 
-	/*
-	 * If extent created before last snapshot => it's shared unless the
-	 * snapshot has been deleted.
-	 */
-	if (btrfs_extent_generation(leaf, ei) <=
-	    btrfs_root_last_snapshot(&root->root_item))
-		goto out;
-
 	/* If this extent has SHARED_DATA_REF then it's shared */
 	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
-- 
2.45.2


