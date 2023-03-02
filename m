Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250AA6A8BC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCBWZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCBWZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A528865
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 732E42237B;
        Thu,  2 Mar 2023 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5ZbVhdR6Id5JadXe5L6hsSKzXfhgcUDStfY2TU6GPI=;
        b=NbrD8Iicua/sGTGAOxKzcmiLFE7/5tJsKVanWbSFQ9qXF26c8Suda/4Cvmt/nYza0icPK3
        SHbGg+QkGhrJMzBb8g7ZIBfkMhTwxtEZ/CXewY9koV4mw+UppIUlfO6IBXVXjDxO2Ntw36
        BaEgShJhe+OSVYBPcbMfZyzr1BSELdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5ZbVhdR6Id5JadXe5L6hsSKzXfhgcUDStfY2TU6GPI=;
        b=XMRQJzFIbxPQTneiG/VAojRr2cr33madlzBbsv8tx7JAW6vXuMMUXnaWYz1LjDB1F3RupM
        OdgPn43LqqttkUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CD9313349;
        Thu,  2 Mar 2023 22:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id US4SA2oiAWTuSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:46 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 18/21] btrfs: check if writeback pages exist before starting writeback
Date:   Thu,  2 Mar 2023 16:25:03 -0600
Message-Id: <3499da06f72955091f63c15bfe454f77b72e4300.1677793433.git.rgoldwyn@suse.com>
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

Check if there are still pages to writeback after locking. This avoids
calls to check for extents.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 70cf852a3efd..c4e5eb5d9ee4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7773,6 +7773,11 @@ static int btrfs_writepages_async(struct btrfs_inode *inode, struct writeback_co
 
 	lock_extent(&inode->io_tree, start, end, NULL);
 
+	if (!filemap_range_has_writeback(inode->vfs_inode.i_mapping, start, end)) {
+		unlock_extent(&inode->io_tree, start, end, NULL);
+		return 0;
+	}
+
 	while (cur_start < end) {
 		bool found;
 		last_start = cur_start;
-- 
2.39.2

