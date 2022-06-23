Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF05574F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiFWIJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiFWIJG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 04:09:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007647571
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 01:09:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CACA921C93;
        Thu, 23 Jun 2022 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655971742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uSciRW9V3NmZ5K3zZnosdnXU8UlVxhdIJ9Jg8202M9Y=;
        b=XXufr0Y4FdUdivXWCCLif95n5dIxFMAhDmkhlEoVi2zqjh65AKAQrSLD180FRmRdDImf2v
        PD2QdJRGUpFrEu3JFlXhQk522+HspnE3e+ZzNNVTOBbk7ne0hKBJT+zzJ7Q9QGgoNVhSqz
        rkidsFqVHZpHC7fqOIXJFj9tfBo3waE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97509133A6;
        Thu, 23 Jun 2022 08:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /5Y+IpsftGLueQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Jun 2022 08:08:59 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: remove skinny extent verbose message
Date:   Thu, 23 Jun 2022 11:08:58 +0300
Message-Id: <20220623080858.1433010-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
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

Skinny extents have been a default mkfs feature since version 3.18 i
(introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
make skinny-metadata default") ). It really doesn't bring any value to
users to simply remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c34d08e3c64..0af4c03279df 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3501,9 +3501,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
 		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
 
-	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
-		btrfs_info(fs_info, "has skinny extents");
-
 	/*
 	 * Flag our filesystem as having big metadata blocks if they are bigger
 	 * than the page size.
-- 
2.25.1

