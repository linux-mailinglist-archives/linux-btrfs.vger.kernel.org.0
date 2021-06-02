Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BFF397EBA
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFBCRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:17:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFBCRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 22:17:33 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 61E8A2194F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622600150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vwFTmM02cGQqGELC/UPd4DxOACzV4CQrjYSS/FDYl4=;
        b=USWzIbE+XMkNzht7IGWIVzVcUiJVFzAGA8tLGxz+hYzXQjIL4VG0gyhY4rRBKDq4ydJ3zo
        ngPoWk7LAozMpZTGzamYH7v9PbhA0w4YVRnaqDnL2GFQZJt5EGl7nZDw3LBZVlH9UdhwRT
        P6uEH7eMnJl4XERLO8jSjcPxolakDh8=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 5FAF9A3B84
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/10] btrfs: defrag: enable defrag for subpage case
Date:   Wed,  2 Jun 2021 10:15:28 +0800
Message-Id: <20210602021528.68617-11-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602021528.68617-1-wqu@suse.com>
References: <20210602021528.68617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the new infrasturture which has taken subpage into consideration,
now we should be safe to allow defrag to work for subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be39ce0f3f9d..f0618756d4d9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2970,12 +2970,6 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		goto out;
 	}
 
-	/* Subpage defrag will be supported in later commits */
-	if (root->fs_info->sectorsize < PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out;
-	}
-
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFDIR:
 		if (!capable(CAP_SYS_ADMIN)) {
-- 
2.31.1

