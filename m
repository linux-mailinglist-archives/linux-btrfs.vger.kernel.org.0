Return-Path: <linux-btrfs+bounces-4474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC848AD994
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07A7B259E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB6156677;
	Mon, 22 Apr 2024 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR/7MeXc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD399156225;
	Mon, 22 Apr 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830053; cv=none; b=UI2QbhtsgaZ26VaibCozXMbTVbr0fX5NXqznoayHZKylGQQ09iyOiXQqV68Vey0kZ8p19Tit/CxqR4QhHtuDZTJFQ7lLc/VOIXcSN3mo+uKrjpSe3ajzVe967fsYJ0IjrF0gbgyqRoD0tiWNHcqhzYiOsBATTdAE6MxooByroSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830053; c=relaxed/simple;
	bh=yMXLr+dehirhd+N9KoXMM3lAnWq8O/IYtoVKkK9ycCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcmLTiEZPbQOh041PNPbM9FOh9MjjlttCJMRFyyKHcMuixxYq/3BwnIDrHkESD4PPuaz43iOyQdAoLRWO3AGEqcxx6KUoOUbikNjbfsvIMtP6X0bvWBPMyBgn14NTCIBadldNWJps/tfGexuRDm8L9gcrjD+WxMIIsZacx4ZIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR/7MeXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59081C113CC;
	Mon, 22 Apr 2024 23:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830053;
	bh=yMXLr+dehirhd+N9KoXMM3lAnWq8O/IYtoVKkK9ycCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR/7MeXcYhOta0eusDQXXYNhmSVpt6G0yp34LxMYpOuwvnwdjBL6ZTJ6JxM02lvGK
	 l8OUs4lgQGs+NQJlBhrm+shDzGNBUv93pg6OwVfqX9Vjct7LrT4ZX1DoF2FHWwN2Co
	 5kUa3EoPkGbfvyMl0FA/bWuerIEFbeEp04W5Oa5BIjDXu3IC/ChkAKhP40o6nObmaq
	 h5sUuz2DhG/rWTdtbKLO35k1fuuIf7YWkjqZ/UCU1n/uQxqtPXWFl7GkG+t9jFGk82
	 jwQW46f/gA05HY23AxYfscbAtqw0TOIkXKM/4AQhByCmp8VcUVU78q6gMVYZy7egfq
	 xps06NPZzYlzQ==
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
Subject: [PATCH AUTOSEL 6.8 08/43] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:13:54 -0400
Message-ID: <20240422231521.1592991-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index 6e2715e3f3aa0..d202e68fb1508 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2523,7 +2523,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		 */
 		if (bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


