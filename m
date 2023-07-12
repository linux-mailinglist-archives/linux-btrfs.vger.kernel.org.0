Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEB74FF7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGLGjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGLGjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C62E2686
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:38:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56EF01FEEC
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689143890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BpxMBde94tbXawgv1adS9qAejUs3nuB9qDgjN5hLLb8=;
        b=eJCqS0LZYzHzJcgVRKV/CTW0ruMPD6tg7N1lqhnYr3s0jxwNL1M4ueTcDMPmRQIQrw4PmJ
        50jNPkF18LVeadLDDvEU8FTQjkx385kGUtoXx3axRVHYawIiS4RX6zmNMDwFwKRRqQq6Zr
        JuxxJvq3tQtGT2FUvcUDhLMyP275chM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD331133DD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0FeMHlFKrmRhDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/6] btrfs: call copy_extent_buffer_full() inside btrfs_clone_extent_buffer()
Date:   Wed, 12 Jul 2023 14:37:46 +0800
Message-ID: <1fcafac62544b937e537f7cfe576b4beb3d8bc0a.1689143655.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689143654.git.wqu@suse.com>
References: <cover.1689143654.git.wqu@suse.com>
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
index c84e64181acb..7f0a532de645 100644
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

