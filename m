Return-Path: <linux-btrfs+bounces-13871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF3AB30BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E319177D83
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E2255E39;
	Mon, 12 May 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQSTU44s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EA2561B9
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036050; cv=none; b=Jvs9kBma+JUSEMmT/R/SBl8QaQHKZEaGToxCC8hK9Lj8rji0MebCCz0NDlcbHV/1zVGD4gaDCwRptQsnqccU1pTdy4BJRx0JVh4XYxOA7QgIahgT73NVXrHte6Qo/D1utp1tIaO0wcLEwBrNRqz8WOUslNXjFU1ClhzhPptTdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036050; c=relaxed/simple;
	bh=TencTL14RtTZIH3xKI4cTNqCN4P6NvjkMCZGlAgpMbw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UISL5tRnJ8GW5O9+wbV5uZYKZQRCRqWBMU9hLA0yhEbsICsvJ72pv8gbxLoz6If+h8aX4i2S54XBzadMdvdn0Q/nYVfIWixdGg0+oJ9Qf09R77Aj+YwZd2+O5KJcH43FczkySSNmtSGzLHEoVDJW4re912pEmYLars0sztTyYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQSTU44s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439BEC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747036049;
	bh=TencTL14RtTZIH3xKI4cTNqCN4P6NvjkMCZGlAgpMbw=;
	h=From:To:Subject:Date:From;
	b=AQSTU44slynDSgDRDCBjC1iLJhAGWjdiIqVJbYEwIP2x68AopT2AN4fxqOrsepp/j
	 fhyMPDnoqE+N6U9Cmsf7pMMr0IKpo2JZo9ThOEa+w7UpMPnr/ijJUuQt5wp+YBFRo0
	 6AcYAAguKjQJ7J6fdhbZ98Q1RdheG9ZMLeURIHxHTk48PXuH6XvXB5IaZSv5/OwzCm
	 SQMCZqNp9yD2psyDXheKh9EwViPL1wiQUqaa3zX/EnzvvyLsgEuu6b/SBzBYT3ZrMl
	 ckAQ4Ud4j6x1xSpKnlL0GZGz3zjSbN1poTu7aKCc7hjjBYlC//Eo1IluMNnkTDWTQ+
	 AWGFPOVDII61A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: return real error from __filemap_get_folio() calls
Date: Mon, 12 May 2025 08:47:26 +0100
Message-Id: <bd0068a988e80be345b7a513df5448ee9da4a0d7.1747035899.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a few places that always assume a -ENOMEM error happened in case a
call to __filemap_get_folio() returns an error, which is just too much of
an assumption and even if it would be the case at some point in time, it's
not future proof and there's nothing in the documentation that guarantees
that only ERR_PTR(-ENOMEM) can be returned with the flags we are passing
to it.

So use the exact error returned by __filemap_get_folio() instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 2 +-
 fs/btrfs/inode.c            | 2 +-
 fs/btrfs/reflink.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 18496ebdee9d..4b34ea1f01c2 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -457,7 +457,7 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 					    mask);
 		if (IS_ERR(folio)) {
 			io_ctl_drop_pages(io_ctl);
-			return -ENOMEM;
+			return PTR_ERR(folio);
 		}
 
 		ret = set_folio_extent_mapped(folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8c1f7196636a..0420be88063a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4938,7 +4938,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 			btrfs_delalloc_release_space(inode, data_reserved,
 						     block_start, blocksize, true);
 		btrfs_delalloc_release_extents(inode, blocksize);
-		ret = -ENOMEM;
+		ret = PTR_ERR(folio);
 		goto out;
 	}
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 42c268dba11d..62161beca559 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -87,7 +87,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 					btrfs_alloc_write_mask(mapping));
 	if (IS_ERR(folio)) {
-		ret = -ENOMEM;
+		ret = PTR_ERR(folio);
 		goto out_unlock;
 	}
 
-- 
2.47.2


