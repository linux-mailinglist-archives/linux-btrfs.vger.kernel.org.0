Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BC4F4152
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiDEPEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392001AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2DA18C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 630D921100
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/erOKNbu3wA8ah/W/txPQuAt1I2rYmcFXZJoTAfSis=;
        b=scf/dJH5kWfYPedavoZLQ/O2DYqBzpynvJYQwvuTNmFwtSeR/3t5KvtD8KHxrfX9EY9CSm
        RtfngGP2LyBAOzpCj8yvCNyYse3x5BIS+XK34sE7FluxOb4w6OASlGtV8Q3TBSpNyWpiep
        STmfNKEhC1PmanhD+/0tfpi1CHkkLbU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4E2613A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wPdQH7M6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs-progs: don't use write_extent_to_disk() directly
Date:   Tue,  5 Apr 2022 20:48:25 +0800
Message-Id: <16371f2a75f00119ffdf19bdc38ca923d75010ce.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
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

There are two call sites using write_extent_to_disk() directly:

- debug_corrupt_block() in btrfs-corrupt-block.c
- corrupt_keys() in btrfs-corrupt-block.c

The problem of write_extent_to_disk() is, it can only handle plain
profiles (All profiles except P/Q stripes of RAID56).

Calling it directly can corrupted RAID56 P/Q, and in the future we're
going to remove eb::fd/eb::dev_bytes, so remove such call sites with
write_and_map_eb().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 8162c0dfd554..8ec6d63f060c 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -76,7 +76,7 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 			printf("corrupting %llu copy %d\n", eb->start,
 			       mirror_num);
 			memset(eb->data, 0, eb->len);
-			ret = write_extent_to_disk(eb);
+			ret = write_and_map_eb(eb->fs_info, eb);
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot write eb bytenr %llu: %m",
@@ -159,7 +159,7 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
 		u16 csum_type = fs_info->csum_type;
 
 		csum_tree_block_size(eb, csum_size, 0, csum_type);
-		write_extent_to_disk(eb);
+		write_and_map_eb(eb->fs_info, eb);
 	}
 }
 
-- 
2.35.1

