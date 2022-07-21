Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CD57CC81
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiGUNsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiGUNro (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:47:44 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26343E75
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:47:42 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id mh14so1205042qvb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO/snL79naOLQxq4QCCLXyQQsq7XdyxRDs5OsxX95gk=;
        b=3E1wJUDk0k/cfvAaBvKWP7m9gN+bs5nCmW3jgeoGxyyTOXPvieRpxCf/ZucQzyQRC5
         myzfN1qDLhcAAVFjPqnAbxAksz4ZZGu2MOlIBudIWOup7y9cKot3J+TvuOmgP1pw9Qta
         MgZdi0jFRU9URylGi6hR4tIK0XVWZ5XEUVANe2MvcQHB4+4IWDhtJaAV2D0C5c8e2KSa
         m9618Vc90HsvUN8nHdtK2qkvL7nz8dHg5R9VrZUbC1Ye0hWBBz0ANueVUj33VYkmcYpZ
         9ECc74phPBTr/19xM6ZnWKsqXYH06f2yYMyuFYMwlxrmTC0ykAIAJUG+jxNKWKv0D8cD
         mwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO/snL79naOLQxq4QCCLXyQQsq7XdyxRDs5OsxX95gk=;
        b=4f0LncanfXsOCgL/meGcgfBZqi5Sc6Lr8DZaGj6Ek89QGFja9AXh+5QIAjBOiYda5I
         HaASE8+0BD2NNliTy9SPlCwNWn+laK8xCxbIkemQacgtCRogp6nYwZPkLFjy7gquWBJC
         9giBNLAEW0lq4rGyYy4ie86gQUhT+vWm1N9v66TFOj0Nvwy4jre99vQc49xUJTj4DIid
         siXNH9ioJW2GaIO7xETgKm7TVYSiyZVQTigFWdmmFHKrVcsoX7pUmM+N7A7WYCLUsGL8
         hxDiyWvdHhBLhEmmfs/A6XsqrOS7XQueO7zLIny8JGLH5QI0Yn2P1Xxs/r5yw8G5AC82
         DenA==
X-Gm-Message-State: AJIora9w8oQZNTjVpJ0n9RJWavnqw4x92fVDNmBQtix0lLyhfG5hbuYj
        fB0JQ7Jqfl9iHuoQJX8GgsvKIQRIIkNrbw==
X-Google-Smtp-Source: AGRyM1sKYicS5Q4fOw99b3n2C7FM3fQyqMSrhubAInzwtYfY/hGrBr45doNtFn+8xrmTyyJlu17uhw==
X-Received: by 2002:a05:6214:624:b0:473:27e8:95d6 with SMTP id a4-20020a056214062400b0047327e895d6mr33596973qvx.109.1658411261378;
        Thu, 21 Jul 2022 06:47:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a12a800b006b5b7a8e6a2sm1329334qki.23.2022.07.21.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:47:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: do not batch insert non-consecutive dir indexes during log replay
Date:   Thu, 21 Jul 2022 09:47:39 -0400
Message-Id: <a69adbc22b4b4340a7289d8b9bbb9878d6c00192.1658411151.git.josef@toxicpanda.com>
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
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 823aa05b3e38..e7f34871a132 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -691,9 +691,22 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	int total_size;
 	char *ins_data = NULL;
 	int ret;
+	bool continuous_keys_only = false;
 
 	lockdep_assert_held(&node->mutex);
 
+	/*
+	 * During normal operation the delayed index offset is continuously
+	 * increasing, so we can batch insert all items as there will not be any
+	 * overlapping keys in the tree.
+	 *
+	 * The exception to this is log replay, where we may have interleaved
+	 * offsets in the tree, so our batch needs to be continuous keys only in
+	 * order to ensure we do not end up with out of order items in our leaf.
+	 */
+	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+		continuous_keys_only = true;
+
 	/*
 	 * For delayed items to insert, we track reserved metadata bytes based
 	 * on the number of leaves that we will use.
@@ -715,6 +728,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		if (!next)
 			break;
 
+		/*
+		 * We cannot allow gaps in the key space if we're doing log
+		 * replay.
+		 */
+		if (continuous_keys_only &&
+		    (next->key.offset != curr->key.offset + 1))
+			break;
+
 		ASSERT(next->bytes_reserved == 0);
 
 		next_size = next->data_len + sizeof(struct btrfs_item);
@@ -775,7 +796,17 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 	ASSERT(node->index_item_leaves > 0);
 
-	if (next) {
+	/*
+	 * For normal operations we will batch an entire leaf's worth of delayed
+	 * items, so if there are more items to process we can decrement
+	 * index_item_leaves by 1 as we inserted 1 leaf's worth of items.
+	 *
+	 * However for log replay we may not have inserted an entire leaf's
+	 * worth of items, we may have not had continuous items, so decrementing
+	 * here would mess up the index_item_leaves accounting.  For this case
+	 * only clean up the accounting when there are no items left.
+	 */
+	if (next && !continuous_keys_only) {
 		/*
 		 * We inserted one batch of items into a leaf a there are more
 		 * items to flush in a future batch, now release one unit of
@@ -784,7 +815,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		 */
 		btrfs_delayed_item_release_leaves(node, 1);
 		node->index_item_leaves--;
-	} else {
+	} else if (!next) {
 		/*
 		 * There are no more items to insert. We can have a number of
 		 * reserved leaves > 1 here - this happens when many dir index
-- 
2.36.1

