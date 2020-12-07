Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3780C2D14C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgLGPd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:33:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:45628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgLGPd1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:33:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuQzojAzewrCOlw0qW0ycRwc0gYoEafygZrs5mNy6Y0=;
        b=ax5t+IPmn/HNdYZNXdzLTI5xQhS6ET7cxfaovNMa72Jaen5MZaosp7sRYPL6N2dGDDg1oE
        lkMK+keYK+VyriN+D9w6bjreLCAgh7GrNMLlu98gOCWQU/sGCxlZeeYjfCZjg4N5W69Eaz
        q2SUP3N2S0d+U+MLaXKxcRANtGtLrA4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A40D7AD71;
        Mon,  7 Dec 2020 15:32:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/6] btrfs: Remove useless ASSERTS
Date:   Mon,  7 Dec 2020 17:32:34 +0200
Message-Id: <20201207153237.1073887-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The invariants the asserts are checking are already verified by the
tree checker, just remove them.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4c3dda0034b5..eaaece2bf0c8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1373,8 +1373,6 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 		goto fail;
 	}
 
-	ASSERT(root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
-
 	mutex_unlock(&root->objectid_mutex);
 
 	return 0;
@@ -2651,7 +2649,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 
-		ASSERT(tree_root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
 
 		ret = btrfs_read_roots(fs_info);
 		if (ret < 0) {
-- 
2.25.1

