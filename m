Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAABD7A06
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfJOPmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfJOPma (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3959B520;
        Tue, 15 Oct 2019 15:42:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/8] btrfs: Remove newest_gen argument from find_oldest_super_backup
Date:   Tue, 15 Oct 2019 18:42:18 +0300
Message-Id: <20191015154224.21537-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's no longer needed following cleanups around find_newest_backup_root
---
 fs/btrfs/disk-io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8b1f6385023d..d51f76abde45 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1792,8 +1792,7 @@ static int find_newest_super_backup(struct btrfs_fs_info *info)
  * in the backup array.  This will set the backup_root_index
  * field in the fs_info struct
  */
-static void find_oldest_super_backup(struct btrfs_fs_info *info,
-				     u64 newest_gen)
+static void find_oldest_super_backup(struct btrfs_fs_info *info)
 {
 	int newest_index;
 
@@ -2831,8 +2830,7 @@ int __cold open_ctree(struct super_block *sb,
 	 * run through our array of backup supers and setup
 	 * our ring pointer to the oldest one
 	 */
-	generation = btrfs_super_generation(disk_super);
-	find_oldest_super_backup(fs_info, generation);
+	find_oldest_super_backup(fs_info);
 
 	/*
 	 * In the long term, we'll store the compression type in the super
-- 
2.17.1

