Return-Path: <linux-btrfs+bounces-13312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F1A98CBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077A61B6562B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFE027FD67;
	Wed, 23 Apr 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJHSan8w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1921280A3A
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418022; cv=none; b=SbnqbBQhMeSGFbCPkqB257yqnmhzTo6vbgpwKReVl1Hz5oM578KLgvv1NFtmcW14TVeiARJJLJ2poDHUDswva1RG3uYhWaUV4H4zNULnqUDLEiq748uP2f0vCg0QTy8T23/Qb+InqYpAxO7Exy/UKo4M1GvCI9Lq5t0NnQZK8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418022; c=relaxed/simple;
	bh=YGNcwd8JZbsEys+BN1ybLVMk/g3mC1vT6ysWgfXg4Io=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UgXo4LMG3ABa3QnbDULyQ5YnQH2cu0G7wKmxiFncMCRF7LcaPMkRNd/nJ0aZ6fNjg5nIxmMHQM3BhZ52EaLyGdUW3oUXlIY6ix6Em7FpUu8g+aIVYrjW7V0gT2L9JCu67s/D0ECbcdM2Va1QfrmghtnLSWoGKFZL7u68DG/vqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJHSan8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05417C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418022;
	bh=YGNcwd8JZbsEys+BN1ybLVMk/g3mC1vT6ysWgfXg4Io=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jJHSan8w8MKxRlC3eeWMOxHV8aA67rjB8dsNn9dKZrIXiqw7A8IN6OZi9wDj8krwN
	 b6govh81R8R/lAPkaG/mFJHZyD9TNuv2MIorVe4CKqS63N4r/QJqpedjp0jieo+9Ri
	 eJ+t3S7qVd2z1gKASoOEyKxCaKw+5YgPuJTcDws40M8TW05sqJ0dyTEwPaLLTYQLt3
	 Xq9rwicS/G+ClgYPkLBr+6kX/w5B/WGQt5SCFKrxsDuFGKAqV8TbWogszbsKzIcPXg
	 fpm6RF3OP+WVRfeiHX6Od8L8AFLuwMXXI51dGFVz3XVJUOAYL4czALVuWTGhgkdWRr
	 9/G2gv3T+G/wQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/22] btrfs: simplify last record detection at set_extent_bit()
Date: Wed, 23 Apr 2025 15:19:56 +0100
Message-Id: <4da6b53a233ddb1582e4a896f4ba8dccbff2e87a.1745401628.git.fdmanana@suse.com>
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

There's no need to compare the current extent state's end offset to
(u64)-1 to check if we have the last possible record and to check as
as well if after updating the start offset to the end offset of the
current record plus one we are still inside the target range.

Instead we can simplify and exit if the current extent state ends at or
after the target range and then remove the check for the (u64)-1 as well
as the check to see if the updated start offset (to last_end + 1) is still
inside the target range. Besides the simplification, this also avoids
seaching for the next extent state record (through next_state()) when the
current extent state record ends at the same offset as our target range,
which is pointless and only wastes times iterating through the rb tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 1460a287c0df..1f3bc12430aa 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1123,12 +1123,11 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		set_state_bits(tree, state, bits, changeset);
 		cache_state(state, cached_state);
 		merge_state(tree, state);
-		if (last_end == (u64)-1)
+		if (last_end >= end)
 			goto out;
 		start = last_end + 1;
 		state = next_state(state);
-		if (start < end && state && state->start == start &&
-		    !need_resched())
+		if (state && state->start == start && !need_resched())
 			goto hit_next;
 		goto search_again;
 	}
@@ -1180,12 +1179,11 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			set_state_bits(tree, state, bits, changeset);
 			cache_state(state, cached_state);
 			merge_state(tree, state);
-			if (last_end == (u64)-1)
+			if (last_end >= end)
 				goto out;
 			start = last_end + 1;
 			state = next_state(state);
-			if (start < end && state && state->start == start &&
-			    !need_resched())
+			if (state && state->start == start && !need_resched())
 				goto hit_next;
 		}
 		goto search_again;
-- 
2.47.2


