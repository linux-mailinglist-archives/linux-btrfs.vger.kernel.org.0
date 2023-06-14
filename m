Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55A72FAC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbjFNK0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 06:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbjFNK0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 06:26:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84826AD
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 03:24:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9E351FDE4
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686738240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jqjQ62mHmaYqmjsdsm7nYTCnaXvIYKYKd6d1PxkeSjA=;
        b=P9PjMoFSixbTDdMi6r819Fo2nEyMT6hTE8ggj7lSYnVhnKxdyWOMvV8jmd6IHg9N1HJexE
        0toBZIMzMlOAMU4j61nOnpAi6XS9ZrsJb9C6jtjUNnLH3wadHLll85Ru6BEa1enz9VeCUI
        zeUikMv3bPKYFu5LBDkENgIo6riOjuk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E79D1391E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 10:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iKojDECViWQ4dwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 10:24:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix accessors for big endian systems
Date:   Wed, 14 Jun 2023 18:23:43 +0800
Message-ID: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report from the github issues, that on s390x big endian
systems, mkfs.btrfs just fails:

 $ mkfs.btrfs  -f ~/test.img
 btrfs-progs v6.3.1
 Invalid mapping for 1081344-1097728, got 17592186044416-17592190238720
 Couldn't map the block 1081344
 ERROR: cannot read chunk root
 ERROR: open ctree failed

[CAUSE]
The error is caused by wrong endian conversion.

The system where Fedora guys reported errors are using big endian:

 $ lscpu
 Byte Order:            Big Endian

While checking the offending @disk_key and @key inside
btrfs_read_sys_array(), we got:

 2301		while (cur_offset < array_size) {
 (gdb)
 2304			if (cur_offset + len > array_size)
 (gdb)
 2307			btrfs_disk_key_to_cpu(&key, disk_key);
 (gdb)
 2310			sb_array_offset += len;
 (gdb) print *disk_key
 $2 = {objectid = 281474976710656, type = 228 '\344', offset = 17592186044416}
 (gdb) print key
 $3 = {objectid = 281474976710656, type = 228 '\344', offset = 17592186044416}
 (gdb)

Now we can see, @disk_key is indeed in the little endian, but @key is
not converted to the CPU native endian.

Furthermore, if we step into the help btrfs_disk_key_to_cpu(), it shows
we're using little endian version:

 (gdb) step
 btrfs_disk_key_to_cpu (disk_key=0x109fcdb, cpu_key=0x3ffffff847f)
     at ./kernel-shared/accessors.h:592
 592		memcpy(cpu_key, disk_key, sizeof(struct btrfs_key));

[FIX]
The kernel accessors.h checks if __LITTLE_ENDIAN is defined or not, but
that only works inside kernel.

In user space, __LITTLE_ENDIAN and __BIG_ENDIAN are both defined inside
<bit/endian.h> header.

Instead we should check __BYTE_ORDER against __LITTLE_ENDIAN to
determine our endianness.

With this change, s390x build works as expected now.

Issue: #639
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/accessors.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 625acfbe8ca7..06ab6e7e9f12 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -7,6 +7,8 @@
 #define _static_assert(expr)   _Static_assert(expr, #expr)
 #endif
 
+#include <bits/endian.h>
+
 struct btrfs_map_token {
 	struct extent_buffer *eb;
 	char *kaddr;
@@ -579,7 +581,7 @@ BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key, objectid, 64)
 BTRFS_SETGET_STACK_FUNCS(disk_key_offset, struct btrfs_disk_key, offset, 64);
 BTRFS_SETGET_STACK_FUNCS(disk_key_type, struct btrfs_disk_key, type, 8);
 
-#ifdef __LITTLE_ENDIAN
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 
 /*
  * Optimized helpers for little-endian architectures where CPU and on-disk
-- 
2.41.0

