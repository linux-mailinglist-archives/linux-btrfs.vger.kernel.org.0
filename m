Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD54DB5FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbiCPQWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiCPQW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 12:22:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0946D4CD
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647447674; x=1678983674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAtx5mHlcLeSh2Bn645SdGh5KbMFQeLg5iHYkqKsf4U=;
  b=OhYwPd1b+CTUPBYI6UzmypV5vDZ7sh8FnsVxKjMEsD6SXie2kQ3utMiX
   X7H2XiyuQOLQctWs9QI0MhkseI+DGi0+56QMJYU0+JQHmR25EmbzQ/dqW
   PTFChZmUv7cIksqQhxUy0W0ptlweNApYO9iaZdFiT0XnFLgvMabSlTklB
   0PnppIXppn8RWf4wm7C9dpQJyUrosGJgrAaj2QKHoMQWdw2nbegYzkB1A
   bo6MVrMRn3VnBv0ciWxVQisMlPAcZhQ6AJ1NzPe/W203J1cDpEGJijFeJ
   Pk1wUo7oj999ecaK7LLcNySfAz44VLwwngHcmnwBYUhNXA5WuzGeBgYHJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,187,1643644800"; 
   d="scan'208";a="299670501"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 00:21:13 +0800
IronPort-SDR: 0p/iodofn6Dxe00CokUvIsKj6zkkKPR8yfjD9y2PwrC5NiM2SMP6EqvLxaoASYcreBMW2yhKP0
 FZyJM60vmti1MYdh6EFIbHTa7khGh8G17J9GQdizrKndrMiac6CNN57yE6AwCdUmfjsx5TXNzc
 zknsohbtyZxQRweDTogiQ1nrlkCf6BmQ+RAxCcZMOghZ9V9QZiPuo/uKzP5vxLXJwC8hEH/JUl
 QLj15yT63JtWWrlin9e3jYrj5N+XsA+scFF5Va9KC8NDIXk9j6kzV4/0wSNzD9btKTY0+IqBR0
 QeaZH1/y9hRfudpO1NFnoFi0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:53:17 -0700
IronPort-SDR: LR3cKF5jDisijrcg/Hu5aXiYKrx/DA86kHNxISuHMDWMXX77IzUrhwzbhMj65FJ7n43joHu++a
 B9q9sj0GZdGnkIJxUZvpJEXHDdq+4xiGayaM+qA00cQKEr0xG7zwSKTjYycEmReRFMHKv34qkU
 8WtYtBNYLIzyyAsLxBu6T43JUk1mOHXdqCyE2i+AtJi/niOlF8FetjZ43raMDZ5eLH/IlhlWwF
 n1L7N3bUZ2sYScZgWmYbumrcM0Z+LoSFYMgykE8+qlGEEEtOzNwpYkU78bd9TxA4ODNjPmyX5i
 bKg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Mar 2022 09:21:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: zoned: use alloc_list instead of RCU locked device_list
Date:   Wed, 16 Mar 2022 09:21:12 -0700
Message-Id: <c13ae130cf4d170da60d9bde63de78e3583611df.1647425970.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Anand pointed out, that instead of using the RCU locked version of
fs_devices->device_list we can use fs_devices->alloc_list, protected by
the chunk_mutex to traverse the list of active devices in
btrfs_can_activate_zone().

We are in the chunk allocation thread. The newer chunk allocation
happens from the devices in the fs_device->alloc_list protected by the
chunk_mutex.

  btrfs_create_chunk()
    lockdep_assert_held(&info->chunk_mutex);
    gather_device_info
      list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)

Also, a device that reappears after the mount won't join the alloc_list
yet and, it will be in the dev_list, which we don't want to consider in
the context of the chunk alloc.

Suggested-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes since v1:
* Fix crash Anand reported
---
 fs/btrfs/zoned.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 49446bb5a5d1..1b1b310c3c51 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1975,15 +1975,16 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
+	struct btrfs_fs_info *fs_info = fs_devices->fs_info;
 	struct btrfs_device *device;
 	bool ret = false;
 
-	if (!btrfs_is_zoned(fs_devices->fs_info))
+	if (!btrfs_is_zoned(fs_info))
 		return true;
 
 	/* Check if there is a device with active zones left */
-	rcu_read_lock();
-	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
+	mutex_lock(&fs_info->chunk_mutex);
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 
 		if (!device->bdev)
@@ -1995,7 +1996,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 			break;
 		}
 	}
-	rcu_read_unlock();
+	mutex_unlock(&fs_info->chunk_mutex);
 
 	return ret;
 }
-- 
2.35.1

