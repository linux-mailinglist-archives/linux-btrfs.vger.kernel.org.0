Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD558D388
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiHIGEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 02:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiHIGEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 02:04:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753871FCCE
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 23:04:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D91933476F
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660025059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bf3qfS7Yc0qv+lsFAvGhMCAxxnDhwFqxlwZBW1tbSTg=;
        b=LkHW+CPvmreorsWTsU0K5EE4X8hBNBssVdnZKdc9JBb9Iftkthx5iI/0dTk4G5YPWj6anH
        VBCIB3DT2to0+/T8Q8Z0OMP0xgfB57n7HveUdMzyNPOtnbgB1QQBYHr2m3JmJi98b+DSK9
        3K9x/1/IR3BgoNh1aVpy6yzjtjX80+g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35F8D13AA1
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4N42AOP48WJTVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 06:04:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/5] btrfs-progs: mkfs: add artificial dependency for block group tree
Date:   Tue,  9 Aug 2022 14:03:55 +0800
Message-Id: <4b9cfb7fefd88b1943a8d630e2e34e0f439695b2.1660024949.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1660024949.git.wqu@suse.com>
References: <cover.1660024949.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To reduce the test matrix and to follow the kernel behavior, make sure
for block-group-tree feature, we have no-holes and free-space-tree
features enabled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 518ce0fd7523..54cd47a0cdc0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1303,6 +1303,13 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+	/* Block group tree feature requires no-holes and frree space tree. */
+	if (runtime_features & BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE &&
+	    (!(features & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
+	     !(runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE))) {
+		error("block group tree feature requires no-holes and free-space-tree features");
+		exit(1);
+	}
 	if (zoned) {
 		if (source_dir_set) {
 			error("the option -r and zoned mode are incompatible");
-- 
2.37.0

