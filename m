Return-Path: <linux-btrfs+bounces-2926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CF86CD8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B074287532
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242614AD2F;
	Thu, 29 Feb 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX0lVRig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE615445B;
	Thu, 29 Feb 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221750; cv=none; b=qRVJyH/rGhF/KZQv+YTBACSHPRKFwGDmv8CaU2Q2gDNgtGRFXslLcNwLG7UWnq3qdLEHADqiOgkYwLuo5IqoFZKq5ncHtaYnYpF1hZIpsp8JYJmOdX1IQVwbVoSO8E7AxNNFI71FaDNbI6p9GiTq78rSg7NWTAbuCjuyJeCJ7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221750; c=relaxed/simple;
	bh=9EZmuMtgssQcts/TES+BrRQcuvnJiRvBbxyDza7TTaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kzs/wz3IB2Pj94wA5q56BuN6crfIU39GxdsVxEO6IPHw/qiwofyfL3/JGCeHvI+UpPyFxvzICw+9/qCfT9OzdnVoDufVcSH8W8+Y68XKemcnrvWug0qcF/ioORR51r1+8LGz2+1PnRkTq8E0PcRp5nnqIPcZ5kXfwpYjgqswikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX0lVRig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8E9C43390;
	Thu, 29 Feb 2024 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221749;
	bh=9EZmuMtgssQcts/TES+BrRQcuvnJiRvBbxyDza7TTaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sX0lVRig/nPUOE7xV8yHMcOQTkLoeQd2XzdRv9suHFsMh9+ZuI6aRSpIW7EMZkqXb
	 b4Kgtz3/QiewuyS/ID1Il5dpeNoGwcCHXEO0gqZo5aTHwww7Nt3pydQKmUWhevFRc6
	 YpHRumWNu2UGyEPLSbyGHTVAXmRoqlVsOUWzzTp3E4U5ARQtd4NQUyzOnUEUFDCHXl
	 6IXN1/vc1vfwXF7EPrSrHDfx48jBC4ivTsklKoy2Huz/vPgTkbzBV54vggvOFDOvx+
	 dWHF8gY9RCWSYZPQP4cu9p6zvMNj6Edrcd64IgRqJ+ucdBMFgv/QA2Upp6Ehogfstq
	 4ieyGqk/iN8Iw==
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
Subject: [PATCH AUTOSEL 6.7 09/26] btrfs: add and use helper to check if block group is used
Date: Thu, 29 Feb 2024 10:48:28 -0500
Message-ID: <20240229154851.2849367-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 6e5dc68ff661f..0dd979c4db037 100644
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


