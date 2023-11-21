Return-Path: <linux-btrfs+bounces-239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E57F2E7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF83281475
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271EB51C4C;
	Tue, 21 Nov 2023 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG3sxitE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5051C41
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F631C433C7
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573924;
	bh=38lcGrYTqmycIpUJp5rPTN/gyCW4xVFDmcYjNAI3qOk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sG3sxitE+mw+yzYvu/UVBN9ncM2wk3/M+hw6FCVSolltJNQekeqU5291xkuRFu/62
	 Xo9oWu5AwGZVBCEIRKKyBZFyUKUQ/P+3OhH6xuJCgHbKimsnHBB88CQ4iADueJIvBe
	 kssdOjBDLe9KtqQgfQbnnF2IILLnDTF5+HD+kt4F1pwI3a4HEUrudkje6OlmziS0KH
	 JGC57DrxeK5A7ykRICLjS9dZ/XJjQiAFQNRNyp+eYhqTO0i0jWcFQ5S77UCrCg51QA
	 TiyWnGr0FiVCiBQ8BOV4WhSW0PHBOZ3XoW6fEhNPZrbV1y/4SRxBjg24fH9rNvcmF0
	 m6UJUkGOQP9dg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: fix off-by-one when checking chunk map includes logical address
Date: Tue, 21 Nov 2023 13:38:32 +0000
Message-Id: <db822a05a08d66879288a91f2186a0898dd7e58b.1700573313.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_get_chunk_map() we get the extent map for the chunk that contains
the given logical address stored in the 'logical' argument. Then we do
sanity checks to verify the extent map contains the logical address. One
of these checks verifies if the extent map covers a range with an end
offset behind the target logical address - however this check has an
off-by-one error since it will consider an extent map whose start offset
plus its length matches the target logical address as inclusive, while
the fact is that the last byte it covers is behind the target logical
address (by 1).

So fix this condition by using '<=' rather than '<' when comparing the
extent map's "start + length" against the target logical address.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dd279241f78c..1775ae0998b0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3008,7 +3008,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
 			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
 			   logical, length, em->start, em->start + em->len);
-- 
2.40.1


