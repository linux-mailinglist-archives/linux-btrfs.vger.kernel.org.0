Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8714633B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWIS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:18:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43985 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWIS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579767537; x=1611303537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/RmVUPr28r4y4WpbIQAB/hMDjzSOOmv2ErNd1ssZyo=;
  b=fdV1Eo68q0FItWuWkfP5d+/8I3wAMU5CGKDpjSCeETwChgRXr1Q851Rm
   JZH7o6BqMywuuFNEvMfUvXX/Y6Vi5Mzs9CimMo/9jrXuJWlzmEgYylmnU
   8Mnuwm1OG2t/FjiKkpOeG100v6W8V20IGWBfRlJFe3pRZgXJMGK/0MO84
   OVTdu38def6d/yn6RhquDyid24BLUkoKXs+RZHO5p1Wg6ZNMA0uwnOG6K
   61SxmxhjA5xFZP8mzP3z6OHWQoTSCSvS8933FRmpUK1PdkfwxdVeqnieF
   TzP798FkPozB9Mznj8m0itT98T7gry6q8lKs+T40GUKdUv0nFfkt/WqMM
   w==;
IronPort-SDR: F6jqVrGTEG478u2n1t1x3MQLrT8Y86thMttuFxJkwijxOh70ZkRahB1n9S2NJfxfst00jfPaJZ
 t8+Vv1DvMcj5YucSN6vml4wsBlQYc5gfj937BClXqz2Qle89kcHGKJXJ6cX1fheEP2cMCc4pM0
 ooPCfLyhqypxhGrQ/w3ZK0KIKtV4mp2hmCwn+sFwoujduOcnjNm/XvGKiGw6fcR+vBo/etvppm
 t4VhLI7JwH9nZZk4OnRIK3YxZlakTEBH1e33+MpPB9QWVAUedF5bMwae5ICni0k/kU99hXlJ44
 cC8=
X-IronPort-AV: E=Sophos;i="5.70,353,1574092800"; 
   d="scan'208";a="129708687"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 16:18:57 +0800
IronPort-SDR: 77wvgMjQ73UDKsuk3AcsfONGtwEBHfVz1rLCZGfvEiwloPg+S/canK/uzR84wZI+rvQKIc3lYo
 HNHEwwzAyph/3dFav7adNQuocfg3UTkaMs+uNsNkuK5+x0svcKxV+vLrBoUaM8OkvgQHrJZxb/
 n2T1HQaikQvASoziGHR6MASGhREpXoLCHSnRF/591xpP6wCnev/RRw/zG2qIHZnM+EtNOXY7ZS
 0lT5JZGm6zL/pvW1LgHPov+GW9xMB/ATjtrs2QNqgHUuOpivC3b4e4Xv9xjWkb4a2yrHy1QXsn
 3q5TeUvaSvUd2Qmj3o5eMnpW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 00:12:19 -0800
IronPort-SDR: sp/ZsTw4DGRCbUAaRdp24YJgGKYAU3emOoj7O2j6SL+hb2tGbHAV00ONckiBvpn4jE8zerEvDa
 tuCLoafnTL+U7QCdTYQFICDq//lhfmccN4WmscGrpe1GAC8uPZ9nk1BhzIkFwjHeWqJsW+KGRH
 3QuHGjv2qr6cmi/WdbI4hrMC5RcYwZ94uSGCguqrKR4rkVO/ovnJlEdwUMcc2fHmg9pMbL6Ksv
 k7AtfCtxyl9eX8ec5cOgsoEGuO42oPFpVn2Iga79sXNZXTwf9W1wMs93qQUuTeNFpeb+VIJzyJ
 gRM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2020 00:18:56 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/6] btrfs: export btrfs_release_disk_super
Date:   Thu, 23 Jan 2020 17:18:44 +0900
Message-Id: <20200123081849.23397-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
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
index 9cfc668f91f4..7a480a2bdf51 100644
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

