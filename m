Return-Path: <linux-btrfs+bounces-12757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE420A7918B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A42316FEFF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396DD23C8CD;
	Wed,  2 Apr 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGqbqJNP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82723CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605660; cv=none; b=ZdxhEtNvbWNwpkI+pzFd6oSJioFy+nliLvqnqXH2hfIilWcfI9HZvtPwgs9la0vxRnfD4TnTe8o24juITgOmSH26t4e62NzdQVtecbdJuDvbK/vhyeMhZFiZcNzIHZ1Nhq42uhA2NSu/XQz7gdwtBtBN8hqj5OjEWhu1LmfJRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605660; c=relaxed/simple;
	bh=TIqodMa/kk2byT3jWMKDCpe65AvXRgvOvSZ6/O0v6EI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEL5vDRIFvkQXPuqVYihtTDch5+ltvNDYWwU1mFbLZbsbASUlvulFKnBLDRd2LdE8fZJv6Crk/Nd6Bua6ducfKfAwg7gLhmuaCNgh3JKVp1NPEhViYHnNPcj1HFx2GsB6pv21NljCPX04WuBc1jvM6y6fswcrTyUUD83NippgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGqbqJNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A6EC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743605660;
	bh=TIqodMa/kk2byT3jWMKDCpe65AvXRgvOvSZ6/O0v6EI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vGqbqJNPZKIoUypSKsKKcBvPnFaDByscKb1s6qQS6CxGOprxLma1ZvSzLaRkMuLfq
	 t5RALgU3uwolK+td7YXmdyQi9phSH+NJLjQS4x5Jc6GrF2cekVXBCNk5U9XgevfqX0
	 fuUL3F5OZjcS4GQ1e6oyEPnmYfzwSDgyPgS7e80UYiwT2G1ERbKMNfDdXP5N8dIqa+
	 cfE6fEupAFpYMJ6qXD0rqs3rVAZR+6i+ZfhMEID+uSzL55MK0PRBRRE11zJwYLk5Jx
	 sVMtPBj/LRdSho8ZXzLpTXOElg3fqUAO05GurdErLzXo5mk9trcHCSBp8oENV2RJ85
	 5OaLt1b4L26lw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: remove redudant record start offset check at test_range_bit()
Date: Wed,  2 Apr 2025 15:54:12 +0100
Message-Id: <bcee10b1dcf4b6d350d0b135256860bd63c22dc8.1743604119.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743604119.git.fdmanana@suse.com>
References: <cover.1743604119.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless to check if the current record's start offset is greater
than the end offset, as before we just tested if it was greater than the
start offset - and if it's not it means it's less than or equal to the
start offset, so it can not be greater than the end offset, as our start
offset is always smaller than the end offset.

So remove that check and also add an assertion to verify the start offset
is smaller then the end offset.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index b321f826d008..d833ab2d69a1 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1794,6 +1794,7 @@ bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 	bool bitset = true;
 
 	ASSERT(is_power_of_2(bit));
+	ASSERT(start < end);
 
 	spin_lock(&tree->lock);
 	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
@@ -1807,9 +1808,6 @@ bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 			break;
 		}
 
-		if (state->start > end)
-			break;
-
 		if ((state->state & bit) == 0) {
 			bitset = false;
 			break;
-- 
2.45.2


