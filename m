Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDEC74562B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjGCHd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGCHdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D9E6B
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31D761FD6F
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fH/sY+7fwJTU1TkUgnFUNJhYmdzJqljiqkh828iLYmg=;
        b=qklfIGn1LwFMuq9Yi7Ahpu3dTtzJRUqiUUlBqXNFgrrgpfpJUOjSYZ7QgylSXIPW/u3fZI
        lTzdKDWAUUWxpXYCIBDYM2VsitKJp9SLaM9DxaqZQC2ZcW4NV6PvJvC3XH8vjohAe2l6D5
        ePUn6Eq7TrfmtQRJR17wv0cpvnn7tik=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 813F113276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sFvwErN5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/14] btrfs: scrub: implement the chunk iteration code for scrub_logical
Date:   Mon,  3 Jul 2023 15:32:33 +0800
Message-ID: <e0c8c12dfc8d4541ed8d06190a4ecd4841bd3e1c.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch implements the code to iterate chunks for scrub_logical
feature.

The differences between scrub_logical and scrub_dev are:

- No need to lookup dev-extent tree
  As scrub_logical can directly grab the block group and check against
  the logical range.
  Thus we don't need to do the dev-extent lookup.

- No dev-replace related work
  Scrub_logical would only be a feature to enhance full fs scrub, thus
  no need to do dev-replace related checks.

For now only the block group iteration code is implemented, the real
scrub part is not yet implemented.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 806c4683a7ef..79e47eee9d1b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2984,6 +2984,69 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+static int scrub_logical_chunks(struct scrub_ctx *sctx, u64 start, u64 end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u64 cur = start;
+	int ret = 0;
+
+	while (cur < end) {
+		struct btrfs_block_group *bg;
+		bool ro_set = false;
+
+		bg = btrfs_lookup_first_block_group(fs_info, cur);
+
+		/* No more block groups. */
+		if (!bg)
+			break;
+		if (bg->start > end)
+			break;
+
+		ret = prepare_scrub_block_group(sctx, bg, &ro_set);
+		if (ret == -ETXTBSY) {
+			ret = 0;
+			goto next;
+		}
+		if (ret > 0)
+			goto next;
+		if (ret < 0) {
+			btrfs_put_block_group(bg);
+			break;
+		}
+
+		/* The real work starts here. */
+		ret = -EOPNOTSUPP;
+
+		if (ro_set)
+			btrfs_dec_block_group_ro(bg);
+		/*
+		 * We might have prevented the cleaner kthread from deleting
+		 * this block group if it was already unused because we raced
+		 * and set it to RO mode first. So add it back to the unused
+		 * list, otherwise it might not ever be deleted unless a manual
+		 * balance is triggered or it becomes used and unused again.
+		 */
+		spin_lock(&bg->lock);
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags) &&
+		    !bg->ro && bg->reserved == 0 && bg->used == 0) {
+			spin_unlock(&bg->lock);
+			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+				btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
+			else
+				btrfs_mark_bg_unused(bg);
+		} else {
+			spin_unlock(&bg->lock);
+		}
+		btrfs_unfreeze_block_group(bg);
+next:
+		cur = bg->start + bg->length;
+		btrfs_put_block_group(bg);
+		if (ret < 0)
+			break;
+	}
+	return ret;
+}
+
 int btrfs_scrub_logical(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 			struct btrfs_scrub_progress *progress, bool readonly)
 {
@@ -3030,8 +3093,7 @@ int btrfs_scrub_logical(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 	atomic_inc(&fs_info->scrubs_logical_running);
 	mutex_unlock(&fs_info->scrub_lock);
 
-	/* The main work would be implemented. */
-	ret = -EOPNOTSUPP;
+	ret = scrub_logical_chunks(sctx, start, end);
 
 	atomic_dec(&fs_info->scrubs_running);
 	atomic_dec(&fs_info->scrubs_logical_running);
-- 
2.41.0

