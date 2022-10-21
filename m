Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610F9606C95
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 02:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJUAnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 20:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUAnv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 20:43:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61308230821
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 17:43:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DF7D33685;
        Fri, 21 Oct 2022 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666313028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Lfe1vlv6+3YnEyOpLWyrVDYT/IH9nKBxpdl0GTDDfEM=;
        b=P4CyPRfrm/C7qAcqp+xNP79s95ALWCwpP6yHyNNL/Kks7luGGmgM615fTMRpFmuTY+jbOx
        hqDgQy/zlI4ckUPAHhKxyYAIGO/mOSLtlufOOLG8zI+lTd63+uBrg+2vryeKWpPRmdxeS8
        tWr5Grn7Il88zsLi3dZYrgt6azc63UI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9090413494;
        Fri, 21 Oct 2022 00:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Y/UF0PrUWNGfgAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 21 Oct 2022 00:43:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
Subject: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
Date:   Fri, 21 Oct 2022 08:43:45 +0800
Message-Id: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are two reports (the earliest one from LKP, a more recent one from
kernel bugzilla) that we can have some chunks with 0 as sub_stripes.

This will cause divide-by-zero errors at btrfs_rmap_block, which is
introduced by a recent kernel patch ac0677348f3c ("btrfs: merge
calculations for simple striped profiles in btrfs_rmap_block"):

		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
				 BTRFS_BLOCK_GROUP_RAID10)) {
			stripe_nr = stripe_nr * map->num_stripes + i;
			stripe_nr = div_u64(stripe_nr, map->sub_stripes); <<<
		}

[CAUSE]
From the more recent report, it has been proven that we have some chunks
with 0 as sub_stripes, mostly caused by older mkfs.

It turns out that the mkfs.btrfs fix is only introduced in 6718ab4d33aa
("btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk")
which is included in v5.4 btrfs-progs release.

So there would be quite some old fses with such 0 sub_stripes.

[FIX]
Just don't trust the sub_stripes values from disk.

We have a trusted btrfs_raid_array[] to fetch the correct sub_stripes
numbers for each profile.

By this, we can keep the compatibility with older fses while still avoid
divide-by-zero bugs.

Fixes: ac0677348f3c ("btrfs: merge calculations for simple striped profiles in btrfs_rmap_block")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Viktor Kuzmin <kvaster@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216559
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 94ba46d57920..39588cb9a7b6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7142,6 +7142,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	u64 devid;
 	u64 type;
 	u8 uuid[BTRFS_UUID_SIZE];
+	int index;
 	int num_stripes;
 	int ret;
 	int i;
@@ -7149,6 +7150,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	logical = key->offset;
 	length = btrfs_chunk_length(leaf, chunk);
 	type = btrfs_chunk_type(leaf, chunk);
+	index = btrfs_bg_flags_to_raid_index(type);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 
 #if BITS_PER_LONG == 32
@@ -7202,7 +7204,14 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	map->io_align = btrfs_chunk_io_align(leaf, chunk);
 	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	map->type = type;
-	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
+	/*
+	 * Don't trust the sub_stripes value, as for profiles other
+	 * than RAID10, they may have 0 as sub_stripes for older mkfs.
+	 * In that case, it can cause divide-by-zero errors later.
+	 * Since currently sub_stripes is fixed for each profile, let's
+	 * use the trusted value instead.
+	 */
+	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
 	map->verified_stripes = 0;
 	em->orig_block_len = btrfs_calc_stripe_length(em);
 	for (i = 0; i < num_stripes; i++) {
-- 
2.38.0

