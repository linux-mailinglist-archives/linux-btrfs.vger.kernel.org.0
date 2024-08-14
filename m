Return-Path: <linux-btrfs+bounces-7184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894029511F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 04:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A151282ECB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B8481B9;
	Wed, 14 Aug 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L++syocv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15ED3BBF4;
	Wed, 14 Aug 2024 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601700; cv=none; b=SF9PPaTDWvxpJ6ormRkWIAV9gSwUuF5nBdfdHXfILm0bCl0A7G6dClPWN/oJPFr4Tq8Ae4qTPaxgI3eQOW/NX+z/Rm6Md2p34kW4CtemuWlGjEn1aoUrDi1v/+ctaDOKiHnXhMuKbcP7OO6CIdLxmDPGJvtVvaj6mn2KvbaNyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601700; c=relaxed/simple;
	bh=xSn9F+pF1P8pVDRaYxocAu4vC5XHXrWB8lIEkY8Zd4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPIzuype4mxQ/0E1nw3nS2hZ9lZ0w6hhluhr2ZgafTkotMqGJLGjm58YZ9dh8ktlJFtwwFcdCXdIDnnJpzq+nYxrsYTM73B5PDiLltbx+MF8Ap5edHQXi0649EOPPVWgiWZ1vvzfS1rHFO4/M5r3fyySJLLhBehpKdmkY2LI+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L++syocv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A8C4AF0E;
	Wed, 14 Aug 2024 02:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601699;
	bh=xSn9F+pF1P8pVDRaYxocAu4vC5XHXrWB8lIEkY8Zd4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L++syocv2wKEA/jQe7sNyePZMRQb/zBxI8hAHH4Zet2yjAhIweKax3ZeM38dBuo7Y
	 WHboNdbbUoIvJ/fPoRYC+DampvM8sTb1mCJEn/LU68pLR+sOxbuiSjJjR1yCZyBCYa
	 Lv7h2KBC1dCrV88ANBN9r+FiCy9yrGpwa+XkP2ueGwIpmcOqjmBLb1bpRVaqdyBNAC
	 DfWaLvBgt6TT4XdiCi9TVfkQ30Xcd0XX1EGnld/wx7PgF4fKc+l1odIy2E6iX+PxNe
	 reza8dS/3UIDi3XtaANhuBaD6ZQDROCqIzAiX4S5QjTj9jckv3CDUiLibqLtQR4N/B
	 BQxw2X2AJK+gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 05/13] btrfs: factor out stripe length calculation into a helper
Date: Tue, 13 Aug 2024 22:14:36 -0400
Message-ID: <20240814021451.4129952-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 33eb1e5db351e2c0e652d878b66b8a6d4d013135 ]

Currently there are two locations which need to calculate the real
length of a stripe (which can be at the end of a chunk, and the chunk
size may not always be 64K aligned).

Factor them into a helper as we're going to have a third user soon.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d7caa3732f074..9712169593980 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1648,14 +1648,20 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	}
 }
 
+static u32 stripe_length(const struct scrub_stripe *stripe)
+{
+	ASSERT(stripe->bg);
+
+	return min(BTRFS_STRIPE_LEN,
+		   stripe->bg->start + stripe->bg->length - stripe->logical);
+}
+
 static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
-				      stripe->bg->length - stripe->logical) >>
-				  fs_info->sectorsize_bits;
+	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
@@ -1729,9 +1735,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
-	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
-				      stripe->bg->length - stripe->logical) >>
-				  fs_info->sectorsize_bits;
+	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
-- 
2.43.0


