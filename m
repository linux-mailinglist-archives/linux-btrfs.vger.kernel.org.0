Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7012FFFC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAVKFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:05:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:58352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbhAVKA3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wcvDCJxwp3C/EaUlW7l1QvCczkH+pgjDYBkbIqRvs8=;
        b=KQzGFkjbA4GdWuLE80Thi1EYOs/LlTUT5gVL0+V74sdmBlvlj0OG1wllhxpJV65wyoa0/L
        C2ZgN/rHlWrxm8zw8pwtIIBWuqaJWa9I8+ggUrLBe+kzZ3iJxC5Oo8G0Yo6QD7Z1DdiKpl
        EEjSX1gQgD8ny6JF6WfZAO5AKgwLFNE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA795B7AE;
        Fri, 22 Jan 2021 09:58:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 08/14] btrfs: Fix description format of fs_info parameter of btrfs_wait_on_delayed_iputs
Date:   Fri, 22 Jan 2021 11:57:59 +0200
Message-Id: <20210122095805.620458-9-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/inode.c:3101: warning: Function parameter or member 'fs_info' not described in 'btrfs_wait_on_delayed_iputs'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5906b4267204..72b892251764 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3088,8 +3088,9 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 }
 
 /**
- * btrfs_wait_on_delayed_iputs - wait on the delayed iputs to be done running
- * @fs_info - the fs_info for this fs
+ * Wait for flushing all delayed iputs
+ *
+ * @fs_info:  the fs_info for this fs
  * @return - EINTR if we were killed, 0 if nothing's pending
  *
  * This will wait on any delayed iputs that are currently running with KILLABLE
-- 
2.25.1

