Return-Path: <linux-btrfs+bounces-13302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266AEA98CB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68671B64EF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369827EC9C;
	Wed, 23 Apr 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXD9dvzX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613B27EC8B
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418012; cv=none; b=lze0ipGh/WsT4BhmTzKkPIt32uQorBueK0QLNH4jRjzuJkBVd4+6MCxbABR0iNcnQe4pmN36Mj8fX2y9VzqzTP8JUF39iExmMkTBAXr8CeaNvdfMGfjOTWh2YRcbagGRHRuKkp/6o1vWS44srs0kO5tckEp5DK0heS8bk4+x0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418012; c=relaxed/simple;
	bh=zkTlA8wyibpyIH1koRo3F7wR7pGg2Rk7BBaji0eCYxM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJ9wIOqpZGCcWkN5It2D5EPOrA+BF2M9zbSGRd/2ZR5WxwfG7O22eKspJO/nHJmb4bwWTKiUtLwINYDtCCvjUvyNAQpwSFwIbQgADG25qQPqsoCO+nIz1gxOPNxsmjZ4jDkxbPFLSiABuRQZ/4Ct0OZKqD4UZhO858DotX3mWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXD9dvzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD12C4CEEC
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418012;
	bh=zkTlA8wyibpyIH1koRo3F7wR7pGg2Rk7BBaji0eCYxM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uXD9dvzXr0muZJsUydvhIrzwzjmznDqzsjt2DdgwTdyvGfOAWx9+9fsxFQwKXzP+e
	 Gq5Zac1TSvGmycVGUWzfLBLGyHnXC06t6eb8y1HCrQbGVtonZoIQYljeJoufHE1csk
	 swOGMLj7Ic3cEyCMU9du6ZoWcOKGCKn5T11d984sPzN/YW6JNC3xlt4N/p5h1y6N5z
	 xQYBgDqT+8qvnIr9bd3SfIJ2JNOKUxWQw0lWSxKwkDdKwE8bEPgnMoLRpWz1wgxHbE
	 4sS69wLpuRRqwtsZ610bl/5S82sIFA1fQiCbvbV6oO3Vn6pvlse/ou0mGZdHAap8Kz
	 1vQDmP9gwvh6A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/22] btrfs: simplify last record detection at btrfs_clear_extent_bit_changeset()
Date: Wed, 23 Apr 2025 15:19:46 +0100
Message-Id: <18a6632e21e383069f814298759d77cfb9115215.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of checking for an end offset of (u64)-1 (U64_MAX) for the current
extent state's end, and then checking after updating the current start
offset if it's now beyond the range's end offset, we can simply stop if
the current extent state's end is greater than or equals to our range's
end offset. This helps remove one comparison under the 'next' label and
allows to remove the if statement that checks if the start offset is
greater than the end offset under the 'search_again' label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 590682490763..5484e2b80cfe 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -734,15 +734,13 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 
 	state = clear_state_bit(tree, state, bits, wake, changeset);
 next:
-	if (last_end == (u64)-1)
+	if (last_end >= end)
 		goto out;
 	start = last_end + 1;
-	if (start <= end && state && !need_resched())
+	if (state && !need_resched())
 		goto hit_next;
 
 search_again:
-	if (start > end)
-		goto out;
 	spin_unlock(&tree->lock);
 	if (gfpflags_allow_blocking(mask))
 		cond_resched();
-- 
2.47.2


