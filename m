Return-Path: <linux-btrfs+bounces-6659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDD893A3A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F301C22710
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863715749B;
	Tue, 23 Jul 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvH3k+GV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443115748A
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747768; cv=none; b=VqcWLJqvfmKe/TnA6r3QnJwhK41WXebsbzSYAgxrwJZDrfMTsZzX61IM+zn/F4u8vNMK7FSdx4C6VwO0REJTQ1dJ6yZl7H+6Zyigo+yKp9vkwDYpz7evOmxGGwXV1j5KA/kC8W9YWxyPcqVf8xWNmAIyqOYxfaI/FiE7v2GQqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747768; c=relaxed/simple;
	bh=CPQ4k83YDQYEdiW+eb3BYyUXAhOBJshiRY5pdCNLdL4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CC69HPH9mtDRJS5skXqwUh7WcpGLfZB7E6AHW1YV8Xl4qAmHMOpCI4tp3vMWN0qruZ2/OQOJLvGfwxCwuhYxv/jHGAcz8OSXIHixYcTNSiNikg+XZJ7UMPGm8uDC0I0Y6/CQ6KM8Cm4biIc4lSsouTZo+NA6YtI4NbypKCf3ajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvH3k+GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2A5C4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721747768;
	bh=CPQ4k83YDQYEdiW+eb3BYyUXAhOBJshiRY5pdCNLdL4=;
	h=From:To:Subject:Date:From;
	b=NvH3k+GVp8PGhkXYWzIpAbj0JLbCcRZ+2Bi7IJjSQcb3NhokA0Tj6MdmcqajU8Qkn
	 n2SCnlkRNem/sNdkeZDm30hfBZVxv3RyYVAl3zcsQyaloaF6PstI832lFEAKleb6MN
	 TsBmjA2u8eWtMMPglbsbWjeh7LuxDyOfSU7dh8cpHXKFO/yaR7DRerMh6yIiVIMaMY
	 6ICBOpvBf4V9BFztfc6jqtXQ5vOTCqt8f8ksexQsQwn7jfGJ/HzZVcgARbBdTJ18wa
	 B02lFys6w/eIp5pMwKYM7VgfiKsK2srsQqJCqx6BIek9+c0zkpEWsAeOHiPT7d92qU
	 EA5DiW7jCHHVA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reduce size and overhead of extent_map_block_end()
Date: Tue, 23 Jul 2024 16:16:03 +0100
Message-Id: <9003408d1f29de77deef59c6ed6e5bf1d98b91ab.1721746528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At extent_map_block_end() we are calling the inline functions
extent_map_block_start() and extent_map_block_len() multiple times, which
results in expanding their code multiple times, increasing the compiled
code size and repeating the computations those functions do.

Improve this by caching their results in local variables.

The size of the module before this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1755770	 163800	  16920	1936490	 1d8c6a	fs/btrfs/btrfs.ko

And after this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1755656	 163800	  16920	1936376	 1d8bf8	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index f85f0172b58b..806a8954b3d5 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -192,10 +192,13 @@ static inline u64 extent_map_block_len(const struct extent_map *em)
 
 static inline u64 extent_map_block_end(const struct extent_map *em)
 {
-	if (extent_map_block_start(em) + extent_map_block_len(em) <
-	    extent_map_block_start(em))
+	const u64 block_start = extent_map_block_start(em);
+	const u64 block_end = block_start + extent_map_block_len(em);
+
+	if (block_end < block_start)
 		return (u64)-1;
-	return extent_map_block_start(em) + extent_map_block_len(em);
+
+	return block_end;
 }
 
 static bool can_merge_extent_map(const struct extent_map *em)
-- 
2.43.0


