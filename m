Return-Path: <linux-btrfs+bounces-15389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8573AFE80B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED98E1C4748E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671A2D97BF;
	Wed,  9 Jul 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUL49Kq3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6302D8371
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061546; cv=none; b=H4+X7eIz6t1H2ig4mmLKZ+m6y7Bp68W7NaRFOeOJ5BJqtXSxXsZZMSn313UJBwuXPAL+iiwsSMUOcwc0B2Li0PGwuiKRmuqrCYk3Fq5qt6lJEBQs/VMjOfTZ5vqi//3NL1JXNY16OBQ1KTkU1M6t1q+CvA7CobA8ERTGvt57iNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061546; c=relaxed/simple;
	bh=TRmDWyGSvA+VE+jAoDyUZmv8czr4qNE6mqJewHfkzpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaG4s05k2zH5edNrDpwURcM9ILX9tnJPL1khC/0E/f8Iakcd1VunMgpkIZYjO8DV7OuAmTqnKjhy4lQRkUlPbTB8OmB0dKqYO1jv6ZANYho4BQOQSmevUe615S750XZ/LkAMETxqsUDTDCyQm5u6B80y30GNGlb/DerXWthd5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUL49Kq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02133C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061546;
	bh=TRmDWyGSvA+VE+jAoDyUZmv8czr4qNE6mqJewHfkzpE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rUL49Kq39mt722uxEKv9iAOkwLBNKGgdOg37DmmTISh+HvkrREdQhZVFJBJLlSqhR
	 qood0JTZXJu2q7qPnGXIkBn1vq0DR8pIt3lYZh51RqKU05EIoTFGPUZwNeKnUr1+Zb
	 BIDBYw3+9uilUcnaheBUSxU50ECK6rtculkS4yeUEzaq1IdzrytK40uAri3uR7gDqI
	 rOUdSOcfD7YanQbnKTmAyE9qDkxoXvxR7VNhJN04xGRo4UPzDYGq59Q6+umi1i62/0
	 UlNVC5HpO59vKQRr01doiu7IO7oRrYEtlEMGRER1lSzCDlQGcWMsdEo1ZRK85oeUjS
	 J/7AcJZrDasGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
Date: Wed,  9 Jul 2025 12:45:40 +0100
Message-ID: <77ee874af5d2ab36833a9a54fbc797ba0939c9b9.1752061083.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752061083.git.fdmanana@suse.com>
References: <cover.1752061083.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have the inode's io_tree already stored in a local variable, so use it
instead of grabbing it again in the call to btrfs_clear_extent_bit().

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index cb07274d4126..e11b1733e3ae 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1950,7 +1950,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * clear any delalloc bits within this page range since we have to
 	 * reserve data&meta space before lock_page() (see above comments).
 	 */
-	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
+	btrfs_clear_extent_bit(io_tree, page_start, end,
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-- 
2.47.2


