Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C9649A97
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiLLJDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiLLJC5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:02:57 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6DC14
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670835777; x=1702371777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5HfefLjnV3VwceLWnp+Nf6eguuH3gifuERtQxkldrk=;
  b=QKzOQ8Dzav1wKGgmDxbrPtzsZB0ZUwFN0LH+yBvvUjR2fWCg1sy6sNtE
   WYbr1TitOQMkmjen/mfuzM2pCxQlyUY/CxLwYmvITejwInUGb4GxKMydA
   NbcesBx9IaiWeN4QU52b3Uyl6dAZGyMjT5NWo8iD+86AYSMDcQv7owG2M
   a/4fiWuAFKhMteuiLjTh5EWfMq4uqSb6UTSvSJxM3EkJmbx0728nOqU1P
   S7KhTY1XK4TEgGzSMy2uxUYRNXdytTgAGfNZG5CiGLAxWmWekmI9aujEq
   DQAwB3TW3LF393/KReDR0NMab+DuDTKMpIpXCtrA9SWnjtLj4xsoQN896
   A==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="322792938"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 17:02:56 +0800
IronPort-SDR: 3Yae+cE/nM1UYoU8+HoXUKjNOEvn9YYsYMqX1ZPbEAx2YG/ySbw5u5qE0mnuXLFuo42vQ8VkMS
 xW4j1yl/hQBItIY+usOHSIOnp5XATI+cYGdcHupXDikpXJ9EaCNTbVXjayki/MPybpnmSC/2/D
 6dC+06bn9s1oSgl43Xn+WQKl1YhYSf7NNjGMBYxT1Gp6Wa5GHWMKUwER1UNrnqCXbGq3u8WotX
 dstvw3oFj3aeeNW9s6/5FvKLjz2KKQVuvY549r8O0I8Jpe+0TQxJw+Fh4v0Zj9ma7RvxY3kSw0
 vsw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 00:21:21 -0800
IronPort-SDR: W0x53FUpOD/NybL13emQla76s+zOV1k7UTp3xNdZHdi5ds9fqQjce7lDCMtz5YIwBUqa8iUc4h
 KYWGpsd9dYq066DFQqFRPilHoJTmZvFH/Dx0Pk1U7iEJlmh29gUbaZ0oSXgX99dNRRoRHjReha
 KKLUhBsXpEfPb8AmtssmFW+I8rzZlWAe6uqMJcMizZB6GcrP3NNxyMQZEMdzOm3xFke5NNQY9i
 3tMKpan8It6aycji1AoIcTiWC++SJyGmheQZFa5IZwwpOHlll1ybDmYnVoN9lWC13osb6ynrSH
 MYw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2022 01:02:56 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/4] btrfs: drop unused trans parameter of drop_delayed_ref
Date:   Mon, 12 Dec 2022 01:02:46 -0800
Message-Id: <96d11175d7b70318858469941ab125c3007b6a6e.1670835448.git.johannes.thumshirn@wdc.com>
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

drop_delayed_ref() doesn't use the btrfs_trans_handle it gets passed in,
so remove it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delayed-ref.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 573ebab886e2..663e7493926f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -437,8 +437,7 @@ int btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
 	return 0;
 }
 
-static inline void drop_delayed_ref(struct btrfs_trans_handle *trans,
-				    struct btrfs_delayed_ref_root *delayed_refs,
+static inline void drop_delayed_ref(struct btrfs_delayed_ref_root *delayed_refs,
 				    struct btrfs_delayed_ref_head *head,
 				    struct btrfs_delayed_ref_node *ref)
 {
@@ -482,10 +481,10 @@ static bool merge_ref(struct btrfs_trans_handle *trans,
 			mod = -next->ref_mod;
 		}
 
-		drop_delayed_ref(trans, delayed_refs, head, next);
+		drop_delayed_ref(delayed_refs, head, next);
 		ref->ref_mod += mod;
 		if (ref->ref_mod == 0) {
-			drop_delayed_ref(trans, delayed_refs, head, ref);
+			drop_delayed_ref(delayed_refs, head, ref);
 			done = true;
 		} else {
 			/*
@@ -641,7 +640,7 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
 
 	/* remove existing tail if its ref_mod is zero */
 	if (exist->ref_mod == 0)
-		drop_delayed_ref(trans, root, href, exist);
+		drop_delayed_ref(root, href, exist);
 	spin_unlock(&href->lock);
 	return ret;
 inserted:
-- 
2.38.1

