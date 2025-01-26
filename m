Return-Path: <linux-btrfs+bounces-11065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C8A1C88A
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6871883111
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6237156887;
	Sun, 26 Jan 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR3QDNPO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6321189919;
	Sun, 26 Jan 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902931; cv=none; b=uNvToSVFwneAWitSMjgKnyEBWhcfVPGxpgkY8I7X/S+Ur2XQy3t7LQbh0lZEBvpWg3hHdmYPyp5/5Jv5oo+grGJ1OpvJ9+W43SrD6mXO22/Pxak2SgZ2daUtHojJIge+ZxkYiVaR+aB9LybDApZIQ/wpkOh2kxe6pfDpsT8BjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902931; c=relaxed/simple;
	bh=PsuA2O7Ae5NUjD6RCAa1OjRPBOl/uUGe+ecjcw0szn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sd7C6bGPc8SkfEx3u4LpuhSLHnjp2bkVcJuATisnjrtHNSth30NtXD1YxEHXzDa9I3Wgca2pinYJXiKgM7sL/a5MZlgMS4Vo0NIoAlj/wzx20QlQxcUFXc1Oxt14VOGJf8bqm7+2N3NZKxmxHfD2xTnsaNNGQhnR/wTFx18ixkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR3QDNPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CAC4CEE5;
	Sun, 26 Jan 2025 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902931;
	bh=PsuA2O7Ae5NUjD6RCAa1OjRPBOl/uUGe+ecjcw0szn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gR3QDNPOmy/SncMho4m10bYW7IZEVN5/JwKcBVFIwC4dfVOUwEHgY5JU2nG1XKcjy
	 +1WHAw5zE2JnOAGiqtWCJDHAsoA+Tix9io1tMcerGIW6VoCV4svHBN5OBiJ9Nf6/Qs
	 n7gG8VkaGEYQ/hccNvsAFOg4FsS/prbJ7OrbD//02CyyfTx4WUQhrzQzi+G3rL9KUZ
	 uVJb4fbMEXTlOmcKqqP6u2UXaETjJC67q8GP7naQfYkaYQF92nnf+0V5gQaeV+J10C
	 zuqLlBUazjfr9Tw59hcwxylfN3y2Um4Ba398V4CNTfxFCPfRQ5na7X6TkU32HGFzy5
	 ZGzpRSfspQyCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 6/7] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:48:37 -0500
Message-Id: <20250126144839.925271-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144839.925271-1-sashal@kernel.org>
References: <20250126144839.925271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index db8b42f674b7c..ab2de2d1b2bee 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4405,8 +4405,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
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


