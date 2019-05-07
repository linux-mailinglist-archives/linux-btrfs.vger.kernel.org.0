Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9815E28
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 09:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEGHXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 03:23:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:54390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbfEGHXt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 03:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE44CAE8D
        for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2019 07:23:48 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Return EAGAIN if we can't start no snpashot write in check_can_nocow
Date:   Tue,  7 May 2019 10:23:46 +0300
Message-Id: <20190507072346.17964-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first thing code does in check_can_nocow is trying to block
concurrent snapshots. If this fails (due to snpashot already being in
progress) the function returns ENOSPC which makes no sense. Instead
return EAGAIN. Despite this return value not being propagated to callers
it's good practice to return the closest in terms of semantics error
code. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d8abce428176..ae1fadae3d47 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1556,7 +1556,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 
 	ret = btrfs_start_write_no_snapshotting(root);
 	if (!ret)
-		return -ENOSPC;
+		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
 	lockend = round_up(pos + *write_bytes,
-- 
2.17.1

