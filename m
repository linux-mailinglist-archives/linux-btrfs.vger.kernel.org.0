Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239EB27CC22
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgI2Mdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 08:33:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733073AbgI2MdZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 08:33:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8537ADD7272408A6F99D;
        Tue, 29 Sep 2020 20:33:18 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 20:33:12 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next]  btrfs: Fix wild pointer reference in btrfs_set_buffer_lockdep_class
Date:   Tue, 29 Sep 2020 20:33:57 +0800
Message-ID: <20200929123357.930605-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

'ks' is pointer type, but not initialized, so ks->keys will reference
wild pointer.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 177da507dc2a..7068d006d43f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -189,12 +189,12 @@ void __init btrfs_init_lockdep(void)
 void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 				    int level)
 {
-	struct btrfs_lockdep_keyset *ks;
+	struct btrfs_lockdep_keyset *ks = btrfs_lockdep_keysets;
 
 	BUG_ON(level >= ARRAY_SIZE(ks->keys));
 
 	/* find the matching keyset, id 0 is the default entry */
-	for (ks = btrfs_lockdep_keysets; ks->id; ks++)
+	for (; ks->id; ks++)
 		if (ks->id == objectid)
 			break;
 
-- 
2.25.4

