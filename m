Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98062A0FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiKOSBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiKOSBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076B11C2A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 350ED1F8E0;
        Tue, 15 Nov 2022 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/+4uL317yjTCA01hYB5sabZtn+knk1BAX2rFaUsm0I=;
        b=sVZCLc+LHog25/d78xJy9SCKBiUu48dO4MGrFTrwn3/od+8guLdNK0n3bt9k6bbUJbW8RE
        24MiBHeZn8w1NaOOG2Nzs4gAmGMIdJVPYtYMBQIK2mGANBfcEK4F0c9Q7c+0wTOFKHLu/s
        E/g3cVDFh8DiJESCuED30cq01RV9GEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/+4uL317yjTCA01hYB5sabZtn+knk1BAX2rFaUsm0I=;
        b=tkJNCkjAwnpteAoEtBo06+RZU0nRPWT0k+IaL8F6US4ZTwMqlavkKJD/qV/90mFn7mQP5r
        S4c66PZS0Ch3dsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1D1413A91;
        Tue, 15 Nov 2022 18:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xosSL8fTc2OEZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:39 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 01/16] btrfs: check for range correctness while locking or setting extent bits
Date:   Tue, 15 Nov 2022 12:00:19 -0600
Message-Id: <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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

Since we will be working at the mercy of userspace, check if the range
is valid and proceed to lock or set bits only if start < end.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent-io-tree.c | 6 ++++++
 fs/btrfs/ordered-data.c   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 21fa15123af8..80657c820df4 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -557,6 +557,9 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	int wake;
 	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
 
+	if (unlikely(start > end))
+		return 0;
+
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
 
@@ -979,6 +982,9 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 last_end;
 	u32 exclusive_bits = (bits & EXTENT_LOCKED);
 
+	if (unlikely(start > end))
+		return 0;
+
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4bed0839b640..0a5512ed9a21 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1043,6 +1043,9 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 	struct extent_state *cache = NULL;
 	struct extent_state **cachedp = &cache;
 
+	if (unlikely(start > end))
+		return;
+
 	if (cached_state)
 		cachedp = cached_state;
 
-- 
2.35.3

