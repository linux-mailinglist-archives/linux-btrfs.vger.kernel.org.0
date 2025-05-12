Return-Path: <linux-btrfs+bounces-13903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC26AB4165
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB65461526
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77A297132;
	Mon, 12 May 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2rSVFbm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61B297118;
	Mon, 12 May 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073043; cv=none; b=gjLxA3uToRyyFKin52q28mm2H0glXxo+iPIIZe9g8HBcNm/E0eqonovYT4bexn/L+N5Jx1b0r9SBbgE1USQwiqFG0CpoE6RYzlWji+/+ez7V6gFAMXmWpFRQScyD2rb9xSMPR4d9bi0i1/WgKnDHWCoHMWB0wpgk/NlnaRXA1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073043; c=relaxed/simple;
	bh=9Y3YEnLLJXEj8uwqZEJhtuyKzP26zmYEx1wU24ofGj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uO9Q6nU0vtOsRKftS51R9FfNuabUwS/xhkneqz6FfwujhkzJKBY4zQ1NzqrPnIJG1jX9yP8Y19D/7FC+bzqLNeKOogmpfsKqlwLirHTauA0a49pJOG1KE49+mUZX33kVDETpVFH+kx19uEDcvsvIhy96Y1T3RyJ5qrLjlbmSVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2rSVFbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118B7C4CEF2;
	Mon, 12 May 2025 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073043;
	bh=9Y3YEnLLJXEj8uwqZEJhtuyKzP26zmYEx1wU24ofGj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2rSVFbmY4QY55ZBjYix2kfitkV94Buycu8pnycBOsrspjnpYmzhe8gx6JBryjZWV
	 MyEMswx+N6l+MLCyfdkc14OpxlFIjcx3cVpIrZj6sNCHlJNk0yWXHRMCKm2KM6QVDx
	 jOsforTezXUuOrAtyYCIxD1S7PZVNlRLt8InChB34Grz9kg+OVkkWoKFQ+VkeWbTXo
	 /2C3Mm6ZjtxNFb8YFYN+ekz9td0Ix7A7srV44lM83KUunCmY6eYYaKg8TL1UF/5u2z
	 od+PBMCpQwt83n8YILBvjYNZtg8iHST8MDSQPPRgELJw6fZLVwguV5w8ZdXCkDWr7r
	 LPcO0+SYIOtnA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 04/15] btrfs: compression: adjust cb->compressed_folios allocation type
Date: Mon, 12 May 2025 14:03:39 -0400
Message-Id: <20250512180352.437356-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 6f9a8ab796c6528d22de3c504c81fce7dde63d8a ]

In preparation for making the kmalloc() family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct folio **" but the returned type will be
"struct page **". These are the same allocation size (pointer size), but
the types don't match. Adjust the allocation type to match the assignment.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Kees Cook <kees@kernel.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0c4d486c3048d..18d2210dc7249 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -606,7 +606,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	free_extent_map(em);
 
 	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
-	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct page *), GFP_NOFS);
+	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct folio *), GFP_NOFS);
 	if (!cb->compressed_folios) {
 		ret = BLK_STS_RESOURCE;
 		goto out_free_bio;
-- 
2.39.5


