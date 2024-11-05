Return-Path: <linux-btrfs+bounces-9336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14349BCFE3
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E67F1C2306E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D33A1D9A60;
	Tue,  5 Nov 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhR/gi7F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669C1D9A61
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818647; cv=none; b=TPtdaqLFw3g3LZH9fzMUM7rkVIoa4j1Y6w7kdidIshGRjBn+ogZPitRGTzSRAGCVUZGZJf1PohJd/s5HkpqGevUVECGWDIIZnB5PiGJHgaKAFXytJ5SfcT2+OddEuDx864jSQC4oj0//Lmh7yv3SwWDRYyJyt15AgJLzLRzsWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818647; c=relaxed/simple;
	bh=EI1N43JqHd8U1XdC4Z7ZE9uKQHq5ylc/i3d0z1jW/6A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dE1Pb1Nx/QrErYVZmNm+dW1kYcB4jv50Q+Wn5GKbCJ0sKwwb4N05Uu3fLHYbZSrFdkjqai4nXIkDHNlVFiyG1dxunrhcNmb7QhT3GqSiXM+x+BbNUgv4ZkVvE+6YvAAIfjAdyjyd8kW1fas4eB8jRCRtCqpjsKMMw3zfKhcxjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhR/gi7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DF7C4CECF
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730818646;
	bh=EI1N43JqHd8U1XdC4Z7ZE9uKQHq5ylc/i3d0z1jW/6A=;
	h=From:To:Subject:Date:From;
	b=XhR/gi7F0wuByKPeMksD5L34jWo0iR+0+1At3So7yKnDNM2EZxJiJTJcigRUtBQQ4
	 c6iJM64X52Cyuax/tNM3SBbvk9FMUBg8sAEVAEpFhbOrKx4G3rVodsRnm3PS5dWbWE
	 z7BO2sPJifNU2wBEe0nCk37HTDBEsrDrt7G2S5523XPchnkKmu68ARcvZ9kNd6HZ5R
	 bSWB7m7+rpIOfV8oOpz6vWy/V/a24YUGsw5BVqE2GM62tMCBWHIKL2m2V8hSr1rore
	 K1uzm0196Fp2JqsJ+E51N8jCNDSbjrvGUWAsKa+oOplFTphKgDkCs1D6lgI1yMHHyk
	 O8DCCwHUlgESg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: simplify logic to decrement snapshot counter at btrfs_mksnapshot()
Date: Tue,  5 Nov 2024 14:57:23 +0000
Message-Id: <e2938504101b0832739b3421f8d07b809a9f5232.1730818481.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in having a 'snapshot_force_cow' variable to track if we
need to decrement the root->snapshot_force_cow counter, as we never jump
to the 'out' label after incrementing the counter. Simplify this by
removing the variable and always decrementing the counter before the 'out'
label, right after the call to btrfs_mksubvol().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cd3e82cc842b..26a07cbeb3a4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1049,7 +1049,6 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 				   struct btrfs_qgroup_inherit *inherit)
 {
 	int ret;
-	bool snapshot_force_cow = false;
 
 	/*
 	 * Force new buffered writes to reserve space even when NOCOW is
@@ -1068,15 +1067,13 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	 * creation.
 	 */
 	atomic_inc(&root->snapshot_force_cow);
-	snapshot_force_cow = true;
 
 	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 
 	ret = btrfs_mksubvol(parent, idmap, name, namelen,
 			     root, readonly, inherit);
+	atomic_dec(&root->snapshot_force_cow);
 out:
-	if (snapshot_force_cow)
-		atomic_dec(&root->snapshot_force_cow);
 	btrfs_drew_read_unlock(&root->snapshot_lock);
 	return ret;
 }
-- 
2.45.2


