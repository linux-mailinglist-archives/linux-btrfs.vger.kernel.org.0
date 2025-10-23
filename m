Return-Path: <linux-btrfs+bounces-18198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E5C0247A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88DB1AA26FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34324278761;
	Thu, 23 Oct 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdYERx80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A226E71C
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235216; cv=none; b=aweoYDGWyl7zCgCKJe9edMCHAhtfys6PwPjI8tmrjaAGgRmZX0+FDwIHc3r4i6tSDeQ9CRif1KD5jKMmWkonefdU+R6hRliIm0/fXAWE89afgwdu0ObwIryjuk/xxxS3hm0Rudc1CwXHb4LH7vDD9wc2Jx/RktOvKlBZ4FYvaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235216; c=relaxed/simple;
	bh=/LgAz/Y0F/YPsjReM2gBtYRAs0xADjfTl4FvJJ2T/EA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puCW3sNFrMp/daLnDeCQ2djssvELqx5V68b/zeMGjoKLzBt2aXSQyxPVYyHxqJ0bB6wGq6QORJ409anKMtHq9iPEQDdvQGJPrIFy+LExF3Z6iol0945vm2dJrjnmvQGy88RI5FUSxvUKLdSrS3HPxIvaCJQPAn3QdM/0DtyMca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdYERx80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8212FC4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235216;
	bh=/LgAz/Y0F/YPsjReM2gBtYRAs0xADjfTl4FvJJ2T/EA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JdYERx80Tolr316nzmw4tKJMPiQdY7zYO7sYY6EqxGcuEhAttMy8H/RyhCZxu4jbI
	 gkZClHm4J8lHsDa8ZnWhIQvN8sjMVwGSec/qQfLrLbBg7581CJhj37ZrxRFTn8qTRt
	 CSAJDSKB/ZmmxKJjdGKfvW3xa/xXfLuha5SmlIrDsppxxMBgN8TDxnIiajnuN9zh1j
	 8bAEfGc7mORsQr8SDkuL8AQo6/f7JBfzJV3JfJrnGANjoSjPGacm9XCbSQTyOeSLUX
	 6J0T1Upw2Lbmbu+nTun2VAJE/fH0krgSPGMAGy+03Dk4MVcR/0oda7aBcf0rDLsiiI
	 8GQZgRxW+QrQg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/28] btrfs: assert space_info is locked in steal_from_global_rsv()
Date: Thu, 23 Oct 2025 16:59:44 +0100
Message-ID: <7e26b03a448778363bea4189211c5a01dfa0085f.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The caller is supposed to have locked the space_info, so assert that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b03c015d5d51..a2af55178c69 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1047,6 +1047,8 @@ static bool steal_from_global_rsv(struct btrfs_space_info *space_info,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 min_bytes;
 
+	lockdep_assert_held(&space_info->lock);
+
 	if (!ticket->steal)
 		return false;
 
-- 
2.47.2


