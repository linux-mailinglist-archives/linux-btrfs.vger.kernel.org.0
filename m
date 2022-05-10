Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E8520D7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiEJGHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEJGH1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 02:07:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE729ED26
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 23:03:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 366631F8BF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 06:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652162609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XcCtFOFgqqixqcw0ZYH6+UeMmlCXKhq+g0aoZqXsbRA=;
        b=cmr0kPrpd565o2TGPXJLvBBKvFHIxb9WHvOO142ZDwkpHjjpu84P+aY3d7jKGWn/JIJClV
        h1ROtSsfC5/UgZYPM+PkyZaGC8dSByUACwGDEgL/RYcbf0TA+jqhCWVLsLYR93NmLvzGzX
        6qqDJeKQcG4YosTXyEUMBpGGGpbestk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B062C13AC1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 06:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dHurHi8AemJnUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 06:03:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: print-tree: print the checksum of header without tailing zeros
Date:   Tue, 10 May 2022 14:03:18 +0800
Message-Id: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the default CRC32 checksum, print-tree now prints tons of
unnecessary padding zeros:

  btrfs-progs v5.17
  chunk tree
  leaf 22036480 items 7 free space 15430 generation 6 owner CHUNK_TREE
  leaf 22036480 flags 0x1(WRITTEN) backref revision 1
  checksum stored 0ac1b9fa00000000000000000000000000000000000000000000000000000000
  checksum calced 0ac1b9fa00000000000000000000000000000000000000000000000000000000
  fs uuid 3d95b7e3-3ab6-4927-af56-c58aa634342e

This is caused by commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
experimental, new option to switch csums"), and it looks like most
distros just enable EXPERIMENTAL features by default.
(Which is a good thing to provide much better coverage).

So here we just limit the csum print to the utilized csum size.

Now the output looks like:

  btrfs-progs v5.17
  chunk tree
  leaf 22036480 items 4 free space 15781 generation 6 owner CHUNK_TREE
  leaf 22036480 flags 0x1(WRITTEN) backref revision 1
  checksum stored 676b812f
  checksum calced 676b812f
  fs uuid d11f8799-b6dc-415d-b1ed-cebe6da5f0b7

Fixes: 1bb6fb896dfc ("btrfs-progs: btrfstune: experimental, new option to switch csums")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9c12dfcb4ca5..4f34645cf741 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1224,7 +1224,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	u8 backref_rev;
 	char csum_str[2 * BTRFS_CSUM_SIZE + strlen(" csum 0x") + 1];
 	int i;
-	int csum_size;
+	int csum_size = fs_info->csum_size;
 
 	flags = btrfs_header_flags(eb) & ~BTRFS_BACKREF_REV_MASK;
 	backref_rev = btrfs_header_flags(eb) >> BTRFS_BACKREF_REV_SHIFT;
@@ -1249,7 +1249,6 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 		char *tmp = csum_str;
 		u8 *csum = (u8 *)(eb->data + offsetof(struct btrfs_header, csum));
 
-		csum_size = fs_info->csum_size;
 		strcpy(csum_str, " csum 0x");
 		tmp = csum_str + strlen(csum_str);
 		for (i = 0; i < csum_size; i++) {
@@ -1268,7 +1267,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 
 #ifdef EXPERIMENTAL
 	printf("checksum stored ");
-	for (i = 0; i < BTRFS_CSUM_SIZE; i++)
+	for (i = 0; i < csum_size; i++)
 		printf("%02hhx", (int)(eb->data[i]));
 	printf("\n");
 	memset(csum, 0, sizeof(csum));
@@ -1276,7 +1275,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 			(u8 *)eb->data + BTRFS_CSUM_SIZE,
 			csum, fs_info->nodesize - BTRFS_CSUM_SIZE);
 	printf("checksum calced ");
-	for (i = 0; i < BTRFS_CSUM_SIZE; i++)
+	for (i = 0; i < csum_size; i++)
 		printf("%02hhx", (int)(csum[i]));
 	printf("\n");
 #endif
-- 
2.36.0

