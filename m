Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553332FBA0E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbhASOlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:41:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:37988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390723AbhASM3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uT8/VvrF8b2zmVsgA7ZwS5+AHiVfq4utWWMf6YpYLA=;
        b=ILfScqGrPWAU6pX3F9XDR9GFjtbycjOsL6JmFF5ZZB2U5473Ndfd+7tnYROeEuESIr3zxz
        4wOZDvqkvgdhMMegwt0Xb7OYmfLYUC+pdu4v6AQciove7ZHbVz5NkTJAKwIlSRWl5QgxIO
        vKCJnX6sc164BB6GfdjH3KA0LuhQhsc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 162C2AF49;
        Tue, 19 Jan 2021 12:26:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/13] btrfs: Fix description format of fs_info parameter of btrfs_wait_on_delayed_iputs
Date:   Tue, 19 Jan 2021 14:26:44 +0200
Message-Id: <20210119122649.187778-9-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
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

