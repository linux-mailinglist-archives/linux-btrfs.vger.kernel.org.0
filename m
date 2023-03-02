Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11B6A8BB1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCBWZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBWZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92415143
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36C3C2237D;
        Thu,  2 Mar 2023 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETP35mJFvVJqwXhOnp/+xm6v2JfOoXdo2Smb1xvPSpI=;
        b=fWfHP2Dr7WTR/SHUQxdtNebztHfYSW+UZF4U7GvW7ID5RWbGzjhsrVA7WKlHkhOhSwRvsu
        oJYXl1jPnj7Nu51p/Gx17pD5XgSiMLKRleqf/whtYucgEjii/+uznvnlwThIQ0ebX9Pkw5
        pG5H83EAMz8y/6GbQSDf3Nruo4VZT7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETP35mJFvVJqwXhOnp/+xm6v2JfOoXdo2Smb1xvPSpI=;
        b=zJ13RZJhr9DQ/jUxhcEXcSQIfCYLC/LoZWrF1xgZEIhXTwAr7gDPTslDNQy3HcFSpjoDMd
        G1rp6BYW3S1EgEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFBAD13349;
        Thu,  2 Mar 2023 22:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TnAiLz4iAWSFSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:02 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 01/21] fs: readahead_begin() to call before locking folio
Date:   Thu,  2 Mar 2023 16:24:46 -0600
Message-Id: <4b8c7d11d7440523dba12205a88b7d43f61a07b1.1677793433.git.rgoldwyn@suse.com>
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

The btrfs filesystem needs to lock the extents before locking folios
to be read from disk. So, introduce a function in
address_space_operaitons, called btrfs_readahead_begin() which is called
before the folio are allocateed and locked.
---
 include/linux/fs.h | 1 +
 mm/readahead.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..6b650db57ca3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -363,6 +363,7 @@ struct address_space_operations {
 	/* Mark a folio dirty.  Return true if this dirtied it */
 	bool (*dirty_folio)(struct address_space *, struct folio *);
 
+	void (*readahead_begin)(struct readahead_control *);
 	void (*readahead)(struct readahead_control *);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
diff --git a/mm/readahead.c b/mm/readahead.c
index b10f0cf81d80..6924d5fed350 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -520,6 +520,9 @@ void page_cache_ra_order(struct readahead_control *ractl,
 			new_order--;
 	}
 
+	if (mapping->a_ops->readahead_begin)
+		mapping->a_ops->readahead_begin(ractl);
+
 	filemap_invalidate_lock_shared(mapping);
 	while (index <= limit) {
 		unsigned int order = new_order;
-- 
2.39.2

