Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7775EB3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 08:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGXGJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXGJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 02:09:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F0B18E
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 23:09:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D338B204F2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690178970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1wVRUlaDdGKGIV0uYsarXB5rXWpJXERhUR6ggPs8mhI=;
        b=ZwAI9WvICATumkT1DEBwN2IhtltE/VGUGZnDKVBzDy5yV3ErMHhjiZqVsdRekqf791Eyno
        08Vntph5KWue4gc3YFMUV2SQYQFHq6+ePOWEk4rvZevQYbUNVXVka16Mh6QmRDHTnKY9hg
        W1Fl6uTVtM3TmcQ77k0yM1Oyv3j4hlo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A288138E8
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vckAF5kVvmTAPAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:09:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: warn on tree blocks which are not nodesize aligned
Date:   Mon, 24 Jul 2023 14:09:09 +0800
Message-ID: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A long time ago, we have some metadata chunks which starts at sector
boundary but not aligned at nodesize boundary.

This led to some older fs which can have tree blocks only aligned to
sectorsize, but not nodesize.

Later btrfs check gained the ability to detect and warn about such tree
blocks, and kernel fixed the chunk allocation behavior, nowadays those
tree blocks should be pretty rare.

But in the future, if we want to migrate metadata to folio, we can not
have such tree blocks, as filemap_add_folio() requires the page index to
be aligned with the folio number of pages.
(AKA, such unaligned tree blocks can lead to VM_BUG_ON().)

So this patch adds extra warning for those unaligned tree blocks, as a
preparation for the future folio migration.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++++++
 fs/btrfs/fs.h        | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 65b01ec5bab1..0aa27a212d1e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3518,6 +3518,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 			  start, fs_info->nodesize);
 		return -EINVAL;
 	}
+	if (!IS_ALIGNED(start, fs_info->nodesize) &&
+	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK,
+			      &fs_info->flags)) {
+		btrfs_warn(fs_info,
+		"tree block not nodesize aligned, start %llu nodesize %u",
+			      start, fs_info->nodesize);
+		btrfs_warn(fs_info, "this can be solved by a full metadata balance");
+	}
 	return 0;
 }
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..2de3961aee44 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -141,6 +141,13 @@ enum {
 	 */
 	BTRFS_FS_FEATURE_CHANGED,
 
+	/*
+	 * Indicate if we have tree block which is only aligned to sectorsize,
+	 * but not to nodesize.
+	 * This should be rare nowadays.
+	 */
+	BTRFS_FS_UNALIGNED_TREE_BLOCK,
+
 #if BITS_PER_LONG == 32
 	/* Indicate if we have error/warn message printed on 32bit systems */
 	BTRFS_FS_32BIT_ERROR,
-- 
2.41.0

