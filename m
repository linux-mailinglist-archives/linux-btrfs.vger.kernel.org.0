Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798CF78BF07
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 09:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjH2HO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjH2HO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 03:14:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD039CCD
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 00:14:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8722B1F750
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 07:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693293283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TOUry4usSI9UeMg8lE+iPA/yR4sbypiTeEiF7L7cTC0=;
        b=Og2yJ63TreDmJ9JWatEMdd54NjdwJ47NQ2BzBdgmz6RFi3H1brkkAs6PQp+QexISOnRzPk
        7kDKZBtl7/ZZIAffSx69gzTibdfZKBXDlU3RcQEJhAiXNGHMJicz1huglVs60ch2CFMQPe
        t2ErvHN5TSM+l2TthxCANJge8kWTq+A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6DF0138E2
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 07:14:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gdOaLOKa7WQNFQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 07:14:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not require EXTENT_NOWAIT for btrfs_redirty_list_add()
Date:   Tue, 29 Aug 2023 15:14:25 +0800
Message-ID: <bd9358f329b4574724250f1c0ba1ef2939f1feaa.1693293259.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The flag EXTENT_NOWAIT is a special flag to notify extent-io-tree code
that this operation should not sleep for the extent state preallocation.

However for btrfs_redirty_list_add(), all callers are able to sleep:

- clean_log_buffer()
  Just 2 lines before, we call btrfs_pin_reserved_extent(), which calls
  pin_down_extent(), and that function does not require EXTENT_NOWAIT.
  Thus we're safe to call it without EXTENT_NOWAIT.

- btrfs_free_tree_block()
  This function have several call sites which trigger tree read, e.g.
  walk_up_proc(), thus we're safe to call it without EXTENT_NOWAIT.

Thus there is no need to require EXTENT_NOWAIT flag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 21aad9704026..d42a672539a5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1609,7 +1609,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
-			EXTENT_DIRTY | EXTENT_NOWAIT, NULL);
+			EXTENT_DIRTY, NULL);
 }
 
 bool btrfs_use_zone_append(struct btrfs_bio *bbio)
-- 
2.41.0

