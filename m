Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559B7518FCB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiECVOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbiECVOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 17:14:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6D12AB4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651612261; x=1683148261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+u9vTgHn6NaRaiJ8cfNkmTt4p/YnHmQveBRHl3oecCE=;
  b=XGLx8/SPX3jC6Y2zjKrrUe604DJJo01mr5f94SP2WreBdEPm+24sKRkH
   WQTLMVQ2KouownVLxc9+E/Il6IxdP3bkhcMIcIJUCdvsJ8tJTj5+xpbeP
   m8zBjaSFsGQhDOnwZsVFw7yY6c87sZchVoa3NtHwdwk2LrQaGw/TNEOzx
   tZTcZROnWEXY3W1RA9bLwE35F6iGkWUUROwWwH6qfcS+UAWW6LKd+xc8B
   Cp4iUP99sfVlLpqpl1oqRPIxm4V5KfPzZLK4pWcW7qaJ6BhZR1oyaW+Rp
   TWETka0/3HthJVzznt4moaD5Z55usfkuj9i1IVyGu+KpyupZzjz5d7+wk
   g==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="199451682"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 05:11:00 +0800
IronPort-SDR: HeX66d7I4Cfe6jiv9WgtmSIKeMC/lUOh00hY3Pq7gnivf9cqUPMsTjrPMn+LkJXJGDGgEM/bJ+
 LgxcvbFlC+ijsmQu5CtFEtf93eSEGZ5Zl2GginajBWmcejv5ChV64cFqTI7/WI8Z63H/5UNCGS
 m4AuTjxtNrrI9x5RfykXtqmRksfFQ0TBB8aCjOJSwAetpVg8TltVvNCHtZ8usanEDzL5BbLQ8T
 VDwPaSV/KvB/iIzEa1nUQtoE3/QtgKbhpnGgrWkTro8vvskW9EjuX3GwDOZL2h6hqQYS3/bQzy
 MR5/NIEKf0UbgKY0IU3waV24
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 13:41:03 -0700
IronPort-SDR: m+obfZPN5zYXnACjoOeEDI5znSWqQxdSsqJIb+9ptffCemUFEkHuJTQXvc+8uL8Z+WP7ZAqBqF
 uVt4JDhn1KdXuQZE5kr5ZgqVhMGKMcrgqAdonsDCSqIBultt8SPg8hObfvLiQ+ltUSrWTl0t/m
 3rE8urzZ+1g0a976IEimC7e4o0MC12EzKpy28+rfDKA8y98grNu9LZVT53BMEMu03GlPmbRAb1
 rNGkhZdQO1p+n9MMSrOfxlyoEi38NnkeZmpe22Ed0ROS8kB75fOfpkdjS6b4ggdynpVNQR3sHq
 ZzA=
WDCIronportException: Internal
Received: from jpf008298.ad.shared (HELO naota-x1.wdc.com) ([10.225.48.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 May 2022 14:11:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: fix zone activation logic
Date:   Tue,  3 May 2022 14:10:03 -0700
Message-Id: <cover.1651611385.git.naohiro.aota@wdc.com>
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

btrfs_zone_activate() "continue"s on seeing a devie without max_active_zone
restriction, and it never set the block group as active if the block group
does not contain a device with the restriction.

While it still return true and make the allocation works, it is confusing
for other code and it is waste of time to iterate the loop every time
btrfs_zone_activate() is called.

Also, there is a non-changing condition check in the loop.

Fix them with this series.

Naohiro Aota (2):
  btrfs: zoned: move non-changing condition check out of the loop
  btrfs: zoned: activate block group properly on unlimited active zone
    device

 fs/btrfs/zoned.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

-- 
2.35.1

