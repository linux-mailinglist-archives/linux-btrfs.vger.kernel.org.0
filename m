Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8473D6A7937
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 02:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCBByi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 20:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCBByh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 20:54:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA01739BA8
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 17:54:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77F6421AF9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677722070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AoZCYLlyoOTWCrSHv8t0nBusu+MLxVwjXnCP2IyunC4=;
        b=X6q5uSXxEnHzNA0AQ/PLhOa+alfGsi2dHhR8gjQjfpgKf8mC55wRj27C+t1Tl+aR/GyJ/T
        Q8svKzXK5qnsIsTaR6Rg9IFY6XRIbQO3J//dh6lwK755SE3T470R4fnQW0C/N5Jei+Iucg
        MpCWia1UUZwPUdCZXJvcUiPZZNJvgkU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCC1313A63
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HoeuJdUBAGTBegAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 01:54:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
Date:   Thu,  2 Mar 2023 09:54:12 +0800
Message-Id: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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
unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
is not configured, cause invalid pointer.

[PROBLEMS]
In above call chain, we just don't handle the possible error from
btrfs_get_chunk_map() inside __btrfs_map_block().

[FIX]
The fix is pretty straightforward, just replace the ASSERT() with proper
error handling.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rebased to latest misc-next
  The error path in bio.c is already fixed, thus only need to replace
  the ASSERT() in __btrfs_map_block().
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4d479ac233a4..93bc45001e68 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		return -EINVAL;
 
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
-	ASSERT(!IS_ERR(em));
+	if (IS_ERR(em))
+		return PTR_ERR(em);
 
 	map = em->map_lookup;
 	data_stripes = nr_data_stripes(map);
-- 
2.39.1

