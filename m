Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2196F8FA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKLMYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:24:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbfKLMYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:24:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE2E0B2CE;
        Tue, 12 Nov 2019 12:24:22 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 5/5] btrfs: remove final BUG_ON() in close_fs_devices()
Date:   Tue, 12 Nov 2019 13:24:16 +0100
Message-Id: <20191112122416.30672-6-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191112122416.30672-1-jthumshirn@suse.de>
References: <20191112122416.30672-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the preparation work is done, remove the temporary BUG_ON() in
close_fs_devices() and return an error instead.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index be1fd935edf7..844333b96075 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1128,7 +1128,12 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
 		ret = btrfs_close_one_device(device);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			return ret;
+		}
+		fs_devices->opened--;
+		fs_devices->seeding--;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-- 
2.16.4

