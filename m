Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D528716599
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGOYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 10:24:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbfEGOYb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 10:24:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 285F9ACAE
        for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2019 14:24:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Add comments on locking of several device-related fields
Date:   Tue,  7 May 2019 17:24:28 +0300
Message-Id: <20190507142428.6531-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b97e8092ba7..514799362244 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -52,8 +52,8 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 
 struct btrfs_device {
-	struct list_head dev_list;
-	struct list_head dev_alloc_list;
+	struct list_head dev_list; /* device_list_mutex */
+	struct list_head dev_alloc_list; /* chunk mutex */
 	struct list_head post_commit_list; /* chunk mutex */
 	struct btrfs_fs_devices *fs_devices;
 	struct btrfs_fs_info *fs_info;
@@ -238,9 +238,14 @@ struct btrfs_fs_devices {
 	 * this mutex lock.
 	 */
 	struct mutex device_list_mutex;
+
+	/* List of all devices, protected by device_list_mutex */
 	struct list_head devices;
 
-	/* devices not currently being allocated */
+	/*
+	 * Devices which can satisfy space allocation. Protected by
+	 * chunk_mutex
+	 */
 	struct list_head alloc_list;
 
 	struct btrfs_fs_devices *seed;
-- 
2.17.1

