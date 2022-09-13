Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913A5B688C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiIMHUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiIMHTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 03:19:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557D62D4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 00:19:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00FC73488F
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663053587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45BQtxSMBmROObkjmy6A7IRq2kY7wwXgBQs3hj/0syU=;
        b=bQXjj9aza3cWx9rzM+yBvrV4reFloDjtUtS8HNTfbD+SFubT/RaacpO2so7TQyosIcfOlD
        gEHpC3eN1x68TyOM0ZtUa9xmzMFuVAudSJvKVYptARd7jmnUNAt5BKscUIV2o/hysruHpU
        Z1fpZMGnEeXYKhGvtAcINgY6npX+JvU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57D1213AB5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cCQwCRIvIGMOfAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: corrupt-block: re-generate the checksum for generation corruption
Date:   Tue, 13 Sep 2022 15:19:26 +0800
Message-Id: <426aaa1e6b83b99fddd66bc892499aca03105748.1663053391.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663053391.git.wqu@suse.com>
References: <cover.1663053391.git.wqu@suse.com>
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
If using btrfs-corrupt-block to corrupt the generation of a tree
block (in my example, it's csum root), it will cause csum mismatch other
than the expected transid mismatch:

 # ./btrfs-corrupt-block --metadata-block 30474240 -f generation \
   /dev/test/scratch1
 # btrfs check /dev/test/scratch1
 Opening filesystem to check...
 checksum verify failed on 30474240 wanted 0xb3e8059a found 0xb4a4b45c
 checksum verify failed on 30474240 wanted 0xb3e8059a found 0xb4a4b45c
 checksum verify failed on 30474240 wanted 0xb3e8059a found 0xb4a4b45c
 Csum didn't match
 ERROR: could not setup csum tree
 ERROR: cannot open file system

[CAUSE]
Inside the switch branch BTRFS_METADATA_BLOCK_GENERATION in
corrupt_metadata_block(), we just set the generation and trigger
write_and_map_eb().

However write_and_map_eb() doesn't re-generate the checksum by itself,
thus we make the victim tree block to have a stale checksum.

[FIX]
Just call csum_tree_block_size() before write_and_map_eb().

Now the corrupted fs have the expected corruption pattern now:

 # btrfs check /dev/test/scratch1
 Opening filesystem to check...
 parent transid verify failed on 30474240 wanted 7 found 11814770867473404344
 parent transid verify failed on 30474240 wanted 7 found 11814770867473404344
 parent transid verify failed on 30474240 wanted 7 found 11814770867473404344
 Ignoring transid failure
 ...

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 4fa27b98fe16..b6aefe658ead 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -885,6 +885,8 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 		u64 bogus = generate_u64(orig);
 
 		btrfs_set_header_generation(eb, bogus);
+		csum_tree_block_size(eb, fs_info->csum_size, 0,
+				     fs_info->csum_type);
 		ret = write_and_map_eb(fs_info, eb);
 		free_extent_buffer(eb);
 		if (ret < 0) {
-- 
2.37.3

