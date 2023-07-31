Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DD769F4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjGaRUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjGaRUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481531FC3
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823970; x=1722359970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxbYhci5eiE+WBMGE/BPON0esufGYWlKynCosHnf6zo=;
  b=eK/7J9v/BvHTJWfDxr6XEWa4E3ZCdz0L5eFT0Es4x3lTEuwfmmrNJKvX
   9UoIHbLHJp20rRzIpxPrZXpBLptNDNWyWxA/5b0d0Vq60635kHyPfdTqM
   vC+0YVmYgaQnt4dv/UB0ACRRjqoLiN7RdrKZBBL6hv1XS1vhp4atKNQQQ
   2GPNHlA4zX0yr0VCwLkXNLx03qL3Hth3NOaHSd4l7Vz9Z5WzBpTKeH+Jp
   dZx2jutWT7u80C5sgytQ2KQzpnZylgqX65dal3Aj/qoMfUT6kEEcvALTC
   ya2ni7nEQjU7TSXlyUIPPUloV8QhMAb0ifAG09fi+xxr21cMFKQoGx1jU
   A==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269577"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:42 +0800
IronPort-SDR: BUmB65LYMaWFJtUuhcA5appfXRH3jiZqoD5qXcpE+uGKm29NO/SDltKEbyii6mtO4eVCwmsvfe
 oqqiNnHBXUywewvJzpxmCxBn4LEBpcWOcsWCCRca5+EJ/aVe+iy4ScdqMNuums2czYld58JlCq
 Uvrl39p5EF055hcYa/QMPznKoJ9QRI7Cpx5KCNlcvfs1eWCDI8AYrjn5Z70kWULVukDBqMSeqL
 U3/tDz2r1kTmmu+83IY07usM9J4aMQcFalHWGv691IL3beI+6ikKYTW2L0UejGsN8fP1jTNpXY
 rds=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:19 -0700
IronPort-SDR: hR1vK/lHCQfnIyMVQ03If2naTtL1Qzm43NlT24kowIP8Bf0x+omfBx3u+Vqw/grFiS7FvbmInu
 cMpyNeGwhMV/r9AGM/tES84eV2AgEk8DBln4Vj0FFTz/zQHCGu0mEQQj4oweAbmA3bXIsrITyR
 HcAHc0AYczYpmpP46y54ccZ7+ERLs+NtskkgxQ501zNCt36Rsj25fdHs951P3xyIscqTbjCKdf
 kydkcHlRbU+E4kzawkZVsqbnnzuuT7gQJUrzFeFjXlwmitbmqhug6iXCpPjQgX5MN2ahmzVP2j
 CJE=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:42 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 10/10] btrfs: zoned: re-enable metadata over-commit for zoned mode
Date:   Tue,  1 Aug 2023 02:17:19 +0900
Message-ID: <be465bfae4cd5b64aa1d0e4920f61a66dc4550a8.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690823282.git.naohiro.aota@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that, we can re-enable metadata over-commit. As we moved the activation
from the reservation time to the write time, we no longer need to ensure
all the reserved bytes is properly activated.

Without the metadata over-commit, it suffers from lower performance because
it needs to flush the delalloc items more often and allocate more block
groups. Re-enabling metadata over-commit will solve the issue.

Fixes: 79417d040f4f ("btrfs: zoned: disable metadata overcommit for zoned")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 356638f54fef..d7e8cd4f140c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -389,11 +389,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags) &&
-	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
-		avail = 0;
-	else
-		avail = calc_available_free_space(fs_info, space_info, flush);
+	avail = calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < space_info->total_bytes + avail)
 		return 1;
-- 
2.41.0

