Return-Path: <linux-btrfs+bounces-5904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646C913A2C
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 13:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAB21F21820
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1817FAB8;
	Sun, 23 Jun 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHicoqzK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB421482F8
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143433; cv=none; b=Lfhn6CxQmgdsgqS90zvxWfMyQCp81LS+YUX2ue0pVV9HZKEOedHExKaxEJPO6ipDgQkIHIs5mPyarN7JTcu4EPi17jsUe6vn1+FPQjzd5HjvCyWa6eS7DmA6skfKigy7br28nR0XO6O+EiWhhavW7rkQDrwTNF4cCTJ+JotL84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143433; c=relaxed/simple;
	bh=kt/9LgdlJsDgi8fYqR4aT3De7GXY1DTvKATLPGsjiyE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MqIzZC62RJppdmTiWGONUcF1uvRlUAoUmOru3ellFLnPM4oXw7m04ys2VFI7gEcRJdmNiYOpDp9aniN8GoXnwVUi9i/O0ODmn9OEip6HlTSx5IvC7QBj+mrLOq/5RZpeBqrfpDb1XjT2TVdjO4ONnnX26iI+s32rCHFGMbRtxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHicoqzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2FEC2BD10
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719143432;
	bh=kt/9LgdlJsDgi8fYqR4aT3De7GXY1DTvKATLPGsjiyE=;
	h=From:To:Subject:Date:From;
	b=XHicoqzK3E7wg82ns/lD28pPDtah188qnFDOyDS0tkHrANvzsoJFJgWVwk0HLF2fA
	 dNzzHyqdmfSgLAIEeKA+cFFQXbZLK86YW9OLXoKf/xHb7LmxWND+J+9WE9knbrbJr1
	 rP3cAjcm6ik2HsSX4zAEx5CEoBKN1uq6jraGdIdsSiJh10yEzXDYC6Q2GdDIUrnTMQ
	 4AJBxKx0TLgRKGolVcpY3cHumPC2fTEZ6QKykXrrXKzd8dZtpPjLDhtRrz7Aq7UG4K
	 oG9ZbKUB9jJ/OcOb9AzO8OEAfyaDkGhhdgXk8n3ywcjyyFkNlFp2PSjjMqC6v+dggZ
	 DInyIB05a1dqw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix uninitialized return value in the ref-verify tool
Date: Sun, 23 Jun 2024 12:50:26 +0100
Message-Id: <612bf950d478214e8b76bdd7c22dd6a991337b15.1719143259.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the ref-verify tool, when processing the inline references of an extent
item, we may end up returning with uninitialized return value, because:

1) The 'ret' variable is not initialized if there are no inline extent
   references ('ptr' == 'end' before the while loop starts);

2) If we find an extent owner inline reference we don't initialize 'ret'.

So fix these cases by initializing 'ret' to 0 when declaring the variable
and set it to -EINVAL if we find an extent owner inline references and
simple quotas are not enabled (as well as print an error message).

Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/59b40ebe-c824-457d-8b24-0bbca69d472b@gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ref-verify.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index cf531255ab76..9522a8b79d22 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -441,7 +441,8 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 	u32 item_size = btrfs_item_size(leaf, slot);
 	unsigned long end, ptr;
 	u64 offset, flags, count;
-	int type, ret;
+	int type;
+	int ret = 0;
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
 	flags = btrfs_extent_flags(leaf, ei);
@@ -486,7 +487,11 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 						  key->objectid, key->offset);
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
-			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			if (!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
+				btrfs_err(fs_info,
+			  "found extent owner ref without simple quotas enabled");
+				ret = -EINVAL;
+			}
 			break;
 		default:
 			btrfs_err(fs_info, "invalid key type in iref");
-- 
2.43.0


