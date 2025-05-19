Return-Path: <linux-btrfs+bounces-14119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BFFABBC25
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21542189C91A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B482749EB;
	Mon, 19 May 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp9hI2xz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1626A08F
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653523; cv=none; b=hsdYF46QL8c/x3C0I6G9IjN3D0y4HBza0D9PpHuVJnDMDGfkgmK0AsTAbxYsEXsDahNcMdb99lwOp+mSDMC6DV03EpWotoTKr+d9f5pE+mRIa4GHN/JFXgjm0Wx8uRH0v4tRtoeTetn+8UZfGbZM/YFtYN0Fc5xggFUZA/lgCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653523; c=relaxed/simple;
	bh=b5FVawChubRn0U35mInM1grwAuAIbGd24tqG3uBq7Ks=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SA6MPb0JTMSLZfOd2ezaaLBuaJzvxB0CBABqvEkNpBZvzjML3GJy0Pw2zMbBqMGX6a2KIHlAI5ye3lYxHAankoJGtWis41d+Bu8+0ktMXLlYNNHvI0YgqFp9MI6eY22OA2wqvqHvMK2niNLwlA78VCYFWCPmHb9KZF3n+FE5i7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp9hI2xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27592C4CEE4
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747653522;
	bh=b5FVawChubRn0U35mInM1grwAuAIbGd24tqG3uBq7Ks=;
	h=From:To:Subject:Date:From;
	b=Kp9hI2xzO4nrkSWH3NZLJ5u1NzTKYvXWnKTP49oDW1Wn17UgAW8wywyGj075CAkov
	 TlQ18RbtCuz2MWM6t/xctMY785AqFL41681BHFP1PtdskY40jxH+7k8pLI1Yo3AuDO
	 fSD+7HFiuOYXdTE40tRHlzjFgkFh4Yqj1tYzlTXxrEtT0qVBE2vVKsAk+5iIPRPMQR
	 n10bsvFfuo5jMMW8vAmPzwrB9GemrJfwuVGO2b6p8Q3p9FZlF3apkLOgKHqByXTG8H
	 1x4pie8huQcfg69TKmPLFAmiP10SlXeRVcud5R1fOjMPY0F7WGtYd1ZL0KGT5yHgpI
	 6xBnNFws5ntCQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction abort at btrfs_insert_one_raid_extent()
Date: Mon, 19 May 2025 12:18:39 +0100
Message-Id: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a common error path where we abort the transaction, but like this
in case we get a transaction abort stack trace we don't know exactly which
previous function call failed. Instead abort the transaction after any
function call that returns an error, so that we can easily indentify which
function failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 1834011ccc49..cab0b291088c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -329,11 +329,14 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
 				item_size);
-	if (ret == -EEXIST)
+	if (ret == -EEXIST) {
 		ret = update_raid_extent_item(trans, &stripe_key, stripe_extent,
 					      item_size);
-	if (ret)
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	} else if (ret) {
 		btrfs_abort_transaction(trans, ret);
+	}
 
 	kfree(stripe_extent);
 
-- 
2.47.2


