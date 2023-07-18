Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09F7583A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 19:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjGRRjS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jul 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRRjR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jul 2023 13:39:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FF91;
        Tue, 18 Jul 2023 10:39:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A4371F45F;
        Tue, 18 Jul 2023 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689701955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xtb9eaTW3MdBWzglgP8jPdI48OuUsG3guGiK3GgqLrA=;
        b=hDbxh5O4NaGnPhPtMdibbkJC8blH5bHWStorBVQNZ0tHypLJTsYIfWjcQG3AGOtmSGm4uc
        Prk6LJS6jEBHVFd2KhY9l+cLrl4MY4YTH6s0VWb/se1szdgoN2wTvu6NV/+s9mQhtDVNzj
        gBNTJ7D0qYzftWJq4nZVtpj7HYKK2EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689701955;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xtb9eaTW3MdBWzglgP8jPdI48OuUsG3guGiK3GgqLrA=;
        b=sLfNylR7t6DRDCRrqTEynBTcTRXQskWErQV+1RBeZKzBF5KvkSEp1+XaTz0sWcb46QI9sy
        +UeiYJSabR3uC2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 094C713494;
        Tue, 18 Jul 2023 17:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cQ96OkLOtmRqbQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 18 Jul 2023 17:39:14 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 9f98d451;
        Tue, 18 Jul 2023 17:39:07 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] btrfs: turn unpin_extent_cache() into a void function
Date:   Tue, 18 Jul 2023 18:39:06 +0100
Message-Id: <20230718173906.12568-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The value of the 'ret' variable is never changed in function
unpin_extent_cache().  And since the only caller of this function doesn't
check the return value, it can simply be turned into a void function.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/btrfs/extent_map.c | 7 ++-----
 fs/btrfs/extent_map.h | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..f99c458071a4 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -292,10 +292,9 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
  * to the generation that actually added the file item to the inode so we know
  * we need to sync this extent when we call fsync().
  */
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
-		       u64 gen)
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
+			u64 gen)
 {
-	int ret = 0;
 	struct extent_map *em;
 	bool prealloc = false;
 
@@ -327,8 +326,6 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 	free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
-	return ret;
-
 }
 
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 35d27c756e08..486a8ea798c7 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -97,7 +97,7 @@ struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
