Return-Path: <linux-btrfs+bounces-4480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475618ADA94
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773E81C217F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754F1836DA;
	Mon, 22 Apr 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYjwp0Z2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7D181D1F;
	Mon, 22 Apr 2024 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830295; cv=none; b=Qmv54HQ6aH80HPu9I2fuG6w9GWAjQFXpbvE8Hol4b1KwzXB2kur4pxY+1lCSWR/tCagpAZbC+DQIOQLs4IS0jJluqLeZW2e1V1RdUYoFwjH6JR8apv9P+IpczJ13v17Mx5DxMRpk/xgAN6NLSuLYNV9po+a7OyoEDAYVk5C6+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830295; c=relaxed/simple;
	bh=tVX8CPlW+oWCXMKKFJChG2+aTFGC0tJ2cjuU8dwsx0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rcc0yyq2eUoUR1taTjVx+RKQ4xPQoLSScixPK/LgZtX5pZPO4IF9q2avElLxw+vtx3hyCp+6eVVJJBM2Dh0R3iNy+eONLXTIUvAlOdnpcMuA225la9HCMsKwU/2D6yr+ElDRxbIUXqBQaYZ0nZxr1AcnK4N32fKOSw8+46sHQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYjwp0Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20104C3277B;
	Mon, 22 Apr 2024 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830295;
	bh=tVX8CPlW+oWCXMKKFJChG2+aTFGC0tJ2cjuU8dwsx0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYjwp0Z2Sz19poNm6FdtaNDqSqOMGuNdzE0BmUCMemowTifFByCbTr547g+d7jBRT
	 5S1Pjx/EQQL4yByIN4MWGpMBhVZPNnAzPBTjzDqxNz8FznRc8KpdVQ2/+oDWFLD3Ou
	 cN+7t52L3Jdl5MZVjN8uFv4pQ8tLe9c8Hv5LGRoui1vk+l6bHn7MCB0fLAxyw3j7rR
	 QCyNXBMv8eUcStC7ErQmL0BRn8+YBECN2TBb7vWn7wwzPtZ92/AmRNHZqcXl9fBKGf
	 wKq0iXeArI8VX16fZfatZVlibDk9Ar+URFVkbxaTeL8Iku8kJ4lfbwmT4y2iDmp5KX
	 edUXtDGmHbNdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/10] btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
Date: Mon, 22 Apr 2024 19:19:16 -0400
Message-ID: <20240422231929.1611680-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 3c6f0c5ecc8910d4ffb0dfe85609ebc0c91c8f34 ]

Currently, this call site in btrfs_clear_delalloc_extent() only converts
the reservation. We are marking it not delalloc, so I don't think it
makes sense to keep the rsv around.  This is a path where we are not
sure to join a transaction, so it leads to incorrect free-ing during
umount.

Helps with the pass rate of generic/269 and generic/475.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c7d8a18daaf50..07c6ab4ba0d43 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2261,7 +2261,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 */
 		if (*bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.43.0


