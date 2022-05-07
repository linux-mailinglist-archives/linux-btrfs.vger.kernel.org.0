Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88151E4A8
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 May 2022 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383463AbiEGGne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 May 2022 02:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbiEGGne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 May 2022 02:43:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520AF40E6B
        for <linux-btrfs@vger.kernel.org>; Fri,  6 May 2022 23:39:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D03831F94C
        for <linux-btrfs@vger.kernel.org>; Sat,  7 May 2022 06:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651905586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W43vrPYISdUcEuiNcOVXj0yyBmApzs+K0r8hI+/lY48=;
        b=qyS16p6Qmj/gcTVroKnqXfLu2afV8WOKprsL1xiDDe6O4N1DZJQmLfQRA8mhM9H5dfhdiK
        cGoalq0OHL6VEX0YXTZ3L1SJh+ERnXRIH9OxNbdL/NYakQVIdCQl5dfIxw66h21jh1N0ZF
        KMOMhhX1kTDVkDzu6W2wvnvytq7IiXY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 255F6139E0
        for <linux-btrfs@vger.kernel.org>; Sat,  7 May 2022 06:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lA8vNzEUdmKqPAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 07 May 2022 06:39:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: allow defrag to convert inline extents to regular extents
Date:   Sat,  7 May 2022 14:39:27 +0800
Message-Id: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
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

Btrfs defaults to max_inline=2K to make small writes inlined into
metadata.

The default value is always a win, as even DUP/RAID1/RAID10 doubles the
metadata usage, it should still cause less physical space used compared
to a 4K regular extents.

But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
users may find inlined extents causing too much space wasted, and want
to convert those inlined extents back to regular extents.

Unfortunately defrag will unconditionally skip all inline extents, no
matter if the user is trying to converting them back to regular extents.

So this patch will add a small exception for defrag_collect_targets() to
allow defragging inline extents, if and only if the inlined extents are
larger than max_inline, allowing users to convert them to regular ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9d8e46815ee4..852c49565ab2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (!em)
 			break;
 
-		/* Skip hole/inline/preallocated extents */
-		if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
+		/*
+		 * If the file extent is an inlined one, we may still want to
+		 * defrag it (fallthrough) if it will cause a regular extent.
+		 * This is for users who want to convert inline extents to
+		 * regular ones through max_inline= mount option.
+		 */
+		if (em->block_start == EXTENT_MAP_INLINE &&
+		    em->len <= inode->root->fs_info->max_inline)
+			goto next;
+
+		/* Skip hole/delalloc/preallocated extents */
+		if (em->block_start == EXTENT_MAP_HOLE ||
+		    em->block_start == EXTENT_MAP_DELALLOC ||
 		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			goto next;
 
@@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->len >= get_extent_max_capacity(em))
 			goto next;
 
+		/*
+		 * For inline extent it should be the first extent and it
+		 * should not have a next extent.
+		 * If the inlined extent passed all above checks, just add it
+		 * for defrag, and be converted to regular extents.
+		 */
+		if (em->block_start == EXTENT_MAP_INLINE)
+			goto add;
+
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
 						extent_thresh, newer_than, locked);
 		if (!next_mergeable) {
-- 
2.36.0

