Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A1600E4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJQLzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJQLzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF6BF59
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007741; x=1697543741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RgEc14j4CKBgEtcQOf5bFGrH7RRtc3htMhZpJWlQ6OU=;
  b=HFfV4DAbbx+X2h8g6S/wROJ0c2CPuZZ2uswlj2/E7kU9R0OK58zkO0ra
   GY44ihlS68shiWWq2hX4PwRtaV6bo183VmLyRuySigVaemR5zlMH4V7yx
   x+55BI8lBzx1JSD739jkR5Z7LT2TdC9Ezi0kOETPVGIMtriWSetmJY8PR
   iug75DlExPv8ouDziZFgOAGf95C5Udx/U2+FrrZDuQwx0UopQGVbXp1+1
   xCtMigXpi+9NL7rXlGOAcI3/x3MipSicSF6wnHM6zkRWrz75vzX6Y+eBD
   efIrxpIqJbxI05qfSBUX0CfJUbFetp2xIsUMhfcx1yzQ8iljiC7FCTG5v
   w==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337169"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:41 +0800
IronPort-SDR: UZxO54scKAF8pz0fkxLfy6Cvv3f63tasvoFaMHTFCncMUrg5T3sQuk/fIp391+Xl6e+9+q/6QP
 ZVRFseteU8UZ4fGrx8RUGHSFcHjrgmfErCjxdZjJh0PR2f95oXOCgn9+4wEDkmzBxHm2rV3LZK
 wbnvvs8D0JPDw20ZThDjLbyHFOiqeCm3lFDIObHQmjUGcbbD5pBToN2ZY7wWx0sMRRmROIgf4H
 6D/nmohYQtqnIR8dKoaqD7hqFvVLKqr3SLewdmf7ZM4AgNXTlx6Nitza4JMMvQFBMc0OF2Nefz
 mysVdpmY2SJSboEEOkfy0512
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:14 -0700
IronPort-SDR: x32K2ZfjpgXdeyFPhjVkhpKR/4R8QuR8jTS6a61vFrTzqPsUfRNhT0uY1pd/MWT5VROA/IWr5u
 nd/KYENml0oGQ8AKxuPgOrYRxMbJlEAKCzcl1W1YWVjlXUCgNledYAqWM3scki4lxnd7GQ3csr
 i+mdNaP/4H9t43nORqSvOzSfPRBYIHkkTrdWuKaq9WsHFU0peqK07mq/yQkfTogf0CbPihd8ar
 ceCADyTpgAO6g34Y8fAksnAISUntjP8k1R8v8Gkeak2gCsu//T/xpbNgnagihrD2cf1RrWlUeB
 HVg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:41 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 09/11] btrfs: fix striping with RST
Date:   Mon, 17 Oct 2022 04:55:27 -0700
Message-Id: <b764b4d96e120f2884838a35ecc57291186f3e4d.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c67d76d93982..5169001b5bba 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6509,6 +6509,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
+	    !((map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) && op != BTRFS_MAP_READ) &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
 	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
-- 
2.37.3

