Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F169ECD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 03:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjBVCan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 21:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVCak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 21:30:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B731E09
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 18:30:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CBCA333C80
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677033032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z/IZujK7GKPoFTKLCfdixe3lJFW1sRMu0SZt2Q0hj5k=;
        b=QDikkTUdtn0QzL5UcxsN9+mCCxNwPIMroOYS5eOYgSE3grHj3kbh0Cf2GBUw6HpAqiPx3G
        uIyUcDZ8VyXURAcbY3ygcsT0uKPWz8CGM4OL3bpwF+Nm4zuEW/aBMtPeKHhZUVP+iYE2kF
        K5gPI/tL8t6+DkJlKKNSKg7zp6wXWxY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 210A913467
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 02:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RwBcNkd+9WNvKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 02:30:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: fix an error in stripe offset calculation
Date:   Wed, 22 Feb 2023 10:30:14 +0800
Message-Id: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
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
After commit "btrfs: replace btrfs_io_context::raid_map with a fixed u64
value", btrfs/261 fails:

 QA output created by 261
 ERROR: there are uncorrectable errors
 scrub failed to fix the fs for profile -m raid5 -d raid5
 ERROR: there are uncorrectable errors
 scrub failed to fix the fs for profile -m raid6 -d raid6
 Silence is golden

[CAUSE]
In commit "btrfs: replace btrfs_io_context::raid_map with a fixed u64
value", there is a call site using raid_map[i]:

		*stripe_offset = logical - raid_map[i];

That location is to calculate the offset inside the stripe.
But unfortunately the offending commit is using a wrong value:

		*stripe_offset = logical - full_stripe_logical;

The above line is change the behavior to "logical - raid_map[0]", not
"logical - raid_map[i]".

Thus causing wrong offset returned to the caller for raid56 replace.

[FIX]
Thankfully the call site itself doesn't really need to access
raid_map[i], since what we need is the offset inside the stripe.

So we can use BTRFS_STRIPE_LEN_MASK to calculate the offset inside the
stripe.

Please fold this one into the offending commit "btrfs: replace
btrfs_io_context::raid_map with a fixed u64 value".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8961dceae18b..26c6ea41821a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1447,7 +1447,8 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 		}
 
 		*stripe_index = i;
-		*stripe_offset = logical - full_stripe_logical;
+		*stripe_offset = (logical - full_stripe_logical) &
+				 BTRFS_STRIPE_LEN_MASK;
 	} else {
 		/* The other RAID type */
 		*stripe_index = mirror;
-- 
2.39.1

