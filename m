Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7675649A98
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiLLJDH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiLLJC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:02:59 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C22F2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670835778; x=1702371778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIv9dDI1QAqWpspR3JUli5zmKvAajTrgwh+jhJ4U51E=;
  b=XaGkyknyfAPf/jDrkOM7INBxVxUfw1fyL1DxJRhAkDJd6Gd7F1lMIlAd
   jZvs/T8d+9lBfAt9DBs5Ot3LoFsduJJ2UgdNosLoqA4LH7tAEElUvRs67
   Vb9+gKpbn2SxZifM9KS10seMc20dAYFCJD8+JzLtZWqfgc6CA9sha2ifR
   Oog7izn+KV6b7OR7htH9Ofkheg6oQC9sDUEJeuhUw4JHTj3asMYYPwcJ2
   XU/cG5qnUXM2pClZ2aCaNbSNARItOmubv4OAnJX7nEq1zccYb9aVRq0G9
   5SevPS/R2n/o1y5xghzbt+Oms6wqC5gfHa/bKmAQ6BY3O59tyexYqxd0m
   g==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="322792943"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 17:02:58 +0800
IronPort-SDR: A9mEQ/BC8ezhlhfY3Uafo3P8vNLv96K9UDx9BtHQqWjzzEtvK2IRwdsbt2sHFBteecihu0to6j
 3DS9t2NEMlKdFdzo9LO8TSZrj0C8R1PKaH/aKJAJnyYxw+8ZkduppFbksHa10VZVQCttOrZkna
 ox9utz5EyT9LwyAd8xQ0LbOmX/mRpiOKOtxPkhfr+PqNvnTLkmYBlgHso6Lf9WCyzr3Gpb8EoO
 zIckByBH4Ek6swbxpiseVYVE90WP8tUgNSqxJuGBtJBLiSTuUivPWwE9b4Za9jX8xDyBZMnBLz
 aVI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 00:21:23 -0800
IronPort-SDR: CfMBdLYChplf4aC66zfT41vBQxu1FrhrcbVnvfA2yYuAuRaAfiVpN+FSJmor/Lq+3ALTxOjrdt
 s+lse6QkyNaGTG3k/Ic+cOtSLf8d4PLh4TAL/k46wXie3v9HwivtFy4Sa/o6hPi2IBhLlHzmUq
 ab+bVU6p2IBI+1aLKWdYFa+1MvTzJJHaWM6CuiP2sKiZgSiTK8Vy0wcUpIBCRolpG3I+2P1zDr
 xdXAikV0RP39krIjx0i0tpaZm8CGoGMQW2UOBR2RGh9YSI0nO8wQA971BCdrT4z9SGaH2tshbx
 Q7A=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2022 01:02:58 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/4] btrfs: directly pass in fs_info to btrfs_merge_delayed_refs
Date:   Mon, 12 Dec 2022 01:02:49 -0800
Message-Id: <49459983637681dd5d1b4c04d0f9dc2e6ada301c.1670835448.git.johannes.thumshirn@wdc.com>
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

Now that none of the functions called by btrfs_merge_delayed_refs() needs
a btrfs_trans_handle, directly pass in a btrfs_fs_info to
btrfs_merge_delayed_refs().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delayed-ref.c | 3 +--
 fs/btrfs/delayed-ref.h | 2 +-
 fs/btrfs/extent-tree.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 678ce95c04ac..886ffb232eac 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -497,11 +497,10 @@ static bool merge_ref(struct btrfs_delayed_ref_root *delayed_refs,
 	return done;
 }
 
-void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
+void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
 			      struct btrfs_delayed_ref_root *delayed_refs,
 			      struct btrfs_delayed_ref_head *head)
 {
-	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_node *ref;
 	struct rb_node *node;
 	u64 seq = 0;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index d6304b690ec4..2eb34abf700f 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -357,7 +357,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 				u64 bytenr, u64 num_bytes,
 				struct btrfs_delayed_extent_op *extent_op);
-void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
+void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
 			      struct btrfs_delayed_ref_root *delayed_refs,
 			      struct btrfs_delayed_ref_head *head);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 892d78c1853c..eaa1fb2850d7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1963,7 +1963,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		cond_resched();
 
 		spin_lock(&locked_ref->lock);
-		btrfs_merge_delayed_refs(trans, delayed_refs, locked_ref);
+		btrfs_merge_delayed_refs(fs_info, delayed_refs, locked_ref);
 	}
 
 	return 0;
@@ -2010,7 +2010,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		 * insert_inline_extent_backref()).
 		 */
 		spin_lock(&locked_ref->lock);
-		btrfs_merge_delayed_refs(trans, delayed_refs, locked_ref);
+		btrfs_merge_delayed_refs(fs_info, delayed_refs, locked_ref);
 
 		ret = btrfs_run_delayed_refs_for_head(trans, locked_ref,
 						      &actual_count);
-- 
2.38.1

