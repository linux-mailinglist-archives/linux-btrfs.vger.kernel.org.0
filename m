Return-Path: <linux-btrfs+bounces-3245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E670C87A82F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238301C2123B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C641A8F;
	Wed, 13 Mar 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtdOSbjt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450D4120B
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336053; cv=none; b=h+8LGJXuRbIAy84W0VsErHFN6JfBZeOXZAefwpgmVq1mTjvvg3hlnLeNcxtlG4j1cHIVeyAJvrIAM8KiLcg9z/soq0Lh5Fn6Daz8j/V/42T8XBDAXCeqvNLKXNwA9unjJJFv1gIHdp2QTYCQau1Ml8Wd0ymhiX1Of3wFKVknB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336053; c=relaxed/simple;
	bh=0qHg+kqnHcIbRamgUH5v7fnWmZdE08NLcXsJknoxAbc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qw1wqj7ZYFGFKYEMJZHm22t5dfh6hDncM2VBJEB75fcOJ5Xl/cTDUbf9gNKlXl+ZcIpS/U0ZSGQlybak8UtuvV+nB+0XOGLhodLXcz5NcDmluauWm69kxbY52vOmaLhdZQZjxRGG05F0Ht7wMbHYxEr8NlaGnoxyrTsXmU6MVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtdOSbjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8778EC433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710336053;
	bh=0qHg+kqnHcIbRamgUH5v7fnWmZdE08NLcXsJknoxAbc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MtdOSbjtJ6TZsXwr3JhFxlR3VcTwnJcAiql3dK0RIeAZDMyEQEahIqoIYOi9Hy3YD
	 Jwq8DR+pM6qWWmI24OVXeZpTk9JAMJ5agu868N1o34sqK4ZSb+UJxR5IpkpTb5d4AP
	 jkwiFv9ZfsCecEPuIZOuIpCfXHeWvRgeqEzkYshwpAsmiNVmHN7oJAti+XuEiW8i42
	 yVo+8RQ+/EWUnC0w7DrU/fqDj85NoZDhvIuCk/skKVv/Zq+u6d9LQ4rRGLr3L4xnus
	 uyLF8QxbLY8QLXA9ZJQm5yU1fCamd6b1GpDXS/DcQeEgUoSdsmN1cvWdedwf5N9PVw
	 VJcU4OVLNobDQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix warning messages not printing interval at unpin_extent_range()
Date: Wed, 13 Mar 2024 13:20:45 +0000
Message-Id: <7039902fc65bb3ec188a461436d19afbc71da1c1.1710335452.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710335452.git.fdmanana@suse.com>
References: <cover.1710335452.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At unpin_extent_range() we print warning messages that are supposed to
print an interval in the form "[X, Y)", with the first element being an
inclusive start offset and the second element being the exclusive end
offset of a range. However we end up printing the range's length instead
of the range's exclusive end offset, so fix that to avoid having confusing
and non-sense messages in case we hit one of these unexpected scenarios.

Fixes: 00deaf04df35 ("btrfs: log messages at unpin_extent_range() during unexpected cases")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index e03953dbcd5e..2cfc6e8cf76f 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -309,7 +309,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 		btrfs_warn(fs_info,
 "no extent map found for inode %llu (root %lld) when unpinning extent range [%llu, %llu), generation %llu",
 			   btrfs_ino(inode), btrfs_root_id(inode->root),
-			   start, len, gen);
+			   start, start + len, gen);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -318,7 +318,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 		btrfs_warn(fs_info,
 "found extent map for inode %llu (root %lld) with unexpected start offset %llu when unpinning extent range [%llu, %llu), generation %llu",
 			   btrfs_ino(inode), btrfs_root_id(inode->root),
-			   em->start, start, len, gen);
+			   em->start, start, start + len, gen);
 		ret = -EUCLEAN;
 		goto out;
 	}
-- 
2.43.0


