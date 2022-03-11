Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E44D5C86
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347225AbiCKHkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345147AbiCKHkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:40:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613056418
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:39:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 486CD1F441
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646984348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPLEcMpZIxJaiA9S7hJv7oAN1bggj/gWDR2SGSPI+k4=;
        b=oqu7rP6Ml+5G9ve3JfjPoIXJErlcA8qdXzDiRdIHOQoV1HI7+t1bdDtJTKxLptrQmijbB1
        xgg0UsNCyhBDpSvqjGyBGxqZqW1NJ5x7DLkXtG4CKr84IZo/QS28cr67irAA0t5KAZ4TA0
        j2YNqTS+OaoOlSqFsGiMcn2Zi3jcW1Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E9D013A82
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eP5aGpv8KmKkJgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/9] btrfs: calculate @physical_end using @dev_extent_len directly in scrub_stripe()
Date:   Fri, 11 Mar 2022 15:38:41 +0800
Message-Id: <62725efd10680c9c92364021f985865294d3b009.1646984153.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646984153.git.wqu@suse.com>
References: <cover.1646984153.git.wqu@suse.com>
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

The variable @physical_end is the exclusive stripe end, currently it's
calculated using @physical + @dev_extent_len / map->stripe_len *
 map->stripe_len.

And since at allocation time we ensured dev_extent_len is stripe_len
aligned, the result is the same as @physical + @dev_extent_len.

So this patch will just assign @physical and @physical_end early,
without using @nstripes.

This is especially helpful for any possible out: label user, as now we
only need to initialize @offset before going to out: label.

Since we're here, also make @physical_end constant.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2316269cade0..c2bf7bbcee67 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3183,10 +3183,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	int slot;
 	u64 nstripes;
 	struct extent_buffer *l;
-	u64 physical;
+	u64 physical = map->stripes[stripe_index].physical;
 	u64 logical;
 	u64 logic_end;
-	u64 physical_end;
+	const u64 physical_end = physical + dev_extent_len;
 	u64 generation;
 	int mirror_num;
 	struct btrfs_key key;
@@ -3205,7 +3205,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	int extent_mirror_num;
 	int stop_loop = 0;
 
-	physical = map->stripes[stripe_index].physical;
 	offset = 0;
 	nstripes = div64_u64(dev_extent_len, map->stripe_len);
 	mirror_num = 1;
@@ -3242,7 +3241,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	path->reada = READA_FORWARD;
 
 	logical = chunk_logical + offset;
-	physical_end = physical + nstripes * map->stripe_len;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		get_raid56_logic_offset(physical_end, stripe_index,
 					map, &logic_end, NULL);
-- 
2.35.1

