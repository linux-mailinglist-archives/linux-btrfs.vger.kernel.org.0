Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575AC10FA53
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 10:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLCJAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 04:00:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfLCJAE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 04:00:04 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 840A3E9970DE881E8608;
        Tue,  3 Dec 2019 17:00:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 16:59:56 +0800
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] btrfs: remove unused condition check in
 btrfs_page_mkwrite()
Message-ID: <d0053a0b-7fd0-153a-8a49-a0950005135c@huawei.com>
Date:   Tue, 3 Dec 2019 16:59:25 +0800
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

The condition '!ret2' is always true. commit 717beb96d969 ("Btrfs: fix
regression in btrfs_page_mkwrite() from vm_fault_t conversion") left
behind the check after moving this code out of the goto, so remove the
unused condition check.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
---
v1 -> v2:
 - update the commit comment

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

