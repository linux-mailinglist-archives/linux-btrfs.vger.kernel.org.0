Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BB125D78
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 10:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLSJSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 04:18:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfLSJSY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 04:18:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C8AFBD3AE4D14FCB733;
        Thu, 19 Dec 2019 17:18:22 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 17:18:13 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] btrfs: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 17:25:34 +0800
Message-ID: <1576747534-112105-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes coccicheck warning:

fs/btrfs/print-tree.c:320:3-4: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/btrfs/print-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 873b6b6..61f44e7 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -317,7 +317,7 @@ void btrfs_print_leaf(struct extent_buffer *l)
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
 					btrfs_item_size_nr(l, i));
 			break;
-		};
+		}
 	}
 }

--
2.7.4

