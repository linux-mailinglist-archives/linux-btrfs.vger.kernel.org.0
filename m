Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABF229322
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgGVIJ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 04:09:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbgGVIJ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 04:09:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC1C5AFF7;
        Wed, 22 Jul 2020 08:09:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/4] btrfs: Don't opencode sync_blockdev
Date:   Wed, 22 Jul 2020 11:09:25 +0300
Message-Id: <20200722080925.6802-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722080925.6802-1-nborisov@suse.com>
References: <20200722080925.6802-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of opencoding filemap_write_and_wait simply call syncblockdev as
it makes it abundandtly clear what's going on and why this is used. No
semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 17047c118969..d42571f36fcf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2499,7 +2499,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		locked = true;
 	}
 
-	filemap_write_and_wait(bdev->bd_inode->i_mapping);
+	sync_blockdev(bdev);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-- 
2.17.1

