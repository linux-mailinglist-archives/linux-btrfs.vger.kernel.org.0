Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C23564CDC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiGDE6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGDE6s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20826D0
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910727; x=1688446727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GY0qLqAH7JRZKP0pFrg7NP4NQkCiGdD4jLSGpT29R3s=;
  b=dkz0VmusuinHbSQJMI5tr9xNLA2d5mNR7E49up2RsdbnjXpLSwS/15K3
   5OHQB7lHEub99wFZWEB07u/dlDaI80OxZqdVHphBWk+bQZxWUfU5V2TQx
   K5DmSJyQEJfmjLXa+0PSbK7LN6Rp4VB0uUxwr3arYxt3GlzUdqPZQ+W0W
   2Qj6Zcx9wfEKD0xQf3V7dfKG5InUmtS58XIUOqF9w56XGJ3Brgua7tm1V
   iUa38m2SOMSUxQ7wEyLunqlL/9pwsdwB9PxFB0xlk1+g/H5jXxuSpxmSl
   0wg6Mf93T4/QFI+lgWS+Zz5rMf8/mz05WcAxyZHitk2OvAJun/zKrN0RF
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732398"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:47 +0800
IronPort-SDR: W8um3XZCoLY+VUBE2/p+6jHF9502stkaG1NawgErbnZGbzIWw0s8+LUKxkH455844i6kdZnb9s
 Bf0Uo8JIARTsvynwB1EsMWtqihGlXMRun9YS6FGgpkCH31CGBm8/ncvhyS1bogyXvp0j5y3AVa
 8D7LGgBUM0LKkMeBmGt9uo+tLVx4BxAh9yuVk9VDRNAQgCEXfgz8pbRj342EGPCog57HVQaNtg
 ACiP12Xwi2eeMHi/GiLCX5Ai79vHJqbfJ67614Rwdt95QdJZw1PakBQPHE26k61Zm0s6/WxLYl
 z2MMSRlqhAT1DGevaRjWmMG1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:40 -0700
IronPort-SDR: fbf7rJu+/KJ5olVma9c7VvX70hnq0ThBWGp1umG6CA5TZPMAz/tTwHgQdlxU1oB+JN/pM5kpTS
 BhvHThxiBUTSXExcaOdoToLVBNdkahcEoI6vBxG+REPsXh9cECmt0vsiVNwSrBxf/dVTvnqx/h
 9LBIL53Z1otZSNUoKxcm4F5zrd4cgno34ZRjKlzMI9Fslxv6tNIBcziAxqFT7/EFn3sOAVrW4b
 OmPVJo9pcEBHFHYjnJ7d+OZEma3NL8eRfFuds6wsQHtqfSulztMgFov4qCS+MVhtITdxJddfXD
 Rto=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/13] block: add bdev_max_segments() helper
Date:   Mon,  4 Jul 2022 13:58:05 +0900
Message-Id: <a3eed5d77f1cd3c7768780356f1528f9ce6e540a.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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

