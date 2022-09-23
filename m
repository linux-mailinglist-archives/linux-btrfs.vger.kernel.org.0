Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96E5E7A22
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiIWMGb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiIWMET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 08:04:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D432B9F
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 05:00:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89B941F8C7;
        Fri, 23 Sep 2022 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663934408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKDuiuSo991nHhqdDuhdjorezDKnyusUTVLG7Z07CSQ=;
        b=lnautrDupIpsQuFZtgnFvvbLuaZRcLwQa8lVapRYoFmT7/HLjODJ/pg186s0CzFi2yO5fU
        UCkTFXf/toYL+bfmqAlcRTeIUzH9dmL0aKUB75++vNlj6InwGHKEb9CUhDMNBsPS5J9Ueq
        TsvJM5/55SbwuTlEDmRsM0CXDSXK7l4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AB4D13A00;
        Fri, 23 Sep 2022 12:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GKEQGMefLWMqaAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 23 Sep 2022 12:00:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>
Subject: [PATCH 3/3] btrfs-progs: properly handle write error when writing back tree blocks
Date:   Fri, 23 Sep 2022 19:59:46 +0800
Message-Id: <3b4a860cd4d9091def2121e0c67d312a99ae0dca.1663934243.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663934243.git.wqu@suse.com>
References: <cover.1663934243.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
If we emulate a write error during commit transaction, by setting the
block device read-only, then we can easily have the following crash
using "btrfs check --clear-space-cache v2":

  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: 5945915b-37f1-4bfa-9f64-684b318b8f73
  Clear free space cache v2
  Error writing to device 1
  kernel-shared/transaction.c:156: __commit_transaction: BUG_ON `ret` triggered, value 1
  ./btrfs(+0x570c9)[0x562ec894f0c9]
  ./btrfs(+0x57167)[0x562ec894f167]
  ./btrfs(__commit_transaction+0x13b)[0x562ec894f7f2]
  ./btrfs(btrfs_commit_transaction+0x214)[0x562ec894fa64]
  ./btrfs(btrfs_clear_free_space_tree+0x177)[0x562ec8941ae6]
  ./btrfs(+0xc8958)[0x562ec89c0958]
  ./btrfs(+0xc9d53)[0x562ec89c1d53]
  ./btrfs(+0x17ec7)[0x562ec890fec7]
  ./btrfs(main+0x12f)[0x562ec8910908]
  /usr/lib/libc.so.6(+0x232d0)[0x7ff917ee82d0]
  /usr/lib/libc.so.6(__libc_start_main+0x8a)[0x7ff917ee838a]
  ./btrfs(_start+0x25)[0x562ec890fdc5]
  Aborted (core dumped)

[CAUSE]
The call trace has shown it's a BUG_ON(), and it's from
__commit_transaction(), which is writing tree blocks back.

[FIX]
The fix is pretty simple, just return error.

In fact we even have an error value check in btrfs_commit_transaction()
just after __commit_transaction() call (although not catching the return
value from it).

And since we're here, also call btrfs_abort_transaction() to prevent
newer transactions from being started.

Now we won't have a full crash:

  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: 5945915b-37f1-4bfa-9f64-684b318b8f73
  Clear free space cache v2
  Error writing to device 1
  ERROR: failed to write bytenr 30425088 length 16384: Operation not permitted
  ERROR: failed to write tree block 30425088: Operation not permitted
  ERROR: failed to clear free space cache v2: -1
  extent buffer leak: start 30720000 len 16384

Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent_io.c   |  2 +-
 kernel-shared/transaction.c | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index f10acc3595c3..3875b8f61242 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -1011,7 +1011,7 @@ int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 				if (ret < 0) {
 					fprintf(stderr, "Error writing to "
 						"device %d\n", errno);
-					ret = errno;
+					ret = -errno;
 					kfree(multi);
 					return ret;
 				} else {
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 8d74016e21d2..28b1684828ee 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -153,13 +153,41 @@ again:
 			eb = find_first_extent_buffer(tree, start);
 			BUG_ON(!eb || eb->start != start);
 			ret = write_tree_block(trans, fs_info, eb);
-			BUG_ON(ret);
+			if (ret < 0) {
+				free_extent_buffer(eb);
+				errno = -ret;
+				error("failed to write tree block %llu: %m",
+				      eb->start);
+				goto cleanup;
+			}
 			start += eb->len;
 			clear_extent_buffer_dirty(eb);
 			free_extent_buffer(eb);
 		}
 	}
 	return 0;
+cleanup:
+	/*
+	 * Mark all remaining dirty ebs clean, as they have no chance to be written
+	 * back anymore.
+	 */
+	while (1) {
+		int find_ret;
+
+		find_ret = find_first_extent_bit(tree, 0, &start, &end, EXTENT_DIRTY);
+
+		if (find_ret)
+			break;
+
+		while (start <= end) {
+			eb = find_first_extent_buffer(tree, start);
+			BUG_ON(!eb || eb->start != start);
+			start += eb->len;
+			clear_extent_buffer_dirty(eb);
+			free_extent_buffer(eb);
+		}
+	}
+	return ret;
 }
 
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
@@ -219,7 +247,7 @@ commit_tree:
 		if (ret < 0)
 			goto error;
 	}
-	__commit_transaction(trans, root);
+	ret = __commit_transaction(trans, root);
 	if (ret < 0)
 		goto error;
 
@@ -244,6 +272,7 @@ commit_tree:
 	}
 	return ret;
 error:
+	btrfs_abort_transaction(trans, ret);
 	btrfs_destroy_delayed_refs(trans);
 	free(trans);
 	return ret;
-- 
2.37.3

