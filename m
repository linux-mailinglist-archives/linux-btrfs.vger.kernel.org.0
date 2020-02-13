Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96E15C5C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgBMPYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:24:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43897 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgBMPYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607486; x=1613143486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2X4aHgnvPPXZMjaOmCVZ7Drr3KtgumDXJtALPCwaAw=;
  b=ppNN4ZeMUPRP0UOdmOjf4asJ1cXjjx41KbPKSFtLhxL5CgFxN31Z+QDB
   glnIdzb59gLYs/MmhCSAOUJ+VOO4q6J3rgHZxeb7auGsspyXFjLmK1iMy
   m73rEH6WP0b6Fog2t5r6g2S+0bTCA57YPWFHsYC2I/AjWIiu3ljGyhnqq
   1spz2LLSKJz+rzLa8mhsgImVbHpJGuvd4LVGeeUIgUFjAgdgbvr5FW9xE
   oXJvbq1bB7FmL52+T0McXZOUrf64PYVKpznwnFDKg/TlZk5Awxw5uYgkc
   FZSz8F4C9pIjkHwjwrYfDa20iMyaV0QwhDUCXWnCdm1YCoR0evpDnw/Dg
   g==;
IronPort-SDR: xZ9K+0NU4mkjc/KSisU0uv4sU5mB1GbbtBlTgsRAuZuV5hT9U/IzMkyef2IpeSUAVn+UrP+ZJ0
 S/BuCoJcGu84eD0wGSHjidRs+OMXXQzpDEkAIuXmftdj0oJdnksuo9siOarfWLD1ZI2TQk0B87
 VQur88veppqbJ+k1/YBKw1CNmKAnCknWvPRSHxlsAf7d3Q2ODfVKvIkWSqZluEraXSevtjmIW5
 pvabpY0k/3hDkQgVOunbJ29niKjlsyFr8YTzzlValrXe+c1y71D4LWRdw+2/fxd5k/+WF79gO/
 548=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227880"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:46 +0800
IronPort-SDR: tZKuc38yjsFeyw7Tv+ltvr7dCOgccyJA7W4zgSNSV8MjzKrzfgBXG8eplqT0Xe3TTY2SusEAh0
 r07AVV/a7V1hZO31vJi9amgk6lHQj5IXjDw8MsOGo8UAj0H0OHIVHkyFPSTAqi435TRYgVmCh1
 9xUaBU+WUnHk7CoJQB1iWE3EAyznpIEWzebIsvYtQ0TXwcBXB5ZSOCabI4wW1YqymjSBirm+5e
 cpTVdcwMKBak87ZS+RC3GsGP5dHTTYRcY5g4y+lhMjPdT3aJhTddZJB69Lq9ZlntjirUWyu4KO
 JsDFC1imrkf6v944P2tIQkTX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:32 -0800
IronPort-SDR: lFZSdDoUYaHQ+59+gWVYVyPUayplgAmMZJEfPDBOZw5XJbWROBrmFG+er90p+fbGSPgjM37x/K
 iqyjCOYbGp63YHLIb0eJFW9cvQHV0rN79Ugv21tjM8hQolZR3NWiazVFPJtaA9CRQYsxTJGIVm
 NKSQD+pSpUumfupgVZFRbXeSd/ZDWnzPLKszrSDkFltzooYddy7IgtjwVTmxNpHqPXiWBfluX6
 s81nlNfWUuVPQPnwwN4a+y8s6j+VMs3mBuEAGuoBrFH8SZgnZCagM9BeiS3mnq1GKk/KoIHVwN
 X/A=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 1/8] btrfs: Export btrfs_release_disk_super
Date:   Fri, 14 Feb 2020 00:24:29 +0900
Message-Id: <20200213152436.13276-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
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

