Return-Path: <linux-btrfs+bounces-4478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095508ADA65
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C101F20F52
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE317965E;
	Mon, 22 Apr 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1eDBWbF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B452178CDF;
	Mon, 22 Apr 2024 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830252; cv=none; b=Mw+nRKCNC2zXWFRT/UOC4m4x0++8JynHBCiXqHeUa2NB0U2/5RT7LVkCHz6EcHhm48ulfLslTf/3PrWLYyIJZq2OQVhryR8fLvF103j+IkxBS2AReOLFEGJrnTubnze23PPKlICwZZbV3DiTvGcF2CWvIEEdyKHW1PXS0WK11QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830252; c=relaxed/simple;
	bh=L02ZFn1dQe1bYJCVW7oXZiTJl8/iDDwXXt/2kdroNQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPLIV52VqsFyVSBygcJYZPEyR/2J7ulPRCqHIkU90JkkZiMqRmirWGQ3q9MoKo+OpVBPe8EYoT+xsAvp8xUFNmuQ00X0af9Ge2nY1Z10PyM+B7J6aSTZOoRpnHgw2ySmeGT1HSF9+QILKdlgrA/WYETARTaOMeLmRMSpwY0Hm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1eDBWbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F21C32782;
	Mon, 22 Apr 2024 23:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830252;
	bh=L02ZFn1dQe1bYJCVW7oXZiTJl8/iDDwXXt/2kdroNQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1eDBWbFi1pOafGMKpnckuzv0uLpBxrRwPMDwkCAfUD1gz1iofR+RQTze8XDIjsU0
	 LYEq7RykCw5ac+lZ9pQxFinGPqycP9x1CQVATNkSM2ym9LAQrClcam7nhA56ZtUIVf
	 CKzo26ZYZuHlk3teTluUIQ9WRCiFaVnchlqT15JHHyZ424W9ErHEF+hE/mpSY1bCxv
	 BBcBiah3I+2T/OldJihqfm11Fi644q4PlxoMAbZh2F+f5bhpw2W7flcTvVeIsEZsQd
	 kLGYruiBteqnJtzMoCttd6zcJlkhslmXOhlYY/muqVCKXPnsyobKK8xzQekarKfSUa
	 t6fWKr2Q2081A==
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
Subject: [PATCH AUTOSEL 6.1 04/19] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:18:18 -0400
Message-ID: <20240422231845.1607921-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index f7f4bcc094642..10ded9c2be03b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2472,7 +2472,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 */
 		if (bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


