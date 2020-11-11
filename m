Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1108A2AF57D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 16:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKKPwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 10:52:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44678 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKKPwq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 10:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605109967; x=1636645967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7IBycp80RR/YgWQpPiu1Pme5Vh965UMbBxoo6/WFJqA=;
  b=rwlFfTiznwIaD3O6bQBwom+DYprdHQlj9TgyqZRNDdnb8lph+rfv4ti+
   hVW9w/igJpRYoHK0Bwn0Tz1ZCPk7iXjeBwC9TJ+rU5yEMqpkt2EH40O/M
   4xEQcC/yiWA1TQvB1m/Ztc+qcOormXap/mrA1h7GjWNwKXdmvZMoSFB8t
   8M/RHustuzm00bLJgrN+IUkID82Ew5XCDm6UwWu65xj03Unhj1hjNB0nr
   FvpZNe0r8vNqNBaNjtDNh6F96JN27pP5irmmwxabrB9wECUn4S5DRsGkd
   CRTpfQV5KvsGdq8YtT8olihDRAWD1DQ6kG9Wr3WoHMIf0/uVx840A2y20
   g==;
IronPort-SDR: v95FMn/FB6qI5kev5mLJfWl6bqlNtVra1Hh1sX5D/67G1kU7V/UARSmLqaawA0IfsSuqt+7DXH
 BD9EZ8Qqd2I8l8YoM8vT5T96byy8KVX/Xss8Dku66DaGA3De6hfq+3pWaQnYpcyHfSq3i7Q8tW
 y+TD84FX/mFeGoewH2o2qnd22FaJQ2syO8iF69DU4MLBuafKe58RHtigqMVckWWlBFi4q5fbk8
 4MQ7LDL4nWQc7dVJV5EiGbnOV+xkEJpu+POOlX0Im9uzLPU/HL8BlcXtia9JC4y1ugDaxXzphH
 VgI=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="153589966"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 23:52:46 +0800
IronPort-SDR: M8xjqCyiAskZ8prTCDCG19V/w5oshvCI+Mq+5mXgnvf/CnTZUfVm+dZOuwStosnVdGju+Namqo
 XB4agY+peuBCXgv808W/2qNc8LYN4gOymoBWI/G/VHoCO2+MnngcFiN203D/XinUePt9971eQG
 xQyK/Dbm796XRK4/lj3Bgv0lSHdG4PJj3cHURfl/G0JsH2/RoY88d1VSkzO4Cnjq8+S+0rG3j1
 CglOg6YlxLrV9+iR42JBRRHivLCVJxgnGGm8CE+eaiDyZhLlcjlzaCgqa+FUGzQz9whaf5JHIq
 +wu92Dap4rZtoaRkle+9LXOO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 07:38:45 -0800
IronPort-SDR: SyrI+pr9K30gRDueWmGyibGUWpL+e7W3XBHg7Ss6cgStet3hwtPMcFv4OC+ZpArikXGYhDTZBy
 AB1PxTg6Z4AkIP6yg09kb2TrXzBH8STKrfKpBmkgd8Xbz9ikIOTT3j7vIcEAh/uzGdZJH/SPPP
 qG0Wt/EX3MTBX6JuRu8upM7bkhhW4Owk+W3yoQij/DrzK54sW57bbBcop+mzFyQRV+TvRR31Q6
 diT3rNdvXedU+ksDESYf2rM8sJZ7fJjv4lrSU+MvLtXtPWAjE3+T4vuyb7xkZ1Jdlg0sNiNbbv
 Qbg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Nov 2020 07:52:45 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: hold device_list_mutex while accessing a btrfs_device's members
Date:   Thu, 12 Nov 2020 00:52:26 +0900
Message-Id: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A struct btrfs_device's lifetime in device_list_add() is protected by the
device_list_mutex. So don't drop the device_list_mutex when printing a
duplicate device warning in device_list_add.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c927dc597550..a653b778b49f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -939,12 +939,12 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 			if (device->bdev != path_bdev) {
 				bdput(path_bdev);
-				mutex_unlock(&fs_devices->device_list_mutex);
 				btrfs_warn_in_rcu(device->fs_info,
 	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
 						  path, devid, found_transid,
 						  current->comm,
 						  task_pid_nr(current));
+				mutex_unlock(&fs_devices->device_list_mutex);
 				return ERR_PTR(-EEXIST);
 			}
 			bdput(path_bdev);
-- 
2.26.2

