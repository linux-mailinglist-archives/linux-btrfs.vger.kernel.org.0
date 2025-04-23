Return-Path: <linux-btrfs+bounces-13303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD8A98CB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313A61B64BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792B27CB35;
	Wed, 23 Apr 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmQ07s11"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AD27EC99
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418013; cv=none; b=DHmn22al14vd7O+TPzHkvhC0U046p8uKN05M01lQqMDpMl4J5h8Q8h9uRrn6w+AnPpdNhcf+Kz91urjUwCOWvKZ5XZZma9xXegB+pKPvrVQLwzIEWFJeZH+17AoWF2gSf5+dx8KFgtXdIXjTPK5SGY35Jz+yseMM3n7eSy0nX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418013; c=relaxed/simple;
	bh=Gl0M2+E2SeQxCHsgO60Um9mO/iUJGXcHaAptw7vp/tI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTXU+virfKfiap1cd0Z1rydWPqO7zzN9RpDTgxiOCmWwgcuPMXn99NMa3/0KTAulKJ8c70O+WbdB2nigJ5//NSl6fvW3DvikVtajJ4A6tl+f+NbU7iARM3veTMNvzx8jQWt17LJ+jbsI0S9ucS6dTCTKWVNFxQAcLPfg8EduYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmQ07s11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF79DC4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418013;
	bh=Gl0M2+E2SeQxCHsgO60Um9mO/iUJGXcHaAptw7vp/tI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BmQ07s11B/CotntdkpbeqkivpWX7y9Xvzo1F1j9bJlye6f+tqPEkp6NPH47xzp1SM
	 qK6XaXcsAl2FnHGA1ZHTYrd9BmhaZEW800Be8bufAPmQFVt4m3rxfunniFAQDzOz8L
	 I0+NlczM47eaChd2EL3i2KE3xQToHiFxR1jdEqLJhWxMHWdYpEHMduhWeVtp26k+aR
	 5xduiZlt90tmcJ9vcLG+jiJ1M4WsFZ05d1KUVVRo7Pyq/vPJKqhuZGYt9Ok4yBKeFY
	 r/yHI8A55IBQouHS5o2d1oAwbj0UUPe/GXMdWe9+2yQiDUJ5gETBb8sClrYkNY8TG4
	 LO4DoMSeP2y0A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/22] btrfs: remove duplicate error check at btrfs_convert_extent_bit()
Date: Wed, 23 Apr 2025 15:19:47 +0100
Message-Id: <2e624648b24aa9e1a6e703c08fdccbab1dca244b.1745401628.git.fdmanana@suse.com>
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
 fs/btrfs/extent-io-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 5484e2b80cfe..8b765ae9085f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1389,11 +1389,11 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto out;
 		}
 		ret = split_state(tree, state, prealloc, start);
-		if (ret)
-			extent_io_tree_panic(tree, state, "split", ret);
 		prealloc = NULL;
-		if (ret)
+		if (ret) {
+			extent_io_tree_panic(tree, state, "split", ret);
 			goto out;
+		}
 		if (state->end <= end) {
 			set_state_bits(tree, state, bits, NULL);
 			cache_state(state, cached_state);
-- 
2.47.2


