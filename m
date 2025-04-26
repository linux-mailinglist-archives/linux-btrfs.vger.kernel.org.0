Return-Path: <linux-btrfs+bounces-13439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64272A9D85D
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 08:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFC47AA353
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077151D5145;
	Sat, 26 Apr 2025 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etztu5+L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CD1C84B1;
	Sat, 26 Apr 2025 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648614; cv=none; b=NPv2S10N42An3d0ca5Nc2hsbHprkI0zsFv4FWszXRsA74qvJJZyuftUqpwsLjmNdo3K5y/PvNp3j2N1q8bIuaobpi4PXky4nVoM2RcOHtXJkog9LSlvLIfXgERrO4e341BQyfzUJ5tMr7nzq30XLERW9IIGiQSQOL4vBYQPAGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648614; c=relaxed/simple;
	bh=cN6WruZl3z/tD9xXqhHwGHaI7t8uHPD25y5CwGYThTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRhTQuQQHRgSBWbhdH3yLpi62lb/NWhiSRf8y+XVv2L8uWEw/SgxgB7P3N71qJ5e//QB9SRJJdkPid/S0BzQQUxybZExACuo6u6GSqG34KiwC3bQgHpN3R2x+n7bf7WCW4oUBoMB+wXLmsOClTqYnvyNHjpcGMQkcac72y3v6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etztu5+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E4C4CEE2;
	Sat, 26 Apr 2025 06:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648613;
	bh=cN6WruZl3z/tD9xXqhHwGHaI7t8uHPD25y5CwGYThTM=;
	h=From:To:Cc:Subject:Date:From;
	b=etztu5+L38oXj87c5ZgqdZ8XjC0BcT/2j3vtQpq+yB9P4uUui0qKn0JKgiHHgfn/r
	 jwy7rvcXyjW3ACc5/vlQXpMVJTQQhKVa0nyK1TDpIFJtGjuq2A/yAYC/IxSF+H3dBX
	 24EJoHNObI/S/FVswmVPuetg8oP/jv3sOyNTzfxJyeymtS3WO5Qa1u1XUnClbeRwR8
	 plCsbUdGXTBRJxyouOx0zDRW338vXGdDR/koI05JCGA33ehsua8aJ2gpZVudnzezb1
	 nHiW16y1RRdnDEMCoGweEsRmxXWtFu25kuEioU92Ctj+KAmXGm9cK3HiUSSbH5rdmb
	 Vcbx31Su7MiXw==
From: Kees Cook <kees@kernel.org>
To: Chris Mason <clm@fb.com>
Cc: Kees Cook <kees@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] btrfs: compression: Adjust cb->compressed_folios allocation type
Date: Fri, 25 Apr 2025 23:23:29 -0700
Message-Id: <20250426062328.work.065-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=kees@kernel.org; h=from:subject:message-id; bh=cN6WruZl3z/tD9xXqhHwGHaI7t8uHPD25y5CwGYThTM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk81Q/LzGZt04jxDhZzKZmiq9+24Phqq+8GhmarXous8 Hkw+aRVRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETKmxn+J1t9fnEyctNMnjV8 c3+fE5Hb3iXyNuc3l9N6l5C2f11Gxgz/MypF7X/WtN3blSt6S5FFsD3oajn7we8doaYF7NsLFv1 mBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct folio **" but the returned type will be
"struct page **". These are the same allocation size (pointer size), but
the types don't match. Adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: <linux-btrfs@vger.kernel.org>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e7f8ee5d48a4..7f11ef559be6 100644
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
2.34.1


