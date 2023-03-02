Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532076A7E6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCBJqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCBJqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:18 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C618169
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750371; x=1709286371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BiUlq7KHxnIhG46uYmi6dJmELPgSEo8C8Q5VoFC/kCU=;
  b=FNOzRIVnlLvBpvhGiZwH6cCZfghsRA9sQTTW2/YRh1Yg/DF156/N1PGK
   uFw5oBICtXakWrRrns6+PYmnZQ30Ev2U7+D2aqMiRdbuCSgptUajspULj
   DJBJTnPQBaheFDo8juI6jmuEOvs9WlAKS+Zj93LvvLVmC0Nehx1MqHxIy
   3maSGXSAb2XKJ/eytowddCxcILbyNNpmhGHPx601XFoQ0AWohKrskgvZl
   mvMPX5Id8fTimPseoLHhbAAs26ceigRIIaSjB+OCgWSBt48osqFsXOUUu
   4gsgA4urMY/4LLo0oByfpH2axMCgnUjodxrpmo+GQ0d3LyjS2YIgZ1td8
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939193"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:44 +0800
IronPort-SDR: 3UKFP+I19/LqYDo8a7R5p9tpT15lSOX2VMH9POo1YtX+XqrRaw38UigKTWpQFyLq8EGeH5cqCy
 wBQlzxbCkA/sLwvPLNP+Mjkeo8rym/v5lg1C5zbE9R5yux9ygUrOf8arjz7ZeIZg6pMTs+IC80
 O+iSLYinF2RBlQUnqTHJnkjPiVsLV2Abb9gvb3bJcttZ+4icjP4pP0aDXgKKIJxvhMzAXj43sb
 IpECPGv8cn/ZoWmpLGOptTWJVCJS2N+tCaaGRrW3wkaBmvbA38An/fC0Yx/DAgQvBbx28eYno9
 Yac=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:49 -0800
IronPort-SDR: WJE8ESZnFb90+T9UrSDxVWaryO0ecMaFtwFrjN4eyZAOJVfRuq4sur2hOFrOzG33IKluc2C2AA
 9s+/ZrJB58w7FnHudsNA0m1rd1G4hGVnYU47Iru34OJxVVDtk04nuKY+Q3Q3TxWb8oKtol2Ftq
 GHdnz7p/C3ISealNDlWhEjfhndGymGh/+5mQeBEvPLjwv0tr1xw4Ice+WgmwDOsnfQBLOdn2AQ
 4dW+5IJkI3jeMJ6568Dqguoev7KJnRWdZKde30ar82lioyS4gmdXTiCyiPpgy5RW8DFlJkUubA
 TBg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:45 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 06/13] btrfs: lookup physical address from stripe extent
Date:   Thu,  2 Mar 2023 01:45:28 -0800
Message-Id: <c53918a56f5be3a3487df91f5e914eead3bb7ea5.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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

Lookup the physical address from the raid stripe tree when a read on an
RAID volume formatted with the raid stripe tree was attempted.

If the requested logical address was not found in the stripe tree, it may
still be in the in-memory ordered stripe tree, so fallback to searching
the ordered stripe tree in this case.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b4b615421643..80baabdef153 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6533,23 +6533,29 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		bioc->full_stripe_logical = em->start +
 			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
 		for (i = 0; i < num_stripes; i++)
-			set_io_stripe(fs_info, op, logical, length,
-				      &bioc->stripes[i], map,
-				      (i + stripe_nr) % num_stripes,
-				      stripe_offset, stripe_nr);
+			ret = set_io_stripe(fs_info, op, logical, length,
+					    &bioc->stripes[i], map,
+					    (i + stripe_nr) % num_stripes,
+					    stripe_offset, stripe_nr);
 	} else {
 		/*
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
 		for (i = 0; i < num_stripes; i++) {
-			set_io_stripe(fs_info, op, logical, length,
-				      &bioc->stripes[i], map, stripe_index,
-				      stripe_offset, stripe_nr);
+			ret = set_io_stripe(fs_info, op, logical, length,
+					    &bioc->stripes[i], map, stripe_index,
+					    stripe_offset, stripe_nr);
 			stripe_index++;
 		}
 	}
 
+	if (ret) {
+		*bioc_ret = NULL;
+		btrfs_put_bioc(bioc);
+		goto out;
+	}
+
 	if (need_full_stripe(op))
 		max_errors = btrfs_chunk_max_errors(map);
 
-- 
2.39.1

