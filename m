Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B995F4F93
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJEFqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 01:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJEFqv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 01:46:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D63472866;
        Tue,  4 Oct 2022 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664948810; x=1696484810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uFxELFmiwDIu9C3D+tGh6lrwomyO98z7pVBflUIQI8s=;
  b=Z2K2/lVO4C/3IjLhQdXeuFMGiB8hNDhHHVa45vE3PJ8DXco1UahAcAq9
   nHY3zBzodHrly/02Lefj3XSt9bf0ToXGTTdhMmo1xartKQ5kWOZMADv+e
   AL8vDmzbLixO5Q8g3+BzYpmsGgA6aShX5PUmN380bHLvsZ0Sey7uQPGVd
   oATBef5q+Bit0ADBqmmGFNPSjzE4WLmUEU6CAp9I5ZOaq4UgQkooKH1YN
   cK1i5HizxkDkFW+OYY3LlyzSJEcfuj177BT/ebzWidN8SaqvcEEh40j61
   4SvnAhqHqVOqugtzGEEQM0uFcc1FaOEj/q+wxTgJXSsdeHLtSYxKvK+42
   g==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="317309476"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:46:49 +0800
IronPort-SDR: QVRDcLQqWP2puAN/rzFiDwyShG26VODW2zcsv139jvMTJfnXvw0R8DrVy6dZZoQNLfq5BUxtDp
 z9Ogfa9YSiRfXtN/OUIIBfrRb2JTw4OPZzZ/aY9Vbzan1JHjWLcTwynUKyh37lR4uISOIzDD0p
 rSOZVxEu+XZ5EP8v6MwMrttRnmJN5AAUhPq3/Gfr1m1a8C5WfoUN0r7ERyp1LDWS71SATqSbcZ
 SAg1xlmdBTVMi4B1swT9PE95P47Ct0AzTdG73WnKFyO0VzawUq7dhkJ+F5qhYUcN+GdRyKZfWs
 tWIuyd/NS4HxpO1rJo/+UyjJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:01:02 -0700
IronPort-SDR: erds+Y/Nx2nonIP0JB52iyqNQewVjjXIbuDlWXf2hDdraS2RvknTj5llSNywhw1eoNj8rn29yX
 EJz/VyagN5jO+rCI/IdgU5UPlGcHioKnqIicz7L+wLazPrO1FZdBgLAA4zRndC4F0z8gig2E6P
 EJHShHUNE9mg8+2l4gwTnlu744H7fIdUOIgVRXODhV0xQzX5EaVq59cwtTNQrwn7fm0lTpbWgR
 3trIgw621v803J/ZmYgC7xVP9rG6PHrwzJbKzOf04/k2C0/FUlkIJOU7/ofBwRUFQB8Y1hNgqf
 X4k=
WDCIronportException: Internal
Received: from 5cg2075dx4.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.62])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Oct 2022 22:46:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/2] btrfs: test active zone tracking
Date:   Wed,  5 Oct 2022 14:46:42 +0900
Message-Id: <cover.1664948475.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.38.0
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
- v3:
  - Fix import of common/zoned in btrfs/237. 
  - Use _fixed_by_kernel_commit.
  - Cleanup background dd processes.
  - Rework error handling.
  - Fix indent.
- v2:
  - Rename to common/zoned.
  - Move _filter_blkzone_report() as well to common/zoned.
  - Drop _require_fio as it was already unnecessary.

Naohiro Aota (2):
  common: introduce zone_capacity() to return a zone capacity
  btrfs: test active zone tracking

 common/filter       |  13 ----
 common/zoned        |  39 ++++++++++++
 tests/btrfs/237     |   8 +--
 tests/btrfs/292     | 143 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |   2 +
 5 files changed, 186 insertions(+), 19 deletions(-)
 create mode 100644 common/zoned
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

-- 
2.38.0

