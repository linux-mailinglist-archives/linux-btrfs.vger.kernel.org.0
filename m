Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCB78678A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbjHXGeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjHXGdp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 02:33:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FAFD
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 23:33:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7312822C04
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692858822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIfzvI1ED9+julezqMNKRgfKO5V22zcBvbaFJ+pWKx4=;
        b=X5Z8ZhgR5aYfRhShgwYvN5qrjogZfOJsGakAI4F6Qg6n9zT3LN8aPcQbOefPAWiDaKskw5
        vi7Hf+4O1xIcKJYSTiA3oZzwmv/yJz1AU2wZ8qrBXo5CtvzrLShOST4b0JCTpphZyzSoyC
        ByXfb4R/aX8VyiaS4u2mtouD809i64Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C80D3138FB
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJBPJMX55mQqDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: warn on tree blocks which are not nodesize aligned
Date:   Thu, 24 Aug 2023 14:33:36 +0800
Message-ID: <09481f8720302e0c4aaee7e460c142f632c72fe8.1692858397.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692858397.git.wqu@suse.com>
References: <cover.1692858397.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index ac3fca5a5e41..f13211975e0b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3462,6 +3462,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
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
index a523d64d5491..4dc16d74437c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -139,6 +139,13 @@ enum {
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

