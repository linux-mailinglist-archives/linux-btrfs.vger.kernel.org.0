Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1006A7E59
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCBJp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCBJp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:45:56 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE143B875
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750341; x=1709286341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/eo7HuIQ7ocuWDBEO4ykBPaYkvBhZ5F6L1dYcDQec0=;
  b=rhEPno7D9t5bwiP0+wpiDnoQeVYJWJoHvpK5VbDS5eJDM7GJRy+lx9NG
   EP9oYwlHJoJGXjanL9zXlcJ0fHzLTSpvZuPqUKZQ6zuHLToBJkcwp9FOd
   BQO/yT1GC27YAAAiWPMXbpyWK5YM8f5MiTURbU5rCe02eFlv9jkQt7POT
   zJyUgXQU/w3CssrV3czh+0k1xlAh2p81+l4PnmZUenUspH7WUdy+mzhST
   M3h/x4HYG+jWXK2uOWmBaH6GDzWOLy9rqrdSKxgRe4t9oSwPk0JP+sVAP
   LARqVek067wH84UEcqnwFgqVDemoIehdFdESC+BBvtRxlEwWKjpQ1e8UD
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939171"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:39 +0800
IronPort-SDR: YOoGvDn0oNc2KOBu6AD4ze2YliDAQ31tjUTCwAt5fekiU/+bL7NOyOBPlc6p9V7+k87NXGsbQ9
 gsmx4O+D/fMkEi1VMaOXbluSPcyes6DtQiMJrXch8te2Q+Mm1/lycR7pZiw08KAZNK10g1dr/S
 9Nl4dqEBwM9+HStBwYicD7jeIhOsMarb/oQKLwzrkqk8mSLG/2QTI+lLHRNVCTl237Zg2+/bRJ
 jQOeAJ9fOQB4w+vRf6vqRvCMaai8omjoiv4ekuSR7+P4vRefJ6iLX72k7DKDci/V+pGjpK6TG/
 hqM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:43 -0800
IronPort-SDR: /IphbyYWcls/wcIATun39z8rzmRG2YEhCY4+OLjWBQ3/rIksw1iYfPcsXlbn5xxffwo623YanQ
 /j40ZF2HW6zpM33vv+ULjVhC74xV37X3rndwdWk2NhsD4VRdDkGXW3TYITly0qtysdVpBYzIje
 XE0soipKmucDCcpPfxrNJEtCz67nou3scrUUa9KloarFQdtRR4z10/8iTVixRu4B8nFXVmkFsU
 6UYhP9nGSiB+h7QLEe7sGo1K+eDYCn5AaAwnn/iHPM9rcaxVFVTAWX370x9gDLhLsyEBcYygiR
 Gg4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:39 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 01/13] btrfs: re-add trans parameter to insert_delayed_ref
Date:   Thu,  2 Mar 2023 01:45:23 -0800
Message-Id: <f461b49660426b4ce56ff3f663e6495a572acc72.1677750131.git.johannes.thumshirn@wdc.com>
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

Re-add the trans parameter to insert_delayed_ref as it is needed again
later in this series.

This reverts commit bccf28752a99 ("btrfs: drop trans parameter of insert_delayed_ref")

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delayed-ref.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 886ffb232eac..7660ac642c81 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -598,7 +598,8 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
  * Return 0 for insert.
  * Return >0 for merge.
  */
-static int insert_delayed_ref(struct btrfs_delayed_ref_root *root,
+static int insert_delayed_ref(struct btrfs_trans_handle *trans,
+			      struct btrfs_delayed_ref_root *root,
 			      struct btrfs_delayed_ref_head *href,
 			      struct btrfs_delayed_ref_node *ref)
 {
@@ -974,7 +975,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
+	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -1066,7 +1067,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
+	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
-- 
2.39.1

