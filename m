Return-Path: <linux-btrfs+bounces-4476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCEC8ADA15
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE728535D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6415F419;
	Mon, 22 Apr 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+pL1lsS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75615F336;
	Mon, 22 Apr 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830180; cv=none; b=sG305wS7/XO8pEVpu413Myg2QV0vJrHJpVgDzvRwvfzu+luIv1fJThD/pmUr8qzTfyUJitZG6oyuTQ4Zb38cBHOzDZJSdlvJJPMx2Hl92hcGu622fQ7WcBc3J2hNj8kTBsrPYqfjOVZnjNEMb/fG3fADPh04wTrQ4pe7SpQJwDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830180; c=relaxed/simple;
	bh=ILZg4GcnOja1C4PyffOywsp9JOVht9Gw6vLOQ8tPcNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3+gSG4qvK/5P/4VwwoRphUS2PqS9Cv2J1XB/ycH6KU7dprF/qhDPpch6KNfmlcBrSJ4NvZGoApszkQmJhwMJRgt5oZ5bJZWo/0UXXkpgGJxDlySwYBMmcJe4g2c2vVoyU8P+xJawzN41Al3J7HIsjX3RIpJcPmYHM8XKJCcmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+pL1lsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B19C3277B;
	Mon, 22 Apr 2024 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830179;
	bh=ILZg4GcnOja1C4PyffOywsp9JOVht9Gw6vLOQ8tPcNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+pL1lsSAB4QIJDZBBK3S1qzsQ7DHo5MzjFpXRmK7K9DXf9ckCMXGmDU+ljVeel9p
	 mr8EVOHI/Bnb2kUgPmEoWSz20pB8MTEE/mpZziG8e+n5zgN6WeHy5JyH09UwjxkagP
	 Ly2K12ivqplzlznodvApWSPRqiU9tFFCoLuVQVRr2Q8hq0QwWEGiOzvyRAzGVoA1Yx
	 pEmU6EGT3k1xRIYki/0NmRqUnjBuLPhQuyITt4j1rv8mv3MKtSDvLlDErgAGqPrqzu
	 7ebYdmNIgM64wswKMCFxJXJDd5DNLEA52zTBl8LOgPIRFkgRTQ8NEk7xv/GTeBy7TY
	 WJft1FYIazD7A==
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
Subject: [PATCH AUTOSEL 6.6 06/29] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:16:47 -0400
Message-ID: <20240422231730.1601976-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index e57d18825a56e..cb66a890c1084 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2511,7 +2511,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		 */
 		if (bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


