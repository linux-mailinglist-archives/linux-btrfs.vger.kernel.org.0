Return-Path: <linux-btrfs+bounces-12755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF176A79182
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51197A358B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137723CEF8;
	Wed,  2 Apr 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ/pMfgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0023C8CC
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605659; cv=none; b=jxExqnOfqYtp+1aijlLA5wL0xiVzyEB78CWMQu8oZu8FMflqxg2ZlwcyKFB16AXYkTbpmIdcUDFJGsebpJ9FQasu5GkZPYb+pcjUEkneGx4C1zPHKlpJI8WmOlRwL11ZVcDakQqYFnfIcRypQ+Qf1i7G844dXpLOCteVonehH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605659; c=relaxed/simple;
	bh=qoPaV5QdIf7LLDf5kvIo+S19fQ80L0RJa7HzjpxuBno=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpRL0dJA+CNX2dYdRF4e82IcSoEGyMDTXiDu9paxfu8wTVgmz8pKiGU4G0YSUZzx1/iFlOzY3UBXEhAYF9GPikD/fEVTxQw6DOOaSXatsBUQwDMymJqJ3xQ3N1lLJkzEtFXIQDbTnjA5XK3gtFyk4K63hxpEM3GA47ymTuINzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ/pMfgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCE4C4CEEA
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743605659;
	bh=qoPaV5QdIf7LLDf5kvIo+S19fQ80L0RJa7HzjpxuBno=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZQ/pMfgl8xzR7H451jjTvfQJ5VoSKfdo75tooKFTRZeXUi9koO5bANhvoOugyMYzj
	 mYhxoxxLZIm+sYlKDsxWWW7gD+MM4JWL7mQYQsiHTJRJQZV+3u1bYw24y4hiKMzlzG
	 MCIJYxa9Ieszm+13MXzYsr7QXIL6cnaHZTZR9Cw2x2e9Nu6GXu480J7YtoaTz0blpr
	 Ljf18g0EUS0dZZNFFHMNmQUkkwapbSzGqwkW5YCLnvTVbNAo9zU2bqq0OVhrBlk6ci
	 VmdRrtmvr5TwbZkE2ch0bS+YbBJieX6aTyNWNAa5Y78RKajMnTptiySggi3zMyoTa6
	 q2j+9fSrzPbcw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: simplify last record detection at test_range_bit()
Date: Wed,  2 Apr 2025 15:54:11 +0100
Message-Id: <53c0bc370a45abf176ec74d1257f66cbdfdb645b.1743604119.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743604119.git.fdmanana@suse.com>
References: <cover.1743604119.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The overflow detection for the start offset of the next record is not
really necessary, we can just stop iterating if the current record ends at
or after out end offset. This removes the need to test if the current
record end offset is (u64)-1 and to check if adding 1 to the current
end offset results in 0.

By testing only if the current record ends at or after the end offset, we
also don't need anymore to test the new start offset at the head of the
while loop.

This makes both the source code and assembly code simpler, more efficient
and shorter (reducing the object text size).

Also remove the pointless initializion to NULL of the state variable, as
we don't use it before the first assignment to it. This may help avoid
some warnings with clang tools such as the one reported/fixed by commit
966de47ff0c9 ("btrfs: remove redundant initialization of variables in
log_new_ancestors").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 18b10e7ed815..b321f826d008 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1790,7 +1790,7 @@ void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
 bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 		    struct extent_state *cached)
 {
-	struct extent_state *state = NULL;
+	struct extent_state *state;
 	bool bitset = true;
 
 	ASSERT(is_power_of_2(bit));
@@ -1801,7 +1801,7 @@ bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 		state = cached;
 	else
 		state = tree_search(tree, start);
-	while (state && start <= end) {
+	while (state) {
 		if (state->start > start) {
 			bitset = false;
 			break;
@@ -1815,16 +1815,11 @@ bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 			break;
 		}
 
-		if (state->end == (u64)-1)
+		if (state->end >= end)
 			break;
 
-		/*
-		 * Last entry (if state->end is (u64)-1 and overflow happens),
-		 * or next entry starts after the range.
-		 */
+		/* Next state must start where this one ends. */
 		start = state->end + 1;
-		if (start > end || start == 0)
-			break;
 		state = next_state(state);
 	}
 
-- 
2.45.2


