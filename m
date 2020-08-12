Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE6242AEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLOEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 10:04:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHLOEi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 10:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A50CAD12;
        Wed, 12 Aug 2020 14:04:59 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Document some invariants of seed code
Date:   Wed, 12 Aug 2020 17:04:36 +0300
Message-Id: <20200812140436.11749-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Without good understanding of how seed devices works it's hard to grok
some of what the code in open_seed_devices or btrfs_prepare_sprout does.

Add comments hopefully reducing some of the cognitive load.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 631cb03b3513..f7ee7837e6bc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2361,10 +2361,20 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	if (!fs_devices->seeding)
 		return -EINVAL;
 
+	/*
+	 * Private copy of the seed devices, anchored at
+	 * fs_info->fs_devices->seed_list
+	 */
 	seed_devices = alloc_fs_devices(NULL, NULL);
 	if (IS_ERR(seed_devices))
 		return PTR_ERR(seed_devices);
 
+	/*
+	 * It's necessary to retain a copy of the original seed fs_devices in
+	 * fs_uuids so that filesystems which have been seeded can be
+	 * successfully reference the seed device from open_seed_devices. This
+	 * also supports multiple fs seed.
+	 */
 	old_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(old_devices)) {
 		kfree(seed_devices);
@@ -6713,6 +6723,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	lockdep_assert_held(&uuid_mutex);
 	ASSERT(fsid);
 
+	/* This will match only for multi-device seed fs */
 	list_for_each_entry(fs_devices, &fs_info->fs_devices->seed_list, seed_list)
 		if (!memcmp(fs_devices->fsid, fsid, BTRFS_FSID_SIZE))
 			return fs_devices;
@@ -6732,6 +6743,10 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		return fs_devices;
 	}
 
+	/*
+	 * Upon first call for a seed fs fsid just create a private copy of the
+	 * respective fs_devices and anchor it at fs_info->fs_devices->seed_list
+	 */
 	fs_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(fs_devices))
 		return fs_devices;
-- 
2.17.1

