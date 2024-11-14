Return-Path: <linux-btrfs+bounces-9664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E449C9103
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215E4B364BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D818BC28;
	Thu, 14 Nov 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqG4qmmM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF52262A3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605843; cv=none; b=jQUQuQzU9s4ycf6aIGEyKM6wFvVjx+9psEGS7SgjTmN59O4+TI2qj8vRMJ1bTtrgxOdfBFMReoH1SIUfyRka/3lRtWIS379yTWE2mh1V020reCO7ULeswOImDBLLy9715NqKRuzli43JeZPeHdL7squnM+MJIFwtE64/c2SBmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605843; c=relaxed/simple;
	bh=Nv2NO+TPjsL/SC+SqMg9Pb0B0kDAHjFQfBTKKUbPcqs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E6GnLivwDQrhGaHOT60gdAi8uvPPuHG9IWAA42o0mnWsOQeggOZRll3swZLCw2H8oc1Ljs6yoyFunx2I169ja9ljtg/R+R4r3K2/U1Ztb1TyY3mkgyx00/efa/OEHMirwBna3vdQYfnsOcYFGjM9bCjJA74PfbJ3SsCGPPE677s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqG4qmmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580E3C4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731605842;
	bh=Nv2NO+TPjsL/SC+SqMg9Pb0B0kDAHjFQfBTKKUbPcqs=;
	h=From:To:Subject:Date:From;
	b=nqG4qmmMyoYpPxrxR+pCQA8ep0PNScg0X02+0RpfNkbBgHPdKDRtpmxSjEA9gp1kH
	 Wi9TwOWptz1glTlx4g3O60PIFhAaEaBQv1VQFbO905HxOQQgW6Rq5trHgs0YeSiCUF
	 S37jg/D05s55dEcr2ihY7YCpr3C1WpoGK2lZQY41q0cC5H/4FqNZBAIQ4UCou06E54
	 K26d3yl//3p0ZEfeegZjturXQ0qX0Qv8k67bQA1l08PJ/I3upHxKYY/1QlaRuZ4IUe
	 85Wxo2+e/4u0BJw6G5xCtDSxoXXqXTfG35VN7dhZNFCFvmmGlRGBu1YIiLmQ//kdyU
	 S7ofFVY9d44zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: advertise experimental features only if CONFIG_BTRFS_EXPERIMENTAL=y
Date: Thu, 14 Nov 2024 17:37:19 +0000
Message-Id: <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are advertising experimental features through sysfs if
CONFIG_BTRFS_DEBUG is set, without looking if CONFIG_BTRFS_EXPERIMENTAL
is set. This is wrong as it will result in reporting experimental
features as supported when CONFIG_BTRFS_EXPERIMENTAL is not set but
CONFIG_BTRFS_DEBUG is set.

Fix this by checking for CONFIG_BTRFS_EXPERIMENTAL instead of
CONFIG_BTRFS_DEBUG.

Fixes: 67cd3f221769 ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b843308e2bc6..fdcbf650ac31 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -295,7 +295,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 /* Remove once support for raid stripe tree is feature complete. */
@@ -329,7 +329,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
 #endif
-- 
2.45.2


