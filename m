Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3E305F1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhA0PIP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235756AbhA0PGZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:06:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D88D6207D0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759944;
        bh=gnA+KrrZmB9w1nftineZzgOzhJlwGHwp82tFNSdWhys=;
        h=From:To:Subject:Date:From;
        b=ZLZDkSlrJvc8E9OagM0Pla6gR4azn2Yp+UhpFniAvm6lstiqaqcMWJ8UQo43nUHAm
         TmxDf/Md9Xtr4MKrpU2fLeysRyd1YNdv83kQO7BjWOGhyF1Sc7Z+3jIA6os1EnQU8x
         GWAu0agMqNKj3hDBNMuWG2NU8Pdov/4blskuEUTHiigcpA1cu3QgHJLKBxBACiUzSV
         UT3Hp592/yFSZwjR60nm/xQLqOq+VkFhtc/b80U2avQeV3Ob1xhoaahriNMzTJCZc1
         d69U+NdOo4hcoanyj52PlX6DMw4USEO4kClZUFwrzhKeAAEBC3yEi1Hyd/QpQa+gNa
         VrRvZewVR8DTw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove wrong comment for can_nocow_extent()
Date:   Wed, 27 Jan 2021 15:05:41 +0000
Message-Id: <9017cffd318c09a5e6248ca904903938c691b450.1611759896.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The comment for can_nocow_extent() says that the function will flush
ordered extents, however that never happens and was never true before the
comment was added in commit e4ecaf90bc13 ("btrfs: add comments for
btrfs_check_can_nocow() and can_nocow_extent()"). This is true only for
the function btrfs_check_can_nocow(), which after that commit was renamed
to check_can_nocow(). So just remove that part of the comment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0dbe1aaa0b71..589030cefd90 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7105,9 +7105,6 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
  * @strict:	if true, omit optimizations that might force us into unnecessary
  *		cow. e.g., don't trust generation number.
  *
- * This function will flush ordered extents in the range to ensure proper
- * nocow checks for (nowait == false) case.
- *
  * Return:
  * >0	and update @len if we can do nocow write
  *  0	if we can't do nocow write
-- 
2.28.0

