Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1C697E6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBOOd6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBOOdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:33:55 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8C38B70
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471621; x=1708007621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Th0z3TBAN6emg+sUWcZJUMYenoGn48ne488/Ef3KsKc=;
  b=nKgnXHyVJJLwAVLF0EeHETfpUCHmQYoeLTBbPeWGvV4lR6Uy0p/5Ivkr
   D9Vuo4rNquFcSusFskHTtJpN3SG0CYlKk49VwBbzXGmOl761vcdmuKiG2
   bzlBl9IdFk/gkvqr3NOD8N3ElNCVnJ1MeO2IXuHcKNnD7X8qb/bDqDCpl
   P793xL20VuCseNcNzaZ1Kv53V2WAq9KoaMqz2dZ86FXPDSUsZec0PsMX6
   Fi2KCduiIHZmPPK/jaulGLoAknBshhPSGKZxeQhvdH7QjQ6nbh2B2YK0g
   szcoQsXok58FW6+JLSxhMkhQvvg+3v6BeeCVyq1WBaJJdlZ9q3C7BHgRD
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394063"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:40 +0800
IronPort-SDR: FTAtdxA0GpZ/pC/Ohcb2XMqv0uOBAkkpPKcmjaMSYmVewlbkc/CKnUkm02RwSPPjBSA1X2kChf
 hoDAKIJzhjVmuf5aw1FI7S1gTUyYi15WDvd+jYKSIE4AHqInH/zRbHFSX7AT77WWencR7X+Rdj
 +NXS3LtdWiZ2YmnYq4q5t5blFjmhvMI8K9/kJCiFG+QhbcecshkV6dwOHD1EXX97c4v5/qZ2NN
 piD2gyEzVfNUcHhBmp1tcC44xTukfvvFG9l+3ATbVcf+tV4i+0QcquZPCCNwovmH5TkKPifyng
 3YE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:02 -0800
IronPort-SDR: iQT5xUZnn12Lo+ntEgDqZ+TkfFTD4R9QPD+gbE/GYYD/pkhLT/8oeZ+390EueKncNee5fyFEPE
 lNzASJl9oT2DM03CsJm6MOPJhyovrIAAO+CMwaUzrwMcVnEPmcRtCCn5HguZ9uhkV1sKbKIlqE
 tBWOYN4/evSz2477PM9TeIP69zejw9j5e7O1YDEHqUzPOLweumxVBPp8BDhbUWCpWKafm6u/qR
 t5pVI4XDzDYb1lCqb6YxZvnqz+sT5+wtdKr86rIez82p9zBJzVQ02L77DFTdmqgo6SsZ2cObOL
 wCY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:40 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 01/13] btrfs: re-add trans parameter to insert_delayed_ref
Date:   Wed, 15 Feb 2023 06:33:22 -0800
Message-Id: <573cca0daf4c9178d9a2aaffe7c5f071e35e537a.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
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
2.39.0

