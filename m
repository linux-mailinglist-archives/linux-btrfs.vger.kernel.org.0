Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A772729AF7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbjFINEm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbjFINEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 09:04:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5342D74
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 06:04:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CFD1A1FDF8
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686315878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Ixre44R2int8Gj0sLd4BBmGnT9zemVkWyzGFyWJZUqc=;
        b=BEUqfjsswDBBslgVfuVvHVuCfnxklQ7790bQvO6veCV/oFNTgC9KvKj64HkNKWtlapzUND
        fKUtfJzyXT6prjCALki7wrdB/Jk9bxi7LmQ+xOo1XObuma+/x+1AGABUPtRPA0hvLiVCEf
        3M7Edl3wizLvK1LOsq1Ofj70E5csN1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686315878;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Ixre44R2int8Gj0sLd4BBmGnT9zemVkWyzGFyWJZUqc=;
        b=VMfCTn40NCbyAfkND3vBqe5LBpLokXSnKj9Yd3RX7FiKr8r+27NqCMPT8Smx/MYiu/Vyxx
        DyEbeZkEvbt4JbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7940913A47
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qAUsFWYjg2QATgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 13:04:38 +0000
Date:   Fri, 9 Jun 2023 08:05:14 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not clear EXTENT_LOCKED in
 try_release_extent_state()
Message-ID: <r3pglf6fh5hqqfd6iwt5eklmalm4idnumjxo5v23buu7zfjdfm@ixnvwldw5yjg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

clear_bits unsets EXTENT_LOCKED in the else branch of checking
EXTENT_LOCKED. At this point, it is not possible that EXTENT_LOCKED bits
are set, so do not clear EXTENT_LOCKED.

Besides, The comment above try_release_extent_state():__clear_extent_bit()
also says that locked bit should not be cleared.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a91d5ad27984..e5bec73b5991 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2357,7 +2357,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
 		ret = 0;
 	} else {
-		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
+		u32 clear_bits = ~(EXTENT_NODATASUM |
 				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
 
 		/*
-- 
2.40.1
