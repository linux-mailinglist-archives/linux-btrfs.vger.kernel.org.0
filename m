Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944E24CFC94
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiCGLWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 06:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiCGLWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 06:22:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567D24597
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 02:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646650043; x=1678186043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fvxjG23tKmUzioT8ur6Q+CJjmJ/OQ5Eh/trIxn/oMLU=;
  b=GCH/IZH4hVNT7Vhh4s9O6600mh5n/4ERGiy5EWAenQ2BCnIhwkskoqWw
   stmPWuvOHjQlK49Yz5HRGAK8erKjI7sUAPiHBOZfichAGVcyWRW5jYYt8
   /JbtOfr8WTcJykSziLhzyfUy8JnjKyAGmt/DNNXfDxsGszOmkamFxAitD
   pIp0JnOQMvD8UVHMCsZl8DsBG46TIusJd9necQgh2OblqCAw/BSUSYgED
   rMNvXiP8GOnBrDo5ANWwsbuRgpVyi7Snx3emHBI+H1QG2xSer/Gnj0R28
   tKGaYlwdlHwGQbWsWClGGbToJCa6QOpAItQOamuGzP/dOvpC6RJYL/Y2z
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195615429"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 18:47:22 +0800
IronPort-SDR: t68j1SMXy6r4tgHx76WSc6KrQyRH23YP4MP0Bv+PRvsE7s94hIVE5zGZfzLunmgDFi8gfDR6+9
 I1RePRDPFUQJJ73mjX9CXry6xgpCyFy17Fo2ocy9F5zyV+Mmtttnr+FwE1wYa63zXY7fkcwJ4Z
 wAQmvtTOfc/r4XfrEA5+ioz9MJJueNU8P5xcJX1PWRX79o4TNepyx2GmJyqgi2xOzYcPNR2lK7
 a+NSKlevQRyoGuV8z9UHBzVetzYJ0vpWFgzP/WQUy+CtlapLVoKM9nxLaE89vjUCSqa3QqT1wO
 tvKwZ6+kC+7CKLdSD0j5wTEE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:19:40 -0800
IronPort-SDR: U/O88JGNhkhryg64m6KW2TJCInLZi+bQtKjknKJHpAy5rCM3qL33XRsE4+Q2A7jyFJSVjBJ3Q8
 7/G+HDrZ45gnu5bCY9xTLiULxAnT47OqJoicCo91gjICrNWeLn1iVAqKfkRw++b8alj/mpZXXT
 v4aZY7L7DpfD1yhjoKmyav/67FHPq58du5T1GJCUkZj6hFlHyMqh1nTFDg8vXxn50dZ5tU3bYy
 TnfDFsBjqaVg+ZAk0WX69Vn8y1NI8vNWri4nND7U14twE8bOBNwTdFqtoAW+Aq5kAxLbWtRAr+
 C9Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Mar 2022 02:47:22 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: zoned: two independent fixes for zoned btrfs
Date:   Mon,  7 Mar 2022 02:47:16 -0800
Message-Id: <cover.1646649873.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
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

Two small and independent fixes for problems found while debugging other
issues on zoned btrfs.

The first one is a possible deadlock and the second one is for removing
leftover ASSERT()s.

Changes since v1:
- Remove unrelated hunks

Johannes Thumshirn (2):
  btrfs: zoned: use rcu list in btrfs_can_activate_zone
  btrfs: zoned: remove left over ASSERT()

 fs/btrfs/zoned.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.35.1

