Return-Path: <linux-btrfs+bounces-11583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFCA3BD50
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A60189C8BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D621E0B67;
	Wed, 19 Feb 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKwVKqB1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3851EB1B2
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965429; cv=none; b=ddsplmmwgxEA4O7ulL1mgiZaU3tzOG9M8kqwTAbsiZUGTr0bJHuNX8ChfkgddWADjmxfJjiOkez19qvMyZN0s25GgvgxErj3/p7Mnoa1+dbDBW3r3NiVTUArQCS+T+gI7wZnG9PCekHqcz2kRLvRRFhWKMrrak7M6BwQhDRJ7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965429; c=relaxed/simple;
	bh=Wyd5Wd89gnJUPIDlPqkGSgkK7n/wp64eKpdAMR3Jnzs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7c6jE0pBKnaPdKD6+GzyK/4r5gs/EcGA4MNBWnYVYpqU9LwfrSPZhobMXsmewDPwCfhpZWTyHsA1sSsNgcx7hadrs4uubBL6e0XOTBixGRsEJEnCaYeAtXuufYYBGxhKqwCxLkeh/qlNyy8Grll2flBKHCBDDozkO8M2RgP7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKwVKqB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319D0C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965428;
	bh=Wyd5Wd89gnJUPIDlPqkGSgkK7n/wp64eKpdAMR3Jnzs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cKwVKqB16hcistaQYHW1acEd+hOyx7rv7cIIRn6tup1YE7HjQfU4MafD5bsHCnRCm
	 5KhjBqDeKcTJzJUKQBvOPIVlwa8abEmzAkSq/BnvsiR/nt9OJC8r3WN8qloqPH110o
	 PdCncs7Pew/weFJXlmIj3tVO/G0psx9Xnd2L8AAG5VdHwgr9jEYEfz1ebtRS6NyUzO
	 Fm5rtrxh1QWnuLRKZJQrnc8rFMr4Gw3xqJKonOlbBLK6lAIq+DsH3u67IV/aF2G8bn
	 giY9BEkbYE/Yc0WIxQigMwu0oqjCmNNN+rrCdSzGUdvTRSlVIBuhdvabP4fi548FI4
	 FIWmdURN/1ZTQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/26] btrfs: send: simplify return logic from record_new_ref()
Date: Wed, 19 Feb 2025 11:43:18 +0000
Message-Id: <7cacb1e6e74eaaafa92656b35d6ea00fd0fcebbc.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b715557ec720..181a234e3a5e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4746,11 +4746,9 @@ static int record_new_ref(struct send_ctx *sctx)
 	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
 				sctx->cmp_key, 0, record_new_ref_if_needed, sctx);
 	if (ret < 0)
-		goto out;
-	ret = 0;
+		return ret;
 
-out:
-	return ret;
+	return 0;
 }
 
 static int record_deleted_ref(struct send_ctx *sctx)
-- 
2.45.2


