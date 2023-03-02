Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE606A8BB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCBWZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCBWZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548323655
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B730C2237D;
        Thu,  2 Mar 2023 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak0oXyxbl0BtbiBynO/E3Y3H5n/OpoHvrW9GTQENiMw=;
        b=eTuXq5Ns5vOl7NlMF4DhshS8BUityCSTV2khULXul3U3lYhWcnOLj45xDjNqCqmwPAdHTb
        YWqZ0SWC9HBBL6ogEgxJN5IRiACNMFBLg1OHEU+aD2sV7GICzTln8Msfi+ce982WvI294V
        JL+UYHY2QC2JaIA+ZaK7eLm1wSAKbY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak0oXyxbl0BtbiBynO/E3Y3H5n/OpoHvrW9GTQENiMw=;
        b=XIe7YlyRnQGv5O4+rIfEPp1+ihQb6OJRuKqYCOZ2Usyt8V6Ny88soN3jfAceVoZsSXxu38
        AVFBIyyk5O1NWlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EB4313349;
        Thu,  2 Mar 2023 22:25:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZAnbDUEiAWSLSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:05 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 02/21] btrfs: add WARN_ON() on incorrect lock range
Date:   Thu,  2 Mar 2023 16:24:47 -0600
Message-Id: <e12de38182a185ffc0540190a90d97124232103f.1677793433.git.rgoldwyn@suse.com>
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

Add a WARN_ON(start > end) to make sure that the locking happens on the
correct range and no incorrect nodes (with state->start > state->end)
are added to the tree.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent-io-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 29a225836e28..482721dd1eba 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1710,6 +1710,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	int err;
 	u64 failed_start;
 
+	WARN_ON(start > end);
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
 			       NULL, cached, NULL, GFP_NOFS);
 	if (err == -EEXIST) {
@@ -1732,6 +1733,7 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	int err;
 	u64 failed_start;
 
+	WARN_ON(start > end);
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
 			       &failed_state, cached_state, NULL, GFP_NOFS);
 	while (err == -EEXIST) {
-- 
2.39.2

