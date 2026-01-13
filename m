Return-Path: <linux-btrfs+bounces-20454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4E0D1A6B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 17:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3632D30609A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BAA34EF0A;
	Tue, 13 Jan 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkQ8Rc1X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5234DB74
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323065; cv=none; b=Jnhm70bvCZMhPkGX8o+7pQkcrSQni9g0V9pJHU/i0WrXjZ9A7fSwpU1yzzRHeWbm9AoYIY+1I3HpjyHevucRRMVI/S4p8PR3Dv+WZViQobe/wFTmzWMFxTcqGcTwkMtHti6q4vrRWb+i5FJnBPHQGkJHQRwCWG9yKwd/hUhW1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323065; c=relaxed/simple;
	bh=NgXiLwGnnJlRgDz0OPH7yWbWv4dGYXu/3HCDVcLgNfQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmzH+PpwTLHj2Kq8wdz9Z+VS8szFbffrqJ9SF5oDl7NWbnmKGlxWYm5REO76w2gNZz4Xcn/CbCkLY1DJzH7w14muGu6aqI8dlKWU/GePoxks4nNY17YvH6U8ZmNqz7XzlTvpJrrMIMKuGIQYhPKpKCs7+FNcXQnKaywLZnvB6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkQ8Rc1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59647C4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323064;
	bh=NgXiLwGnnJlRgDz0OPH7yWbWv4dGYXu/3HCDVcLgNfQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nkQ8Rc1X5k0miExxdAKT0Ht2K6RpYI+2MCFRTGNaXxnpD2TLFYFuzSM7gcN3U6NL+
	 a6Dd9K5Y6uUSmYdzbrVgj8Ug7absb2UpmyU0i2YzJ4ThDkWI4JggQeBI48M019rJwK
	 yP3cNonEGhTDldpWkg2Cdws8ggCTX5K+DCVXzWgheDSAo0BmAN0H1juczgVPDbMza5
	 zMnaoJVsIMEtjvXnPLvVD71hoEjM6V5wPRHl+lyKrwPlm77QWNqWjQbsbwjIj+l+Fv
	 L9KbiIPx4juI8DsDTxlk/PMiXsddOLH0C7SSWLD3JYk8gVFEBoaT4MJuzlSg1alOu9
	 5scx5JMIiLD9A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: tag as unlikely error handling in run_one_delayed_ref()
Date: Tue, 13 Jan 2026 16:50:59 +0000
Message-ID: <0544cd360cab432f8becc3a235f2d6f6d302c89b.1768322747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768322747.git.fdmanana@suse.com>
References: <cover.1768322747.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't expect to get errors unless we have a corrupted fs, bad ram or a
bug. So tag the error handling as unlikely.

This slightly reduces the module's text size on x86_64 using gcc 14.2.0-19
from Debian.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939458	 172512	  15592	2127562	 2076ca	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939398	 172512	  15592	2127502	 20768e	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ffb62b58a919..01a796c536f2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1785,13 +1785,15 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 		btrfs_err(fs_info, "unexpected delayed ref node type: %u", node->type);
 	}
 
-	if (ret && insert_reserved)
-		btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
-	if (ret < 0)
+	if (unlikely(ret)) {
+		if (insert_reserved)
+			btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
 		btrfs_err(fs_info,
 "failed to run delayed ref for logical %llu num_bytes %llu type %u action %u ref_mod %d: %d",
 			  node->bytenr, node->num_bytes, node->type,
 			  node->action, node->ref_mod, ret);
+	}
+
 	return ret;
 }
 
-- 
2.47.2


