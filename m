Return-Path: <linux-btrfs+bounces-11068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6BA1C89C
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E11661F9
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA715A843;
	Sun, 26 Jan 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJmEbOb1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0951993B2;
	Sun, 26 Jan 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902947; cv=none; b=GSXCxhIWOgMeDzHfVP18W3BoIcs2n0gbm5MiKmUHIaBYFSpGPUzp4w4sMs/ySWc+cFEiZn2hbFe8CRePFAQ773cvc4iZyvuoNSpJdT8phjUk1rNxmpOOBp/Vx4ljjiCrt/xiQtQ65Z6pJ8atroqLw2qWNzKRc2EvkFqWHTF1ccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902947; c=relaxed/simple;
	bh=2qm6EZaar3W+BpWNlCu9d9a4XkEQtujz3UcXUzioeBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrWkAlONE6PiBIJbgd2JpwlcwObGOILV4BrUvLevnvckb5I52Izk8g2D+5+jD5tWG+l3+saBnN52lh3Gu6vvNmoNqmiWfaN34DofsglJjvD5JbiSdTGIoJUAcuugjFpl5kJhi0i8OEmsXKpbrrPCzcEerCg6uyGlMp1Ti4nNV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJmEbOb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1271C4CEE2;
	Sun, 26 Jan 2025 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902945;
	bh=2qm6EZaar3W+BpWNlCu9d9a4XkEQtujz3UcXUzioeBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJmEbOb1krZPQoHMb7+9pR+6qS4tLgUG5pNLexMZdVG/iiM1pXFTsXri2Qf9iHJK2
	 FyYMbxxwOayn+SMyynOuzkhHOjwF5+cwbzKfN3ZEtSWAw4jOYg0rlfGcRwoRprqpk3
	 mtqao53WIHLI3NBzCcnXqIS4X3rHBft90YUIFPKCUHSefYy29ov8yeAxLovA0nMIWD
	 w5uDYV4dvB4yNgmABB6ua9ZFmTU9LTdEXPkPrZg622QDiGF+U0g3EDwrm5v8TIdFHG
	 N8joVMIXmIclBvKPjgGoQBjtXs5C1EKPAzsySvU7jLGutrLgoPmZ1UFVYTtKTLbqTZ
	 yemVHnblAl/iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 6/6] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:48:53 -0500
Message-Id: <20250126144854.925377-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144854.925377-1-sashal@kernel.org>
References: <20250126144854.925377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index adcbdc970f9ea..f24a80857cd60 100644
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


