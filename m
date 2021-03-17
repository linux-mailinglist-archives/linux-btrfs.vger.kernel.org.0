Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515D933EBF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 09:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCQI5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 04:57:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64443 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhCQI5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615971463; x=1647507463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+gRXoEUpst5zSAcDbV2BT8jUr0U1210nhOSK71Q9YYg=;
  b=E8cybl6pKo3i0flj5MC2Mv5OQtqoRmbUNDf0o/139G0z4E/amzX7rnNy
   oJ6pkEdU0CZOayYtW5eyLWeUNvgq3IjSWEpkkhnev2bq7XJf2j6eOLUTO
   AU/aV4ll7N9sueVrjGHgkCp6DRf3UPEaoJcvfCW+/uXOqGchSZEkKp6tg
   tf6PQRUuror/2qaAIMYoB4sDZAs8MAgz1pxFvfj8pGQPwxStcxo4D3YWd
   wyez/8Cm8oAp3XAjQE0eTQigqc1PYi6R4Hx62P93m3LxdKEEeCPQYgeDb
   pHWNDHnUJNxKkLoHF7whdK1cTccmo0KwmifWx9ApuAeAJavXfllb8fd+C
   A==;
IronPort-SDR: ujhdufdPuYkgR8BqLuW8052Gpg1ANYugPr/Uc+hkgCAvqcs+vDJ+Pbp27BWdHlVJhK0SVOrr9g
 XZf8w0wLjl4AvLO1XH6EnNIwnzLTOMfJgfhNecRPmZ/c4EW6GYp0E0/CNqFfFA7uLWtVPqdTwp
 51ClMZTk6scBTayhXf38eTWunjaMqYltuiZVc6A0Ci9eUOQUduVBIuqqjuYfdANdAoL1KwdzuL
 27sY0hzE1/+P5qihc1TjhISTyA359YJP88ftAbprV7SqRPQ6VaadpnPxiuY0xPK7+bNxoCRpQI
 wuQ=
X-IronPort-AV: E=Sophos;i="5.81,255,1610380800"; 
   d="scan'208";a="266740126"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 16:57:42 +0800
IronPort-SDR: hjNHVWpwi73rBOc1da++GJMzxCTC+WL8Ks4gFLHZMxu/1kgymjX+gayB0AMW+arWOCQGKWN1CI
 VQo9nwU9cIadCZovoBadGruNpyHt37qOhFxiLtd9VH6lbwJEr3Nw9kArdEPV/bsYKRfiv3WunL
 iTvRX8XyT7EhONDKZSMjOrX6uXxJ+9xrND7NHdYlAAstKeybFimoDp1RxiDhUUCsj+v5DAab0s
 GXUMFUpwCMk/EtwpNgLVQ+46XPdo2Ub1N9zS22ampuvGZG6jAxA48HxLh4noG+AgFVvHzFEeeG
 tg7IvaP93xoOe6RpONvOjSK5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 01:39:59 -0700
IronPort-SDR: qXnPfBq48+GKL2AOm6f+z3ZfWlXR3hu1zwrvKOc/Jfi2MZ575S/Wp5UQW8/ILxTMR/OledOiCg
 P4w2OJ8wsGHd+nYhLQysxy/S/S0i0lWTl44GxAnM0kFBp0sDuD3NxsY/aHNJ1na348TnlgZG0t
 8DOOXOggNZJWVzMGpswTjpXItN+9DJX9lzPOiNsO93sZRiLv1fXDX5hc5vCe19LQ0eB8EixSVx
 gYELzGIgNBLM+VuSbRhAZ/nyqMebgbA8bHdBaCjtqHmGSKqiJqhv+yvh/Miuy1enxigY7uoyF/
 9Ts=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Mar 2021 01:57:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Date:   Wed, 17 Mar 2021 17:57:31 +0900
Message-Id: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_submit_direct() there's a WAN_ON_ONCE() that will trigger if
we're submitting a DIO write on a zoned filesystem but are not using
REQ_OP_ZONE_APPEND to submit the IO to the block device.

This is a left over from a previous version where btrfs_dio_iomap_begin()
didn't use btrfs_use_zone_append() to check for sequential write only
zones.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 618ec195985b..288c7ce63a32 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8179,10 +8179,6 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
-		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
-			     fs_info->max_zone_append_size &&
-			     bio_op(bio) != REQ_OP_ZONE_APPEND);
-
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
 							file_offset);
-- 
2.30.0

