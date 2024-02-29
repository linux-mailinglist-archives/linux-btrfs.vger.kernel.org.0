Return-Path: <linux-btrfs+bounces-2928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84B86CE19
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF62832E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887D14EA35;
	Thu, 29 Feb 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1zntycN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17D14AD09;
	Thu, 29 Feb 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221839; cv=none; b=qJ1HNWPvkxnf+vjhrJfAuYSQCmJhDvzFCvGFuarwz7r9qFSFs2HVgrDArkAXamyioPN1gyVlh9EEpwf4XIkuhqZAi2lGpGd63cFBRNx2Q63mE42PleUWrOYJlmYI7YS5ZtyglxXoAI5oyUuTfAqYmMm7+6WMcUthxLy0tjGeGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221839; c=relaxed/simple;
	bh=MKzZHudUtkuU/YH2Fp+tPU3wPDONFFu+ixTas/V6RQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoVCnvrR31/NgvHRJyubCOkE3GWdZgfTuBWvlskkZKqCH/tCKE/gNAFSnHWmwc3g6dZWV8PZIYCF/v9PbbQmOQ/avHduEg3adKbfDKzvn3x1tvM61bQ+l7hwLG29VYGFDTLqsHucupxFDfBEiqZifSJ7vo38B/Dnpk5tI8iVD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1zntycN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DDEC43394;
	Thu, 29 Feb 2024 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221839;
	bh=MKzZHudUtkuU/YH2Fp+tPU3wPDONFFu+ixTas/V6RQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1zntycN6/YnAl/atsU6W8WhHJ1vQuqh1t7+eSHDhw9QdtXEDZTguCtVT6/payywz
	 v/X/5keZDY7ZeK9Moh41+a18mxkfbIseCOQVsY9SSE6a6jEFYNE4BNbEcFQB9l5YmD
	 esiVqgjOWapQOFJaBjv2ykQ1Zn3o6ix8y3XwL3OJ/I/3LRUbsvgG2zcjnAa4DD6TFj
	 smYFDsIKvVOn9Lkl7kzv5O+53lfUnbVGTpaQp4PMzZMj3zjWpajNVhGf2FpgpjJq4R
	 bqmu7ECSYid/XfUw4CXbj8s4dVe2LoJLU0wtvKD1tKUz0UE8bH4dO4Eniwqi8xd/wc
	 Wk6fB3VPkapeA==
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
Subject: [PATCH AUTOSEL 6.1 04/12] btrfs: add and use helper to check if block group is used
Date: Thu, 29 Feb 2024 10:50:21 -0500
Message-ID: <20240229155032.2850566-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155032.2850566-1-sashal@kernel.org>
References: <20240229155032.2850566-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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
index 08017b180a10d..efc6f03773eb3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1375,8 +1375,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 47a2dcbfee255..bace40a006379 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -241,6 +241,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
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


