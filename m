Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E522D5D215
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGBOuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 10:50:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfGBOuJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 10:50:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3358780BBA68DC0EDB0A;
        Tue,  2 Jul 2019 22:39:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 22:39:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <jthumshirn@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] btrfs: Fix build error while LIBCRC32C is module
Date:   Tue, 2 Jul 2019 22:39:03 +0800
Message-ID: <20190702143903.49264-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If CONFIG_BTRFS_FS is y and CONFIG_LIBCRC32C is m,
building fails:

fs/btrfs/super.o: In function `btrfs_mount_root':
super.c:(.text+0xb7f9): undefined reference to `crc32c_impl'
fs/btrfs/super.o: In function `init_btrfs_fs':
super.c:(.init.text+0x3465): undefined reference to `crc32c_impl'
fs/btrfs/extent-tree.o: In function `hash_extent_data_ref':
extent-tree.c:(.text+0xe60): undefined reference to `crc32c'
extent-tree.c:(.text+0xe78): undefined reference to `crc32c'
extent-tree.c:(.text+0xe8b): undefined reference to `crc32c'
fs/btrfs/dir-item.o: In function `btrfs_insert_xattr_item':
dir-item.c:(.text+0x291): undefined reference to `crc32c'
fs/btrfs/dir-item.o: In function `btrfs_insert_dir_item':
dir-item.c:(.text+0x429): undefined reference to `crc32c'

Select LIBCRC32C to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 2521a24..df4041d 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -4,6 +4,7 @@ config BTRFS_FS
 	tristate "Btrfs filesystem support"
 	select CRYPTO
 	select CRYPTO_CRC32C
+	select LIBCRC32C
 	select CRYPTO_SHA256
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
-- 
2.7.4


