Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1673527725
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiEOKz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiEOKzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:55:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43D15812
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:55:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 046EA1F8A3
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQgtn9hQTMD4r/ARNGeHxS0PQDFkLcXLbYllnc4xkF8=;
        b=Lk5BztcahwguMUuQjFEb6Y3LX8BlPgrf3a2+r+O3YgPT9d8+dfBBpu8TKFn33LUWJs+Ivi
        rajxq6cB3ChUxNsFzoZ4Umr1iFkfsTwXWrfv1QtMOAT58QbiTIQeMFoJqX6axaRgUAybAj
        AFQoUFTSJJNknIaiieqD/dpM4FSucTk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58E5F13491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMfZCBvcgGLsfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: print-tree: add support for per_dev_reserved of chunk item
Date:   Sun, 15 May 2022 18:54:59 +0800
Message-Id: <6da8b1594021c5e6bd26b78f768c9050715e85b5.1652611958.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652611957.git.wqu@suse.com>
References: <cover.1652611957.git.wqu@suse.com>
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

Just change the prompt string for "io_align" to "per_dev_reserved" based
on the chunk type.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9c12dfcb4ca5..d9f896ced827 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -223,6 +223,7 @@ void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 	int i;
 	u32 chunk_item_size;
 	char chunk_flags_str[BG_FLAG_STRING_LEN] = {};
+	bool is_journal;
 
 	/* The chunk must contain at least one stripe */
 	if (num_stripes < 1) {
@@ -237,13 +238,15 @@ void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 		return;
 	}
 
+	is_journal = btrfs_bg_type_is_journal(btrfs_chunk_type(eb, chunk));
 	bg_flags_to_str(btrfs_chunk_type(eb, chunk), chunk_flags_str);
 	printf("\t\tlength %llu owner %llu stripe_len %llu type %s\n",
 	       (unsigned long long)btrfs_chunk_length(eb, chunk),
 	       (unsigned long long)btrfs_chunk_owner(eb, chunk),
 	       (unsigned long long)btrfs_chunk_stripe_len(eb, chunk),
 		chunk_flags_str);
-	printf("\t\tio_align %u io_width %u sector_size %u\n",
+	printf("\t\t%s %u io_width %u sector_size %u\n",
+			is_journal ? "per_dev_reserved" : "io_align",
 			btrfs_chunk_io_align(eb, chunk),
 			btrfs_chunk_io_width(eb, chunk),
 			btrfs_chunk_sector_size(eb, chunk));
-- 
2.36.1

