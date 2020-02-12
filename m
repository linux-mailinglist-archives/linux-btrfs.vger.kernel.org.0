Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080E515A19A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgBLHRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:17:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46465 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgBLHRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581491841; x=1613027841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2X4aHgnvPPXZMjaOmCVZ7Drr3KtgumDXJtALPCwaAw=;
  b=eLpI5rWkj3Mv0aUKORShZPu2B4WwXUQeXfSO7h8yXg2zEj3jx+zRlmTd
   IChZhicEjZjQrLiVkqoqxJj2SnaGkIACpaQf+nVip87z2ZyW8Mq/P9Rdd
   e01xl0xSxoypBvLoYtfulqsObv/vtbdMmH7uz6lxC8g+89Xisy6/NrKx4
   +vk8FsgmAOvlwUMnx/fd0Ze3XmrsQVx1DaodJYG1I/qLlZL24zpbSYXdV
   JdY7QCZCNaUPuTkWlBOSWnVZfd6J8MZqK4NOStX65GesiqIy55Hl1ZwBo
   p74+F1Qrkrm9vd5aX9FkqTvL8HWC8qZic1QYKlUKBdUwMwYqBo5fCWZSt
   g==;
IronPort-SDR: bNq3N4tcgvg50zQwR2lc/Qu0ClLp4CSXumKUST91zrN43LwnSvV7GBJpPqy0aCfrrJEs9czmhU
 LNE5UuJk8+pdc8C7dgiLamueL1JHtIwzK46g1QujDsI1sAONRJcLJuUmxhyF3vuCmqdOohejmE
 kvwGBWVymuQ3oWBduyBW80zJOlEzv3e/mE/nby6Y/ZB82/YAINss33aMyTLyXO++webwiu1Rjv
 0wFjBK8C2HVYTMdED6eOfGcRjWWf1ceXby+ByX+BHRs59MESdn5CfUy9n9aKR+xdpukJhnt+jJ
 LnU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448455"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:17:21 +0800
IronPort-SDR: OYBCrbuLcnoJ4pxfyDpUzRJ/5TkTPVrz6lAUoZ2bU+YIWUwt7cv2vzE+52MGG+iWTqNfGAUPrQ
 65aDxCjh2vvyderfpkekXtBTmyZL0gCpNZv0FIZ9axiCeNhi0VdD6Y+yBtVkHniB20WULr8nvq
 +n7aN96SsRjuj5b56ZO0SvZzxF5b43FYDRq4eRDKN0pS33mOBMA5NzMsneU9YqDeAEYkZIiYwQ
 mOFdqho66rpQKUGy5FDkMDW9AAcJV14tJir6XROMbSAp3dlU4Pc6hh4h1rKGcHFisGUt2OcsFH
 JgAgOgGJixQonL3UWU2WV7CL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:09:58 -0800
IronPort-SDR: LdsyK39Is5ddR80wu//BG5BCox2x+A9cpVc0Ih7F+jpKSWvEJv/Qwxv2+1Qp+uecB5KHLNmINV
 0BmdNxsA9EFlktX6Gs0UomfR5H96WgfGAAALbCDLXfgxXX9/yKTfvNOcwkpN1fCf3Wpl3oNm8G
 RefsW5V5fY8JaEZteD8uCF+XZXsHdlNiCIHhpYTwuYfFObgKx9JyreiKoHr2YA8D91qyQAUWLu
 H1NTWIZX4DEqmuiZ8lLUdB6I4oBJWf50a68wZqikBJoS/crIS63WL0grK5iUH6W0lKCCqG5FxT
 CaE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 23:17:09 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 1/8] btrfs: Export btrfs_release_disk_super
Date:   Wed, 12 Feb 2020 16:16:57 +0900
Message-Id: <20200212071704.17505-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
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

