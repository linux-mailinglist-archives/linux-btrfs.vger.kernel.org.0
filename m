Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD46693B67
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 01:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjBMAiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 19:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMAiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 19:38:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD72EF93
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 16:38:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D070960349;
        Mon, 13 Feb 2023 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676248698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C79jz99avRcSlXPmSF3kamAo/vUn1bml6rx2HUsJQ9c=;
        b=r9uRhH3ynJUU/I9flB8oTSWpm9BbdwDv5e2Z3aal+JAq5IS95tyEE0B1xZnKgLSgP3i9Kb
        qisR64niuBRJyEHiwjNck3/XhzLmnOSyzLY653OfgaK1Bx+qg0JIaX0jsoo67aNPXOUKW7
        CnBjmOMm7fHj6HOyELLamdfQ9qzVv7k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C25E513310;
        Mon, 13 Feb 2023 00:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RNZMI3mG6WNEBwAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 13 Feb 2023 00:38:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] fs: btrfs: limit the mapped length to the original length
Date:   Mon, 13 Feb 2023 08:37:59 +0800
Message-Id: <99e2c01bb0366af9aec7522f7109c74b09c5509d.1676248644.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

[BUG]
There is a bug report that btrfs driver caused hang during file read:

  This breaks btrfs on the HiFive Unmatched.

  => pci enum
  PCIE-0: Link up (Gen1-x8, Bus0)
  => nvme scan
  => load nvme 0:2 0x8c000000 /boot/dtb/sifive/hifive-unmatched-a00.dtb
  [hangs]

[CAUSE]
The reporter provided some debug output:

  read_extent_data: cur=615817216, orig_len=16384, cur_len=16384
  read_extent_data: btrfs_map_block: cur_len=479944704; ret=0
  read_extent_data: ret=0
  read_extent_data: cur=615833600, orig_len=4096, cur_len=4096
  read_extent_data: btrfs_map_block: cur_len=479928320; ret=0

Note the second and the last line, the @cur_len is 450+MiB, which is
almost a chunk size.

And inside __btrfs_map_block(), we limits the returned value to stripe
length, but that's depending on the chunk type:

	if (map->type & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1 |
			 BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4 |
			 BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
			 BTRFS_BLOCK_GROUP_RAID10 |
			 BTRFS_BLOCK_GROUP_DUP)) {
		/* we limit the length of each bio to what fits in a stripe */
		*length = min_t(u64, ce->size - offset,
			      map->stripe_len - stripe_offset);
	} else {
		*length = ce->size - offset;
	}

This means, if the chunk is SINGLE profile, then we don't limit the
returned length at all, and even for other profiles, we can still return
a length much larger than the requested one.

[FIX]
Properly clamp the returned length, preventing it from returning a much
larger range than expected.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4aaaeab663f5..7d4095d9ca88 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -956,6 +956,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
 	struct cache_extent *ce;
 	struct map_lookup *map;
+	u64 orig_len = *length;
 	u64 offset;
 	u64 stripe_offset;
 	u64 *raid_map = NULL;
@@ -1047,6 +1048,7 @@ again:
 	} else {
 		*length = ce->size - offset;
 	}
+	*length = min_t(u64, *length, orig_len);
 
 	if (!multi_ret)
 		goto out;
-- 
2.39.1

