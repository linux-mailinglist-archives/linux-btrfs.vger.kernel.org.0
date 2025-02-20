Return-Path: <linux-btrfs+bounces-11653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C141A3D7C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28C617CBCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4C1F4610;
	Thu, 20 Feb 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCAMJgCA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CA1F4604
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049506; cv=none; b=WuCNfXjv+GjZSGl4fzQb3MLFRV/wgAVxQ9SoEBDeg4W7SgSzU/8TuQChLHiqBM7p9vblvee8k80x6332F9ZJdbFnYLa2K7TSMcSbTqnjTBxWK81xZIOiFF6zR1RPxXrdqndKg9z5PtJY9SlPY+Qgvz4EiqwEaNvJ9nd3i+KuPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049506; c=relaxed/simple;
	bh=Wyd5Wd89gnJUPIDlPqkGSgkK7n/wp64eKpdAMR3Jnzs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBfqOkBZuqJgkeovEpTXo668rdbknBxtriDJynCXmUfgo+arp5n3nq7RIBkGKNIN2T96gYLudo9A0D/oOaXLczTi1l1E3qyxXx2ztnajXjzVpCRdyrb+G9cQK3PNUh7L/KE0/KBpKMXpT2MZ3+IjjHmzBSW7ez2Qjwx4c8oziSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCAMJgCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AECEC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049506;
	bh=Wyd5Wd89gnJUPIDlPqkGSgkK7n/wp64eKpdAMR3Jnzs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kCAMJgCAL1OGHn/otgY1v8GuS8ZK+7wmSkWzL3yacAhQUmID8BVo1t+sJ6N85xdyV
	 EAAFkevTge4IXYRz/b/P9IyxY7EgFqFtcmzVt3Gav7E4rjqMrJ7glVoTEqdxhgFdY7
	 0O15QG/L7z1Xn6Y/jDifZVZiWINFMPy94X09YAyA/b3ZCYi1BsbDP1GbrRRCecD85x
	 v7X3STxxOP4lR+s8g/cO7QQf8jFIjEIpJSJi5cQvOL9/HHv8gRH1ex73hOaRXo+Ej7
	 +ln2bUryQBsIdjHPNsmD9IAjHc6W8HQyjmBXePL3Yywg3GBy9D1UPLnK+f+fDlfOa/
	 zhOBvUHaVG1IQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/30] btrfs: send: simplify return logic from record_new_ref()
Date: Thu, 20 Feb 2025 11:04:31 +0000
Message-Id: <56ddd47f9ff5493137cc6ec668ff7b97413068b1.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
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


