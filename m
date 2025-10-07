Return-Path: <linux-btrfs+bounces-17503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D38BC108B
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D52D3BEF22
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586A2D7D2A;
	Tue,  7 Oct 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0zzwcUH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301519E7E2
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833619; cv=none; b=ENteGFAa7onMdtjZhB/BVhbiimIZAUQMzNnX4T0S8wMUnltZhVZOuUd5KDMMF6ex1AcmPo5b2vU+q+jrsHiWNGzHgYSL0knBauDcQfnQZ7CVB3B/Br/rNakA/TbL/3NUaM1tr48SSa9zEYqK5taMWlZHa8dPHKH+Q2x9G0P0wo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833619; c=relaxed/simple;
	bh=bWtGKc5cWa7gUBr/LwWPfjqcwUOLPi3dF3B+5auwzLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Zp8lN6pgban1lpA1DEsmny5ACBOoYWZkoUvYRsbO5K5uCZbVEQ95amnRfQbXI3bk0fuIAelMitLmV/vSSxteiCkR1ExLnNXIXFM0bYBEotixD41/o/p2hbVSOnc8LvaqRYDWtHUKEY2wjI5KGtJjHtMzCPCOM6mGZ2O6ryM5C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0zzwcUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAF4C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759833618;
	bh=bWtGKc5cWa7gUBr/LwWPfjqcwUOLPi3dF3B+5auwzLk=;
	h=From:To:Subject:Date:From;
	b=h0zzwcUHzlibE4SBxQAynHFj8zJgJztSpRz/UPNOGVAoiMU9mQbzmY0gq+UeDBZ95
	 GwRzyYIg8xNJpsathtX4urz01DAexlN10s1MYxeG7a7g24VE1o/Nec3loo3ko0cCaZ
	 xTSPilaSC6dmNenXOf9fIFEf/zGFfc61aQAhbgwGeN7wHmoS7KatsX9oUMBcAmPZRr
	 EQa7MVgrc5iTYb4woa+fYRnyLd6SXak67BQyfyPtxHI9UFG0s6jjadu6Rdpikj7eEq
	 hNPDCJPnIBN3XDH3YDF1OWGcEAQMXjpPC8eb+nCjzqYXB0V4ymPGzzc/FOhcEMS0Io
	 7z68sS6+imEnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use end_pos variable where needed in btrfs_dirty_folio()
Date: Tue,  7 Oct 2025 11:40:14 +0100
Message-ID: <264523d69e13ece0fd80675a77511caaaaaca421.1759833561.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a couple places doing the computation "pos + write_bytes" when we
already have it in the local variable "end_pos". Change then to use the
variable instead and make source code smaller. Also make the variable
const since it's not supposed to change.

This also has a very slight reduction in the module size.

Before:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1915990	 161647	  15592	2093229	 1ff0ad	fs/btrfs/btrfs.ko

After:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1915974	 161647	  15592	2093213	 1ff09d	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7efd1f8a1912..dcbd038d1ad1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -75,7 +75,7 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 	u64 num_bytes;
 	u64 start_pos;
 	u64 end_of_last_block;
-	u64 end_pos = pos + write_bytes;
+	const u64 end_pos = pos + write_bytes;
 	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;
 
@@ -86,10 +86,9 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 		extra_bits |= EXTENT_NORESERVE;
 
 	start_pos = round_down(pos, fs_info->sectorsize);
-	num_bytes = round_up(write_bytes + pos - start_pos,
-			     fs_info->sectorsize);
+	num_bytes = round_up(end_pos - start_pos, fs_info->sectorsize);
 	ASSERT(num_bytes <= U32_MAX);
-	ASSERT(folio_pos(folio) <= pos && folio_end(folio) >= pos + write_bytes);
+	ASSERT(folio_pos(folio) <= pos && folio_end(folio) >= end_pos);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
-- 
2.47.2


