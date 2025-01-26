Return-Path: <linux-btrfs+bounces-11074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE4A1C8E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3290E1887A9D
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240241A8413;
	Sun, 26 Jan 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk46kAhP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6E1A83E2;
	Sun, 26 Jan 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902970; cv=none; b=uDHOFJlahNE7XwZfA33UiyhdBXWTGyYqWARIxPkX8qIBYZuMMyBOorW1OcH9L5XbP1o/4h5QkHI9Me5ovWZ972BFLpIlOw9DoVeoXVmx8deYvEOOB8C2jO2f1cebn1utymCsqApa1ZYtwJFb+s3+hDjqnZkWz0WV3R/hrT4+dgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902970; c=relaxed/simple;
	bh=Br7vYgj+FCtFGn8supBZOAlkZj4HJKpL0VOJ+GZSKrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbqJ8tOZjUoFad48ZyWxiCJy0AI4WqAQ3fIcCwFVP5O41qkLNNQd0JOgBDMZTvcc8wkHzfqfAQJRKoEgbcupGnG3eBVvYpEtZhCi4JtM6X/Q8d88vL+IvOhd6s++1cRrtrjjByqB5MbW1K/byyLWgCyd+S0bsOHYANWoYuNpMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk46kAhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34450C4CEE3;
	Sun, 26 Jan 2025 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902970;
	bh=Br7vYgj+FCtFGn8supBZOAlkZj4HJKpL0VOJ+GZSKrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk46kAhP+NqLbJNzO6on5SmXDTDUcuS1+N3QYRqcICbOqxHxRn7mtuFSFnnyALk27
	 8YQRe8hNAW8pNG/s8sBXrOwhZcZtxnY3KBXFTRAXcS0N3n4wPd5ri6o7odbBpTCt7Y
	 Laqm88i2lndiGu1BNN9V97x6vF2LrKRzxG76R9YQSB/ybOo0Z9EUVLsSI8Q1ulfvCa
	 ORB7blEmXX/Ts9x5hW9XEOKwhd9r5TUiEJTO/bHHVbTNpMsIiEEY4+3zsIv/+TbVpU
	 OwLnZOgVmERqlnmipbLVqc+dV6fia4hN+CPE7Q9tAyjTVAb0e4km/+wymx0bZ4Gchw
	 mu8InKodmWu7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/2] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:49:26 -0500
Message-Id: <20250126144926.925617-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144926.925617-1-sashal@kernel.org>
References: <20250126144926.925617-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 87f302a413f9a..887ae4a9c50c3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4414,8 +4414,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
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


