Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B444273DBE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjFZJzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFZJzq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 05:55:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79359B
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 02:55:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FCF1211E2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687773343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TKU0XFHspazEWapKGTDATIUhyvjyIxCJ2kc/Ym0DRqw=;
        b=ga5XwGt9nm5vwXMp5KQxxTHSzJOpvcXCJefcvidhkJDVlBVh1MNCF4GYl/HQ9h4HCKJxyv
        MxDUHiOJA6v/6+O5lfBuSMEsZgPdDLFBeSAwoBRhRMV6MLaWYkfH20+AQvq1KydMl/vtr8
        7s3Ujrq8x7ameyonvQdulABchUH7cNA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B71BC13905
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 09:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bLNMIJ5gmWQ+fQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 09:55:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: deprecate check_int* feature
Date:   Mon, 26 Jun 2023 17:55:25 +0800
Message-ID: <d1b4174922a786884a1a3bfdcbbc208925797f4b.1687773318.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check_int feature needs to be enabled at compile time and then enable
through mount option.

Although it provides some unique feature which can not be provided by
any other sanity checks, it does not only have high CPU and memory
overhead, but also maintenance burden.

For example, check_int is the only caller of btrfs_map_block() with
@need_raid_map = 0.

Considering most btrfs developers are not even testing this feature, I'm
here to purpose the deprecation of this feature.

For now only extra warning messages would be outputted, the feature
itself would still work.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8b1c1225245e..3eaa0775cef1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -709,12 +709,16 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 		case Opt_check_integrity_including_extent_data:
+			btrfs_warn(info,
+	"check_int feature is marked deprecated and would be removed soon");
 			btrfs_info(info,
 				   "enabling check integrity including extent data");
 			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY_DATA);
 			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
 			break;
 		case Opt_check_integrity:
+			btrfs_warn(info,
+	"check_int feature is marked deprecated and would be removed soon");
 			btrfs_info(info, "enabling check integrity");
 			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
 			break;
@@ -727,6 +731,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				goto out;
 			}
 			info->check_integrity_print_mask = intarg;
+			btrfs_warn(info,
+	"check_int feature is marked deprecated and would be removed soon");
 			btrfs_info(info, "check_integrity_print_mask 0x%x",
 				   info->check_integrity_print_mask);
 			break;
-- 
2.41.0

