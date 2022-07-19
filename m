Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B561E579256
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 07:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiGSFLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 01:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiGSFLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 01:11:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9607E2B1BE
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 22:11:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3856C343B6;
        Tue, 19 Jul 2022 05:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658207498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rChjh1HO/l13BAhBfXwPLZO5mxkEvqBKAqXCNXLOJA=;
        b=X1c9nn6rS3Bd0GsHzodbaRfTelVi6b+NGS9obeWhBGAt5NtJRhVqFytjAwvAqFE1IKvYao
        bH2FCJxT9xxQ/QsRkVqlmeBF/YDIvi+r0ptxY0rRDEN0HF5KHQLyOClCBkBTYomqSVexkh
        DMiqdCl6U1c5pIvlciJP9bwryFvgC0I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DAB613754;
        Tue, 19 Jul 2022 05:11:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mAJ0Cgk91mJTeAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 19 Jul 2022 05:11:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/4] btrfs: output human readable space info flag
Date:   Tue, 19 Jul 2022 13:11:15 +0800
Message-Id: <79cbc7064028a2f214a60abbb702f0d174b630a5.1658207325.git.wqu@suse.com>
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

For btrfs_space_info, its flags has only 4 possible values:
- BTRFS_BLOCK_GROUP_SYSTEM
- BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA
- BTRFS_BLOCK_GROUP_METADATA
- BTRFS_BLOCK_GROUP_DATA

Thus do debuggers a favor by output a human readable flags in
__btrfs_dump_space_info().

Now the summary line of __btrfs_dump_space_info() looks like:

 BTRFS info (device dm-1: state A): space_info META has 251494400 free, is not full

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 62d25112310d..36b466525318 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -450,14 +450,29 @@ do {									\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
+static const char *space_info_flag_to_str(struct btrfs_space_info *space_info)
+{
+	if (space_info->flags == BTRFS_BLOCK_GROUP_SYSTEM)
+		return "SYS";
+
+	/* Handle mixed data+metadata first. */
+	if (space_info->flags == (BTRFS_BLOCK_GROUP_METADATA |
+				  BTRFS_BLOCK_GROUP_DATA))
+		return "DATA+META";
+	if (space_info->flags == BTRFS_BLOCK_GROUP_DATA)
+		return "DATA";
+	return "META";
+}
+
 static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *info)
 {
+	const char *flag_str = space_info_flag_to_str(info);
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
-	btrfs_info(fs_info, "space_info %llu has %lld free, is %sfull",
-		   info->flags,
+	btrfs_info(fs_info, "space_info %s has %lld free, is %sfull",
+		   flag_str,
 		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-- 
2.37.0

