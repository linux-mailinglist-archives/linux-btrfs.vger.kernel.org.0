Return-Path: <linux-btrfs+bounces-13307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B2CA98CBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB31B65BC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584527FD40;
	Wed, 23 Apr 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv6eF+PS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703427F743
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418018; cv=none; b=F0VqaF8JHz36K+XsgL6GftztmCUCSwRJkpI8mwqI4h/CoZwadp/dd0MtgXKeMeUy353rxX+69CCZJYHk7mG3rAXCVe/0JZmQF18tGUpjnLVv2yRXv3ZLdUcQLMqf4JQVfTYpBVFTFfbeDuPJt3pJbBmyHg6wbx2mM3w3lAJvtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418018; c=relaxed/simple;
	bh=BLLPOT5WvS0WI671rCAmLnCxZzEYo16fGMkZ1a04DQY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ME75SS596nlbcdFXVd8jIpQOznXfHTZUJ1c4s5g9FDPtCZ2cxrWKh/xooyjgEVrIJZShyE0RQLhcYpBfhddDPeXVg1+PV6vQhh3IlfyRetoWDmA8ht8ddWZah5Xzi/TMB9A6PxOLKEYTw5wbr0kadrDZihEVvPgVGZsrzav2TQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv6eF+PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E685CC4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418018;
	bh=BLLPOT5WvS0WI671rCAmLnCxZzEYo16fGMkZ1a04DQY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nv6eF+PSSXE3qUHS9/Gt4mD4wdRrpw2D+eCUbBte66++PN4qKamp2tp3dg49iakCw
	 QzG2cYZX4fdcNYRDjOn1a6Y7TYXPXWsAq/vl47NRvDE7bsF0r5QsT2XjFJlWwIEUck
	 7xwpJWe8o0H0wKw4OmuN9YKfVWryKsnKzzHBa+fupJHPScoEqIP5Z6x4Bl7T8Q2owc
	 PnkUVVo7DrzyLAxBfCAr+XpTebhIGuOBTRrZvzgVZ5EVFDDhcmkzN8pU5eiaQIl0JV
	 geAVEv3+HX+oyv6OAUVfIanj7c1kRJ+3LN2oQmZgOeAae6kSD1f8yaaunhCOIvdO3K
	 RLguzqB89b7BA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/22] btrfs: avoid researching tree when converting bits in an extent range
Date: Wed, 23 Apr 2025 15:19:52 +0100
Message-Id: <169a547a4f511dfd5bc999e7a0ae984ebd045df0.1745401628.git.fdmanana@suse.com>
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

When converting bits for an extent range (btrfs_convert_extent_bit()), if
the current extent state record starts after the target range, we always
do a jump to the 'search_again' label, which will cause us to do a full
tree search for the next state if the current state ends before the target
range. Unless we need to reschedule, we can just grab the next state and
process it, avoiding a full tree search, even if that next state is not
contiguous, as we'll allocate and insert a new prealloc state if needed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index a898a15a7854..65665c0843e6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1458,6 +1458,22 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (inserted_state == prealloc)
 			prealloc = NULL;
 		start = inserted_state->end + 1;
+
+		/* Beyond target range, stop. */
+		if (start > end)
+			goto out;
+
+		if (need_resched())
+			goto search_again;
+
+		state = next_search_state(inserted_state, end);
+		/*
+		 * If there's a next state, whether contiguous or not, we don't
+		 * need to unlock and research. If it's not contiguous we will
+		 * end up here and try to allocate a prealloc state and insert.
+		 */
+		if (state)
+			goto hit_next;
 		goto search_again;
 	}
 	/*
-- 
2.47.2


