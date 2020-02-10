Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB84315825D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 19:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJScd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 13:32:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25711 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJScc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581359552; x=1612895552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2X4aHgnvPPXZMjaOmCVZ7Drr3KtgumDXJtALPCwaAw=;
  b=RfIPzLD0GsMLcZ37DoJAAeBkiBxY/sE/d2/Yt0JZm0LKdOcrfJTX3HcO
   yg7tctWOaWpbzU+BCN6znSGNqMBnBzMVGlypUWkClBt9UICQORRb4IJzK
   cVW8bFvrzh4WDsUDWrjzBoUrMveocTKuLS9LEyzJI9zyJllAoQ79poB+t
   Dsh9jKDkhx58/Lp12fiqYv1cs456GaJkBdkxPdmxzhfogfY3BEah2/PUx
   a9qq9g2McsduJ7SJg+J5K+u4OnuI86B4Xp/fNVCWnVHk6e84BIiRJGE6A
   mA7imlTjb1xZ2Po2r+azoBSxS0bwH95J90HrIBabP3LiR2SprlatToq+B
   w==;
IronPort-SDR: 9lYzFGX7TXZf5MTkBs7HqTSBDc3dH82KsGC7w64vvezbCwwFffnXDJyIr1jM1AwJcGiRbT8GZ+
 yl5efUlrTBoUba9YECudjb6/rGblCCFY1NHUL5GxOxlyvvLICwxYnqlU7sYha3FAqEWO+Lcx+f
 /g3iAHfwPGiarwBA4a+mh5JdwGqUqYSb6P+nLUmhqK78zunEgp1OuFqkO/PjrVTyUmyF/I/Jmm
 ULUjcRON7hsf+hbVK0g1xDQgEsOSBxDvl0Y3qa+SRJJPsMq9A6P3zwcKR1akb6GV0hyg/MMQUV
 LL8=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="237529176"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 02:32:32 +0800
IronPort-SDR: /FXR5E0yUenzIzUedSmoxwhSY2kdcCskmCL4DaAMNgWwznOHO6Vbw45zfdM7YHqBjlhpBklDJg
 WQjZJeRXs+SnGPuMwVVRblxIqoP3+btUgpeHl2iUMk9qcbTMToL6TJFTjAvjzG0BZSs99CPgzx
 ibC/zuUOD0ArlbrxRfEwU0nvg40i6njKFIAFjbMux/+ZXKVS6YYkEq+4aD+0IUz3X4zTkO219c
 0sgeyERR42wJLEwtYgbcN8OR0ciUB1oq9ITTljOC8Yzwg08kRurgqw73lBx9k7r4YwMcEHryO3
 N1/1WMJVn+F2X62LwPWdz+vj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 10:25:24 -0800
IronPort-SDR: /fqFLO6zCoLUkon4jeduT4mYt6U7Eb2I6wuE0GqMXD76UCoZbdxlFophAqk5MQynqWyCSWnPdo
 ExGpYHxYN2K5CLCZJcTqccYirzDN7T0qE3rbbjzT44n+r/JEPRM3Tw1fVzVvVOI2zah6C8GQxV
 tPL+00Q7ZrFt0gZG9/DzukCiWZID/ZDlT2dTt3N7hy4es5KF5Uz1FR5kUd4GPjvq0yIOF4MYMO
 vhMCQERStXL5Kdh8jiyVDldkWQF0tJV5VKIn2p5v4DqT3zYH4uNVdz8Eoj0IaiKxIw09rMbfQQ
 7JA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2020 10:32:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 1/7] btrfs: Export btrfs_release_disk_super
Date:   Tue, 11 Feb 2020 03:32:19 +0900
Message-Id: <20200210183225.10137-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

Preparatory patch for removal of buffer_head usage in btrfs.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/volumes.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b092021e41e9..6ebdd95b798d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1247,7 +1247,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
-static void btrfs_release_disk_super(struct page *page)
+void btrfs_release_disk_super(struct page *page)
 {
 	kunmap(page);
 	put_page(page);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 690d4f5a0653..b7f2edbc6581 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -483,6 +483,7 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 				       u64 logical, u64 length);
+void btrfs_release_disk_super(struct page *page);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
-- 
2.24.1

