Return-Path: <linux-btrfs+bounces-3349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4787E92D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412F2B22132
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37802381C8;
	Mon, 18 Mar 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVuRoxaY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64097381AD
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764100; cv=none; b=VSIxrr6SeZSNi60bzAzQL5UaopLobRwkidQ1oj0QHZD0D1y+aUhrZooTTeaE0IQ4cCYBGYe3mpbuV/Z+zDoIdlrjdWREsjqJqyaTNW8s0d0uLAehIXO/sZgx96TjvkYAhdenqYLfaeO7SjO4b7mbstvQX9Y7lnrVlTijxrJfXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764100; c=relaxed/simple;
	bh=8c8N/KTDaDcOwuW3ZEUwlOBPq8LmVmRZFJTVFUi2p3c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFGiRiQhMmif1F9vmttPwciKszCthxzz0Bywy3x/tez2H96iRJGunGHqCEFFz61JdbqeRakTqv1d6HO5IxUG2vdlnwenW/l5fXGsmj0sp3Xs15MeH/hDKCwDWI3egC35bQ2RgWGpvrK956s/0QjOrTi6PsT6i75WL42FB3rGj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVuRoxaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A3EC433F1
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764100;
	bh=8c8N/KTDaDcOwuW3ZEUwlOBPq8LmVmRZFJTVFUi2p3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XVuRoxaYf1jIUOGf+8Gh+TnBjegEMaLzQ8ABMyYNdSQ5UlSGfkoQR5s/me0bn8FKP
	 tgRgq/pkNJEDbEyCRcJBQqB7TG88kLfb7JHybsUbu3txM7ka57m47EpJ1EyvlXoEpJ
	 2Ey5B09H+rYa4e/fZfo7dmOdoRSDozkHNuzEBcweh5HsoM78CG32ZgYtf1QZfEqb28
	 BHCRY+4c22IIVnENSAob7Z2laYgkZKub9PbkTK7JQNkL7nAUr1LOfRvPWAdJVLqrZL
	 EBLllkZs/doSmTlIWfdBgwx/o9pHIFvMEG4WyHRVQ9sNyoFgWVAT8DEcKETFkOgA57
	 dY3V5+ByQDhHg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove pointless readahead callback wrapper
Date: Mon, 18 Mar 2024 12:14:55 +0000
Message-Id: <c3b23a240ee8ab06b7c92e461b0ecdb11a05cc6c.1710763611.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710763611.git.fdmanana@suse.com>
References: <cover.1710763611.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in having a static readahead callback in inode.c that
does nothing besides calling extent_readahead() from extent_io.c.
So just remove the callback at inode.c and rename extent_readahead()
to btrfs_readahead().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7441245b1ceb..47a299b0fa2d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2277,7 +2277,7 @@ int extent_writepages(struct address_space *mapping,
 	return ret;
 }
 
-void extent_readahead(struct readahead_control *rac)
+void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
 	struct page *pagepool[16];
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e3530d427e1f..eb123b0499e1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -241,7 +241,7 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
-void extent_readahead(struct readahead_control *rac);
+void btrfs_readahead(struct readahead_control *rac);
 int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len);
 int set_folio_extent_mapped(struct folio *folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 37701531eeb1..e447a4f1d926 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7919,11 +7919,6 @@ static int btrfs_writepages(struct address_space *mapping,
 	return extent_writepages(mapping, wbc);
 }
 
-static void btrfs_readahead(struct readahead_control *rac)
-{
-	extent_readahead(rac);
-}
-
 /*
  * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
-- 
2.43.0


