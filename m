Return-Path: <linux-btrfs+bounces-4484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F18ADAD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25731F21E87
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292B1C65E2;
	Mon, 22 Apr 2024 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6fiwMCc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4731C2320;
	Mon, 22 Apr 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830345; cv=none; b=LwkZpSjcY3vX4UYBPzlWrW/w0X56RR7SRs9Bnql2QCvBDDpYVfPfnYO1nd2J8wkZdWjA7m9wkErhBA58NDWXkcgg8/7ZoJh4zSYj0g0jrM/1Zsbjc852y2JtRfylxJ7070dFZOXJh0b1QPTi73v7eQ5QS6Y5R2nd7Nl001Vr42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830345; c=relaxed/simple;
	bh=K9nkMEPqW/wg52Akj52nPLb2Cj/Qr9B7hr9acvdaYcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfjv36J4k8iA5efLpxce+Y2LrQGu3hikcQbe0J2YyY9dAjMVH0pXcrysORaPfedisRu3kAWpaHZ3acVo+jJMDKftD9Erp4jtwHea0aMq3cEOrjYysyFV8dVDL2a7U8AL09yvvOMXWlJcIHF2Ajg7isrBo+m2z5fZ2fdgfjmiq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6fiwMCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF1CC4AF08;
	Mon, 22 Apr 2024 23:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830345;
	bh=K9nkMEPqW/wg52Akj52nPLb2Cj/Qr9B7hr9acvdaYcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6fiwMCcemme+hhDwzvKuWFa3/81wX/+1BLDww+U8P28Yhn3U14ToO3ceYarsqog0
	 M2zZBKKEE6qEb0lRDDmH5iXSsg1QGsklsEBwVvK2QIDvcYh76BdT3uUt0F34kh12KI
	 PkHErJK34MCz0t1wwnBAveX0xqjwwA9em+KaBQkGpGVX+zNFBF1zR39yqTj32QljXN
	 ySPyHcz4Q13vCAzQPiyiajZQfyIn2PSxExjVT+fWzzFXzbNdlWArmnZpIYyPIXEgp3
	 g0xQBosJfb+fsxKkyUDHME5qMg2B99Eatm1Imsqf831hdChcreZe68Q4X44NZO+mhN
	 O8zxwEh8BV1bg==
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
Subject: [PATCH AUTOSEL 5.4 3/9] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:20:08 -0400
Message-ID: <20240422232020.1615476-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index c89e85a7da7d4..2c86be3fc25cd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2051,7 +2051,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 */
 		if (*bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


