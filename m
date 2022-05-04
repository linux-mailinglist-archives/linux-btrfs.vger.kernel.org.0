Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E425192FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 02:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiEDAxN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 20:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiEDAxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 20:53:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB03F881
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651625378; x=1683161378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJ4qwMbBCUweIqCvZNG9ToTimuagjupKpXA4hL5+tSg=;
  b=dWny1gNuOvrkUepTDhuZ84fJ9QmHG1IhfHdBotKNcfSUHKxHGZo36jC2
   /aVMJ8W8LoGjzNSNRQeo1SXcb0yrt7r6Cr2grXqD0N00o3J9GIcK71SL4
   Lljrqt8w87T0NVPcIrxtNIs8iY1KNiOUU6bVWdU/IcAFmXrDVz0VQFFWW
   0PTmw6QUFU01alDJmeWFMJcS35kJVjItMJPduFdbEEuE97DdQ1efOBziL
   xKmr2c3RQQA4VLjvpPtVzjgw9CjA3k1WGQq4DFYICbIOVY7gW/Ve7t3Zy
   zNs2+EYo7m7VTEc6ho3aDbo2GsciaR1zRvcCflxhdq5Ky57RXxy3daa/Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="200341871"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 08:49:37 +0800
IronPort-SDR: chbFKmcMIsF0OFY/oey7r3lnBjO+kHQXetgzm/25DO9uOWAp1W3aRsF4jgNa4mLVhiVHsd0eii
 bcFPiHD+BNl1KkuAAaxExMZ33v4x+gDFCVpwCDlKPM2yrvnUhqO+OJj/oX4KQSTy6jJRfkDmbM
 dxE5FxghZfGwItJkhUvgCTkWF9rBIQfcGY2oAXJ7DCQTzAuSv9DDgrdfKrrklhtAJ6wuHrfNke
 wrRnE6CjQaEI6RzzvlBIAHJ7FKbRQk6eHzA1bL6kjW1JBnIPQVcpfhhj8OtO2UjibOiZjSICTk
 /W6yD0QbdfSeLxyI5mko8jK1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 17:19:38 -0700
IronPort-SDR: D913By38l3XaSFBsC2bhCRFpHrZPPGUXfXvQr4uF5dbuwIEi3SfzLpD9wYVuw6W/7hqC2hIwrK
 3ryV7TVzMUFs04bMx+y9Sk6pSVPW2qro6Az0a2TOY/EkcM0thXp1BcH7DBCG6Sb+9z69n5EYuV
 jbFy//SDSXmVjvf6h1vm7B7j/y9usDAMZFUIWCEvYeFuPVgbG6Ji7pY9II5fc3Gz9iNrBqa30S
 IoyC9H0QLjqqDbSwWCnV8y9LTec09jKxBx90AC2pw11M/RZNlRV6f2rPpyM3k4aynt+rEtBIBG
 hxU=
WDCIronportException: Internal
Received: from jv0vzd3.ad.shared (HELO naota-x1.wdc.com) ([10.225.48.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 May 2022 17:49:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/5] btrfs: zoned: fixes for zone finishing
Date:   Tue,  3 May 2022 17:48:49 -0700
Message-Id: <cover.1651624820.git.naohiro.aota@wdc.com>
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

- Changes
 - v2
   - Rename some functions/variables.
   - Intoduce btrfs_zoned_bg_is_full() to check if a block group is fully
     allocated or not.
   - Add some more comments.

* Note: this series depends on "btrfs: zoned: fix zone activation logic"
  series (patch 1). I found the bug addressed in the series while I'm
  introducing the helper. 

Commit be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
introduced zone finishing a block group when the IO reaches at the end of
the block group. However, since the zone capacity may not aligned to 16KB
(node size), we can leave an un-allocatable space at the end of a block
group. Also, it turned out that metadata zone finishing never works
actually.

This series addresses these issues by rewriting metadata zone finishing
code to use a workqueue to process the finishing work.

Patch 1 introduces a helper to check if a block group is fully allocated.
The helper is used in patch 2.

Patch 2 is a clean-up patch to consolidate zone finishing function for
better maintainability.

Patch 3 changes the left region calculation so that it finishes a block
group when there is no more space left for allocation.

Patch 4 fixes metadata block group finishing which is not actually working.

Patch 5 implements zone finishing of an unused block group and fixes active
block group accounting. This patch is a bit unrelated to other ones. But,
the patch is tested with the previous patches applied, so let me go with
the same series.

Naohiro Aota (5):
  btrfs: zoned: introduce btrfs_zoned_bg_is_full
  btrfs: zoned: consolidate zone finish function
  btrfs: zoned: finish BG when there are no more allocatable bytes left
  btrfs: zoned: properly finish block group on metadata write
  btrfs: zoned: zone finish unused block group

 fs/btrfs/block-group.c |   8 ++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/extent-tree.c |   3 +-
 fs/btrfs/extent_io.c   |   6 +-
 fs/btrfs/extent_io.h   |   1 -
 fs/btrfs/zoned.c       | 176 ++++++++++++++++++++++++-----------------
 fs/btrfs/zoned.h       |  11 +++
 7 files changed, 128 insertions(+), 79 deletions(-)

-- 
2.35.1

