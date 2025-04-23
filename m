Return-Path: <linux-btrfs+bounces-13297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE37A98CB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FE917E0ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6785627CCE1;
	Wed, 23 Apr 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxO9g9yq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6F27C873
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418007; cv=none; b=pui/QkAAPKGmSlOYyFxlPQmAOZf1/MVVmFLFv2ki8P4qNq10hM3AYpK4Ug0sJk9IMumFKqcTYJu9Id7hna5bh0IpnUMoLKMWvR9/GGlbkmj41QKc2LdkDA/VoP4gTS2aCyFyCXPihOpt3q5tOSva2bfPnaNuPgoHi3wCdR66ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418007; c=relaxed/simple;
	bh=pjHUD/NzWn3y8FsH9ILIVyAw6IE9A25PW5mZ2gp+3VE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ji7PlQHd17aqdtmoWt3hx8pgrR+eRHQ9Ckvam3ap7uTewtp3JxMMG0zvBdQToaNy36kIYXqUvwDSAs4wPvJco8nAN7pEksBaFwv1VFeI2TCDrjemiZbh7bU2GgfNkdqKtgsx6u8WWwKsV/QDibpqMdFAKb/RL3a45b5YR/CDTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxO9g9yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1182C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418007;
	bh=pjHUD/NzWn3y8FsH9ILIVyAw6IE9A25PW5mZ2gp+3VE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JxO9g9yq8C4dHJm3pJoIYs8Ak0s9l0Xa4StkcEInj520foa/Aly4Rt7jgljm1bQyt
	 6Cz6F6r11zu4da49r2SOpIJLF1XzUvY6OlYqqkEVyriAxR/M14pBpXrun6SRMc5fx7
	 bVUckIeGQ1b5xIeeBjJC/OFEHQyiKmfXBcxMgFa/nibahWWu+U+tdyuVgIefQPk4NZ
	 AADauBztlKIT1oLD70lysc2NgIeWD6PA3qUXpqmoAg+A05IkNMH6dykA1PfQN6JXaP
	 Hz1lFlrgXMZKdbsY9pKFN3u53z2HAGrTQU1XWWqAdEoJG0iMiC5aJQzuZoUS4ZV4/b
	 HVqLPCv50uFXw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/22] btrfs: remove duplicate error check at btrfs_clear_extent_bit_changeset()
Date: Wed, 23 Apr 2025 15:19:41 +0100
Message-Id: <b4694e72586683f7e6324ebf41cf3b5545d1a7a3.1745401627.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to check if split_state() returned an error twice, instead
unify into a single if statement after setting 'prealloc' to NULL, because
on error split_state() frees the 'prealloc' extent state record.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index cae3980f4291..dc8cd908a383 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -691,12 +691,11 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 		if (!prealloc)
 			goto search_again;
 		err = split_state(tree, state, prealloc, start);
-		if (err)
-			extent_io_tree_panic(tree, state, "split", err);
-
 		prealloc = NULL;
-		if (err)
+		if (err) {
+			extent_io_tree_panic(tree, state, "split", err);
 			goto out;
+		}
 		if (state->end <= end) {
 			state = clear_state_bit(tree, state, bits, wake, changeset);
 			goto next;
-- 
2.47.2


