Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD64D4D955B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 08:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiCOHel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 03:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345480AbiCOHec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 03:34:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C15D1094
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 00:33:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7EF08210FC;
        Tue, 15 Mar 2022 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647329597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HzvQ9ntbXcjtgmlpiQDYhIkn0ovcZ5VwZ0VBGnXz7tc=;
        b=erJI6UskEyI6iogHLZ42JFgVWaq0QggW6mXB9FKST5WCuNDTe/5t5WgljOD/g3XjAcGmJS
        LXkcCJ5jZy/X12FEUsyxkbVBapkO+MWC8RjWCctnSZCBsHz/AbXStS8YZtGS4KNXmGBHBX
        xIn+jV7rBpKViUvuMZQrx34CViT42v8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FBA61333E;
        Tue, 15 Mar 2022 07:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iTkHGzxBMGLZTgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 15 Mar 2022 07:33:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>
Subject: [RFC PATCH] btrfs: don't trust sub_stripes from disk
Date:   Tue, 15 Mar 2022 15:32:59 +0800
Message-Id: <d5fb898de7b87629a08f51bf1ca50a2b8f48b95b.1647329345.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

[BUG]
LKP reported a divide error testing my scrub entrance tests:

 BTRFS info (device sdb2): dev_replace from /dev/sdb3 (devid 2) to /dev/sdb6 started
 divide error: 0000 [#1] SMP KASAN PTI
 CPU: 3 PID: 3293 Comm: btrfs Not tainted 5.17.0-rc5-00101-g3626a285f87d #1
 Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
 RIP: 0010:scrub_stripe (kbuild/src/consumer/fs/btrfs/scrub.c:3448 kbuild/src/consumer/fs/btrfs/scrub.c:3486 kbuild/src/consumer/fs/btrfs/scrub.c:3644) btrfs
 Code: 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 0c 11 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 27 09 00 00 41 8b 5d 1c 99 <f7> fb 48 8b 54 24 30 48 c1 ea 03 48 63 e8 48 b8 00 00 00 00 00 fc
   0:	00 00                	add    %al,(%rax)
   2:	fc                   	cld
   3:	ff                   	(bad)
   4:	df 48 89             	fisttps -0x77(%rax)
   7:	f9                   	stc
   8:	48 c1 e9 03          	shr    $0x3,%rcx
   c:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
  10:	48 89 fa             	mov    %rdi,%rdx
  13:	83 e2 07             	and    $0x7,%edx
  16:	83 c2 03             	add    $0x3,%edx
  19:	38 ca                	cmp    %cl,%dl
  1b:	7c 08                	jl     0x25
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 85 27 09 00 00    	jne    0x94c
  25:	41 8b 5d 1c          	mov    0x1c(%r13),%ebx
  29:	99                   	cltd
  2a:*	f7 fb                	idiv   %ebx		<-- trapping instruction
  2c:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
  31:	48 c1 ea 03          	shr    $0x3,%rdx
  35:	48 63 e8             	movslq %eax,%rbp
  38:	48                   	rex.W
  39:	b8 00 00 00 00       	mov    $0x0,%eax
  3e:	00 fc                	add    %bh,%ah

[CAUSE]
The offending function is simple_stripe_full_stripe_len(), which handles
both RAID0 and RAID10.

In that function we will divide by map->sub_stripes.

So this means map->sub_stripes is 0.

For RAID10 it's impossible as btrfs_check_chunk_valid() will ensure
RAID10 chunk has sub_stripes set to 2.

But it doesn't check RAID0 (nor any other profiles).

With more help from Oliver, it shows that under their environment,
SINGLE/DUP profiles also have 0 as their sub_stripes.

So it looks like a bug in btrfs-progs, but I can not reproduce nor pin down
the exact commit.

[FIX]
From btrfs_raid_array[], all profiles have either sub_stripes as 1 or 2
(only for RAID10).

Thus there is no need to trust the sub_stripe value from disk at all.

I'm not yet confident to put such sub_stripes check for all profiles, as
there is no concrete evidence to indicate it's a bug in mkfs.btrfs, nor
how many users are affected by it.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I don't have direct evidence to indicate it's a bug in mkfs.btrfs.

But both code review and extra debug patches show Oliver's environment
has chunk items with 0 as sub_stripes (for DUP at least).

However using the same progs version, I can not reproduce the same
behavior at all (still 1 sub_stripes for SINGLE/RAID0/DUP/...)

So this is just a preventive method.
---
 fs/btrfs/volumes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd17e87815a..8400b114fd62 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7081,6 +7081,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	u8 uuid[BTRFS_UUID_SIZE];
 	int num_stripes;
 	int ret;
+	int index;
 	int i;
 
 	logical = key->offset;
@@ -7104,6 +7105,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 		if (ret)
 			return ret;
 	}
+	index = btrfs_bg_flags_to_raid_index(type);
 
 	read_lock(&map_tree->lock);
 	em = lookup_extent_mapping(map_tree, logical, 1);
@@ -7139,7 +7141,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	map->io_align = btrfs_chunk_io_align(leaf, chunk);
 	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	map->type = type;
-	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
+	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
 	map->verified_stripes = 0;
 	em->orig_block_len = calc_stripe_length(type, em->len,
 						map->num_stripes);
-- 
2.35.1

