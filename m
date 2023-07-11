Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1308374E85B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 09:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGKHuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGKHuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 03:50:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B11122
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 00:50:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B9D120532
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689061805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SevsxJYqaLPDXJc8tx6x6Qme+1/H69PpvaIQLnZmqqU=;
        b=hBe49Ox7qbiXERPJA8S02pWq/DQd503qUHnMsmMbPkgThXHLjrmqf/imdrPdaVcIrFjy4J
        XPbbWAoMpcz6WGmqqYBFm2VbmO5rCJMyBQs7f2r0C0lhKFCZlgy4Ny7PXB0v18SfTBuUoh
        oTUKnOea7/cdGX7+1Jo+VvkgRggMj+U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8167E1391C
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iCxpFKwJrWS6LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: use write_extent_buffer() to implement write_extent_buffer_*id()
Date:   Tue, 11 Jul 2023 15:49:41 +0800
Message-ID: <e86267202871b02aad2359dc42aab05e96102aaa.1689061099.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689061099.git.wqu@suse.com>
References: <cover.1689061099.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For helpers write_extent_buffer_chunk_tree_uuid() and
write_extent_buffer_fsid(), they can be implemented by
write_extent_buffer().

And those two helpers are not that hot, they only get called during
initialization of a new tree block.

There is not much need for those slightly optimized versions.

This would make later page/folio switch much easier, as all change only
need to happen in write_extent_buffer().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6a7abcbe6bec..fef5a7b6c60a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4178,23 +4178,16 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *srcv)
 {
-	char *kaddr;
-
-	assert_eb_page_uptodate(eb, eb->pages[0]);
-	kaddr = page_address(eb->pages[0]) +
-		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
-						   chunk_tree_uuid));
-	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
+	write_extent_buffer(eb, srcv,
+			    offsetof(struct btrfs_header, chunk_tree_uuid),
+			    BTRFS_FSID_SIZE);
 }
 
 void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 {
-	char *kaddr;
 
-	assert_eb_page_uptodate(eb, eb->pages[0]);
-	kaddr = page_address(eb->pages[0]) +
-		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
-	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
+	write_extent_buffer(eb, srcv, offsetof(struct btrfs_header, fsid),
+			    BTRFS_FSID_SIZE);
 }
 
 void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
-- 
2.41.0

