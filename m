Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953833094E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 12:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhA3L3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jan 2021 06:29:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19455 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhA3L3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jan 2021 06:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612006145; x=1643542145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kfBnGLEELbLt5OLOCONDNYc0f1iRp0scH8Cw+Erf3o=;
  b=hyXxtFUSEN60IiEeU0bRZTNzeGNu8a02BMO3qIC2S8wfJsaBViJYESr+
   m4CydWNyrO/lwN96pAevudcT6tzkkedHgaVfd90rBl5a0ulStLRYi8Xym
   5quYu347V6O4RnQ0700De3mbbxspkrhPKvtg/zKezSLqGVxI8Bua1FPjj
   v9QLwWiqVBOcltgD72FWM3/3AJXvNKT/o/J7veAzmy6UAsjOeOhe5NBT4
   GZrN1YxUszR2J2G9alxlSq9mCogcld0WYYAskorosNiffxg3B9kLl+a/y
   Al6UnNLwHbXKGxCTOHCi+KMobTGmit/HTygZt2VjpoQEDxOQ+flWRpdRy
   Q==;
IronPort-SDR: 6aysOrlTQQDYht+kzwxOk4B5E7z5be4rYJLgH3lFt+jYoAzGGPBa/djBcSdLDTRmEippeh1CHj
 gaf8ouPJOX8v4otJYEYm58w5EEvQYfPNn5JHgD+g7AzKB+0hqdLwFinVpT9u7tPvMV0mxg3cU6
 R+BRP+maZfxBwqznd4kJrvh70fuoyA6HQXr/mjyEPh1iVeyBDtobfyQDNh0OPmAWq1fgCanUFv
 8ZFpjep+9Sywl9uwAuhOyqh3xjsYCKd7ZEFrAYExgzqZ54ZNEkHhzGskB3i1bfTdqq662oBt9Z
 IA8=
X-IronPort-AV: E=Sophos;i="5.79,388,1602518400"; 
   d="scan'208";a="158695896"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 19:26:57 +0800
IronPort-SDR: mtCe/bY1cgvAU5A/3GhDlUSY9Uju7+H7Omk2w4E632njk9xs4NwguDQKqIr3fBhj+Xda6NNtbG
 gO9xtBSB9G1pCxjl+vDRKHRX7/GVyiZYFm9mW7iYa/Wjb+F+2PgWSlJexRhffohWteuuPGJijg
 OsA9qt1NaqY0mZhe8JAxLuSIADL9ayrexoejSA4owbUGTCWETnQHHRZBP82Z2jfCZ5bvaToN8L
 t3Xm7gOFZWB36GGoJbnImKl2vTPLFktSAobSGt5AIYKbgspeFrhOM+TFHkiy6qz6uy3WbCtH3A
 pwnMX1Q2yw5+isER+G8mgPIS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 03:09:09 -0800
IronPort-SDR: eixOq6o8NLB/QFU3h0J39Qa36x5p6v2D23kX3OvKcQnETwdL+3UooUc+F/99MyC4CQbKTJaZ2I
 ZDW92mfhBJHtNvmd8Ry0UOp3TI77GDFf73jW/vJ0CRs2QCAoBPfOjn7mHNdgq/MFNzVEnEUUh7
 Fqr16+Tlc+/PCGEV++P2kMCQYsc6F7Vfj+5TvLvu2QQHTXt9ctyDsEOxziSqDFnRkphloVG+pQ
 Yfb+tEA/kE2dM6HoN20CAUhX1PnNbk4vwsXV3zFSYIuGaADjwArbPDUCG3+4IBDv0xoY4OJWwp
 cvk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2021 03:26:56 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH for-next 2/2] btrfs: fix double free in btrfs_get_dev_zone_info
Date:   Sat, 30 Jan 2021 20:26:44 +0900
Message-Id: <6db9da814a31858f37fd9d2236768d3b75a11342.1612005682.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612005682.git.johannes.thumshirn@wdc.com>
References: <cover.1612005682.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we end up getting an unsupported zone model in
btrfs_get_dev_zone_info() the default error handling case frees all
allocated resources, but "zones" was already freed resulting in a
double-free and "zone_info" is already assigned to device->zone_info
resulting in a potential use-after-free.

For the double free we could also set 'zones = NULL' after freeing, but I
think this way is more readable.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: 9e802babe329 ("btrfs: allow zoned mode on non-zoned block devices")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 362df27040ff..fd953ec848e6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -425,7 +425,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 				 bdev_zoned_model(bdev),
 				 rcu_str_deref(device->name));
 		ret = -EOPNOTSUPP;
-		goto out;
+		goto out_free_zone_info;
 	}
 
 	btrfs_info_in_rcu(fs_info,
@@ -437,9 +437,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
 out:
 	kfree(zones);
+out_free_zone_info:
 	bitmap_free(zone_info->empty_zones);
 	bitmap_free(zone_info->seq_zones);
 	kfree(zone_info);
+	device->zone_info = NULL;
 
 	return ret;
 }
-- 
2.26.2

