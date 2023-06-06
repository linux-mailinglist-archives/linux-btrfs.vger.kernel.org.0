Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7727234FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 04:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjFFCFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 22:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjFFCFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 22:05:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC532123
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 19:05:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE06A21992
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 02:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686017122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sobF7NCJvMtDDfR8Xmxy1kK4qV1Ttj7KCfAkLJtK0x0=;
        b=MjYKWOwT+CeW5NVWSdE0gVMAa3zSgKfqgWwUHwHaMYzet0z4cdqCF0Zj5qahCDiSmz4YNz
        uXjvcx6h9KXqnxPJMwYajI1IGBfpULHJ8UQt/WTELTmINJqC6ru19naUR6XGE0oNZqrK+A
        l3WAwSNQDoHoooPVk9XnhWZusKx7hVc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F1FE13343
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 02:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ClOcMmGUfmQqCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 02:05:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: respect the read-only flag during repair
Date:   Tue,  6 Jun 2023 10:05:04 +0800
Message-Id: <85514d999fd01d20cbabed1b346f58f0fb6f7063.1686017100.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With recent scrub rework, the scrub operation no longer respects the
read-only flag passed by "-r" option of "btrfs scrub start" command.

 # mkfs.btrfs -f -d raid1 $dev1 $dev2
 # mount $dev1 $mnt
 # xfs_io -f -d -c "pwrite -b 128K -S 0xaa 0 128k" $mnt/file
 # sync
 # xfs_io -c "pwrite -S 0xff $phy1 64k" $dev1
 # xfs_io -c "pwrite -S 0xff $((phy2 + 65536)) 64k" $dev2
 # mount $dev1 $mnt -o ro
 # btrfs scrub start -BrRd $mnt
 Scrub device $dev1 (id 1) done
 Scrub started:    Tue Jun  6 09:59:14 2023
 Status:           finished
 Duration:         0:00:00
	[...]
 	corrected_errors: 16 <<< Still has corrupted sectors
 	last_physical: 1372585984

 Scrub device $dev2 (id 2) done
 Scrub started:    Tue Jun  6 09:59:14 2023
 Status:           finished
 Duration:         0:00:00
	[...]
 	corrected_errors: 16 <<< Still has corrupted sectors
 	last_physical: 1351614464

 # btrfs scrub start -BrRd $mnt
 Scrub device $dev1 (id 1) done
 Scrub started:    Tue Jun  6 10:00:17 2023
 Status:           finished
 Duration:         0:00:00
	[...]
 	corrected_errors: 0 <<< No more errors
 	last_physical: 1372585984

 Scrub device $dev2 (id 2) done
	[...]
 	corrected_errors: 0 <<< No more errors
 	last_physical: 1372585984

[CAUSE]
In the newly reworked scrub code, repair is always submitted no matter
if we're doing a read-only scrub.

[FIX]
Fix it by skipping the write submission if the scrub is a read-only one.

Unfortunately for the report part, even for a read-only scrub we will
still report it as corrected errors, as we know it's repairable, even we
won't really submit the write.

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 28caad17ccc7..375c1f8fef4d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1695,7 +1695,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 				break;
 			}
 		}
-	} else {
+	} else if (!sctx->readonly) {
 		for (int i = 0; i < nr_stripes; i++) {
 			unsigned long repaired;
 
-- 
2.40.1

