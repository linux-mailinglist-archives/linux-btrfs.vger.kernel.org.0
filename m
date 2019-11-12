Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4686CF8FA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKLMYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:24:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbfKLMYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:24:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6543B287;
        Tue, 12 Nov 2019 12:24:22 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/5] btrfs: handle error return of close_fs_devices()
Date:   Tue, 12 Nov 2019 13:24:15 +0100
Message-Id: <20191112122416.30672-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191112122416.30672-1-jthumshirn@suse.de>
References: <20191112122416.30672-1-jthumshirn@suse.de>
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

