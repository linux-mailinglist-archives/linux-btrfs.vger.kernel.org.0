Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4655F43CA11
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhJ0Mva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 08:51:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhJ0Mva (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 08:51:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 330191FD3C
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635338944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vCDYHj63so6zBooCvu/G3SphI6Nt987OjTNxAV5xfnE=;
        b=hLVW8M/QaG4+XVNmV0F0P7G2c43nWEuchL0KyRLj5PaOsvdE4Xz2hKPwAba5rQ0QlIkuFZ
        +YqbaPgtj2Hoe336W+Aq2PG9Xu+iZ9iR8MvMplEBoiiBqECw3a5P2aYn/Ty6zxytYWsViP
        Dss3W9fg7LyWmsnJo+uT8tMHkZUn+Rw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82A8213D55
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 12:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8HDZEr9KeWGLEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 12:49:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: printf format fixes for 32bit x86
Date:   Wed, 27 Oct 2021 20:48:46 +0800
Message-Id: <20211027124846.100854-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When compiling btrfs-progs on 32bit x86 using GCC 11.1.0, there are
several warnings:

  In file included from ./common/utils.h:30,
                   from check/main.c:36:
  check/main.c: In function 'run_next_block':
  ./common/messages.h:42:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
     42 |                 __btrfs_error((fmt), ##__VA_ARGS__);                    \
        |                               ^~~~~
  check/main.c:6496:33: note: in expansion of macro 'error'
   6496 |                                 error(
        |                                 ^~~~~

  In file included from ./common/utils.h:30,
                   from kernel-shared/volumes.c:32:
  kernel-shared/volumes.c: In function 'btrfs_check_chunk_valid':
  ./common/messages.h:42:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
     42 |                 __btrfs_error((fmt), ##__VA_ARGS__);                    \
        |                               ^~~~~
  kernel-shared/volumes.c:2052:17: note: in expansion of macro 'error'
   2052 |                 error("invalid chunk item size, have %u expect [%zu, %lu)",
        |                 ^~~~~

  image/main.c: In function 'search_for_chunk_blocks':
  ./common/messages.h:42:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     42 |                 __btrfs_error((fmt), ##__VA_ARGS__);                    \
        |                               ^~~~~
  image/main.c:2122:33: note: in expansion of macro 'error'
   2122 |                                 error(
        |                                 ^~~~~

There are two types of problems:

- __BTRFS_LEAF_DATA_SIZE()
  This macro has no type definition, making it behaves differently on
  different arches.

  Fix this by following kernel to use inline function to make its return
  value fixed to u32.

- size_t related output
  For x86_64 %lu is OK but not for x86.

  Fix this by using %zu.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c            | 2 +-
 image/main.c            | 2 +-
 kernel-shared/ctree.h   | 6 +++++-
 kernel-shared/volumes.c | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 38b2cfdf5b0b..235a9bab2f52 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6494,7 +6494,7 @@ static int run_next_block(struct btrfs_root *root,
 			if (btrfs_item_size_nr(buf, i) < inline_offset) {
 				ret = -EUCLEAN;
 				error(
-		"invalid file extent item size, have %u expect (%lu, %lu]",
+		"invalid file extent item size, have %u expect (%lu, %u]",
 					btrfs_item_size_nr(buf, i),
 					inline_offset,
 					BTRFS_LEAF_DATA_SIZE(gfs_info));
diff --git a/image/main.c b/image/main.c
index b40e0e5550f8..dbce17e74dbd 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2120,7 +2120,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 					       current_cluster);
 			if (ret < 0) {
 				error(
-			"failed to search tree blocks in item bytenr %llu size %lu",
+			"failed to search tree blocks in item bytenr %llu size %zu",
 					item_bytenr, size);
 				goto out;
 			}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 563ea50b3587..8d866e60c1b8 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -354,7 +354,11 @@ struct btrfs_header {
 	u8 level;
 } __attribute__ ((__packed__));
 
-#define __BTRFS_LEAF_DATA_SIZE(bs) ((bs) - sizeof(struct btrfs_header))
+static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
+{
+	return nodesize - sizeof(struct btrfs_header);
+}
+
 #define BTRFS_LEAF_DATA_SIZE(fs_info) \
 				(__BTRFS_LEAF_DATA_SIZE(fs_info->nodesize))
 
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 6c1e6f1018a3..7d6fe8fd34a7 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2094,7 +2094,7 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	 */
 	if (slot >= 0 &&
 	    btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk)) {
-		error("invalid chunk item size, have %u expect [%zu, %lu)",
+		error("invalid chunk item size, have %u expect [%zu, %u)",
 			btrfs_item_size_nr(leaf, slot),
 			sizeof(struct btrfs_chunk),
 			BTRFS_LEAF_DATA_SIZE(fs_info));
-- 
2.33.1

