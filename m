Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98B504AB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 03:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiDRB5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Apr 2022 21:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiDRB5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Apr 2022 21:57:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C7183A3
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 18:54:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC3DC1F37C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650246883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ok46jt32ZroRJy9Y7qM+jv7S2buA5vGvBaZHy0YE+Ek=;
        b=Krz5lobT7L+wraBRuGVsNReRslJuZ/HSndZ2/w1HzzQl1/g1b/80a9F1uJRCyDqRIwOevH
        c/4PRD8BHS6TBIOkB1o4xGXlr4B4gkRjMipHqwoKOgmihTlO4dXdhSzoXzXNkS5+L4Z+gv
        opooOMwYcSQwUYTTUeS6pd+LfABY704=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B78B13A9D
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 01:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hf9xMeLEXGLJIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 01:54:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix a wrong return value for write_and_map_eb()
Date:   Mon, 18 Apr 2022 09:54:24 +0800
Message-Id: <d3d68b4a612208acf1624238d11a3cf414f65ace.1650246860.git.wqu@suse.com>
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
With commit "btrfs-progs: use write_data_to_disk() to replace
write_extent_to_disk()", "mkfs.btrfs -m raid5" will always fail:

 kernel-shared/transaction.c:155: __commit_transaction: BUG_ON `ret` triggered, value 65536
 ./mkfs.btrfs(+0x57dd2)[0x557e610addd2]
 ./mkfs.btrfs(+0x57e70)[0x557e610ade70]
 ./mkfs.btrfs(__commit_transaction+0x139)[0x557e610ae4d4]
 ./mkfs.btrfs(btrfs_commit_transaction+0x214)[0x557e610ae746]
 ./mkfs.btrfs(main+0x19d9)[0x557e61066d34]
 /usr/lib/libc.so.6(+0x2d310)[0x7f2bf222d310]
 /usr/lib/libc.so.6(__libc_start_main+0x81)[0x7f2bf222d3c1]
 ./mkfs.btrfs(_start+0x25)[0x557e61062925]
 Aborted (core dumped)

[CAUSE]
Commit "btrfs-progs: use write_data_to_disk() to replace
write_extent_to_disk()" refactor write_and_map_eb() very slightly, but
it changed the return value on successful writeback for RAID56.

Previously we return 0, but now we return the stripe length, causing
btrfs_commit_transaction() to freak out.

[FIX]
Fix it by just reseting ret to 0 if nothing wrong happened for RAID56.

Please fold this fix into commit "btrfs-progs: use write_data_to_disk()
to replace write_extent_to_disk()".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4aae7a35768c..26b1c9aa192a 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -477,6 +477,8 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 			error(
 		"failed to write raid56 stripe for bytenr %llu length %llu: %m",
 				eb->start, length);
+		} else {
+			ret = 0;
 		}
 		goto out;
 	}
-- 
2.35.1

