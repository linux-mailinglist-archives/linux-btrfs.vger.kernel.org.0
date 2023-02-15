Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A22697E60
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBOOb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOObX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:23 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE81C38B57
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471481; x=1708007481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u95jO6mXgW1aRkfnKEmm6qy9fm5sQOtKImE++W0MI1I=;
  b=HQny/LkxKvTRxvwehEWeS//yppehJJk09BkTCocowsGKlofiHEE4kgG9
   unuomAUBl3VJs5jsaCBmqkF2peP2Mvwt2YYeO6bZJYy6QGwGd58w6ITIN
   haPdd1BzAb+p2wVcD/cBM5FcDoCLDIE2e2kzP6gXzG6lRChad4LpMxPk5
   f4HM5RcGJSbi2FdsY/Nd8PIXquJ6bqBsxxrUWhIDL3pJ91P6C2cfgFoYZ
   AuyvtLvVfI2Z3VBppnphNfhMVhTTcOevat3URcPlRM/LBMI+ZcJvdqnvh
   ybFR9uc/ZAJcafiahRdcILyZC0iIo70TXFbNiN/7cvkhcVq4oXc+Nxoe2
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393922"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:15 +0800
IronPort-SDR: 9Cp6ULydp5lLtZwFAB929l1wAsg68bY2+WA28jh3UhT4BIKSejbmgUiYQpalh9S69E+epRn6xw
 Q5iJiOKukKJdKlmPk/0cEwsAAbqeBffcm16GHOu3+fgRPIZDrNA5WRBtpD0xH16JKgtLuMvItL
 TARgSozANnZ70RMKXCqAfgaFWpJo5eaTQa2dnd8SIPJ/k1OYn3XEMACymiR4q1hFZB6zlOmZAD
 44qgrDpAhI51bPa6HbREt6sOHtl3GLZZ2Vdf4nrsv/wko2K8LWWU/M5IqHKBhsTmHcByKs5AEg
 AA8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:21 -0800
IronPort-SDR: bhI0O7Me3OLlRYiIu57YfJ2E1WVmgi8DU5lizu3jxbFXhWEUlSdeIa5ASfIBhQHfOV6xZEgk/6
 Dmu92mKshRH6QUhUjwAgLZesCH06hFdidwoX0Tm2RUmBFRb/QIFxEJ5N1Vk5fI8IO+SiQIZjhh
 rEkF92qev/0jdRnrh4IXeYBJADzLJFC50CV2cjmRTM4GldjAvrQ7QoznaTjNCPPHYh7W5zNrhR
 4Sx3mSJqktHrakHcWLTlXkYmhYMOj1SpE983Re4W/smSSroYwi7y9X15R0KvZehxYC1irHB2gm
 k7Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/6] btrfs-progs: load zone info for all zoned devices
Date:   Wed, 15 Feb 2023 06:31:08 -0800
Message-Id: <20230215143109.2721722-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
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
 mkfs/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index df091b16760c..f4ff2c58a81f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1667,6 +1667,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+
+	if (opt_zoned)
+		btrfs_get_dev_zone_info_all_devices(fs_info);
+
 raid_groups:
 	ret = create_raid_groups(trans, root, data_profile,
 			 metadata_profile, mixed, &allocation);
-- 
2.39.0

