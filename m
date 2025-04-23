Return-Path: <linux-btrfs+bounces-13311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A42A98CBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557021B65350
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEE280A3C;
	Wed, 23 Apr 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgmZ0Eky"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677427D773
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418022; cv=none; b=l+6xOzbpzB+sE5Pr6e04rPNj8PCX7t/iD6wnWHSFq1Sc4PbJ/OMrpaBXpRhpRB639QRXzxpgOs93twCKRJYTVVh0dDwv02G1FGEB83DRGPSd2wd2sW5DETl7njtAQ6Ml+4ibBIXpCX5S4jQThP0weArxUbG1PUuNkHSdssciGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418022; c=relaxed/simple;
	bh=6e0K/MNVqUVOQZq8Xin6g3ryZ1f09TlrOfN3T4KoqWI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sM+xhhtjV2aVmPnJqPUAKhircDo3rm/KAsNKan2fXSztv5Ps5cAaQjgiNeSuJ+42oDypVMcwUJnXL9rHyOd56QimbLJ2FxmUL+Zs/3hp+e+I5Yz5ETmT2AunDeyzlbGjUk5d/kQ1fL/jaMEVFAHE7RhnhDE9pBuiH50P+y418uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgmZ0Eky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006D8C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418021;
	bh=6e0K/MNVqUVOQZq8Xin6g3ryZ1f09TlrOfN3T4KoqWI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JgmZ0EkyNF9qqfBx9S64JtEveXdF5l7YI0qDXftHxysb4r+zMWP6YfXWQtVKS69aO
	 SuCCGhLGPvg8hiceQzmYw0vEoSKZmy39kRLXp8AP7yc+YCwkhBohI3PPqHiVNpUPhS
	 laPsxNQZKwWJQ8AfW1kYZYBhPNgBk1K3jdMlz25WUb5KMsKa++X2j/lw4bTej6PiEa
	 Sf+8W0Y7hcsLZJK1jb7B9lKscN30vURjA5dW8KbQmSil46UjE/mDAcEa0fIVV8Pmoi
	 8EHR9citR1rjHVJzM9rpAgOmbg5b7zfPj3lrKAaFo2RP5ZFDwNF7HxKk8FsnM8cO0O
	 +lnIEmMWDRxkw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/22] btrfs: exit after state split error at set_extent_bit()
Date: Wed, 23 Apr 2025 15:19:55 +0100
Message-Id: <fca0004092b0e533339ce9153613fb47dd6656f9.1745401628.git.fdmanana@suse.com>
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

If split_state() returned an error we call extent_io_tree_panic() which
will trigger a BUG() call. However if CONFIG_BUG is disabled, which is an
uncommon and exotic scenario, then we fallthrough and hit a use after free
when calling set_state_bits() since the extent state record which the
local variable 'prealloc' points to was freed by split_state().

So jump to the label 'out' after calling extent_io_tree_panic() and set
the 'prealloc' pointer to NULL since split_state() has already freed it
when it hit an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 2f92b7f697ad..1460a287c0df 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1247,8 +1247,11 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (!prealloc)
 			goto search_again;
 		ret = split_state(tree, state, prealloc, end + 1);
-		if (ret)
+		if (ret) {
 			extent_io_tree_panic(tree, state, "split", ret);
+			prealloc = NULL;
+			goto out;
+		}
 
 		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
-- 
2.47.2


