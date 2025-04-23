Return-Path: <linux-btrfs+bounces-13314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D258BA98CC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D9418812E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408D280CCE;
	Wed, 23 Apr 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORnU310X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED7280A33
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418024; cv=none; b=CG5iRa1Ffz0+LJuYNqQQXJMq9uDq2Uj0DsdO1rrgrsSKMWnH0fizFFmZMgn/BISoJLlSxaWxra2Gj6VOayN/nMMD/lsgBV9FnCtycBZl9KKdCU1wZrN5tAc15cbcdSrzcE+pyQp2iw7ap1Z8CzF4s4gNKy597XuUy6vIC8mESFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418024; c=relaxed/simple;
	bh=mRc7eNG7XC94/AMSCo+Xu/w/Bwb5d4/Ru8spmb8rv2k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hioZDFyYxePh1+zmt7UEA3DE6j+MfkSIh9OgHlWGMPlH23AbX+mf2wg8LwFEVZz4z+dVHaGaD9mNEuTUzqnS7d4WEH3E5eudSCIshj9i3T3pNYXWzl5j1LJBd45wjriJBUn4N/Mfz344nb7fVdFJs0bFyDRsNYJ6VsrqQV5KuOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORnU310X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBB3C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418024;
	bh=mRc7eNG7XC94/AMSCo+Xu/w/Bwb5d4/Ru8spmb8rv2k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ORnU310XoxNS2rDyB6W6CkScyLBM0iFuzNSDgTd4t4xm4gMd6OkGmD0Y5YiF0S/ZO
	 SMj9+XeKWxMVlPchNM6+bRi8rou9T3jPcUXwmVnyqDt/+/We6ojEfsC4LOfGCDfMM2
	 9fwcs+WaedW4rRh7fq1/Csz+Y4oTgb4fb1Z9Y221tSxdIzNNAbtDOYVRWeF3jdTnPj
	 6NgFqIDwx+hFaR8s1fGZc/BbIKtLMvv6IekC2ruv4Og6lyBEyAW0eufcviO9auxHf0
	 BNsZkkfipkj51gz1TJ5x7qQ6qAbaxlaDf/zY5yr/+Qy0Y34UePiunAXekqSqepYVxt
	 9O47aNRepUf7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/22] btrfs: avoid researching tree when setting bits in an extent range
Date: Wed, 23 Apr 2025 15:19:58 +0100
Message-Id: <f525cca8905cd4394f681eea4f005e2ffd887510.1745401628.git.fdmanana@suse.com>
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

When setting bits for an extent range (set_extent_bit()), if the current
extent state record starts after the target range, we always do a jump to
the 'search_again' label, which will cause us to do a full tree search for
the next state if the current state ends before the target range. Unless
we need to reschedule, we can just grab the next state and process it,
avoiding a full tree search, even if that next state is not contiguous, as
we'll allocate and insert a new prealloc state if needed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index ea974bde11dd..7271d6356c32 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1223,6 +1223,22 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
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


