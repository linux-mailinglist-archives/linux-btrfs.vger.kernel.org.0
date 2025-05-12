Return-Path: <linux-btrfs+bounces-13907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F1AB41A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D817EE74
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C07298CC0;
	Mon, 12 May 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBzDKoys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99A297101;
	Mon, 12 May 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073071; cv=none; b=A4QcPGMoXUP3arceUP2R8TS7Dj8FZDQjfHN+aipStX/IgaZEMDWBLnCoVMXVj4s+5Kw4m+SfYmZsToq5G5GBoQSIJWXVo7ynR2KVwv5RyaWQ0wYRernDgXsCOFZo7Z0NjKPM6MVDB84G3TYbapGf3W1YzFA7+PuW2sGAERRiru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073071; c=relaxed/simple;
	bh=6yGGThJp/v6xWSh4vMlnt3kWtvP0zME5v5Q+cE7cJYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F7FhWVz8ug5SK9Ac/k3P0m4D7edpiMHgOm63TVFohS/GolCLwL+BFG5kVmoXtRLu3ZMpOaus8j28AVp4u8q/SZLJzGHhahMqCryKBqtc+PCtin0Ss9hSzfZtX4jRDwQcUoZilRiP7BLx6ujcKT6ziTI1o9PoQanzOQHU5Qd3RXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBzDKoys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6436DC4CEF0;
	Mon, 12 May 2025 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073071;
	bh=6yGGThJp/v6xWSh4vMlnt3kWtvP0zME5v5Q+cE7cJYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tBzDKoysDaTnoV5UXhZJbwHZw5RlI/kinmKfvVPTX8b07k2Ok5QaXZUhzHQ9KSDPE
	 ySY/5g4vUj4qv2mhwz3xBIkYD7fK4sQXSOUKV0kYAPonGQ+c2P1XZDXmkra8Rc3H5k
	 uQPPT0KLIYK7U+qeayTxhb727L+6q86HhjJ5n+io/4kRmFdZlaCjM9g34IDaSF5WxI
	 W4aaDH3WgRWqHDJqhmq+xfT8d7SKDdW167ccA2UxjyY3foriuXYKgr3JcMgQ9t80it
	 r2bc4Eppfs8KzdgukBLxTw58h/5MwcvjVCn6g2fk2oiwKxnRwpoYXkh00uO1i1fgq5
	 vbyhr2zWM+dTA==
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
Subject: [PATCH AUTOSEL 6.12 01/11] btrfs: compression: adjust cb->compressed_folios allocation type
Date: Mon, 12 May 2025 14:04:16 -0400
Message-Id: <20250512180426.437627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.28
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
index 40332ab62f101..65d883da86c60 100644
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


