Return-Path: <linux-btrfs+bounces-14742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED353ADD624
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D41896DBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C42F743D;
	Tue, 17 Jun 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwN5jqFY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C242F7435
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176805; cv=none; b=RsS8LONKO0w5bKlpva9UL40aqKIEKBEw0QSUT7uknFQBN5UwzEDMBJvyxbSK+t75RZOFf5U+kNN38OSY0UlUzZexqoI+cjnkE2eKZafoQIGeBUngk+Q0bAFOIOFUchMfZnYLcOgDTwSz26cTA3yZlk0yNlOL/4BDmvuvyaoHTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176805; c=relaxed/simple;
	bh=zvAbVAxKPdyMe4OPiDjPc2NUScIRdoPh2WKTC9q2miA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWshaSUPPfdkbH8vNDdXxJW2t2lF2uhVSzVOAsL1emXUNBuiz2yGTA5vtyX+0dFOXtM1y2Ppu436F3xiPftNMX2PAa+v+0vnQemzgxDb4P5f5OtCWSKx+LhWoJ4yR0uKUHiyYSDDDDUOs3JcyUTvN4AAtuvRPhNawo4GCsz8D9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwN5jqFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504B2C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176804;
	bh=zvAbVAxKPdyMe4OPiDjPc2NUScIRdoPh2WKTC9q2miA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iwN5jqFYRUrGVpaWuGwtc1GvUOrRtJs0qSs1W86tq4s2CBCfRK5ioY49gBGFC/yJX
	 bDqE4N5W6xb62mbWMZeLu/9BE0DSdJA/yN09FYNrrkXHcbkn7wc/DCzZ4+qkxSpYze
	 rsp5VzeHEHKfMIqWDZgXbEv4prvK9bfsRWrVX2+tRLsCfLX4o9zZkKRxkHf7CYcIoe
	 Kt0x+i2JArhlxIlDGgCL5aIn3E0TXgXAi3e2NPQFyGaahcMEhAGrW2f+mJdIa198uT
	 YIGWrx1xFGzDL3lH/SzN3wXKXq+yj+AVm/QkeUILvzZITxeLfbqSYcwlqR4IxH0p+1
	 Wh3ROXtj6B1VA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs: avoid double slot decrement at btrfs_convert_free_space_to_extents()
Date: Tue, 17 Jun 2025 17:13:08 +0100
Message-ID: <d8a361eb81dabb0d908d5a1d7ccf4bc5b2329e33.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to subtract 1 from path->slots[0] and then decrement the
slot, we can reduce the generated assembly code by decrementing the slot
and then use it.

Module size before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1846220	 162998	  16136	2025354	 1ee78a	fs/btrfs/btrfs.ko

Module size after:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1846204	 162998	  16136	2025338	 1ee77a	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index b85927232860..d5766e25f5dc 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -406,12 +406,12 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				data_size = free_space_bitmap_size(fs_info,
 								found_key.offset);
 
-				ptr = btrfs_item_ptr_offset(leaf, path->slots[0] - 1);
+				path->slots[0]--;
+				ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 				read_extent_buffer(leaf, bitmap_cursor, ptr,
 						   data_size);
 
 				nr++;
-				path->slots[0]--;
 			} else {
 				ASSERT(0);
 			}
-- 
2.47.2


