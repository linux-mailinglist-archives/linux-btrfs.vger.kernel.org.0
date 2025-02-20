Return-Path: <linux-btrfs+bounces-11651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D175A3D7C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC43117C843
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E431F4262;
	Thu, 20 Feb 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WermkIrG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE041F4189
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049504; cv=none; b=Ba3hkrgQeMUXush35mCunLMKUBdS3lqgq5SiWPiYGHIuUrs4bQj3Kn/STGvmETWerjLWbLnYqhthF2gackJ5Qz8iacUx8TrGBPAjRcfe30/ejN2x7PIYgQCTUOUwqZJE9lPpmDsmBwNO0TEl5n/0kiOZH4xryb/fRs+Z8pazc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049504; c=relaxed/simple;
	bh=THpErzxIZlA7QdlBQjpr5bQsJcE1FHd68W0QxJlpsYI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpsVH5pQ7aihsBL5aE32AawolGDBQozjY+kIaOBev+JqEOz/hzOwBF2+RimgsMGYYWNXPzCVxgCdzhJP8xjLmIFpjkL1nBTF+RMhT7+atit2yAxO4aQ+4j4bzicU1azicV5ist4nVMB+3ReJr6AgVDHH5cFS+VsgbfgxiQuli5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WermkIrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DABCC4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049504;
	bh=THpErzxIZlA7QdlBQjpr5bQsJcE1FHd68W0QxJlpsYI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WermkIrGvV2/HQBO6b3LmNmpNzOXv8ADvjZ8nGYkbwY+y/nweohUI7bKSvaN8X0oa
	 3EU+QZkPVwVD0t/rY8k2lQnutv+WZa6XeFvhNpZB2/o8uVSdUwspfME/t8VPYm3lo3
	 7gL5IeiY1k38iexXIJY+gvvtBmg5dWT0Xbag+kiUKLkzWPc97YEptMchW0xq612Rux
	 D7HkNz+Nw/FkCSHb1YSjnLfZTjps4YBb9WtN4u16p8Cde1XvGm695yki0TlG5lSh9C
	 cE032qoN9Bnsc3Zb1fwjujr1V/+3XQ2PQWgRP2xCxccikfzb2N4c2jrI2Zyq2+p6LB
	 76zHOEzmZIBTQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/30] btrfs: send: simplify return logic from record_new_ref_if_needed()
Date: Thu, 20 Feb 2025 11:04:29 +0000
Message-Id: <9229ca2ec7c2baf45e6aeb869a764ee3ddf036e3.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
 make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5fd3deaf14d6..96aa519e791a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4683,7 +4683,7 @@ static int record_ref_in_tree(struct rb_root *root, struct list_head *refs,
 
 static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 {
-	int ret = 0;
+	int ret;
 	struct send_ctx *sctx = ctx;
 	struct rb_node *node = NULL;
 	struct recorded_ref data;
@@ -4692,7 +4692,7 @@ static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 
 	ret = get_inode_gen(sctx->send_root, dir, &dir_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	data.dir = dir;
 	data.dir_gen = dir_gen;
@@ -4706,7 +4706,7 @@ static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 					 &sctx->new_refs, name, dir, dir_gen,
 					 sctx);
 	}
-out:
+
 	return ret;
 }
 
-- 
2.45.2


