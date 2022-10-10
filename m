Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360955F9CD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiJJKge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiJJKgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:36:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2AC578AB
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:36:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E6641F8D6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665398189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnH4O35HfRBUYOl3oj6MsOrKrHNE2HHxi5FhIg/Kh9U=;
        b=UuHwZEIhla/oY8el0xEH0+kDKR/AgJZrD+RTAimxa5KlvfNYsfyNK8+dvrK7Zl2JvW9/VI
        peNanOY5Q4z/rABOk4VCwpK7D7LbPNc4jrNqOj15RTlykKn8OTZ0RtvXkZ24KO4xIvtaXZ
        mnM2pmCQrO7WRGxH9GzAhL0uV/DskHQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D27E513ACA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Ci2Jaz1Q2M9LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: raid56: properly handle the error when unable to find the missing stripe
Date:   Mon, 10 Oct 2022 18:36:06 +0800
Message-Id: <895a5f5c5938e0cea436190b821f2bbec3222ec0.1665397731.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665397731.git.wqu@suse.com>
References: <cover.1665397731.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In raid56_alloc_missing_rbio(), if we can not determine where the
missing device is inside the full stripe, we just BUG_ON().

This is not necessary especially the only caller inside scrub.c is
already properly checking the return value, and will treat it as a
memory allocation failure.

Fix the error handling by:

- Add an extra warning for the reason
  Although personally speaking it may be better to be an ASSERT().

- Properly free the allocated rbio

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f6395e8288d6..892005f756cf 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2742,8 +2742,10 @@ raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila == -1) {
-		BUG();
-		kfree(rbio);
+		btrfs_warn_rl(fs_info,
+	"can not determine the failed stripe number for full stripe %llu",
+			      bioc->raid_map[0]);
+		__free_raid_bio(rbio);
 		return NULL;
 	}
 
-- 
2.37.3

