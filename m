Return-Path: <linux-btrfs+bounces-15374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882DAFE337
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567001C4295F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F5280CE0;
	Wed,  9 Jul 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAvXGOIq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04628280CC1
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051206; cv=none; b=pV3W87dCstQNd+QG4sabweVbIB7lNFhdokOUyY7CwQSddSpmTv8T87W48idbyxX22KjkvMpyzTw7zsxVX0BUrPyvpj8fVNLIFI+OOb/oXkNGWpZpXGWLhLo3jk207MeBCaTq6q5t5k7pPd0vpEktUu2fOY1R/hIqk4W3EjxdPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051206; c=relaxed/simple;
	bh=rfb+XIpDOMdBrQjUf5aYC0AG2hiL1+2sPkjCXJznLzo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlZLMmsTGDU4GxihuWbr5atxSSqUnzDOQ+uP/HlxZbJYAIJrlWL6ZBj/4b2xdqJcxFE8SV3uRTsmCpgPor0B01afHBnlEqRd46UPmUE1N3mXpiR7mbJN7FpEkIudLMjJ1OnTM99YL0ekWmQIA/5rDIKFj49KHPIzd5faU1JRdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAvXGOIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1D3C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051205;
	bh=rfb+XIpDOMdBrQjUf5aYC0AG2hiL1+2sPkjCXJznLzo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cAvXGOIqLui9Jul85QOTA76y9PjmqG3cTcTgxJPVOmd2mswOBEbHja1fqxQEFIjlq
	 AzhaubRqu0JOiXbImxZX+rhdmwMRMBN2ol3FeqkQBtU99V55PjkbSxMnp1paVUNubd
	 EEkcVkDFh54lny6E7dLgYU0Po9DKFUXWWsym6pCiy5bdpp6uWvdyzkzmrqFQJ5IWDP
	 oRZBMf8whG+RFI8T5FAixjL9SuDre+xhQ+D4k32KksANgXOk2DywINV277INlgsTog
	 WYhmyLSmR44aHhKwG+GokJ6ZovUx6v52djnyAKZw4ghrHmok3qT0xkB8Ei/tECGYcP
	 sMUT06Ao2FxHg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
Date: Wed,  9 Jul 2025 09:53:19 +0100
Message-ID: <a8b95fa1119a5cff19ccde53ffc182d2441c1172.1752050704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752050704.git.fdmanana@suse.com>
References: <cover.1752050704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have the inode's io_tree already stored in a local variable, so use it
instead of grabbing it again in the call to btrfs_clear_extent_bit().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f08c72dbb530..e76e92873de5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1940,7 +1940,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * clear any delalloc bits within this page range since we have to
 	 * reserve data&meta space before lock_page() (see above comments).
 	 */
-	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
+	btrfs_clear_extent_bit(io_tree, page_start, end,
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-- 
2.47.2


