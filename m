Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9CFAE73
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 11:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKMK1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 05:27:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:48156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbfKMK1i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6C55B2DC;
        Wed, 13 Nov 2019 10:27:36 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 0/7] remove BUG_ON()s in btrfs_close_one_device()
Date:   Wed, 13 Nov 2019 11:27:21 +0100
Message-Id: <20191113102728.8835-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series attempts to remove the BUG_ON()s in btrfs_close_one_device().
Therefore some reorganization of btrfs_close_one_device() and
close_fs_devices() was needed.

Forthermore a new BUG_ON() had to be temporarily introduced but is removed
again in the last patch of theis series.

Although it is generally legal to return -ENOMEM on umount(2), the error
handling up until close_ctree() as neither close_ctree() nor btrfs_put_super()
would be able to handle the error.

This series has passed fstests without any deviation from the baseline and
also the new error handling was tested via error injection using this snippet:

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7c55169c0613..c58802c9c39c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1069,6 +1069,9 @@ static int btrfs_close_one_device(struct btrfs_device *device)
 
 	new_device = btrfs_alloc_device(NULL, &device->devid,
 					device->uuid);
+	btrfs_free_device(new_device);
+	pr_err("%s() INJECTING -ENOMEM\n", __func__);
+	new_device = ERR_PTR(-ENOMEM);
 	if (IS_ERR(new_device))
 		return PTR_ERR(new_device);

Changes to v1:

Fixed the decremt of btrfs_fs_devices::seeding.

In addition to this, I've added two patches changing btrfs_fs_devices::seeding
and btrfs_fs_devices::rotating to bool, as they are in fact used as booleans.

Johannes Thumshirn (7):
  btrfs: decrement number of open devices after closing the device not
    before
  btrfs: handle device allocation failure in btrfs_close_one_device()
  btrfs: handle allocation failure in strdup
  btrfs: handle error return of close_fs_devices()
  btrfs: remove final BUG_ON() in close_fs_devices()
  btrfs: change btrfs_fs_devices::seeing to bool
  btrfs: change btrfs_fs_devices::rotating to bool

 fs/btrfs/volumes.c | 81 ++++++++++++++++++++++++++++++++++++------------------
 fs/btrfs/volumes.h |  4 +--
 2 files changed, 56 insertions(+), 29 deletions(-)

-- 
2.16.4

