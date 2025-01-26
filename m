Return-Path: <linux-btrfs+bounces-11075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83690A1C8F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09974166811
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404C1A9B34;
	Sun, 26 Jan 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwwT1yTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4551A83E2;
	Sun, 26 Jan 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902973; cv=none; b=Do9KcpmFYH3Zbd076bBkIK3TViNhRd5J7bD+28cjxiekGqIzq8LltMuqR6uhkSioRif1HgV96+/Q/4/Cu2JLsKqr9iCtvwuxqXFy8k+HXw6W2jn3FTquuNEnZ8bGg4fbZYm61d6IRCM6uLHwmUhAHFkaM7MsGRKVybrnujVxkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902973; c=relaxed/simple;
	bh=xCbmDYscuIAXcyPTul2ZheG0PoZTHFWxyNkVLY8wGy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mk00thLIKFJTZ0S5Z0dv+wnCdKg6TSyK63pGFs1klaB+m37ROedw11zW4NuWOsZbH4b01ddZ/bxatvYG7PEX7qI6OmAun5bAXnbaFENkqUrsP4Nq7/SD9LOQrr3PWLdB+EPF0nOYimj+lGOaOPNcfMdsbjstQjNKbbJoWM5l8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwwT1yTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2304C4CEE5;
	Sun, 26 Jan 2025 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902973;
	bh=xCbmDYscuIAXcyPTul2ZheG0PoZTHFWxyNkVLY8wGy8=;
	h=From:To:Cc:Subject:Date:From;
	b=lwwT1yTuRmvdtHF8seBlMkMNSh841hA2EdvQj9nlNxt8FIZ6ioyf+issGUmG8QCbh
	 wlply3GgL3Ruc1FRd4mQ1/pmLBPsGBKHnb4UuTq3NLn2ccAPlUp+4hCG2vP8rloaWS
	 ULApdjN81rf6BO2wh8N+9P00GSR0QBozh4nLhyzEoQYrrwkBjVA3JsXaUDO7BQ4IFC
	 gDIahZggNDGqs5V+53LheuovEa/GDHcWuoJU4PkLS9ZDn+rZDORkvjGufW9RINGgR6
	 azMDNPj3T5q78IxCuMuOaocrlNm/ZtaOGfKoUm/g3eyaETp8NI/ChzYZwyC9gDiPoj
	 QSSBhYROHjR7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:49:30 -0500
Message-Id: <20250126144930.925655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 98e3b3749ec12..5b921e6ed94e2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3976,8 +3976,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
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


