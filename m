Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BD715308
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjE3Bpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 21:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE3Bpu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 21:45:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD220D9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 18:45:49 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CEA621A80
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685411148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VogHfS6Hpg5PeV9xmuf3aWOXV4y/phRmvYgzwvKizi8=;
        b=LbF7w4101XgwhcggAXu/LwUC7fxK8xqKb/0Lfo3itw6Sl5OR1vRUxmA9nJhTeKNFyioG+K
        EfQiwilBBFniM+UQhdB2KjsKKoNYfcLZpwg3lySMA0rjPMSQXewLk2ASksPQhsBJbvJJzZ
        ha6H0Hbo/8BiXBupcPg+9xGTmPWbGgo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E9E5F132F3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id wD2SLktVdWSIJwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:45:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: make alloc_extent_buffer() handle previously uptodate range more efficient for subpage
Date:   Tue, 30 May 2023 09:45:27 +0800
Message-Id: <dcacf1177cd31b969bb61910e49ed3397d796ee3.1685411033.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685411033.git.wqu@suse.com>
References: <cover.1685411033.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently alloc_extent_buffer() would make the extent buffer uptodate if
the corresponding pages are also uptodate.

But this check is only checking PageUptodate, which is fine for regular
cases, but not for subpage cases, as we can have multiple extent buffers
in the same page.

So here we go btrfs_page_test_uptodate() instead.

The old code doesn't cause any problem, but not efficient, as it would
cause extra metadata read even if the range is already uptodate.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbf212c7a43f..9afdcf0c70dd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3708,7 +3708,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
 		eb->pages[i] = p;
-		if (!PageUptodate(p))
+		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
 			uptodate = 0;
 
 		/*
-- 
2.40.1

