Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7057F27DE2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgI3B5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbgI3B53 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTFqggKtYVDEOn8mkUOTe1+I+Lj715IkCZSDlviaapo=;
        b=HLqC+DYBwMoh8SIpgqiepFKgKEDqrwgzsoeBb/4XHMKbAvAWEjIkc5RGclxyrppRRaBa1w
        Rb4xUNRN3bE3d1cQ6SWG06RFOPtgRFQ0ZXBMWL+3YTcVlQOynFbF5A4GPYaD4yU3VwCvbr
        zmiVJmYx/KsfUQmy2UPg3PxG6vB7B0Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1D63AF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 49/49] btrfs: support metadata read write for test
Date:   Wed, 30 Sep 2020 09:55:39 +0800
Message-Id: <20200930015539.48867-50-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ----------
 fs/btrfs/file.c    |  4 ++++
 fs/btrfs/super.c   |  7 -------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2ac980f739dc..8b5f65e6c5fa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3335,16 +3335,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	/* For 4K sector size support, it's only read-only yet */
-	if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
-		if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
-			btrfs_err(fs_info,
-				"subpage sector size only support RO yet");
-			err = -EINVAL;
-			goto fail_alloc;
-		}
-	}
-
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4507c3d09399..0785e16ba243 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1937,6 +1937,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	loff_t oldsize;
 	int clean_page = 0;
 
+	/* Don't support data write yet */
+	if (btrfs_is_subpage(fs_info))
+		return -EOPNOTSUPP;
+
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 743a2fadf4ee..25967ecaaf0a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1922,13 +1922,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			ret = -EINVAL;
 			goto restore;
 		}
-		if (btrfs_is_subpage(fs_info)) {
-			btrfs_warn(fs_info,
-	"read-write mount is not yet allowed for sector size %u page size %lu",
-				   fs_info->sectorsize, PAGE_SIZE);
-			ret = -EINVAL;
-			goto restore;
-		}
 
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
-- 
2.28.0

