Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E081272F52A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbjFNGuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbjFNGt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 02:49:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3D1BC9
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 23:49:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 536CB224FF
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 06:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686725394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JCuacyXR6NU4WTGwAJUpmgQRzXX9l/9y2m+RnXYc16o=;
        b=QeJa0WG8jKaeRFZC+FVE3mpb5hNzzrTcLLipH4z6xEumSsBVomtLaW1z5lCzbN4dcMUh2C
        FXvApcUTHCYQW4yp5UEt7VZOyUJp4+kHuN4nwJD0VXzvrdguFbPD5Cs4nhzQQTCQsim7hn
        uvs2tEjPLeHrVyHzA1n4a17oajpwy4I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A97541357F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 06:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A5erHBFjiWQSCQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 06:49:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: fix a return value overwrite in scrub_stripe()
Date:   Wed, 14 Jun 2023 14:49:35 +0800
Message-ID: <846cb6c0ad0ba87026f2d0b1ac3dfc4e1ddde21c.1686725373.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[RETURN VALUE OVERWRITE]
Inside scrub_stripe(), we would submit all the remaining stripes after
iterating all extents.

But since flush_scrub_stripes() can return error, we need to avoid
overwriting the existing @ret if there is any error.

However the existing check is doing the wrong check:

	ret2 = flush_scrub_stripes();
	if (!ret2)
		ret = ret2;

This would overwrite the existing @ret to 0 as long as the final flush
detects no critical errors.

[FIX]
We should check @ret other than @ret2 in that case.

Fixes: 8eb3dd17eadd ("btrfs: dev-replace: error out if we have unrepaired metadata error during")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index be6efe9f3b55..521a5b7895c1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2252,7 +2252,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	}
 out:
 	ret2 = flush_scrub_stripes(sctx);
-	if (!ret2)
+	if (!ret)
 		ret = ret2;
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
-- 
2.41.0

