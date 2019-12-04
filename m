Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C861C112CBD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfLDNhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 08:37:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDNhO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 08:37:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so8616561wrf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 05:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eL6SHVGCBkpkreaEUkpbhItxmp0I+pp5HgBAK2WSy0c=;
        b=soxB5sSAMfBRAJyxpHgkt6olO97mP7ZmKzrceT1iInIfZLf9JhhaKt1JQ+OxS7a0rY
         gFkRtb0MWtfCb9+84GuYlKbtTNNISA1Ek1F4hoH9YBKX+EGPC3+1ju8XssVIjvOmh7nG
         6gqhkGJb2FnBVd1HtbWeLfgU3C62nV2AJsGVGMQtUUH61eUYXscIG9udGQ1UGT0sHec8
         1k0QYFVcOTw/SCSGQlXbb1hPH9wA/1euQWQ9yWfXtc+UijzSXMvGptCIaDL52rn1YWJl
         lhv8lgF1uLbeqRdTjhWYEBYYzKndY5OBga089XKb91JXS+FGTC8w2/sppDMWcg72BtdF
         NXHQ==
X-Gm-Message-State: APjAAAVAjoPj6p460ZrcXEKym6MwPr0Ahlb+6vV0taAwcj1RiuTav0px
        g+DCBd9nHZ9qm1nzK2tZ7mnZ7erAz8c=
X-Google-Smtp-Source: APXvYqy70eNj7gSIz+lUQyA0ckoaxQsx7gxo5kKOxz9fEbEizL3+1eKR1THgrTPnY0YPNdeOrdlrAg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr3780088wrm.139.1575466632629;
        Wed, 04 Dec 2019 05:37:12 -0800 (PST)
Received: from localhost.localdomain (ppp-46-244-211-33.dynamic.mnet-online.de. [46.244.211.33])
        by smtp.gmail.com with ESMTPSA id q3sm8291948wrn.33.2019.12.04.05.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 05:37:12 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 2/2] btrfs: reset device back to allocation state when removing
Date:   Wed,  4 Dec 2019 14:36:39 +0100
Message-Id: <20191204133639.2382-3-jth@kernel.org>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20191204133639.2382-1-jth@kernel.org>
References: <20191204133639.2382-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

When closing a device, btrfs_close_one_device() first allocates a new
device, copies the device to close's name, replaces it in the dev_list
with the copy and then finally frees it.

This involves two memory allocation, which can potentially fail. As this
code path is tricky to unwind, the allocation failures where handled by
BUG_ON()s.

But this copying isn't strictly needed, all that is needed is resetting
the device in question to it's state it had after the allocation.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v4:
- Clear dev_stat_ccnt on removal (Dave)
- Don't clear BTRFS_DEV_STATE_MISSING and BTRFS_DEV_STATE_FS_METADATA as
  they'll be handled elsewhere
- Release extent_io_tree (fstests)

Changes to v3:
- Clear DEV_STATE_WRITABLE _after_ btrfs_close_bdev() (Nik)
---
 fs/btrfs/volumes.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae3980ba3a87..eef0b9ed9ea4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1066,8 +1066,6 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 static void btrfs_close_one_device(struct btrfs_device *device)
 {
 	struct btrfs_fs_devices *fs_devices = device->fs_devices;
-	struct btrfs_device *new_device;
-	struct rcu_string *name;
 
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -1079,25 +1077,21 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 		fs_devices->missing_devices--;
 
 	btrfs_close_bdev(device);
-	if (device->bdev)
+	if (device->bdev) {
 		fs_devices->open_devices--;
-
-	new_device = btrfs_alloc_device(NULL, &device->devid,
-					device->uuid);
-	BUG_ON(IS_ERR(new_device)); /* -ENOMEM */
-
-	/* Safe because we are under uuid_mutex */
-	if (device->name) {
-		name = rcu_string_strdup(device->name->str, GFP_NOFS);
-		BUG_ON(!name); /* -ENOMEM */
-		rcu_assign_pointer(new_device->name, name);
+		device->bdev = NULL;
 	}
+	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 
-	list_replace_rcu(&device->dev_list, &new_device->dev_list);
-	new_device->fs_devices = device->fs_devices;
+	atomic_set(&device->dev_stats_ccnt, 0);
+	extent_io_tree_release(&device->alloc_state);
 
-	synchronize_rcu();
-	btrfs_free_device(device);
+	/* Verify the device is back in a pristine state  */
+	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
+	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
+	ASSERT(list_empty(&device->dev_alloc_list));
+	ASSERT(list_empty(&device->post_commit_list));
+	ASSERT(atomic_read(&device->reada_in_flight) == 0);
 }
 
 static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
-- 
2.20.1 (Apple Git-117)

