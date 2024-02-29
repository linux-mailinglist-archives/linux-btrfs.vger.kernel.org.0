Return-Path: <linux-btrfs+bounces-2927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020786CDDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 16:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24851C21832
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD2B134431;
	Thu, 29 Feb 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqJamQpd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A713440D;
	Thu, 29 Feb 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221802; cv=none; b=IRj9a/g+CnXV8a15KhNeyf7dUE2/XsRwTLyImJOC3LWP+Cr3smLS5QLBg46d9YSse4pO097qYaMssCn4STCZ2IHfzvrVFejCYlGUABil6F/qKjs1+pOSDv2hCXKk7RyKa/eUIXLw9dTlEicgAgZOfb0x4d4Cil95MisR/0/l0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221802; c=relaxed/simple;
	bh=RbFIn/rD8T4m8UwPhFAvxAa8fNz3weSaVcCt6bnPhkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqHjltH9aSpWKmdx3REHVYckkH9mJ91u1l9vOrgmgtsYfPVw5LOM0UxrpGMtKtNROoWExQk1Q1pnXDlZ4/acFy+ev0mD5Zyojl+2HgdI/cCcV/MdBZKgqegz8e/xNoN2PmH5JSM6oDQHKaI5SXiMFb43EvA0NdNtitfxWqysySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqJamQpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B74C433A6;
	Thu, 29 Feb 2024 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221802;
	bh=RbFIn/rD8T4m8UwPhFAvxAa8fNz3weSaVcCt6bnPhkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqJamQpd/dk360guw2YVssgWKtzvnMpSabHOa93iVzCqONh7M8qblyuKiydHoeuhg
	 rtS1sIu+BLy4Hrw8FWMwZsMNpD6cqrLGxaSXCc5fpo5VN5nAXW3LMcDRR6JIFAVE7c
	 b7mbOcz4qWirjb8FNzW3peewD0XWnGo6wuHlIC+J0uG1XCt7kGos3cQHFnaFp3dKH7
	 wtomaKuRqyk92SDfkQOtWzGgx7N4ckbmaDrO8cxOcgbibMTkMX6E7x3lxgpgLGcxAq
	 flHo7b9Oy1ae+BCrGvrcD0RhQFPl/WSiIlZ4yA5TzKiZO8fcm8HA8Z2JBTsnqvkYq3
	 FMUmBnUvHaWQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/21] btrfs: add and use helper to check if block group is used
Date: Thu, 29 Feb 2024 10:49:28 -0500
Message-ID: <20240229154946.2850012-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]

Add a helper function to determine if a block group is being used and make
use of it at btrfs_delete_unused_bgs(). This helper will also be used in
future code changes.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/block-group.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5a97db9888107..b152c1b1913fb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1524,8 +1524,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 2bdbcb834f954..089979981e4aa 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -255,6 +255,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
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
2.43.0


