Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6968C7D20E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJVDki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 23:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVDkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 23:40:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB2E1
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 20:40:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C3F821906
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697946029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r88uHwIFStcO4Dc0+DbEwzxQ+mHs2XQFVfU7ItwCBrU=;
        b=aEg74XfKQ/YcF5iiF0JVRrc6TsHLQ7uAy/BM+gNqIpHjYXcVeVGKSTWZjQjVpLGgQ2XJum
        gFQxNoRpe/YGuSh42Z86DXrEmksycAft9cHtiAIU3zYriVIemaWNdXId6NUfrW2uIInBR/
        De9uvhtdC9maernASfC0K1L9an++J7E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8948E1348C
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Fl4EayZNGVHZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: dump-tree: output the sequence number for inline references
Date:   Sun, 22 Oct 2023 14:10:07 +1030
Message-ID: <fa881bcd58d137e9096150c0a875f2dcee38ae30.1697945679.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697945679.git.wqu@suse.com>
References: <cover.1697945679.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 6cf11f3e3815 ("btrfs-progs: check: check order of inline extent
refs") fixes a problem that btrfs check never properly verify the
sequence of inline references.

It's not obvious because by default kernel handles EXTENT_DATA_REF_KEY
using its own hash, resulting some seemingly out-of-order result:

	item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16143 itemsize 140
		refs 4 gen 7 flags DATA
		extent data backref root FS_TREE objectid 258 offset 0 count 1
		extent data backref root FS_TREE objectid 257 offset 0 count 1
		extent data backref root FS_TREE objectid 260 offset 0 count 1
		extent data backref root FS_TREE objectid 259 offset 0 count 1

By a quick glance, no one can see the above inline backref items are in
any order.

To make such sequence more obvious, let dump-tree to output a new prefix
to indicate the type and the internal sequence number:

For above case, the new output would look like this:

        item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16143 itemsize 140
                refs 4 gen 7 flags DATA
                (178 0xdfb591fbbf5f519) extent data backref root FS_TREE objectid 258 offset 0 count 1
                (178 0xdfb591fa80d95ea) extent data backref root FS_TREE objectid 257 offset 0 count 1
                (178 0xdfb591f9c0534ff) extent data backref root FS_TREE objectid 260 offset 0 count 1
                (178 0xdfb591f49f9f8e7) extent data backref root FS_TREE objectid 259 offset 0 count 1

Although still not that obvious, it should show the inline data backrefs
has descending sequence number.

For the type part, it's anti-instinctive in ascending order, which is
not that easy to produce.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index f6e7539eb191..9e3ebddb97b3 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -487,38 +487,45 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
 	ptr = (unsigned long)iref;
 	end = (unsigned long)ei + item_size;
 	while (ptr < end) {
+		u64 seq;
+
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_extent_inline_ref_type(eb, iref);
 		offset = btrfs_extent_inline_ref_offset(eb, iref);
+		seq = offset;
 		switch (type) {
 		case BTRFS_TREE_BLOCK_REF_KEY:
-			printf("\t\ttree block backref root ");
+			printf("\t\t(%u 0x%llx) tree block backref root ",
+			       type, seq);
 			print_objectid(stdout, offset, 0);
 			printf("\n");
 			break;
 		case BTRFS_SHARED_BLOCK_REF_KEY:
-			printf("\t\tshared block backref parent %llu\n",
-			       (unsigned long long)offset);
+			printf("\t\t(%u 0x%llx) shared block backref parent %llu\n",
+			       type, seq, offset);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
-			printf("\t\textent data backref root ");
-			print_objectid(stdout,
-		(unsigned long long)btrfs_extent_data_ref_root(eb, dref), 0);
+			seq = hash_extent_data_ref(
+					btrfs_extent_data_ref_root(eb, dref),
+					btrfs_extent_data_ref_objectid(eb, dref),
+					btrfs_extent_data_ref_offset(eb, dref));
+			printf("\t\t(%u 0x%llx) extent data backref root ",
+			       type, seq);
+			print_objectid(stdout, btrfs_extent_data_ref_root(eb, dref), 0);
 			printf(" objectid %llu offset %llu count %u\n",
-			       (unsigned long long)btrfs_extent_data_ref_objectid(eb, dref),
+			       btrfs_extent_data_ref_objectid(eb, dref),
 			       btrfs_extent_data_ref_offset(eb, dref),
 			       btrfs_extent_data_ref_count(eb, dref));
 			break;
 		case BTRFS_SHARED_DATA_REF_KEY:
 			sref = (struct btrfs_shared_data_ref *)(iref + 1);
-			printf("\t\tshared data backref parent %llu count %u\n",
-			       (unsigned long long)offset,
-			       btrfs_shared_data_ref_count(eb, sref));
+			printf("\t\t(%u 0x%llx) shared data backref parent %llu count %u\n",
+			       type, seq, offset, btrfs_shared_data_ref_count(eb, sref));
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
-			printf("\t\textent owner root %llu\n",
-			       (unsigned long long)offset);
+			printf("\t\(%u 0x%llx) textent owner root %llu\n",
+			       type, seq, offset);
 			break;
 		default:
 			return;
-- 
2.42.0

