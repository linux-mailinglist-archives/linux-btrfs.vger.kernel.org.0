Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63B4B79F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfFSMFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 08:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMFy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:05:54 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2560B206E0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560945953;
        bh=vW1Ay9OFMNSNx6qFvS0J4WTZrmcwwVCn/HdIrGpbvJ0=;
        h=From:To:Subject:Date:From;
        b=EigcUF13/5UUKAp4pXPLmww4P6X6AqcXi4HIWkjxBTawtm54dabyFb9FqaJXZaM+g
         7Kw2dCVjfErTZlrY1ZtRkG49C+UlfRTm97psI7kfZcqL6x7WR37IqCUSfsoIpgV8B3
         cbyI62LfoYQUp3h67Hw+9Gcu0ALs+lzwNPAmbJzE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: add missing inode version, ctime and mtime updates when punching hole
Date:   Wed, 19 Jun 2019 13:05:50 +0100
Message-Id: <20190619120550.9825-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If the range for which we are punching a hole covers only part of a page,
we end up updating the inode item but we skip the update of the inode's
iversion, mtime and ctime. Fix that by ensuring we update those properties
of the inode.

A patch for fstests test case generic/059 that tests this as been sent
along with this fix.

Fixes: 2aaa66558172b0 ("Btrfs: add hole punching")
Fixes: e8c1c76e804b18 ("Btrfs: add missing inode update when punching hole")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 89f5be2bfb43..1c7533db16b0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2721,6 +2721,11 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		 * for detecting, at fsync time, if the inode isn't yet in the
 		 * log tree or it's there but not up to date.
 		 */
+		struct timespec64 now = current_time(inode);
+
+		inode_inc_iversion(inode);
+		inode->i_mtime = now;
+		inode->i_ctime = now;
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
 			err = PTR_ERR(trans);
-- 
2.11.0

