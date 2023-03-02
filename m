Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE86A8BB3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCBWZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCBWZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943CEB53
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6333320069;
        Thu,  2 Mar 2023 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9KCkO8DkEDWq1KpZOwRNO4XEUlld9HpJInd1mWjYeQ=;
        b=HcFS2R0H9CQUvwY+b1HrGANDIgBFJfSiSovWbeGj8TCt9BnXkRSY6AZQb6yDnI2iYX32wf
        pfWX2pTSa9NxF8mW+lfTP8DgaB4VqsAE7H71dz0DFcvwO2Ki5TdJrAGZuNXb0Dod9WJyuy
        MwqGsr92OYoJY1fmusHrjZ1ZC2fCCfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9KCkO8DkEDWq1KpZOwRNO4XEUlld9HpJInd1mWjYeQ=;
        b=i/+qFQmqqs9Xp5cFQDRm9mcB5Q4RT7KrR8/QyD31nF2sv5MDjJf39aeztupNvN18OO9UkP
        qoOakrOsrOJD0lDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CBB413349;
        Thu,  2 Mar 2023 22:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iogcNkMiAWSPSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:07 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 03/21] btrfs: Add start < end check in btrfs_debug_check_extent_io_range()
Date:   Thu,  2 Mar 2023 16:24:48 -0600
Message-Id: <37fd374e88730196100116cc237f637cd6a8962a.1677793433.git.rgoldwyn@suse.com>
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

For issues such as zero size writes, we can get start > end. Check them
in btrfs_debug_check_extent_io_range() so this may be caught early.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent-io-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 482721dd1eba..d467c614c84e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -65,7 +65,8 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 		return;
 
 	isize = i_size_read(&inode->vfs_inode);
-	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
+	if ((start > end) ||
+	    (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1)) {
 		btrfs_debug_rl(inode->root->fs_info,
 		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
 			caller, btrfs_ino(inode), isize, start, end);
-- 
2.39.2

