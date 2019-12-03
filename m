Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245CC10F995
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 09:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCIQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 03:16:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfLCIQz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 03:16:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 755A1C86D53108544065;
        Tue,  3 Dec 2019 16:16:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 16:16:45 +0800
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] btrfs: remove unused condition check in btrfs_page_mkwrite()
Message-ID: <a84442bc-304b-2514-272e-ea89aae4b992@huawei.com>
Date:   Tue, 3 Dec 2019 16:16:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The condition '!ret2' is always true. so remove the unused condition
check.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 fs/btrfs/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 56032c518b26..eef2432597e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9073,7 +9073,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
-	ret2 = 0;

 	/* page is wholly or partially inside EOF */
 	if (page_start + PAGE_SIZE > size)
@@ -9097,12 +9096,10 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)

 	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);

-	if (!ret2) {
-		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-		sb_end_pagefault(inode->i_sb);
-		extent_changeset_free(data_reserved);
-		return VM_FAULT_LOCKED;
-	}
+	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	sb_end_pagefault(inode->i_sb);
+	extent_changeset_free(data_reserved);
+	return VM_FAULT_LOCKED;

 out_unlock:
 	unlock_page(page);
-- 
2.7.4

