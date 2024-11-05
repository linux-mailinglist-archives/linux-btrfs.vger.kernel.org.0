Return-Path: <linux-btrfs+bounces-9335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA679BCC5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56EF1C2200A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B91D5176;
	Tue,  5 Nov 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrHUzJmv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B71420A8
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808533; cv=none; b=NPUhTrmjk1G7z4jt4z4tjj4GDUb4tNZ9fF18KT9HixxaX6eyHsb8RqeCTko/rW8cSXuzqMuCGjTabBaRkLIXYJQRffwKcEqT2Dn92R1CX9oSXgibYI+q6eYhNOrQ82GQvGmxaaVBq2e09uJGOnNEIyW/RaTSxH5n8jjkoRtZlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808533; c=relaxed/simple;
	bh=cnhTFk5JVWN9OtDQCc8p3PokO4lUUgigOwb7nUmtSIk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SPNfYwhT8HztdHwZYcff/SkqCzqKhqDu/8ymTVs1DZxb1D/lu0usUODXpcKhq5SDfNmEEDKddggv04dDdYKPD8lV1QD6t2hWfUhhUskExm3n2u2mxG6ohLtPkuKfPH0B0uOXfogLUl93bJi+OIBHhUFukb0nxu3mcIEMolARttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrHUzJmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456E5C4CED0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730808532;
	bh=cnhTFk5JVWN9OtDQCc8p3PokO4lUUgigOwb7nUmtSIk=;
	h=From:To:Subject:Date:From;
	b=FrHUzJmv32cb3awTtgS2uw4wkoKhKPGR1DaHQdqOccjgjTYIbESpv6yLR9vpdZf1d
	 UoFPBcoFSp2IXJThNx8xrXMo9SgRlJCri+5t7b9wEn+zYI4NcO0+LEFssUM0Su+rjf
	 RpkozlrVX8GjPLCbTmh5maXQD+aAbk/QC8a+dtnFYnUf7Bs8gUCPVAZmd+tdOwm6fn
	 JtfaTyEzy6UY8b8Qql3xh1ZSKRg99zENQf4VOaQKoK+BAKsaQ88l1M6QJD8YdDROd5
	 SEFq30J/aJfrHUQnMn/pe1Hf3ubzFDjux49F6CnVajG3DNlEzqL6+C//4vMEMX3fFr
	 znuc+3F75wzsg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove hole from struct btrfs_delayed_node
Date: Tue,  5 Nov 2024 12:08:49 +0000
Message-Id: <008db737b88fdf9993be37ff44edc89e31a3677a.1730808362.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

On x86_64 and a release kernel, there's a 4 bytes hole in the structure
after the ref count field:

  struct btrfs_delayed_node {
          u64                        inode_id;             /*     0     8 */
          u64                        bytes_reserved;       /*     8     8 */
          struct btrfs_root *        root;                 /*    16     8 */
          struct list_head           n_list;               /*    24    16 */
          struct list_head           p_list;               /*    40    16 */
          struct rb_root_cached      ins_root;             /*    56    16 */
          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
          struct rb_root_cached      del_root;             /*    72    16 */
          struct mutex               mutex;                /*    88    32 */
          struct btrfs_inode_item    inode_item;           /*   120   160 */
          /* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- */
          refcount_t                 refs;                 /*   280     4 */

          /* XXX 4 bytes hole, try to pack */

          u64                        index_cnt;            /*   288     8 */
          long unsigned int          flags;                /*   296     8 */
          int                        count;                /*   304     4 */
          u32                        curr_index_batch_size; /*   308     4 */
          u32                        index_item_leaves;    /*   312     4 */

          /* size: 320, cachelines: 5, members: 15 */
          /* sum members: 312, holes: 1, sum holes: 4 */
          /* padding: 4 */
  };

Move the 'count' field, which is 4 bytes long, to just below the ref count
field, so we eliminate the hole and reduce the structure size from 320
bytes down to 312 bytes:

  struct btrfs_delayed_node {
          u64                        inode_id;             /*     0     8 */
          u64                        bytes_reserved;       /*     8     8 */
          struct btrfs_root *        root;                 /*    16     8 */
          struct list_head           n_list;               /*    24    16 */
          struct list_head           p_list;               /*    40    16 */
          struct rb_root_cached      ins_root;             /*    56    16 */
          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
          struct rb_root_cached      del_root;             /*    72    16 */
          struct mutex               mutex;                /*    88    32 */
          struct btrfs_inode_item    inode_item;           /*   120   160 */
          /* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- */
          refcount_t                 refs;                 /*   280     4 */
          int                        count;                /*   284     4 */
          u64                        index_cnt;            /*   288     8 */
          long unsigned int          flags;                /*   296     8 */
          u32                        curr_index_batch_size; /*   304     4 */
          u32                        index_item_leaves;    /*   308     4 */

          /* size: 312, cachelines: 5, members: 15 */
          /* last cacheline: 56 bytes */
  };

This now allows to have 13 delayed nodes per 4K page instead of 12.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 7cfefdfe54ea..f4d9feac0d0e 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -64,9 +64,9 @@ struct btrfs_delayed_node {
 	struct mutex mutex;
 	struct btrfs_inode_item inode_item;
 	refcount_t refs;
+	int count;
 	u64 index_cnt;
 	unsigned long flags;
-	int count;
 	/*
 	 * The size of the next batch of dir index items to insert (if this
 	 * node is from a directory inode). Protected by @mutex.
-- 
2.45.2


