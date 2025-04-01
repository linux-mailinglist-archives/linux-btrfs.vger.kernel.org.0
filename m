Return-Path: <linux-btrfs+bounces-12720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128FA77A5A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98952188B13A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD825202F99;
	Tue,  1 Apr 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhG06q+9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F81FAC50
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509154; cv=none; b=Xoc3MIQ7nerpNCnJqJ2nToPfnAIsN2+sRy3/O5XPpZhPqli8cJShsEpcoYyq/zJ9XxyLKBVoNxKFkdbLSsqdVfA/CniOn6uZ47j3Y95Xtb/tkQqOZhW4K92bTs5OdTSWLzgGy+ZCkQPqZMHNkJJQMnD9wiB+Q0zUWH8HvAXdRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509154; c=relaxed/simple;
	bh=29hF5xAeU8i7ZE8Qko3WEFeyVFWmmB+JcUq+PIaLwKQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPJ9F7fG1I9dpd5GPUj77O/Y1EU9YVBZqdteTnwWwBmDEc9nhXjGObFbCzcCT1O5EY8ruiRpc7dSEwbU7RjRiWH3srlHL/hvyoGJgiRYkhe9oscQcRFBx+3qPPBSPkQ2Vvu6oPdPhL07eKJ27BoVLsuz1EfA70FzROyoJaAISCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhG06q+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AB3C4CEE4
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743509152;
	bh=29hF5xAeU8i7ZE8Qko3WEFeyVFWmmB+JcUq+PIaLwKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qhG06q+9gdKa3aD/Szm3r3litiBFbbsszzudLGeqstIPVUj91RPnGAUJL7x0rJf9+
	 mzNTFJgTa14nK/0Td/ymEzeLiH1X7Pty2bDftqR3PAaY+S58PNPTDbDQOgUB/ARA5W
	 Sk0l/7frDKZ/h1GsRJfNpkBWihVu6NGTdL6ziexAqIlEGg/PR9/ps/HX5bLcKxe1ul
	 r1WxCHIRnGDWnnVwle4EfWCLFh8amv/Nwigr8Ul41+osf4LrUeXDji0iTZMXPMMP3J
	 tT0/dnU9GLgNBrM1md/vclf+uCjf6u9J5bUcS3Hq6rkGqGFzl3t+GQoDNaJWdetDJw
	 Boj3ZB3lVM0gQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: simplify last record detection at test_range_bit_exists()
Date: Tue,  1 Apr 2025 13:05:46 +0100
Message-Id: <2037fb2e4ce4b289e5b5a454f8ada8537f0265be.1743508707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743508707.git.fdmanana@suse.com>
References: <cover.1743508707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of keeping track of the minimum start offset of the next record
and detecting overflow everytime we update that offset to be the sum of
current record's end offset plus one, we can simply exit when the current
record ends at or beyond our end offset and forget about about updating
the start offset on every iteration and testing for it at the top of the
loop. This makes both the source code and assembly code simpler, more
efficient and shorter (reducing the object text size).

Also remove the pointless initializion to NULL of the state variable, as
we don't use it before the first assignment to it. This may help avoid
some warnings with clang tools such as the one reported/fixed by commit
966de47ff0c9 ("btrfs: remove redundant initialization of variables in
log_new_ancestors").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 7ae24a533404..293cb354259d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1726,14 +1726,14 @@ u64 count_range_bits(struct extent_io_tree *tree,
  */
 bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit)
 {
-	struct extent_state *state = NULL;
+	struct extent_state *state;
 	bool bitset = false;
 
 	ASSERT(is_power_of_2(bit));
 
 	spin_lock(&tree->lock);
 	state = tree_search(tree, start);
-	while (state && start <= end) {
+	while (state) {
 		if (state->start > end)
 			break;
 
@@ -1742,9 +1742,7 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
 			break;
 		}
 
-		/* If state->end is (u64)-1, start will overflow to 0 */
-		start = state->end + 1;
-		if (start > end || start == 0)
+		if (state->end >= end)
 			break;
 		state = next_state(state);
 	}
-- 
2.45.2


