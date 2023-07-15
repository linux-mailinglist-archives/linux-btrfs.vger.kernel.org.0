Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28135754866
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGOLJF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGOLJE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:09:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E843A88
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:09:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96D8721FCA;
        Sat, 15 Jul 2023 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD2U+Nz3BJcBG+nIg3y3JFf5vYEzfVhGDd7JcclVseY=;
        b=LC3FEXVKMedq9/UUbGr/lOpZ4vp1uhKmPtPMmAV4iXzqlur9IxHy/fjio/ezOF1QolKSS1
        Np+8aR6er+uW3DUp/mDVbUkofh8bv2wc6W9Hou7oXsIewx4qNJB6K0MdZzi0UXRL3bXwMc
        l3g6a04p/Ncrk+BMTfI+CnbKGeCHQjI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83DEE133F7;
        Sat, 15 Jul 2023 11:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CPpsE0x+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 15 Jul 2023 11:09:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 6/8] btrfs: copy all pages at once at the end of btrfs_clone_extent_buffer()
Date:   Sat, 15 Jul 2023 19:08:32 +0800
Message-ID: <991ddca1a1c642d7db42f28d8ac423f7a02c1e54.1689418958.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689418958.git.wqu@suse.com>
References: <cover.1689418958.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_clone_extent_buffer() calls copy_page() at each iteration but we
can copy all pages at the end in one go if there were no errors.
This would make later conversion to folios easier.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 46f72e6623d6..d2a89b04c487 100644
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

