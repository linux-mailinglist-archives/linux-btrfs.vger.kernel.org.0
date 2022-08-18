Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AD597EF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiHRHHL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243786AbiHRHHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 03:07:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64500876AE
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 00:07:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8D7A20D67;
        Thu, 18 Aug 2022 07:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660806423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zFH9vjjdlob3I3NIZeLIFDZ5XRP9BXs9cRB5BB/+JTs=;
        b=lt/osvkkhwYIRdo1Wbbi3JFmSxoMFfFEoCgpLJuywqUUtAvC/pueVk9apOzULhueNeRpOQ
        oALZV48dzTJHzsoYEW7K47ysRzvVSXjAidVTMgMZ1sJRAVt9/k08bphoYeNpZXnI2AuymC
        +2W9VtyPUbURLk6DXEK6/3u7ruiNDoA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3193139B7;
        Thu, 18 Aug 2022 07:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +p58KBbl/WIVRgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 18 Aug 2022 07:07:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: fix the max chunk size and stripe length calculation
Date:   Thu, 18 Aug 2022 15:06:44 +0800
Message-Id: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
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

[BEHAVIOR CHANGE]
Since commit f6fca3917b4d ("btrfs: store chunk size in space-info
struct"), btrfs no longer can create larger data chunks than 1G:

  mkfs.btrfs -f -m raid1 -d raid0 $dev1 $dev2 $dev3 $dev4
  mount $dev1 $mnt

  btrfs balance start --full $mnt
  btrfs balance start --full $mnt
  umount $mnt

  btrfs ins dump-tree -t chunk $dev1 | grep "DATA|RAID0" -C 2

Before that offending commit, what we got is a 4G data chunk:

	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 itemsize 176
		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 4 sub_stripes 1

Now what we got is only 1G data chunk:

	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 6271533056) itemoff 15491 itemsize 176
		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID0
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 4 sub_stripes 1

This will increase the number of data chunks by the number of devices,
not only increase system chunk usage, but also greatly increase mount
time.

Without a properly reason, we should not change the max chunk size.

[CAUSE]
Previously, we set max data chunk size to 10G, while max data stripe
length to 1G.

Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")
completely ignored the 10G limit, but use 1G max stripe limit instead,
causing above shrink in max data chunk size.

[FIX]
Fix the max data chunk size to 10G, and in decide_stripe_size_regular()
we limit stripe_size to 1G manually.

This should only affect data chunks, as for metadata chunks we always
set the max stripe size the same as max chunk size (256M or 1G
depending on fs size).

Now the same script result the same old result:

	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 itemsize 176
		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 4 sub_stripes 1

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Fixes: f6fca3917b4d ("btrfs: store chunk size in space-info struct")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.c | 2 +-
 fs/btrfs/volumes.c    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 477e57ace48d..b74bc31e9a8e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -199,7 +199,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
 	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
 
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
-		return SZ_1G;
+		return BTRFS_MAX_DATA_CHUNK_SIZE;
 	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return SZ_32M;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8c64dda69404..e0fd1aecf447 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5264,6 +5264,9 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 				       ctl->stripe_size);
 	}
 
+	/* Stripe size should never go beyond 1G. */
+	ctl->stripe_size = min_t(u64, ctl->stripe_size, SZ_1G);
+
 	/* Align to BTRFS_STRIPE_LEN */
 	ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
 	ctl->chunk_size = ctl->stripe_size * data_stripes;
-- 
2.37.1

