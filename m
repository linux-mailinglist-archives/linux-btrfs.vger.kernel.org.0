Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0336A204CAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 10:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgFWIkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 04:40:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11901 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731803AbgFWIkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 04:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592901636; x=1624437636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DVhoc0dUvAbdutxDMfl7BUKLe758G7vlOIrvpwuEmP4=;
  b=oQk+zUt4xcugkIXksFIyhFc8xmrwPg0qYSBc162ftKJUm3I3hDncXq4S
   xlrZfU2p8TeHArzh/u7rvfM2fb0jfjHbpd8REDTEFYqZOlp+7tmXY7PJ/
   O0UZKHPtjm4GDjIzYwIQQhwSztKBwIfGTA5/KwNpcXieewtOg2HfLk27Z
   +B9KMxph0olqCevjQHgAKetTOJMIjblW5dr75DNUwnFhCaQeF6obLTjOr
   zWVV7HK4hPkeSpKRD2Rxctn8ToFZecz7zGPwCeRRTjxYGfvv9PD0o1U9W
   ChTzCmZYKMng3OYAXnIy5rjfY3qFjOo0AIEgH/ZDQZCKvJxaSZcgdG4/1
   A==;
IronPort-SDR: JmwTVLBXIEQSkk0yoe5uIs+ktekjVfQrJzywrSq9CmZbryjMugm5K7zHOiEWzMtf90R3Av6q6T
 OvdUv2QIxOb5uwK+yi/UhX4fHKkpGTt/yAX1sl50C7SEUtM+WY3+0jqBDErrRIrqtsJXzY1QTc
 /Rx33rWRi2aEQe94R9mT0g8e2CYS2gPYqkCTn0axRHOCvCoXAUS6TnTMUQK64xY3ryEF4JKJbX
 p7CXPWCjn9eh8xDZJlemmTL4SLLPvsHOjGD25EhnO+KTaFZ4jd0UPZ5D8tX4Rly4Sov6XTOw1H
 +Rw=
X-IronPort-AV: E=Sophos;i="5.75,270,1589212800"; 
   d="scan'208";a="243677074"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 16:40:36 +0800
IronPort-SDR: 9kMqqM9UYSuJ1Rp80RNHxmxWZWc9icxe2V5EmS/rDAGcul5NzjlqKObux73Kf0cqmUQlLPciAP
 7I/SguoR4IfmPY2UYBwH3tGlbmflSxuXU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 01:28:47 -0700
IronPort-SDR: HsrUV+FZHFURDchC8MGtynzdg9NH7oIkqM2D94IcG4+FlojS9RUyTo1TerEmbB4SzbxtETtNe2
 ZXpm+VD6b7nQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jun 2020 01:40:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: use free_root_extent_buffer to free root
Date:   Tue, 23 Jun 2020 17:40:07 +0900
Message-Id: <20200623084007.34215-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_put_root() we're freeing a btrfs_root's 'node' and 'commit_root'
extent buffers manually via kfree(), while we're using
free_root_extent_buffers() in the free_root_pointers() function above.

free_root_extent_buffers() also NULLs the pointers after freeing, which
mitigates potential double frees.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c70d47b8090a..b86961309b0d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2001,8 +2001,7 @@ void btrfs_put_root(struct btrfs_root *root)
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
-		free_extent_buffer(root->node);
-		free_extent_buffer(root->commit_root);
+		free_root_extent_buffers(root);
 		kfree(root->free_ino_ctl);
 		kfree(root->free_ino_pinned);
 #ifdef CONFIG_BTRFS_DEBUG
-- 
2.26.2

