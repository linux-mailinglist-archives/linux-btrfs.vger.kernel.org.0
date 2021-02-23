Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795C8322B57
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 14:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhBWNVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 08:21:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:59472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhBWNV3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 08:21:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614086443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=etvXDRKX+C+eQUI3ggxyu2VSklDFOJKwbGtrf9coCfk=;
        b=KnEW8QdAdtX38gyNH53gMHlFKcSBOc2Iyt/Gd8MLUxHvmI5jTTwGgC3tNqHw4/fOw46MF4
        0BKdp6XApEcGPn0CTPPOjZTgTPmCNLUkL+TjFVmucMrAxXPZCelw14ZgKYqFAJqP4iWl0C
        gcBz+5HTvPlGugkVUx6CJ4yXu0caQbo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E890AC1D;
        Tue, 23 Feb 2021 13:20:43 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Unlock extents in btrfs_zero_range in case of errors
Date:   Tue, 23 Feb 2021 15:20:42 +0200
Message-Id: <20210223132042.1198894-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If btrfs_qgroup_reserve_data returns an error (i.e quota limit reached)
the handling logic directly goes to the 'out' label without first
unlocking the extent range between lockstart, lockend. This results in
deadlocks as processes try to lock the same extent.

Fixes: a7f8b1c2ac21 ("btrfs: file: reserve qgroup space after the hole punch range is locked")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1e68349c3884..af0253473508 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3259,8 +3259,11 @@ static int btrfs_zero_range(struct inode *inode,
 			goto out;
 		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
-		if (ret)
+		if (ret) {
+			unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
+					     lockend, &cached_state);
 			goto out;
+		}
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
 						i_blocksize(inode),
-- 
2.25.1

