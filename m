Return-Path: <linux-btrfs+bounces-11028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B4A17DD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 13:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE5160634
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E11F191A;
	Tue, 21 Jan 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ova7igV0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DE19342F
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462815; cv=none; b=awrjGy5sP9FfYrXeA7W/W0zGBV6CtMfPypVgANe/7REm2qKGbMSjZN3qFcQDh8YI3Jv1fV/wo8C7Dj7vYrkfnKhHdtq1Aj2xPkPIY0O8liKOsYx95PxwstGaKrrg1fOgPyJgLIQTVn2m3gahayywyyUgxu9U/66+jMAmOUD7jIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462815; c=relaxed/simple;
	bh=HBSCGZNCUEnWgrp/cW0Fwqkr73l5ZStLSTommivykE4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Hjy7hCgmWs7V3f0Bz9X5WRFDmoyL1MJ6cs1y1DOlkg+yDUTZ4cHDMwHt16KExXDVr/lLVHOcMgFQhI++En8zfPKQ17WcdsVucGGF9aLzh+LGPXs8umIA/LY9XCv9vIsaPWf9/3qEwZWJF04/nyx++d2Rcc20W4IK6yJrfR/asd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ova7igV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF190C4CEDF
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737462814;
	bh=HBSCGZNCUEnWgrp/cW0Fwqkr73l5ZStLSTommivykE4=;
	h=From:To:Subject:Date:From;
	b=Ova7igV0s4cq6scqLpvk4+OprF1+8jUoOXyM+EfXO5yRXx35iYesLaxZ4S2Ps3BVQ
	 vu+Tu9XFgXDcopuJBGw3djD+z0LMz5q2DKQxZ/jRHe0/ulLk7Nc5V2y+dIKD1yBC1t
	 EvGuYCgMFQ/Fbx4QoFyPd8AncDg4aTAHQOTkmw1iTAxXNOUKrjPgE86YCcGMTt3TNP
	 Hbkna3S+4//apl2pI83UiUYJdMF2PhOetfc3XNBVxjW4Y5yQGMT28IkaYDfx16yzTr
	 7jvLEqGSM0axdDw+XSn4kQB/nBmYpAjAfAVVK6suoSrB+V03LYD28aI45lNvWKw4D7
	 t521Gwrq+RKpw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid start new transaction when cleaning qgroup during subvolume drop
Date: Tue, 21 Jan 2025 12:33:31 +0000
Message-Id: <a1d2ce906be6a35c652b8792074cdb48b6d3c9ac.1737462738.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_qgroup_cleanup_dropped_subvolume() all we want to commit the
current transaction in order to have all the qgroup rfer/excl numbers up
to date. However we are using btrfs_start_transaction(), which joins the
current transaction if there is one that is not yet committing, but also
starts a new one if there is none or if the current one is already
committing (its state is >= TRANS_STATE_COMMIT_START). This later case
results in unnecessary IO, wasting time and a pointless rotation of the
backup roots in the super block.

So instead of using btrfs_start_transaction() followed by a
btrfs_commit_transaction(), use btrfs_commit_current_transaction() which
achieves our purpose and avoids starting and committing new transactions.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index aaf16019d829..f9d3766c809b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1880,11 +1880,7 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info, u64 su
 	 * Commit current transaction to make sure all the rfer/excl numbers
 	 * get updated.
 	 */
-	trans = btrfs_start_transaction(fs_info->quota_root, 0);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_current_transaction(fs_info->quota_root);
 	if (ret < 0)
 		return ret;
 
-- 
2.45.2


