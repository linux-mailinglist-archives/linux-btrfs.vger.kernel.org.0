Return-Path: <linux-btrfs+bounces-13309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF68A98CC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B1144648B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94A27FD5C;
	Wed, 23 Apr 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvJI1jVg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EE27FD7D
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418019; cv=none; b=lFNhYsQ4K8B9Dkq4elHR/NOqQNNzKozxoteGObrTZBCl3MahmEAR4mERQ4ehNh/TIlmYaUjsOvoyKHOSywgFPRBrwQBGQIK3sJdsj6rRAODPGW57YTXyPitIstwpop1NnIXymtjArftbwRnof/hQePXuOES6lezjhL1fwUPcnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418019; c=relaxed/simple;
	bh=nRRhd6nrRPNrX2Ke5AENTzh1vaSkqwJ/RqUpt7oTsbM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ahx1vfDqX33KT/3aeIbCq4ACZYzIDX7LkGNAmOGFkYy5AoZ/k/gaVh5irkZPnlsQa04iQfzkcx+8Ix3l3TI1eGhdJldjRS4DxlTv0IIO0rJ4zavaUCQ9tAxGYJh2l9mYZTj+rwLQqCF4Mu65yKgKMZsktcjmFfghS2hh3cIFMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvJI1jVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB404C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418019;
	bh=nRRhd6nrRPNrX2Ke5AENTzh1vaSkqwJ/RqUpt7oTsbM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mvJI1jVg2A1h+M8ySfm3Xfpik9QAX2odB5mUPOxsW1djBA785hgbwDeTKxnP1pZ2M
	 /8g+V9V+KNhYIEidp6evtRMOo4YCSJBhN0iu+Yylh0AUnx7FoCa8+LkwBfZSwZhUIw
	 n/1xayLFxWXWOa81qzAFTLhpiPD+zmXngqIRx/IqsfW5qQn7AUfv9EhCFR+TTu7+tW
	 qE0Q6NNM7xDGv/vxXswnLfVazOL6bakjGDuNFK9Xi5a0Ead+xcPtr0GnXQahzGX+HD
	 g696ArqRX7EtG8QE84v+A0xaaf+/ZW5/GVmyfwnidqBDpaDlkSCqrCnlgkxafq0Bzu
	 zMjv/5dXiO6UA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/22] btrfs: simplify last record detection at btrfs_convert_extent_bit()
Date: Wed, 23 Apr 2025 15:19:53 +0100
Message-Id: <8ab91642f04bbe97df7891e9864be7d2378ad4ff.1745401628.git.fdmanana@suse.com>
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
inside the target range.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 65665c0843e6..453312c0ea70 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1370,12 +1370,11 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		cache_state(state, cached_state);
 		next = next_search_state(state, end);
 		clear_state_bit(tree, state, clear_bits, 0, NULL);
-		if (last_end == (u64)-1)
+		if (last_end >= end)
 			goto out;
 		start = last_end + 1;
 		state = next;
-		if (start < end && state && state->start == start &&
-		    !need_resched())
+		if (state && state->start == start && !need_resched())
 			goto hit_next;
 		goto search_again;
 	}
@@ -1412,12 +1411,11 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			cache_state(state, cached_state);
 			next = next_search_state(state, end);
 			clear_state_bit(tree, state, clear_bits, 0, NULL);
-			if (last_end == (u64)-1)
+			if (last_end >= end)
 				goto out;
 			start = last_end + 1;
 			state = next;
-			if (start < end && state && state->start == start &&
-			    !need_resched())
+			if (state && state->start == start && !need_resched())
 				goto hit_next;
 		}
 		goto search_again;
-- 
2.47.2


