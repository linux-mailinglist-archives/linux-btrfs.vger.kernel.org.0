Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22F6A8BC6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjCBWZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCBWZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F257303CE
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0CB42006B;
        Thu,  2 Mar 2023 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T12swTc5dwKhsvLTQeh51cvZRrZ1mkPwvm42hkHB+Q=;
        b=JwD8UQfZWuu6uEPfEI3QnO0v0Rs3d87JDvAdSldu0srlt5nNUch4OSaeOK9uyoI9YNiN91
        U+vwf/fFptk7Cw/h03Dx6RAX75f8OLzB4fWO3Cu3ASyY5aU5LzDWmAmhMZxqUpRjut6ltW
        UOypV5WHwtmSQYt1K8SzWubd2P4N9QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T12swTc5dwKhsvLTQeh51cvZRrZ1mkPwvm42hkHB+Q=;
        b=uswocf1aULctJ9BXKF8DTA9LGycjXiB06vOZnLAI2nD6xCSYWYFuGZBHuPNrvq+hy98JMW
        Rse0V5+22DHTCcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96AC713349;
        Thu,  2 Mar 2023 22:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id epIVHW8iAWT2SQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:51 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 20/21] btrfs: Add inode->i_count instead of calling ihold()
Date:   Thu,  2 Mar 2023 16:25:05 -0600
Message-Id: <c201e92c0a69df45a8f1c4651028ccfb30aebdd2.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

I am not sure of this patch, but put it to avoid the WARN_ON() in
ihold().  I am not sure why the i_count would drop below one at this
point of time since this is still called within writepages context.

Perhaps, there is a better way to solve this?
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4e5eb5d9ee4..b5f5c1896dbb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1535,7 +1535,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		 * igrab is called higher up in the call chain, take only the
 		 * lightweight reference for the callback lifetime
 		 */
-		ihold(&inode->vfs_inode);
+		atomic_inc(&inode->vfs_inode.i_count);
 		async_chunk[i].async_cow = ctx;
 		async_chunk[i].inode = inode;
 		async_chunk[i].start = start;
-- 
2.39.2

