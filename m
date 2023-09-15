Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A17A1747
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 09:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjIOHZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 03:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjIOHZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 03:25:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FE1720;
        Fri, 15 Sep 2023 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694762716; x=1726298716;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7b0wwijAcb0CQGppuiXE0z9DmHBBPNw8T5LderyaHEY=;
  b=kjGDSWOGCp2QJepFucHkAM99PW+D5OsPjUMrpEq+sJAYyxRqXMhTcy+I
   +/zUe0Xn71CMzcxU9whf4eRjIu7JujiPNEfQzjpsaBCwO3TL+iePfAX9y
   ZWw6+/ZLR68S5k2yfZVonvzxHMoe6IOk6WJOhLmWqz1UNSx+njt9sBMwt
   uBFqVBSrT9/bpz/8DGkti8nYjtrkssMr8rrVMFh53ytiOwmgdU2qAqrIB
   oRNlFXcQSz7yAbvI1Urew7xsUSC+4wmId21qEMDSPazjQDxngBRw2HNuJ
   hmcgOzpWi5jKSlZ5i+S6k/ZUHGglR7e5QarP5GeVITe6wZ0wS4kFNCgXf
   w==;
X-CSE-ConnectionGUID: HNtWz3CZSI+LuPDX/j8oxA==
X-CSE-MsgGUID: IQ1vuE48RfO7a8yGuZJEqA==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="242254963"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 15:25:16 +0800
IronPort-SDR: Kpv3Kn26i4oJIF4U83H/2yMxuuBaCFVjg5e/DPXV8h8wHQ7Rcqc/gG4c3CszZHFgOw808/s45A
 nwBLrttU1+i4yV7VVr1ioy6PIdt6SXL+N/X4INoTqnGjcSkkf4fvqZrn68seabgRbWk/QTgc7p
 9iKaXM90FnA9tj5IWLCl8suGl2HJHXWX6vil/PhvubAIlEA2bMScprC97NXR3058j2qabj3mpG
 0aIBZu6yF0ZxkEjbtmnZcwbia26qsX7JeYmuL3kZuDuLbLk7aO9xmsznQVW0cblCnV3ZXTKMK6
 C3w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 23:32:16 -0700
IronPort-SDR: lsGhvsL1FTx3PUrK5KnpEyNQZux/vlNEb/i3SH0+b9io8/8b1U2g72cjv9P410A+mUxQ47+37K
 SEx0wf90FuvMHn/6V5a2pAgsf0YoTVyMAzugsknkZJJnhb61UTBVO36GmN0UE4HL/7xXiuIxSV
 j9aGjWN8zUATvYPIRsPS31zBaBMZWUjqeULOlea3AVkLCN6YJ453bP9fJrBX+ZP43TFu2hhYhz
 T01/vYJMBURLLwQW27kH5zMvIv+xRWmP/7D/mMiQEbQwvmSXAHOlry5nxTNLrSkQ4OaU4lEAS6
 9hM=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2023 00:25:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs/076: fix failure on device with small zone_append_max_bytes
Date:   Fri, 15 Sep 2023 16:25:09 +0900
Message-ID: <cover.1694762532.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running btrfs/072 on a zoned null_blk device fails with a mismatch of the
number of extents. That mismatch happens because the max size of extent is
limited by not only BTRFS_MAX_UNCOMPRESSED, but also zone_append_max_bytes
on the zoned mode.

Fix the issue by calculating the expected number of extents instead of
hard-coding it in the output file.

Also, use _fixed_by_kernel_commit to rewrite the fixing commit indication
in the comment.

- v2: Only fixed the subject lines

Naohiro Aota (2):
  btrfs/076: support smaller extent size limit
  btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel
    commit

 tests/btrfs/076     | 29 ++++++++++++++++++++++++-----
 tests/btrfs/076.out |  3 +--
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.42.0

