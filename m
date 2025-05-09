Return-Path: <linux-btrfs+bounces-13856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3097AB1B3F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0343188AE00
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774E2356C9;
	Fri,  9 May 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OouG7unw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA117228CB0
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810312; cv=none; b=Ta+M5e02X+tQg+eyZEXIB4QKYxHZ4fV1gRzaU1nDvgkKoaxgpFO3zYk8qVLDHGbqtakh89RGqK8wyeoRxlP/xA/A6pUqNF7s2ak5ZFR8edhIiK0Ai/XXWO7LTCsizRvlcxu8flf8UdAUGg3/SaslRvru2FgS+iaMen+NZGdRQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810312; c=relaxed/simple;
	bh=a0OJgyzGVWU3Lo/ap/We5svrTpBXkP4Kip+cu0uE67U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LiF3Wzf5WS0Q2OrH4Z2ay8d8ghoAjsVozseKKvSyL729+qn1Sfl7hM9b0DSnFPj5sWrS2cUli+BHaT47ElV/Q4Ul5ITD5cn5syUejHOGnLpfRNMSNSF7ypw+6Wb5UL6ps7nv9FAI78AXaxyZYwEkZMQw97kR73g38E2EAhlfYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OouG7unw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF4C4CEE9
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746810312;
	bh=a0OJgyzGVWU3Lo/ap/We5svrTpBXkP4Kip+cu0uE67U=;
	h=From:To:Subject:Date:From;
	b=OouG7unw59DmdQ5FzIFAmuZ7L2zKrlVi0tryogF+cJLw2mSf6rOdqZGryMPeDgdiP
	 IusOpdFfYCprjenjEvW7BjUhaFMD/6JFe+4BpjWmOdA+od5ymUnnpIMYPKDiR8o/Zg
	 +xadbTAAGbBnMsVwQ0H02h/fw7c5oD2ZMx2drVR3ZchB8tTaQVEZnOB76m9mMYHWoQ
	 ZLQNjn092/8uZzf4XrZAX2UQQCN0gkDJ6B6+5A2GMBQ5wQM6tTpHhX/oEOV9Wa8WCa
	 7csS5blasHU7UtbnMibBEihFDR0HCTyC7PEaMie10BXXutVgc2dUfe+nq+7zkeNc+o
	 gOmhtv69OKyOA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix invalid data space release when truncating block in NOCOW mode
Date: Fri,  9 May 2025 18:05:07 +0100
Message-Id: <4cddde52bf9d965d7735f204d1403855dd9b8f74.1746808787.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If when truncating a block we fail to reserve data space and then we
proceed anyway because we can do a NOCOW write, if we later get an error
when trying to get the folio from the inode's mapping, we end up releasing
data space that we haven't reserved, screwing up the bytes_may_use counter
from the data space_info, eventually resulting in an underflow when all
other reservations done by other tasks are released, if any, or right away
if there are no other reservations at the moment.

This is because when we get an error when trying to grab the block's folio
we call btrfs_delalloc_release_space(), which releases metadata (which we
have reserved) and data (which we haven't reserved).

Fix this by calling btrfs_delalloc_release_space() only if we did reserve
data space, that is, if we aren't falling back to NOCOW, meaning the local
variable @only_release_metadata has a false value, otherwise release only
metadata by calling btrfs_delalloc_release_metadata().

Fixes: 6d4572a9d71d ("btrfs: allow btrfs_truncate_block() to fallback to nocow for data space reservation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d518acb7b01d..8c1f7196636a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4932,8 +4932,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio)) {
-		btrfs_delalloc_release_space(inode, data_reserved, block_start,
-					     blocksize, true);
+		if (only_release_metadata)
+			btrfs_delalloc_release_metadata(inode, blocksize, true);
+		else
+			btrfs_delalloc_release_space(inode, data_reserved,
+						     block_start, blocksize, true);
 		btrfs_delalloc_release_extents(inode, blocksize);
 		ret = -ENOMEM;
 		goto out;
-- 
2.47.2


