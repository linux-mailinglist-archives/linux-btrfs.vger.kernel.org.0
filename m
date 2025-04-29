Return-Path: <linux-btrfs+bounces-13533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D34AA3D38
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 01:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7104C0157
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A432E62AE;
	Tue, 29 Apr 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaF+hCMY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE82E3394;
	Tue, 29 Apr 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970642; cv=none; b=FKCWvJT8DvvIE6WjenkIippdYVNQvujJTXHa5uAQoSMSi2w58EARuXo09eMhIrHdWGgcVjyByCaWvaUGdn5EE2InsH4uP5HOMi9ORjnzXXZoooWbJBqiB0fzwtjKjJTBnE3zSPxUiPoEVcLIVQaf+aSgf3/2s1zqST8A8LxsF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970642; c=relaxed/simple;
	bh=E3QxLlakm2Gr1puJo9qXMmbj9NvCCBFAlAbMWzgIMjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYh6f9cxdrulND4HQ5WcwN4Kz60RPtoR0hJrIpObbUKeavmcn443b2uKc/2t5yJP7U1/Awx9JgY/gwFndMNGjfVjW+TXzgdcMiERZNAAoFbDyy3SD8bumMs0oLDWLjJ1jLvnV1O9kFvUT94mtGzfqISc1QOWQ0rBLgLUVlBTQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaF+hCMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E1CC4CEED;
	Tue, 29 Apr 2025 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970642;
	bh=E3QxLlakm2Gr1puJo9qXMmbj9NvCCBFAlAbMWzgIMjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaF+hCMYyiK4uQZtJFtIGvQFaLic1SSZrOunRQWcbpiB4Lc9/6FLyDrH1m4hziv+a
	 dYxdl5pZjrXkvnoHI4xQH5WH3aOWZNmDuY3IUP7dxEzLriYvjv4msuC5Rs8oABN+tB
	 wv2vDCyql6F0Vo1f/4g+cLEbyqmuvD2STW6d5Elc0Pnwpto70hd3SylTnfATP4UDEu
	 xJ5LiLQRs2OevoyhhhuCPbJ436pubeRnFzOmmadhhGv+CNG6vGtkd/zAs5NWO0A0ev
	 udc5S5YekbqLa4ynQ5/tQAmZHzGVGyBfk24JFqtumN/eRZgjGiFR3kfyCw5q7+wVlR
	 pBgzqD4yqbFQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 18/39] btrfs: tree-checker: adjust error code for header level check
Date: Tue, 29 Apr 2025 19:49:45 -0400
Message-Id: <20250429235006.536648-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit f1ab0171e9be96fd530329fa54761cff5e09ea95 ]

The whole tree checker returns EUCLEAN, except the one check in
btrfs_verify_level_key(). This was inherited from the function that was
moved from disk-io.c in 2cac5af16537 ("btrfs: move
btrfs_verify_level_key into tree-checker.c") but this should be unified
with the rest.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 43979891f7c89..2b66a6130269a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2235,7 +2235,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 		btrfs_err(fs_info,
 "tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
 			  eb->start, check->level, found_level);
-		return -EIO;
+		return -EUCLEAN;
 	}
 
 	if (!check->has_first_key)
-- 
2.39.5


