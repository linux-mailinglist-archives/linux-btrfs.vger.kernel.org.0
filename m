Return-Path: <linux-btrfs+bounces-11070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F91A1C8BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794C67A32D6
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B019F471;
	Sun, 26 Jan 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeodXVyO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935919F416;
	Sun, 26 Jan 2025 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902958; cv=none; b=f28IJRNLINZuDyhYRYreN5BH4gGRzF08XGPPDc3avKIqEQWz52oHcfCae5fjsQoMs79sVCf6seAm9vmHdVjSusLPnLU2c2Pwy+oY8OjUWPD1mMuVjwD2wx8XU+Xqwj1MQuOPCdRHRTqWKZ4GJhs+/u8neRd/gb2UivTvnfT+nWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902958; c=relaxed/simple;
	bh=Q4MUxk/WytrKjrTDXy5MsH1TXPIi7kytcdrOYgRBfFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Flfrj+OEU4KTWKiAlY/w5mSIwZTFxqilMZQEmcGseUB7bLDq6qNoE93Enjetwuy+skwH8Gc0bUYTZvfWOdR0s+g0FzX2ij0O4Ek/Hsmg5ZSo/WvOVdWr8iKLaNyqy7VCjs63YG+ttu0hMFt7agOSH1+1M4e9gSDl4mzrgv8WLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeodXVyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E900BC4CED3;
	Sun, 26 Jan 2025 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902956;
	bh=Q4MUxk/WytrKjrTDXy5MsH1TXPIi7kytcdrOYgRBfFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeodXVyOBDmKor5U+pe8cEcGVAEcc6eFM67wyOBGOa1UQ7LI7MlL6XSuwUv/EzfxE
	 m2co3RDsZ1Hvo8VNltJuF4gjzGfVOY0Ni7WI1H0sYknQzMWStTZWImNMkgHo39T8O7
	 PIoNnwMpGa+F/Jx+Se+9/HOQs1LOhvppJrae1M1noTEgcK/oPmG/caKIV1by62M7DY
	 VYrp6beOkaFcxkJpdzfX9K4To63IaDT0xZ5bccES0SuxQ9g/5zSR5npHrAlLaKS1Jt
	 Fs6t+dwXdcSJKi9ef0ROglSWqoD/zENJxFseZ6QuDL4BNPDTwgvJ3aJjhs9s16bRpm
	 muscmfGyOTmNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 5/5] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:49:06 -0500
Message-Id: <20250126144906.925468-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144906.925468-1-sashal@kernel.org>
References: <20250126144906.925468-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 6a4730b325aaa48f7a5d5ba97aff0a955e2d9cec ]

This BUG_ON is meant to catch backref cache problems, but these can
arise from either bugs in the backref cache or corruption in the extent
tree.  Fix it to be a proper error.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 299eac696eb42..537e184b4b1df 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4378,8 +4378,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		WARN_ON(!first_cow && level == 0);
 
 		node = rc->backref_cache.path[level];
-		BUG_ON(node->bytenr != buf->start &&
-		       node->new_bytenr != buf->start);
+
+		/*
+		 * If node->bytenr != buf->start and node->new_bytenr !=
+		 * buf->start then we've got the wrong backref node for what we
+		 * expected to see here and the cache is incorrect.
+		 */
+		if (unlikely(node->bytenr != buf->start && node->new_bytenr != buf->start)) {
+			btrfs_err(fs_info,
+"bytenr %llu was found but our backref cache was expecting %llu or %llu",
+				  buf->start, node->bytenr, node->new_bytenr);
+			return -EUCLEAN;
+		}
 
 		btrfs_backref_drop_node_buffer(node);
 		atomic_inc(&cow->refs);
-- 
2.39.5


