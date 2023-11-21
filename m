Return-Path: <linux-btrfs+bounces-242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2E7F2E7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E377B21C68
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE3524A5;
	Tue, 21 Nov 2023 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgSFxvKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5F51C5A
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271EBC433C7
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573927;
	bh=uhPLVsyl1/BwiVE4F42E2HQMoDjtF+iHhk+p6xUTiR8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fgSFxvKACTNxdLaf2kRYfRcAaE04GqjQrp1LmU8xtol3gqKDSOEgTdwcBQNitZpcF
	 AaBTOBSqClf4WwsVJdM/M7PEYOhUKaFgqj7LbtS2FjFqsgbTc405Rlu3CuzrSo1RiB
	 lTJsibSEu3QTpX3QnuVMkgSwz0Uac4cneEJGzr8UYdtMzJhJ6nlZCZYRkF33m79Y8X
	 4KAN8wqFgZuzxC4Hwq5LG9fjnYfHsBRCsY8ryYjf+5Kv4iIkqabgWsU7miwiiRDkiJ
	 zTQzTtcjGC39o2sWoMCs3L08dkaKbXtcB4xYOyaw5plb2Om1aTPVvXYV2ZAJ91nAzS
	 KH4MON2rxEPrQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: split assert into two different asserts when removing block group
Date: Tue, 21 Nov 2023 13:38:35 +0000
Message-Id: <8c8238bb0a638ecea8f27b9b2e4c6cc1017bd987.1700573314.git.fdmanana@suse.com>
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

When starting a transaction to remove a block group we have one ASSERT
that checks we found an extent map and that the extent map's start offset
matches the desired chunk offset. In case one of the conditions fails, we
get a stack trace that point to the respective line of code, however we
can't tell which condition failed: either there's no extent map or we got
one with an unexpected start offset. To make such an issue easier to debug
and analyse, split the assertion into two, one for each condition. This
was actually triggered during development of another upcoming change.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6e5dc68ff661..fca653cc977c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1303,7 +1303,8 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, chunk_offset, 1);
 	read_unlock(&em_tree->lock);
-	ASSERT(em && em->start == chunk_offset);
+	ASSERT(em != NULL);
+	ASSERT(em->start == chunk_offset);
 
 	/*
 	 * We need to reserve 3 + N units from the metadata space info in order
-- 
2.40.1


