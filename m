Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8531816B844
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgBYD5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603025; x=1614139025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUGVNLNv/Xw1+4E0FweGNhJuWYzoIgjs7aWOG25iDyo=;
  b=C24u+x5ujizJutypIotzv6Pw9baaVyN0KKAPhqe7t608jZpL5ZLsT1Tk
   AKFz7iMKQetm/y+lRYfXdIL+ZaswkRYUoXsrumZPkCgiOTUEKqKi3Ul8W
   G6dbD4AIgGvlLX8h77RXu+yr3zAoaoB+IgAAyO1i/GmHNwqpkuXWigbqL
   94gDljjdH1WmpkfhjOgqSKHVA6VvCgYd0heQyxTKuVJ+rOGefCbB0OvQX
   eX41XoHj1t/FW3ysUprlbFZ2dte84TRelv0bz/q1/Cmx+m/97gZS4bb3a
   oTqJVOHZTthsPnATdRL0ticafq83Wv7idD9w2u6Fw9ZunLviqRMwhBrD0
   Q==;
IronPort-SDR: +SiF8UWNWXNUy+0PH27sFWOPi0PFa9ap1VCwE0TwtTih1Z3xqP5fAMGjxK6zHmtKce9O327NTX
 3C8ngYseMq/LBlHWiuyTUG1WGu0RNcMolYcRpqRedF3RRhfWiwkSAJm6qS270QtCH3mnjMR57t
 NTVKaSDLo04CzfySreHnbhFM7LozbYcmvF2Tu67ebeQSAGDlEJEodGvHeZsd3CY1x2N4PENWjL
 zak5W3z91ka1jRTiAWoTFQ9tuXaCOmci3/z/ie55ELGb2tWkunOk4dr89zL9Qb/h5fH0qB6PTt
 7uI=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168270"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:56:59 +0800
IronPort-SDR: aXty77n9zTc4eca0Nj5sxe2B9m5eaDEXghoifpSwUkasHc/4waJSblTQf32fWmUn3FY/BulMG5
 DrJqmmp1SKHmLEBg2v7f1CrkJg/TzexGr6QYej3pBhddsadez+pg/YemVdKwLfQ536TiaM5rwd
 C1Koi1O7Xx/G67/bChlcwUVhcXC5dXe+zPnnAVQacXZcD3eErxGnw0XUBSxLBo5Rsek1HWFXuY
 Rb7qQWsOqEtteT3fQ2FJobZt3KhEwSTwWHE1Zfx2N+BnTcVjzdlqcwq+XSIZ1VVZyIdmQSBZZy
 UaZ2s4DcXz5IMeBNUrVb9Mzo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:27 -0800
IronPort-SDR: PDgzJIZcZldsS0B55yUMsUMnEuJEVi3tX3HNlwY6HwskILyxuoyVU8sGwVcR9gx062UgWMzX/3
 OInz7ee8CXh5IzJkiVv2US1yPz8YGYqipWMeh+fgUR3Yuw0BQdmS9BFLkZrgPOP2oMx0Bc9fHC
 RCM3pQO72uIRdZSBV+FTFcQfOSQZA3aBx51Azllal1KKEKVjcHvTYOLAlFnOSKw3aRw9S1Xvdj
 fDYln1cZd3pTvOtHfOavEQZJIPd05GL7U53xNBAtr7vwBSGAHpx0FjvY8cym9WP1bCWmqQW8C2
 97g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:56:58 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 03/21] btrfs: introduce chunk allocation policy
Date:   Tue, 25 Feb 2020 12:56:08 +0900
Message-Id: <20200225035626.1049501-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit introduces chunk allocation policy for btrfs. This policy
controls how btrfs allocate a chunk and device extents from devices.

There is no functional change introduced with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 1 +
 fs/btrfs/volumes.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 911c6b7c650b..9fcbed9b57f9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1209,6 +1209,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
+	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 out:
 	return ret;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 309cda477589..6f462b337fce 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,10 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+enum btrfs_chunk_allocation_policy {
+	BTRFS_CHUNK_ALLOC_REGULAR,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -260,6 +264,8 @@ struct btrfs_fs_devices {
 	struct kobject *devices_kobj;
 	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
+
+	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.25.1

