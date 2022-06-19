Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD978550B04
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiFSNtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFSNsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 09:48:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD276413
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 06:48:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F67221DD6
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655646496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kWskIbGdFP/42ojgQCYb/g1fuQDESM3GED0rWXvHl4s=;
        b=OWrn6C7f68ekFMw7khNrsCmxfyhLdg9IjNxxrWAC2qlG5OvZUKC1HoaR00qxmW32UkJfS3
        N/jDBJHY+RarrlyVl07GekN0J+fO4abK/BGleaqInuJ2bKC2GMBB8OD4careFyZhHtJlPa
        tvZobQRMyDxElLNhwOj5zdHZchLb4RA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED6EB13427
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 13:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pAFALh8pr2JcTQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 13:48:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: output mirror number for bad metadata
Date:   Sun, 19 Jun 2022 21:47:56 +0800
Message-Id: <ae3c7264a3aefe55c64e3c6a0426289800023742.1655646447.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

When handling a real world transid mismatch image, it's hard to know
which copy is corrupted, as the error messages just look like this:

BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted 0xcdcdcdcd found 0x3c0adc8e level 0

We don't even know if the retry is caused by btrfs or the VFS retry.

To make things a little easier to read, this patch will add mirror
number for all related tree block read errors.

So the above messages would look like this:

 BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
 BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
 BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
 BTRFS warning (device dm-3): checksum verify failed on 30408704 mirror 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68e..506d48b5fd7e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -220,8 +220,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 		goto out;
 	}
 	btrfs_err_rl(eb->fs_info,
-		"parent transid verify failed on %llu wanted %llu found %llu",
-			eb->start,
+	"parent transid verify failed on %llu mirror %u wanted %llu found %llu",
+			eb->start, eb->read_mirror,
 			parent_transid, btrfs_header_generation(eb));
 	ret = 1;
 	clear_extent_buffer_uptodate(eb);
@@ -551,21 +551,22 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 
 	found_start = btrfs_header_bytenr(eb);
 	if (found_start != eb->start) {
-		btrfs_err_rl(fs_info, "bad tree block start, want %llu have %llu",
-			     eb->start, found_start);
+		btrfs_err_rl(fs_info,
+			"bad tree block start, mirror %u want %llu have %llu",
+			     eb->read_mirror, eb->start, found_start);
 		ret = -EIO;
 		goto out;
 	}
 	if (check_tree_block_fsid(eb)) {
-		btrfs_err_rl(fs_info, "bad fsid on block %llu",
-			     eb->start);
+		btrfs_err_rl(fs_info, "bad fsid on block %llu mirror %u",
+			     eb->start, eb->read_mirror);
 		ret = -EIO;
 		goto out;
 	}
 	found_level = btrfs_header_level(eb);
 	if (found_level >= BTRFS_MAX_LEVEL) {
-		btrfs_err(fs_info, "bad tree block level %d on %llu",
-			  (int)btrfs_header_level(eb), eb->start);
+		btrfs_err(fs_info, "bad tree block mirror %u level %d on %llu",
+			  eb->read_mirror, btrfs_header_level(eb), eb->start);
 		ret = -EIO;
 		goto out;
 	}
@@ -576,8 +577,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
 		btrfs_warn_rl(fs_info,
-	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
-			      eb->start,
+	"checksum verify failed on %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
+			      eb->start, eb->read_mirror,
 			      CSUM_FMT_VALUE(csum_size, header_csum),
 			      CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb));
@@ -602,8 +603,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 		set_extent_buffer_uptodate(eb);
 	else
 		btrfs_err(fs_info,
-			  "block=%llu read time tree block corruption detected",
-			  eb->start);
+		"block=%llu mirror %u read time tree block corruption detected",
+			  eb->start, eb->read_mirror);
 out:
 	return ret;
 }
-- 
2.36.1

