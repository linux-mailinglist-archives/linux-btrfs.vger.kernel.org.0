Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3F2FCFDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbhATMPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:15:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:37886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbhATK10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uT8/VvrF8b2zmVsgA7ZwS5+AHiVfq4utWWMf6YpYLA=;
        b=RVmYXP4u3GbogLI0VPGMD5eTqoY5Zjl9oq8Q7K6ubeger9vhiRqUychLwvnD47338mrgMX
        00398ms+8TUicb/YIpwSva0fVvYZmCdQa8Wi7IXaECF58bthO5CkfsH/pQ8T3Ry33lxlu4
        lZfVSqS/6fma4UBgIOzUOhGdp/xqhzs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C74FBAFF9;
        Wed, 20 Jan 2021 10:25:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 08/14] btrfs: Fix description format of fs_info parameter of btrfs_wait_on_delayed_iputs
Date:   Wed, 20 Jan 2021 12:25:20 +0200
Message-Id: <20210120102526.310486-9-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/inode.c:3101: warning: Function parameter or member 'fs_info' not described in 'btrfs_wait_on_delayed_iputs'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5906b4267204..b6711c207808 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3089,7 +3089,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 
 /**
  * btrfs_wait_on_delayed_iputs - wait on the delayed iputs to be done running
- * @fs_info - the fs_info for this fs
+ * @fs_info:  the fs_info for this fs
  * @return - EINTR if we were killed, 0 if nothing's pending
  *
  * This will wait on any delayed iputs that are currently running with KILLABLE
-- 
2.25.1

