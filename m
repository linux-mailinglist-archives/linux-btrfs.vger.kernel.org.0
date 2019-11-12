Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F6F8F9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKLMYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:24:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:56776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfKLMYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:24:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E04EB194;
        Tue, 12 Nov 2019 12:24:22 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/5] btrfs: decrement number of open devices after closing the device not before
Date:   Tue, 12 Nov 2019 13:24:12 +0100
Message-Id: <20191112122416.30672-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191112122416.30672-1-jthumshirn@suse.de>
References: <20191112122416.30672-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_close_one_device we're decrementing the number of open devices
before we're calling btrfs_close_bdev().

As there is no intermediate exit between these points in this function it
is technically OK to do so, but it a) is a bit harder to understand and b)
further refactoring to implement proper error handling in
btrfs_close_one_device() will change the layout of the function.

Move both operations closer together and move the decrement step after
btrfs_close_bdev().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 22a5bd991e47..5ee26e7fca32 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1067,9 +1067,6 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	struct btrfs_device *new_device;
 	struct rcu_string *name;
 
-	if (device->bdev)
-		fs_devices->open_devices--;
-
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
 		list_del_init(&device->dev_alloc_list);
@@ -1080,6 +1077,8 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 		fs_devices->missing_devices--;
 
 	btrfs_close_bdev(device);
+	if (device->bdev)
+		fs_devices->open_devices--;
 
 	new_device = btrfs_alloc_device(NULL, &device->devid,
 					device->uuid);
-- 
2.16.4

