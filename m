Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2351FBFA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiEIMFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiEIMFI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 08:05:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07211A35BA
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 05:01:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6918921C54
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652097671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sOynVTbHRnO/N0Od3uJHtOCWAdsCFYdvxL1WmpBIkvo=;
        b=WflY7DT73f5yyXL+5GgXNWKa52ms9HnS1ssQljrtEgmVmFZpfK2eSttrpKFly2ibTGDiUX
        etAyMeGCn2bsOcR6t3yqHyeXIQxouREMCAsUi6cdD9bitgU7YWHbrycpQon822VDtN0ga5
        B6P6UU4Wi6Mz1dkLEUs2K77Mtzgq9C0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC8413AA5
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 12:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3hcmJ4YCeWJ3NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 12:01:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: allow defrag to convert inline extents to regular extents
Date:   Mon,  9 May 2022 20:00:53 +0800
Message-Id: <0606709d439b711a767ce1491f51f0113326d265.1652097509.git.wqu@suse.com>
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

This also allows us to defrag extents like the following:

	item 6 key (257 EXTENT_DATA 0) itemoff 15794 itemsize 69
		generation 7 type 0 (inline)
		inline extent data size 48 ram_bytes 4096 compression 1 (zlib)
	item 7 key (257 EXTENT_DATA 4096) itemoff 15741 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 16384 ram 16384
		extent compression 1 (zlib)

Previously we're unable to do any defrag, since the first extent is
inlined, and the second one has no extent to merge.

Now we can defrag it to just one single extent, saving 48 bytes metadata
space.

	item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 13635584 nr 4096
		extent data offset 0 nr 20480 ram 20480
		extent compression 1 (zlib)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Re-phase why we add the inline extent without checking @next_mergeable

- Add some commit message on the new ability to handle mixed inline and
  regular extents
---
 fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9d8e46815ee4..d5a8f5b7d3a9 100644
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
+		 * Normally there is no more extent after an inline one, thus
+		 * @next_mergeable will normally be false and not defragged.
+		 * So if an inline extent passed all above checks, just add it
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

