Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604CB242A4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 15:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHLN0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 09:26:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgHLN0t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 09:26:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63DD1AF30;
        Wed, 12 Aug 2020 13:27:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove alloc_list splice in btrfs_prepare_sprout
Date:   Wed, 12 Aug 2020 16:26:46 +0300
Message-Id: <20200812132646.9638-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_prepare_sprout is called when the first rw device is added to a
seed filesystem. This means the filesystem can't have its alloc_list
be non-empty, since seed filesystems are read only. Simply remove the
code altogether.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 71480175e8cb..4bae30b9c944 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2385,10 +2385,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
 		device->fs_devices = seed_devices;
 
-	mutex_lock(&fs_info->chunk_mutex);
-	list_splice_init(&fs_devices->alloc_list, &seed_devices->alloc_list);
-	mutex_unlock(&fs_info->chunk_mutex);
-
 	fs_devices->seeding = false;
 	fs_devices->num_devices = 0;
 	fs_devices->open_devices = 0;
-- 
2.17.1

