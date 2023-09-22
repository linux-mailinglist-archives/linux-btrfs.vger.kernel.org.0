Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4758D7AA72B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjIVCzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 22:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjIVCzt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 22:55:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF48195
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 19:55:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D47C02208F
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695351341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bg8VTFox50LALWxFmDiiDxV4J+NwSXDb1UgrkOdcEA0=;
        b=COR2PjrlFCsLN/Wbs9IkIuYs+AwCFKmj5IlGO6Rw+3Z0O4NzmSKFkm61KU0f5QgO1JyqE0
        /UcfaHOeXn5xrbLcbmMohi7O+zc78I8h0x7NDWoM/i/HYLwqP95rqUqmDdlUnu8eHQQ9FA
        gjzBlO+SJnmxUmxyWTtJRkFmzRZIWTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01C7D13438
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8JdqKywCDWV6LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: explicitly mark BTRFS_MOUNT_ enum as 64bit
Date:   Fri, 22 Sep 2023 12:25:19 +0930
Message-ID: <f57b31a59f39fd8149f184634d98e33ef625a73a.1695350405.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695350405.git.wqu@suse.com>
References: <cover.1695350405.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we already have 29 BTRFS_MOUNT_* enums, and with several new
incoming mount options, we will go beyond 32bits.

For now we use "unsigned long" for fs_info->mount_opt, which is 64bit
for x86_64, but it's not always the case for all architects.

So here we explicitly mark BTRFS_MOUNT_* enum and
btrfs_fs_info::mount_opt as 64bit to avoid overflow.

For common architects like x86_64 and aarch64, this change makes no
difference, but for older 32bit systems it would cause a slight memory
usage increase per-fs (4 bytes increase + possible 4 bytes hole).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 19f9a444bcd8..cec28d6b20bc 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -158,36 +158,36 @@ enum {
  * Note: don't forget to add new options to btrfs_show_options()
  */
 enum {
-	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
-	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
-	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
-	BTRFS_MOUNT_SSD				= (1UL << 3),
-	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
-	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
-	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
-	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
-	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
-	BTRFS_MOUNT_NOSSD			= (1UL << 9),
-	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
-	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
-	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
-	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
-	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
-	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
-	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
-	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
-	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
-	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 19),
-	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 20),
-	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 21),
-	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 22),
-	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 23),
-	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 24),
-	BTRFS_MOUNT_REF_VERIFY			= (1UL << 25),
-	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 26),
-	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
-	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
-	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
+	BTRFS_MOUNT_NODATASUM			= (1ULL << 0),
+	BTRFS_MOUNT_NODATACOW			= (1ULL << 1),
+	BTRFS_MOUNT_NOBARRIER			= (1ULL << 2),
+	BTRFS_MOUNT_SSD				= (1ULL << 3),
+	BTRFS_MOUNT_DEGRADED			= (1ULL << 4),
+	BTRFS_MOUNT_COMPRESS			= (1ULL << 5),
+	BTRFS_MOUNT_NOTREELOG			= (1ULL << 6),
+	BTRFS_MOUNT_FLUSHONCOMMIT		= (1ULL << 7),
+	BTRFS_MOUNT_SSD_SPREAD			= (1ULL << 8),
+	BTRFS_MOUNT_NOSSD			= (1ULL << 9),
+	BTRFS_MOUNT_DISCARD_SYNC		= (1ULL << 10),
+	BTRFS_MOUNT_FORCE_COMPRESS		= (1ULL << 11),
+	BTRFS_MOUNT_SPACE_CACHE			= (1ULL << 12),
+	BTRFS_MOUNT_CLEAR_CACHE			= (1ULL << 13),
+	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1ULL << 14),
+	BTRFS_MOUNT_ENOSPC_DEBUG		= (1ULL << 15),
+	BTRFS_MOUNT_AUTO_DEFRAG			= (1ULL << 16),
+	BTRFS_MOUNT_USEBACKUPROOT		= (1ULL << 17),
+	BTRFS_MOUNT_SKIP_BALANCE		= (1ULL << 18),
+	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1ULL << 19),
+	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1ULL << 20),
+	BTRFS_MOUNT_FRAGMENT_DATA		= (1ULL << 21),
+	BTRFS_MOUNT_FRAGMENT_METADATA		= (1ULL << 22),
+	BTRFS_MOUNT_FREE_SPACE_TREE		= (1ULL << 23),
+	BTRFS_MOUNT_NOLOGREPLAY			= (1ULL << 24),
+	BTRFS_MOUNT_REF_VERIFY			= (1ULL << 25),
+	BTRFS_MOUNT_DISCARD_ASYNC		= (1ULL << 26),
+	BTRFS_MOUNT_IGNOREBADROOTS		= (1ULL << 27),
+	BTRFS_MOUNT_IGNOREDATACSUMS		= (1ULL << 28),
+	BTRFS_MOUNT_NODISCARD			= (1ULL << 29),
 };
 
 /*
@@ -429,7 +429,7 @@ struct btrfs_fs_info {
 	 * required instead of the faster short fsync log commits
 	 */
 	u64 last_trans_log_full_commit;
-	unsigned long mount_opt;
+	u64 mount_opt;
 
 	unsigned long compress_type:4;
 	unsigned int compress_level;
-- 
2.42.0

