Return-Path: <linux-btrfs+bounces-15096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808DAEDCD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E2F7A6B6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67219286D62;
	Mon, 30 Jun 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPz+7EOs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E627055E
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286805; cv=none; b=BKN9LLpjvdlj14o/gEunGtOPWEWVBL/90cO11z0d0SOjrr3QWnQcX2sM09LyGzS48HD/hgKprZM+S8Fh8dTgUnbJWsL5BQV6HF5rIhXQFSP8okjxMR1kA5iWmeeO+UEmgUuHxo70mOhS4aHjnabUpOsBh5wzYlCPLXG3CGxlj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286805; c=relaxed/simple;
	bh=ua2ipCTa7rkbrN7QoUJlpsJPQMnMzooNk2QLt09WCaQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fObAf/D9PhIBQdI7tdx6kD3RVD6fFqi5378BX8xYxl5oH4ARbhaqBBBBeL2hALvHTsCE1ir0SVtc6sxfyJGJNHILI1Pxynf9ujVHwcNeSt5zqNIIw7eCuTgv/LtofLMmqgZvjmZOXrR5sp/g2SaVNW4Pjjfm+d/vIEtRpcVNoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPz+7EOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6C8C4CEE3
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751286805;
	bh=ua2ipCTa7rkbrN7QoUJlpsJPQMnMzooNk2QLt09WCaQ=;
	h=From:To:Subject:Date:From;
	b=FPz+7EOsmkm1lh5DcnRz6JWZ/L4LoF+7soVz4ebynMIEpxPMyIDtpAx9CHFVqyw2y
	 UBsvyA3p4DCWfm/znveaTbYrGGq3ISr6e3Np8FFNE13E2SVGU9az6GVwfK93SL4wtB
	 AjEfiDeS3zmfUBny4umHZe+5iFL2m0gQeoYq0PkHu43ZWcn5y7vnoX7suJEoMvps1C
	 xG26CiprawOrZe1kDjTaGpoAlJ5YLvmczmKCep65E392WzF3SjvCqrkA5I4/gUbWh/
	 d+yZkHvDtlDUKhlBG/Wi1fVgsFMD4ceXDigwOz4LEy6fVUGhyVCCr3P54wGQpvQtfO
	 w54LHE0W2HWTw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: clear dirty status from extent buffer on error at insert_new_root()
Date: Mon, 30 Jun 2025 13:33:20 +0100
Message-ID: <e9542d79dd176857624ab9e492acc7484a01b57b.1751282942.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we failed to insert the tree mod log operation, we are not removing the
dirty status from the allocated and dirtied extent buffer before we free
it. Removing the dirty status is needed for several reasons such as to
adjust the fs_info->dirty_metadata_bytes counter and remove the dirty
status from the respective folios. So add the missing call to
btrfs_clear_buffer_dirty().

Fixes: f61aa7ba08ab ("btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2997f2420719..dc21e840664b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2881,6 +2881,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	if (ret < 0) {
 		int ret2;
 
+		btrfs_clear_buffer_dirty(trans, c);
 		ret2 = btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
 		if (ret2 < 0)
 			btrfs_abort_transaction(trans, ret2);
-- 
2.47.2


