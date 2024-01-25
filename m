Return-Path: <linux-btrfs+bounces-1781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D683BEB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C6FB28891
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494ED1CAAD;
	Thu, 25 Jan 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlV/Tl4X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB371CAA2
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178393; cv=none; b=BVLo3DjQoyqvrwZFVK24azD5oPAaFWNs/n6gte6AXFYMIf8cVFiIMqFxeXUMNhR+IziOXjDV3Vd5lcfxFMddHW5hHYxyMOODhAG4T9DCvABNUAWweRENtd0AEN7aW5MXgSQtw5+CixQQpi+5CJefF83/PeM/mWkQT5Kq1aXPGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178393; c=relaxed/simple;
	bh=B4kH0VTFE209jH2/55eFDJiNMYCyMVQk6NSt8OcUoco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7hyijBQR51Yf3vXtlt4G+fEvYONtu36MaX7rPNTGAM56r4qhFo/9NVsTdCmkMZMn8dCikNTr/+yTic6vi9DtokTbvttQaANnupJqOF3ZkLBMmbZB2zCUyV3eswLSbuPL9bEf5jWnnVs5m/0IhPmWEhBqQdIunZkzlcJ2GAOJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlV/Tl4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DAFC43390
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178392;
	bh=B4kH0VTFE209jH2/55eFDJiNMYCyMVQk6NSt8OcUoco=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QlV/Tl4Xrde6KxN88FH3+87IzUbFO3xAtk+2mecsMnSC83+ajmTdN8tR8QI4R2kVP
	 Vp5etX2MsHUlAVcgEeFKcJw2uPfIQqgBcwleicti3MNBYQLMQTgzu0uS5a9orDDb0b
	 9VM4zX96fNxGWMCXxwAE/gFl2OHiaH7GyFnmkoCtIUTNWugIl19rn09B4WExLAVkMi
	 7JXY2k0+QwiV3PqpB77AKJP3r4iqD7/4r5J/CwvSXESxkbLXAAmaTQISnoAwlidSEK
	 /ad6zUBHtpDSUiPq8ZVbQeM7GCbQuDsI0GmQPgWpq5AZbjgENcZkwlOIZKjdDCAuP8
	 B5vZmyYoGSPhQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: add and use helper to check if block group is used
Date: Thu, 25 Jan 2024 10:26:24 +0000
Message-Id: <e234e1ff663eb7ffb6509f9ef7933221f4139db8.1706177914.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>
References: <cover.1706177914.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add a helper function to determine if a block group is being used and make
use of it at btrfs_delete_unused_bgs(). This helper will also be used in
future code changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/block-group.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a9be9ac99222..9daef18bcbbc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1512,8 +1512,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c4a1f01cc1c2..962b11983901 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -257,6 +257,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
 	return (block_group->start + block_group->length);
 }
 
+static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
+{
+	lockdep_assert_held(&bg->lock);
+
+	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
+}
+
 static inline bool btrfs_is_block_group_data_only(
 					struct btrfs_block_group *block_group)
 {
-- 
2.40.1


