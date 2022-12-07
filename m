Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E764534A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 06:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLGFKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 00:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLGFKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 00:10:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E245578F6
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 21:10:19 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D88F021C91
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 05:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670389817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xiEEiUmvtkrVt2Q1isQBMRdlm93QtwnTTzOjqw+2hJc=;
        b=Ycte81LehZtpuDzomHS9mthOwJ1hJqRM8En0+hFNd2ZqXAPJopO0fv9ZpNkPVB4vFz4aGH
        22yhyq4pTW8XGGUHNIIlnUBYwb23IHIubx2MYlhN7HpfLw73yujiYTe6nRXJJwjflFHsoC
        5RimFKw9Lgnbk8WON/OM6yAPp28irGY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3A00D132F3
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 05:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0BeZIjggkGNWAgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 05:10:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: handle missing chunk mapping more gracefully
Date:   Wed,  7 Dec 2022 13:09:59 +0800
Message-Id: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

[BUG]
During my scrub rework, I did a stupid thing like this:

        bio->bi_iter.bi_sector = stripe->logical;
        btrfs_submit_bio(fs_info, bio, stripe->mirror_num);

Above bi_sector assignment is using logical address directly, which
lacks ">> SECTOR_SHIFT".

This results a read on a range which has no chunk mapping.

This results the following crash:

 BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
 assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
 ------------[ cut here ]------------

Sure this is all my fault, but this shows a possible problem in real
world, that some bitflip in file extents/tree block can point to
unmapped ranges, and trigger above ASSERT().

[PROBLEMS]
In above call chain, there are 2 locations not properly handling the
errors:

- __btrfs_map_block()
  If btrfs_get_chunk_map() returned error, we just trigger an ASSERT().

- btrfs_submit_bio()
  If the returned mapped length is smaller than expected, we just BUG().

[FIX]
This patch will fix the problems by:

- Add extra WARN_ON() if btrfs_get_chunk_map() failed
  I know syzbot will complain, but it's better noisy for fstests.

- Replace the ASSERT()
  By returning the error.

- Handle the error when mapped length is smaller than expected length

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c     | 6 +++++-
 fs/btrfs/volumes.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index b8fb7ef6b520..8f7b56a0290f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -246,7 +246,11 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		btrfs_crit(fs_info,
 			   "mapping failed logical %llu bio len %llu len %llu",
 			   logical, length, map_length);
-		BUG();
+		WARN_ON(1);
+		ret = -EINVAL;
+		btrfs_bio_counter_dec(fs_info);
+		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
+		return;
 	}
 
 	if (!bioc) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index aa25fa335d3e..f69475fb1bc1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3012,6 +3012,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	if (!em) {
 		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
 			   logical, length);
+		WARN_ON(1);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3020,6 +3021,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
 			   logical, length, em->start, em->start + em->len);
 		free_extent_map(em);
+		WARN_ON(1);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -6384,7 +6386,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
-	ASSERT(!IS_ERR(em));
+	if (IS_ERR(em))
+		return PTR_ERR(em);
 
 	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
 	if (ret < 0)
-- 
2.38.1

