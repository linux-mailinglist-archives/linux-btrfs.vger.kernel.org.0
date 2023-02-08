Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF768ED6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBHK6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHK56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:57:58 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFFC12F22
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853877; x=1707389877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a1strDIm7tyg8w4s1CKx9LdLPKzwnd4fihHxz4o2En0=;
  b=b1Drmcc6gLifG32If0FjQ9tvd5fcHv2Qm6DpTnujCpyPDgID+1VYpqkd
   NcuuF23JUHrPN3BdThLTuGwBzxwgXPu+I90xkXmvKpjDAyA1dv50OHio/
   bDQsPsM5isg7cYwR1Fe+p4ZjUpBMM72tizVA7aqxqM7/SXWJn4fH9Gman
   /bwoxa5uw5Mvg+2vsJtHd0eyREMcJzj4FfLbHsMQzIgfSBx4kFjbA5hvM
   bi69DaNkFaXQyYIC00Zka2POfq/c6+6gKynMRj5ETM3ENgBPE0A2vGBdC
   JQ1klscmRcYfP2BrG4fu2wR+PK0raOYiXiPg9fVvLcELJbTDcpJmhrppC
   A==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115625"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:57:56 +0800
IronPort-SDR: imLlfBSBYHPGbZZypKZPKg/B9uqnisEDzihOSoq9UBYvNgl61/S0Z9oKXf9SV8OrFre3xn6/5H
 G6UPW8FSVO73vqX7RSmUNhHveuaZWtmBaMUP//1/FgnrSf2wvir+U1tZkrSSGpTWUVQjiVkKlX
 KsA8MuLRAQrSSXbUdgi9neZs8325l+lAQIW7jYebOEOrKYPkMO6ShcTBPYT441HJeM5UlbhimZ
 0edln1G6DmK6/HiLoYh0mUfP7e+NDpJRInWx5kYxLO98XqdFqiY/SIagUmemZxBlcncw+x6xBh
 x4w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:11 -0800
IronPort-SDR: YJzRk0oEc/5G7i4zPCDnxvpx+RouH64CXlBrDje0cr6E7YBr65zWDIjaFRVISydx8DS3slOTJ1
 EJvdktAhBVE/JBgAjF9e/dr/SBMEjNC7CTVfjBf53DImvC8FUoRGPT4TYvZ3AuXJ/4FxNIvsbo
 f2e45LbXufshpkEsr23ekNxB3dQ1YzAzMHbnZit0YrPGnVWCjJBb76k8OLyrPqXiFdKfebqUFl
 dGFYZ7zQnvrZxn9Nr4DIhTWzRLzmchO7YJhn/+riIzUmdt3aP0HKoBX95CLFzp0PWndnxQUudp
 OYc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:57:56 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 01/13] btrfs: re-add trans parameter to insert_delayed_ref
Date:   Wed,  8 Feb 2023 02:57:38 -0800
Message-Id: <19d1a7d054f4127c750b91692835de5abbbf164d.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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
2.39.0

