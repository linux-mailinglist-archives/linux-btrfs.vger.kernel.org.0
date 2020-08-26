Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2C2526CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 08:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHZG2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 02:28:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgHZG2M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 02:28:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 09B4238B05C1D0E2A5AF;
        Wed, 26 Aug 2020 14:28:09 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 14:27:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: Remove unused variable 'fs_info'
Date:   Wed, 26 Aug 2020 14:27:52 +0800
Message-ID: <20200826062752.20912-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs/btrfs/volumes.c: In function ‘btrfs_rm_dev_replace_free_srcdev’:
fs/btrfs/volumes.c:2217:24: warning: unused variable ‘fs_info’ [-Wunused-variable]
  struct btrfs_fs_info *fs_info = srcdev->fs_info;
                        ^~~~~~~

Caused by commit 65237ee3b6b3 ("btrfs: get fs_info from device
in btrfs_rm_dev_replace_free_srcdev")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/volumes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ec62fc0ec113..b775ed5d3737 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2214,7 +2214,6 @@ void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev)
 
 void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev)
 {
-	struct btrfs_fs_info *fs_info = srcdev->fs_info;
 	struct btrfs_fs_devices *fs_devices = srcdev->fs_devices;
 
 	mutex_lock(&uuid_mutex);
-- 
2.17.1


