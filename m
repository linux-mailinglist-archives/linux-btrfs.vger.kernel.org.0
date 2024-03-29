Return-Path: <linux-btrfs+bounces-3762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7E891B40
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E06AB22480
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C391703CD;
	Fri, 29 Mar 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdckBq5x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79081703B6;
	Fri, 29 Mar 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715671; cv=none; b=VntF8khkU7SAVQYWZDslPl0rYiMuCWoRK3b7UEb+P/ualtVs6HUgZ6OM+pdmdPGPQwwzqfGTECIG8UfbfQceEcQG5bm87Vc3Ks+hvz+7solSU716Vh9RMO4gNi3PHk6EbPE3wUtYdX9v3eRPf5aTrLCEjwfgYNUdXfMV4bD6OrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715671; c=relaxed/simple;
	bh=Wbr3WrvcU27mxVlXxKr9LiCbLXTK6CwiODDSojafyfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9FYTtZ9aeDPYY9XbKgUDQR2mGl46LJwzJHHtVVPSZlV22hzOg5jp0RfVDoxfyFK9o7vmgvjWqHj9z1/q7vCCEWqdW946aQ/yvdDFnYpDPVezs5Tl0HTTHI19md8vU2/AiRvUVs4o/BxIH5R0xxePlogvQCAb87wk7mGmDQC94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdckBq5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A38C43399;
	Fri, 29 Mar 2024 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715670;
	bh=Wbr3WrvcU27mxVlXxKr9LiCbLXTK6CwiODDSojafyfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdckBq5xLp/GNQAT/TezvNBqFmXDxZfQnigDIBiXEpjnDU908FP2uY3Z4OdMpHFwY
	 XMg94wfCmavK4kLYv9iJesREiVqoXf3ewkcP9c4UbMcKExDTrB8zYxGVxzvg8rHRuC
	 oPMapGxTJtNiy7hgE123UD6U62ZEPSgMmfiQA+o6ZL1Rn6//qBnYerJGYxJMINT05I
	 1PqCbI5u5jUQxErPQY29lkZaQK/aYa6AxdSlhNVL8x+0t7lhqklMrJjD5zCYQAJw4W
	 op9dUj/XqwHx0TemSxkafo7h3q0LvwsbJ8PqqWBYXljz28KKuDfYI09gTOLof9GAE+
	 SoC7vwUbWgkhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/17] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:33:52 -0400
Message-ID: <20240329123405.3086155-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 7411055db5ce64f836aaffd422396af0075fdc99 ]

The unhandled case in btrfs_relocate_sys_chunks() loop is a corruption,
as it could be caused only by two impossible conditions:

- at first the search key is set up to look for a chunk tree item, with
  offset -1, this is an inexact search and the key->offset will contain
  the correct offset upon a successful search, a valid chunk tree item
  cannot have an offset -1

- after first successful search, the found_key corresponds to a chunk
  item, the offset is decremented by 1 before the next loop, it's
  impossible to find a chunk item there due to alignment and size
  constraints

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index eaf5cd043dace..634b73d734bc6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3178,7 +3178,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
-		BUG_ON(ret == 0); /* Corruption */
+		if (ret == 0) {
+			/*
+			 * On the first search we would find chunk tree with
+			 * offset -1, which is not possible. On subsequent
+			 * loops this would find an existing item on an invalid
+			 * offset (one less than the previous one, wrong
+			 * alignment and size).
+			 */
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
-- 
2.43.0


