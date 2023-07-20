Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC175B044
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGTNl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGTNl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 09:41:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBA91986;
        Thu, 20 Jul 2023 06:41:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D27821C27;
        Thu, 20 Jul 2023 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689860485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tmYRxGuocIo10P4xltez5btt1MOHtYPP9QgSYCfneJA=;
        b=MrU/a1rCHZDdoSg3U6X5LnqvXNIb58Spqw7w0jpBsLPHZKHlKHbPVj6conmj0vfxm58ukj
        gYPpypJjBA4nMrq1Wvq4Q+CXi+k0MLTqdJeiRiQCZY3a1zmqcNia13hd4MtWVwiVwUOPqN
        xoMGPHhAPbWpxgWMUtOTPvUVMoBhpOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689860485;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tmYRxGuocIo10P4xltez5btt1MOHtYPP9QgSYCfneJA=;
        b=2o+IogIYWgNcFO4znAxvrS8NZrdqlVS2r9MJejKoFMiAt5VvRTdWtJ/ZopVTorreR+kOXZ
        Az1jNFA8wpYis3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2751B133DD;
        Thu, 20 Jul 2023 13:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EZrsBYU5uWTSVwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 20 Jul 2023 13:41:25 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 41c3dcbc;
        Thu, 20 Jul 2023 13:41:24 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] btrfs: propagate error from function unpin_extent_cache()
Date:   Thu, 20 Jul 2023 14:41:23 +0100
Message-Id: <20230720134123.13148-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function unpin_extent_cache() doesn't propagate an error if the call to
lookup_extent_mapping() fails.  This patch adds an error return (EINVAL)
and simply logs it in the only caller.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi!

As per David and Johannes reviews, I'm now proposing a different approach.
Note that I kept the WARN_ON() instead of replacing it by an ASSERT().  In
fact, I considered removing the WARN_ON() completely and simply return the
error if em->start != start.  But I guess it may useful for debug.

Changes since v1:
Instead of changing unpin_extent_cache() into a void function, make it
propage an error code instead.

 fs/btrfs/extent_map.c | 4 +++-
 fs/btrfs/inode.c      | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..f4e7956edc05 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -304,8 +304,10 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 
 	WARN_ON(!em || em->start != start);
 
-	if (!em)
+	if (!em) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	em->generation = gen;
 	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbbb67293e34..21eb66fcc0df 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3273,8 +3273,12 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
-			   ordered_extent->num_bytes, trans->transid);
+
+	/* Proceed even if we fail to unpin extent from cache */
+	if (unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
+			       ordered_extent->num_bytes, trans->transid) < 0)
+		btrfs_warn(fs_info, "failed to unpin extent from cache");
+
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
