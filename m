Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D468579257
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 07:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiGSFLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 01:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSFLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 01:11:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74372B248
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 22:11:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E3BB2068F;
        Tue, 19 Jul 2022 05:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658207499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OXX/Cr5aRGX42o3l3VBj7li7zJ36hiwajy68S+pYD8=;
        b=C/pHjpEw8ZIGy1cjoDhZ3N70ZykGMlXUIng81yNZWr3E+bGrNWxDu9pSCgbo0pa/lyVILr
        WtBFyXnRr/arFXkkZZNzMntqKAMyWM3Aky6+Pd/u9nWp7evWWRxgIJ0YoLcAApSFWEzhu7
        hldssHox9idg0MtjZLdRE8xmUApw5dk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9808B13754;
        Tue, 19 Jul 2022 05:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +HUZGQo91mJTeAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 19 Jul 2022 05:11:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output better formatted
Date:   Tue, 19 Jul 2022 13:11:16 +0800
Message-Id: <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658207325.git.wqu@suse.com>
References: <cover.1658207325.git.wqu@suse.com>
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

The format change includes:

- Output each bytes_* in a separate line

- All bytes_* output starts at the same vertical position
  Do human a favor reading the numbers

- Skip zone specific numbers if zone is not enabled

Now one example of __btrfs_dump_space_info() looks like this for its
bytes_* members.

 BTRFS info (device dm-1: state A): space_info META has 251494400 free, is not full
 BTRFS info (device dm-1: state A):   total:         268435456
 BTRFS info (device dm-1: state A):   used:          376832
 BTRFS info (device dm-1: state A):   pinned:        229376
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       16269312
 BTRFS info (device dm-1: state A):   read_only:     65536

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 36b466525318..623fa0488545 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -475,11 +475,15 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		   flag_str,
 		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
 		   info->full ? "" : "not ");
-	btrfs_info(fs_info,
-		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
-		info->total_bytes, info->bytes_used, info->bytes_pinned,
-		info->bytes_reserved, info->bytes_may_use,
-		info->bytes_readonly, info->bytes_zone_unusable);
+	btrfs_info(fs_info, "  total:         %llu", info->total_bytes);
+	btrfs_info(fs_info, "  used:          %llu", info->bytes_used);
+	btrfs_info(fs_info, "  pinned:        %llu", info->bytes_pinned);
+	btrfs_info(fs_info, "  reserved:      %llu", info->bytes_reserved);
+	btrfs_info(fs_info, "  may_use:       %llu", info->bytes_may_use);
+	btrfs_info(fs_info, "  read_only:     %llu", info->bytes_readonly);
+	if (btrfs_is_zoned(fs_info))
+		btrfs_info(fs_info,
+			    "  zone_unusable: %llu", info->bytes_zone_unusable);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
-- 
2.37.0

