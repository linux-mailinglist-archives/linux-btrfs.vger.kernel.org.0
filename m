Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D550220A6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGOKsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 06:48:53 -0400
Received: from [195.135.220.15] ([195.135.220.15]:37922 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgGOKsw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 06:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 079A1ADC2;
        Wed, 15 Jul 2020 10:48:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/5] btrfs: Factor out reada loop in __reada_start_machine
Date:   Wed, 15 Jul 2020 13:48:46 +0300
Message-Id: <20200715104850.19071-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715104850.19071-1-nborisov@suse.com>
References: <20200715104850.19071-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is in preparation for moving fs_devices to proper lists.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/reada.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 243a2e44526e..aa9d24ed56d7 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -767,15 +767,14 @@ static void reada_start_machine_worker(struct btrfs_work *work)
 	kfree(rmw);
 }
 
-static void __reada_start_machine(struct btrfs_fs_info *fs_info)
+
+/* Try to start up to 10k READA requests for a group of devices. */
+static int __reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)
 {
-	struct btrfs_device *device;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	u64 enqueued;
 	u64 total = 0;
-	int i;
+	struct btrfs_device *device;
 
-again:
 	do {
 		enqueued = 0;
 		mutex_lock(&fs_devices->device_list_mutex);
@@ -787,6 +786,18 @@ static void __reada_start_machine(struct btrfs_fs_info *fs_info)
 		mutex_unlock(&fs_devices->device_list_mutex);
 		total += enqueued;
 	} while (enqueued && total < 10000);
+
+	return total;
+}
+
+static void __reada_start_machine(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	int i;
+	u64 enqueued = 0;
+
+again:
+	enqueued += __reada_start_for_fsdevs(fs_devices);
 	if (fs_devices->seed) {
 		fs_devices = fs_devices->seed;
 		goto again;
-- 
2.17.1

