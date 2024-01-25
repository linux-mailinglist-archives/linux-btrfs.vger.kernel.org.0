Return-Path: <linux-btrfs+bounces-1785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB383BEB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9759128BD6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7732228E3E;
	Thu, 25 Jan 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX9Lgq4v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7220DF7
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178397; cv=none; b=eOlGcxeqWOGjTP1bsReGBTdvvlmD4bawNN5xgL+zMn75fsQwHF8dDXFoydSVCO+Eik8fXyncA2M1PQXe0DoJzNJSmyVxpCJXNw6+LSFCo99PWMcjeUqnGTrkZU+RG5+pMGot0GhNdNv8kabHBehSGMonM0SbwE/3mzcoco7ftDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178397; c=relaxed/simple;
	bh=XdwHqc2RLS/YRE0/MNV3LPnapHyySuYrTZWc7SP7kvQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+TxX5S5Fl7JFCya6WPxZCLXK59EMhutXcu8N7+Bw4mDfK3F5yTo9GnjRKvj3zjbvvl9Sc9SpWfYy9iFmFjTedgB5RPpKG3pTSRuqK0bC4GqKuXpbuvp0RuPPf2RG5OR605nHQAWMAsSZyv6yAa9v+EiK9I7uonSSBhCpCeaSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX9Lgq4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C73C43390
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178396;
	bh=XdwHqc2RLS/YRE0/MNV3LPnapHyySuYrTZWc7SP7kvQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QX9Lgq4vj6EmnR0YmxnuNt26qdmrwi7/n9Bu70wSXwMWgFnV7v5lsaPW6gAn/oUB3
	 raZ46TpLftVmJ5FtsM6H0yv9xvxfBhHVw4Evdye/LtA9z6WD7vQmxOcSbRPLtPHjD5
	 i7mi4HbTzwMiwbSLCdWwuCaD57DhU53fr/dFFm97J4/R/CFzlasIfqU28tgWdAmcVn
	 ++n3Jr2/1wmt9p9BezO63zkgopedA+QDhgphmy/JEd+4y+xpV576BLARRZGdNZchZj
	 JEB319xIcUfUMat8Rx/3gCDsHzWh04dGq8J1OEaOy62vC5VKLcHszTgMROEnPqlH1S
	 6W+OPzzOUQiIw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: add comment about list_is_singular() use at btrfs_delete_unused_bgs()
Date: Thu, 25 Jan 2024 10:26:28 +0000
Message-Id: <fdc5a0a2cf0240c02c56521332a48409be65b326.1706177914.git.fdmanana@suse.com>
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

At btrfs_delete_unused_bgs(), the use of the list_is_singular() check on
a block group may not be immediately obvious. It is there to prevent
losing raid profile information for a block group type (data, metadata or
system), as that information is removed from
fs_info->avail_[data|metadata|system]_alloc_bits when the last block group
of a given type is deleted. So deleting the block group would later result
in creating block groups of that type with a single profile (because
fs_info->avail_*_alloc_bits would have a value of 0).

This check was added in commit aefbe9a633b5 ("btrfs: Fix lost-data-profile
caused by auto removing bg").

So add a comment mentioning the need for the check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 378d9103a207..2dc39e8db995 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,6 +1522,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			 * outstanding allocations in this block group.  We do
 			 * the ro check in case balance is currently acting on
 			 * this block group.
+			 *
+			 * Also bail out if this is the only block group for its
+			 * type, because otherwise we would lose profile
+			 * information from fs_info->avail_*_alloc_bits and the
+			 * next block group of this type would be created with a
+			 * "single" profile (even if we're in a raid fs) because
+			 * fs_info->avail_*_alloc_bits would be 0.
 			 */
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
-- 
2.40.1


