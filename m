Return-Path: <linux-btrfs+bounces-12196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF27A5CA4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 17:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18777AE938
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB7625E825;
	Tue, 11 Mar 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raIG5GYb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207B25F964
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709210; cv=none; b=ZAk7vVJjaEdmr83CocWYAAlUKQU738fQN+iKHFsHZKVBxOmoOfTfU0GQCjrIu4XBBlg1EZIGZ7ZXWhPeawCCtG/MJTpfVT3Wfmz0cYQYF2/G6jUu3KpMp3RPUZhy47ky8T1tS4nzkxTcpO6W2NGtC6cV4E48mZpUHEd0lS2dNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709210; c=relaxed/simple;
	bh=9+nOTRBoCMUhGhpDKIsSKhPp+XN/Ji1gJ7DpKSvFdwY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=I4u5aEOwHjdZetRHS2ON7N0rrVQHnkouhYBBUvF8Y1l+iNRRhBXT9HbEM8Q7M33QkK9A7rM/5KOH7fHoGdHznYL9lObxXFMUzZ2imh4h+uShiS54zyyHK668SSdl1JNwZ/qVjfJhFRGTHUcsSjlyZdRs2rNGys6ItxzUQkmp08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raIG5GYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC9EC4CEE9
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709210;
	bh=9+nOTRBoCMUhGhpDKIsSKhPp+XN/Ji1gJ7DpKSvFdwY=;
	h=From:To:Subject:Date:From;
	b=raIG5GYbIX29zoBDYuITHUVTP+/7iNDuenkKbosBV639itMQ5KjpmgqadnFkbIEv0
	 VnXOlLYu7ooZPGSqRbw0gidHuDu+S7BTuDa417yKBcV3zJpHVb5uBiB8xUudawQovh
	 ctTups0nRWWl73tSMH8Wh52ieTktmtRT7QeWhcGXlPHyKpXoJZMn132vqINYPxelT3
	 iKXmcWD8Vu9fq9WsizSTNWeqEI0n53N1fvpuTnX/QgfYdfVdcFn+WEtBdjtKwZ2qYg
	 PC9cnzSOBCfRGnpXqRXyN2tMflBDNb9x3WUHlDEH/uZ1D2V+qQKWqqKS0yw/fss99L
	 cvOnl5mqnYntg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tests: fix chunk map leak after failure to add it to the tree
Date: Tue, 11 Mar 2025 16:06:46 +0000
Message-Id: <f05862e33146ef046f6d377b8b2663b69f2c2e84.1741709026.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to add the chunk map to the fs mapping tree we exit
test_rmap_block() without freeing the chunk map. Fix this by adding a
call to btrfs_free_chunk_map() before exiting the test function if the
call to btrfs_add_chunk_map() failed.

Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 56e61ac1cc64..609bb6c9c087 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -1045,6 +1045,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	ret = btrfs_add_chunk_map(fs_info, map);
 	if (ret) {
 		test_err("error adding chunk map to mapping tree");
+		btrfs_free_chunk_map(map);
 		goto out_free;
 	}
 
-- 
2.45.2


