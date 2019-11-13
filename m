Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3249FAE74
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 11:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKMK1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 05:27:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:48238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbfKMK1j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18174B2C3;
        Wed, 13 Nov 2019 10:27:37 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 4/7] btrfs: handle error return of close_fs_devices()
Date:   Wed, 13 Nov 2019 11:27:25 +0100
Message-Id: <20191113102728.8835-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113102728.8835-1-jthumshirn@suse.de>
References: <20191113102728.8835-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

close_fs_devices() will be able to return an error instead of crashing
after the following patch.

Prepare btrfs_close_devices() for this.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e5864ca3bb3b..be1fd935edf7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1143,10 +1143,10 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_fs_devices *seed_devices = NULL;
-	int ret;
+	int err, err2 = 0;
 
 	mutex_lock(&uuid_mutex);
-	ret = close_fs_devices(fs_devices);
+	err = close_fs_devices(fs_devices);
 	if (!fs_devices->opened) {
 		seed_devices = fs_devices->seed;
 		fs_devices->seed = NULL;
@@ -1156,10 +1156,13 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 	while (seed_devices) {
 		fs_devices = seed_devices;
 		seed_devices = fs_devices->seed;
-		close_fs_devices(fs_devices);
+		err2 = close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
 	}
-	return ret;
+
+	if (err2)
+		return err2;
+	return err;
 }
 
 static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
-- 
2.16.4

