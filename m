Return-Path: <linux-btrfs+bounces-15402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E93AFF2DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 22:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710F43A7001
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228823A564;
	Wed,  9 Jul 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pibPooJZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A951242D73
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092437; cv=none; b=l9LSDtUqz4dyN0EY13oIP3alDI8fcUUL7VR47t8Kq1k+kzr19z4i2NWczllZg7WJ4aGikAItHNBf/4ebyxjDhZe7AvUA7Lx6yFQmY/UJcssZOUx2IXhW4ecHo9K5ss6iAmMGFaNtj4m6BPgl01pUg7sD2UZtrVVBccK04k8LJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092437; c=relaxed/simple;
	bh=lX4HyI1O2kmwUTcLo9JpN2XoyZ1248aDxnuxcFoOPhg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf9eP4e6E/zQgnG7x/vUv8EDVwMX4EaRurM6B7tHWovXM5MXAOj179SWxGvEmPlniff8ATBKToYyzAO1E3Y1ZwvZzQtD87I81sIu9bJS1UVWD+g60Al9w5Qgbx7OYy6bJ1ZR1ErDEVj3UeJes3lawaA9Ct/E2G9I9rY+uIa0Kbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pibPooJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC38C4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092437;
	bh=lX4HyI1O2kmwUTcLo9JpN2XoyZ1248aDxnuxcFoOPhg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pibPooJZW0SqzaebBEhZpHGBE8Odiosg91gR4SfFM5UOppLqP03we8dZVLRQ4GfCC
	 mwe5gGbgBB9fr1tVNWjmpRHDVwSXMHjH/jxEBR9DDkQHDprCBXHgQqbpYVTJ4GF8td
	 eF/D+e6kUzrnJUCPQZEWhrD3996fGk6KeHQpYG93F6PTEhew6GHzJOhsQjekiTzfjg
	 YbyJ+kbmJtNZ+aZbU212SPeJDvwjmvSd5q8xQXDDrrrzDJBeXTMiAX2n3UBp9wnC9m
	 Hrg8LTKiGQCwTq+CHeqkr7PuYzWCFACvUY42qWoCrY4pci2SA5C1bIVkPs16BH7/+E
	 aewcVUl6og3Hw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: assert we can NOCOW the range in btrfs_truncate_block()
Date: Wed,  9 Jul 2025 21:20:29 +0100
Message-ID: <f93281a4124a9afc4f99479633fb9af8aa445a26.1752092303.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752092303.git.fdmanana@suse.com>
References: <cover.1752092303.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We call btrfs_check_nocow_lock() to see if we can NOCOW a block sized
range but we don't check later if we can NOCOW the whole range.
It's unexpected to be able to NOCOW a range smaller than blocksize, so
add an assertion to check the NOCOW range matches the blocksize.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d060a64f8808..6aa1e66448fa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4847,7 +4847,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 	pgoff_t index = (offset >> PAGE_SHIFT);
 	struct folio *folio;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
-	size_t write_bytes = blocksize;
 	int ret = 0;
 	const bool in_head_block = is_inside_block(offset, round_down(start, blocksize),
 						   blocksize);
@@ -4899,8 +4898,12 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
 					  blocksize, false);
 	if (ret < 0) {
+		size_t write_bytes = blocksize;
+
 		if (btrfs_check_nocow_lock(inode, block_start, &write_bytes, false) > 0) {
-			/* For nocow case, no need to reserve data space */
+			/* For nocow case, no need to reserve data space. */
+			ASSERT(write_bytes == blocksize, "write_bytes=%zu blocksize=%u",
+			       write_bytes, blocksize);
 			only_release_metadata = true;
 		} else {
 			goto out;
-- 
2.47.2


