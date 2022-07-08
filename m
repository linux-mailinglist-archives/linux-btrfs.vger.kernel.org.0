Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6338956C4DC
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiGHXTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiGHXTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:08 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0F41985;
        Fri,  8 Jul 2022 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322347; x=1688858347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=46bgUsnJhvod1OQcMqcmVs+X0PGcZlNGXTNYwMX0W94=;
  b=hNRvWzwvVUPk2t02rbwCV1HeOkejm9uyCpVCwGVMl5gH9W3T0ZiCXHaK
   l9No0lduZKV8buX297E88FgP60G0TVFi6EndgInPzbPBJGeMnFj11NbYS
   Kj0gs294rPzzwIU3WJlcalnDJm4UMKymcwnFx471Baq+Pf8XjLsGqkhOo
   9Y5FwmR1OTjVdB35lfDnI8DkUeQWFJO0eJxmkMGt1DcrmBjAl7Qidjlp/
   VVcQq9+lwikmXWTjlK99tkH623nJgiiHPtuc6ISSZz6NqFjzeM9lnt4Ju
   FggP2ZJHs3XRBiZlM0qx+LGWMwUfe4n87BOyV//lZBXFjkzzG98a1nIk1
   A==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871811"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:06 +0800
IronPort-SDR: yYEmo4hE2XNCCGMBYB4uZezzR957IS+GCGTPMc+eRvKqixVZUeXXdxss2wuAORc2guI7I+QPFF
 f+7ydgGgSVEYjaEVx69BZ7CIO88NUDwFFYrWcokf8ypssXIPXzH7Bj/jgy468dT2PzR+uoBR9I
 5xkNNhHQ8QWXr21uAKcLuiKFJEHnkw/C4ZmH8r1OdguXMrwlXvSTBTXxNzNYAyLaBCRjnivLhH
 MV5wfucTp3Ek4VLR3f8j1ekrFF0a+TFfY1iz8XOo1IPq7VgjF4wnyPtGDryeFwccwtcm21zSxL
 RAxU710HL9/0UAy9YmbvR5rM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:11 -0700
IronPort-SDR: JcLMt+KdjvQG4Y9LpYB39ypAVHoA8RfHjdysTxMnETop4io0fG1IIHLBlBTN6oZahaloZ9+vDq
 lTjvs79JQeExkGiwltBGxv4M/DFGZdGuUemfHlIkr92GArMkljdDvn24Og6Yo3MIO5E5/trhBO
 /CZYLXeg9fNRvnr2cjVwCj226HHOGlJi0hHoVTzYyAqG5aTqL8CIE9mOEc/oAOZBuEy63o4coY
 VX6KIT3bx7fESy/ngYCJGQzh8LR7S13hmgSeykonxaFAEJygbr0j9a867s23a0OepeJ7euYUXb
 FXo=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/13] block: add bdev_max_segments() helper
Date:   Sat,  9 Jul 2022 08:18:38 +0900
Message-Id: <b4401816e33a90b1f05a1e32b420f073a8438591.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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

Add bdev_max_segments() like other queue parameters.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blkdev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f7b43444c5f..62e3ff52ab03 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1206,6 +1206,11 @@ bdev_max_zone_append_sectors(struct block_device *bdev)
 	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
 }
 
+static inline unsigned int bdev_max_segments(struct block_device *bdev)
+{
+	return queue_max_segments(bdev_get_queue(bdev));
+}
+
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
-- 
2.35.1

