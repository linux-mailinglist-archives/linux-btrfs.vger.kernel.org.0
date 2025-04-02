Return-Path: <linux-btrfs+bounces-12756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE56A79181
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A315F1893D7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164B23CEF9;
	Wed,  2 Apr 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb3SNb90"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6223C8CD
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605659; cv=none; b=D/bUQckFuYlNRTiN9egety1IrLdSivjTpHH+zpxNz3z+BJXdKVJDyAor4mt5Sjh/ZMB0k6IXcTv2fSoxtzsdKr8u1FxllLTSwaGyPQ1yrfoTx6zyWi4o6684uOrI6G8pzSsKVIlDYexFw27OeBynM+b5Re7g2x3E648IK0uz/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605659; c=relaxed/simple;
	bh=pulcjm3sjJuVepIWdS8YnVZ6qwAP0c7Tyz0KbJmUoyw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWsnszAaVejtmwQZ8nXfgleqbFJz9akMvsSSuIDseGuhENLAZY6P7vSRdajbAlQWdeJ6gatU48rfc2JgQJv5Kybvp/pHf9NRP2DudeXWdMbQgjLkCibY81faVNMyf3A1MdR6vfKgjOP5YUinPlwh4fDPnufJNm4ZksckgGuaMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb3SNb90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA674C4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743605658;
	bh=pulcjm3sjJuVepIWdS8YnVZ6qwAP0c7Tyz0KbJmUoyw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yb3SNb90H980yA9gZ3APNTTqXG1Tq61fxFUZTfC6UVqT2asoMko37iBKv866vx0Dg
	 r9e785NpVGuTuCq3vTYlIA0KaX/6V+hYdGz67zcvIR/5EJ7VjmCQ70CShGA7MFwCxR
	 30n0At0tq5na6xmquR3eS3Zbp5omBIJUKcjlcCrFvjDnUcWXZ/ELKu2xS9iVCPUmbw
	 6SVk5INAcIzcTrmFABZt8IRqcZZ3lTdd5MJk5jsYo9PB8YTBFiK5zBz0VVULYqYa+A
	 xqxqyfOKZR+OR6JhQlWsAdGKdPQdZjTt30BDQbS4Ex2YfDatANwUk01ruduhSWbb9M
	 TtsMml19AP+cQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: remove redundant check at find_first_extent_bit_state()
Date: Wed,  2 Apr 2025 15:54:10 +0100
Message-Id: <53332cd42e8da6a425195ce329c9c571c6d3a4e6.1743604119.git.fdmanana@suse.com>
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

The tree_search() function always returns an entry that either contains
the search offset or the first entry in the tree that starts after the
offset. So checking at find_first_extent_bit_state() if the returned
entry ends at or after the search offset is pointless. Remove the check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 355c24449776..18b10e7ed815 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -877,7 +877,7 @@ static struct extent_state *find_first_extent_bit_state(struct extent_io_tree *t
 	 */
 	state = tree_search(tree, start);
 	while (state) {
-		if (state->end >= start && (state->state & bits))
+		if (state->state & bits)
 			return state;
 		state = next_state(state);
 	}
-- 
2.45.2


