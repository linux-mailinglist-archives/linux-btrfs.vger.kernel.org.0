Return-Path: <linux-btrfs+bounces-6809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E493E354
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D6A1C21717
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC081AC444;
	Sun, 28 Jul 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usU40omv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C41AC42D;
	Sun, 28 Jul 2024 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128197; cv=none; b=qaMIC5Cdexea4B4QFKMnWPFfPp8U5LYIWg8tna3d3IrogVVBGeXPRBuyaF3r4KyJ3+7cyKPKsnq2R4GVWicJZQJvPjqjqbhScSf35s2jz78ha8012dPrnlqh2ZB97FGC5a0iFgd6r0C4P7xqugnJpRVH71Wlk3LnCjj8h3tLXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128197; c=relaxed/simple;
	bh=Rt7Lo8gELzsx4ODHUfrq/0rWxh2luWJqZTwi6ES3H3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCNe0pehk9ZoPpma0E/52m/slJsHZlwqQTxBAxUNfuQxlC+7uJ+rkX22n2ClUF4nzP3mZwkxce05kf2o+RtyHU3xO/vHVdB3jyPoWR106tD/SfcK8FAv6Zw7lDTRtoy9yJkz9EXqwf5geuykjQHx1E2Y0B4KoN8Et/YBa2M4/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usU40omv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367B8C32781;
	Sun, 28 Jul 2024 00:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128197;
	bh=Rt7Lo8gELzsx4ODHUfrq/0rWxh2luWJqZTwi6ES3H3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usU40omvO+11qz9oV5JvXH/vCnvyt0B2yobcGBIN2EbtRqtckrd1tm7ozMV3lo5dW
	 1uSXTcV2Dp4WB1UnL/FYia0bDvvTRCQuQsTp6nsB1WBNpPXmPclFDpbm899pU5iqhB
	 llNcS+qJfS0ZdcIzSeAJm/lJ+pfg/mASUJxRs6I869dJi2Vv/kyEfUSSjcoAW5weNk
	 8MokGZW5VoteHL7ylpl69mLpdGEK69w758fBjZbD3KW0TO2ObeokXq+JtSNT8PoG3q
	 YLtzoK3POEguDd6XvI5+0yA6iewrVdsRleH7brJtI32+yUR3XJr3+6oq4qhAPl+H/M
	 bLTr59G4avSHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/6] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:56:19 -0400
Message-ID: <20240728005622.1736526-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005622.1736526-1-sashal@kernel.org>
References: <20240728005622.1736526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 320d8dc612660da84c3b70a28658bb38069e5a9a ]

If we failed to link a free space entry because there's already a
conflicting entry for the same offset, we free the free space entry but
we don't free the associated bitmap that we had just allocated before.
Fix that by freeing the bitmap before freeing the entry.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0cb93f73acb2d..af89fce57ff75 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -788,6 +788,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0


