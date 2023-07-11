Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A020874E85D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 09:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKHuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGKHuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 03:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D363DB
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 00:50:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEC662052F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689061807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QM2qn4Fv6hPMSWUyP0MIu83OLYXypFabSSYsQdaS0lI=;
        b=amEcjR/DxCFUjTt17bGJAB8LZs2QmWsKS0Ltv2laSP/lJ7dt2sREQNCanmZ3+35HRKtU8r
        dBVlduM7S0Yr44xtxrAUjchGQvAhtE33Q3X0pD+I7zqW1PTVH/bg7ytOhBC+rA036KzEWu
        MGTPuBqFmgZ0S4CZ19zJe9RYYSnEktg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5481A1391C
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eN2HCa8JrWS6LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: call copy_extent_buffer_full() inside btrfs_clone_extent_buffer()
Date:   Tue, 11 Jul 2023 15:49:44 +0800
Message-ID: <50e8ebd3470bbd05f4987d37f661e0f3a570715c.1689061099.git.wqu@suse.com>
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

Function btrfs_clone_extent_buffer() is calling of copy_page() directly.

To make later migration for folio easier, just call
copy_extent_buffer_full() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9425380c110e..555cf17c13f9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3285,8 +3285,8 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 			return NULL;
 		}
 		WARN_ON(PageDirty(p));
-		copy_page(page_address(p), page_address(src->pages[i]));
 	}
+	copy_extent_buffer_full(new, src);
 	set_extent_buffer_uptodate(new);
 
 	return new;
-- 
2.41.0

