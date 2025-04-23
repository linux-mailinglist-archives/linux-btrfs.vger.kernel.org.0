Return-Path: <linux-btrfs+bounces-13301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945AA98CBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A357E443AFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61327CB33;
	Wed, 23 Apr 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RicmNx3e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193427E1C3
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418011; cv=none; b=VNjb7z+DT2Xrruy8Kk3CNdo8Cx5CztGLm23HcuOGzuuQlYFA8aZIS4uIZ8inJ8F14cYj9jx1bXoDFSPWNh5bxODJtha/g1Ns1VyL5XAcTy2JlbTWJlXvxYZ+YAusolM/b8sj4CjgBHX51oa81AghyIih5eQN1Ix2Lg80j7dBuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418011; c=relaxed/simple;
	bh=Jux4z7MAXYj8Sn6aXlZJV8kXlnHmQKed7943NU+dl3U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmICcwVF3kU4jKRd93N8qgjZ6vVCHuucG7ZNmZgKwXhx0Ts3U8caJYK4RCfXLq5RXfbAzvrRpWPjw28TmGH/G+yj/JOnevG/suIGvak9mAWqy3BWrc5jrw5RjVrdWJygXRg8WePSwlX0dyqPaZS3n+TbI+KR0Zqmb3uRynkSPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RicmNx3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C311DC4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418011;
	bh=Jux4z7MAXYj8Sn6aXlZJV8kXlnHmQKed7943NU+dl3U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RicmNx3eYvQZcr8XCj6jedYuVgdLkAs7P2NNhGKKJFGuADX/yWPww4mEfJpfpjTZ9
	 R2cFgoch1lyLZJhQdz60skVkiZ5PNHUI6Kch8ERVF3doQar4d1wHKlyXghzG/5ZxOi
	 rj8kKxvGIznXshU4NI/X8ibxzE92vsBbTi4g2EUoDg7m4zkxVeNFkGpHqMTcbtnlL9
	 ErVKoWbfLytiq9GuYVdKDFurta3Q2n9mAlNupA1eJlLQfkU5456uGV8rU33sVgl6xG
	 pawfvyl8wQgHWHW/ULtNLNA4jDmEUv0/eiovdX9AYuYPN9iaiV6xJgrPHfKPGkdy6h
	 b4gf3NKSddymw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/22] btrfs: avoid extra tree search at btrfs_clear_extent_bit_changeset()
Date: Wed, 23 Apr 2025 15:19:45 +0100
Message-Id: <40288b424af8cb2a0d779e56e02eab57e1a1cf9a.1745401628.git.fdmanana@suse.com>
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

When we find an extent state that starts before our range's start we
split it and jump into the 'search_again' label with our start offset
remaining the same, making us then go to the 'again' label and search
again for an extent state that contains the 'start' offset, and this
time it finds the same extent state but with its start offset set to
our range's start offset (due to the split). This is because we have
consumed the preallocated extent state record and we may need to split
again, and by jumping to 'again' we release the spinlock, allocate a new
prealloc state and restart the search.

However we may not need to restart and allocate a new extent state in
case we don't find extent states that cross our end offset, therefore
no need for further extent state splits, or we may be able to do an
atomic allocation (which is quick even if it fails). In these cases
it's a waste to restart the search.

So change the behaviour to do the restart only if we need to reschedule,
otherwise fall through - if we need to allocate an extent state for split
operations, we will try an atomic allocation and if that fails we will do
the restart as before.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index b56046c55097..590682490763 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -699,7 +699,13 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 			state = clear_state_bit(tree, state, bits, wake, changeset);
 			goto next;
 		}
-		goto search_again;
+		if (need_resched())
+			goto search_again;
+		/*
+		 * Fallthrough and try atomic extent state allocation if needed.
+		 * If it fails we'll jump to 'search_again' retry the allocation
+		 * in non-atomic mode and research.
+		 */
 	}
 	/*
 	 * | ---- desired range ---- |
-- 
2.47.2


