Return-Path: <linux-btrfs+bounces-4482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E071C8ADAB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AB22849F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AA1A38E0;
	Mon, 22 Apr 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqasRFbi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF61A38C0;
	Mon, 22 Apr 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830321; cv=none; b=PM2650VejEoO1AnaK+LGaU8X1OWjBK7WLWlXRbqYkLFv3XQs110xtBGQMNHnpst129cco6r5acYpP+qaRYSijqRiN3tx4+y0uJ7oyWjUIHHyAiCDru/U+7/pTKhNxLV7ZneMuId0476xJSKK6BtOTuPz6hg2lPgDNrZTCdQu0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830321; c=relaxed/simple;
	bh=uDSRleTl8pNoCZ5WJRORmukFfr1AhtePQt+nhcKr2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLDdrWkoKbsqWxvcF5xkF72bKfyg5RUOQzSm762++62wXUAiKf//X4S/mB9WB40VhRNDRxaPrNK5oIn6+oPwmMVgb58XDz71IsKygFJvHqfm0m/w3TpCjJda0S3YQ+QBWo94FvKRt3sfFnK4riVC3VDDuom2zz/hckoivrmAnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqasRFbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F203C3277B;
	Mon, 22 Apr 2024 23:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830321;
	bh=uDSRleTl8pNoCZ5WJRORmukFfr1AhtePQt+nhcKr2uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqasRFbi7LCF8RWrPBTvqIT4unrTpkvPDD/v5sqJ6cbIhIKMbU0gN0cw1sQ++I1s2
	 gjr9YUP8DTnjeluedeQjRt6+zTWSNKFV4djRCbnKDiSYZQ0k33Wmq2Dk9N5MU7+w/N
	 5omKX+Bepwdlo0HF1QSWtxUQZ6Hgrut772tFa1fSwGZo1TO7KjgLqfV0BrhvFPGwy2
	 c1TRyjoYLCoeBW7PPDPfh9w/qCDOmBqPyNucxs3QcH2cSJ0ntpdq+HTAW1+eoFIwUi
	 RhS2mXsPIZpq4/9G5+fmUCknEyFvMtASV8ghhQjrfu7ED62PJpuCTWhSEDs2ZQ4p7p
	 cMmYDb0K86Pdg==
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
Subject: [PATCH AUTOSEL 5.10 3/9] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:19:44 -0400
Message-ID: <20240422231955.1613650-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231955.1613650-1-sashal@kernel.org>
References: <20240422231955.1613650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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
index 591caac2bf814..1f99d7dced17a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2070,7 +2070,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 */
 		if (*bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


