Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1467DD2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjA0Flp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjA0Fln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:41:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55408721CF
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 21:41:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0F4C21C70
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674798098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDZCWWpgULB40YxDEqg/vOhKoope109BO1h4pWEGtUM=;
        b=UxALgJwpwFI4Be+OBYpRx7MxlJjbMctXs6HgmKWF/ejY2LrnaCQ0QAe8DtC+HgMPRdi1ej
        TsYmBngc6M4ukwraVXfhqoPJpRFseHrVWStX2aKHAhh7CB8bluDHMf2lohTEH9oMQtsOj6
        r+mjvlgJKZ/mgyQxsFETy2aVNFd5qwg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30D83134F5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EIjwOhFk02OnLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs-progs: fix a false alert on an uninitialized variable when BUG_ON() is involved.
Date:   Fri, 27 Jan 2023 13:41:15 +0800
Message-Id: <c1bd04c707a6ac03f9927b99a959058615ec9d05.1674797823.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
References: <cover.1674797823.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[FALSE ALERT]
Clang 15.0.7 gives the following false alert in get_dev_extent_len():

  kernel-shared/extent-tree.c:3328:2: warning: variable 'div' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
          default:
          ^~~~~~~
  kernel-shared/extent-tree.c:3332:24: note: uninitialized use occurs here
          return map->ce.size / div;
                                ^~~
  kernel-shared/extent-tree.c:3311:9: note: initialize the variable 'div' to silence this warning
          int div;
                 ^
                  = 0

And one in btrfs_stripe_length() too:

  kernel-shared/volumes.c:2781:2: warning: variable 'stripe_len' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
          default:
          ^~~~~~~
  kernel-shared/volumes.c:2785:9: note: uninitialized use occurs here
          return stripe_len;
                 ^~~~~~~~~~
  kernel-shared/volumes.c:2754:16: note: initialize the variable 'stripe_len' to silence this warning
          u64 stripe_len;
                        ^
                         = 0

[CAUSE]
Clang doesn't really understand what BUG_ON() means, thus in that
default case, we won't get uninitialized value but crash directly.

[FIX]
Silent the errors by assigning the default value properly using the
value of SINGLE profile.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 4 ++--
 kernel-shared/volumes.c     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 0b0c40afe9a9..4c6ad64f5ba8 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3308,7 +3308,7 @@ out:
 
 static u64 get_dev_extent_len(struct map_lookup *map)
 {
-	int div;
+	int div = 1;
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case 0: /* Single */
@@ -3316,7 +3316,7 @@ static u64 get_dev_extent_len(struct map_lookup *map)
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
-		div = 1;
+		/* The default value can already handle it. */
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 65147d064934..1e2c88955719 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2758,6 +2758,7 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 		      BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
 	chunk_len = btrfs_chunk_length(leaf, chunk);
+	stripe_len = chunk_len;
 
 	switch (profile) {
 	case 0: /* Single profile */
@@ -2765,7 +2766,7 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
 	case BTRFS_BLOCK_GROUP_DUP:
-		stripe_len = chunk_len;
+		/* The default value is already fine. */
 		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
 		stripe_len = chunk_len / num_stripes;
-- 
2.39.1

