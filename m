Return-Path: <linux-btrfs+bounces-2930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE986CE47
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D922861F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E362154457;
	Thu, 29 Feb 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3e2B6aV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A51547C0;
	Thu, 29 Feb 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221875; cv=none; b=NLSwRKCESgmngxtHdYXCKwxnc4AiPnCjKgx7v+wx/SETRxykTA1zmS179vd6ULfHU6kiz3MCiG30nZHd0cAAjQ/J08/ebuZrgKivGiuEsmHl9puoY32GkYb1hJ5ZpMCOXunUA/LfHMkjFo6mg8HqSyUi/6F8MNndRvNR9KtwGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221875; c=relaxed/simple;
	bh=W7EFPrddAiARLEIxEX/jN7SMYuIy9OT780TTtwsJlAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hc6tTDjsQTNIYBUU4r9/Fbnqk/EOznqPJqpoa7jOl4gA6XkIvAc3D687UNf5tjWvaOxxlQIU+js3e5300MG7FcSW1JbAVDkDecnSnCdOqpIDjFgS+ppFpWNQ0Rlsuv1XncnRJUIigNzxQMMz5gOxlx2X+aOCbpymkLJjIUZn4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3e2B6aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ACEC433F1;
	Thu, 29 Feb 2024 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221875;
	bh=W7EFPrddAiARLEIxEX/jN7SMYuIy9OT780TTtwsJlAg=;
	h=From:To:Cc:Subject:Date:From;
	b=c3e2B6aVmG4M15qM3q9olZ16c8xVfuNyJCKrGO/qpflYxRjyH8jZpV5UrTEy+hvhu
	 M9qcvIxhDoIMASd4lWsLtucNjapXdkGAjnbiMq1zI1KoocqkuIR2EFqXLxTZATxHU7
	 aRBYVUVvoxR8x4HiamsFfVJdtLsEEuHqhxlYyZDs9AlgT8uMEGNzGx2DcfdhsRhK03
	 +TnlWT9iH4EKg9Z0EzGzB596zcph9o/f86jbFmLipKJLc4IT9ClI+sQFlY1uK6uAuv
	 H3wYMCbQhXy8N5EKNc2XDuU2LwYgubsGhMPVTBJVIXtiXH1eQaFexd2Or/ybXO3mOm
	 hgNjlxNUOgjjw==
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
Subject: [PATCH AUTOSEL 5.10 1/7] btrfs: add and use helper to check if block group is used
Date: Thu, 29 Feb 2024 10:51:05 -0500
Message-ID: <20240229155112.2851155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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
index c4e3c1a5de059..9a7c7e0f7c233 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1393,8 +1393,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4c7614346f724..0d02b75f9e7e3 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -196,6 +196,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
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


