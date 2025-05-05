Return-Path: <linux-btrfs+bounces-13660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD77AAA97E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324E517B326
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B725F992;
	Mon,  5 May 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy4ZJaJX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD361264A89
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460202; cv=none; b=T/5UOpLgt8aHF5uVEeb+Sv2ljl9CJwVgC+dIyuWPU1X4xdvLUU8LgQQ2mQQ2gbLCyISU6RPpUkrK3UptA73QTNxyccEqnDfGLp5+gTTKS2Wy5lbXyO9FS2yxiOSIcEK22a8C74w63R6moQWtq5rgfGfkGU9gjHWmZJHrtd+w2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460202; c=relaxed/simple;
	bh=nPgmRA1POk5naFygLkF12CSazT3moQHBKhN2tjc5YeM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I//HQiWuqLRKEDinu3QPxHNqDig6aJCai+s+aGbH3g0UKA3+9W/Q96tu7MPcBwPLMAeGCKgXcadY4+9IHrKwb0OVY0a2jix2ZYwlraccMXzBso0aZxzwkpjxBIEFWGe6DH0MX1pEb686sU0tLWSxa4EBqQG2tN/ZaSoM1gqconI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy4ZJaJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A0BC4CEF5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460202;
	bh=nPgmRA1POk5naFygLkF12CSazT3moQHBKhN2tjc5YeM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yy4ZJaJXPT+tXyEF0+gQ788C8gLiE8+OmDABIWXLOp/rSkAsnzR13G41IyCVwLz5E
	 86IC0vbwA/kJPFPF+UWJlwPvMYwMrisXh+szqeiWaZLdtMBvQDrKbE+SbPkTfr/Zet
	 Y4gLZxZmsw2+Vc9Xyakc8nj8KLEUx6VQZuGUrWNFMxz3Iubmkn6R95WCrTbat4lk0s
	 ElM9L0k+cJOtE1TWvyqDI05C9dV9AhIpar08FEZX6jKP/hHtBwIDGOHrOvwO0c6k8J
	 7G/YpU9+v3a2OTvS1Yg2OO97MDFYqMDHcGsDk1Cx8v5hlqn9RafBkEOtvpOyXq8qI7
	 YYO+ctRSXaSWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: use verbose assert at peek_discard_list()
Date: Mon,  5 May 2025 16:49:56 +0100
Message-Id: <28f059e4718c988385c0d330c5c4663e253b60b0.1746460035.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746460035.git.fdmanana@suse.com>
References: <cover.1746460035.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We now have a verbose variant of ASSERT() so that we can print the value
of the block group's discard_index. So use it for better problem analysis
in case the assertion is triggered.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/discard.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index de23c4b3515e..89fe85778115 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -256,7 +256,9 @@ static struct btrfs_block_group *peek_discard_list(
 				 * the discard lists.
 				 */
 				ASSERT(block_group->discard_index !=
-				       BTRFS_DISCARD_INDEX_UNUSED);
+				       BTRFS_DISCARD_INDEX_UNUSED,
+				       "discard_index=%d",
+				       block_group->discard_index);
 			} else {
 				list_del_init(&block_group->discard_list);
 				btrfs_put_block_group(block_group);
-- 
2.47.2


