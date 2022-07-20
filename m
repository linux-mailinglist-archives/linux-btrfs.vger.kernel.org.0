Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3857BAFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiGTQA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 12:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTQA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 12:00:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4026ED
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 09:00:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b25so13205007qka.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJiumJhFyN7pEtmeriAdKE0qLKxzO+bYPc7cyJuPnfc=;
        b=6JX5gS4tT/CQxtG2rYIKz7TPLXbeVQAhOCCegOQ59kuIhzpJN2HtCQYglhmooInFqm
         8+VBUBzHOqV2bvq5JA3DYW0Z2xrNU8GNYRO+CDdE1Cyw98lk70wdi7m00y5Pfq6EMNT5
         kDvCqYfQe4+6p5+cC5KaR2H4dQ4XmgRacsJC811+zT57ekT+Jz6lbpfrwl6KMImcvbsv
         JqbW6RsXW3tL1i6qOhLDlrrad+peam69aEZqQ2V9wUu/lpfIq1uevIE/7d9Ceiqq2V9R
         r2iNE6Oijr3azPTMr2mC+5gfbOJhV+Ew2FhSannrBf3Yi8embwin9j67ifEdU2xI2rSU
         tXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJiumJhFyN7pEtmeriAdKE0qLKxzO+bYPc7cyJuPnfc=;
        b=Irt98n5yCGPTbHwz0HMRqXx6lFrEYeWJcH4GlKGy5RPIBm004YJ9zGg/GZKsBzFucL
         sFwDMNNm9ehJWVzMsmA2nl9ywyuOSSspl53UjuIxGbDKWZ+ASxTEFNBYIArUJmfIR39G
         5Z2oHH0gJHgmskGm3f8m4YwB+xINr6Qkdiy/i9h0KaWKVFqcEIJXIvNYxxE+WWJJQyyQ
         gxM4l9KZ4DLxmijhDXJDXGTykSO/8nHm/TCuj5E/tmSVyKbZQ0spi5SlZ1JY68vdKPLO
         dSHswyIrsV26nj0NgJy3f0saFolyu9FJ0i8gbQN+mLoLh2bJumlxe87wtAvTIPvE+rEr
         ppbg==
X-Gm-Message-State: AJIora/ecfDz5gRv3VyQjy+R/jqQq2cFD/ow59p3G5gXFLskAqeOtWiw
        U54hngpvyKthRnYMjxMVFBfZorpZsqFSPQ==
X-Google-Smtp-Source: AGRyM1ucdi2a3htBRc5CKShNC+OOumcLcPRZNWe7gqMCWXPx12eJMaA2hnlqyRtMszNE0Mgz4SAKnw==
X-Received: by 2002:a05:620a:8085:b0:6b5:4b1b:463d with SMTP id ef5-20020a05620a808500b006b54b1b463dmr24828556qkb.24.1658332853510;
        Wed, 20 Jul 2022 09:00:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a40ce00b006af3bc9c6bbsm18365262qko.52.2022.07.20.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:00:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not batch insert non-consecutive dir indexes during log replay
Date:   Wed, 20 Jul 2022 12:00:51 -0400
Message-Id: <2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running generic/475 in a loop I got the following error

BTRFS critical (device dm-11): corrupt leaf: root=5 block=31096832 slot=69, bad key order, prev (263 96 531) current (263 96 524)
<snip>
 item 65 key (263 96 517) itemoff 14132 itemsize 33
 item 66 key (263 96 523) itemoff 14099 itemsize 33
 item 67 key (263 96 525) itemoff 14066 itemsize 33
 item 68 key (263 96 531) itemoff 14033 itemsize 33
 item 69 key (263 96 524) itemoff 14000 itemsize 33

As you can see here we have 3 dir index keys with the dir index value of
523, 524, and 525 inserted between 517 and 524.  This occurs because our
dir index insertion code will bulk insert all dir index items on the
node regardless of their actual key value.

This makes sense on a normally running system, because if there's a gap
in between the items there was a deletion before the item was inserted,
so there's not going to be an overlap of the dir index items that need
to be inserted and what exists on disk.

However during log replay this isn't necessarily true, we could have any
number of dir indexes in the tree already.

Fix this by seeing if we're replaying the log, and if we are simply skip
batching if there's a gap in the key space.

This file system was left broken from the fstest, I tested this patch
against the broken fs to make sure it replayed the log properly, and
then btrfs check'ed the file system after the log replay to verify
everything was ok.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 823aa05b3e38..0760578e0e86 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -691,9 +691,23 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	int total_size;
 	char *ins_data = NULL;
 	int ret;
+	bool need_consecutive = false;
 
 	lockdep_assert_held(&node->mutex);
 
+	/*
+	 * We will just batch non-consecutive items for insertion while running,
+	 * because the dir index offset is continuously increasing.  If there is
+	 * a gap in the key.offset range we simply deleted that entry and that
+	 * key won't exist in the tree.
+	 *
+	 * The exception to this is log replay, where we could have any pattern
+	 * of keys in our fs tree.  If we're recovering the log we can only
+	 * batch keys that are consecutive and have no gaps in their key space.
+	 */
+	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+		need_consecutive = true;
+
 	/*
 	 * For delayed items to insert, we track reserved metadata bytes based
 	 * on the number of leaves that we will use.
@@ -715,6 +729,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		if (!next)
 			break;
 
+		/*
+		 * We cannot allow gaps in the key space if we're doing log
+		 * replay.
+		 */
+		if (need_consecutive &&
+		    (next->key.offset != curr->key.offset + 1))
+			break;
+
 		ASSERT(next->bytes_reserved == 0);
 
 		next_size = next->data_len + sizeof(struct btrfs_item);
@@ -775,7 +797,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 	ASSERT(node->index_item_leaves > 0);
 
-	if (next) {
+	/*
+	 * If we are need_consecutive we possibly stopped not because we batch
+	 * inserted an entire leaf, but because there was a gap in the key
+	 * space, so don't bother dropping the index_item_leaves here, simply
+	 * wait until we've run all of our items and release all of the space at
+	 * once.
+	 */
+	if (next && !need_consecutive) {
 		/*
 		 * We inserted one batch of items into a leaf a there are more
 		 * items to flush in a future batch, now release one unit of
@@ -784,7 +813,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		 */
 		btrfs_delayed_item_release_leaves(node, 1);
 		node->index_item_leaves--;
-	} else {
+	} else if (!next) {
 		/*
 		 * There are no more items to insert. We can have a number of
 		 * reserved leaves > 1 here - this happens when many dir index
-- 
2.26.3

