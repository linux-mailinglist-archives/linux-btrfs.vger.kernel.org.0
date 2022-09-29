Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8E5EECB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 06:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiI2ETt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 00:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI2ETr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 00:19:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC732DE7;
        Wed, 28 Sep 2022 21:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664425182; x=1695961182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fuVGnARmzsW1A0GCCZaX3ZKDv6TW3ClG7AX9D7lPKbY=;
  b=EQTD7Qh3T4M8EdgM73X43vGeYUwE8UlVc+cYpBhQNFpx2xEu5hjSFVIj
   w8nTNjabvTcWTn0tUjkE06UNl8rvHTA+haYzZm0XbJtTkKQhnv9t/GoWl
   IL4XmYkuG8iJPxZvytN2+PJ/sHrE/Ah8pTIuY1PjMoK3nFTFwckUeJh+l
   6m2uFAfS/L+nI11B/p45LhYjNjddHxwGilv5MkgO4DiAeIgm2JIEfIwIx
   1ltcFfZxAXxrrR2htrbpBoMJRfFVpDQ8WPbP+JRI9M8pnUS62JHpaKqdp
   tNFkou9Uqx085N06rSsGPgekLrEoJrt2zPDJd6gA2ZsOHLntJKrdLfFLw
   w==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="210903785"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 12:19:36 +0800
IronPort-SDR: pSMyV774hlsK4yYVVx/D0MkLu/OoG9I6krz4b/QvxSu+w4n2n/7d/PUa87W+VlR6aOQGJdTIxu
 JcyAyyBYAMhIKo8uLNzOZiL33hs4K+dj3La9yi85Hr4AMZ0hiGTQZghN+Mc9syZNEmhkKlD4aO
 3CFZIy5rujvcD4uOX8gijc0wuvN2rEIiUtkHgdesNmEqPwPzuNDJOfIITJyH8FF1uSk5BFQf7l
 HN270kCVw8PPlTZmXrcEOykIDLeZawYDpCvcv0S81IwTepQOt9yWpsUVITNHYgtGpeRYpKLBYa
 wniBhbWLmESt1+t8x3f2zyV7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 20:39:30 -0700
IronPort-SDR: QSlEuDWaQ833cEtZclehG1/3deCOs+XVYdZRLXr1A2F2YsMBkzI3zAfWE+JP+Ox9CQ+R3u0n/z
 X7OlRzYfEsZfVDM2NxsrsINhhL+bjcBOdXFc7ds1Wq/xiCuWeC4cB6MSFLGN5tzvNMJzGv772S
 +WGahGGY7F2Fx3oyXBwKijwdV+L6yom2jiFQsX7pkqI7mbLXASUBN6NS6yZP3ymltH2+PHb8uA
 QHIBjTqxq+ge6ovsh5L2jlamztxjfwH2MqrmEAiGSkisjmvRBeEDZYW0IzhHPwI1NGxtV9hC5w
 MYI=
WDCIronportException: Internal
Received: from h69v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Sep 2022 21:19:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: test active zone tracking
Date:   Thu, 29 Sep 2022 13:19:23 +0900
Message-Id: <cover.1664419525.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
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

This series adds a test for checking if an active zone tracking feature of
btrfs's zoned mode. The first patch introduces _zone_capacity() helper to
get the zone capacity of a specified zone. It rewrites btrfs/237 with the
helper and use the helper in a newly added test btrfs/292.

Changes:
- v2:
  - Rename to common/zoned.
  - Move _filter_blkzone_report() as well to common/zoned.
  - Drop _require_fio as it was already unnecessary.

Naohiro Aota (2):
  common: introduce zone_capacity() to return a zone capacity
  btrfs: test active zone tracking

 common/filter       |  13 -----
 common/zoned        |  39 +++++++++++++
 tests/btrfs/237     |   8 +--
 tests/btrfs/292     | 136 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |   2 +
 5 files changed, 179 insertions(+), 19 deletions(-)
 create mode 100644 common/zoned
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

-- 
2.37.3

