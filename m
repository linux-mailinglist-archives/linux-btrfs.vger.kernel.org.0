Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C94EEC55
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiDALZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbiDALZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281A16D8C9
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 230B31FD01
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nzNGzueB/2GMAQXopi1FCSlvx95ckIn8OTHS/i9KCA=;
        b=Lj6fr8MFTNlkeGYl70dUNDmmz3jmlyrjmtVfgH5Z2eYqJU/XBdS2yvjQeIqdhP70xDHkYP
        GPdVtR6yzmvfuGqJl+fn76FhH0yz+9fIdGVKogYkd32pkqvRE1R/LOD12QDj+QT5nupAxY
        aXtrvaZnHzt99101vQVz9OCtXcbCaNc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BDE1132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPDYEcbgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: make btrfs_raid_bio more compact
Date:   Fri,  1 Apr 2022 19:23:17 +0800
Message-Id: <9f54219b03f7218e20f8df1a7bd52755897730da.1648807440.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648807440.git.wqu@suse.com>
References: <cover.1648807440.git.wqu@suse.com>
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

There are a lot of members using much larger type in btrfs_raid_bio.

Like nr_pages which represents the total number of a full stripe.

Instead of int (which is at least 32bits), u16 is already enough
(max stripe length will be 256MiB, already beyond current raid56 device
number limit).

So this patch will reduce the width of the following members:

- stripe_len to u32
- nr_pages to u16
- nr_data to u8
- real_stripes to u8
- scrubp to u8
- faila/b to s8
  As -1 is used to indicate no corruption

This will slightly reduce the size of btrfs_raid_bio from 272 bytes to
256 bytes, reducing 16 bytes usage.

But please note that, when using btrfs_raid_bio, we allocate extra space
for it to cover various pointer array, so the reduce memory is not
really a big saving overall.

As we're here modifying the comments already, update existing comments
to current code standard.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ae585ed6a023..2553e1bb8bbf 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -101,15 +101,6 @@ struct btrfs_raid_bio {
 	 */
 	unsigned long flags;
 
-	/* size of each individual stripe on disk */
-	int stripe_len;
-
-	/* number of data stripes (no p/q) */
-	int nr_data;
-
-	int real_stripes;
-
-	int stripe_npages;
 	/*
 	 * set if we're doing a parity rebuild
 	 * for a read from higher up, which is handled
@@ -118,21 +109,32 @@ struct btrfs_raid_bio {
 	 */
 	enum btrfs_rbio_ops operation;
 
-	/* first bad stripe */
-	int faila;
+	/* Size of each individual stripe on disk */
+	u32 stripe_len;
 
-	/* second bad stripe (for raid6 use) */
-	int failb;
+	/* How many pages there are for the full stripe including P/Q */
+	u16 nr_pages;
 
-	int scrubp;
-	/*
-	 * number of pages needed to represent the full
-	 * stripe
-	 */
-	int nr_pages;
+	/* Number of data stripes (no p/q) */
+	u8 nr_data;
+
+	/* Numer of all stripes (including P/Q) */
+	u8 real_stripes;
+
+	/* How many pages there are for each stripe */
+	u8 stripe_npages;
+
+	/* First bad stripe, -1 means no corruption */
+	s8 faila;
+
+	/* Second bad stripe (for raid6 use) */
+	s8 failb;
+
+	/* Stripe number that we're scrubbing  */
+	u8 scrubp;
 
 	/*
-	 * size of all the bios in the bio_list.  This
+	 * Size of all the bios in the bio_list.  This
 	 * helps us decide if the rbio maps to a full
 	 * stripe or not
 	 */
-- 
2.35.1

