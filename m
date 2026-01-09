Return-Path: <linux-btrfs+bounces-20331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C43D09D69
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 13:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 368773034FEB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A535A956;
	Fri,  9 Jan 2026 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxSu9Mqn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898A35A952
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961798; cv=none; b=FnLRSW3BWLIb4fpHeu6PbLcyg8NcyS9MOYHSCTadpU1rvPgQaPCdGLZTg2o9KGgSJtdyCTIxVNM9BFM6t1nxkgC9CJo3M9n0My2nMJGGNtPzUm2Zj+kjcRrwK38seNiNBDDvHuyGzJuiK5ClKdBtXAlyMJwzsk6KEu//wKPZkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961798; c=relaxed/simple;
	bh=266T4rcithEfwORUki3VWNVaf21wn7iONgBUXNkq4tI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDJo/Bw663uRXKggbRAuJzuV85rLm4+ZZpxAlS+H6Dsely03s0FyO8Zg48dwwxdM/B0B1lJdeD0Z3yPkcQV+XoClWtathvKi6rkNQiKVqs7PgZ4Aeh1wXeUcBLiQfZjtpWKU7Re0gQGo+RPz/mEtAA7m0smZdUQ0QJklGf9DHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxSu9Mqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86586C19421
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767961798;
	bh=266T4rcithEfwORUki3VWNVaf21wn7iONgBUXNkq4tI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GxSu9MqnPC+d0Mi0/2XFnYjKGhCXOUfkW1u7XyrAxcUdldTL6nlVyVifwtOGNvg7a
	 kqmtdLPIevpGt8BLuBPhwbDW2DL+KGVHIpChqwbZKlYdmi1QyQe1ZS9V9Zb5xvFvlJ
	 hki5t4l89mdVdvqKcexr3z9HcoEGxY4bT1Tu5MCOq/Sgjp3LC7RYAqM3Os8DdSNDJy
	 Qm2Pw8GkXb8/Va0YLhjGD51bKCPze4VYweh26WuDws1ZJ2L4smDZcNVLhmWtfwmxhX
	 9pvj6NMHX/5wT74RLzv1p3szPHgMP7EWYlkgMuPZW6GyeAE/eVVC9a3QbRj0q4YNes
	 pdJ2WummgxfNw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: update comment for delalloc flush and oe wait in btrfs_clone_files()
Date: Fri,  9 Jan 2026 12:29:51 +0000
Message-ID: <12c71c470eb0c53d0431ce7ddb1bfd58443fd872.1767960735.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1767960735.git.fdmanana@suse.com>
References: <cover.1767960735.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Make the comment more detailed about why we need to flush delalloc and
wait for ordered extent completion before attempting to invalidate the
page cache.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ab4ce56d69ee..314cb95ba846 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -754,8 +754,13 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 
 	/*
 	 * We may have copied an inline extent into a page of the destination
-	 * range, so wait for writeback to complete before invalidating pages
-	 * from the page cache. This is a rare case.
+	 * range. So flush delalloc and wait for ordered extent completion.
+	 * This is to ensure the invalidation below does not fail, as if for
+	 * example it finds a dirty folio, our folio release callback
+	 * (btrfs_release_folio()) returns false, which makes the invalidation
+	 * return an -EBUSY error. We can't ignore such failures since they
+	 * could come from some range other than the copied inline extent's
+	 * destination range and we have no way to know that.
 	 */
 	ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
 	if (ret < 0)
-- 
2.47.2


