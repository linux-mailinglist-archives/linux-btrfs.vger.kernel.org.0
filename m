Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F83649A96
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiLLJDH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiLLJC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:02:59 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8D6353
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670835778; x=1702371778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29WyzW0KaUCeypzRBWUMzRWkyxdtqldnF6bii/Y8veY=;
  b=W3d3mPuUY+H2XryJXqegeTaBnZ/YBBdMsGbXDjh0LxLalFJMgnf7DGhW
   LVc3VqETezVsMXJu7ZDDoBoWnM0iO7yIYrCnj8Dx7QfopeOQNqRmEEABe
   d3RLT/o0v3hsvB+lO77c10C8QEJI9Chq++YONdrFn/yitAclVGrsqqzXu
   Y1MP1suFLONy5cq2BK2xE1Oj7Rn1wrGMJLzcVFiuGZA2nB79Ago92j0Xm
   5nxAGCWec/IZsp2uRbQ0kwJuA9fwxiUoRU7fJts54kQ37K4hanhADek0/
   mLg/9e12t4Px8TvlVUAtB8SZTHdgb9Ozm+jjZNDYJwRCNL9jdUm/Ml4G7
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="322792942"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 17:02:57 +0800
IronPort-SDR: jjKeYv6/9DWK/6dvKuhJPOiBx/3crBHo+KSouBgCrSmTaMXnG2cWYJJ/ewOlUfptp9BFXkwz2H
 YnTT/UgthJVV4S+CytXU46yISvjSwJJzfuuCu7DLeN/CbE6B0Y9IL0yKJOfuxaPAQBpF2dnMtm
 MQZeuM908g66zaYao5yLkQvQ+wdjDjRLsj2x6vDGnslaTvqPpxKuHZ3wN/Y7k8i7PmoUIWEIph
 wahzfG76WBB5xgpIAFwuIjXNMsNmN2w1Su3p63x/Gf3cnMszzvNpL5eAgmqG0Zk+IlLYjQMYdI
 VEA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 00:21:22 -0800
IronPort-SDR: N7fBAAvtUojR2fArroBjs7UNrIS0SRmqpPCcdJPG/sXKRqZ7cpBkFw7Pnnlc/hg69QGy4YSpxV
 pra1hwowkDeIe5JBjJjSSfokxTP6vcxzK/hFT6zj5mikRW9nt0GIvhFUZlKVaZKW+99moRsCR7
 9xrRBw757EnLFKEEJwGfKus6dvquIOn41uwXxN9mhlggUZoZ9VeMA1/vzksXqRHEzLVuXElpFi
 xO6mO/gT3/cu3Z75CuXRWVXCu8/Nlrz4lDg4Nl7Yxn4TYFoMNOyaOLfRRFnF8hN/HutDj8S/5D
 JpI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2022 01:02:58 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/4] btrfs: drop trans parameter of insert_delayed_ref
Date:   Mon, 12 Dec 2022 01:02:48 -0800
Message-Id: <d47bb8668e2d3307923d653d781eda65582a6a1a.1670835448.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670835448.git.johannes.thumshirn@wdc.com>
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
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

Now that drop_delayed_ref() doesn't need a btrfs_trans_handle, drop it
from insert_delayed_ref() as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delayed-ref.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 046ba49b8f94..678ce95c04ac 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -599,8 +599,7 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
  * Return 0 for insert.
  * Return >0 for merge.
  */
-static int insert_delayed_ref(struct btrfs_trans_handle *trans,
-			      struct btrfs_delayed_ref_root *root,
+static int insert_delayed_ref(struct btrfs_delayed_ref_root *root,
 			      struct btrfs_delayed_ref_head *href,
 			      struct btrfs_delayed_ref_node *ref)
 {
@@ -976,7 +975,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
+	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -1068,7 +1067,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
+	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
-- 
2.38.1

