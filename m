Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D64F0842
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Apr 2022 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiDCHW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 03:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiDCHWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 03:22:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2E31919
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 00:20:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5F6B210E4
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648970429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oB6YF1l1lNAFHnu8KFe7y5qrzDezi6TDhN9WDZW6Wko=;
        b=AkO3ERt/j7GBg0jf0/4sW5oP+E8rVFQjsnw5D64I2SI1KT0ZgTum76KHHo+dqX2nAUo+Kb
        aaSjom9FzFo67YM1tsF7lByT7ZW6TAuFtmf+o5ZFQ0T7fMux55uNnbu04ym8D4OWrrfFSW
        hKHaTw1jTiwEgR1/Xx/mout+DvNfwtE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 032B513B6A
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 07:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LUAqLrxKSWKDNAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Apr 2022 07:20:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: mkfs: use sectorsize as nodesize for mixed profiles
Date:   Sun,  3 Apr 2022 15:20:11 +0800
Message-Id: <59658bb9ea9be5bf991aded9211684ba1c7c8d2d.1648970393.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

[BUG]
When running btrfs/011 with subpage case, even with RAID56 support, it
still fails with the following error:

 QA output created by 011
 *** test btrfs replace
 mkfs failed
 (see /home/adam/xfstests-dev/results//btrfs/011.full for details)

The full log shows:

 ---------workout "-m single -d single -M" 1 no 64-----------
 ERROR: illegal nodesize 65536 (not equal to 4096 for mixed block group)
 mkfs failed

This is a critical error, making test case to be aborted, without
checking the rest profiles.

[CAUSE]
Mkfs.btrfs always uses the maximum value between sectorsize and page
size for its mixed profile nodesize.

For subpage case, it means we always go PAGE_SIZE, no matter whatever
the sectorsize is passed in.

[FIX]
Just get rid of the direct PAGE_SIZE usage when determining nodesize for
mixed profiles.
And use sectorsize directly (either passed in by the user, or
deteremined from page size).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a603ec5896f3..4e0a46a77aa5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1261,8 +1261,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			data_profile = tmp;
 		}
 	} else {
-		u32 best_nodesize = max_t(u32, sysconf(_SC_PAGESIZE), sectorsize);
-
 		if (metadata_profile_opt || data_profile_opt) {
 			if (metadata_profile != data_profile) {
 				error(
@@ -1272,7 +1270,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 
 		if (!nodesize_forced)
-			nodesize = best_nodesize;
+			nodesize = sectorsize;
 	}
 
 	/*
-- 
2.35.1

