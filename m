Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484CE649A99
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiLLJDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiLLJC6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:02:58 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F05FD1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670835777; x=1702371777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QNwXG7yn6I56eUa8BOj/TPttDKfVSAjLnM5woJOmXpY=;
  b=I1XsjdYpN78WsSSNxhCuocwYYTiZKTccHmisMDUxXQVgznhO1TSHCNtI
   REZ7ELnHMCWcAZrOkUp3jnKI+mR+plIOFexVY+QAZS0Hajjdh8MvLn4tF
   9cYki8qG4UWBm6TKtsZOnIRJDBShCROLT1MtkwhoklvSUBfarc2k0/Fim
   mQVGD+LtTfLWBLXHoDYislcYIfsi8mv06NqcGA9HY+V1BvH4SebgxcIqK
   sVOKu6EQNvTTNdw7nBR2AakNZXXQa9GNpNftIRchi1VGsQGrKDy44tgkr
   BRkY6G2Rongx+SmmhoxP1c3/3HaNnvAe5Jo/h9OV5GYMgFDYe2m0eI/q6
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="322792940"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 17:02:56 +0800
IronPort-SDR: 1gDgSy0Dj08JchBUtgwvTKF7l0yRjmvD+kwON9xYi+Y3rgFAYNAivjmjwfUsmbwUNUqEWSGvel
 hl1MYNtRCq+ZCmlgrXIzSW6TlCWPbVEP/6wXFBZiBnNVgLLlXt5oChupMdqAeGiNnPKUuQUOYN
 +wamL/qCjpf0cJYlErcVoy2Ta7y9zpB/5F1BRqtDnbVFvzJXv393ZeNTUh3cjk8UehvoDMV0A6
 B+tVobzSNujgR8RIYBM0UgoeLLGomBUwOE1UJk9R+n6XzXKZMEC4jAXZtE28QL2f+BDnapXat0
 R2Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 00:21:22 -0800
IronPort-SDR: xQdcacTNdOaL9Jsp4Z/mMfph58cd4UiZlWbHoUddy9Wb/39V3XvJ0xBZCyLc6QVB/HYZL3ueIf
 jWr6Cz3jPV7gAjzlBodRkynt+v+7OQUB8Flae2n5AoDn7/Q9DBEdhtDQAY/s6Z4toIIgZRTpIR
 pzvYhNtmpBvqcrP4K5HaZuhcChZPCY5EY2WLb46IYSZLZd2CI+x824GQRYEEYkRlZkhOo6gXGR
 zCvMGjowp6s5+ZCI2NCGtHBmML/+j8ahL8s2BusTeenk8hhzhpEX9FtPf7J5BIKqjrzTeWsRJM
 LkI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2022 01:02:57 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/4] btrfs: remove trans parameter of merge_ref
Date:   Mon, 12 Dec 2022 01:02:47 -0800
Message-Id: <730412da5b804df3b373aee79429c8ecaebf2535.1670835448.git.johannes.thumshirn@wdc.com>
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

Now that drop_delayed_ref() doesn't get the btrfs_trans_handle passed in
anymore, we can get rid of it in merge_ref() as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delayed-ref.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 663e7493926f..046ba49b8f94 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -451,8 +451,7 @@ static inline void drop_delayed_ref(struct btrfs_delayed_ref_root *delayed_refs,
 	atomic_dec(&delayed_refs->num_entries);
 }
 
-static bool merge_ref(struct btrfs_trans_handle *trans,
-		      struct btrfs_delayed_ref_root *delayed_refs,
+static bool merge_ref(struct btrfs_delayed_ref_root *delayed_refs,
 		      struct btrfs_delayed_ref_head *head,
 		      struct btrfs_delayed_ref_node *ref,
 		      u64 seq)
@@ -523,7 +522,7 @@ void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
 		ref = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
 		if (seq && ref->seq >= seq)
 			continue;
-		if (merge_ref(trans, delayed_refs, head, ref, seq))
+		if (merge_ref(delayed_refs, head, ref, seq))
 			goto again;
 	}
 }
-- 
2.38.1

