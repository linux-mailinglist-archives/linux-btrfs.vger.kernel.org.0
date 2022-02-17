Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED54B9C77
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiBQJuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 04:50:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiBQJuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 04:50:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9B17AAF
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 01:49:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 058A41F37D;
        Thu, 17 Feb 2022 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645091393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ceVlN5m+F9/sKWN2jBr6FVgbDQYWirPQwGHle1zmEVc=;
        b=MRVZf9esNK4Ex3Zdm9hGvf4d5zObE3Z1QOt4Bn3Kcng1zlahbt9qMr2TN42hkHgtWVb87A
        ZqaWwQTyO3X34phXeRda76wuk4hq1ljLEZN/rGSfijWvhdYgcruzK9VzEPOuRDZCIxE1bw
        PeWozHj9YnuaH0wGBOQs9V5sc+3dFdY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16EA213BBF;
        Thu, 17 Feb 2022 09:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NwuPMz8aDmI8LQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 17 Feb 2022 09:49:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <l@damenly.su>
Subject: [PATCH v2] btrfs: remove an ASSERT() which can cause false alert
Date:   Thu, 17 Feb 2022 17:49:34 +0800
Message-Id: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Su reported that with his VM running on an M1 mac, it has a high chance
to trigger the following ASSERT() with scrub and balance test cases:

		ASSERT(cache->start == chunk_offset);
		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
				  dev_extent_len);

[CAUSE]
The ASSERT() is making sure that the block group cache (@cache) and the
chunk offset from the device extent match.

But the truth is, block group caches and dev extent items are deleted at
different timing.

For block group caches and items, after btrfs_remove_block_group() they
will be marked deleted, but the device extent and the chunk item is
still in dev tree and chunk tree respectively.

The device extents and chunk items are only deleted in
btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
or btrfs_relocate_chunk().

This timing difference leaves a window where we can have a mismatch
between block group cache and device extent tree, and triggering the
ASSERT().

[FIX]

- Remove the ASSERT()

- Add a quick exit if our found bg doesn't match @chunk_offset

- Add a comment on the existing checks in scrub_chunk()
  This is the ultimate safenet, as it will iterate through all the stripes
  of the found chunk.
  And only scrub the stripe if it matches both device and physical
  offset.

  So even by some how we got a dev extent which is no longer owned
  by the target chunk, we will just skip this chunk completely, without
  any consequence.

Reported-by: Su Yue <l@damenly.su>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add a new quick exit with extra comments

- Add a new comment in the existing safenet in scrub_chunk()
---
 fs/btrfs/scrub.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 11089568b287..1c3ed4720ddd 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3578,6 +3578,14 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 		goto out;
 
 	map = em->map_lookup;
+
+	/*
+	 * Due to the delayed modification of device tree, this chunk
+	 * may not own this dev extent.
+	 *
+	 * So we need to iterate through all stripes, and only scrub
+	 * the stripe which matches both device and physical offset.
+	 */
 	for (i = 0; i < map->num_stripes; ++i) {
 		if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
 		    map->stripes[i].physical == dev_offset) {
@@ -3699,6 +3707,18 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+		/*
+		 * Since dev extents modification is delayed, it's possible
+		 * we got a bg which doesn't really own this dev extent.
+		 *
+		 * Here just do a quick skip, scrub_chunk() has a more
+		 * comprehensive check in it.
+		 */
+		if (cache->start != chunk_offset) {
+			btrfs_put_block_group(cache);
+			goto skip;
+		}
+
 		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
 			spin_lock(&cache->lock);
 			if (!cache->to_copy) {
@@ -3822,7 +3842,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		dev_replace->item_needs_writeback = 1;
 		up_write(&dev_replace->rwsem);
 
-		ASSERT(cache->start == chunk_offset);
 		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
 				  dev_extent_len);
 
-- 
2.35.1

