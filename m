Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EF167DE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgBUNCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:02:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:40008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgBUNCj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:02:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2B02AD2D;
        Fri, 21 Feb 2020 13:02:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80A81DA70E; Fri, 21 Feb 2020 14:02:20 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: use ioctl args support mask for device delete
Date:   Fri, 21 Feb 2020 14:02:20 +0100
Message-Id: <35813380382186dcd381e759e665f59f77c1f287.1582289899.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582289899.git.dsterba@suse.com>
References: <cover.1582289899.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the device remove v2 ioctl was added, the full support mask was
added to sanity check the flags. However this would allow to let the
subvolume related flags to be accepted. This is not supposed to happen.

Use the correct support mask, which means that now any of
BTRFS_SUBVOL_CREATE_ASYNC, BTRFS_SUBVOL_RDONLY or
BTRFS_SUBVOL_QGROUP_INHERIT will be rejected as ENOTSUPP. Though this is
a user-visible change, specifying subvolume flags for device deletion
does not make sense and there are hopefully no applications doing that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a7872cacd0aa..cd2d11dcd477 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3075,8 +3075,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto err_drop;
 	}
 
-	/* Check for compatibility reject unknown flags */
-	if (vol_args->flags & ~BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED) {
+	if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.25.0

