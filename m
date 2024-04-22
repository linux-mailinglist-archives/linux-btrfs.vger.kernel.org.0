Return-Path: <linux-btrfs+bounces-4486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF08ADAF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2916F1C20A70
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981113DBA4;
	Mon, 22 Apr 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvoDyIT+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2371C9EDB;
	Mon, 22 Apr 2024 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830366; cv=none; b=hT1VzO7uMoyzKsXDQhSoMIHb8SmgYNtB22CufB1WIf54CebCYHA32BRFTOmPnGbbs1OY/HXOZJRLczJw2qZkaLU1REqfDQUR/yPS4B7cKMllbi0uHQfk3A2xID8QXyPmu1Dx3eo7gnuT9BgVjvDtN2tIn6rkDhh30A2TibBMHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830366; c=relaxed/simple;
	bh=zdHRm/QHxbV08KzjFvgJAWkSD/HMWwEKKSRNQi7PPLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0Veag+0oONigPzEF3Q/pRPwWKFx7l3w305gYj+BEWKmYcBhU+XvVnr+uwhm3MHPcThO6KAdzJ8Ao4wXdVeDoed3wfvs6xmBh6NVNJuWykHRPmddQc+JQzYMqm/06wbdZOKqhXnuj+AomCEKiIWsWUInDw8PWYUuXLhdLaqf3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvoDyIT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319CAC113CC;
	Mon, 22 Apr 2024 23:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830366;
	bh=zdHRm/QHxbV08KzjFvgJAWkSD/HMWwEKKSRNQi7PPLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvoDyIT+CAtve6Uf9k3tYhph9t2yv730ydlkiVsOM6dMMlPCp/Dr1LhrwOUS3RWam
	 1tevNRAmKv1zNFqwIAocE3luMqkfsZ4U5THfL4zj+vMoaAhR64XwWKcDBTkdljF0m8
	 ebP7lNrjszL7FH+PhVJonuT2LYkR0tSohmiL4m+ZPxpfHp+LnQAbLZHZ2S6FvT5JPd
	 WKNZMhcRb18P0Blg/fDJcwXOG4xD2fHh4Rtv4e9RvdM10Q3Pz4oaMlOvg6ZbR0OlT9
	 FcTV6h/T+P2Vcdwheg3HtjgMoFcH44U3ZMbrSQ2mYZ2DxI1Iqi8i1vkEf2PwCEzSqT
	 nLZczibH8Ceuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/7] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:20:35 -0400
Message-ID: <20240422232040.1616527-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232040.1616527-1-sashal@kernel.org>
References: <20240422232040.1616527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 3c6f0c5ecc8910d4ffb0dfe85609ebc0c91c8f34 ]

Currently, this call site in btrfs_clear_delalloc_extent() only converts
the reservation. We are marking it not delalloc, so I don't think it
makes sense to keep the rsv around.  This is a path where we are not
sure to join a transaction, so it leads to incorrect free-ing during
umount.

Helps with the pass rate of generic/269 and generic/475.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e4a4074ef33da..7f675862ffb0e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1906,7 +1906,7 @@ static void btrfs_clear_bit_hook(void *private_data,
 		 */
 		if (*bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


