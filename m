Return-Path: <linux-btrfs+bounces-4481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053AA8ADA99
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E84E28289E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BC1836F7;
	Mon, 22 Apr 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6B+mRdf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF621836DF;
	Mon, 22 Apr 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830296; cv=none; b=U5fGfIsi+pwefqB8nUC8BOTkREKHXCCqDM4BTqQ/5SnbSX1/KBr//9c9rq3yqrOoMHvrCqrKsskWTCTXK/BPBlpQEWLn5MgboG2s3nk+nap1OJ5q3y+ITqjMqPXapgsZoSbdj0HBK9NenAABi6PuO3u1zP9hVmvfX7/avlxZAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830296; c=relaxed/simple;
	bh=kADEmfIFSrsHC1aEzLc45zJZYFz57p1oEd6NRAXZ/jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/Vlze659GP5yw2qT/IDdlzaCsLSjwD3cMRQ7Drt+z7Me7igKecaV8q1bh9K1sBotmNVCOR5f3yLWYW2T/OH009b6+3XfUVo3I98fDxSYWQ+ytoJ17xSQLT0J3I7OsytNwykvWkbAZ/R1gSLpfA+pjL6psjCoC5YjRbGx0886B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6B+mRdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89802C32786;
	Mon, 22 Apr 2024 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830296;
	bh=kADEmfIFSrsHC1aEzLc45zJZYFz57p1oEd6NRAXZ/jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6B+mRdf+yvpzjhZ0uDcQ1btCJwzIR2Vc/PZLPISrsomDUWb+Aq88vGUlw/iN3wDf
	 Jkp86WIIXSmn805StgEQ1kW6wwcu06i2t0g7jmmlAeAj26IChm+q092jltCHZGJtq7
	 baa6BqL0N3nf8SoWWZpD8VP4+eIarMjfXuAlAVJTbQP9nnPfGtVrcfXDmiyON+0z29
	 LlMmMUdM7q32L4OgtrU/66bzZz0yEEOoG0wUHvhCyxdcUgQMJ9i8x9dPAtVAwZhDOZ
	 ByKssWfUEfBtFoO+AZy4YXmhW1/HsV8fPlzTg10oLAvkKW6ZWXTTgjHFxuUqc8BfZV
	 eU7vA20EN2JCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/10] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:19:17 -0400
Message-ID: <20240422231929.1611680-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 6e68de0bb0ed59e0554a0c15ede7308c47351e2d ]

It is possible to clear a root's IN_TRANS tag from the radix tree, but
not clear its PERTRANS, if there is some error in between. Eliminate
that possibility by moving the free up to where we clear the tag.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 99cdd1d6a4bf8..a9b794c47159f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1424,6 +1424,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1448,7 +1449,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0


