Return-Path: <linux-btrfs+bounces-4330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AEB8A8195
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D191BB23AF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544813D605;
	Wed, 17 Apr 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAbadJyd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88013D2A7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351830; cv=none; b=BITICYa9LQIZwk6Qyc21FI6+Ag2i2/45KR5Z2jPn1/Onx4RglKn0Mk7U6wOZWYye6uM3cVMo9Y2r27Eya/Bcqdd7rSlg3x/Jq/UTQpX2r8lAVEBWN1lsQev4zHBuOEPzY6AZ74DVuC3qiJaqOZYfwtRJ0qLQ8O7cJEJ2+9u8jSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351830; c=relaxed/simple;
	bh=JqZ4OjqU7g7yKQOq+QVsLg3cq3E9F9Ko2piwpu/wL+E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXgcx74+onDNmfxxQRoUk1ow+/FvlaTsulYkwrK5H65bQZxvzLiqhP9C+C8e6n9m/+GVJpqfM4tqFsUhWetf6UJmS7QI5T2KLJwRE8CrVFOa89b3vVNM3/PKTqma1iUgLVD461er1QE0a+MTJigq/8kHm7064uCHqr0fDxbF300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAbadJyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B96C32783
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351829;
	bh=JqZ4OjqU7g7yKQOq+QVsLg3cq3E9F9Ko2piwpu/wL+E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nAbadJydzEJmSqng5QJtwFkwOWM+2yx2ARD8/iQ9rzoTgrASkLX3AKZowWtOyPZWo
	 G9rMTSNZvNFXtLl9QFpsUc7L7z48NJNrN5AQ8L72DHMEZJ2eCZKUIVeG+L13EDUxOZ
	 jpgH5I5RKvc8jGAw/HHEKXDL5/O8N07Al0aEXKSepsV5glVaIANnvlBTqnclwGOoAt
	 oQRZtVhs5LutfEjFiQyvA5pse6nAyJIELLqQsrncVCLacvV/l0sKOVKOyWdrgWWnus
	 E6IpUyDGk8AkjfHu7VfQlfclUf9opQRE08C0YWSxZXPy2iVAq5k/Wi/crHIXtRsSMA
	 lZPIQKRFdYcpw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: use btrfs_get_fs_generation() at try_release_extent_mapping()
Date: Wed, 17 Apr 2024 12:03:32 +0100
Message-Id: <afc9fac7a3b01d7538c43efee19ae3924addd8ad.1713302470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713302470.git.fdmanana@suse.com>
References: <cover.1713302470.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Nowadays we have the btrfs_get_fs_generation() to get the current
generation of the filesystem, so there's no need anymore to lock the
transaction spinlock to read it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6438c3e74756..f689c53553e3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2406,8 +2406,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	    page->mapping->host->i_size > SZ_16M) {
 		u64 len;
 		while (start <= end) {
-			struct btrfs_fs_info *fs_info;
-			u64 cur_gen;
+			const u64 cur_gen = btrfs_get_fs_generation(inode->root->fs_info);
 
 			len = end - start + 1;
 			write_lock(&extent_tree->lock);
@@ -2442,10 +2441,6 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 * Otherwise don't remove it, we could be racing with an
 			 * ongoing fast fsync that could miss the new extent.
 			 */
-			fs_info = inode->root->fs_info;
-			spin_lock(&fs_info->trans_lock);
-			cur_gen = fs_info->generation;
-			spin_unlock(&fs_info->trans_lock);
 			if (em->generation >= cur_gen)
 				goto next;
 remove_em:
-- 
2.43.0


