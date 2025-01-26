Return-Path: <linux-btrfs+bounces-11072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7EA1C8E4
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2077A29C1
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885A1A38E1;
	Sun, 26 Jan 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF2NqBhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C41714D0;
	Sun, 26 Jan 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902966; cv=none; b=CsoDp40J52LS/rUAuA7OZdB0Gi8j4kq3QtaCjCP8PW0wIlWFAimKHT47uRSk7KVs5Jw4akkDi498vwnaSI7dZVCZWwv1/SojdcZsKGHklY4MIMTq18FNEVkYVe+5Yu4I0hz6AdL7BAoNdmWjZdL8Hm52axupIT8z5Y5HgzvxWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902966; c=relaxed/simple;
	bh=6DA/UEcNo4XDr6H0xAe4SFAjFcegThYxcoWGbW8Z4MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWzJ2/HyfVOm9c6yeKgPJBuOTeAWoEO3egqCA2Lnn0RGY+MEMXp493Ft0xtbnS1yW9LMNT20zHb8MOVH/baGQ8Ejls4LrEdE61pKbPzrZ4nR4EUXGPm0VKE09jDPApfvkKWkolKz3AVkNeVccGqcNU1zRe2upghVOjS7hLMuE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF2NqBhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7ECC4CEE3;
	Sun, 26 Jan 2025 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902965;
	bh=6DA/UEcNo4XDr6H0xAe4SFAjFcegThYxcoWGbW8Z4MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VF2NqBhwUOEGK3mzVY5Y5aqdZ+QZz8itYZEoTKBzYfMjbcVNUc9rAZpTHJTMTaHZW
	 ijWkmKOqDNzfXV/X7W9plnpiJTNGzL/TC3zevXGBOA2BSC3F0LxgffN0fnB3EZkfBq
	 ZaZlCiMR6SlvMkfsF3mn4zmv+5hlv6ouo3FaqmCZTQt6HObAayp9a9gQNeVmD1dk2e
	 cCqCTvqpZcVa6ghE7E0O+e67LZQIgDkGhfN0Eip5pWrXbvrZ49eMU0KlD3h5N7ZrvJ
	 Y9XuBlZRvLA22IoIzQ6YeNh48Gf/LETovlQw1g55o6q3gQ/X6BUxu8mIlNFaSq8wok
	 TFJW4JCTGryQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/4] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:49:17 -0500
Message-Id: <20250126144918.925549-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144918.925549-1-sashal@kernel.org>
References: <20250126144918.925549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 4c6ba97299cd6..d6cda0b2e9256 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4423,8 +4423,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
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


