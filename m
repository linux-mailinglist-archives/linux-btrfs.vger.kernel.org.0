Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D34D000D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 14:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiCGNbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 08:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCGNa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 08:30:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794C7CDE2
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 05:30:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F22C4210F6;
        Mon,  7 Mar 2022 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646659804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g4n78rAJOC2v+mBFicF+4/PDv1Ica+GAr4PR3YuBVbk=;
        b=BCUn+BvdE0kULigN2cKRQUwCjvlhzhZt92iYFUdfYwsYkezbuUoGxavTvuyGDUyjHqqJ1I
        sxiOp4RENMeNEMkZUuxl7xtFcMkBOhJqziTa1/YiaqdM3Kd6e9SQhu4JixT0haM37OnObb
        zjRz5czc6NhkGBWVFnh2qFEyLDwDtEI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B316613AF0;
        Mon,  7 Mar 2022 13:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sXdDKNsIJmL3CwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 07 Mar 2022 13:30:03 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: zoned: Put block group after final usage
Date:   Mon,  7 Mar 2022 15:30:02 +0200
Message-Id: <20220307133002.28765-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
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

It's counter-intuitive (and wrong) to put the block group _before_ the
final usage in submit_eb_page. Fix it by re-ordering the call to
btrfs_put_block_group after its final reference. Also fix a minor typo
in 'implies'


Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3f13ff0affdb..ebda09c207f1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4786,11 +4786,14 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return ret;
 	}
 	if (cache) {
-		/* Impiles write in zoned mode */
-		btrfs_put_block_group(cache);
-		/* Mark the last eb in a block group */
+		/*
+		 * Implies write in zoned mode.
+		 *
+		 * Mark the last eb in a block group
+		 */
 		if (cache->seq_zone && eb->start + eb->len == cache->zone_capacity)
 			set_bit(EXTENT_BUFFER_ZONE_FINISH, &eb->bflags);
+		btrfs_put_block_group(cache);
 	}
 	ret = write_one_eb(eb, wbc, epd);
 	free_extent_buffer(eb);
--
2.25.1

