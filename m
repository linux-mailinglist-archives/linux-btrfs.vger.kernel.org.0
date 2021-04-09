Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE835A26C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhDIP4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 11:56:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhDIP4d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Apr 2021 11:56:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 447B1AF10;
        Fri,  9 Apr 2021 15:56:19 +0000 (UTC)
Date:   Fri, 9 Apr 2021 10:56:44 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
Subject: [PATCH] btrfs-progs: Correct check_running_fs_exclop() return value
Message-ID: <20210409155644.qkk6puelfjvtjwqs@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

check_running_fs_exclop() can return 1 when exclop is changed to "none"
The ret is set by the return value of the select() operation. Checking
the exclusive op changes just the exclop variable while ret is still
set to 1.

Set ret exclusively if exclop is set to BTRFS_EXCL_NONE.
---
 common/utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/utils.c b/common/utils.c
index 57e41432..2e5175c3 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -2326,6 +2326,8 @@ int check_running_fs_exclop(int fd, enum exclusive_operation start, bool enqueue
 			tv.tv_sec /= 2;
 			ret = select(sysfs_fd + 1, NULL, NULL, &fds, &tv);
 			exclop = get_fs_exclop(fd);
+			if (exclop == BTRFS_EXCL_NONE)
+				ret = 0;
 			continue;
 		}
 	}
-- 
2.30.2
