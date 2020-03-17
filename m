Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B01879C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 07:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgCQGkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 02:40:18 -0400
Received: from mail.synology.com ([211.23.38.101]:34916 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgCQGkR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 02:40:17 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 02:40:17 EDT
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 65D55DB18374;
        Tue, 17 Mar 2020 14:31:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1584426675; bh=Lh9iSPfSVcgqea/3F5iZg07vm7hQvgHQi8/FpeorqqA=;
        h=From:To:Cc:Subject:Date;
        b=mEV/5lzuoy1bIyC4fRxM3av6hdOAAStIh0ojUqhhO+w+2QfBm9F9hhmoxNwq7+DOE
         AQ6uMkjDFB0jjZisjxiLRc4lnfEivqf2NjvbKxb0HkPf/8nxZfYPscJpQmC7ETt+kE
         Yj9SZ7gieD1BBO3humYyRo8XnH2bm8bNzpkD5DaI=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH] Btrfs: fix missing semaphore unlock
Date:   Tue, 17 Mar 2020 14:31:02 +0800
Message-Id: <20200317063102.8869-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

Fixes: aab15e8ec2576 ("Btrfs: fix rare chances for data loss when doing a fast fsync")
Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a16da274c9aa..ae903da21588 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2124,6 +2124,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
+		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
-- 
2.17.1

