Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D966BF6D9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Mar 2023 01:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCRATE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 20:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRATD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 20:19:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9461A974
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 17:19:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 917D721AAF
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 00:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679098740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5uPUCET9PFrOFAKlcfmF4vIsGfDhO0I7LAgLr542CWQ=;
        b=GNJiJI8gNU1OQCaJKWWTSavFniZTbP3JOFjwuKXDBo4GCcAJGH6TFr9H0Nr8Bh9v+uKB3b
        l+cmmwwh1l56iZgIzH4+dlBRRS+gjIJt/SsDXDF4ZpaTrCuPOQcDe7RHe1ClFyzvhZ4MCo
        xBqHZ/bk6ODdddFv43qr7rr0oeawabM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8BC1134F7
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 00:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FfpkLHMDFWTKEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 00:18:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: use alloc_dummy_extent_buffer() for temporaray super block
Date:   Sat, 18 Mar 2023 08:18:42 +0800
Message-Id: <80b02fbfe6796c85322244f2e3110295787df3a6.1679098721.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[FALSE ALERT]
There is a false alert when compiling btrfs-progs using gcc 12.2.1:

 $ make D=1
 kernel-shared/print-tree.c: In function 'print_sys_chunk_array':
 kernel-shared/print-tree.c:1797:9: warning: 'buf' may be used uninitialized [-Wmaybe-uninitialized]
  1797 |         write_extent_buffer(buf, sb, 0, sizeof(*sb));
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from ./kernel-shared/ctree.h:27,
                  from kernel-shared/print-tree.c:24:
 ./kernel-shared/extent_io.h:148:6: note: by argument 1 of type 'const struct extent_buffer *' to 'write_extent_buffer' declared here
   148 | void write_extent_buffer(const struct extent_buffer *eb, const void *src,
       |      ^~~~~~~~~~~~~~~~~~~

[CAUSE]
This is a false alert, the uninitialized part of buf will not be
utilized at all during write_extent_buffer().

[FIX]
Instead of allocating such adhoc buf, go a more formal way by calling
alloc_dummy_extent_buffer(), which would properly setting all the
members.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a57e9a4d7593..3fb6a37c118b 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1789,7 +1789,7 @@ static void print_sys_chunk_array(struct btrfs_super_block *sb)
 	struct btrfs_key key;
 	int item;
 
-	buf = malloc(sizeof(*buf) + sizeof(*sb));
+	buf = alloc_dummy_extent_buffer(NULL, 0, BTRFS_SUPER_INFO_SIZE);
 	if (!buf) {
 		error_msg(ERROR_MSG_MEMORY, NULL);
 		return;
@@ -1860,13 +1860,13 @@ static void print_sys_chunk_array(struct btrfs_super_block *sb)
 	}
 
 out:
-	free(buf);
+	free_extent_buffer(buf);
 	return;
 
 out_short_read:
 	error("sys_array too short to read %u bytes at offset %u",
 			len, cur_offset);
-	free(buf);
+	free_extent_buffer(buf);
 }
 
 static int empty_backup(struct btrfs_root_backup *backup)
-- 
2.39.2

