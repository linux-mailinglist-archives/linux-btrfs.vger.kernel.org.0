Return-Path: <linux-btrfs+bounces-11646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B96A3D7B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F219C112A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B051F3BBC;
	Thu, 20 Feb 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyMdV0HL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086881F3BA3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049499; cv=none; b=J/fkuP7HEUU87xwzjNXF6YuV3fBK12nwrVWT1W5Jx8oiWmOao78K1/EH/RSoIHb2QSdQF2IPiWgiWfi/7c7BgrQZZCBX+LLgM0IBxey1HyBmmw/KWgxktekL8BWC9ZjEQKkDXcr6kI+0Jwu2rbP0Dt/cJiUSaf3Se3UGz7GSws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049499; c=relaxed/simple;
	bh=yGG6Cy9K8ygG2fE8rIJTVP2uEfYv8gX0Yf3gDRp25FY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rqt2thJYa6FurP8snbAYjFcSWlStiWw86SPx6yUWEC2lUVFh+eQyNtQoy5IbBn/srObnGYp7LUD7+u8cEUBtdmMdPZ1Pw9mryKYwhLjtiMSmvcH9z5jvc25XDG4gFLuWOuyQqMyLtQaNNzPgxjYlDXSX9ObQmf8AGg1SbS7dkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyMdV0HL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586E1C4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049498;
	bh=yGG6Cy9K8ygG2fE8rIJTVP2uEfYv8gX0Yf3gDRp25FY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YyMdV0HL8gAq31Wqes/O/2pJtUCOXeIN9D/YgIo/a4KwkFCESAhjJreRJzKGMqwIY
	 uw8zv29ljc20om0eksb4REK3wMs+0KbACeUwEbRM4p6/kHvja6sET9w1RTt73uOoyS
	 o7PXUQl2QMB+Y3Qg0svbXwLCtFr6xnikCgZRvzlm4HxmAmfpzy//UFtM6ePN3ne2df
	 pyelyOXQfsGTQFdCfH8/VgRpaZhI2DRF/KNsZhXer1XsS4/kiFnhHukjI+CK5u54Jg
	 n2TNvP1yunHhxvA/HYT5hOwZWK8QybH+IMQORDyiPn5ycowYENYSbcBYRKBSk0Gebf
	 cvtn3x2FehtNQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/30] btrfs: send: simplify return logic from get_cur_inode_state()
Date: Thu, 20 Feb 2025 11:04:24 +0000
Message-Id: <03a17adfd1cbe7b435971a8c1d196cc5c2455006.1740049233.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0a908e1066a6..e0e24ac94aac 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1880,7 +1880,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
 	if (ret < 0 && ret != -ENOENT)
-		goto out;
+		return ret;
 	left_ret = (info.nlink == 0) ? -ENOENT : ret;
 	left_gen = info.gen;
 	if (send_gen)
@@ -1891,7 +1891,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 	} else {
 		ret = get_inode_info(sctx->parent_root, ino, &info);
 		if (ret < 0 && ret != -ENOENT)
-			goto out;
+			return ret;
 		right_ret = (info.nlink == 0) ? -ENOENT : ret;
 		right_gen = info.gen;
 		if (parent_gen)
@@ -1936,7 +1936,6 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 		ret = -ENOENT;
 	}
 
-out:
 	return ret;
 }
 
-- 
2.45.2


