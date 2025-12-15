Return-Path: <linux-btrfs+bounces-19732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11ACBD351
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0101B302A942
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063E329C55;
	Mon, 15 Dec 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b27ALVcm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4F314B8A
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791513; cv=none; b=qpHX3Kz4Ttcr2yjKm+Bezv7FSaJdW0M6/lodJyKsiQIoxy2dPLIC7D3tZ7Ato8M5YtdqPJEHgXDj3ALwY93HeXys1AioAF+sIrM+rtShO2HJ+rrIPRpkJbPiJo3xPwmCBPTo4mPMvkkFKy1Rg2a1NQs0NO8a/8SZsQfcNlewPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791513; c=relaxed/simple;
	bh=g9c/9af1UJd81KrRbczz0DXsIWmDHK7G4qZf+Wn+mE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUO43Jwd54eFry43a3rQwiWbi7cOyQJ4Nq/9kGZ5pxMbkUpSqEAxZjPPddyM4vsndvwFXqRRfkmYv6E+ZnmuP09LcYcp5kre7/aRhuJ0NaPd0I0B+bdf0q5LCOwH3VkEt4b5MXowIVPbquW1eixr1yz1PXp9ae4+t25YvMWxoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b27ALVcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C910C4CEFB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765791512;
	bh=g9c/9af1UJd81KrRbczz0DXsIWmDHK7G4qZf+Wn+mE0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b27ALVcm24rilN/K5fnjPo+qGAkTJR2VuIpW+N84A9/PJUq0MtnL8+zY9IWYpWbY2
	 2u1W3qXLQ0ugH9iwY2ZmyJOm/DEooMyC22b5nB+w2e1ryEITLnk39ze1yzLbxHNHvp
	 1M3+kMo2lT75cq73PR7ED7a/1SgWuV89lVoTwo+CmvW3uE5GQZV/ss2vZy6cg4hgdx
	 J3zF+Yj6K0kaGBU/aOBG/mBg9G9QHjyjFVa5qPfrKSbL5m16fNY6lv0tI+N078TBik
	 M7+pkHqkecbnsKdPpWFzhimFf/K/zseyekuTkPc9Hb2i8wGrCQwbJmgCtKx6lGxEDD
	 hKaisn8Qq19/Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: do not free data reservation in fallback from inline due to -ENOSPC
Date: Mon, 15 Dec 2025 09:38:25 +0000
Message-ID: <d73d7cef875d6fca9cca0d6db39fdd5d77f55c6f.1765743479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765743479.git.fdmanana@suse.com>
References: <cover.1765743479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to create an inline extent due to -ENOSPC, we will attempt to
go through the normal COW path, reserve an extent, create an ordered
extent, etc. However we were always freeing the reserved qgroup data,
which is wrong since we will use data. Fix this by freeing the reserved
qgroup data in __cow_file_range_inline() only if we are not doing the
fallback (ret is <= 0).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 566780eb80ff..605589f29da7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -675,8 +675,12 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	 * it won't count as data extent, free them directly here.
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
+	 *
+	 * If we fallback to non-inline (ret == 1) due to -ENOSPC, then we need
+	 * to keep the data reservation.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
+	if (ret <= 0)
+		btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.47.2


