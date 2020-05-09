Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187711CC0E4
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEILXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 07:23:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbgEILXI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 07:23:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD8CBFC340B6D1C401E5;
        Sat,  9 May 2020 19:23:03 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 19:22:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: Remove unused inline function btrfs_dev_extent_chunk_tree_uuid
Date:   Sat, 9 May 2020 19:22:43 +0800
Message-ID: <20200509112243.54176-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's no callers in-tree anymore since
commit d24ee97b96db ("btrfs: use new helpers to set uuids in eb")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/ctree.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 03ea7370aea7..0b78ab0213bb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1643,13 +1643,6 @@ BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
 BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
 		   chunk_offset, 64);
 BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
-
-static inline unsigned long btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
-{
-	unsigned long ptr = offsetof(struct btrfs_dev_extent, chunk_tree_uuid);
-	return (unsigned long)dev + ptr;
-}
-
 BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
 BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item,
 		   generation, 64);
-- 
2.17.1


