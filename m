Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55C45A5B02
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiH3FKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 01:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3FKv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 01:10:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF67435D
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 22:10:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 414D71F9AF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 05:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661836248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JMzQ8ruZ23n53jPME4TLbG4FFKLg3RY6BJ4wdNArb34=;
        b=JEDsvAGNKUuWy9KPprp2u9jKWvbNSShilP/xbFQUObeiwJhPmdBLhzSCfG5QaLwU8dce5b
        E22e+x6oa9ume6yIMn4wqv+UFSGd36f4tZrgtk7YL68dNoB0TInPkxHvDeCAkuWmoZm326
        /gpeV6tFMnsunvddXMq5ox4x9aZmF+k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92A3213ACF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 05:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bOBHF9ebDWNSCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 05:10:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DON'T MERGE] btrfs-progs: crash if eb has leaked for debug builds
Date:   Tue, 30 Aug 2022 13:10:29 +0800
Message-Id: <d1986a1743d1f0e56a680b6ab4ba92ba225c21db.1661836144.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
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

!!! DON'T MERGE !!!

Currently if we leaked some extent buffers, btrfs-progs can still work
fine, and will only output a not-that-obvious message like:

 extent buffer leak: start 30572544 len 16384

This is pretty hard to catch and test cases will not be able to catch
such regression.

This patch will add a new default debug cflags,
-DDEBUG_ABORT_ON_EB_LEAK, and in extent_io_tree_cleanup(), if that
debug flag is enabled, we will report all the leaked eb first, then
crash to make users and test cases to catch this problem.

Unfortunately the eb leakage is a big problem, fsck tests can only reach
002 before crashing at that test image.

If someone can help fixing all the eb leakage it would be great.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile                  | 2 +-
 kernel-shared/extent_io.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 2a37d1c6b5eb..beaa31d36f0e 100644
--- a/Makefile
+++ b/Makefile
@@ -65,7 +65,7 @@ include Makefile.extrawarn
 EXTRA_CFLAGS :=
 EXTRA_LDFLAGS :=
 
-DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3
+DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3 -DDEBUG_ABORT_ON_EB_LEAK
 DEBUG_CFLAGS_INTERNAL =
 DEBUG_CFLAGS :=
 
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 48bcf2cf2f96..6def70a3fca4 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -84,6 +84,7 @@ static void free_extent_buffer_final(struct extent_buffer *eb);
 void extent_io_tree_cleanup(struct extent_io_tree *tree)
 {
 	struct extent_buffer *eb;
+	bool leaked = false;
 
 	while(!list_empty(&tree->lru)) {
 		eb = list_entry(tree->lru.next, struct extent_buffer, lru);
@@ -92,11 +93,16 @@ void extent_io_tree_cleanup(struct extent_io_tree *tree)
 				"extent buffer leak: start %llu len %u\n",
 				(unsigned long long)eb->start, eb->len);
 			free_extent_buffer_nocache(eb);
+			leaked = true;
 		} else {
 			free_extent_buffer_final(eb);
 		}
 	}
-
+	if (leaked) {
+#ifdef DEBUG_ABORT_ON_EB_LEAK
+		abort();
+#endif
+	}
 	cache_tree_free_extents(&tree->state, free_extent_state_func);
 }
 
-- 
2.37.2

