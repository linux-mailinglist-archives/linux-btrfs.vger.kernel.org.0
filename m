Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99EF2DD20F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 14:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLQNWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 08:22:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:58988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQNWE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 08:22:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608211278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1YdwRUmmoIapE3IYrPSrMzR48NUa6O2e0dguqlhhkJU=;
        b=SBWlBWn/IHfQONY67tF6p5OeAqxzsT5ox8N9ge7B2uumfB/APIVJzz5eB9amBGsQjdPNio
        Y2xvOAzdLmA0RhzBGQkdMpbF/yeh2iAMm5NPQAaUIxJPF66YTuLmSfNep2wcFUs/K4SgcK
        WI2ZXHZknoV4veOP8hWgequvfiV31wE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2857AC7B;
        Thu, 17 Dec 2020 13:21:17 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Consolidate btrfs_previous_item ret val handling in btrfs_shrink_device
Date:   Thu, 17 Dec 2020 15:21:16 +0200
Message-Id: <20201217132116.328291-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of having 3 'if' to handle non-null return value consolidate
this in 1 'if (ret)'. That way the code is more obvious:

 - Always drop dlete_unused_bgs_mutex if ret is non null
 - If ret is negative -> goto done
 - If it's 1 -> reset ret to 0, release the path and finish the loop.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7930e1c78c45..a34eded1bfbe 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4667,11 +4667,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		}
 
 		ret = btrfs_previous_item(root, path, 0, key.type);
-		if (ret)
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
-		if (ret < 0)
-			goto done;
 		if (ret) {
+			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			if (ret < 0)
+				goto done;
 			ret = 0;
 			btrfs_release_path(path);
 			break;
-- 
2.25.1

