Return-Path: <linux-btrfs+bounces-10420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65D69F3757
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C758C16C35D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85383207DFC;
	Mon, 16 Dec 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV+9zWhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA393207DF2
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369456; cv=none; b=WhzMqmxmciIN3gpR3jRzWbSgTqxorE6AUwgaTvYxKx+6E/reWno6/lPkFlEBVQPR3Bvnc6ytaHsPnM4A1nQ47MPgdqvgJnax0AgiUSkTZFhZoNlK8nGhrD8ljLdu4Sx7gVFTECjeNrZJvqGyeJ5JQP9EogV2/N3xrQVmeO0ri1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369456; c=relaxed/simple;
	bh=TWfop68J0/V4tNQYLbzq6QHeylMcxgdDRrgDl64LAKc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0gzyLEX9vXVseixTeCw9+nTif4SBk03rtuVCfy1h5pRlf90JtuX/bzD4vQLLjmuwOc0bv2LB0egWuSNEbowZyqjvsKrc0bEF4CNPss1J8eNxRiF+xO6RSKJwUyJp4RsnietMg3rFVey/RhV01p/dFNF846T7z43/AUmHLV/YXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV+9zWhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C307C4CED4
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369456;
	bh=TWfop68J0/V4tNQYLbzq6QHeylMcxgdDRrgDl64LAKc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EV+9zWhw4eBGiTYrpuqGZ2W8TmzwUxZ3xw7ygTKUh/ZoNL9y5a5P1VALPfDdjcVDt
	 jg4ADYtDQsYlFzc7OLyBKtCmkHTDCwqY5cPmdr2WVBZRXwMexxgBsh1Md+CBQnha5W
	 ZnnqBy4iovorblJYvn5Qb89be7Cm3i666LtCXgN7mW2d8/S3GEonDLlRBo4pUM0BRA
	 rRX9iD5DYjATa8TcgZPTHNFV0Ea70Hqj3D3L3hdZlzn2CtzrcHhxdx21o09TEFb6nb
	 8nhuca/499re9zKRhXutvpCtpfncijIa7FASiVHOKLBMVDSrrmbEG+8TUYyxsMMhhJ
	 GwPBetR2Trt0w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: remove pointless comment from ctree.h
Date: Mon, 16 Dec 2024 17:17:24 +0000
Message-Id: <edd83757b6aaebaef1f3c0be7abff06c51c54909.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless to have a comment above the prototype declarations of
btrfs_ctree_init() and btrfs_ctree_exit() mentioning that they are
declared in ctree.c. This is from the old days when ctree.h was used
to place anything that didn't fit in any other file. So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cdf10cca8194..1096a80a64e7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -505,7 +505,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-/* ctree.c */
 int __init btrfs_ctree_init(void);
 void __cold btrfs_ctree_exit(void);
 
-- 
2.45.2


