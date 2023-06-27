Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7BE73F5D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjF0He6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjF0Hew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 03:34:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E29EC9
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 00:34:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05A5E1F8BF
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687851290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4ptmBqVkzHNStwUgZaMIFCf32Ijr2CYiA4y6weaH3O0=;
        b=YrEOIoxaYcr2C0lZiGuTmIcHJGgf3NMJ6XvR65qA+zsI8SKUNX8uvUtBV9CSBiUYWUfhex
        Rx3ymzlGvyD7JObHLZtJczjuaERIdaCmkgU7HYsX3NvrEs3PyOqutlsjgqc5C6+udGLgfe
        jrE1Kv+N8juhOhVaRVfqZP0B93AmImo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CEEC13462
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 07:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jeJrChmRmmQMHwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 07:34:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add comments for btrfs_map_block()
Date:   Tue, 27 Jun 2023 15:34:31 +0800
Message-ID: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_map_block() is a critical part of the btrfs storage
layer, which handles mapping of logical ranges to physical ranges.

Thus it's better to have some basic explanation, especially on the
following points:

- Segment split by various boundaries
  As a continuous logical range may be split into different segments,
  due to various factors like zones and RAID0/5/6/10 boundaries.

- The meaning of @mirror_num

- The possible single stripe optimization

- One deprecated parameter @need_raid_map
  Just explicitly mark it deprecated so we're aware of the problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
There would be a follow up patch, to add one new case for
@mirror_num, where for RAID56 we allow mirror_num > num_copies, as a way
to read P/Q stripes directly for the incoming scrub_logical.

Thus I believe it's better to explicit explain @mirror_num_ret at least.

Also if @need_raid_map can be finally removed, we can also remove the
corner case for special op == READ && !need_raid_map case where
mirror_num == 2 means P stripe.
---
 fs/btrfs/volumes.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ed15c89d4350..efac9293446d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6227,6 +6227,45 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 }
 
+/*
+ * Map one logical range to one or more physical ranges.
+ *
+ * @length:		(Mandatory) mapped length of this run.
+ *			One logical range can be split into different segments
+ *			due to factors like zones and RAID0/5/6/10 stripe
+ *			boundaries.
+ *
+ * @bioc_ret:		(Mandatory) returned btrfs_io_context structure.
+ *			which has one or more physical ranges (btrfs_io_stripe)
+ *			recorded inside.
+ *			Caller should call btrfs_put_bioc() to free it after use.
+ *
+ * @smap:		(Optional) single physical range optimization.
+ *			If the map request can be fulfilled by one single
+ *			physical range, and this is parameter is not NULL,
+ *			then @bioc_ret would be NULL, and @smap would be
+ *			updated.
+ *
+ * @mirror_num_ret:	(Mandatory) returned mirror number if the original
+ *			value is 0.
+ *
+ *			Mirror number 0 means to choose any live mirrors.
+ *
+ *			For non-RAID56 profiles, non-zero mirror_num means
+ *			the Nth mirror. (e.g. mirror_num 1 means the first
+ *			copy).
+ *
+ *			For RAID56 profile, mirror 1 means rebuild from P and
+ *			the remaingin data stripes.
+ *
+ *			For RAID6 profile, mirror > 2 means mark another
+ *			data/P stripe error and rebuild from the remaining
+ *			stripes..
+ *
+ * @need_raid_map:	(Deprecated) whether the map wants a full stripe map
+ *			(including all data and P/Q stripes) for RAID56.
+ *			Should always be 1 except for legacy call sites.
+ */
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    u64 logical, u64 *length,
 		    struct btrfs_io_context **bioc_ret,
-- 
2.41.0

